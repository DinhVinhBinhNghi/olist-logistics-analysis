# Dataset

This project uses the **Brazilian E-Commerce Public Dataset by Olist**.

Due to the large file size, the dataset is **not stored directly in this repository**.
Please download it from the official source below.

## Download

Dataset link:
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

You can download it manually or using the Kaggle API.

### Option 1 — Manual Download

1. Go to the dataset link above.
2. Download the ZIP file.
3. Extract it into the `dataset/` folder.

Expected folder structure:

project
├── dataset
│   ├── olist_customers_dataset.csv

│   ├── olist_orders_dataset.csv

│   ├── olist_order_items_dataset.csv

│   ├── olist_products_dataset.csv

│   └── ...

Option 2 — Using Kaggle API

Install Kaggle:

pip install kaggle

Download dataset:

kaggle datasets download -d olistbr/brazilian-ecommerce

Unzip into the dataset folder.

Notes

The dataset is publicly available on Kaggle.

This repository only contains the code and analysis, not the raw dataset files.

