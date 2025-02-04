{string} Products = ...;
{string} Resources = ...;
{string} Machines = ...;
float MaxProduction = ...;

tuple typeProductData {
  float demand;
  float incost;
  float outcost;
  float use[Resources];
  string machine;
}

typeProductData Product[Products] = ...;
float Capacity[Resources] = ...;
float RentCost[Machines] = ...;

dvar boolean Rent[Machines];
dvar float+ Inside[Products];
dvar float+ Outside[Products];


minimize
  sum( p in Products ) 
    ( Product[p].incost * Inside[p] + 
      Product[p].outcost * Outside[p] ) +
  sum( m in Machines ) 
    RentCost[m] * Rent[m];
   
subject to {
  forall( r in Resources )
    ctCapacity:
      sum( p in Products ) 
        Product[p].use[r] * Inside[p] <= Capacity[r];

  forall( p in Products )
    ctDemand: 
      Inside[p] + Outside[p] >= Product[p].demand;

  forall( p in Products )
    ctMaxProd:
      Inside[p] <= MaxProduction * Rent[Product[p].machine];//Rent is boolean
}
