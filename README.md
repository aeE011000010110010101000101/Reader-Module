# This software is a module designed for artificial intelligence implemented through batch. No other modules are used within this module. 

You can use this module as follows:

This module that can read specific type of data structure , like :

++"Layer" <-- (the layer name)

:[ <-- (cluster start parameter) {"Cluster"} <-- (cluster name)
 
 Info inside a cluster. <-- (Your Info) #0001 <-- (your tag here)

]: <-- (End of the cluster parameter which should be added for a correct data structure.)

--End <-- (end of the current layer)

Enviromental rules that MUST be obeyed for order:

- Layers can contain multiple clusters.
- Please provide the individual layer names enclosed in quotes that need to be read for special layer recognition input.
- Please provide the individual cluster names enclosed in quotes that need to be read for special cluster recognition input.
- Clusters can contain multiple data's.
- Data can contain only 1 tag.
- Layer cannot contain a layer inside.
- Cluster cannot contain a cluster inside.
- Except data NOTHING can contain "!" and "%" signs. Meaning layers , clusters and tags can't contain "%" and "!".
- Every data should contain a tag.
- Tags MUST have a range of 4 steps. Using integer is not necessary but recomended for less possible errors.
- To make a data visable you have to make it have a tag which inside a cluster and that cluster inside a layer. 
- Tag must be inside every data and it must be at the last 5 steps. Example: Here is my data! #0001 <--- 
- The first step of the tag MUST be "#" .
- The data will be setted inside "transfered.data" variable.
  ALL enviromental rules above must be obeyed too.
  
  These are the rules of the module.

More and more updates will come soon.
Dont forget that this is a module that re-designed for users use.

Calling parameter ability :

Call Reader64bytes.bat "(File that is going to be read here)" "(Layers that is going to be read here)" "(Clusters that is going to be read here)" "(Tags that is going to be read here)"

# The usage of this module is completely free and open to everyone. 
# If you have taken this project to use in any of your other projects, please don't forget to share my GitHub username. (aeE011000010110010101000101)
# If you find any errors or deficiencies, I would be very happy to hear about them.