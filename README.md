# Bank Customer Churn — MLflow Experiments (Research Branch)

This project predicts **bank customer churn** and tracks experiments with **MLflow**.  
It follows the assignment requirements:
- Manual MLflow logging (no `mlflow.autolog`)
- At least 3 runs with different models/hyperparameters
- Register two models: one in **Staging**, one in **Production** — with justification
- BONUS: Completed README
- EXTRA BONUS: Code refactor into modules + logging (while keeping `src/train.py` with the original comments and solution)

---

## 📂 Dataset
- Source: Kaggle — Bank Customer Churn Prediction  
- File used: `data/Churn_Modelling.csv`  
- Target column: `Exited` (0 = stays, 1 = churns)

> Place the dataset at: `./data/Churn_Modelling.csv`

---

## 🧰 Environment (Python 3.12)

### Conda
```bash
conda create -n churn_prediction python=3.12 -y
conda activate churn_prediction
pip install --upgrade pip
pip install -r requirements.txt