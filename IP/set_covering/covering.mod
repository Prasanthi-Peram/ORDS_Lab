// --------------------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// 5725-A06 5725-A29 5724-Y48 5724-Y49 5724-Y54 5724-Y55
// Copyright IBM Corporation 1998, 2024. All Rights Reserved.
//
// Note to U.S. Government Users Restricted Rights:
// Use, duplication or disclosure restricted by GSA ADP Schedule
// Contract with IBM Corp.
// --------------------------------------------------------------------------
//Card is used to obtain the cardinality and asSet is used to convert an array or range to a assert

int NbWorkers = ...;
range Workers = 1..NbWorkers;
{string} Tasks = ...;
{int} Qualified[Tasks] = ...;
assert 
  forall( t in Tasks , i in Qualified[t] ) i in asSet(Workers);
//alternate formulation:
assert 
  forall( t in Tasks ) 
    card(Qualified[t] inter asSet(Workers))==card(Qualified[t]);
int Cost[Workers] = ...;
dvar boolean Hire[Workers];

minimize 
  sum(c in Workers) Cost[c] * Hire[c];
subject to {
  forall(j in Tasks)
    ct:
      sum( c in Qualified[j] ) 
        Hire[c] >= 1;
}
tuple solutionT{
	int Crew;
};
{solutionT} Crew = { <c> | c in Workers : Hire[c] == 1 };
execute DISPLAY {
  writeln("Crew=",Crew);
}


