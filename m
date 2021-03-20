Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C176D342C34
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhCTLbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:31:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14108 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhCTLaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:30:23 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F2dmm3ydpz17NQ4;
        Sat, 20 Mar 2021 19:28:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Mar 2021 19:30:12 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 2/4] crypto: hisilicon/qm - move 'CURRENT_QM' code to qm.c
Date:   Sat, 20 Mar 2021 19:27:44 +0800
Message-ID: <1616239666-43572-3-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616239666-43572-1-git-send-email-qianweili@huawei.com>
References: <1616239666-43572-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the code related to 'CURRENT_QM' debugfs is exactly same in
sec/hpre/zip driver, move 'CURRENT_QM' to qm.c to reduce duplicate code.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre.h      |  1 -
 drivers/crypto/hisilicon/hpre/hpre_main.c | 61 ----------------------
 drivers/crypto/hisilicon/qm.c             | 87 ++++++++++++++++++++++++++-----
 drivers/crypto/hisilicon/qm.h             |  9 +---
 drivers/crypto/hisilicon/sec2/sec.h       |  1 -
 drivers/crypto/hisilicon/sec2/sec_main.c  | 59 +--------------------
 drivers/crypto/hisilicon/zip/zip_main.c   | 58 +--------------------
 7 files changed, 76 insertions(+), 200 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index 92892e3..e0b4a19 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -26,7 +26,6 @@ enum {
 };
 
 enum hpre_ctrl_dbgfs_file {
-	HPRE_CURRENT_QM,
 	HPRE_CLEAR_ENABLE,
 	HPRE_CLUSTER_CTRL,
 	HPRE_DEBUG_FILE_NUM,
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 818e7f3..a8b9c4c 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -118,7 +118,6 @@ static struct hisi_qm_list hpre_devices = {
 };
 
 static const char * const hpre_debug_file_name[] = {
-	[HPRE_CURRENT_QM]   = "current_qm",
 	[HPRE_CLEAR_ENABLE] = "rdclr_en",
 	[HPRE_CLUSTER_CTRL] = "cluster_ctrl",
 };
@@ -407,10 +406,6 @@ static void hpre_cnt_regs_clear(struct hisi_qm *qm)
 	unsigned long offset;
 	int i;
 
-	/* clear current_qm */
-	writel(0x0, qm->io_base + QM_DFX_MB_CNT_VF);
-	writel(0x0, qm->io_base + QM_DFX_DB_CNT_VF);
-
 	/* clear clusterX/cluster_ctrl */
 	for (i = 0; i < clusters_num; i++) {
 		offset = HPRE_CLSTR_BASE + i * HPRE_CLSTR_ADDR_INTRVL;
@@ -462,49 +457,6 @@ static inline struct hisi_qm *hpre_file_to_qm(struct hpre_debugfs_file *file)
 	return &hpre->qm;
 }
 
-static u32 hpre_current_qm_read(struct hpre_debugfs_file *file)
-{
-	struct hisi_qm *qm = hpre_file_to_qm(file);
-
-	return readl(qm->io_base + QM_DFX_MB_CNT_VF);
-}
-
-static int hpre_current_qm_write(struct hpre_debugfs_file *file, u32 val)
-{
-	struct hisi_qm *qm = hpre_file_to_qm(file);
-	u32 num_vfs = qm->vfs_num;
-	u32 vfq_num, tmp;
-
-	if (val > num_vfs)
-		return -EINVAL;
-
-	/* According PF or VF Dev ID to calculation curr_qm_qp_num and store */
-	if (val == 0) {
-		qm->debug.curr_qm_qp_num = qm->qp_num;
-	} else {
-		vfq_num = (qm->ctrl_qp_num - qm->qp_num) / num_vfs;
-		if (val == num_vfs) {
-			qm->debug.curr_qm_qp_num =
-			qm->ctrl_qp_num - qm->qp_num - (num_vfs - 1) * vfq_num;
-		} else {
-			qm->debug.curr_qm_qp_num = vfq_num;
-		}
-	}
-
-	writel(val, qm->io_base + QM_DFX_MB_CNT_VF);
-	writel(val, qm->io_base + QM_DFX_DB_CNT_VF);
-
-	tmp = val |
-	      (readl(qm->io_base + QM_DFX_SQE_CNT_VF_SQN) & CURRENT_Q_MASK);
-	writel(tmp, qm->io_base + QM_DFX_SQE_CNT_VF_SQN);
-
-	tmp = val |
-	      (readl(qm->io_base + QM_DFX_CQE_CNT_VF_CQN) & CURRENT_Q_MASK);
-	writel(tmp, qm->io_base + QM_DFX_CQE_CNT_VF_CQN);
-
-	return  0;
-}
-
 static u32 hpre_clear_enable_read(struct hpre_debugfs_file *file)
 {
 	struct hisi_qm *qm = hpre_file_to_qm(file);
@@ -560,9 +512,6 @@ static ssize_t hpre_ctrl_debug_read(struct file *filp, char __user *buf,
 
 	spin_lock_irq(&file->lock);
 	switch (file->type) {
-	case HPRE_CURRENT_QM:
-		val = hpre_current_qm_read(file);
-		break;
 	case HPRE_CLEAR_ENABLE:
 		val = hpre_clear_enable_read(file);
 		break;
@@ -603,11 +552,6 @@ static ssize_t hpre_ctrl_debug_write(struct file *filp, const char __user *buf,
 
 	spin_lock_irq(&file->lock);
 	switch (file->type) {
-	case HPRE_CURRENT_QM:
-		ret = hpre_current_qm_write(file, val);
-		if (ret)
-			goto err_input;
-		break;
 	case HPRE_CLEAR_ENABLE:
 		ret = hpre_clear_enable_write(file, val);
 		if (ret)
@@ -746,11 +690,6 @@ static int hpre_ctrl_debug_init(struct hisi_qm *qm)
 {
 	int ret;
 
-	ret = hpre_create_debugfs_file(qm, NULL, HPRE_CURRENT_QM,
-				       HPRE_CURRENT_QM);
-	if (ret)
-		return ret;
-
 	ret = hpre_create_debugfs_file(qm, NULL, HPRE_CLEAR_ENABLE,
 				       HPRE_CLEAR_ENABLE);
 	if (ret)
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 3c215ba..02f4d02 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -166,6 +166,14 @@
 #define ACC_AM_ROB_ECC_INT_STS		0x300104
 #define ACC_ROB_ECC_ERR_MULTPL		BIT(1)
 
+#define QM_DFX_MB_CNT_VF		0x104010
+#define QM_DFX_DB_CNT_VF		0x104020
+#define QM_DFX_SQE_CNT_VF_SQN		0x104030
+#define QM_DFX_CQE_CNT_VF_CQN		0x104040
+#define QM_DFX_QN_SHIFT			16
+#define CURRENT_FUN_MASK		GENMASK(5, 0)
+#define CURRENT_Q_MASK			GENMASK(31, 16)
+
 #define POLL_PERIOD			10
 #define POLL_TIMEOUT			1000
 #define WAIT_PERIOD_US_MAX		200
@@ -352,6 +360,7 @@ static struct qm_dfx_item qm_dfx_files[] = {
 };
 
 static const char * const qm_debug_file_name[] = {
+	[CURRENT_QM]   = "current_qm",
 	[CURRENT_Q]    = "current_q",
 	[CLEAR_ENABLE] = "clear_enable",
 };
@@ -920,6 +929,50 @@ static int clear_enable_write(struct debugfs_file *file, u32 rd_clr_ctrl)
 	return 0;
 }
 
+static u32 current_qm_read(struct debugfs_file *file)
+{
+	struct hisi_qm *qm = file_to_qm(file);
+
+	return readl(qm->io_base + QM_DFX_MB_CNT_VF);
+}
+
+static int current_qm_write(struct debugfs_file *file, u32 val)
+{
+	struct hisi_qm *qm = file_to_qm(file);
+	u32 vfq_num;
+	u32 tmp;
+
+	if (val > qm->vfs_num)
+		return -EINVAL;
+
+	/* According PF or VF Dev ID to calculation curr_qm_qp_num and store */
+	if (!val) {
+		qm->debug.curr_qm_qp_num = qm->qp_num;
+	} else {
+		vfq_num = (qm->ctrl_qp_num - qm->qp_num) / qm->vfs_num;
+
+		if (val == qm->vfs_num)
+			qm->debug.curr_qm_qp_num =
+				qm->ctrl_qp_num - qm->qp_num -
+				(qm->vfs_num - 1) * vfq_num;
+		else
+			qm->debug.curr_qm_qp_num = vfq_num;
+	}
+
+	writel(val, qm->io_base + QM_DFX_MB_CNT_VF);
+	writel(val, qm->io_base + QM_DFX_DB_CNT_VF);
+
+	tmp = val |
+	      (readl(qm->io_base + QM_DFX_SQE_CNT_VF_SQN) & CURRENT_Q_MASK);
+	writel(tmp, qm->io_base + QM_DFX_SQE_CNT_VF_SQN);
+
+	tmp = val |
+	      (readl(qm->io_base + QM_DFX_CQE_CNT_VF_CQN) & CURRENT_Q_MASK);
+	writel(tmp, qm->io_base + QM_DFX_CQE_CNT_VF_CQN);
+
+	return 0;
+}
+
 static ssize_t qm_debug_read(struct file *filp, char __user *buf,
 			     size_t count, loff_t *pos)
 {
@@ -931,6 +984,9 @@ static ssize_t qm_debug_read(struct file *filp, char __user *buf,
 
 	mutex_lock(&file->lock);
 	switch (index) {
+	case CURRENT_QM:
+		val = current_qm_read(file);
+		break;
 	case CURRENT_Q:
 		val = current_q_read(file);
 		break;
@@ -973,27 +1029,24 @@ static ssize_t qm_debug_write(struct file *filp, const char __user *buf,
 
 	mutex_lock(&file->lock);
 	switch (index) {
+	case CURRENT_QM:
+		ret = current_qm_write(file, val);
+		break;
 	case CURRENT_Q:
 		ret = current_q_write(file, val);
-		if (ret)
-			goto err_input;
 		break;
 	case CLEAR_ENABLE:
 		ret = clear_enable_write(file, val);
-		if (ret)
-			goto err_input;
 		break;
 	default:
 		ret = -EINVAL;
-		goto err_input;
 	}
 	mutex_unlock(&file->lock);
 
-	return count;
+	if (ret)
+		return ret;
 
-err_input:
-	mutex_unlock(&file->lock);
-	return ret;
+	return count;
 }
 
 static const struct file_operations qm_debug_fops = {
@@ -1531,12 +1584,12 @@ static const struct file_operations qm_cmd_fops = {
 	.write = qm_cmd_write,
 };
 
-static void qm_create_debugfs_file(struct hisi_qm *qm, enum qm_debug_file index)
+static void qm_create_debugfs_file(struct hisi_qm *qm, struct dentry *dir,
+				   enum qm_debug_file index)
 {
-	struct dentry *qm_d = qm->debug.qm_d;
 	struct debugfs_file *file = qm->debug.files + index;
 
-	debugfs_create_file(qm_debug_file_name[index], 0600, qm_d, file,
+	debugfs_create_file(qm_debug_file_name[index], 0600, dir, file,
 			    &qm_debug_fops);
 
 	file->index = index;
@@ -2932,9 +2985,11 @@ void hisi_qm_debug_init(struct hisi_qm *qm)
 	qm->debug.qm_d = qm_d;
 
 	/* only show this in PF */
-	if (qm->fun_type == QM_HW_PF)
+	if (qm->fun_type == QM_HW_PF) {
+		qm_create_debugfs_file(qm, qm->debug.debug_root, CURRENT_QM);
 		for (i = CURRENT_Q; i < DEBUG_FILE_NUM; i++)
-			qm_create_debugfs_file(qm, i);
+			qm_create_debugfs_file(qm, qm_d, i);
+	}
 
 	debugfs_create_file("regs", 0444, qm->debug.qm_d, qm, &qm_regs_fops);
 
@@ -2962,6 +3017,10 @@ void hisi_qm_debug_regs_clear(struct hisi_qm *qm)
 	struct qm_dfx_registers *regs;
 	int i;
 
+	/* clear current_qm */
+	writel(0x0, qm->io_base + QM_DFX_MB_CNT_VF);
+	writel(0x0, qm->io_base + QM_DFX_DB_CNT_VF);
+
 	/* clear current_q */
 	writel(0x0, qm->io_base + QM_DFX_SQE_CNT_VF_SQN);
 	writel(0x0, qm->io_base + QM_DFX_CQE_CNT_VF_CQN);
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index f91110f..5c4797b 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -51,14 +51,6 @@
 #define PEH_AXUSER_CFG			0x401001
 #define PEH_AXUSER_CFG_ENABLE		0xffffffff
 
-#define QM_DFX_MB_CNT_VF		0x104010
-#define QM_DFX_DB_CNT_VF		0x104020
-#define QM_DFX_SQE_CNT_VF_SQN		0x104030
-#define QM_DFX_CQE_CNT_VF_CQN		0x104040
-#define QM_DFX_QN_SHIFT			16
-#define CURRENT_FUN_MASK		GENMASK(5, 0)
-#define CURRENT_Q_MASK			GENMASK(31, 16)
-
 #define QM_AXI_RRESP			BIT(0)
 #define QM_AXI_BRESP			BIT(1)
 #define QM_ECC_MBIT			BIT(2)
@@ -123,6 +115,7 @@ enum qm_fun_type {
 };
 
 enum qm_debug_file {
+	CURRENT_QM,
 	CURRENT_Q,
 	CLEAR_ENABLE,
 	DEBUG_FILE_NUM,
diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index f7eba9b..dfdce2f 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -147,7 +147,6 @@ enum sec_endian {
 };
 
 enum sec_debug_file_index {
-	SEC_CURRENT_QM,
 	SEC_CLEAR_ENABLE,
 	SEC_DEBUG_FILE_NUM,
 };
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 2360d31..b1818f7 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -151,7 +151,6 @@ static const struct sec_hw_error sec_hw_errors[] = {
 };
 
 static const char * const sec_dbg_file_name[] = {
-	[SEC_CURRENT_QM] = "current_qm",
 	[SEC_CLEAR_ENABLE] = "clear_enable",
 };
 
@@ -400,10 +399,6 @@ static void sec_debug_regs_clear(struct hisi_qm *qm)
 {
 	int i;
 
-	/* clear current_qm */
-	writel(0x0, qm->io_base + QM_DFX_MB_CNT_VF);
-	writel(0x0, qm->io_base + QM_DFX_DB_CNT_VF);
-
 	/* clear sec dfx regs */
 	writel(0x1, qm->io_base + SEC_CTRL_CNT_CLR_CE);
 	for (i = 0; i < ARRAY_SIZE(sec_dfx_regs); i++)
@@ -464,50 +459,6 @@ static void sec_hw_error_disable(struct hisi_qm *qm)
 	writel(val, qm->io_base + SEC_CONTROL_REG);
 }
 
-static u32 sec_current_qm_read(struct sec_debug_file *file)
-{
-	struct hisi_qm *qm = file->qm;
-
-	return readl(qm->io_base + QM_DFX_MB_CNT_VF);
-}
-
-static int sec_current_qm_write(struct sec_debug_file *file, u32 val)
-{
-	struct hisi_qm *qm = file->qm;
-	u32 vfq_num;
-	u32 tmp;
-
-	if (val > qm->vfs_num)
-		return -EINVAL;
-
-	/* According PF or VF Dev ID to calculation curr_qm_qp_num and store */
-	if (!val) {
-		qm->debug.curr_qm_qp_num = qm->qp_num;
-	} else {
-		vfq_num = (qm->ctrl_qp_num - qm->qp_num) / qm->vfs_num;
-
-		if (val == qm->vfs_num)
-			qm->debug.curr_qm_qp_num =
-				qm->ctrl_qp_num - qm->qp_num -
-				(qm->vfs_num - 1) * vfq_num;
-		else
-			qm->debug.curr_qm_qp_num = vfq_num;
-	}
-
-	writel(val, qm->io_base + QM_DFX_MB_CNT_VF);
-	writel(val, qm->io_base + QM_DFX_DB_CNT_VF);
-
-	tmp = val |
-	      (readl(qm->io_base + QM_DFX_SQE_CNT_VF_SQN) & CURRENT_Q_MASK);
-	writel(tmp, qm->io_base + QM_DFX_SQE_CNT_VF_SQN);
-
-	tmp = val |
-	      (readl(qm->io_base + QM_DFX_CQE_CNT_VF_CQN) & CURRENT_Q_MASK);
-	writel(tmp, qm->io_base + QM_DFX_CQE_CNT_VF_CQN);
-
-	return 0;
-}
-
 static u32 sec_clear_enable_read(struct sec_debug_file *file)
 {
 	struct hisi_qm *qm = file->qm;
@@ -542,9 +493,6 @@ static ssize_t sec_debug_read(struct file *filp, char __user *buf,
 	spin_lock_irq(&file->lock);
 
 	switch (file->index) {
-	case SEC_CURRENT_QM:
-		val = sec_current_qm_read(file);
-		break;
 	case SEC_CLEAR_ENABLE:
 		val = sec_clear_enable_read(file);
 		break;
@@ -585,11 +533,6 @@ static ssize_t sec_debug_write(struct file *filp, const char __user *buf,
 	spin_lock_irq(&file->lock);
 
 	switch (file->index) {
-	case SEC_CURRENT_QM:
-		ret = sec_current_qm_write(file, val);
-		if (ret)
-			goto err_input;
-		break;
 	case SEC_CLEAR_ENABLE:
 		ret = sec_clear_enable_write(file, val);
 		if (ret)
@@ -674,7 +617,7 @@ static int sec_debug_init(struct hisi_qm *qm)
 	int i;
 
 	if (qm->pdev->device == SEC_PF_PCI_DEVICE_ID) {
-		for (i = SEC_CURRENT_QM; i < SEC_DEBUG_FILE_NUM; i++) {
+		for (i = SEC_CLEAR_ENABLE; i < SEC_DEBUG_FILE_NUM; i++) {
 			spin_lock_init(&sec->debug.files[i].lock);
 			sec->debug.files[i].index = i;
 			sec->debug.files[i].qm = qm;
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 8f67d70..4d2e9c8 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -137,13 +137,11 @@ static const struct hisi_zip_hw_error zip_hw_error[] = {
 };
 
 enum ctrl_debug_file_index {
-	HZIP_CURRENT_QM,
 	HZIP_CLEAR_ENABLE,
 	HZIP_DEBUG_FILE_NUM,
 };
 
 static const char * const ctrl_debug_file_name[] = {
-	[HZIP_CURRENT_QM]   = "current_qm",
 	[HZIP_CLEAR_ENABLE] = "clear_enable",
 };
 
@@ -362,48 +360,6 @@ static inline struct hisi_qm *file_to_qm(struct ctrl_debug_file *file)
 	return &hisi_zip->qm;
 }
 
-static u32 current_qm_read(struct ctrl_debug_file *file)
-{
-	struct hisi_qm *qm = file_to_qm(file);
-
-	return readl(qm->io_base + QM_DFX_MB_CNT_VF);
-}
-
-static int current_qm_write(struct ctrl_debug_file *file, u32 val)
-{
-	struct hisi_qm *qm = file_to_qm(file);
-	u32 vfq_num;
-	u32 tmp;
-
-	if (val > qm->vfs_num)
-		return -EINVAL;
-
-	/* According PF or VF Dev ID to calculation curr_qm_qp_num and store */
-	if (val == 0) {
-		qm->debug.curr_qm_qp_num = qm->qp_num;
-	} else {
-		vfq_num = (qm->ctrl_qp_num - qm->qp_num) / qm->vfs_num;
-		if (val == qm->vfs_num)
-			qm->debug.curr_qm_qp_num = qm->ctrl_qp_num -
-				qm->qp_num - (qm->vfs_num - 1) * vfq_num;
-		else
-			qm->debug.curr_qm_qp_num = vfq_num;
-	}
-
-	writel(val, qm->io_base + QM_DFX_MB_CNT_VF);
-	writel(val, qm->io_base + QM_DFX_DB_CNT_VF);
-
-	tmp = val |
-	      (readl(qm->io_base + QM_DFX_SQE_CNT_VF_SQN) & CURRENT_Q_MASK);
-	writel(tmp, qm->io_base + QM_DFX_SQE_CNT_VF_SQN);
-
-	tmp = val |
-	      (readl(qm->io_base + QM_DFX_CQE_CNT_VF_CQN) & CURRENT_Q_MASK);
-	writel(tmp, qm->io_base + QM_DFX_CQE_CNT_VF_CQN);
-
-	return  0;
-}
-
 static u32 clear_enable_read(struct ctrl_debug_file *file)
 {
 	struct hisi_qm *qm = file_to_qm(file);
@@ -437,9 +393,6 @@ static ssize_t hisi_zip_ctrl_debug_read(struct file *filp, char __user *buf,
 
 	spin_lock_irq(&file->lock);
 	switch (file->index) {
-	case HZIP_CURRENT_QM:
-		val = current_qm_read(file);
-		break;
 	case HZIP_CLEAR_ENABLE:
 		val = clear_enable_read(file);
 		break;
@@ -477,11 +430,6 @@ static ssize_t hisi_zip_ctrl_debug_write(struct file *filp,
 
 	spin_lock_irq(&file->lock);
 	switch (file->index) {
-	case HZIP_CURRENT_QM:
-		ret = current_qm_write(file, val);
-		if (ret)
-			goto err_input;
-		break;
 	case HZIP_CLEAR_ENABLE:
 		ret = clear_enable_write(file, val);
 		if (ret)
@@ -579,7 +527,7 @@ static int hisi_zip_ctrl_debug_init(struct hisi_qm *qm)
 	struct hisi_zip *zip = container_of(qm, struct hisi_zip, qm);
 	int i;
 
-	for (i = HZIP_CURRENT_QM; i < HZIP_DEBUG_FILE_NUM; i++) {
+	for (i = HZIP_CLEAR_ENABLE; i < HZIP_DEBUG_FILE_NUM; i++) {
 		spin_lock_init(&zip->ctrl->files[i].lock);
 		zip->ctrl->files[i].ctrl = zip->ctrl;
 		zip->ctrl->files[i].index = i;
@@ -626,10 +574,6 @@ static void hisi_zip_debug_regs_clear(struct hisi_qm *qm)
 {
 	int i, j;
 
-	/* clear current_qm */
-	writel(0x0, qm->io_base + QM_DFX_MB_CNT_VF);
-	writel(0x0, qm->io_base + QM_DFX_DB_CNT_VF);
-
 	/* enable register read_clear bit */
 	writel(HZIP_RD_CNT_CLR_CE_EN, qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE);
 	for (i = 0; i < ARRAY_SIZE(core_offsets); i++)
-- 
2.8.1

