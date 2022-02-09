# demo using mapreduce to create a sample text file and see if you can find the number of times different words appear.

# note add MRJOB to PythonData environment using pip install MRJob

# import dependencies
from mrjob.job import MRJob

# Note: a class contains all the instructions to create a unique object
# Create a class called Bacon_count, which inherits, or takes properties, from the MRJob class.
# We create this class to be called to run the full MapReduce job withMRJob:


class Chicken_count(MRJob):

    # Next, create a mapper()function that will take (self, _, line) as parameters.
    # The mapper() function will assign the input to key-value pairs:
    def mapper(self, _, line):

        # The second parameter (here using an underscore (_), explained next) allows methods to be mapped together. Since we are not chaining anything together, we use the Python convention of an underscore to indicate that we won’t use this parameter.
        # The line parameter will be the line of text taken from the raw input file.

        # split out each word for each line and use yeild to "count" the occurances of bacon
        for word in line.split():
            if word.lower() == "chicken":
                yield "chicken", 1
                
    # shuffle and reduce
    def reducer(self, key, values):
        yield key, sum(values)
            
# add conventional Python code for running the program:
if __name__ == "__main__":
    Chicken_count.run()



