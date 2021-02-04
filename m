Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F6D30EF34
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbhBDJD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:03:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12025 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbhBDJCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:02:46 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWXZc3KW7zjJnF;
        Thu,  4 Feb 2021 17:00:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 17:01:49 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <tanghui20@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] crypto: hisilicon/hpre - adapt the number of clusters
Date:   Thu, 4 Feb 2021 16:59:33 +0800
Message-ID: <1612429176-28084-2-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612429176-28084-1-git-send-email-tanghui20@huawei.com>
References: <1612429176-28084-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HPRE of Kunpeng 930 is updated on cluster numbers,
so we try to update this driver to make it running
okay on Kunpeng920/Kunpeng930 chips.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre.h      |  8 ++--
 drivers/crypto/hisilicon/hpre/hpre_main.c | 71 ++++++++++++++++++++-----------
 2 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index f69252b..181c109 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -14,8 +14,7 @@ enum {
 	HPRE_CLUSTER0,
 	HPRE_CLUSTER1,
 	HPRE_CLUSTER2,
-	HPRE_CLUSTER3,
-	HPRE_CLUSTERS_NUM,
+	HPRE_CLUSTER3
 };

 enum hpre_ctrl_dbgfs_file {
@@ -36,7 +35,10 @@ enum hpre_dfx_dbgfs_file {
 	HPRE_DFX_FILE_NUM
 };

-#define HPRE_DEBUGFS_FILE_NUM    (HPRE_DEBUG_FILE_NUM + HPRE_CLUSTERS_NUM - 1)
+#define HPRE_CLUSTERS_NUM_V2		(HPRE_CLUSTER3 + 1)
+#define HPRE_CLUSTERS_NUM_V3		1
+#define HPRE_CLUSTERS_NUM_MAX		HPRE_CLUSTERS_NUM_V2
+#define HPRE_DEBUGFS_FILE_NUM (HPRE_DEBUG_FILE_NUM + HPRE_CLUSTERS_NUM_MAX - 1)

 struct hpre_debugfs_file {
 	int index;
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 3b3481e..0045261 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -73,7 +73,8 @@
 #define HPRE_QM_AXI_CFG_MASK		0xffff
 #define HPRE_QM_VFG_AX_MASK		0xff
 #define HPRE_BD_USR_MASK		0x3
-#define HPRE_CLUSTER_CORE_MASK		0xf
+#define HPRE_CLUSTER_CORE_MASK_V2	0xf
+#define HPRE_CLUSTER_CORE_MASK_V3	0xff

 #define HPRE_AM_OOO_SHUTDOWN_ENB	0x301044
 #define HPRE_AM_OOO_SHUTDOWN_ENABLE	BIT(0)
@@ -86,6 +87,11 @@
 #define HPRE_QM_PM_FLR			BIT(11)
 #define HPRE_QM_SRIOV_FLR		BIT(12)

+#define HPRE_CLUSTERS_NUM(qm)		\
+	(((qm)->ver >= QM_HW_V3) ? HPRE_CLUSTERS_NUM_V3 : HPRE_CLUSTERS_NUM_V2)
+#define HPRE_CLUSTER_CORE_MASK(qm)	\
+	(((qm)->ver >= QM_HW_V3) ? HPRE_CLUSTER_CORE_MASK_V3 :\
+		HPRE_CLUSTER_CORE_MASK_V2)
 #define HPRE_VIA_MSI_DSM		1
 #define HPRE_SQE_MASK_OFFSET		8
 #define HPRE_SQE_MASK_LEN		24
@@ -279,6 +285,38 @@ static int hpre_cfg_by_dsm(struct hisi_qm *qm)
 	return 0;
 }

+static int hpre_set_cluster(struct hisi_qm *qm)
+{
+	u32 cluster_core_mask = HPRE_CLUSTER_CORE_MASK(qm);
+	u8 clusters_num = HPRE_CLUSTERS_NUM(qm);
+	struct device *dev = &qm->pdev->dev;
+	unsigned long offset;
+	u32 val = 0;
+	int ret, i;
+
+	for (i = 0; i < clusters_num; i++) {
+		offset = i * HPRE_CLSTR_ADDR_INTRVL;
+
+		/* clusters initiating */
+		writel(cluster_core_mask,
+		       HPRE_ADDR(qm, offset + HPRE_CORE_ENB));
+		writel(0x1, HPRE_ADDR(qm, offset + HPRE_CORE_INI_CFG));
+		ret = readl_relaxed_poll_timeout(HPRE_ADDR(qm, offset +
+					HPRE_CORE_INI_STATUS), val,
+					((val & cluster_core_mask) ==
+					cluster_core_mask),
+					HPRE_REG_RD_INTVRL_US,
+					HPRE_REG_RD_TMOUT_US);
+		if (ret) {
+			dev_err(dev,
+				"cluster %d int st status timeout!\n", i);
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * For Hi1620, we shoul disable FLR triggered by hardware (BME/PM/SRIOV).
  * Or it may stay in D3 state when we bind and unbind hpre quickly,
@@ -298,9 +336,8 @@ static void disable_flr_of_bme(struct hisi_qm *qm)
 static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
 {
 	struct device *dev = &qm->pdev->dev;
-	unsigned long offset;
-	int ret, i;
 	u32 val;
+	int ret;

 	writel(HPRE_QM_USR_CFG_MASK, HPRE_ADDR(qm, QM_ARUSER_M_CFG_ENABLE));
 	writel(HPRE_QM_USR_CFG_MASK, HPRE_ADDR(qm, QM_AWUSER_M_CFG_ENABLE));
@@ -335,25 +372,9 @@ static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
 		return -ETIMEDOUT;
 	}

-	for (i = 0; i < HPRE_CLUSTERS_NUM; i++) {
-		offset = i * HPRE_CLSTR_ADDR_INTRVL;
-
-		/* clusters initiating */
-		writel(HPRE_CLUSTER_CORE_MASK,
-		       HPRE_ADDR(qm, offset + HPRE_CORE_ENB));
-		writel(0x1, HPRE_ADDR(qm, offset + HPRE_CORE_INI_CFG));
-		ret = readl_relaxed_poll_timeout(HPRE_ADDR(qm, offset +
-					HPRE_CORE_INI_STATUS), val,
-					((val & HPRE_CLUSTER_CORE_MASK) ==
-					HPRE_CLUSTER_CORE_MASK),
-					HPRE_REG_RD_INTVRL_US,
-					HPRE_REG_RD_TMOUT_US);
-		if (ret) {
-			dev_err(dev,
-				"cluster %d int st status timeout!\n", i);
-			return -ETIMEDOUT;
-		}
-	}
+	ret = hpre_set_cluster(qm);
+	if (ret)
+		return -ETIMEDOUT;

 	ret = hpre_cfg_by_dsm(qm);
 	if (ret)
@@ -366,6 +387,7 @@ static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)

 static void hpre_cnt_regs_clear(struct hisi_qm *qm)
 {
+	u8 clusters_num = HPRE_CLUSTERS_NUM(qm);
 	unsigned long offset;
 	int i;

@@ -374,7 +396,7 @@ static void hpre_cnt_regs_clear(struct hisi_qm *qm)
 	writel(0x0, qm->io_base + QM_DFX_DB_CNT_VF);

 	/* clear clusterX/cluster_ctrl */
-	for (i = 0; i < HPRE_CLUSTERS_NUM; i++) {
+	for (i = 0; i < clusters_num; i++) {
 		offset = HPRE_CLSTR_BASE + i * HPRE_CLSTR_ADDR_INTRVL;
 		writel(0x0, qm->io_base + offset + HPRE_CLUSTER_INQURY);
 	}
@@ -673,13 +695,14 @@ static int hpre_pf_comm_regs_debugfs_init(struct hisi_qm *qm)

 static int hpre_cluster_debugfs_init(struct hisi_qm *qm)
 {
+	u8 clusters_num = HPRE_CLUSTERS_NUM(qm);
 	struct device *dev = &qm->pdev->dev;
 	char buf[HPRE_DBGFS_VAL_MAX_LEN];
 	struct debugfs_regset32 *regset;
 	struct dentry *tmp_d;
 	int i, ret;

-	for (i = 0; i < HPRE_CLUSTERS_NUM; i++) {
+	for (i = 0; i < clusters_num; i++) {
 		ret = snprintf(buf, HPRE_DBGFS_VAL_MAX_LEN, "cluster%d", i);
 		if (ret < 0)
 			return -EINVAL;
--
2.8.1

