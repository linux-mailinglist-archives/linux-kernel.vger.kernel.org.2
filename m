Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB783817C4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 12:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhEOKuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 06:50:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3697 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhEOKtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 06:49:18 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fj28v1wN8z16QDk;
        Sat, 15 May 2021 18:45:03 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 15 May 2021 18:47:35 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <liulongfang@huawei.com>
Subject: [PATCH 4/4] crypto: hisilicon/qm - enable to close master ooo when NFE occurs
Date:   Sat, 15 May 2021 18:44:40 +0800
Message-ID: <1621075480-52869-5-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1621075480-52869-1-git-send-email-qianweili@huawei.com>
References: <1621075480-52869-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kunpeng930 could be able to close master ooo when NFE occurs, which will
disable memory accessing from device and execute tasks. This ensures that
errors do not spread.

This patch enables the hardware to close master ooo when an error occurs
by writing hardware registers, and ensures that the driver will not drain
qp because the hardware will empty the tasks automatically.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c |  36 ++++++---
 drivers/crypto/hisilicon/qm.c             | 118 ++++++++++++++++++++----------
 drivers/crypto/hisilicon/sec2/sec_main.c  |  36 ++++++---
 drivers/crypto/hisilicon/zip/zip_main.c   |  36 ++++++---
 4 files changed, 150 insertions(+), 76 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 0ba43515..95c7ee3 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -50,6 +50,7 @@
 #define HPRE_RAS_NFE_ENB		0x301414
 #define HPRE_HAC_RAS_NFE_ENABLE		0x3ffffe
 #define HPRE_RAS_FE_ENB			0x301418
+#define HPRE_OOO_SHUTDOWN_SEL		0x301a3c
 #define HPRE_HAC_RAS_FE_ENABLE		0
 
 #define HPRE_CORE_ENB		(HPRE_CLSTR_BASE + HPRE_CORE_EN_OFFSET)
@@ -413,23 +414,36 @@ static void hpre_cnt_regs_clear(struct hisi_qm *qm)
 	hisi_qm_debug_regs_clear(qm);
 }
 
-static void hpre_hw_error_disable(struct hisi_qm *qm)
+static void hpre_master_ooo_ctrl(struct hisi_qm *qm, bool enable)
 {
-	u32 val;
+	u32 val1, val2;
+
+	val1 = readl(qm->io_base + HPRE_AM_OOO_SHUTDOWN_ENB);
+	if (enable) {
+		val1 |= HPRE_AM_OOO_SHUTDOWN_ENABLE;
+		val2 = HPRE_HAC_RAS_NFE_ENABLE;
+	} else {
+		val1 &= ~HPRE_AM_OOO_SHUTDOWN_ENABLE;
+		val2 = 0x0;
+	}
+
+	if (qm->ver > QM_HW_V2)
+		writel(val2, qm->io_base + HPRE_OOO_SHUTDOWN_SEL);
 
+	writel(val1, qm->io_base + HPRE_AM_OOO_SHUTDOWN_ENB);
+}
+
+static void hpre_hw_error_disable(struct hisi_qm *qm)
+{
 	/* disable hpre hw error interrupts */
 	writel(HPRE_CORE_INT_DISABLE, qm->io_base + HPRE_INT_MASK);
 
-	/* disable HPRE block master OOO when m-bit error occur */
-	val = readl(qm->io_base + HPRE_AM_OOO_SHUTDOWN_ENB);
-	val &= ~HPRE_AM_OOO_SHUTDOWN_ENABLE;
-	writel(val, qm->io_base + HPRE_AM_OOO_SHUTDOWN_ENB);
+	/* disable HPRE block master OOO when nfe occurs on Kunpeng930 */
+	hpre_master_ooo_ctrl(qm, false);
 }
 
 static void hpre_hw_error_enable(struct hisi_qm *qm)
 {
-	u32 val;
-
 	/* clear HPRE hw error source if having */
 	writel(HPRE_CORE_INT_DISABLE, qm->io_base + HPRE_HAC_SOURCE_INT);
 
@@ -438,10 +452,8 @@ static void hpre_hw_error_enable(struct hisi_qm *qm)
 	writel(HPRE_HAC_RAS_NFE_ENABLE, qm->io_base + HPRE_RAS_NFE_ENB);
 	writel(HPRE_HAC_RAS_FE_ENABLE, qm->io_base + HPRE_RAS_FE_ENB);
 
-	/* enable HPRE block master OOO when m-bit error occur */
-	val = readl(qm->io_base + HPRE_AM_OOO_SHUTDOWN_ENB);
-	val |= HPRE_AM_OOO_SHUTDOWN_ENABLE;
-	writel(val, qm->io_base + HPRE_AM_OOO_SHUTDOWN_ENB);
+	/* enable HPRE block master OOO when nfe occurs on Kunpeng930 */
+	hpre_master_ooo_ctrl(qm, true);
 
 	/* enable hpre hw error interrupts */
 	writel(HPRE_CORE_INT_ENABLE, qm->io_base + HPRE_INT_MASK);
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 04c0905..8f7ea50 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -155,6 +155,7 @@
 #define QM_RAS_CE_THRESHOLD		0x1000f8
 #define QM_RAS_CE_TIMES_PER_IRQ		1
 #define QM_RAS_MSI_INT_SEL		0x1040f4
+#define QM_OOO_SHUTDOWN_SEL		0x1040f8
 
 #define QM_RESET_WAIT_TIMEOUT		400
 #define QM_PEH_VENDOR_ID		0x1000d8
@@ -1623,13 +1624,9 @@ static void qm_hw_error_init_v1(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe)
 	writel(QM_ABNORMAL_INT_MASK_VALUE, qm->io_base + QM_ABNORMAL_INT_MASK);
 }
 
-static void qm_hw_error_init_v2(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe)
+static void qm_hw_error_cfg(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe)
 {
-	u32 irq_enable = ce | nfe | fe;
-	u32 irq_unmask = ~irq_enable;
-
 	qm->error_mask = ce | nfe | fe;
-
 	/* clear QM hw residual error source */
 	writel(QM_ABNORMAL_INT_SOURCE_CLR,
 	       qm->io_base + QM_ABNORMAL_INT_SOURCE);
@@ -1639,6 +1636,14 @@ static void qm_hw_error_init_v2(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe)
 	writel(QM_RAS_CE_TIMES_PER_IRQ, qm->io_base + QM_RAS_CE_THRESHOLD);
 	writel(nfe, qm->io_base + QM_RAS_NFE_ENABLE);
 	writel(fe, qm->io_base + QM_RAS_FE_ENABLE);
+}
+
+static void qm_hw_error_init_v2(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe)
+{
+	u32 irq_enable = ce | nfe | fe;
+	u32 irq_unmask = ~irq_enable;
+
+	qm_hw_error_cfg(qm, ce, nfe, fe);
 
 	irq_unmask &= readl(qm->io_base + QM_ABNORMAL_INT_MASK);
 	writel(irq_unmask, qm->io_base + QM_ABNORMAL_INT_MASK);
@@ -1649,6 +1654,28 @@ static void qm_hw_error_uninit_v2(struct hisi_qm *qm)
 	writel(QM_ABNORMAL_INT_MASK_VALUE, qm->io_base + QM_ABNORMAL_INT_MASK);
 }
 
+static void qm_hw_error_init_v3(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe)
+{
+	u32 irq_enable = ce | nfe | fe;
+	u32 irq_unmask = ~irq_enable;
+
+	qm_hw_error_cfg(qm, ce, nfe, fe);
+
+	/* enable close master ooo when hardware error happened */
+	writel(nfe & (~QM_DB_RANDOM_INVALID), qm->io_base + QM_OOO_SHUTDOWN_SEL);
+
+	irq_unmask &= readl(qm->io_base + QM_ABNORMAL_INT_MASK);
+	writel(irq_unmask, qm->io_base + QM_ABNORMAL_INT_MASK);
+}
+
+static void qm_hw_error_uninit_v3(struct hisi_qm *qm)
+{
+	writel(QM_ABNORMAL_INT_MASK_VALUE, qm->io_base + QM_ABNORMAL_INT_MASK);
+
+	/* disable close master ooo when hardware error happened */
+	writel(0x0, qm->io_base + QM_OOO_SHUTDOWN_SEL);
+}
+
 static void qm_log_hw_error(struct hisi_qm *qm, u32 error_status)
 {
 	const struct hisi_qm_hw_error *err;
@@ -1715,6 +1742,35 @@ static enum acc_err_result qm_hw_error_handle_v2(struct hisi_qm *qm)
 	return ACC_ERR_RECOVERED;
 }
 
+static u32 qm_get_hw_error_status(struct hisi_qm *qm)
+{
+	return readl(qm->io_base + QM_ABNORMAL_INT_STATUS);
+}
+
+static u32 qm_get_dev_err_status(struct hisi_qm *qm)
+{
+	return qm->err_ini->get_dev_hw_err_status(qm);
+}
+
+/* Check if the error causes the master ooo block */
+static int qm_check_dev_error(struct hisi_qm *qm)
+{
+	u32 val, dev_val;
+
+	if (qm->fun_type == QM_HW_VF)
+		return 0;
+
+	val = qm_get_hw_error_status(qm);
+	dev_val = qm_get_dev_err_status(qm);
+
+	if (qm->ver < QM_HW_V3)
+		return (val & QM_ECC_MBIT) ||
+		       (dev_val & qm->err_info.ecc_2bits_mask);
+
+	return (val & readl(qm->io_base + QM_OOO_SHUTDOWN_SEL)) ||
+	       (dev_val & (~qm->err_info.dev_ce_mask));
+}
+
 static int qm_stop_qp(struct hisi_qp *qp)
 {
 	return qm_mb(qp->qm, QM_MB_CMD_STOP_QP, 0, qp->qp_id, 0);
@@ -1739,8 +1795,8 @@ static const struct hisi_qm_hw_ops qm_hw_ops_v3 = {
 	.get_vft = qm_get_vft_v2,
 	.qm_db = qm_db_v2,
 	.get_irq_num = qm_get_irq_num_v2,
-	.hw_error_init = qm_hw_error_init_v2,
-	.hw_error_uninit = qm_hw_error_uninit_v2,
+	.hw_error_init = qm_hw_error_init_v3,
+	.hw_error_uninit = qm_hw_error_uninit_v3,
 	.hw_error_handle = qm_hw_error_handle_v2,
 	.stop_qp = qm_stop_qp,
 };
@@ -2017,11 +2073,8 @@ static int qm_drain_qp(struct hisi_qp *qp)
 	int ret = 0, i = 0;
 	void *addr;
 
-	/*
-	 * No need to judge if ECC multi-bit error occurs because the
-	 * master OOO will be blocked.
-	 */
-	if (qm->err_status.is_qm_ecc_mbit || qm->err_status.is_dev_ecc_mbit)
+	/* No need to judge if master OOO is blocked. */
+	if (qm_check_dev_error(qm))
 		return 0;
 
 	/* Kunpeng930 supports drain qp by device */
@@ -3527,11 +3580,6 @@ pci_ers_result_t hisi_qm_dev_err_detected(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_GPL(hisi_qm_dev_err_detected);
 
-static u32 qm_get_hw_error_status(struct hisi_qm *qm)
-{
-	return readl(qm->io_base + QM_ABNORMAL_INT_STATUS);
-}
-
 static int qm_check_req_recv(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -3712,6 +3760,10 @@ static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
 {
 	u32 nfe_enb = 0;
 
+	/* Kunpeng930 hardware automatically close master ooo when NFE occurs */
+	if (qm->ver >= QM_HW_V3)
+		return;
+
 	if (!qm->err_status.is_dev_ecc_mbit &&
 	    qm->err_status.is_qm_ecc_mbit &&
 	    qm->err_ini->close_axi_master_ooo) {
@@ -3830,11 +3882,6 @@ static int qm_vf_reset_done(struct hisi_qm *qm)
 	return ret;
 }
 
-static u32 qm_get_dev_err_status(struct hisi_qm *qm)
-{
-	return qm->err_ini->get_dev_hw_err_status(qm);
-}
-
 static int qm_dev_hw_init(struct hisi_qm *qm)
 {
 	return qm->err_ini->hw_init(qm);
@@ -3844,6 +3891,9 @@ static void qm_restart_prepare(struct hisi_qm *qm)
 {
 	u32 value;
 
+	if (qm->ver >= QM_HW_V3)
+		return;
+
 	if (!qm->err_status.is_qm_ecc_mbit &&
 	    !qm->err_status.is_dev_ecc_mbit)
 		return;
@@ -3863,15 +3913,15 @@ static void qm_restart_prepare(struct hisi_qm *qm)
 
 	/* clear AM Reorder Buffer ecc mbit source */
 	writel(ACC_ROB_ECC_ERR_MULTPL, qm->io_base + ACC_AM_ROB_ECC_INT_STS);
-
-	if (qm->err_ini->open_axi_master_ooo)
-		qm->err_ini->open_axi_master_ooo(qm);
 }
 
 static void qm_restart_done(struct hisi_qm *qm)
 {
 	u32 value;
 
+	if (qm->ver >= QM_HW_V3)
+		goto clear_flags;
+
 	if (!qm->err_status.is_qm_ecc_mbit &&
 	    !qm->err_status.is_dev_ecc_mbit)
 		return;
@@ -3881,6 +3931,7 @@ static void qm_restart_done(struct hisi_qm *qm)
 	value |= qm->err_info.msi_wr_port;
 	writel(value, qm->io_base + ACC_AM_CFG_PORT_WR_EN);
 
+clear_flags:
 	qm->err_status.is_qm_ecc_mbit = false;
 	qm->err_status.is_dev_ecc_mbit = false;
 }
@@ -3918,6 +3969,8 @@ static int qm_controller_reset_done(struct hisi_qm *qm)
 
 	qm_restart_prepare(qm);
 	hisi_qm_dev_err_init(qm);
+	if (qm->err_ini->open_axi_master_ooo)
+		qm->err_ini->open_axi_master_ooo(qm);
 
 	ret = qm_restart(qm);
 	if (ret) {
@@ -4005,21 +4058,6 @@ pci_ers_result_t hisi_qm_dev_slot_reset(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(hisi_qm_dev_slot_reset);
 
-/* check the interrupt is ecc-mbit error or not */
-static int qm_check_dev_error(struct hisi_qm *qm)
-{
-	int ret;
-
-	if (qm->fun_type == QM_HW_VF)
-		return 0;
-
-	ret = qm_get_hw_error_status(qm) & QM_ECC_MBIT;
-	if (ret)
-		return ret;
-
-	return (qm_get_dev_err_status(qm) & qm->err_info.ecc_2bits_mask);
-}
-
 void hisi_qm_reset_prepare(struct pci_dev *pdev)
 {
 	struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(pdev));
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index e57167d..6a4408e 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -52,6 +52,7 @@
 #define SEC_RAS_CE_ENB_MSK		0x88
 #define SEC_RAS_FE_ENB_MSK		0x0
 #define SEC_RAS_NFE_ENB_MSK		0x7c177
+#define SEC_OOO_SHUTDOWN_SEL		0x301014
 #define SEC_RAS_DISABLE		0x0
 #define SEC_MEM_START_INIT_REG	0x301100
 #define SEC_MEM_INIT_DONE_REG		0x301104
@@ -430,10 +431,27 @@ static void sec_debug_regs_clear(struct hisi_qm *qm)
 	hisi_qm_debug_regs_clear(qm);
 }
 
-static void sec_hw_error_enable(struct hisi_qm *qm)
+static void sec_master_ooo_ctrl(struct hisi_qm *qm, bool enable)
 {
-	u32 val;
+	u32 val1, val2;
+
+	val1 = readl(qm->io_base + SEC_CONTROL_REG);
+	if (enable) {
+		val1 |= SEC_AXI_SHUTDOWN_ENABLE;
+		val2 = SEC_RAS_NFE_ENB_MSK;
+	} else {
+		val1 &= SEC_AXI_SHUTDOWN_DISABLE;
+		val2 = 0x0;
+	}
+
+	if (qm->ver > QM_HW_V2)
+		writel(val2, qm->io_base + SEC_OOO_SHUTDOWN_SEL);
+
+	writel(val1, qm->io_base + SEC_CONTROL_REG);
+}
 
+static void sec_hw_error_enable(struct hisi_qm *qm)
+{
 	if (qm->ver == QM_HW_V1) {
 		writel(SEC_CORE_INT_DISABLE, qm->io_base + SEC_CORE_INT_MASK);
 		pci_info(qm->pdev, "V1 not support hw error handle\n");
@@ -448,10 +466,8 @@ static void sec_hw_error_enable(struct hisi_qm *qm)
 	writel(SEC_RAS_FE_ENB_MSK, qm->io_base + SEC_RAS_FE_REG);
 	writel(SEC_RAS_NFE_ENB_MSK, qm->io_base + SEC_RAS_NFE_REG);
 
-	/* enable SEC block master OOO when m-bit error occur */
-	val = readl(qm->io_base + SEC_CONTROL_REG);
-	val = val | SEC_AXI_SHUTDOWN_ENABLE;
-	writel(val, qm->io_base + SEC_CONTROL_REG);
+	/* enable SEC block master OOO when nfe occurs on Kunpeng930 */
+	sec_master_ooo_ctrl(qm, true);
 
 	/* enable SEC hw error interrupts */
 	writel(SEC_CORE_INT_ENABLE, qm->io_base + SEC_CORE_INT_MASK);
@@ -459,15 +475,11 @@ static void sec_hw_error_enable(struct hisi_qm *qm)
 
 static void sec_hw_error_disable(struct hisi_qm *qm)
 {
-	u32 val;
-
 	/* disable SEC hw error interrupts */
 	writel(SEC_CORE_INT_DISABLE, qm->io_base + SEC_CORE_INT_MASK);
 
-	/* disable SEC block master OOO when m-bit error occur */
-	val = readl(qm->io_base + SEC_CONTROL_REG);
-	val = val & SEC_AXI_SHUTDOWN_DISABLE;
-	writel(val, qm->io_base + SEC_CONTROL_REG);
+	/* disable SEC block master OOO when nfe occurs on Kunpeng930 */
+	sec_master_ooo_ctrl(qm, false);
 
 	/* disable RAS int */
 	writel(SEC_RAS_DISABLE, qm->io_base + SEC_RAS_CE_REG);
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 8e3a522..3e23f2a 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -68,6 +68,7 @@
 #define HZIP_CORE_INT_RAS_CE_ENABLE	0x1
 #define HZIP_CORE_INT_RAS_NFE_ENB	0x301164
 #define HZIP_CORE_INT_RAS_FE_ENB        0x301168
+#define HZIP_OOO_SHUTDOWN_SEL		0x30120C
 #define HZIP_CORE_INT_RAS_NFE_ENABLE	0x1FFE
 #define HZIP_SRAM_ECC_ERR_NUM_SHIFT	16
 #define HZIP_SRAM_ECC_ERR_ADDR_SHIFT	24
@@ -312,10 +313,27 @@ static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 	return 0;
 }
 
-static void hisi_zip_hw_error_enable(struct hisi_qm *qm)
+static void hisi_zip_master_ooo_ctrl(struct hisi_qm *qm, bool enable)
 {
-	u32 val;
+	u32 val1, val2;
+
+	val1 = readl(qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
+	if (enable) {
+		val1 |= HZIP_AXI_SHUTDOWN_ENABLE;
+		val2 = HZIP_CORE_INT_RAS_NFE_ENABLE;
+	} else {
+		val1 &= ~HZIP_AXI_SHUTDOWN_ENABLE;
+		val2 = 0x0;
+	}
+
+	if (qm->ver > QM_HW_V2)
+		writel(val2, qm->io_base + HZIP_OOO_SHUTDOWN_SEL);
+
+	writel(val1, qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
+}
 
+static void hisi_zip_hw_error_enable(struct hisi_qm *qm)
+{
 	if (qm->ver == QM_HW_V1) {
 		writel(HZIP_CORE_INT_MASK_ALL,
 		       qm->io_base + HZIP_CORE_INT_MASK_REG);
@@ -333,10 +351,8 @@ static void hisi_zip_hw_error_enable(struct hisi_qm *qm)
 	writel(HZIP_CORE_INT_RAS_NFE_ENABLE,
 	       qm->io_base + HZIP_CORE_INT_RAS_NFE_ENB);
 
-	/* enable ZIP block master OOO when m-bit error occur */
-	val = readl(qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
-	val = val | HZIP_AXI_SHUTDOWN_ENABLE;
-	writel(val, qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
+	/* enable ZIP block master OOO when nfe occurs on Kunpeng930 */
+	hisi_zip_master_ooo_ctrl(qm, true);
 
 	/* enable ZIP hw error interrupts */
 	writel(0, qm->io_base + HZIP_CORE_INT_MASK_REG);
@@ -344,15 +360,11 @@ static void hisi_zip_hw_error_enable(struct hisi_qm *qm)
 
 static void hisi_zip_hw_error_disable(struct hisi_qm *qm)
 {
-	u32 val;
-
 	/* disable ZIP hw error interrupts */
 	writel(HZIP_CORE_INT_MASK_ALL, qm->io_base + HZIP_CORE_INT_MASK_REG);
 
-	/* disable ZIP block master OOO when m-bit error occur */
-	val = readl(qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
-	val = val & ~HZIP_AXI_SHUTDOWN_ENABLE;
-	writel(val, qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
+	/* disable ZIP block master OOO when nfe occurs on Kunpeng930 */
+	hisi_zip_master_ooo_ctrl(qm, false);
 }
 
 static inline struct hisi_qm *file_to_qm(struct ctrl_debug_file *file)
-- 
2.8.1

