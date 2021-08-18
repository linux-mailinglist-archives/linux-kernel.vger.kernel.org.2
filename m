Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743083F0BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhHRTll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhHRTlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:41:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6872C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:40:35 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso3113382pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDyN4z6VCQWAfic0lAu1wvxFL13woz8ZH8fFX556NbA=;
        b=OxfCv2vak3gMAxmxQ9xQxIVmg0vdPmvv33ZAtFKoyif5Yi5NWvr7aS+RKThT1o514Q
         zI++UN5h55BMzXRr6dILzrgGB6MMJ3zmj0GZn0Z7Ot4A2SQHiT5HqqBJt22am4Unl+5Y
         YTDJqjMSbjPjibviEwvtTRJdrxnLX/SLn3UZQlSQOeUKHkKOlfpLW+tWxViKV2qDIxC/
         HBH/J8QmOiEOPYkm7yxRebkoWFmQXBk/M2fwp2VOWDTROrNw4Q5ghjMJ+TZWLjmtHY9o
         RC+wzDoLysPLlPF3S6Lbxy0kNPUdWtciIcVlqx/Qf6gjh5mULbaotRoh02pBqbaWmoik
         PFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDyN4z6VCQWAfic0lAu1wvxFL13woz8ZH8fFX556NbA=;
        b=MUaHe+Jrjj4qaflBKriZJxb6XYAhZwy+0eprKzLNA0drUATaerYOKpbj+9mWXBs1J5
         94K7GJBK9NiaLQpM29ni16wA/mhg8dgk+CFyaNmvxo4Yev0JIk+g3kzgZ3DXAtrLFULj
         7gv1oDpd4jqoNW8wdrh+61H43ysDXXtGRkLx6MugdcSvtvlSRWlYtaPezxd452srRA+B
         1yfd0CNZTgBjPTtx24wmRPWYSlIFY43OpjsYkXnXR5Y9+qIQWm93URDassOSFMS8tS5y
         VjnAhqcfklgww9EVGpnHclcvziMQVMgorP0DJMm0hQZExm/7ly7STEsKSWucOq9eBcyh
         U3SA==
X-Gm-Message-State: AOAM53230H8rzdSPnBwpEjwze2bXQz02JdAO06A7VRVhtlyg/SsWj4VX
        32XxVDa0h1Xky746fg6LfzNOCg==
X-Google-Smtp-Source: ABdhPJy0poC5re9Iy4Dofdui0Sn/LTvMqk46/mQ1iILRBrcjX3yqx0tFmarR5Qe1RXc96J+gzCKiQg==
X-Received: by 2002:a17:90a:6888:: with SMTP id a8mr11057507pjd.91.1629315635393;
        Wed, 18 Aug 2021 12:40:35 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k12sm2960137pjg.6.2021.08.18.12.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 12:40:34 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] coresight: etm4x: Add complex configuration handlers to etmv4
Date:   Wed, 18 Aug 2021 13:40:18 -0600
Message-Id: <20210818194022.379573-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818194022.379573-1-mathieu.poirier@linaro.org>
References: <20210818194022.379573-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

Adds in handlers to allow the ETMv4 to use the complex configuration
support. Features and configurations can be loaded and selected in the
device.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Link: https://lore.kernel.org/r/20210723165444.1048-8-mike.leach@linaro.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Makefile          |   3 +-
 .../hwtracing/coresight/coresight-etm4x-cfg.c | 182 ++++++++++++++++++
 .../hwtracing/coresight/coresight-etm4x-cfg.h |  15 ++
 .../coresight/coresight-etm4x-core.c          |  38 +++-
 .../coresight/coresight-etm4x-sysfs.c         |   3 +
 5 files changed, 238 insertions(+), 3 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.c
 create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.h

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 63ecfc3cf66d..9420d33b23ac 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -16,7 +16,8 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o
 coresight-etm3x-y := coresight-etm3x-core.o coresight-etm-cp14.o \
 		     coresight-etm3x-sysfs.o
 obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o
-coresight-etm4x-y := coresight-etm4x-core.o coresight-etm4x-sysfs.o
+coresight-etm4x-y := coresight-etm4x-core.o coresight-etm4x-sysfs.o \
+			coresight-etm4x-cfg.o
 obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
 obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
 obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
new file mode 100644
index 000000000000..d2ea903231b2
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(C) 2020 Linaro Limited. All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include "coresight-etm4x.h"
+#include "coresight-etm4x-cfg.h"
+#include "coresight-priv.h"
+#include "coresight-syscfg.h"
+
+/* defines to associate register IDs with driver data locations */
+#define CHECKREG(cval, elem) \
+	{ \
+		if (offset == cval) { \
+			reg_csdev->driver_regval = &drvcfg->elem; \
+			err = 0; \
+			break; \
+		} \
+	}
+
+#define CHECKREGIDX(cval, elem, off_idx, mask)	\
+	{ \
+		if (mask == cval) { \
+			reg_csdev->driver_regval = &drvcfg->elem[off_idx]; \
+			err = 0; \
+			break; \
+		} \
+	}
+
+/**
+ * etm4_cfg_map_reg_offset - validate and map the register offset into a
+ *			     location in the driver config struct.
+ *
+ * Limits the number of registers that can be accessed and programmed in
+ * features, to those which are used to control the trace capture parameters.
+ *
+ * Omits or limits access to those which the driver must use exclusively.
+ *
+ * Invalid offsets will result in fail code return and feature load failure.
+ *
+ * @drvdata:	driver data to map into.
+ * @reg:	register to map.
+ * @offset:	device offset for the register
+ */
+static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
+				   struct cscfg_regval_csdev *reg_csdev, u32 offset)
+{
+	int err = -EINVAL, idx;
+	struct etmv4_config *drvcfg = &drvdata->config;
+	u32 off_mask;
+
+	if (((offset >= TRCEVENTCTL0R) && (offset <= TRCVIPCSSCTLR)) ||
+	    ((offset >= TRCSEQRSTEVR) && (offset <= TRCEXTINSELR)) ||
+	    ((offset >= TRCCIDCCTLR0) && (offset <= TRCVMIDCCTLR1))) {
+		do {
+			CHECKREG(TRCEVENTCTL0R, eventctrl0);
+			CHECKREG(TRCEVENTCTL1R, eventctrl1);
+			CHECKREG(TRCSTALLCTLR, stall_ctrl);
+			CHECKREG(TRCTSCTLR, ts_ctrl);
+			CHECKREG(TRCSYNCPR, syncfreq);
+			CHECKREG(TRCCCCTLR, ccctlr);
+			CHECKREG(TRCBBCTLR, bb_ctrl);
+			CHECKREG(TRCVICTLR, vinst_ctrl);
+			CHECKREG(TRCVIIECTLR, viiectlr);
+			CHECKREG(TRCVISSCTLR, vissctlr);
+			CHECKREG(TRCVIPCSSCTLR, vipcssctlr);
+			CHECKREG(TRCSEQRSTEVR, seq_rst);
+			CHECKREG(TRCSEQSTR, seq_state);
+			CHECKREG(TRCEXTINSELR, ext_inp);
+			CHECKREG(TRCCIDCCTLR0, ctxid_mask0);
+			CHECKREG(TRCCIDCCTLR1, ctxid_mask1);
+			CHECKREG(TRCVMIDCCTLR0, vmid_mask0);
+			CHECKREG(TRCVMIDCCTLR1, vmid_mask1);
+		} while (0);
+	} else if ((offset & GENMASK(11, 4)) == TRCSEQEVRn(0)) {
+		/* sequencer state control registers */
+		idx = (offset & GENMASK(3, 0)) / 4;
+		if (idx < ETM_MAX_SEQ_STATES) {
+			reg_csdev->driver_regval = &drvcfg->seq_ctrl[idx];
+			err = 0;
+		}
+	} else if ((offset >= TRCSSCCRn(0)) && (offset <= TRCSSPCICRn(7))) {
+		/* 32 bit, 8 off indexed register sets */
+		idx = (offset & GENMASK(4, 0)) / 4;
+		off_mask =  (offset & GENMASK(11, 5));
+		do {
+			CHECKREGIDX(TRCSSCCRn(0), ss_ctrl, idx, off_mask);
+			CHECKREGIDX(TRCSSCSRn(0), ss_status, idx, off_mask);
+			CHECKREGIDX(TRCSSPCICRn(0), ss_pe_cmp, idx, off_mask);
+		} while (0);
+	} else if ((offset >= TRCCIDCVRn(0)) && (offset <= TRCVMIDCVRn(7))) {
+		/* 64 bit, 8 off indexed register sets */
+		idx = (offset & GENMASK(5, 0)) / 8;
+		off_mask = (offset & GENMASK(11, 6));
+		do {
+			CHECKREGIDX(TRCCIDCVRn(0), ctxid_pid, idx, off_mask);
+			CHECKREGIDX(TRCVMIDCVRn(0), vmid_val, idx, off_mask);
+		} while (0);
+	} else if ((offset >= TRCRSCTLRn(2)) &&
+		   (offset <= TRCRSCTLRn((ETM_MAX_RES_SEL - 1)))) {
+		/* 32 bit resource selection regs, 32 off, skip fixed 0,1 */
+		idx = (offset & GENMASK(6, 0)) / 4;
+		if (idx < ETM_MAX_RES_SEL) {
+			reg_csdev->driver_regval = &drvcfg->res_ctrl[idx];
+			err = 0;
+		}
+	} else if ((offset >= TRCACVRn(0)) &&
+		   (offset <= TRCACATRn((ETM_MAX_SINGLE_ADDR_CMP - 1)))) {
+		/* 64 bit addr cmp regs, 16 off */
+		idx = (offset & GENMASK(6, 0)) / 8;
+		off_mask = offset & GENMASK(11, 7);
+		do {
+			CHECKREGIDX(TRCACVRn(0), addr_val, idx, off_mask);
+			CHECKREGIDX(TRCACATRn(0), addr_acc, idx, off_mask);
+		} while (0);
+	} else if ((offset >= TRCCNTRLDVRn(0)) &&
+		   (offset <= TRCCNTVRn((ETMv4_MAX_CNTR - 1)))) {
+		/* 32 bit counter regs, 4 off (ETMv4_MAX_CNTR - 1) */
+		idx = (offset &  GENMASK(3, 0)) / 4;
+		off_mask = offset &  GENMASK(11, 4);
+		do {
+			CHECKREGIDX(TRCCNTRLDVRn(0), cntrldvr, idx, off_mask);
+			CHECKREGIDX(TRCCNTCTLRn(0), cntr_ctrl, idx, off_mask);
+			CHECKREGIDX(TRCCNTVRn(0), cntr_val, idx, off_mask);
+		} while (0);
+	}
+	return err;
+}
+
+/**
+ * etm4_cfg_load_feature - load a feature into a device instance.
+ *
+ * @csdev:	An ETMv4 CoreSight device.
+ * @feat:	The feature to be loaded.
+ *
+ * The function will load a feature instance into the device, checking that
+ * the register definitions are valid for the device.
+ *
+ * Parameter and register definitions will be converted into internal
+ * structures that are used to set the values in the driver when the
+ * feature is enabled for the device.
+ *
+ * The feature spinlock pointer is initialised to the same spinlock
+ * that the driver uses to protect the internal register values.
+ */
+static int etm4_cfg_load_feature(struct coresight_device *csdev,
+				 struct cscfg_feature_csdev *feat_csdev)
+{
+	struct device *dev = csdev->dev.parent;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
+	const struct cscfg_feature_desc *feat_desc = feat_csdev->feat_desc;
+	u32 offset;
+	int i = 0, err = 0;
+
+	/*
+	 * essential we set the device spinlock - this is used in the generic
+	 * programming routines when copying values into the drvdata structures
+	 * via the pointers setup in etm4_cfg_map_reg_offset().
+	 */
+	feat_csdev->drv_spinlock = &drvdata->spinlock;
+
+	/* process the register descriptions */
+	for (i = 0; i < feat_csdev->nr_regs && !err; i++) {
+		offset = feat_desc->regs_desc[i].offset;
+		err = etm4_cfg_map_reg_offset(drvdata, &feat_csdev->regs_csdev[i], offset);
+	}
+	return err;
+}
+
+/* match information when loading configurations */
+#define CS_CFG_ETM4_MATCH_FLAGS	(CS_CFG_MATCH_CLASS_SRC_ALL | \
+				 CS_CFG_MATCH_CLASS_SRC_ETM4)
+
+int etm4_cscfg_register(struct coresight_device *csdev)
+{
+	struct cscfg_csdev_feat_ops ops;
+
+	ops.load_feat = &etm4_cfg_load_feature;
+
+	return cscfg_register_csdev(csdev, CS_CFG_ETM4_MATCH_FLAGS, &ops);
+}
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.h b/drivers/hwtracing/coresight/coresight-etm4x-cfg.h
new file mode 100644
index 000000000000..a204ad9a4792
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2014-2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _CORESIGHT_ETM4X_CFG_H
+#define _CORESIGHT_ETM4X_CFG_H
+
+#include "coresight-config.h"
+#include "coresight-etm4x.h"
+
+/* ETMv4 specific config functions */
+int etm4_cscfg_register(struct coresight_device *csdev);
+
+#endif /* CORESIGHT_ETM4X_CFG_H */
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index da27cd4a3c38..e24252eaf8e4 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -39,6 +39,8 @@
 
 #include "coresight-etm4x.h"
 #include "coresight-etm-perf.h"
+#include "coresight-etm4x-cfg.h"
+#include "coresight-syscfg.h"
 
 static int boot_enable;
 module_param(boot_enable, int, 0444);
@@ -561,12 +563,15 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
 	return ret;
 }
 
-static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
+static int etm4_parse_event_config(struct coresight_device *csdev,
 				   struct perf_event *event)
 {
 	int ret = 0;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct etmv4_config *config = &drvdata->config;
 	struct perf_event_attr *attr = &event->attr;
+	unsigned long cfg_hash;
+	int preset;
 
 	/* Clear configuration from previous run */
 	memset(config, 0, sizeof(struct etmv4_config));
@@ -632,6 +637,20 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
 		/* bit[12], Return stack enable bit */
 		config->cfg |= BIT(12);
 
+	/*
+	 * Set any selected configuration and preset.
+	 *
+	 * This extracts the values of PMU_FORMAT_ATTR(configid) and PMU_FORMAT_ATTR(preset)
+	 * in the perf attributes defined in coresight-etm-perf.c.
+	 * configid uses bits 63:32 of attr->config2, preset uses bits 3:0 of attr->config.
+	 * A zero configid means no configuration active, preset = 0 means no preset selected.
+	 */
+	if (attr->config2 & GENMASK_ULL(63, 32)) {
+		cfg_hash = (u32)(attr->config2 >> 32);
+		preset = attr->config & 0xF;
+		ret = cscfg_csdev_enable_active_config(csdev, cfg_hash, preset);
+	}
+
 out:
 	return ret;
 }
@@ -648,7 +667,7 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 	}
 
 	/* Configure the tracer based on the session's specifics */
-	ret = etm4_parse_event_config(drvdata, event);
+	ret = etm4_parse_event_config(csdev, event);
 	if (ret)
 		goto out;
 	/* And enable it */
@@ -794,11 +813,18 @@ static int etm4_disable_perf(struct coresight_device *csdev,
 	u32 control;
 	struct etm_filters *filters = event->hw.addr_filters;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct perf_event_attr *attr = &event->attr;
 
 	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
 		return -EINVAL;
 
 	etm4_disable_hw(drvdata);
+	/*
+	 * The config_id occupies bits 63:32 of the config2 perf event attr
+	 * field. If this is non-zero then we will have enabled a config.
+	 */
+	if (attr->config2 & GENMASK_ULL(63, 32))
+		cscfg_csdev_disable_active_config(csdev);
 
 	/*
 	 * Check if the start/stop logic was active when the unit was stopped.
@@ -1939,6 +1965,13 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 		return ret;
 	}
 
+	/* register with config infrastructure & load any current features */
+	ret = etm4_cscfg_register(drvdata->csdev);
+	if (ret) {
+		coresight_unregister(drvdata->csdev);
+		return ret;
+	}
+
 	etmdrvdata[drvdata->cpu] = drvdata;
 
 	dev_info(&drvdata->csdev->dev, "CPU%d: %s v%d.%d initialized\n",
@@ -2025,6 +2058,7 @@ static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
 
 	cpus_read_unlock();
 
+	cscfg_unregister_csdev(drvdata->csdev);
 	coresight_unregister(drvdata->csdev);
 
 	return 0;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 007bad9e7ad8..a0640fa5c55b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -9,6 +9,7 @@
 #include <linux/sysfs.h>
 #include "coresight-etm4x.h"
 #include "coresight-priv.h"
+#include "coresight-syscfg.h"
 
 static int etm4_set_mode_exclude(struct etmv4_drvdata *drvdata, bool exclude)
 {
@@ -269,6 +270,8 @@ static ssize_t reset_store(struct device *dev,
 
 	spin_unlock(&drvdata->spinlock);
 
+	cscfg_csdev_reset_feats(to_coresight_device(dev));
+
 	return size;
 }
 static DEVICE_ATTR_WO(reset);
-- 
2.25.1

