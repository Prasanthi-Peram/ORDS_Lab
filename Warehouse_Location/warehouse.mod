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

int Fixed = ...;
{string} Warehouses = ...;
int NbStores = ...;
range Stores = 0..NbStores-1;
int Capacity[Warehouses] = ...;
int SupplyCost[Stores][Warehouses] = ...;
dvar boolean Open[Warehouses];
dvar boolean Supply[Stores][Warehouses];


minimize
  sum( w in Warehouses ) 
    Fixed * Open[w] +
  sum( w in Warehouses , s in Stores ) 
    SupplyCost[s][w] * Supply[s][w];
    

subject to{
  forall( s in Stores )
    ctEachStoreHasOneWarehouse:
      sum( w in  Warehouses ) 
        Supply[s][w] == 1;
  forall( w in Warehouses, s in Stores )
    ctUseOpenWarehouses:
      Supply[s][w] <= Open[w];
  forall( w in Warehouses )
    ctMaxUseOfWarehouse:         
      sum( s in Stores ) 
        Supply[s][w] <= Capacity[w];
}

{int} Storesof[w in Warehouses] = { s | s in Stores : Supply[s][w] == 1 };
execute DISPLAY_RESULTS{
  writeln("Open=",Open);
  writeln("Storesof=",Storesof);
}
