# Math70076-CW2-Stephen Curry Shot Selection Analysis

This repository presents the final project for the MATH70076 Data Science module at Imperial College London. The project investigates the factors influencing NBA legend Stephen Curry’s shot selection and success. Using detailed shot-level data spanning multiple seasons, this study applies a range of statistical and machine learning models to model and interpret shooting behavior.

---

## 📁 Repository Structure

-`data/`: Raw and processed datasets used in the analysis.

-`analyse/`: R scripts for key analytical components: data processing, exploratory data analysis (EDA), and model fitting & evaluation.

-`outputs/`: Figures and visualizations generated throughout the analysis.

-`scr/`: Utility R scripts, including court plotting and empirical logit visualization functions.

-`report/`: Final project report in PDF format, LaTeX files, bibliography and associated material for submission.

-`summary/`: Reflective summary document, LaTeX files, bibliography and associated material for submission.

## 📊 Analysis Summary

- **Objective**: Analyze Stephen Curry’s shot-level data to identify spatial, temporal, and contextual factors that predict shot success.
- **Modeling Techniques Used:**: Logistic regression (GLM, stepwise with AIC/BIC), Decision Trees and Random Forests, Support Vector Machines (SVM), K-Nearest Neighbors (KNN), Neural Networks(NN).
- **Key Features Considered:**: Shot distance, game quarter, clock time, Action type (e.g., jump shot, layup), Home/away status, Shot location coordinates.
- **Diagnostics and Evaluation:**: Confusion matrices, ROC curves, empirical logit plots, Visualization of decision boundaries, Model comparison via accuracy, recall, precision, and AUC.

## 📄 Key Variables
### Dependent variable (outcome):
- **made**: Binary outcome indicating whether the shot was made (1) or missed (0).

### Selected predictors include:
- **log_distance_ft**: Log-transformed shot distance in feet.
- **sqrt_seconds_left**: Square-root-transformed game clock seconds remaining.
- **action_group**: Categorized shot types (e.g., Jump Shot, Dunk, Hook Shot).
- **zone_basic**: Court zones such as "Left Corner", "Top of the Key".
- **is_home**: Indicator for whether the shot was taken at home.
- **x, y**: Court coordinates (used for spatial modeling and visualization).

## R & R Packages Used
-ggplot2, patchwork, dplyr, forcats, MASS

-broom, knitr, kableExtra, stringr, caret, nnet

-e1071, rpart, randomForest, class, pROC





