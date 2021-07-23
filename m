Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B546C3D3DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhGWQOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhGWQOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:14:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E359C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:54:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j34-20020a05600c1c22b029024e75084404so1054693wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SBQF3vlztO8iUWOrKAXFGwxVh8UbqmWVuPD7uMb+qnU=;
        b=usbMH/8swElfY31Koa2zAqtyomUrPPHosBPF9uP6UOGqibYoqsWb1PgjGc0w1rzWu/
         U5I4xK3flY87W0Hi6WhxPIYIrSYcELd5eV1H24RTqgwy9AusIi9k2LB1avYd3rIHa2Ps
         X3jZE+XV/VJxprWmxO9Hn9e7ky89OztVOkxCRHLr3DeW1zqwEVaxsLLSJKsoBF0ps4d8
         E/o83v0mruZQCIW09s4lh+7DPSsZlguTjtUWFmyI29qz6ytYuERy6aAJqXMVSkMl1JkZ
         CXYK+m0gAJvtEGW83SmD9UdIJKCgtoxUP4awkF+fcBlU5gJJ1iSvxFFIsgs2SC2LcIzu
         rh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SBQF3vlztO8iUWOrKAXFGwxVh8UbqmWVuPD7uMb+qnU=;
        b=jdt0iSVyQbQUgTgr70RlBYvyEIO4uy31+adwu7Ehgo0Gq+HHdbqgj3Iv031eCvrYmd
         2WZwERPbbDG9UsD/HCZNeF841dm21CDTnqRnK5LXG7tpjZbAno2SshiR0/DwYN8JzURg
         tZmiTS+dGUP3Q2ziAwMnx5EBQrW5vbbFCpQv+InSvgzL4AIlURfEOxFHMQmnAZVqnRH1
         7+Ufb8DTGjT8lPt7O1Grilll9NQETY7IDN12ktvTMAOxWLKWyh5kHtiLYIzimJ0A1eR4
         o90OIevjfnFRmUn2cSD83H/1r/ZS8twk+8fyqMMRwVdTMLKDMXZc4lw0n69wJDwAgZ14
         3anA==
X-Gm-Message-State: AOAM533FRPOHEAvfQeljAi+SeRJ92w4JL/NcoR0w4MTeQU+6sQP7E5LA
        yrjYARTU8wZ8eUIGnGhAmx3KeZBI0Kaqbw==
X-Google-Smtp-Source: ABdhPJzk0QCbhakkiEeUi+RyUCw8XpsJtxzak3J7pF3sNPNd3v2TbyilKQkg5zcjxuO0ok7TGERN+w==
X-Received: by 2002:a05:600c:4f08:: with SMTP id l8mr5506024wmq.22.1627059293127;
        Fri, 23 Jul 2021 09:54:53 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:fdab:eb9d:1515:bff3])
        by smtp.gmail.com with ESMTPSA id z11sm33193225wru.65.2021.07.23.09.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 09:54:52 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Cc:     yabinc@google.com, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v9 08/10] coresight: config: Add preloaded configurations
Date:   Fri, 23 Jul 2021 17:54:42 +0100
Message-Id: <20210723165444.1048-9-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723165444.1048-1-mike.leach@linaro.org>
References: <20210723165444.1048-1-mike.leach@linaro.org>
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
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Makefile          |   3 +-
 .../hwtracing/coresight/coresight-cfg-afdo.c  | 153 ++++++++++++++++++
 .../coresight/coresight-cfg-preload.c         |  31 ++++
 .../coresight/coresight-cfg-preload.h         |  13 ++
 .../hwtracing/coresight/coresight-etm4x-cfg.h |  15 ++
 .../hwtracing/coresight/coresight-syscfg.c    |   9 ++
 .../hwtracing/coresight/coresight-syscfg.h    |   1 +
 7 files changed, 224 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-afdo.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.h

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 9420d33b23ac..ad44f0fe3069 100644
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
index 000000000000..84b31184252b
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-cfg-afdo.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(C) 2020 Linaro Limited. All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include "coresight-config.h"
+
+/* ETMv4 includes and features */
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
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
+struct cscfg_feature_desc strobe_etm4x = {
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
+struct cscfg_config_desc afdo_etm4x = {
+	.name = "autofdo",
+	.description = "Setup ETMs with strobing for autofdo\n"
+	"Supplied presets allow experimentation with mark-space ratio for various loads\n",
+	.nr_feat_refs = ARRAY_SIZE(afdo_ref_names),
+	.feat_ref_names = afdo_ref_names,
+	.nr_presets = AFDO_NR_PRESETS,
+	.nr_total_params = AFDO_NR_PARAMS,
+	.presets = &afdo_presets[0][0],
+};
+
+/* end of ETM4x configurations */
+#endif	/* IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X) */
diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.c b/drivers/hwtracing/coresight/coresight-cfg-preload.c
new file mode 100644
index 000000000000..751af3710d56
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-cfg-preload.c
@@ -0,0 +1,31 @@
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
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
+	&strobe_etm4x,
+#endif
+	NULL
+};
+
+static struct cscfg_config_desc *preload_cfgs[] = {
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
+	&afdo_etm4x,
+#endif
+	NULL
+};
+
+/* preload called on initialisation */
+int cscfg_preload(void)
+{
+	return cscfg_load_config_sets(preload_cfgs, preload_feats);
+}
diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.h b/drivers/hwtracing/coresight/coresight-cfg-preload.h
new file mode 100644
index 000000000000..21299e175477
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-cfg-preload.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(C) 2020 Linaro Limited. All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+/* declare preloaded configurations and features */
+
+/* from coresight-cfg-afdo.c - etm 4x features */
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
+extern struct cscfg_feature_desc strobe_etm4x;
+extern struct cscfg_config_desc afdo_etm4x;
+#endif
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.h b/drivers/hwtracing/coresight/coresight-etm4x-cfg.h
index a204ad9a4792..32dab34c1dac 100644
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
 int etm4_cscfg_register(struct coresight_device *csdev);
 
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 8903aab36c51..cdfa9121a41d 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -749,8 +749,17 @@ int __init cscfg_init(void)
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

