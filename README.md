A JPEG Decoder
===================

# 1.Introduction
----------------

We introduce the initial GAV model and CV model which can only solve the local minimum due to the non-convexity of the energy function. Using the horizontal set method and gradient descent method, the objective function is transformed into a convex energy function based on variational. Then we can determine a global minimum of active contours model and use two efficient and fast algorithms: the Primal-Dual algorithms and the Split-Bregman algorithms. In the Primal-Dual algorithm, an additional variable corresponding to the original partition variable is introduced, which is called a dual variable, and then we use the linear method to slove problem. In the Split Bregman algorihm, the Bregman iterative regularization method is used in the image field that is used to solve the segmentation variables. Experiments show that the two algorithms are effective and fast. Unlike the Primal-Dual algorithm, the Split Bregman algorithm's reslut is not depend on the threshold and has better performance at the edge of the object. These studies confirm the application and contribution of convex optimization theory in the active contours field.


# 2.Structure
---------------
	- Matlab
		-- GAC
		-- snake
	- input 
		-- dog.jpg


# 3. Reference
->1. M. Kass, A. Witkin, and D. Terzopoulos, “Snakes: Active contour models”, International Journal of Computer Vision, 1 (4) :321-331, 1988.
[2].	V. Caselles, R. Kimmel, and G. Sapiro, “Geodesic active contours”, International Journal of Computer Vision, 22 (1) :61-79, 1997.
[3].	 L.D. Cohen, R. Kimmel, “Global Minimum for Active Contour Models: A Minimal Path Approach”, International Journal of Computer Vision, 24 (1) :57-78, 1997
[4].	X. Bresson, S. Esedoglu, P. Vandergheynst, J. P. Thiran, and S. Osher, “Fast Global Minimization of the Active Contour/Snake Model”, International Journal of Computer Vision, 28 (2) :151-167, 2007.
[5].	N. Paragios, O. Mellinagottardo, and V. Ramesh, “Gradient vector flow fast geodesic active contours”, IEEE International Conference on Computer Vision, 1 :67-73 vol.1, 2001.
[6].	“Active Contours Without Edges”
[7].	T. Goldstein, X. Bresson, and S. Osher, “Geometric Applications of the Split Bregman Method: Segmentation and Surface Reconstruction”, Journal of Scientific Computing, 45 (1-3) :272-293, 2010.
[8].	Y. Yang, and B. Wu, “Split Bregman method for minimization of improved active contour model combining local and global information dynamically”, Journal of Mathematical Analysis and Applications, 389(1):351-366, 2012.


