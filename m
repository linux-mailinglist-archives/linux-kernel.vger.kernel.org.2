Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E8A30AEF5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhBASTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbhBASP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:29 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6204CC0612F2
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:13 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m12so75976pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cry816/nSGJZaakAE5oUCDuh5GR8b59TtsUrvCCp4xM=;
        b=MEvx6jXdM8va8vSZnJhFkcQgtBPM0HbCoiQnPaLm2SvZgrMCg26IdQEM6jcA9jO+NF
         aSvrDFmHTRYIYIFht6kA1KdHktDn60vo1l1tnWHAPZ8RMdOHDIZOtgxHSxmUWq19QDDR
         gy7DB2sBjKpaCFvrz/D1LqZFxKrAC0bt7A+8PjZXJC1UwUukK04JGK+mLug7ZlShncTc
         k/KppVrz/BTAQ3l5FbpwYgPo7CepiODvBWgPlphEogi1Jc0NcR+SpmZ9d8LTIdm4uWBQ
         18r4ZckVhceZGAzvBdLwyYmy7qslldy2RM4kpp/viZTBsdbCR5PV7wq3WthCTrs9ubEa
         fyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cry816/nSGJZaakAE5oUCDuh5GR8b59TtsUrvCCp4xM=;
        b=orUTEL1ffvVkA3wC6Gnw4Z3/sVRRAGBR+6aIWbkbFBZGRpndg+z+foCKQVM6bTprCe
         PoLImuMvsQECa+0ySCVkN/eaQhmOcUhS8TVaguJo5LpyRKJIdSsuR/IHwaBNxVK2iCf1
         toi+wZxScRtu7Xh5QHzTUFhF90YQi5skFnN8pf1p3o0GFRU/e8O3cTPunaVHuIBYmjsb
         N+wlXYs+uy6MNhY0qcItN2QoslcEAPzzbjNLMD4FyV2I12ma9thEBlqVMIu0DuDU3Tjq
         RrbYUtHc1mDX6xYSTjTcNdOqIogx1icsUz/TrtUZQHEgAqUieXhAA4rPqO3MLLYH5AMY
         bJ1g==
X-Gm-Message-State: AOAM532uHnilukvafwT12C2zet+hR2tq8r663AFaoh0Ivm0jbbY+1GQ0
        m3hU+9RQys59T5fiPtpnf0bnLg==
X-Google-Smtp-Source: ABdhPJzU1zYTOVaXWXqw4dMF6ou0XXtlAyHt0WeOq2zwKSe/eWlmQaAdrVBUYBpRjQBKXTT/C/lM1Q==
X-Received: by 2002:a17:902:ea0f:b029:de:5fd5:abb9 with SMTP id s15-20020a170902ea0fb02900de5fd5abb9mr18746751plg.46.1612203252860;
        Mon, 01 Feb 2021 10:14:12 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:12 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/31] coresight: etm4x: Clean up exception level masks
Date:   Mon,  1 Feb 2021 11:13:38 -0700
Message-Id: <20210201181351.1475223-19-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

etm4_get_access_type() calculates the exception level bits
for use in address comparator registers. This is also used
by the TRCVICTLR register by shifting to the required position.

This patch cleans up the logic to make etm4_get_access_type()
calculate a generic mask which can be used by all users by
shifting to their field.

No functional changes intended.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-17-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          | 47 +++++++++----------
 .../coresight/coresight-etm4x-sysfs.c         | 12 ++---
 drivers/hwtracing/coresight/coresight-etm4x.h | 47 ++++++++++++-------
 3 files changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index d91b259a4334..c9fcb17968a0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -959,20 +959,16 @@ static void etm4_init_arch_data(void *info)
 	etm4_cs_lock(drvdata, csa);
 }
 
+static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
+{
+	return etm4_get_access_type(config) << TRCVICTLR_EXLEVEL_SHIFT;
+}
+
 /* Set ELx trace filter access in the TRCVICTLR register */
 static void etm4_set_victlr_access(struct etmv4_config *config)
 {
-	u64 access_type;
-
-	config->vinst_ctrl &= ~(ETM_EXLEVEL_S_VICTLR_MASK | ETM_EXLEVEL_NS_VICTLR_MASK);
-
-	/*
-	 * TRCVICTLR::EXLEVEL_NS:EXLEVELS: Set kernel / user filtering
-	 * bits in vinst_ctrl, same bit pattern as TRCACATRn values returned by
-	 * etm4_get_access_type() but with a relative shift in this register.
-	 */
-	access_type = etm4_get_access_type(config) << ETM_EXLEVEL_LSHIFT_TRCVICTLR;
-	config->vinst_ctrl |= (u32)access_type;
+	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_MASK;
+	config->vinst_ctrl |= etm4_get_victlr_access_type(config);
 }
 
 static void etm4_set_default_config(struct etmv4_config *config)
@@ -1002,12 +998,9 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
 	u64 access_type = 0;
 
 	/*
-	 * EXLEVEL_NS, bits[15:12]
-	 * The Exception levels are:
-	 *   Bit[12] Exception level 0 - Application
-	 *   Bit[13] Exception level 1 - OS
-	 *   Bit[14] Exception level 2 - Hypervisor
-	 *   Bit[15] Never implemented
+	 * EXLEVEL_NS, for NonSecure Exception levels.
+	 * The mask here is a generic value and must be
+	 * shifted to the corresponding field for the registers
 	 */
 	if (!is_kernel_in_hyp_mode()) {
 		/* Stay away from hypervisor mode for non-VHE */
@@ -1024,20 +1017,26 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
 	return access_type;
 }
 
+/*
+ * Construct the exception level masks for a given config.
+ * This must be shifted to the corresponding register field
+ * for usage.
+ */
 static u64 etm4_get_access_type(struct etmv4_config *config)
 {
-	u64 access_type = etm4_get_ns_access_type(config);
-
-	/* All supported secure ELs are excluded */
-	access_type |= (u64)config->s_ex_level << TRCACATR_EXLEVEL_SHIFT;
+	/* All Secure exception levels are excluded from the trace */
+	return etm4_get_ns_access_type(config) | (u64)config->s_ex_level;
+}
 
-	return access_type;
+static u64 etm4_get_comparator_access_type(struct etmv4_config *config)
+{
+	return etm4_get_access_type(config) << TRCACATR_EXLEVEL_SHIFT;
 }
 
 static void etm4_set_comparator_filter(struct etmv4_config *config,
 				       u64 start, u64 stop, int comparator)
 {
-	u64 access_type = etm4_get_access_type(config);
+	u64 access_type = etm4_get_comparator_access_type(config);
 
 	/* First half of default address comparator */
 	config->addr_val[comparator] = start;
@@ -1072,7 +1071,7 @@ static void etm4_set_start_stop_filter(struct etmv4_config *config,
 				       enum etm_addr_type type)
 {
 	int shift;
-	u64 access_type = etm4_get_access_type(config);
+	u64 access_type = etm4_get_comparator_access_type(config);
 
 	/* Configure the comparator */
 	config->addr_val[comparator] = address;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index e8fdda45ffca..45aeeac2f50e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -743,7 +743,7 @@ static ssize_t s_exlevel_vinst_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	val = (config->vinst_ctrl & ETM_EXLEVEL_S_VICTLR_MASK) >> 16;
+	val = (config->vinst_ctrl & TRCVICTLR_EXLEVEL_S_MASK) >> TRCVICTLR_EXLEVEL_S_SHIFT;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -760,10 +760,10 @@ static ssize_t s_exlevel_vinst_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	/* clear all EXLEVEL_S bits  */
-	config->vinst_ctrl &= ~(ETM_EXLEVEL_S_VICTLR_MASK);
+	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_S_MASK);
 	/* enable instruction tracing for corresponding exception level */
 	val &= drvdata->s_ex_level;
-	config->vinst_ctrl |= (val << 16);
+	config->vinst_ctrl |= (val << TRCVICTLR_EXLEVEL_S_SHIFT);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -778,7 +778,7 @@ static ssize_t ns_exlevel_vinst_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	/* EXLEVEL_NS, bits[23:20] */
-	val = (config->vinst_ctrl & ETM_EXLEVEL_NS_VICTLR_MASK) >> 20;
+	val = (config->vinst_ctrl & TRCVICTLR_EXLEVEL_NS_MASK) >> TRCVICTLR_EXLEVEL_NS_SHIFT;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -795,10 +795,10 @@ static ssize_t ns_exlevel_vinst_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	/* clear EXLEVEL_NS bits  */
-	config->vinst_ctrl &= ~(ETM_EXLEVEL_NS_VICTLR_MASK);
+	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_NS_MASK);
 	/* enable instruction tracing for corresponding exception level */
 	val &= drvdata->ns_ex_level;
-	config->vinst_ctrl |= (val << 20);
+	config->vinst_ctrl |= (val << TRCVICTLR_EXLEVEL_NS_SHIFT);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 29cd27f53e72..91b82002e260 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -559,24 +559,39 @@
 
 #define TRCACATR_EXLEVEL_SHIFT		8
 
-/* secure state access levels - TRCACATRn */
-#define ETM_EXLEVEL_S_APP		BIT(8)
-#define ETM_EXLEVEL_S_OS		BIT(9)
-#define ETM_EXLEVEL_S_HYP		BIT(10)
-#define ETM_EXLEVEL_S_MON		BIT(11)
-/* non-secure state access levels - TRCACATRn */
-#define ETM_EXLEVEL_NS_APP		BIT(12)
-#define ETM_EXLEVEL_NS_OS		BIT(13)
-#define ETM_EXLEVEL_NS_HYP		BIT(14)
-#define ETM_EXLEVEL_NS_NA		BIT(15)
-
-/* access level control in TRCVICTLR - same bits as TRCACATRn but shifted */
-#define ETM_EXLEVEL_LSHIFT_TRCVICTLR	8
+/*
+ * Exception level mask for Secure and Non-Secure ELs.
+ * ETM defines the bits for EL control (e.g, TRVICTLR, TRCACTRn).
+ * The Secure and Non-Secure ELs are always to gether.
+ * Non-secure EL3 is never implemented.
+ * We use the following generic mask as they appear in different
+ * registers and this can be shifted for the appropriate
+ * fields.
+ */
+#define ETM_EXLEVEL_S_APP		BIT(0)	/* Secure EL0		*/
+#define ETM_EXLEVEL_S_OS		BIT(1)	/* Secure EL1		*/
+#define ETM_EXLEVEL_S_HYP		BIT(2)	/* Secure EL2		*/
+#define ETM_EXLEVEL_S_MON		BIT(3)	/* Secure EL3/Monitor	*/
+#define ETM_EXLEVEL_NS_APP		BIT(4)	/* NonSecure EL0	*/
+#define ETM_EXLEVEL_NS_OS		BIT(5)	/* NonSecure EL1	*/
+#define ETM_EXLEVEL_NS_HYP		BIT(6)	/* NonSecure EL2	*/
+
+#define ETM_EXLEVEL_MASK		(GENMASK(6, 0))
+#define ETM_EXLEVEL_S_MASK		(GENMASK(3, 0))
+#define ETM_EXLEVEL_NS_MASK		(GENMASK(6, 4))
+
+/* access level controls in TRCACATRn */
+#define TRCACATR_EXLEVEL_SHIFT		8
+
+/* access level control in TRCVICTLR */
+#define TRCVICTLR_EXLEVEL_SHIFT		16
+#define TRCVICTLR_EXLEVEL_S_SHIFT	16
+#define TRCVICTLR_EXLEVEL_NS_SHIFT	20
 
 /* secure / non secure masks - TRCVICTLR, IDR3 */
-#define ETM_EXLEVEL_S_VICTLR_MASK	GENMASK(19, 16)
-/* NS MON (EL3) mode never implemented */
-#define ETM_EXLEVEL_NS_VICTLR_MASK	GENMASK(22, 20)
+#define TRCVICTLR_EXLEVEL_MASK		(ETM_EXLEVEL_MASK << TRCVICTLR_EXLEVEL_SHIFT)
+#define TRCVICTLR_EXLEVEL_S_MASK	(ETM_EXLEVEL_S_MASK << TRCVICTLR_EXLEVEL_SHIFT)
+#define TRCVICTLR_EXLEVEL_NS_MASK	(ETM_EXLEVEL_NS_MASK << TRCVICTLR_EXLEVEL_SHIFT)
 
 /* Interpretation of resource numbers change at ETM v4.3 architecture */
 #define ETM4X_ARCH_4V3	0x43
-- 
2.25.1

