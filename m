Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F186C3A3EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhFKJJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:09:18 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4032 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhFKJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:09:08 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G1Zbp1s4czWt7C;
        Fri, 11 Jun 2021 17:02:14 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 17:07:08 +0800
Received: from huawei.com (10.69.192.56) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 17:07:08 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 1/8] crypto: hisilicon/qm - supports writing QoS int the host
Date:   Fri, 11 Jun 2021 17:06:43 +0800
Message-ID: <1623402410-63906-2-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623402410-63906-1-git-send-email-yekai13@huawei.com>
References: <1623402410-63906-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the Token bucket algorithm. The HAC driver supports to configure
each function's QoS in the host. The driver supports writing QoS by the
debugfs node that named "alg_qos". The qos value is 1~1000.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 298 +++++++++++++++++++++++++++++++++++++++++-
 drivers/crypto/hisilicon/qm.h |  14 ++
 2 files changed, 310 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index f79d43c..f2e5d0b 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -240,6 +240,32 @@
 #define QM_DRIVER_REMOVING		0
 #define QM_RST_SCHED			1
 #define QM_RESETTING			2
+#define QM_QOS_PARAM_NUM		2
+#define QM_QOS_VAL_NUM			1
+#define QM_QOS_BDF_PARAM_NUM		4
+#define QM_QOS_MAX_VAL			1000
+#define QM_QOS_RATE			100
+#define QM_QOS_EXPAND_RATE		1000
+#define QM_SHAPER_CIR_B_MASK		GENMASK(7, 0)
+#define QM_SHAPER_CIR_U_MASK		GENMASK(10, 8)
+#define QM_SHAPER_CIR_S_MASK		GENMASK(14, 11)
+#define QM_SHAPER_FACTOR_CIR_U_SHIFT	8
+#define QM_SHAPER_FACTOR_CIR_S_SHIFT	11
+#define QM_SHAPER_FACTOR_CBS_B_SHIFT	15
+#define QM_SHAPER_FACTOR_CBS_S_SHIFT	19
+#define QM_SHAPER_CBS_B			1
+#define QM_SHAPER_CBS_S			16
+#define QM_SHAPER_VFT_OFFSET		6
+#define QM_QOS_MIN_ERROR_RATE		5
+#define QM_QOS_TYPICAL_NUM		8
+#define QM_SHAPER_MIN_CBS_S		8
+#define QM_QOS_TICK			0x300U
+#define QM_QOS_DIVISOR_CLK		0x1f40U
+#define QM_QOS_MAX_CIR_B		200
+#define QM_QOS_MIN_CIR_B		100
+#define QM_QOS_MAX_CIR_U		6
+#define QM_QOS_MAX_CIR_S		11
+#define QM_QOS_VAL_MAX_LEN		32
 
 #define QM_MK_CQC_DW3_V1(hop_num, pg_sz, buf_sz, cqe_sz) \
 	(((hop_num) << QM_CQ_HOP_NUM_SHIFT)	| \
@@ -280,6 +306,7 @@
 enum vft_type {
 	SQC_VFT = 0,
 	CQC_VFT,
+	SHAPER_VFT,
 };
 
 enum acc_err_result {
@@ -288,6 +315,11 @@ enum acc_err_result {
 	ACC_ERR_RECOVERED,
 };
 
+enum qm_alg_type {
+	ALG_TYPE_0,
+	ALG_TYPE_1,
+};
+
 enum qm_mb_cmd {
 	QM_PF_FLR_PREPARE = 0x01,
 	QM_PF_SRST_PREPARE,
@@ -460,6 +492,11 @@ static const char * const qp_s[] = {
 	"none", "init", "start", "stop", "close",
 };
 
+static const u32 typical_qos_val[QM_QOS_TYPICAL_NUM] = {100, 250, 500, 1000,
+						10000, 25000, 50000, 100000};
+static const u32 typical_qos_cbs_s[QM_QOS_TYPICAL_NUM] = {9, 10, 11, 12, 16,
+							 17, 18, 19};
+
 static bool qm_avail_state(struct hisi_qm *qm, enum qm_state new)
 {
 	enum qm_state curr = atomic_read(&qm->status.flags);
@@ -899,8 +936,69 @@ static void qm_init_prefetch(struct hisi_qm *qm)
 	writel(page_type, qm->io_base + QM_PAGE_SIZE);
 }
 
+/*
+ * the formula:
+ * IR = X Mbps if ir = 1 means IR = 100 Mbps, if ir = 10000 means = 10Gbps
+ *
+ *		        IR_b * (2 ^ IR_u) * 8
+ * IR(Mbps) * 10 ^ -3 = -------------------------
+ *		        Tick * (2 ^ IR_s)
+ */
+static u32 acc_shaper_para_calc(u64 cir_b, u64 cir_u, u64 cir_s)
+{
+	return ((cir_b * QM_QOS_DIVISOR_CLK) * (1 << cir_u)) /
+					(QM_QOS_TICK * (1 << cir_s));
+}
+
+static u32 acc_shaper_calc_cbs_s(u32 ir)
+{
+	int i;
+
+	if (ir < typical_qos_val[0])
+		return QM_SHAPER_MIN_CBS_S;
+
+	for (i = 1; i < QM_QOS_TYPICAL_NUM; i++) {
+		if (ir >= typical_qos_val[i - 1] && ir < typical_qos_val[i])
+			return typical_qos_cbs_s[i - 1];
+	}
+
+	return typical_qos_cbs_s[QM_QOS_TYPICAL_NUM - 1];
+}
+
+static int qm_get_shaper_para(u32 ir, struct qm_shaper_factor *factor)
+{
+	u32 cir_b, cir_u, cir_s, ir_calc;
+	u32 error_rate;
+
+	factor->cbs_s = acc_shaper_calc_cbs_s(ir);
+
+	for (cir_b = QM_QOS_MIN_CIR_B; cir_b <= QM_QOS_MAX_CIR_B; cir_b++) {
+		for (cir_u = 0; cir_u <= QM_QOS_MAX_CIR_U; cir_u++) {
+			for (cir_s = 0; cir_s <= QM_QOS_MAX_CIR_S; cir_s++) {
+				/** the formula is changed to:
+				 *	   IR_b * (2 ^ IR_u) * DIVISOR_CLK
+				 * IR(Mbps) = -------------------------
+				 *	       768 * (2 ^ IR_s)
+				 */
+				ir_calc = acc_shaper_para_calc(cir_b, cir_u,
+							       cir_s);
+				error_rate = QM_QOS_EXPAND_RATE * (u32)abs(ir_calc - ir) / ir;
+				if (error_rate <= QM_QOS_MIN_ERROR_RATE) {
+					factor->cir_b = cir_b;
+					factor->cir_u = cir_u;
+					factor->cir_s = cir_s;
+
+					return 0;
+				}
+			}
+		}
+	}
+
+	return -EINVAL;
+}
+
 static void qm_vft_data_cfg(struct hisi_qm *qm, enum vft_type type, u32 base,
-			    u32 number)
+			    u32 number, struct qm_shaper_factor *factor)
 {
 	u64 tmp = 0;
 
@@ -929,6 +1027,15 @@ static void qm_vft_data_cfg(struct hisi_qm *qm, enum vft_type type, u32 base,
 				tmp = QM_CQC_VFT_VALID;
 			}
 			break;
+		case SHAPER_VFT:
+			if (qm->ver >= QM_HW_V3) {
+				tmp = factor->cir_b |
+				(factor->cir_u << QM_SHAPER_FACTOR_CIR_U_SHIFT) |
+				(factor->cir_s << QM_SHAPER_FACTOR_CIR_S_SHIFT) |
+				(QM_SHAPER_CBS_B << QM_SHAPER_FACTOR_CBS_B_SHIFT) |
+				(factor->cbs_s << QM_SHAPER_FACTOR_CBS_S_SHIFT);
+			}
+			break;
 		}
 	}
 
@@ -939,6 +1046,7 @@ static void qm_vft_data_cfg(struct hisi_qm *qm, enum vft_type type, u32 base,
 static int qm_set_vft_common(struct hisi_qm *qm, enum vft_type type,
 			     u32 fun_num, u32 base, u32 number)
 {
+	struct qm_shaper_factor *factor = &qm->factor[fun_num];
 	unsigned int val;
 	int ret;
 
@@ -950,9 +1058,12 @@ static int qm_set_vft_common(struct hisi_qm *qm, enum vft_type type,
 
 	writel(0x0, qm->io_base + QM_VFT_CFG_OP_WR);
 	writel(type, qm->io_base + QM_VFT_CFG_TYPE);
+	if (type == SHAPER_VFT)
+		fun_num |= base << QM_SHAPER_VFT_OFFSET;
+
 	writel(fun_num, qm->io_base + QM_VFT_CFG);
 
-	qm_vft_data_cfg(qm, type, base, number);
+	qm_vft_data_cfg(qm, type, base, number, factor);
 
 	writel(0x0, qm->io_base + QM_VFT_CFG_RDY);
 	writel(0x1, qm->io_base + QM_VFT_CFG_OP_ENABLE);
@@ -962,6 +1073,27 @@ static int qm_set_vft_common(struct hisi_qm *qm, enum vft_type type,
 					  POLL_TIMEOUT);
 }
 
+static int qm_shaper_init_vft(struct hisi_qm *qm, u32 fun_num)
+{
+	int ret, i;
+
+	qm->factor[fun_num].func_qos = QM_QOS_MAX_VAL;
+	ret = qm_get_shaper_para(QM_QOS_MAX_VAL * QM_QOS_RATE, &qm->factor[fun_num]);
+	if (ret) {
+		dev_err(&qm->pdev->dev, "failed to calculate shaper parameter!\n");
+		return ret;
+	}
+	writel(qm->type_rate, qm->io_base + QM_SHAPER_CFG);
+	for (i = ALG_TYPE_0; i <= ALG_TYPE_1; i++) {
+		/* The base number of queue reuse for different alg type */
+		ret = qm_set_vft_common(qm, SHAPER_VFT, fun_num, i, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /* The config should be conducted after qm_dev_mem_reset() */
 static int qm_set_sqc_cqc_vft(struct hisi_qm *qm, u32 fun_num, u32 base,
 			      u32 number)
@@ -974,7 +1106,21 @@ static int qm_set_sqc_cqc_vft(struct hisi_qm *qm, u32 fun_num, u32 base,
 			return ret;
 	}
 
+	/* init default shaper qos val */
+	if (qm->ver >= QM_HW_V3) {
+		ret = qm_shaper_init_vft(qm, fun_num);
+		if (ret)
+			goto back_sqc_cqc;
+	}
+
 	return 0;
+back_sqc_cqc:
+	for (i = SQC_VFT; i <= CQC_VFT; i++) {
+		ret = qm_set_vft_common(qm, i, fun_num, 0, 0);
+		if (ret)
+			return ret;
+	}
+	return ret;
 }
 
 static int qm_get_vft_v2(struct hisi_qm *qm, u32 *base, u32 *number)
@@ -3133,6 +3279,7 @@ void hisi_qm_uninit(struct hisi_qm *qm)
 	struct device *dev = &pdev->dev;
 
 	qm_cmd_uninit(qm);
+	kfree(qm->factor);
 	down_write(&qm->qps_lock);
 
 	if (!qm_avail_state(qm, QM_CLOSE)) {
@@ -3862,6 +4009,149 @@ static int qm_clear_vft_config(struct hisi_qm *qm)
 	return 0;
 }
 
+static int qm_func_shaper_enable(struct hisi_qm *qm, u32 fun_index, u32 qos)
+{
+	struct device *dev = &qm->pdev->dev;
+	u32 ir = qos * QM_QOS_RATE;
+	int ret, total_vfs, i;
+
+	total_vfs = pci_sriov_get_totalvfs(qm->pdev);
+	if (fun_index > total_vfs)
+		return -EINVAL;
+
+	qm->factor[fun_index].func_qos = qos;
+
+	ret = qm_get_shaper_para(ir, &qm->factor[fun_index]);
+	if (ret) {
+		dev_err(dev, "failed to calculate shaper parameter!\n");
+		return -EINVAL;
+	}
+
+	for (i = ALG_TYPE_0; i <= ALG_TYPE_1; i++) {
+		/* The base number of queue reuse for different alg type */
+		ret = qm_set_vft_common(qm, SHAPER_VFT, fun_index, i, 1);
+		if (ret) {
+			dev_err(dev, "type: %d, failed to set shaper vft!\n", i);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static ssize_t qm_qos_value_init(const char *buf, unsigned long *val)
+{
+	int buflen = strlen(buf);
+	int ret, i;
+
+	for (i = 0; i < buflen; i++) {
+		if (!isdigit(buf[i]))
+			return -EINVAL;
+	}
+
+	ret = sscanf(buf, "%ld", val);
+	if (ret != QM_QOS_VAL_NUM)
+		return -EINVAL;
+
+	return 0;
+}
+
+static ssize_t qm_algqos_write(struct file *filp, const char __user *buf,
+			       size_t count, loff_t *pos)
+{
+	struct hisi_qm *qm = filp->private_data;
+	char tbuf[QM_DBG_READ_LEN];
+	int tmp1, bus, device, function;
+	char tbuf_bdf[QM_DBG_READ_LEN] = {0};
+	char val_buf[QM_QOS_VAL_MAX_LEN] = {0};
+	unsigned int fun_index;
+	unsigned long val = 0;
+	int len, ret;
+
+	if (qm->fun_type == QM_HW_VF)
+		return -EINVAL;
+
+	/* Mailbox and reset cannot be operated at the same time */
+	if (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
+		pci_err(qm->pdev, "dev resetting, write alg qos failed!\n");
+		return -EAGAIN;
+	}
+
+	if (*pos != 0) {
+		ret = 0;
+		goto err_get_status;
+	}
+
+	if (count >= QM_DBG_READ_LEN) {
+		ret = -ENOSPC;
+		goto err_get_status;
+	}
+
+	len = simple_write_to_buffer(tbuf, QM_DBG_READ_LEN - 1, pos, buf, count);
+	if (len < 0) {
+		ret = len;
+		goto err_get_status;
+	}
+
+	tbuf[len] = '\0';
+	ret = sscanf(tbuf, "%s %s", tbuf_bdf, val_buf);
+	if (ret != QM_QOS_PARAM_NUM) {
+		ret = -EINVAL;
+		goto err_get_status;
+	}
+
+	ret = qm_qos_value_init(val_buf, &val);
+	if (val == 0 || val > QM_QOS_MAX_VAL || ret) {
+		pci_err(qm->pdev, "input qos value is error, please set 1~1000!\n");
+		ret = -EINVAL;
+		goto err_get_status;
+	}
+
+	ret = sscanf(tbuf_bdf, "%d:%x:%d.%d", &tmp1, &bus, &device, &function);
+	if (ret != QM_QOS_BDF_PARAM_NUM) {
+		pci_err(qm->pdev, "input pci bdf value is error!\n");
+		ret = -EINVAL;
+		goto err_get_status;
+	}
+
+	fun_index = device * 8 + function;
+
+	ret = qm_func_shaper_enable(qm, fun_index, val);
+	if (ret) {
+		pci_err(qm->pdev, "failed to enable function shaper!\n");
+		ret = -EINVAL;
+		goto err_get_status;
+	}
+
+	ret =  count;
+
+err_get_status:
+	clear_bit(QM_RESETTING, &qm->misc_ctl);
+	return ret;
+}
+
+static const struct file_operations qm_algqos_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = qm_algqos_write,
+};
+
+/**
+ * hisi_qm_set_algqos_init() - Initialize function qos debugfs files.
+ * @qm: The qm for which we want to add debugfs files.
+ *
+ * Create function qos debugfs files.
+ */
+static void hisi_qm_set_algqos_init(struct hisi_qm *qm)
+{
+	if (qm->fun_type == QM_HW_PF)
+		debugfs_create_file("alg_qos", 0644, qm->debug.debug_root,
+				    qm, &qm_algqos_fops);
+	else
+		debugfs_create_file("alg_qos", 0444, qm->debug.debug_root,
+				    qm, &qm_algqos_fops);
+}
+
 /**
  * hisi_qm_sriov_enable() - enable virtual functions
  * @pdev: the PCIe device
@@ -3916,6 +4206,7 @@ EXPORT_SYMBOL_GPL(hisi_qm_sriov_enable);
 int hisi_qm_sriov_disable(struct pci_dev *pdev, bool is_frozen)
 {
 	struct hisi_qm *qm = pci_get_drvdata(pdev);
+	int total_vfs = pci_sriov_get_totalvfs(qm->pdev);
 
 	if (pci_vfs_assigned(pdev)) {
 		pci_err(pdev, "Failed to disable VFs as VFs are assigned!\n");
@@ -3929,6 +4220,9 @@ int hisi_qm_sriov_disable(struct pci_dev *pdev, bool is_frozen)
 	}
 
 	pci_disable_sriov(pdev);
+	/* clear vf function shaper configure array */
+	memset(qm->factor + 1, 0, sizeof(struct qm_shaper_factor) * total_vfs);
+
 	return qm_clear_vft_config(qm);
 }
 EXPORT_SYMBOL_GPL(hisi_qm_sriov_disable);
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 8a36bad..035eaf8 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -76,6 +76,9 @@
 #define QM_Q_DEPTH			1024
 #define QM_MIN_QNUM                     2
 #define HISI_ACC_SGL_SGE_NR_MAX		255
+#define QM_SHAPER_CFG			0x100164
+#define QM_SHAPER_ENABLE		BIT(30)
+#define QM_SHAPER_TYPE1_OFFSET		10
 
 /* page number for queue file region */
 #define QM_DOORBELL_PAGE_NR		1
@@ -148,6 +151,14 @@ struct qm_debug {
 	struct debugfs_file files[DEBUG_FILE_NUM];
 };
 
+struct qm_shaper_factor {
+	u32 func_qos;
+	u64 cir_b;
+	u64 cir_u;
+	u64 cir_s;
+	u64 cbs_s;
+};
+
 struct qm_dma {
 	void *va;
 	dma_addr_t dma;
@@ -262,6 +273,9 @@ struct hisi_qm {
 	resource_size_t db_phys_base;
 	struct uacce_device *uacce;
 	int mode;
+	struct qm_shaper_factor *factor;
+	u32 mb_qos;
+	u32 type_rate;
 };
 
 struct hisi_qp_status {
-- 
2.7.4

