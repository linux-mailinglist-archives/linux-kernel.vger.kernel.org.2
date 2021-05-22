Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE1338D438
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 09:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhEVHea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 03:34:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5724 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhEVHe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 03:34:29 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FnFV16XT8zqVHN;
        Sat, 22 May 2021 15:29:29 +0800 (CST)
Received: from dggeme768-chm.china.huawei.com (10.3.19.114) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 15:33:02 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggeme768-chm.china.huawei.com (10.3.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 22 May 2021 15:33:02 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <liulongfang@huawei.com>
Subject: [PATCH] crypto: hisilicon/qm - support address prefetching
Date:   Sat, 22 May 2021 15:30:04 +0800
Message-ID: <1621668604-14973-1-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme768-chm.china.huawei.com (10.3.19.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longfang Liu <liulongfang@huawei.com>

Kunpeng930 hardware supports address prefetching to improve performance
before doing tasks in SVA scenario.

This patch enables this function in device initialization by writing
hardware registers. In the process of reset, address prefetching is
disabled to avoid the failure of interaction between accelerator device
and SMMU.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 50 +++++++++++++++++++++++++++++++
 drivers/crypto/hisilicon/qm.c             | 35 ++++++++++++++++++++++
 drivers/crypto/hisilicon/qm.h             |  2 ++
 drivers/crypto/hisilicon/sec2/sec_main.c  | 45 ++++++++++++++++++++++++++++
 drivers/crypto/hisilicon/zip/zip_main.c   | 50 +++++++++++++++++++++++++++++++
 5 files changed, 182 insertions(+)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 13323ba..37c5296 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -75,6 +75,11 @@
 #define HPRE_BD_USR_MASK		GENMASK(1, 0)
 #define HPRE_CLUSTER_CORE_MASK_V2	GENMASK(3, 0)
 #define HPRE_CLUSTER_CORE_MASK_V3	GENMASK(7, 0)
+#define HPRE_PREFETCH_CFG		0x301130
+#define HPRE_SVA_PREFTCH_DFX		0x30115C
+#define HPRE_PREFETCH_ENABLE		(~(BIT(0) | BIT(30)))
+#define HPRE_PREFETCH_DISABLE		BIT(30)
+#define HPRE_SVA_DISABLE_READY		(BIT(4) | BIT(8))
 
 #define HPRE_AM_OOO_SHUTDOWN_ENB	0x301044
 #define HPRE_AM_OOO_SHUTDOWN_ENABLE	BIT(0)
@@ -370,6 +375,47 @@ static void disable_flr_of_bme(struct hisi_qm *qm)
 	writel(PEH_AXUSER_CFG_ENABLE, qm->io_base + QM_PEH_AXUSER_CFG_ENABLE);
 }
 
+static void hpre_open_sva_prefetch(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	if (qm->ver < QM_HW_V3)
+		return;
+
+	/* Enable prefetch */
+	val = readl_relaxed(qm->io_base + HPRE_PREFETCH_CFG);
+	val &= HPRE_PREFETCH_ENABLE;
+	writel(val, qm->io_base + HPRE_PREFETCH_CFG);
+
+	ret = readl_relaxed_poll_timeout(qm->io_base + HPRE_PREFETCH_CFG,
+					 val, !(val & HPRE_PREFETCH_DISABLE),
+					 HPRE_REG_RD_INTVRL_US,
+					 HPRE_REG_RD_TMOUT_US);
+	if (ret)
+		pci_err(qm->pdev, "failed to open sva prefetch\n");
+}
+
+static void hpre_close_sva_prefetch(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	if (qm->ver < QM_HW_V3)
+		return;
+
+	val = readl_relaxed(qm->io_base + HPRE_PREFETCH_CFG);
+	val |= HPRE_PREFETCH_DISABLE;
+	writel(val, qm->io_base + HPRE_PREFETCH_CFG);
+
+	ret = readl_relaxed_poll_timeout(qm->io_base + HPRE_SVA_PREFTCH_DFX,
+					 val, !(val & HPRE_SVA_DISABLE_READY),
+					 HPRE_REG_RD_INTVRL_US,
+					 HPRE_REG_RD_TMOUT_US);
+	if (ret)
+		pci_err(qm->pdev, "failed to close sva prefetch\n");
+}
+
 static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
 {
 	struct device *dev = &qm->pdev->dev;
@@ -876,6 +922,8 @@ static const struct hisi_qm_err_ini hpre_err_ini = {
 	.clear_dev_hw_err_status = hpre_clear_hw_err_status,
 	.log_dev_hw_err		= hpre_log_hw_error,
 	.open_axi_master_ooo	= hpre_open_axi_master_ooo,
+	.open_sva_prefetch	= hpre_open_sva_prefetch,
+	.close_sva_prefetch	= hpre_close_sva_prefetch,
 	.err_info_init		= hpre_err_info_init,
 };
 
@@ -888,6 +936,8 @@ static int hpre_pf_probe_init(struct hpre *hpre)
 	if (ret)
 		return ret;
 
+	hpre_open_sva_prefetch(qm);
+
 	qm->err_ini = &hpre_err_ini;
 	qm->err_ini->err_info_init(qm);
 	hisi_qm_dev_err_init(qm);
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 8f7ea50..dcdcdc9 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -95,6 +95,7 @@
 #define QM_DOORBELL_SQ_CQ_BASE_V2	0x1000
 #define QM_DOORBELL_EQ_AEQ_BASE_V2	0x2000
 #define QM_QUE_ISO_CFG_V		0x0030
+#define QM_PAGE_SIZE			0x0034
 #define QM_QUE_ISO_EN			0x100154
 #define QM_CAPBILITY			0x100158
 #define QM_QP_NUN_MASK			GENMASK(10, 0)
@@ -791,6 +792,32 @@ static void qm_init_qp_status(struct hisi_qp *qp)
 	atomic_set(&qp_status->used, 0);
 }
 
+static void qm_init_prefetch(struct hisi_qm *qm)
+{
+	struct device *dev = &qm->pdev->dev;
+	u32 page_type = 0x0;
+
+	if (qm->ver < QM_HW_V3)
+		return;
+
+	switch (PAGE_SIZE) {
+	case SZ_4K:
+		page_type = 0x0;
+		break;
+	case SZ_16K:
+		page_type = 0x1;
+		break;
+	case SZ_64K:
+		page_type = 0x2;
+		break;
+	default:
+		dev_err(dev, "system page size is not support: %lu, default set to 4KB",
+			PAGE_SIZE);
+	}
+
+	writel(page_type, qm->io_base + QM_PAGE_SIZE);
+}
+
 static void qm_vft_data_cfg(struct hisi_qm *qm, enum vft_type type, u32 base,
 			    u32 number)
 {
@@ -2879,6 +2906,8 @@ static int __hisi_qm_start(struct hisi_qm *qm)
 	if (ret)
 		return ret;
 
+	qm_init_prefetch(qm);
+
 	writel(0x0, qm->io_base + QM_VF_EQ_INT_MASK);
 	writel(0x0, qm->io_base + QM_VF_AEQ_INT_MASK);
 
@@ -3822,6 +3851,9 @@ static int qm_soft_reset(struct hisi_qm *qm)
 		return ret;
 	}
 
+	if (qm->err_ini->close_sva_prefetch)
+		qm->err_ini->close_sva_prefetch(qm);
+
 	ret = qm_set_pf_mse(qm, false);
 	if (ret) {
 		pci_err(pdev, "Fails to disable pf MSE bit.\n");
@@ -3891,6 +3923,9 @@ static void qm_restart_prepare(struct hisi_qm *qm)
 {
 	u32 value;
 
+	if (qm->err_ini->open_sva_prefetch)
+		qm->err_ini->open_sva_prefetch(qm);
+
 	if (qm->ver >= QM_HW_V3)
 		return;
 
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index acefdf8..9048aa6 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -188,6 +188,8 @@ struct hisi_qm_err_ini {
 	void (*clear_dev_hw_err_status)(struct hisi_qm *qm, u32 err_sts);
 	void (*open_axi_master_ooo)(struct hisi_qm *qm);
 	void (*close_axi_master_ooo)(struct hisi_qm *qm);
+	void (*open_sva_prefetch)(struct hisi_qm *qm);
+	void (*close_sva_prefetch)(struct hisi_qm *qm);
 	void (*log_dev_hw_err)(struct hisi_qm *qm, u32 err_sts);
 	void (*err_info_init)(struct hisi_qm *qm);
 };
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 6a4408e..8ab4e67 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -85,6 +85,12 @@
 #define SEC_USER1_SMMU_MASK		(~SEC_USER1_SVA_SET)
 #define SEC_CORE_INT_STATUS_M_ECC	BIT(2)
 
+#define SEC_PREFETCH_CFG		0x301130
+#define SEC_SVA_TRANS			0x301EC4
+#define SEC_PREFETCH_ENABLE		(~(BIT(0) | BIT(1) | BIT(11)))
+#define SEC_PREFETCH_DISABLE		BIT(1)
+#define SEC_SVA_DISABLE_READY		(BIT(7) | BIT(11))
+
 #define SEC_DELAY_10_US			10
 #define SEC_POLL_TIMEOUT_US		1000
 #define SEC_DBGFS_VAL_MAX_LEN		20
@@ -332,6 +338,42 @@ static u8 sec_get_endian(struct hisi_qm *qm)
 		return SEC_64BE;
 }
 
+static void sec_open_sva_prefetch(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	if (qm->ver < QM_HW_V3)
+		return;
+
+	/* Enable prefetch */
+	val = readl_relaxed(qm->io_base + SEC_PREFETCH_CFG);
+	val &= SEC_PREFETCH_ENABLE;
+	writel(val, qm->io_base + SEC_PREFETCH_CFG);
+
+	ret = readl_relaxed_poll_timeout(qm->io_base + SEC_PREFETCH_CFG,
+					 val, !(val & SEC_PREFETCH_DISABLE),
+					 SEC_DELAY_10_US, SEC_POLL_TIMEOUT_US);
+	if (ret)
+		pci_err(qm->pdev, "failed to open sva prefetch\n");
+}
+
+static void sec_close_sva_prefetch(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	val = readl_relaxed(qm->io_base + SEC_PREFETCH_CFG);
+	val |= SEC_PREFETCH_DISABLE;
+	writel(val, qm->io_base + SEC_PREFETCH_CFG);
+
+	ret = readl_relaxed_poll_timeout(qm->io_base + SEC_SVA_TRANS,
+					 val, !(val & SEC_SVA_DISABLE_READY),
+					 SEC_DELAY_10_US, SEC_POLL_TIMEOUT_US);
+	if (ret)
+		pci_err(qm->pdev, "failed to close sva prefetch\n");
+}
+
 static int sec_engine_init(struct hisi_qm *qm)
 {
 	int ret;
@@ -751,6 +793,8 @@ static const struct hisi_qm_err_ini sec_err_ini = {
 	.clear_dev_hw_err_status = sec_clear_hw_err_status,
 	.log_dev_hw_err		= sec_log_hw_error,
 	.open_axi_master_ooo	= sec_open_axi_master_ooo,
+	.open_sva_prefetch	= sec_open_sva_prefetch,
+	.close_sva_prefetch	= sec_close_sva_prefetch,
 	.err_info_init		= sec_err_info_init,
 };
 
@@ -766,6 +810,7 @@ static int sec_pf_probe_init(struct sec_dev *sec)
 	if (ret)
 		return ret;
 
+	sec_open_sva_prefetch(qm);
 	hisi_qm_dev_err_init(qm);
 	sec_debug_regs_clear(qm);
 
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 3e23f2a..9e4c49c 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -97,6 +97,14 @@
 #define HZIP_RD_CNT_CLR_CE_EN		(HZIP_CNT_CLR_CE_EN | \
 					 HZIP_RO_CNT_CLR_CE_EN)
 
+#define HZIP_PREFETCH_CFG		0x3011B0
+#define HZIP_SVA_TRANS			0x3011C4
+#define HZIP_PREFETCH_ENABLE		(~(BIT(26) | BIT(17) | BIT(0)))
+#define HZIP_SVA_PREFETCH_DISABLE	BIT(26)
+#define HZIP_SVA_DISABLE_READY		(BIT(26) | BIT(30))
+#define HZIP_DELAY_1_US		1
+#define HZIP_POLL_TIMEOUT_US	1000
+
 static const char hisi_zip_name[] = "hisi_zip";
 static struct dentry *hzip_debugfs_root;
 
@@ -263,6 +271,45 @@ int zip_create_qps(struct hisi_qp **qps, int qp_num, int node)
 	return hisi_qm_alloc_qps_node(&zip_devices, qp_num, 0, node, qps);
 }
 
+static void hisi_zip_open_sva_prefetch(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	if (qm->ver < QM_HW_V3)
+		return;
+
+	/* Enable prefetch */
+	val = readl_relaxed(qm->io_base + HZIP_PREFETCH_CFG);
+	val &= HZIP_PREFETCH_ENABLE;
+	writel(val, qm->io_base + HZIP_PREFETCH_CFG);
+
+	ret = readl_relaxed_poll_timeout(qm->io_base + HZIP_PREFETCH_CFG,
+					 val, !(val & HZIP_SVA_PREFETCH_DISABLE),
+					 HZIP_DELAY_1_US, HZIP_POLL_TIMEOUT_US);
+	if (ret)
+		pci_err(qm->pdev, "failed to open sva prefetch\n");
+}
+
+static void hisi_zip_close_sva_prefetch(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	if (qm->ver < QM_HW_V3)
+		return;
+
+	val = readl_relaxed(qm->io_base + HZIP_PREFETCH_CFG);
+	val |= HZIP_SVA_PREFETCH_DISABLE;
+	writel(val, qm->io_base + HZIP_PREFETCH_CFG);
+
+	ret = readl_relaxed_poll_timeout(qm->io_base + HZIP_SVA_TRANS,
+					 val, !(val & HZIP_SVA_DISABLE_READY),
+					 HZIP_DELAY_1_US, HZIP_POLL_TIMEOUT_US);
+	if (ret)
+		pci_err(qm->pdev, "failed to close sva prefetch\n");
+}
+
 static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 {
 	void __iomem *base = qm->io_base;
@@ -696,6 +743,8 @@ static const struct hisi_qm_err_ini hisi_zip_err_ini = {
 	.log_dev_hw_err		= hisi_zip_log_hw_error,
 	.open_axi_master_ooo	= hisi_zip_open_axi_master_ooo,
 	.close_axi_master_ooo	= hisi_zip_close_axi_master_ooo,
+	.open_sva_prefetch	= hisi_zip_open_sva_prefetch,
+	.close_sva_prefetch	= hisi_zip_close_sva_prefetch,
 	.err_info_init		= hisi_zip_err_info_init,
 };
 
@@ -714,6 +763,7 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
 	qm->err_ini->err_info_init(qm);
 
 	hisi_zip_set_user_domain_and_cache(qm);
+	hisi_zip_open_sva_prefetch(qm);
 	hisi_qm_dev_err_init(qm);
 	hisi_zip_debug_regs_clear(qm);
 
-- 
2.8.1

