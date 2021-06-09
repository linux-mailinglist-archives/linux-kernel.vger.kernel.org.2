Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789813A0A02
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 04:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhFIC0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 22:26:06 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:41546 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbhFIC0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 22:26:02 -0400
Received: by mail-qt1-f178.google.com with SMTP id o20so1496857qtr.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 19:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b6NcSV0VhKI9C8MGe0xadyzFh2Gwksr/C1HgKRtsY+U=;
        b=0QPTO4RRd5FRyK4OzNYo9CT/VfEaWgFboOvJINPWmJWS/K6VfQ5Du/em5txheHsfpa
         MGWhPHiK2GZSRE16VjLsaCFj6txxqYYqnPc1t7iYn3uUVEo7HH53E36C2Sbl/YDr2Z9m
         e3FtUOoUYfFdPn/GjBWc5Uf0bCQZ90OyABROwUVDtmoMVMu1jplhyqkQ8BizePNMEw1j
         YgxaxkWskev+RdrzT+FSy6ko9m6T92mkJ0aodTpFPpGAsfWkA3Eyv0Ggc/sXrbMbkgjA
         8m2rWew8bhSFAgaYdLI4KUz9UUWXillnxG5f3w7DPxzzly8KQoZKu13lz6nEEQ51pCkN
         Dw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b6NcSV0VhKI9C8MGe0xadyzFh2Gwksr/C1HgKRtsY+U=;
        b=WJwr8pbmg5n5oKVDvc1IGNZuE+t6tTHINgsy7D80xECefMIYu4vhAMUnSECGao0LI9
         Ov7KNsdhrYJJcEM5L676zdCzvC+Yq7wzDoWkfcu618BDWmOTP2oBdVKSaoXFCU46SFfo
         siwTk++G4Kup57H9kCKsia+yCs9cHLK0gxyBzloNvIx0CEtbZ/rLWSY1s9v8Md8gQSHG
         dg2DjsMalYinyM4ICpgeTIfFOlpiFe0cAypcTwyK27VOnwCq8cjgAeNCMex0VxNbYgdB
         HcxLy5MZpXhXy+pTARrgC8VJNWE6qdOfyeDy8jieJD4fn6hFwCvYOcd/cXH8MFyywfBC
         BVsg==
X-Gm-Message-State: AOAM531VV6+H2Ko04nDXecPc/nSBjL3ikcxh/E5YpzJPMJKVIQrR0nxJ
        9W03sDn6ic0Q5GXB3HyNaflpQQ==
X-Google-Smtp-Source: ABdhPJxQYB8Q01lTK+vkhcziQ3JCstDafFI7c+MoDzXYNBpjlO1jEyglmILUpmglmkUAMxsz9S83RA==
X-Received: by 2002:a05:622a:15d5:: with SMTP id d21mr15890934qty.335.1623205376222;
        Tue, 08 Jun 2021 19:22:56 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id h6sm7004657qtr.73.2021.06.08.19.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 19:22:55 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     robert.foss@linaro.org, andrey.konovalov@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK)
Subject: [PATCH v2 3/3] clk: qcom: Add camera clock controller driver for SM8250
Date:   Tue,  8 Jun 2021 22:20:48 -0400
Message-Id: <20210609022051.2171-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210609022051.2171-1-jonathan@marek.ca>
References: <20210609022051.2171-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the camera clock controller found on SM8250.

Based on the downstream driver.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/clk/qcom/Kconfig        |    7 +
 drivers/clk/qcom/Makefile       |    1 +
 drivers/clk/qcom/camcc-sm8250.c | 2456 +++++++++++++++++++++++++++++++
 3 files changed, 2464 insertions(+)
 create mode 100644 drivers/clk/qcom/camcc-sm8250.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 45646b867cdbc..4f48c71dd964a 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -483,6 +483,13 @@ config SDX_GCC_55
 	  Say Y if you want to use peripheral devices such as UART,
 	  SPI, I2C, USB, SD/UFS, PCIe etc.
 
+config SM_CAMCC_8250
+	tristate "SM8250 Camera Clock Controller"
+	select SM_GCC_8250
+	help
+	  Support for the camera clock controller on SM8250 devices.
+	  Say Y if you want to support camera devices and camera functionality.
+
 config SM_DISPCC_8250
 	tristate "SM8150 and SM8250 Display Clock Controller"
 	depends on SM_GCC_8150 || SM_GCC_8250
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 464f0af360d82..87144813962fe 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_SDM_GPUCC_845) += gpucc-sdm845.o
 obj-$(CONFIG_SDM_LPASSCC_845) += lpasscc-sdm845.o
 obj-$(CONFIG_SDM_VIDEOCC_845) += videocc-sdm845.o
 obj-$(CONFIG_SDX_GCC_55) += gcc-sdx55.o
+obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
 obj-$(CONFIG_SM_DISPCC_8250) += dispcc-sm8250.o
 obj-$(CONFIG_SM_GCC_8150) += gcc-sm8150.o
 obj-$(CONFIG_SM_GCC_8250) += gcc-sm8250.o
diff --git a/drivers/clk/qcom/camcc-sm8250.c b/drivers/clk/qcom/camcc-sm8250.c
new file mode 100644
index 0000000000000..35f5c9a5f0e76
--- /dev/null
+++ b/drivers/clk/qcom/camcc-sm8250.c
@@ -0,0 +1,2456 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2018-2021, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#include <dt-bindings/clock/qcom,camcc-sm8250.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap-divider.h"
+#include "common.h"
+#include "gdsc.h"
+#include "reset.h"
+
+enum {
+	P_BI_TCXO,
+	P_CAM_CC_PLL0_OUT_EVEN,
+	P_CAM_CC_PLL0_OUT_MAIN,
+	P_CAM_CC_PLL0_OUT_ODD,
+	P_CAM_CC_PLL1_OUT_EVEN,
+	P_CAM_CC_PLL2_OUT_EARLY,
+	P_CAM_CC_PLL2_OUT_MAIN,
+	P_CAM_CC_PLL3_OUT_EVEN,
+	P_CAM_CC_PLL4_OUT_EVEN,
+	P_SLEEP_CLK,
+};
+
+static struct pll_vco lucid_vco[] = {
+	{ 249600000, 2000000000, 0 },
+};
+
+static struct pll_vco zonda_vco[] = {
+	{ 595200000, 3600000000, 0 },
+};
+
+static const struct alpha_pll_config cam_cc_pll0_config = {
+	.l = 0x3e,
+	.alpha = 0x8000,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002261,
+	.config_ctl_hi1_val = 0x329A699c,
+	.user_ctl_val = 0x00003100,
+	.user_ctl_hi_val = 0x00000805,
+	.user_ctl_hi1_val = 0x00000000,
+};
+
+static struct clk_alpha_pll cam_cc_pll0 = {
+	.offset = 0x0,
+	.vco_table = lucid_vco,
+	.num_vco = ARRAY_SIZE(lucid_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_pll0",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_lucid_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_cam_cc_pll0_out_even[] = {
+	{ 0x1, 2 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv cam_cc_pll0_out_even = {
+	.offset = 0x0,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_cam_cc_pll0_out_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll0_out_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_pll0_out_even",
+		.parent_hws = (const struct clk_hw*[]){
+			&cam_cc_pll0.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_lucid_ops,
+	},
+};
+
+static const struct clk_div_table post_div_table_cam_cc_pll0_out_odd[] = {
+	{ 0x3, 3 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv cam_cc_pll0_out_odd = {
+	.offset = 0x0,
+	.post_div_shift = 12,
+	.post_div_table = post_div_table_cam_cc_pll0_out_odd,
+	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll0_out_odd),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_pll0_out_odd",
+		.parent_hws = (const struct clk_hw*[]){
+			&cam_cc_pll0.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_lucid_ops,
+	},
+};
+
+static const struct alpha_pll_config cam_cc_pll1_config = {
+	.l = 0x1f,
+	.alpha = 0x4000,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002261,
+	.config_ctl_hi1_val = 0x329A699c,
+	.user_ctl_val = 0x00000100,
+	.user_ctl_hi_val = 0x00000805,
+	.user_ctl_hi1_val = 0x00000000,
+};
+
+static struct clk_alpha_pll cam_cc_pll1 = {
+	.offset = 0x1000,
+	.vco_table = lucid_vco,
+	.num_vco = ARRAY_SIZE(lucid_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_pll1",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_lucid_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_cam_cc_pll1_out_even[] = {
+	{ 0x1, 2 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv cam_cc_pll1_out_even = {
+	.offset = 0x1000,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_cam_cc_pll1_out_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll1_out_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_pll1_out_even",
+		.parent_hws = (const struct clk_hw*[]){
+			&cam_cc_pll1.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_lucid_ops,
+	},
+};
+
+static const struct alpha_pll_config cam_cc_pll2_config = {
+	.l = 0x4b,
+	.alpha = 0x0,
+	.config_ctl_val = 0x08200920,
+	.config_ctl_hi_val = 0x05002015,
+	.config_ctl_hi1_val = 0x00000000,
+	.user_ctl_val = 0x00000100,
+	.user_ctl_hi_val = 0x00000000,
+	.user_ctl_hi1_val = 0x00000000,
+};
+
+static struct clk_alpha_pll cam_cc_pll2 = {
+	.offset = 0x2000,
+	.vco_table = zonda_vco,
+	.num_vco = ARRAY_SIZE(zonda_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_ZONDA],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_pll2",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_zonda_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_cam_cc_pll2_out_main[] = {
+	{ 0x1, 2 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv cam_cc_pll2_out_main = {
+	.offset = 0x2000,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_cam_cc_pll2_out_main,
+	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll2_out_main),
+	.width = 2,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_ZONDA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_pll2_out_main",
+		.parent_hws = (const struct clk_hw*[]){
+			&cam_cc_pll2.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_zonda_ops,
+	},
+};
+
+static const struct alpha_pll_config cam_cc_pll3_config = {
+	.l = 0x24,
+	.alpha = 0x7555,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002261,
+	.config_ctl_hi1_val = 0x329A699c,
+	.user_ctl_val = 0x00000100,
+	.user_ctl_hi_val = 0x00000805,
+	.user_ctl_hi1_val = 0x00000000,
+};
+
+static struct clk_alpha_pll cam_cc_pll3 = {
+	.offset = 0x3000,
+	.vco_table = lucid_vco,
+	.num_vco = ARRAY_SIZE(lucid_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_pll3",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_lucid_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_cam_cc_pll3_out_even[] = {
+	{ 0x1, 2 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv cam_cc_pll3_out_even = {
+	.offset = 0x3000,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_cam_cc_pll3_out_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll3_out_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_pll3_out_even",
+		.parent_hws = (const struct clk_hw*[]){
+			&cam_cc_pll3.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_lucid_ops,
+	},
+};
+
+static const struct alpha_pll_config cam_cc_pll4_config = {
+	.l = 0x24,
+	.alpha = 0x7555,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002261,
+	.config_ctl_hi1_val = 0x329A699c,
+	.user_ctl_val = 0x00000100,
+	.user_ctl_hi_val = 0x00000805,
+	.user_ctl_hi1_val = 0x00000000,
+};
+
+static struct clk_alpha_pll cam_cc_pll4 = {
+	.offset = 0x4000,
+	.vco_table = lucid_vco,
+	.num_vco = ARRAY_SIZE(lucid_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_pll4",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_lucid_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_cam_cc_pll4_out_even[] = {
+	{ 0x1, 2 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv cam_cc_pll4_out_even = {
+	.offset = 0x4000,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_cam_cc_pll4_out_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll4_out_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_pll4_out_even",
+		.parent_hws = (const struct clk_hw*[]){
+			&cam_cc_pll4.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_lucid_ops,
+	},
+};
+
+static const struct parent_map cam_cc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAM_CC_PLL0_OUT_MAIN, 1 },
+	{ P_CAM_CC_PLL0_OUT_EVEN, 2 },
+	{ P_CAM_CC_PLL0_OUT_ODD, 3 },
+	{ P_CAM_CC_PLL2_OUT_MAIN, 5 },
+};
+
+static const struct clk_parent_data cam_cc_parent_data_0[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &cam_cc_pll0.clkr.hw },
+	{ .hw = &cam_cc_pll0_out_even.clkr.hw },
+	{ .hw = &cam_cc_pll0_out_odd.clkr.hw },
+	{ .hw = &cam_cc_pll2_out_main.clkr.hw },
+};
+
+static const struct parent_map cam_cc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAM_CC_PLL2_OUT_EARLY, 5 },
+};
+
+static const struct clk_parent_data cam_cc_parent_data_1[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &cam_cc_pll2.clkr.hw },
+};
+
+static const struct parent_map cam_cc_parent_map_2[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAM_CC_PLL3_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data cam_cc_parent_data_2[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &cam_cc_pll3_out_even.clkr.hw },
+};
+
+static const struct parent_map cam_cc_parent_map_3[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAM_CC_PLL4_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data cam_cc_parent_data_3[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &cam_cc_pll4_out_even.clkr.hw },
+};
+
+static const struct parent_map cam_cc_parent_map_4[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAM_CC_PLL1_OUT_EVEN, 4 },
+};
+
+static const struct clk_parent_data cam_cc_parent_data_4[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &cam_cc_pll1_out_even.clkr.hw },
+};
+
+static const struct parent_map cam_cc_parent_map_5[] = {
+	{ P_SLEEP_CLK, 0 },
+};
+
+static const struct clk_parent_data cam_cc_parent_data_5[] = {
+	{ .fw_name = "sleep_clk" },
+};
+
+static const struct parent_map cam_cc_parent_map_6[] = {
+	{ P_BI_TCXO, 0 },
+};
+
+static const struct clk_parent_data cam_cc_parent_data_6[] = {
+	{ .fw_name = "bi_tcxo" },
+};
+
+static const struct freq_tbl ftbl_cam_cc_bps_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(100000000, P_CAM_CC_PLL0_OUT_EVEN, 6, 0, 0),
+	F(200000000, P_CAM_CC_PLL0_OUT_ODD, 2, 0, 0),
+	F(400000000, P_CAM_CC_PLL0_OUT_ODD, 1, 0, 0),
+	F(480000000, P_CAM_CC_PLL2_OUT_MAIN, 1.5, 0, 0),
+	F(600000000, P_CAM_CC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_bps_clk_src = {
+	.cmd_rcgr = 0x7010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_bps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_bps_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_camnoc_axi_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(300000000, P_CAM_CC_PLL0_OUT_EVEN, 2, 0, 0),
+	F(400000000, P_CAM_CC_PLL0_OUT_ODD, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_camnoc_axi_clk_src = {
+	.cmd_rcgr = 0xc0f8,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_camnoc_axi_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_camnoc_axi_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_cci_0_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(37500000, P_CAM_CC_PLL0_OUT_EVEN, 16, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_cci_0_clk_src = {
+	.cmd_rcgr = 0xc0bc,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_cci_0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_cci_0_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_cci_1_clk_src = {
+	.cmd_rcgr = 0xc0d8,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_cci_0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_cci_1_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_cphy_rx_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(400000000, P_CAM_CC_PLL0_OUT_ODD, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_cphy_rx_clk_src = {
+	.cmd_rcgr = 0xa068,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_cphy_rx_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_cphy_rx_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_csi0phytimer_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(300000000, P_CAM_CC_PLL0_OUT_EVEN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_csi0phytimer_clk_src = {
+	.cmd_rcgr = 0x6000,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_csi0phytimer_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_csi1phytimer_clk_src = {
+	.cmd_rcgr = 0x6020,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_csi1phytimer_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_csi2phytimer_clk_src = {
+	.cmd_rcgr = 0x6040,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_csi2phytimer_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_csi3phytimer_clk_src = {
+	.cmd_rcgr = 0x6060,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_csi3phytimer_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_csi4phytimer_clk_src = {
+	.cmd_rcgr = 0x6080,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_csi4phytimer_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_csi5phytimer_clk_src = {
+	.cmd_rcgr = 0x60a0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_csi5phytimer_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_fast_ahb_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(50000000, P_CAM_CC_PLL0_OUT_EVEN, 12, 0, 0),
+	F(100000000, P_CAM_CC_PLL0_OUT_EVEN, 6, 0, 0),
+	F(200000000, P_CAM_CC_PLL0_OUT_EVEN, 3, 0, 0),
+	F(300000000, P_CAM_CC_PLL0_OUT_MAIN, 4, 0, 0),
+	F(400000000, P_CAM_CC_PLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_fast_ahb_clk_src = {
+	.cmd_rcgr = 0x703c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_fast_ahb_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_fast_ahb_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_fd_core_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(400000000, P_CAM_CC_PLL0_OUT_ODD, 1, 0, 0),
+	F(480000000, P_CAM_CC_PLL2_OUT_MAIN, 1.5, 0, 0),
+	F(600000000, P_CAM_CC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_fd_core_clk_src = {
+	.cmd_rcgr = 0xc098,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_fd_core_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_fd_core_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_icp_clk_src = {
+	.cmd_rcgr = 0xc074,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_fd_core_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_icp_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_ife_0_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(350000000, P_CAM_CC_PLL3_OUT_EVEN, 1, 0, 0),
+	F(475000000, P_CAM_CC_PLL3_OUT_EVEN, 1, 0, 0),
+	F(576000000, P_CAM_CC_PLL3_OUT_EVEN, 1, 0, 0),
+	F(680000000, P_CAM_CC_PLL3_OUT_EVEN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_ife_0_clk_src = {
+	.cmd_rcgr = 0xa010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_2,
+	.freq_tbl = ftbl_cam_cc_ife_0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_ife_0_clk_src",
+		.parent_data = cam_cc_parent_data_2,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div cam_cc_sbi_div_clk_src = {
+	.reg = 0x9010,
+	.shift = 0,
+	.width = 3,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "cam_cc_sbi_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&cam_cc_ife_0_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_ife_0_csid_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(75000000, P_CAM_CC_PLL0_OUT_EVEN, 8, 0, 0),
+	F(400000000, P_CAM_CC_PLL0_OUT_ODD, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_ife_0_csid_clk_src = {
+	.cmd_rcgr = 0xa040,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_ife_0_csid_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_ife_0_csid_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_ife_1_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(350000000, P_CAM_CC_PLL4_OUT_EVEN, 1, 0, 0),
+	F(475000000, P_CAM_CC_PLL4_OUT_EVEN, 1, 0, 0),
+	F(576000000, P_CAM_CC_PLL4_OUT_EVEN, 1, 0, 0),
+	F(680000000, P_CAM_CC_PLL4_OUT_EVEN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_ife_1_clk_src = {
+	.cmd_rcgr = 0xb010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_3,
+	.freq_tbl = ftbl_cam_cc_ife_1_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_ife_1_clk_src",
+		.parent_data = cam_cc_parent_data_3,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_3),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_ife_1_csid_clk_src = {
+	.cmd_rcgr = 0xb040,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_ife_0_csid_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_ife_1_csid_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_ife_lite_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(400000000, P_CAM_CC_PLL0_OUT_ODD, 1, 0, 0),
+	F(480000000, P_CAM_CC_PLL2_OUT_MAIN, 1.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_ife_lite_clk_src = {
+	.cmd_rcgr = 0xc000,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_ife_lite_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_ife_lite_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_ife_lite_csid_clk_src = {
+	.cmd_rcgr = 0xc01c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_cphy_rx_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_ife_lite_csid_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_ipe_0_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(300000000, P_CAM_CC_PLL1_OUT_EVEN, 1, 0, 0),
+	F(475000000, P_CAM_CC_PLL1_OUT_EVEN, 1, 0, 0),
+	F(525000000, P_CAM_CC_PLL1_OUT_EVEN, 1, 0, 0),
+	F(700000000, P_CAM_CC_PLL1_OUT_EVEN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_ipe_0_clk_src = {
+	.cmd_rcgr = 0x8010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_4,
+	.freq_tbl = ftbl_cam_cc_ipe_0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_ipe_0_clk_src",
+		.parent_data = cam_cc_parent_data_4,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_4),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_jpeg_clk_src = {
+	.cmd_rcgr = 0xc048,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_bps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_jpeg_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_mclk0_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(24000000, P_CAM_CC_PLL2_OUT_EARLY, 10, 1, 6),
+	F(68571429, P_CAM_CC_PLL2_OUT_EARLY, 1, 1, 21),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_mclk0_clk_src = {
+	.cmd_rcgr = 0x5000,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_1,
+	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_mclk0_clk_src",
+		.parent_data = cam_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_mclk1_clk_src = {
+	.cmd_rcgr = 0x501c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_1,
+	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_mclk1_clk_src",
+		.parent_data = cam_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_mclk2_clk_src = {
+	.cmd_rcgr = 0x5038,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_1,
+	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_mclk2_clk_src",
+		.parent_data = cam_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_mclk3_clk_src = {
+	.cmd_rcgr = 0x5054,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_1,
+	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_mclk3_clk_src",
+		.parent_data = cam_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_mclk4_clk_src = {
+	.cmd_rcgr = 0x5070,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_1,
+	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_mclk4_clk_src",
+		.parent_data = cam_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_mclk5_clk_src = {
+	.cmd_rcgr = 0x508c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_1,
+	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_mclk5_clk_src",
+		.parent_data = cam_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_mclk6_clk_src = {
+	.cmd_rcgr = 0x50a8,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_1,
+	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_mclk6_clk_src",
+		.parent_data = cam_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 cam_cc_sbi_csid_clk_src = {
+	.cmd_rcgr = 0x901c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_cphy_rx_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_sbi_csid_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_sleep_clk_src[] = {
+	F(32768, P_SLEEP_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_sleep_clk_src = {
+	.cmd_rcgr = 0xc170,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_5,
+	.freq_tbl = ftbl_cam_cc_sleep_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_sleep_clk_src",
+		.parent_data = cam_cc_parent_data_5,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_5),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_slow_ahb_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(80000000, P_CAM_CC_PLL0_OUT_EVEN, 7.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_slow_ahb_clk_src = {
+	.cmd_rcgr = 0x7058,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_0,
+	.freq_tbl = ftbl_cam_cc_slow_ahb_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_slow_ahb_clk_src",
+		.parent_data = cam_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cam_cc_xo_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cam_cc_xo_clk_src = {
+	.cmd_rcgr = 0xc154,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = cam_cc_parent_map_6,
+	.freq_tbl = ftbl_cam_cc_xo_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cam_cc_xo_clk_src",
+		.parent_data = cam_cc_parent_data_6,
+		.num_parents = ARRAY_SIZE(cam_cc_parent_data_6),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch cam_cc_bps_ahb_clk = {
+	.halt_reg = 0x7070,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x7070,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_bps_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_slow_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_bps_areg_clk = {
+	.halt_reg = 0x7054,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x7054,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_bps_areg_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_fast_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_bps_axi_clk = {
+	.halt_reg = 0x7038,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x7038,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_bps_axi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_camnoc_axi_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_bps_clk = {
+	.halt_reg = 0x7028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x7028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_bps_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_bps_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_camnoc_axi_clk = {
+	.halt_reg = 0xc114,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc114,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_camnoc_axi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_camnoc_axi_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_camnoc_dcd_xo_clk = {
+	.halt_reg = 0xc11c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc11c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_camnoc_dcd_xo_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_xo_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_cci_0_clk = {
+	.halt_reg = 0xc0d4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc0d4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_cci_0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_cci_0_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_cci_1_clk = {
+	.halt_reg = 0xc0f0,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc0f0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_cci_1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_cci_1_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_core_ahb_clk = {
+	.halt_reg = 0xc150,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0xc150,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_core_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_slow_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_cpas_ahb_clk = {
+	.halt_reg = 0xc0f4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc0f4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_cpas_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_slow_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_csi0phytimer_clk = {
+	.halt_reg = 0x6018,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_csi0phytimer_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_csi0phytimer_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_csi1phytimer_clk = {
+	.halt_reg = 0x6038,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6038,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_csi1phytimer_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_csi1phytimer_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_csi2phytimer_clk = {
+	.halt_reg = 0x6058,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6058,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_csi2phytimer_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_csi2phytimer_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_csi3phytimer_clk = {
+	.halt_reg = 0x6078,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6078,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_csi3phytimer_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_csi3phytimer_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_csi4phytimer_clk = {
+	.halt_reg = 0x6098,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6098,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_csi4phytimer_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_csi4phytimer_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_csi5phytimer_clk = {
+	.halt_reg = 0x60b8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x60b8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_csi5phytimer_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_csi5phytimer_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_csiphy0_clk = {
+	.halt_reg = 0x601c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x601c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_csiphy0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_csiphy1_clk = {
+	.halt_reg = 0x603c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x603c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_csiphy1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_csiphy2_clk = {
+	.halt_reg = 0x605c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x605c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_csiphy2_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_csiphy3_clk = {
+	.halt_reg = 0x607c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x607c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_csiphy3_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_csiphy4_clk = {
+	.halt_reg = 0x609c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x609c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_csiphy4_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_csiphy5_clk = {
+	.halt_reg = 0x60bc,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x60bc,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_csiphy5_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_fd_core_clk = {
+	.halt_reg = 0xc0b0,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc0b0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_fd_core_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_fd_core_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_fd_core_uar_clk = {
+	.halt_reg = 0xc0b8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc0b8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_fd_core_uar_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_fd_core_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_gdsc_clk = {
+	.halt_reg = 0xc16c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc16c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_gdsc_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_xo_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_icp_ahb_clk = {
+	.halt_reg = 0xc094,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc094,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_icp_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_slow_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_icp_clk = {
+	.halt_reg = 0xc08c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc08c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_icp_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_icp_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_0_ahb_clk = {
+	.halt_reg = 0xa088,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa088,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_0_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_slow_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_0_areg_clk = {
+	.halt_reg = 0xa030,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa030,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_0_areg_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_fast_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_0_axi_clk = {
+	.halt_reg = 0xa084,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa084,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_0_axi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_camnoc_axi_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_0_clk = {
+	.halt_reg = 0xa028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_ife_0_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_0_cphy_rx_clk = {
+	.halt_reg = 0xa080,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa080,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_0_cphy_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_0_csid_clk = {
+	.halt_reg = 0xa058,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa058,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_0_csid_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_ife_0_csid_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_0_dsp_clk = {
+	.halt_reg = 0xa03c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa03c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_0_dsp_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_ife_0_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_1_ahb_clk = {
+	.halt_reg = 0xb068,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb068,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_1_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_slow_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_1_areg_clk = {
+	.halt_reg = 0xb030,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb030,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_1_areg_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_fast_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_1_axi_clk = {
+	.halt_reg = 0xb064,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb064,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_1_axi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_camnoc_axi_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_1_clk = {
+	.halt_reg = 0xb028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_ife_1_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_1_cphy_rx_clk = {
+	.halt_reg = 0xb060,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb060,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_1_cphy_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_1_csid_clk = {
+	.halt_reg = 0xb058,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb058,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_1_csid_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_ife_1_csid_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_1_dsp_clk = {
+	.halt_reg = 0xb03c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb03c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_1_dsp_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_ife_1_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_lite_ahb_clk = {
+	.halt_reg = 0xc040,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_lite_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_slow_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_lite_axi_clk = {
+	.halt_reg = 0xc044,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc044,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_lite_axi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_camnoc_axi_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_lite_clk = {
+	.halt_reg = 0xc018,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_lite_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_ife_lite_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_lite_cphy_rx_clk = {
+	.halt_reg = 0xc03c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc03c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_lite_cphy_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ife_lite_csid_clk = {
+	.halt_reg = 0xc034,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc034,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ife_lite_csid_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_ife_lite_csid_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ipe_0_ahb_clk = {
+	.halt_reg = 0x8040,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ipe_0_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_slow_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ipe_0_areg_clk = {
+	.halt_reg = 0x803c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x803c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ipe_0_areg_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_fast_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ipe_0_axi_clk = {
+	.halt_reg = 0x8038,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8038,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ipe_0_axi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_camnoc_axi_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_ipe_0_clk = {
+	.halt_reg = 0x8028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_ipe_0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_ipe_0_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_jpeg_clk = {
+	.halt_reg = 0xc060,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc060,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_jpeg_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_jpeg_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_mclk0_clk = {
+	.halt_reg = 0x5018,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_mclk0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_mclk0_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_mclk1_clk = {
+	.halt_reg = 0x5034,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5034,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_mclk1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_mclk1_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_mclk2_clk = {
+	.halt_reg = 0x5050,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5050,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_mclk2_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_mclk2_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_mclk3_clk = {
+	.halt_reg = 0x506c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x506c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_mclk3_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_mclk3_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_mclk4_clk = {
+	.halt_reg = 0x5088,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5088,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_mclk4_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_mclk4_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_mclk5_clk = {
+	.halt_reg = 0x50a4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x50a4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_mclk5_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_mclk5_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_mclk6_clk = {
+	.halt_reg = 0x50c0,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x50c0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_mclk6_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_mclk6_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_sbi_ahb_clk = {
+	.halt_reg = 0x9040,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_sbi_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_slow_ahb_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_sbi_axi_clk = {
+	.halt_reg = 0x903c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x903c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_sbi_axi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_camnoc_axi_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_sbi_clk = {
+	.halt_reg = 0x9014,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9014,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_sbi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_sbi_div_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_sbi_cphy_rx_clk = {
+	.halt_reg = 0x9038,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9038,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_sbi_cphy_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_cphy_rx_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_sbi_csid_clk = {
+	.halt_reg = 0x9034,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9034,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_sbi_csid_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_sbi_csid_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_sbi_ife_0_clk = {
+	.halt_reg = 0x9044,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9044,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_sbi_ife_0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_ife_0_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_sbi_ife_1_clk = {
+	.halt_reg = 0x9048,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9048,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_sbi_ife_1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_ife_1_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch cam_cc_sleep_clk = {
+	.halt_reg = 0xc188,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc188,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "cam_cc_sleep_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&cam_cc_sleep_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc bps_gdsc = {
+	.gdscr = 0x7004,
+	.pd = {
+		.name = "bps_gdsc",
+	},
+	.flags = HW_CTRL | POLL_CFG_GDSCR,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc ipe_0_gdsc = {
+	.gdscr = 0x8004,
+	.pd = {
+		.name = "ipe_0_gdsc",
+	},
+	.flags = HW_CTRL | POLL_CFG_GDSCR,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc sbi_gdsc = {
+	.gdscr = 0x9004,
+	.pd = {
+		.name = "sbi_gdsc",
+	},
+	.flags = HW_CTRL | POLL_CFG_GDSCR,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc ife_0_gdsc = {
+	.gdscr = 0xa004,
+	.pd = {
+		.name = "ife_0_gdsc",
+	},
+	.flags = POLL_CFG_GDSCR,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc ife_1_gdsc = {
+	.gdscr = 0xb004,
+	.pd = {
+		.name = "ife_1_gdsc",
+	},
+	.flags = POLL_CFG_GDSCR,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc titan_top_gdsc = {
+	.gdscr = 0xc144,
+	.pd = {
+		.name = "titan_top_gdsc",
+	},
+	.flags = POLL_CFG_GDSCR,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct clk_regmap *cam_cc_sm8250_clocks[] = {
+	[CAM_CC_BPS_AHB_CLK] = &cam_cc_bps_ahb_clk.clkr,
+	[CAM_CC_BPS_AREG_CLK] = &cam_cc_bps_areg_clk.clkr,
+	[CAM_CC_BPS_AXI_CLK] = &cam_cc_bps_axi_clk.clkr,
+	[CAM_CC_BPS_CLK] = &cam_cc_bps_clk.clkr,
+	[CAM_CC_BPS_CLK_SRC] = &cam_cc_bps_clk_src.clkr,
+	[CAM_CC_CAMNOC_AXI_CLK] = &cam_cc_camnoc_axi_clk.clkr,
+	[CAM_CC_CAMNOC_AXI_CLK_SRC] = &cam_cc_camnoc_axi_clk_src.clkr,
+	[CAM_CC_CAMNOC_DCD_XO_CLK] = &cam_cc_camnoc_dcd_xo_clk.clkr,
+	[CAM_CC_CCI_0_CLK] = &cam_cc_cci_0_clk.clkr,
+	[CAM_CC_CCI_0_CLK_SRC] = &cam_cc_cci_0_clk_src.clkr,
+	[CAM_CC_CCI_1_CLK] = &cam_cc_cci_1_clk.clkr,
+	[CAM_CC_CCI_1_CLK_SRC] = &cam_cc_cci_1_clk_src.clkr,
+	[CAM_CC_CORE_AHB_CLK] = &cam_cc_core_ahb_clk.clkr,
+	[CAM_CC_CPAS_AHB_CLK] = &cam_cc_cpas_ahb_clk.clkr,
+	[CAM_CC_CPHY_RX_CLK_SRC] = &cam_cc_cphy_rx_clk_src.clkr,
+	[CAM_CC_CSI0PHYTIMER_CLK] = &cam_cc_csi0phytimer_clk.clkr,
+	[CAM_CC_CSI0PHYTIMER_CLK_SRC] = &cam_cc_csi0phytimer_clk_src.clkr,
+	[CAM_CC_CSI1PHYTIMER_CLK] = &cam_cc_csi1phytimer_clk.clkr,
+	[CAM_CC_CSI1PHYTIMER_CLK_SRC] = &cam_cc_csi1phytimer_clk_src.clkr,
+	[CAM_CC_CSI2PHYTIMER_CLK] = &cam_cc_csi2phytimer_clk.clkr,
+	[CAM_CC_CSI2PHYTIMER_CLK_SRC] = &cam_cc_csi2phytimer_clk_src.clkr,
+	[CAM_CC_CSI3PHYTIMER_CLK] = &cam_cc_csi3phytimer_clk.clkr,
+	[CAM_CC_CSI3PHYTIMER_CLK_SRC] = &cam_cc_csi3phytimer_clk_src.clkr,
+	[CAM_CC_CSI4PHYTIMER_CLK] = &cam_cc_csi4phytimer_clk.clkr,
+	[CAM_CC_CSI4PHYTIMER_CLK_SRC] = &cam_cc_csi4phytimer_clk_src.clkr,
+	[CAM_CC_CSI5PHYTIMER_CLK] = &cam_cc_csi5phytimer_clk.clkr,
+	[CAM_CC_CSI5PHYTIMER_CLK_SRC] = &cam_cc_csi5phytimer_clk_src.clkr,
+	[CAM_CC_CSIPHY0_CLK] = &cam_cc_csiphy0_clk.clkr,
+	[CAM_CC_CSIPHY1_CLK] = &cam_cc_csiphy1_clk.clkr,
+	[CAM_CC_CSIPHY2_CLK] = &cam_cc_csiphy2_clk.clkr,
+	[CAM_CC_CSIPHY3_CLK] = &cam_cc_csiphy3_clk.clkr,
+	[CAM_CC_CSIPHY4_CLK] = &cam_cc_csiphy4_clk.clkr,
+	[CAM_CC_CSIPHY5_CLK] = &cam_cc_csiphy5_clk.clkr,
+	[CAM_CC_FAST_AHB_CLK_SRC] = &cam_cc_fast_ahb_clk_src.clkr,
+	[CAM_CC_FD_CORE_CLK] = &cam_cc_fd_core_clk.clkr,
+	[CAM_CC_FD_CORE_CLK_SRC] = &cam_cc_fd_core_clk_src.clkr,
+	[CAM_CC_FD_CORE_UAR_CLK] = &cam_cc_fd_core_uar_clk.clkr,
+	[CAM_CC_GDSC_CLK] = &cam_cc_gdsc_clk.clkr,
+	[CAM_CC_ICP_AHB_CLK] = &cam_cc_icp_ahb_clk.clkr,
+	[CAM_CC_ICP_CLK] = &cam_cc_icp_clk.clkr,
+	[CAM_CC_ICP_CLK_SRC] = &cam_cc_icp_clk_src.clkr,
+	[CAM_CC_IFE_0_AHB_CLK] = &cam_cc_ife_0_ahb_clk.clkr,
+	[CAM_CC_IFE_0_AREG_CLK] = &cam_cc_ife_0_areg_clk.clkr,
+	[CAM_CC_IFE_0_AXI_CLK] = &cam_cc_ife_0_axi_clk.clkr,
+	[CAM_CC_IFE_0_CLK] = &cam_cc_ife_0_clk.clkr,
+	[CAM_CC_IFE_0_CLK_SRC] = &cam_cc_ife_0_clk_src.clkr,
+	[CAM_CC_IFE_0_CPHY_RX_CLK] = &cam_cc_ife_0_cphy_rx_clk.clkr,
+	[CAM_CC_IFE_0_CSID_CLK] = &cam_cc_ife_0_csid_clk.clkr,
+	[CAM_CC_IFE_0_CSID_CLK_SRC] = &cam_cc_ife_0_csid_clk_src.clkr,
+	[CAM_CC_IFE_0_DSP_CLK] = &cam_cc_ife_0_dsp_clk.clkr,
+	[CAM_CC_IFE_1_AHB_CLK] = &cam_cc_ife_1_ahb_clk.clkr,
+	[CAM_CC_IFE_1_AREG_CLK] = &cam_cc_ife_1_areg_clk.clkr,
+	[CAM_CC_IFE_1_AXI_CLK] = &cam_cc_ife_1_axi_clk.clkr,
+	[CAM_CC_IFE_1_CLK] = &cam_cc_ife_1_clk.clkr,
+	[CAM_CC_IFE_1_CLK_SRC] = &cam_cc_ife_1_clk_src.clkr,
+	[CAM_CC_IFE_1_CPHY_RX_CLK] = &cam_cc_ife_1_cphy_rx_clk.clkr,
+	[CAM_CC_IFE_1_CSID_CLK] = &cam_cc_ife_1_csid_clk.clkr,
+	[CAM_CC_IFE_1_CSID_CLK_SRC] = &cam_cc_ife_1_csid_clk_src.clkr,
+	[CAM_CC_IFE_1_DSP_CLK] = &cam_cc_ife_1_dsp_clk.clkr,
+	[CAM_CC_IFE_LITE_AHB_CLK] = &cam_cc_ife_lite_ahb_clk.clkr,
+	[CAM_CC_IFE_LITE_AXI_CLK] = &cam_cc_ife_lite_axi_clk.clkr,
+	[CAM_CC_IFE_LITE_CLK] = &cam_cc_ife_lite_clk.clkr,
+	[CAM_CC_IFE_LITE_CLK_SRC] = &cam_cc_ife_lite_clk_src.clkr,
+	[CAM_CC_IFE_LITE_CPHY_RX_CLK] = &cam_cc_ife_lite_cphy_rx_clk.clkr,
+	[CAM_CC_IFE_LITE_CSID_CLK] = &cam_cc_ife_lite_csid_clk.clkr,
+	[CAM_CC_IFE_LITE_CSID_CLK_SRC] = &cam_cc_ife_lite_csid_clk_src.clkr,
+	[CAM_CC_IPE_0_AHB_CLK] = &cam_cc_ipe_0_ahb_clk.clkr,
+	[CAM_CC_IPE_0_AREG_CLK] = &cam_cc_ipe_0_areg_clk.clkr,
+	[CAM_CC_IPE_0_AXI_CLK] = &cam_cc_ipe_0_axi_clk.clkr,
+	[CAM_CC_IPE_0_CLK] = &cam_cc_ipe_0_clk.clkr,
+	[CAM_CC_IPE_0_CLK_SRC] = &cam_cc_ipe_0_clk_src.clkr,
+	[CAM_CC_JPEG_CLK] = &cam_cc_jpeg_clk.clkr,
+	[CAM_CC_JPEG_CLK_SRC] = &cam_cc_jpeg_clk_src.clkr,
+	[CAM_CC_MCLK0_CLK] = &cam_cc_mclk0_clk.clkr,
+	[CAM_CC_MCLK0_CLK_SRC] = &cam_cc_mclk0_clk_src.clkr,
+	[CAM_CC_MCLK1_CLK] = &cam_cc_mclk1_clk.clkr,
+	[CAM_CC_MCLK1_CLK_SRC] = &cam_cc_mclk1_clk_src.clkr,
+	[CAM_CC_MCLK2_CLK] = &cam_cc_mclk2_clk.clkr,
+	[CAM_CC_MCLK2_CLK_SRC] = &cam_cc_mclk2_clk_src.clkr,
+	[CAM_CC_MCLK3_CLK] = &cam_cc_mclk3_clk.clkr,
+	[CAM_CC_MCLK3_CLK_SRC] = &cam_cc_mclk3_clk_src.clkr,
+	[CAM_CC_MCLK4_CLK] = &cam_cc_mclk4_clk.clkr,
+	[CAM_CC_MCLK4_CLK_SRC] = &cam_cc_mclk4_clk_src.clkr,
+	[CAM_CC_MCLK5_CLK] = &cam_cc_mclk5_clk.clkr,
+	[CAM_CC_MCLK5_CLK_SRC] = &cam_cc_mclk5_clk_src.clkr,
+	[CAM_CC_MCLK6_CLK] = &cam_cc_mclk6_clk.clkr,
+	[CAM_CC_MCLK6_CLK_SRC] = &cam_cc_mclk6_clk_src.clkr,
+	[CAM_CC_PLL0] = &cam_cc_pll0.clkr,
+	[CAM_CC_PLL0_OUT_EVEN] = &cam_cc_pll0_out_even.clkr,
+	[CAM_CC_PLL0_OUT_ODD] = &cam_cc_pll0_out_odd.clkr,
+	[CAM_CC_PLL1] = &cam_cc_pll1.clkr,
+	[CAM_CC_PLL1_OUT_EVEN] = &cam_cc_pll1_out_even.clkr,
+	[CAM_CC_PLL2] = &cam_cc_pll2.clkr,
+	[CAM_CC_PLL2_OUT_MAIN] = &cam_cc_pll2_out_main.clkr,
+	[CAM_CC_PLL3] = &cam_cc_pll3.clkr,
+	[CAM_CC_PLL3_OUT_EVEN] = &cam_cc_pll3_out_even.clkr,
+	[CAM_CC_PLL4] = &cam_cc_pll4.clkr,
+	[CAM_CC_PLL4_OUT_EVEN] = &cam_cc_pll4_out_even.clkr,
+	[CAM_CC_SBI_AHB_CLK] = &cam_cc_sbi_ahb_clk.clkr,
+	[CAM_CC_SBI_AXI_CLK] = &cam_cc_sbi_axi_clk.clkr,
+	[CAM_CC_SBI_CLK] = &cam_cc_sbi_clk.clkr,
+	[CAM_CC_SBI_CPHY_RX_CLK] = &cam_cc_sbi_cphy_rx_clk.clkr,
+	[CAM_CC_SBI_CSID_CLK] = &cam_cc_sbi_csid_clk.clkr,
+	[CAM_CC_SBI_CSID_CLK_SRC] = &cam_cc_sbi_csid_clk_src.clkr,
+	[CAM_CC_SBI_DIV_CLK_SRC] = &cam_cc_sbi_div_clk_src.clkr,
+	[CAM_CC_SBI_IFE_0_CLK] = &cam_cc_sbi_ife_0_clk.clkr,
+	[CAM_CC_SBI_IFE_1_CLK] = &cam_cc_sbi_ife_1_clk.clkr,
+	[CAM_CC_SLEEP_CLK] = &cam_cc_sleep_clk.clkr,
+	[CAM_CC_SLEEP_CLK_SRC] = &cam_cc_sleep_clk_src.clkr,
+	[CAM_CC_SLOW_AHB_CLK_SRC] = &cam_cc_slow_ahb_clk_src.clkr,
+	[CAM_CC_XO_CLK_SRC] = &cam_cc_xo_clk_src.clkr,
+};
+
+static struct gdsc *cam_cc_sm8250_gdscs[] = {
+	[BPS_GDSC] = &bps_gdsc,
+	[IPE_0_GDSC] = &ipe_0_gdsc,
+	[SBI_GDSC] = &sbi_gdsc,
+	[IFE_0_GDSC] = &ife_0_gdsc,
+	[IFE_1_GDSC] = &ife_1_gdsc,
+	[TITAN_TOP_GDSC] = &titan_top_gdsc,
+};
+
+static const struct qcom_reset_map cam_cc_sm8250_resets[] = {
+	[CAM_CC_BPS_BCR] = { 0x7000 },
+	[CAM_CC_ICP_BCR] = { 0xc070 },
+	[CAM_CC_IFE_0_BCR] = { 0xa000 },
+	[CAM_CC_IFE_1_BCR] = { 0xb000 },
+	[CAM_CC_IPE_0_BCR] = { 0x8000 },
+	[CAM_CC_SBI_BCR] = { 0x9000 },
+};
+
+static const struct regmap_config cam_cc_sm8250_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xe004,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc cam_cc_sm8250_desc = {
+	.config = &cam_cc_sm8250_regmap_config,
+	.clks = cam_cc_sm8250_clocks,
+	.num_clks = ARRAY_SIZE(cam_cc_sm8250_clocks),
+	.resets = cam_cc_sm8250_resets,
+	.num_resets = ARRAY_SIZE(cam_cc_sm8250_resets),
+	.gdscs = cam_cc_sm8250_gdscs,
+	.num_gdscs = ARRAY_SIZE(cam_cc_sm8250_gdscs),
+};
+
+static const struct of_device_id cam_cc_sm8250_match_table[] = {
+	{ .compatible = "qcom,sm8250-camcc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cam_cc_sm8250_match_table);
+
+static int cam_cc_sm8250_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &cam_cc_sm8250_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_lucid_pll_configure(&cam_cc_pll0, regmap, &cam_cc_pll0_config);
+	clk_lucid_pll_configure(&cam_cc_pll1, regmap, &cam_cc_pll1_config);
+	clk_zonda_pll_configure(&cam_cc_pll2, regmap, &cam_cc_pll2_config);
+	clk_lucid_pll_configure(&cam_cc_pll3, regmap, &cam_cc_pll3_config);
+	clk_lucid_pll_configure(&cam_cc_pll4, regmap, &cam_cc_pll4_config);
+
+	return qcom_cc_really_probe(pdev, &cam_cc_sm8250_desc, regmap);
+}
+
+static struct platform_driver cam_cc_sm8250_driver = {
+	.probe = cam_cc_sm8250_probe,
+	.driver = {
+		.name = "cam_cc-sm8250",
+		.of_match_table = cam_cc_sm8250_match_table,
+	},
+};
+
+static int __init cam_cc_sm8250_init(void)
+{
+	return platform_driver_register(&cam_cc_sm8250_driver);
+}
+subsys_initcall(cam_cc_sm8250_init);
+
+static void __exit cam_cc_sm8250_exit(void)
+{
+	platform_driver_unregister(&cam_cc_sm8250_driver);
+}
+module_exit(cam_cc_sm8250_exit);
+
+MODULE_DESCRIPTION("QTI CAMCC SM8250 Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.26.1

