Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE23A3817C1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 12:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhEOKt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 06:49:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3696 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhEOKtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 06:49:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fj28p2BYDz16QDM;
        Sat, 15 May 2021 18:44:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 15 May 2021 18:47:35 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <liulongfang@huawei.com>
Subject: [PATCH 3/4] crypto: hisilicon/qm - adjust order of device error configuration
Date:   Sat, 15 May 2021 18:44:39 +0800
Message-ID: <1621075480-52869-4-git-send-email-qianweili@huawei.com>
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

In order to avoid reporting an exception but the error type is not
configured, the driver needs to configure the error type first, and then
enable the error interrupt. Before executing the task, hardware error
initialization is needed so that the hardware can detect the error in time.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c |  6 ++++--
 drivers/crypto/hisilicon/qm.c             |  2 +-
 drivers/crypto/hisilicon/sec2/sec_main.c  | 24 ++++++++++--------------
 drivers/crypto/hisilicon/zip/zip_main.c   |  6 +++---
 4 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 046bc96..0ba43515 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -433,8 +433,7 @@ static void hpre_hw_error_enable(struct hisi_qm *qm)
 	/* clear HPRE hw error source if having */
 	writel(HPRE_CORE_INT_DISABLE, qm->io_base + HPRE_HAC_SOURCE_INT);
 
-	/* enable hpre hw error interrupts */
-	writel(HPRE_CORE_INT_ENABLE, qm->io_base + HPRE_INT_MASK);
+	/* configure error type */
 	writel(HPRE_HAC_RAS_CE_ENABLE, qm->io_base + HPRE_RAS_CE_ENB);
 	writel(HPRE_HAC_RAS_NFE_ENABLE, qm->io_base + HPRE_RAS_NFE_ENB);
 	writel(HPRE_HAC_RAS_FE_ENABLE, qm->io_base + HPRE_RAS_FE_ENB);
@@ -443,6 +442,9 @@ static void hpre_hw_error_enable(struct hisi_qm *qm)
 	val = readl(qm->io_base + HPRE_AM_OOO_SHUTDOWN_ENB);
 	val |= HPRE_AM_OOO_SHUTDOWN_ENABLE;
 	writel(val, qm->io_base + HPRE_AM_OOO_SHUTDOWN_ENB);
+
+	/* enable hpre hw error interrupts */
+	writel(HPRE_CORE_INT_ENABLE, qm->io_base + HPRE_INT_MASK);
 }
 
 static inline struct hisi_qm *hpre_file_to_qm(struct hpre_debugfs_file *file)
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 09f0370..04c0905 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3917,6 +3917,7 @@ static int qm_controller_reset_done(struct hisi_qm *qm)
 	}
 
 	qm_restart_prepare(qm);
+	hisi_qm_dev_err_init(qm);
 
 	ret = qm_restart(qm);
 	if (ret) {
@@ -3938,7 +3939,6 @@ static int qm_controller_reset_done(struct hisi_qm *qm)
 		return -EPERM;
 	}
 
-	hisi_qm_dev_err_init(qm);
 	qm_restart_done(qm);
 
 	clear_bit(QM_RESETTING, &qm->misc_ctl);
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 6f0062d..e57167d 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -440,43 +440,39 @@ static void sec_hw_error_enable(struct hisi_qm *qm)
 		return;
 	}
 
-	val = readl(qm->io_base + SEC_CONTROL_REG);
-
 	/* clear SEC hw error source if having */
 	writel(SEC_CORE_INT_CLEAR, qm->io_base + SEC_CORE_INT_SOURCE);
 
-	/* enable SEC hw error interrupts */
-	writel(SEC_CORE_INT_ENABLE, qm->io_base + SEC_CORE_INT_MASK);
-
 	/* enable RAS int */
 	writel(SEC_RAS_CE_ENB_MSK, qm->io_base + SEC_RAS_CE_REG);
 	writel(SEC_RAS_FE_ENB_MSK, qm->io_base + SEC_RAS_FE_REG);
 	writel(SEC_RAS_NFE_ENB_MSK, qm->io_base + SEC_RAS_NFE_REG);
 
 	/* enable SEC block master OOO when m-bit error occur */
+	val = readl(qm->io_base + SEC_CONTROL_REG);
 	val = val | SEC_AXI_SHUTDOWN_ENABLE;
-
 	writel(val, qm->io_base + SEC_CONTROL_REG);
+
+	/* enable SEC hw error interrupts */
+	writel(SEC_CORE_INT_ENABLE, qm->io_base + SEC_CORE_INT_MASK);
 }
 
 static void sec_hw_error_disable(struct hisi_qm *qm)
 {
 	u32 val;
 
-	val = readl(qm->io_base + SEC_CONTROL_REG);
-
-	/* disable RAS int */
-	writel(SEC_RAS_DISABLE, qm->io_base + SEC_RAS_CE_REG);
-	writel(SEC_RAS_DISABLE, qm->io_base + SEC_RAS_FE_REG);
-	writel(SEC_RAS_DISABLE, qm->io_base + SEC_RAS_NFE_REG);
-
 	/* disable SEC hw error interrupts */
 	writel(SEC_CORE_INT_DISABLE, qm->io_base + SEC_CORE_INT_MASK);
 
 	/* disable SEC block master OOO when m-bit error occur */
+	val = readl(qm->io_base + SEC_CONTROL_REG);
 	val = val & SEC_AXI_SHUTDOWN_DISABLE;
-
 	writel(val, qm->io_base + SEC_CONTROL_REG);
+
+	/* disable RAS int */
+	writel(SEC_RAS_DISABLE, qm->io_base + SEC_RAS_CE_REG);
+	writel(SEC_RAS_DISABLE, qm->io_base + SEC_RAS_FE_REG);
+	writel(SEC_RAS_DISABLE, qm->io_base + SEC_RAS_NFE_REG);
 }
 
 static u32 sec_clear_enable_read(struct sec_debug_file *file)
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 2178b40..8e3a522 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -333,13 +333,13 @@ static void hisi_zip_hw_error_enable(struct hisi_qm *qm)
 	writel(HZIP_CORE_INT_RAS_NFE_ENABLE,
 	       qm->io_base + HZIP_CORE_INT_RAS_NFE_ENB);
 
-	/* enable ZIP hw error interrupts */
-	writel(0, qm->io_base + HZIP_CORE_INT_MASK_REG);
-
 	/* enable ZIP block master OOO when m-bit error occur */
 	val = readl(qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
 	val = val | HZIP_AXI_SHUTDOWN_ENABLE;
 	writel(val, qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
+
+	/* enable ZIP hw error interrupts */
+	writel(0, qm->io_base + HZIP_CORE_INT_MASK_REG);
 }
 
 static void hisi_zip_hw_error_disable(struct hisi_qm *qm)
-- 
2.8.1

