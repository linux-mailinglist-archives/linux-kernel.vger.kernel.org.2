Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A47F3108E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhBEKU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:20:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12439 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhBEKOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:14:25 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DXB6h6g13zjJ6C;
        Fri,  5 Feb 2021 18:12:12 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Feb 2021
 18:13:11 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>, <wangzhou1@hisilicon.com>,
        <xuzaibo@huawei.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] crypto: hisilicon/sec - fixes some driver coding style
Date:   Fri, 5 Feb 2021 18:10:56 +0800
Message-ID: <1612519857-30714-3-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612519857-30714-1-git-send-email-liulongfang@huawei.com>
References: <1612519857-30714-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cleanup static check errors for SEC

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_main.c | 131 ++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 55 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 4809c19..65bb46a 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -35,15 +35,13 @@
 #define SEC_CTX_Q_NUM_MAX		32
 
 #define SEC_CTRL_CNT_CLR_CE		0x301120
-#define SEC_CTRL_CNT_CLR_CE_BIT		BIT(0)
-#define SEC_ENGINE_PF_CFG_OFF		0x300000
-#define SEC_ACC_COMMON_REG_OFF		0x1000
+#define SEC_CTRL_CNT_CLR_CE_BIT	BIT(0)
 #define SEC_CORE_INT_SOURCE		0x301010
 #define SEC_CORE_INT_MASK		0x301000
 #define SEC_CORE_INT_STATUS		0x301008
 #define SEC_CORE_SRAM_ECC_ERR_INFO	0x301C14
-#define SEC_ECC_NUM(err)			(((err) >> 16) & 0xFF)
-#define SEC_ECC_ADDR(err)			((err) >> 0)
+#define SEC_ECC_NUM			16
+#define SEC_ECC_MASH			0xFF
 #define SEC_CORE_INT_DISABLE		0x0
 #define SEC_CORE_INT_ENABLE		0x1ff
 #define SEC_CORE_INT_CLEAR		0x1ff
@@ -55,23 +53,23 @@
 #define SEC_RAS_CE_ENB_MSK		0x88
 #define SEC_RAS_FE_ENB_MSK		0x0
 #define SEC_RAS_NFE_ENB_MSK		0x177
-#define SEC_RAS_DISABLE			0x0
-#define SEC_MEM_START_INIT_REG		0x0100
-#define SEC_MEM_INIT_DONE_REG		0x0104
+#define SEC_RAS_DISABLE		0x0
+#define SEC_MEM_START_INIT_REG	0x301100
+#define SEC_MEM_INIT_DONE_REG		0x301104
 
-#define SEC_CONTROL_REG			0x0200
+#define SEC_CONTROL_REG		0x301200
 #define SEC_TRNG_EN_SHIFT		8
 #define SEC_CLK_GATE_ENABLE		BIT(3)
 #define SEC_CLK_GATE_DISABLE		(~BIT(3))
 #define SEC_AXI_SHUTDOWN_ENABLE	BIT(12)
 #define SEC_AXI_SHUTDOWN_DISABLE	0xFFFFEFFF
 
-#define SEC_INTERFACE_USER_CTRL0_REG	0x0220
-#define SEC_INTERFACE_USER_CTRL1_REG	0x0224
-#define SEC_SAA_EN_REG					0x0270
-#define SEC_BD_ERR_CHK_EN_REG0		0x0380
-#define SEC_BD_ERR_CHK_EN_REG1		0x0384
-#define SEC_BD_ERR_CHK_EN_REG3		0x038c
+#define SEC_INTERFACE_USER_CTRL0_REG	0x301220
+#define SEC_INTERFACE_USER_CTRL1_REG	0x301224
+#define SEC_SAA_EN_REG			0x301270
+#define SEC_BD_ERR_CHK_EN_REG0		0x301380
+#define SEC_BD_ERR_CHK_EN_REG1		0x301384
+#define SEC_BD_ERR_CHK_EN_REG3		0x30138c
 
 #define SEC_USER0_SMMU_NORMAL		(BIT(23) | BIT(15))
 #define SEC_USER1_SMMU_NORMAL		(BIT(31) | BIT(23) | BIT(15) | BIT(7))
@@ -95,9 +93,6 @@
 #define SEC_SQE_MASK_OFFSET		64
 #define SEC_SQE_MASK_LEN		48
 
-#define SEC_ADDR(qm, offset) ((qm)->io_base + (offset) + \
-			     SEC_ENGINE_PF_CFG_OFF + SEC_ACC_COMMON_REG_OFF)
-
 struct sec_hw_error {
 	u32 int_msk;
 	const char *msg;
@@ -117,16 +112,43 @@ static struct hisi_qm_list sec_devices = {
 };
 
 static const struct sec_hw_error sec_hw_errors[] = {
-	{.int_msk = BIT(0), .msg = "sec_axi_rresp_err_rint"},
-	{.int_msk = BIT(1), .msg = "sec_axi_bresp_err_rint"},
-	{.int_msk = BIT(2), .msg = "sec_ecc_2bit_err_rint"},
-	{.int_msk = BIT(3), .msg = "sec_ecc_1bit_err_rint"},
-	{.int_msk = BIT(4), .msg = "sec_req_trng_timeout_rint"},
-	{.int_msk = BIT(5), .msg = "sec_fsm_hbeat_rint"},
-	{.int_msk = BIT(6), .msg = "sec_channel_req_rng_timeout_rint"},
-	{.int_msk = BIT(7), .msg = "sec_bd_err_rint"},
-	{.int_msk = BIT(8), .msg = "sec_chain_buff_err_rint"},
-	{ /* sentinel */ }
+	{
+		.int_msk = BIT(0),
+		.msg = "sec_axi_rresp_err_rint"
+	},
+	{
+		.int_msk = BIT(1),
+		.msg = "sec_axi_bresp_err_rint"
+	},
+	{
+		.int_msk = BIT(2),
+		.msg = "sec_ecc_2bit_err_rint"
+	},
+	{
+		.int_msk = BIT(3),
+		.msg = "sec_ecc_1bit_err_rint"
+	},
+	{
+		.int_msk = BIT(4),
+		.msg = "sec_req_trng_timeout_rint"
+	},
+	{
+		.int_msk = BIT(5),
+		.msg = "sec_fsm_hbeat_rint"
+	},
+	{
+		.int_msk = BIT(6),
+		.msg = "sec_channel_req_rng_timeout_rint"
+	},
+	{
+		.int_msk = BIT(7),
+		.msg = "sec_bd_err_rint"
+	},
+	{
+		.int_msk = BIT(8),
+		.msg = "sec_chain_buff_err_rint"
+	},
+	{}
 };
 
 static const char * const sec_dbg_file_name[] = {
@@ -277,9 +299,7 @@ static u8 sec_get_endian(struct hisi_qm *qm)
 				    "cannot access a register in VF!\n");
 		return SEC_LE;
 	}
-	reg = readl_relaxed(qm->io_base + SEC_ENGINE_PF_CFG_OFF +
-			    SEC_ACC_COMMON_REG_OFF + SEC_CONTROL_REG);
-
+	reg = readl_relaxed(qm->io_base + SEC_CONTROL_REG);
 	/* BD little endian mode */
 	if (!(reg & BIT(0)))
 		return SEC_LE;
@@ -299,13 +319,13 @@ static int sec_engine_init(struct hisi_qm *qm)
 	u32 reg;
 
 	/* disable clock gate control */
-	reg = readl_relaxed(SEC_ADDR(qm, SEC_CONTROL_REG));
+	reg = readl_relaxed(qm->io_base + SEC_CONTROL_REG);
 	reg &= SEC_CLK_GATE_DISABLE;
-	writel_relaxed(reg, SEC_ADDR(qm, SEC_CONTROL_REG));
+	writel_relaxed(reg, qm->io_base + SEC_CONTROL_REG);
 
-	writel_relaxed(0x1, SEC_ADDR(qm, SEC_MEM_START_INIT_REG));
+	writel_relaxed(0x1, qm->io_base + SEC_MEM_START_INIT_REG);
 
-	ret = readl_relaxed_poll_timeout(SEC_ADDR(qm, SEC_MEM_INIT_DONE_REG),
+	ret = readl_relaxed_poll_timeout(qm->io_base + SEC_MEM_INIT_DONE_REG,
 					 reg, reg & 0x1, SEC_DELAY_10_US,
 					 SEC_POLL_TIMEOUT_US);
 	if (ret) {
@@ -313,40 +333,40 @@ static int sec_engine_init(struct hisi_qm *qm)
 		return ret;
 	}
 
-	reg = readl_relaxed(SEC_ADDR(qm, SEC_CONTROL_REG));
+	reg = readl_relaxed(qm->io_base + SEC_CONTROL_REG);
 	reg |= (0x1 << SEC_TRNG_EN_SHIFT);
-	writel_relaxed(reg, SEC_ADDR(qm, SEC_CONTROL_REG));
+	writel_relaxed(reg, qm->io_base + SEC_CONTROL_REG);
 
-	reg = readl_relaxed(SEC_ADDR(qm, SEC_INTERFACE_USER_CTRL0_REG));
+	reg = readl_relaxed(qm->io_base + SEC_INTERFACE_USER_CTRL0_REG);
 	reg |= SEC_USER0_SMMU_NORMAL;
-	writel_relaxed(reg, SEC_ADDR(qm, SEC_INTERFACE_USER_CTRL0_REG));
+	writel_relaxed(reg, qm->io_base + SEC_INTERFACE_USER_CTRL0_REG);
 
-	reg = readl_relaxed(SEC_ADDR(qm, SEC_INTERFACE_USER_CTRL1_REG));
+	reg = readl_relaxed(qm->io_base + SEC_INTERFACE_USER_CTRL1_REG);
 	reg &= SEC_USER1_SMMU_MASK;
 	if (qm->use_sva)
 		reg |= SEC_USER1_SMMU_SVA;
 	else
 		reg |= SEC_USER1_SMMU_NORMAL;
-	writel_relaxed(reg, SEC_ADDR(qm, SEC_INTERFACE_USER_CTRL1_REG));
+	writel_relaxed(reg, qm->io_base + SEC_INTERFACE_USER_CTRL1_REG);
 
 	writel(SEC_SINGLE_PORT_MAX_TRANS,
 	       qm->io_base + AM_CFG_SINGLE_PORT_MAX_TRANS);
 
-	writel(SEC_SAA_ENABLE, SEC_ADDR(qm, SEC_SAA_EN_REG));
+	writel(SEC_SAA_ENABLE, qm->io_base + SEC_SAA_EN_REG);
 
 	/* Enable sm4 extra mode, as ctr/ecb */
 	writel_relaxed(SEC_BD_ERR_CHK_EN0,
-		       SEC_ADDR(qm, SEC_BD_ERR_CHK_EN_REG0));
+		       qm->io_base + SEC_BD_ERR_CHK_EN_REG0);
 	/* Enable sm4 xts mode multiple iv */
 	writel_relaxed(SEC_BD_ERR_CHK_EN1,
-		       SEC_ADDR(qm, SEC_BD_ERR_CHK_EN_REG1));
+		       qm->io_base + SEC_BD_ERR_CHK_EN_REG1);
 	writel_relaxed(SEC_BD_ERR_CHK_EN3,
-		       SEC_ADDR(qm, SEC_BD_ERR_CHK_EN_REG3));
+		       qm->io_base + SEC_BD_ERR_CHK_EN_REG3);
 
 	/* config endian */
-	reg = readl_relaxed(SEC_ADDR(qm, SEC_CONTROL_REG));
+	reg = readl_relaxed(qm->io_base + SEC_CONTROL_REG);
 	reg |= sec_get_endian(qm);
-	writel_relaxed(reg, SEC_ADDR(qm, SEC_CONTROL_REG));
+	writel_relaxed(reg, qm->io_base + SEC_CONTROL_REG);
 
 	return 0;
 }
@@ -406,7 +426,7 @@ static void sec_hw_error_enable(struct hisi_qm *qm)
 		return;
 	}
 
-	val = readl(SEC_ADDR(qm, SEC_CONTROL_REG));
+	val = readl(qm->io_base + SEC_CONTROL_REG);
 
 	/* clear SEC hw error source if having */
 	writel(SEC_CORE_INT_CLEAR, qm->io_base + SEC_CORE_INT_SOURCE);
@@ -422,14 +442,14 @@ static void sec_hw_error_enable(struct hisi_qm *qm)
 	/* enable SEC block master OOO when m-bit error occur */
 	val = val | SEC_AXI_SHUTDOWN_ENABLE;
 
-	writel(val, SEC_ADDR(qm, SEC_CONTROL_REG));
+	writel(val, qm->io_base + SEC_CONTROL_REG);
 }
 
 static void sec_hw_error_disable(struct hisi_qm *qm)
 {
 	u32 val;
 
-	val = readl(SEC_ADDR(qm, SEC_CONTROL_REG));
+	val = readl(qm->io_base + SEC_CONTROL_REG);
 
 	/* disable RAS int */
 	writel(SEC_RAS_DISABLE, qm->io_base + SEC_RAS_CE_REG);
@@ -442,7 +462,7 @@ static void sec_hw_error_disable(struct hisi_qm *qm)
 	/* disable SEC block master OOO when m-bit error occur */
 	val = val & SEC_AXI_SHUTDOWN_DISABLE;
 
-	writel(val, SEC_ADDR(qm, SEC_CONTROL_REG));
+	writel(val, qm->io_base + SEC_CONTROL_REG);
 }
 
 static u32 sec_current_qm_read(struct sec_debug_file *file)
@@ -712,7 +732,8 @@ static void sec_log_hw_error(struct hisi_qm *qm, u32 err_sts)
 				err_val = readl(qm->io_base +
 						SEC_CORE_SRAM_ECC_ERR_INFO);
 				dev_err(dev, "multi ecc sram num=0x%x\n",
-						SEC_ECC_NUM(err_val));
+						((err_val) >> SEC_ECC_NUM) &
+						SEC_ECC_MASH);
 			}
 		}
 		errs++;
@@ -733,9 +754,9 @@ static void sec_open_axi_master_ooo(struct hisi_qm *qm)
 {
 	u32 val;
 
-	val = readl(SEC_ADDR(qm, SEC_CONTROL_REG));
-	writel(val & SEC_AXI_SHUTDOWN_DISABLE, SEC_ADDR(qm, SEC_CONTROL_REG));
-	writel(val | SEC_AXI_SHUTDOWN_ENABLE, SEC_ADDR(qm, SEC_CONTROL_REG));
+	val = readl(qm->io_base + SEC_CONTROL_REG);
+	writel(val & SEC_AXI_SHUTDOWN_DISABLE, qm->io_base + SEC_CONTROL_REG);
+	writel(val | SEC_AXI_SHUTDOWN_ENABLE, qm->io_base + SEC_CONTROL_REG);
 }
 
 static const struct hisi_qm_err_ini sec_err_ini = {
-- 
2.8.1

