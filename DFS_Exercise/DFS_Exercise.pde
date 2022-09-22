//CSCI 5611 - Graph Search & Planning
//Breadth-First Search (BFS) [Exercise]
// Stephen J. Guy <sjguy@umn.edu>

/*
 TODO: 
    1. Try to understand how this Breadth-first Search (BFS) implementation works.
       As a start, compare to the pseudocode at: https://en.wikipedia.org/wiki/Breadth-first_search
       How do I represent nodes? How do I represent edges?
       What is the purpose of the visited list? What about the parent list?
       What is getting added to the fringe? In what order?
       How do I find the path once I've found the goal?
    2. Convert this Breadth-first Search to a Depth-First Search.
       Which version BFS or DFS has a smaller maximum fringe size? 
       
          !!!! Answer: They are the same: size = 4

    3. Currently, the code sets up a graph which follows this tree-like structure: https://snipboard.io/6BhxRd.jpg
       Change it to plan a path from node 0 to node 7 over this graph instead: https://snipboard.io/VIx6Er.jpg
       How do we know the graph is no longer a tree?
       Does Breadth-first Search still find the optimal path?
          !!!! Answer: It is no longer a tree because different branches share leaves
 CHALLENGE:
    1. Make a new graph where there is a cycle. DFS should fail. Does it? Why?
    2. Add a maximum depth limit to DFS. Now can it handle cycles?
    3. Call the new depth-limited DFS in a loop, growing the depth limit with each
       iteration. Is this new iterative deepening DFS optimal? Can it handle loops
       in the graph? How does the memory usage/fringe size compare to BFS?
*/

int numNodes = 8;

//Represents our graph structure as 3 lists
ArrayList<Integer>[] neighbors = new ArrayList[numNodes];  //A list of neighbors can can be reached from a given node
Boolean[] visited = new Boolean[numNodes]; //A list which store if a given node has been visited
int[] parent = new int[numNodes]; //A list which stores the best previous node on the optimal path to reach this node
  //Set start and goal
  int start = 0;
  int goal = 7;

  boolean found = false;

    ArrayList<Integer> fringe = new ArrayList(); 

void setup(){
  //Initialize our graph 

    
  // Initialize the lists which represent our graph 
  for (int i = 0; i < numNodes; i++) { 
      neighbors[i] = new ArrayList<Integer>(); 
      visited[i] = false;
      parent[i] = -1; //No parent yet
  }

  //Set which nodes are connected to which neighbors
  neighbors[0].add(1); neighbors[0].add(3);
  neighbors[1].add(2);
  neighbors[2].add(4); neighbors[2].add(7);
  neighbors[3].add(4); neighbors[3].add(6);
  neighbors[4].add(1); neighbors[4].add(5);
  neighbors[5].add(7);
  neighbors[6].add(5);

  println("List of Neighbors:");
  println(neighbors);





  println("\nBeginning Search");

  visited[start] = true;
  fringe.add(start);
  println("Adding node", start, "(start) to the fringe.");
  println(" Current Fringe: ", fringe);

  for(int i = 0; i < 5; i++){
  if(DFS(0, 0, i)){
    break;  
  }
  }

  // breath
  // while (fringe.size() > 0){
  //   int fringeTop = 0;
  //   int currentNode = fringe.get(fringeTop);
  //   fringe.remove(fringeTop);
  //   if (currentNode == goal){
  //     println("Goal found!");
  //     break;
  //   }
  //   for (int i = 0; i < neighbors[currentNode].size(); i++){
  //     int neighborNode = neighbors[currentNode].get(i);
  //     if (!visited[neighborNode]){
  //       visited[neighborNode] = true;
  //       parent[neighborNode] = currentNode;
  //       fringe.add(neighborNode);
  //       println("Added node", neighborNode, "to the fringe.");
  //       println(" Current Fringe: ", fringe);
  //     }
  //   } 
  // }

  print("\nReverse path: ");
  int prevNode = parent[goal];
  print(goal, " ");
  while (prevNode >= 0){
    print(prevNode," ");
    prevNode = parent[prevNode];
  }
  print("\n");

}

boolean DFS(int v, int depth, int maxDepth){
  visited[v] = true;
  if(found){
    fringe.remove(fringe.indexOf(v));
    return true;
  }  
  if(depth > 2){
    fringe.remove(fringe.indexOf(v));
    return false;
   }
  for(int i : neighbors[v]){
    fringe.add(i);
    println("Visited: " + i);
    parent[i] = v;
    if (i == goal){
      found = true;
      println("Goal found!");
      println(" Current Fringe: ", fringe);
      println("Max Depth of: " + maxDepth);
      return true;
    }
    DFS(i, depth + 1, maxDepth);
    if(found){
        return true;
    }
  }
  fringe.remove(fringe.indexOf(v));
  return false;  
}