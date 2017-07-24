/*********************************************
 * OPL 12.7.0.0 Model
 * Author: HP NOTEBOOK
 * Creation Date: 14-Jul-2017 at 3:55:52 pm
 *********************************************/
int n=...;
range cities=1..n;
//range i=1..n;
//int m=(n+1);
//range matrix=1..m;
/*tuple location{
float x;
float y;
}
tuple edge{
int i;
int j;
}*/
//setof(edge) edges={<i,j> | i,j in cities: i!=j};
int C[1..n][1..n]=...;
//location cityLocation[cities];
/*execute{
       function getDistance(city1,city2){
              return Opl.sqrt(Opl.pow(city1.x-city2.x,2)+Opl.pow(city1.y-city2.y,2));
              }
      for(var i in cities)
       {
         cityLocation[i].x=Opl.rand(100);
         cityLocation[i].y=Opl.rand(100);
       }
      for(var e in edges)
      {
      C[e]=getDistance(cityLocation[e.i],cityLocation[e.j]);
      }
}*/
//decision variable
dvar boolean X[1..n][1..n];
dvar float+ u[2..n];
//expression
float temp;
execute{
var before = new Date();
temp = before.getTime();
}
dexpr float TotalDistance=sum(i in cities,j in cities)C[i][j]*X[i][j];
minimize TotalDistance;
subject to
{
forall(j in cities)
     flow_in:
       sum(i in cities : i!=j) X[i][j]==1;
forall(i in cities)
     flow_out:
       sum(j in cities : j!=i) X[i][j]==1;
forall(i in cities :i>1, j in cities : j>1 && j!=i)
     subtour:
       u[i]-u[j]+(n-1)*X[i][j]<=n-2;
}
execute{
var after = new Date();
var f1=new IloOplOutputFile("F:/projecttsp/timeLP.txt");
f1.writeln(" Time=",(after.getTime()-temp)/1000);
}
execute{
/*var f2=new IloOplOutputFile("F:/projecttsp/pathlp1.txt");
//f2.writeln("1");
var i=1;
var j=1;
//var k=1;
for(i in cities)
{
for(j in cities)
{

if(X[i][j]==1)
{
f2.writeln(i);
i=j;
j=1;
}

}

}



//f2.writeln("Minimum Cost: ",TotalDistance);
f2.close();*/
var f=new IloOplOutputFile("F:/projecttsp/distLP.txt");
f.writeln("Minimum Cost: ",TotalDistance);
f.close();
}

