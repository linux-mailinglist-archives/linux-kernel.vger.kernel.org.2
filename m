Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA5533DC33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbhCPSIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbhCPSHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:07:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EEAC0613E4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:04:10 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v4so7914026wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/b+zwpRcFLrzPT6OfmBqEOW5zM4P9ZI9jhRX0KJ3SaU=;
        b=bCrS4lj1xhgtrUf4kRYVr+sHZxxrAb5L6b/JEg2xaz937DNMuocZHBoOrBc3VVwGxq
         SOrzERzKE2dgDLPoHc7VyN7gzN2KejM1FouwTubUCIzr9RgjPUEhbtYC0Bg3F87vGq/Z
         uyF2YVqOKoW8jKrsnyfGDKyTLC5mChdH4tOniSVucliSeVRGTAXm4AXVImgUjPNS4o1+
         6flhyr2WsYnitrDYL4UPcCPMAmoQvkjG9EeIj9pfaRIiwSgX3N8iknUTI+Hc/xzdajwj
         ANgsRf1x4S6dF94sgX80//E8eI4oyK9ZETu3rfbJ7F3WcKW4MP/LKS1l5rSEyPAsWmUd
         JwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/b+zwpRcFLrzPT6OfmBqEOW5zM4P9ZI9jhRX0KJ3SaU=;
        b=GN/jbcjiSI2667kRh4EvYg1yxLI/qdYHChkKk7wzpSSNKyINS7+mgJbIlxC4GmSN0a
         o32/rGsRxxek7itgibR2j4xW/BoTKD02dwu5pIj0hmk3GYVg3Rsa2bRDc4Tp3j80XmUp
         YzjRlVYUUB9NpsKlLizSQfe5k1mjsRWp68XmTOaGbTOCBwhifiUCZwfmSUfCTnRbegH4
         AgZAy+moUhBWSKHRKSp5mAxtEacrETjegu/ozcCmL/QtL/7/MP1FVsM/uQDEa2ZzUaq5
         FMxJZ97s1AX+zuZWmlG3cCr976KBP3XUIPS/dBUbhzKz+BsMo4sAbdl5pbBqwvzVWKCp
         qYtg==
X-Gm-Message-State: AOAM532Mu8Jn4JCL3bwLU8/10ZdknZuySasmWV7RHNeXRZwwBN+bRfO4
        P+ob6rIan8MRkVdMP6mNT81egA==
X-Google-Smtp-Source: ABdhPJzJp9Z0yiTGn0c/ISPSQSxef0avRuomntn3Mzo7HjOJFfRNwLXjm+o7kWAaqp8yh5AsiN6KvQ==
X-Received: by 2002:adf:e548:: with SMTP id z8mr288703wrm.246.1615917848983;
        Tue, 16 Mar 2021 11:04:08 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6801:1801:84a6:25fa:dde:ecca])
        by smtp.gmail.com with ESMTPSA id d13sm23927858wro.23.2021.03.16.11.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:04:08 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 08/10] coresight: config: Add preloaded configurations
Date:   Tue, 16 Mar 2021 18:03:58 +0000
Message-Id: <20210316180400.7184-9-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316180400.7184-1-mike.leach@linaro.org>
References: <20210316180400.7184-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preload set of configurations.

This patch creates a small set of preloaded configurations and features
that are available immediately after coresight has been initialised.

The current set provides a strobing feature for ETMv4, that creates a
periodic sampling of trace by switching trace generation on and off
using counters in the ETM.

A configuration called "autofdo" is also provided that uses the 'strobing'
feature and provides a couple of preset values, selectable on the perf
command line.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/Makefile          |   3 +-
 .../hwtracing/coresight/coresight-cfg-afdo.c  | 149 ++++++++++++++++++
 .../coresight/coresight-cfg-preload.c         |  27 ++++
 .../coresight/coresight-cfg-preload.h         |  11 ++
 .../hwtracing/coresight/coresight-etm4x-cfg.h |  15 ++
 .../hwtracing/coresight/coresight-syscfg.c    |   9 ++
 .../hwtracing/coresight/coresight-syscfg.h    |   1 +
 7 files changed, 214 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-afdo.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.h

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index ea544206204d..2707bfef1b76 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -4,7 +4,8 @@
 #
 obj-$(CONFIG_CORESIGHT) += coresight.o
 coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
-		coresight-sysfs.o coresight-syscfg.o coresight-config.o
+		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
+		coresight-cfg-preload.o coresight-cfg-afdo.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
 		      coresight-tmc-etr.o
diff --git a/drivers/hwtracing/coresight/coresight-cfg-afdo.c b/drivers/hwtracing/coresight/coresight-cfg-afdo.c
new file mode 100644
index 000000000000..44d60ca1da49
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-cfg-afdo.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(C) 2020 Linaro Limited. All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include "coresight-config.h"
+#include "coresight-etm4x-cfg.h"
+
+/* preload configurations and features */
+
+/* preload in features for ETMv4 */
+
+/* strobe feature */
+static struct cscfg_parameter_desc strobe_params[] = {
+	{
+		.name = "window",
+		.value = 5000,
+	},
+	{
+		.name = "period",
+		.value = 10000,
+	},
+};
+
+static struct cscfg_regval_desc strobe_regs[] = {
+	/* resource selectors */
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE,
+		.offset = TRCRSCTLRn(2),
+		.hw_info = ETM4_CFG_RES_SEL,
+		.val32 = 0x20001,
+	},
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE,
+		.offset = TRCRSCTLRn(3),
+		.hw_info = ETM4_CFG_RES_SEQ,
+		.val32 = 0x20002,
+	},
+	/* strobe window counter 0 - reload from param 0 */
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE | CS_CFG_REG_TYPE_VAL_SAVE,
+		.offset = TRCCNTVRn(0),
+		.hw_info = ETM4_CFG_RES_CTR,
+	},
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE | CS_CFG_REG_TYPE_VAL_PARAM,
+		.offset = TRCCNTRLDVRn(0),
+		.hw_info = ETM4_CFG_RES_CTR,
+		.val32 = 0,
+	},
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE,
+		.offset = TRCCNTCTLRn(0),
+		.hw_info = ETM4_CFG_RES_CTR,
+		.val32 = 0x10001,
+	},
+	/* strobe period counter 1 - reload from param 1 */
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE | CS_CFG_REG_TYPE_VAL_SAVE,
+		.offset = TRCCNTVRn(1),
+		.hw_info = ETM4_CFG_RES_CTR,
+	},
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE | CS_CFG_REG_TYPE_VAL_PARAM,
+		.offset = TRCCNTRLDVRn(1),
+		.hw_info = ETM4_CFG_RES_CTR,
+		.val32 = 1,
+	},
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE,
+		.offset = TRCCNTCTLRn(1),
+		.hw_info = ETM4_CFG_RES_CTR,
+		.val32 = 0x8102,
+	},
+	/* sequencer */
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE,
+		.offset = TRCSEQEVRn(0),
+		.hw_info = ETM4_CFG_RES_SEQ,
+		.val32 = 0x0081,
+	},
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE,
+		.offset = TRCSEQEVRn(1),
+		.hw_info = ETM4_CFG_RES_SEQ,
+		.val32 = 0x0000,
+	},
+	/* view-inst */
+	{
+		.type = CS_CFG_REG_TYPE_STD | CS_CFG_REG_TYPE_VAL_MASK,
+		.offset = TRCVICTLR,
+		.val32 = 0x0003,
+		.mask32 = 0x0003,
+	},
+	/* end of regs */
+};
+
+struct cscfg_feature_desc strobe = {
+	.name = "strobing",
+	.description = "Generate periodic trace capture windows.\n"
+		       "parameter \'window\': a number of CPU cycles (W)\n"
+		       "parameter \'period\': trace enabled for W cycles every period x W cycles\n",
+	.match_flags = CS_CFG_MATCH_CLASS_SRC_ETM4,
+	.nr_params = ARRAY_SIZE(strobe_params),
+	.params_desc = strobe_params,
+	.nr_regs = ARRAY_SIZE(strobe_regs),
+	.regs_desc = strobe_regs,
+};
+
+/* create an autofdo configuration */
+
+/* we will provide 9 sets of preset parameter values */
+#define AFDO_NR_PRESETS	9
+/* the total number of parameters in used features */
+#define AFDO_NR_PARAMS	ARRAY_SIZE(strobe_params)
+
+#define AFDO_MATCH_STROBING (CS_CFG_MATCH_INST_ANY | CS_CFG_MATCH_CLASS_SRC_ETM4)
+
+static const char *afdo_ref_names[] = {
+	"strobing",
+};
+
+/*
+ * set of presets leaves strobing window constant while varying period to allow
+ * experimentation with mark / space ratios for various workloads
+ */
+static u64 afdo_presets[AFDO_NR_PRESETS][AFDO_NR_PARAMS] = {
+	{ 5000, 2 },
+	{ 5000, 4 },
+	{ 5000, 8 },
+	{ 5000, 16 },
+	{ 5000, 64 },
+	{ 5000, 128 },
+	{ 5000, 512 },
+	{ 5000, 1024 },
+	{ 5000, 4096 },
+};
+
+struct cscfg_config_desc afdo = {
+	.name = "autofdo",
+	.description = "Setup ETMs with strobing for autofdo\n"
+	"Supplied presets allow experimentation with mark-space ratio for various loads\n",
+	.nr_feat_refs = ARRAY_SIZE(afdo_ref_names),
+	.feat_ref_names = afdo_ref_names,
+	.nr_presets = AFDO_NR_PRESETS,
+	.nr_total_params = AFDO_NR_PARAMS,
+	.presets = &afdo_presets[0][0],
+};
diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.c b/drivers/hwtracing/coresight/coresight-cfg-preload.c
new file mode 100644
index 000000000000..9ed0f029a335
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-cfg-preload.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(C) 2020 Linaro Limited. All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include "coresight-cfg-preload.h"
+#include "coresight-config.h"
+#include "coresight-syscfg.h"
+
+/* Basic features and configurations pre-loaded on initialisation */
+
+static struct cscfg_feature_desc *preload_feats[] = {
+	&strobe,
+	0
+};
+
+static struct cscfg_config_desc *preload_cfgs[] = {
+	&afdo,
+	0
+};
+
+/* preload called on initialisation */
+int cscfg_preload(void)
+{
+	return cscfg_load_config_sets(preload_cfgs, preload_feats);
+}
diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.h b/drivers/hwtracing/coresight/coresight-cfg-preload.h
new file mode 100644
index 000000000000..fc4ac7faa93d
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-cfg-preload.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(C) 2020 Linaro Limited. All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+/* declare preloaded configurations and features */
+
+/* from coresight-cfg-afdo.c */
+extern struct cscfg_feature_desc strobe;
+extern struct cscfg_config_desc afdo;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.h b/drivers/hwtracing/coresight/coresight-etm4x-cfg.h
index 7ec65771ee58..1f5477883818 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-cfg.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.h
@@ -9,6 +9,21 @@
 #include "coresight-config.h"
 #include "coresight-etm4x.h"
 
+/* ETMv4 specific config defines */
+
+/* resource IDs */
+
+#define ETM4_CFG_RES_CTR	0x001
+#define ETM4_CFG_RES_CMP	0x002
+#define ETM4_CFG_RES_CMP_PAIR0	0x003
+#define ETM4_CFG_RES_CMP_PAIR1	0x004
+#define ETM4_CFG_RES_SEL	0x005
+#define ETM4_CFG_RES_SEL_PAIR0	0x006
+#define ETM4_CFG_RES_SEL_PAIR1	0x007
+#define ETM4_CFG_RES_SEQ	0x008
+#define ETM4_CFG_RES_TS		0x009
+#define ETM4_CFG_RES_MASK	0x00F
+
 /* ETMv4 specific config functions */
 int etm4_cscfg_register(struct coresight_device *csdev, const char *dev_name);
 
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index c44746d6cd6d..befc379b85b9 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -642,8 +642,17 @@ int __init cscfg_init(void)
 	INIT_LIST_HEAD(&cscfg_mgr->config_desc_list);
 	atomic_set(&cscfg_mgr->sys_active_cnt, 0);
 
+	/* preload built-in configurations */
+	err = cscfg_preload();
+	if (err)
+		goto exit_err;
+
 	dev_info(cscfg_device(), "CoreSight Configuration manager initialised");
 	return 0;
+
+exit_err:
+	cscfg_clear_device();
+	return err;
 }
 
 void cscfg_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
index a52775890670..7bb8c8e497ba 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.h
+++ b/drivers/hwtracing/coresight/coresight-syscfg.h
@@ -56,6 +56,7 @@ struct cscfg_registered_csdev {
 /* internal core operations for cscfg */
 int __init cscfg_init(void);
 void cscfg_exit(void);
+int cscfg_preload(void);
 
 /* syscfg manager external API */
 int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
-- 
2.17.1

