Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB4730AEEF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhBASRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhBASPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:13 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB14C06178C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:01 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p21so735876pld.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3osC3oDSziejkHJJ1wP12+ZD9D+IsOQLgnD9w5tLSo=;
        b=XmI4RpqF3OBMe5HxTc6r7wAz27oljyunE8/sCHbJ73GfbHL5vJG8UndJZBiXj8MDVh
         FCpuhg2yPTNw/djt0vn1ztSEjKRUxLU98H2+uedyEpTnB5YsBaBYWlDQZx34A01SxKaP
         BanMBheF4ddgLGCsCYd+MhwJ79crGLTRpsGR+xO99LGaWrHO4AG43EyTrtaRpyGS3CYr
         g62ayDbrssH/QxX6O7fr+VCBAx/XGqxUvivceNUauJrPBZa9/XigRBtlLAO4zAykZBbd
         CtPBOUQSqsf5LVgv42ESDEO/w+8kqOd5NTgCS2EcU6U9gXke5YVDTGdsF/4LsQHU04PC
         Ixag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3osC3oDSziejkHJJ1wP12+ZD9D+IsOQLgnD9w5tLSo=;
        b=M6ue6PVRpa9qXEtwGx+zMJD1Ax+8vUYz/EGC7rc1GtIzhEx+MC6kqdLfDepb9Qz/kp
         Eq3KzeJMdcjL6mW44iTRp8Nx24egDvfLeKdf/fI0ud6CnkIucxPALtxhcFxaE00a7LS8
         /0BhcV0UaQvTLqvC3MyPdgP+lAP4WAN5vn5IkJSZJyrUwNKOQnsVAwMv6ub+ofZAaR9l
         O9gWTFwCoDmdAlo6NP+iqGYarIKwETN5EqLvwAGIh6jZaMM6+7XGPQ21GEDsCTkXFN4c
         vnqZvShz/t6foTULBPD4ybZ8NFFpm3QRxrTaMYxAZm/r/RMzCSKcjzZOkiVXjLJRrC0X
         29Bg==
X-Gm-Message-State: AOAM5337QWSYoGm666kwi1QE4IQW+sRJP/UrNNEiRGZGTOcaxhWW56xd
        thdsl/8EgVm8n2TmUSNp5UHdb1TwOqNOaQ==
X-Google-Smtp-Source: ABdhPJzckXMg+RkuOTjrLPkoK8IRccYAKfq3/26RezkX88p55MmEuaGWs6hehbmle2YB39/oKFfLHA==
X-Received: by 2002:a17:90a:cf:: with SMTP id v15mr96207pjd.221.1612203240643;
        Mon, 01 Feb 2021 10:14:00 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:00 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/31] coresight: Convert coresight_timeout to use access abstraction
Date:   Mon,  1 Feb 2021 11:13:27 -0700
Message-Id: <20210201181351.1475223-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Convert the generic routines to use the new access abstraction layer
gradually, starting with coresigth_timeout.

Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-6-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-catu.c  |  5 ++--
 drivers/hwtracing/coresight/coresight-core.c  | 13 ++++----
 drivers/hwtracing/coresight/coresight-etb10.c |  5 ++--
 .../coresight/coresight-etm4x-core.c          | 30 ++++++++++++-------
 drivers/hwtracing/coresight/coresight-stm.c   |  3 +-
 .../hwtracing/coresight/coresight-tmc-core.c  | 15 ++++++----
 drivers/hwtracing/coresight/coresight-tpiu.c  |  4 +--
 include/linux/coresight.h                     | 11 +++++--
 8 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 867c932c7b26..d6097454d399 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -401,8 +401,9 @@ static const struct attribute_group *catu_groups[] = {
 
 static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
 {
-	return coresight_timeout(drvdata->base,
-				 CATU_STATUS, CATU_STATUS_READY, 1);
+	struct csdev_access *csa = &drvdata->csdev->access;
+
+	return coresight_timeout(csa, CATU_STATUS, CATU_STATUS_READY, 1);
 }
 
 static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index a38af8f0831b..74985068f325 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1418,23 +1418,24 @@ static void coresight_remove_conns(struct coresight_device *csdev)
 }
 
 /**
- * coresight_timeout - loop until a bit has changed to a specific state.
- * @addr: base address of the area of interest.
- * @offset: address of a register, starting from @addr.
+ * coresight_timeout - loop until a bit has changed to a specific register
+ *			state.
+ * @csa: coresight device access for the device
+ * @offset: Offset of the register from the base of the device.
  * @position: the position of the bit of interest.
  * @value: the value the bit should have.
  *
  * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
  * TIMEOUT_US has elapsed, which ever happens first.
  */
-
-int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
+int coresight_timeout(struct csdev_access *csa, u32 offset,
+		      int position, int value)
 {
 	int i;
 	u32 val;
 
 	for (i = TIMEOUT_US; i > 0; i--) {
-		val = __raw_readl(addr + offset);
+		val = csdev_access_read32(csa, offset);
 		/* waiting on the bit to go from 0 to 1 */
 		if (value) {
 			if (val & BIT(position))
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index cc742561a986..0f664aeeda93 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -252,6 +252,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
 {
 	u32 ffcr;
 	struct device *dev = &drvdata->csdev->dev;
+	struct csdev_access *csa = &drvdata->csdev->access;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -263,7 +264,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
 	ffcr |= ETB_FFCR_FON_MAN;
 	writel_relaxed(ffcr, drvdata->base + ETB_FFCR);
 
-	if (coresight_timeout(drvdata->base, ETB_FFCR, ETB_FFCR_BIT, 0)) {
+	if (coresight_timeout(csa, ETB_FFCR, ETB_FFCR_BIT, 0)) {
 		dev_err(dev,
 		"timeout while waiting for completion of Manual Flush\n");
 	}
@@ -271,7 +272,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
 	/* disable trace capture */
 	writel_relaxed(0x0, drvdata->base + ETB_CTL_REG);
 
-	if (coresight_timeout(drvdata->base, ETB_FFSR, ETB_FFSR_BIT, 1)) {
+	if (coresight_timeout(csa, ETB_FFSR, ETB_FFSR_BIT, 1)) {
 		dev_err(dev,
 			"timeout while waiting for Formatter to Stop\n");
 	}
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index b9e01357ffad..180bb6ed9090 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -217,7 +217,9 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i, rc;
 	struct etmv4_config *config = &drvdata->config;
-	struct device *etm_dev = &drvdata->csdev->dev;
+	struct coresight_device *csdev = drvdata->csdev;
+	struct device *etm_dev = &csdev->dev;
+	struct csdev_access *csa = &csdev->access;
 
 	CS_UNLOCK(drvdata->base);
 	etm4_enable_arch_specific(drvdata);
@@ -232,7 +234,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	writel_relaxed(0, drvdata->base + TRCPRGCTLR);
 
 	/* wait for TRCSTATR.IDLE to go up */
-	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
+	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 	if (drvdata->nr_pe)
@@ -323,7 +325,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	writel_relaxed(1, drvdata->base + TRCPRGCTLR);
 
 	/* wait for TRCSTATR.IDLE to go back down to '0' */
-	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
+	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 
@@ -587,7 +589,9 @@ static void etm4_disable_hw(void *info)
 	u32 control;
 	struct etmv4_drvdata *drvdata = info;
 	struct etmv4_config *config = &drvdata->config;
-	struct device *etm_dev = &drvdata->csdev->dev;
+	struct coresight_device *csdev = drvdata->csdev;
+	struct device *etm_dev = &csdev->dev;
+	struct csdev_access *csa = &csdev->access;
 	int i;
 
 	CS_UNLOCK(drvdata->base);
@@ -615,8 +619,7 @@ static void etm4_disable_hw(void *info)
 	writel_relaxed(control, drvdata->base + TRCPRGCTLR);
 
 	/* wait for TRCSTATR.PMSTABLE to go to '1' */
-	if (coresight_timeout(drvdata->base, TRCSTATR,
-			      TRCSTATR_PMSTABLE_BIT, 1))
+	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for PM stable Trace Status\n");
 
@@ -1272,7 +1275,15 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 {
 	int i, ret = 0;
 	struct etmv4_save_state *state;
-	struct device *etm_dev = &drvdata->csdev->dev;
+	struct coresight_device *csdev = drvdata->csdev;
+	struct csdev_access *csa;
+	struct device *etm_dev;
+
+	if (WARN_ON(!csdev))
+		return -ENODEV;
+
+	etm_dev = &csdev->dev;
+	csa = &csdev->access;
 
 	/*
 	 * As recommended by 3.4.1 ("The procedure when powering down the PE")
@@ -1287,8 +1298,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	etm4_os_lock(drvdata);
 
 	/* wait for TRCSTATR.PMSTABLE to go up */
-	if (coresight_timeout(drvdata->base, TRCSTATR,
-			      TRCSTATR_PMSTABLE_BIT, 1)) {
+	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1)) {
 		dev_err(etm_dev,
 			"timeout while waiting for PM Stable Status\n");
 		etm4_os_unlock(drvdata);
@@ -1377,7 +1387,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		state->trcpdcr = readl(drvdata->base + TRCPDCR);
 
 	/* wait for TRCSTATR.IDLE to go up */
-	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
+	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 		etm4_os_unlock(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 41d9a922c2d4..5927316d7a03 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -258,6 +258,7 @@ static void stm_disable(struct coresight_device *csdev,
 			struct perf_event *event)
 {
 	struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct csdev_access *csa = &csdev->access;
 
 	/*
 	 * For as long as the tracer isn't disabled another entity can't
@@ -270,7 +271,7 @@ static void stm_disable(struct coresight_device *csdev,
 		spin_unlock(&drvdata->spinlock);
 
 		/* Wait until the engine has completely stopped */
-		coresight_timeout(drvdata->base, STMTCSR, STMTCSR_BUSY_BIT, 0);
+		coresight_timeout(csa, STMTCSR, STMTCSR_BUSY_BIT, 0);
 
 		pm_runtime_put(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index e61b75be66b6..4dc1ea2c19b5 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -33,16 +33,20 @@ DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
 
 void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
 {
+	struct coresight_device *csdev = drvdata->csdev;
+	struct csdev_access *csa = &csdev->access;
+
 	/* Ensure formatter, unformatter and hardware fifo are empty */
-	if (coresight_timeout(drvdata->base,
-			      TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
-		dev_err(&drvdata->csdev->dev,
+	if (coresight_timeout(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
+		dev_err(&csdev->dev,
 			"timeout while waiting for TMC to be Ready\n");
 	}
 }
 
 void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
 {
+	struct coresight_device *csdev = drvdata->csdev;
+	struct csdev_access *csa = &csdev->access;
 	u32 ffcr;
 
 	ffcr = readl_relaxed(drvdata->base + TMC_FFCR);
@@ -51,9 +55,8 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
 	ffcr |= BIT(TMC_FFCR_FLUSHMAN_BIT);
 	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
 	/* Ensure flush completes */
-	if (coresight_timeout(drvdata->base,
-			      TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
-		dev_err(&drvdata->csdev->dev,
+	if (coresight_timeout(csa, TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
+		dev_err(&csdev->dev,
 		"timeout while waiting for completion of Manual Flush\n");
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index a12b6ee0a576..2ec057892799 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -86,9 +86,9 @@ static void tpiu_disable_hw(struct csdev_access *csa)
 	/* Generate manual flush */
 	csdev_access_relaxed_write32(csa, FFCR_STOP_FI | FFCR_FON_MAN, TPIU_FFCR);
 	/* Wait for flush to complete */
-	coresight_timeout(csa->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
+	coresight_timeout(csa, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
 	/* Wait for formatter to stop */
-	coresight_timeout(csa->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
+	coresight_timeout(csa, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
 
 	CS_LOCK(csa->base);
 }
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 6107cf4021d3..18bc7f9fb041 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -460,7 +460,7 @@ coresight_register(struct coresight_desc *desc);
 extern void coresight_unregister(struct coresight_device *csdev);
 extern int coresight_enable(struct coresight_device *csdev);
 extern void coresight_disable(struct coresight_device *csdev);
-extern int coresight_timeout(void __iomem *addr, u32 offset,
+extern int coresight_timeout(struct csdev_access *csa, u32 offset,
 			     int position, int value);
 
 extern int coresight_claim_device(void __iomem *base);
@@ -491,8 +491,13 @@ static inline void coresight_unregister(struct coresight_device *csdev) {}
 static inline int
 coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
 static inline void coresight_disable(struct coresight_device *csdev) {}
-static inline int coresight_timeout(void __iomem *addr, u32 offset,
-				     int position, int value) { return 1; }
+
+static inline int coresight_timeout(struct csdev_access *csa, u32 offset,
+				    int position, int value)
+{
+	return 1;
+}
+
 static inline int coresight_claim_device_unlocked(void __iomem *base)
 {
 	return -EINVAL;
-- 
2.25.1

