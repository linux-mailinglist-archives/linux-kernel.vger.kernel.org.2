Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888A73FD2B5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbhIAFGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:06:53 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38075 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241935AbhIAFGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:06:33 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 31C435C01E7;
        Wed,  1 Sep 2021 01:05:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 01 Sep 2021 01:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=8mv7j7KBB2uyL
        uFOCm+bMLa9wn2hDUe88jDS++BBLho=; b=hLu5bHfXW02pnPQBlZo4z8o9ae40K
        3CcPEQr1WDBWJSMZ33oNT7wAb8hp+B0sFDi43jOy/JdZZuq/DJBSTaLI/4tOVzpL
        1Lq1zoPay8gKlF96yCQkSH3umLfWbRtA8PXfaqaMqWK+ux9hcyAR8+oN4fFPrMWp
        3WEXmgnSgbHVWnuaLMbzz6yroWAZKAiWwowKC+BW+Iyhczm4CyVbMteeNGEmGkJl
        RINLAE5bfdC4Qvye6Tjm7fl6HPdj+yh/qxa+po2QUP5nc19ePTbPLsDLlP4Jy4Uj
        Gxf9k+JUmiZZOX4DJRglxH9jNjCTYCYMTf0Hl9wMztWSzZ+Q9b8YKKQXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=8mv7j7KBB2uyLuFOCm+bMLa9wn2hDUe88jDS++BBLho=; b=qV/BSfYw
        sTQPivtDv+FEiKiOROdbRYjFw9NJ4OI5fIF8ZitvYxtIUjn3JWbxy7at04VEg20M
        yTgJ29Mn/C7ZZqv9k3M/Us7T9NTv0zEY9WLOcBoUlByxOvVForObpmLKY4Ez6MWA
        P/ifzbK+R3pDQ3JSutzbn244VCEbUEWrW0pMJjut3T1sM8KNeeCcGPUqjN6E8xjU
        BvtvUri6b85hDbjiV11ecJYW2usvJSP03HJdgYizo/9U1tmes/2L7Kg6BUYr+B1f
        uxKkj8ZmfiJMMTgDJs0laplMeDf/RrlZDkkvOQKUZEeW9v22Dvgh0EfVytliS+ne
        zaE+iLDlB9FC9g==
X-ME-Sender: <xms:IQovYYWFQ8QsS-mrYuhw_VUq8twFKv-Zlox7Nv6g2gz8fvKOg0WltA>
    <xme:IQovYclzR-9hclehtJvPHRWNMLMedAdomBVTOjYKVqYli4DkWBBo9UA9xRRX8JVY6
    zWGdSn-Dl2y2zn1EA>
X-ME-Received: <xmr:IQovYcY6HxbhdGY-0trvsT-Z9gogrw2oksaK0rwSKk-h8asOcOIRzfu0kWDampp1FCwaDB7O4zwzOG3KndgcFOxZKD2aZuZQr-v9L-78bw-QlJC3tmp_BV50lRbdqoUNAPlCDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:IQovYXVWhaGawDZlSAQ5ymQl1-E5HXbVC_sXt7hh0gGEOZlZtKgJtw>
    <xmx:IQovYSmykvcvSHLbf_JOT6c4OIrJPIgHMxTBeyzpOQmwNdQ3MwfdWw>
    <xmx:IQovYcdNOYIy8lXU8Shk4TNxCF9L8vCVNMBQMwBMmsUE-fvONywRuw>
    <xmx:IQovYc5gyvVnfjV80UjO8Hro0FhSQTJKHwTwkJ72yPycjnVn3o_vuw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:05:36 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 8/8] clk: sunxi-ng: Allow the CCU core to be built as a module
Date:   Wed,  1 Sep 2021 00:05:26 -0500
Message-Id: <20210901050526.45673-9-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901050526.45673-1-samuel@sholland.org>
References: <20210901050526.45673-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the individual CCU drivers, it can be beneficial for memory
consumption of cross-platform configurations to only load the CCU core
on the relevant platform. For example, a generic arm64 kernel sees the
following improvement when building the CCU core and drivers as modules:

  before:
    text      data     bss     dec       hex      filename
    13882360  5251670  360800  19494830  12977ae  vmlinux

  after:
    text      data     bss     dec       hex      filename
    13734787  5086442  360800  19182029  124b1cd  vmlinux

So the result is a 390KB total reduction in kernel image size.

The one early clock provider (sun5i) requires the core to be built in.

Now that loading the MMC driver will trigger loading the CCU core, the
MMC timing mode functions do not need a compile-time fallback.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/Makefile              |  2 +-
 drivers/clk/sunxi-ng/Kconfig      |  3 ++-
 drivers/clk/sunxi-ng/Makefile     | 33 +++++++++++++++++--------------
 drivers/clk/sunxi-ng/ccu_common.c |  3 +++
 drivers/mmc/host/Kconfig          |  1 +
 include/linux/clk/sunxi-ng.h      | 15 --------------
 6 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 2b91d34c582b..009c4b41a45a 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -110,7 +110,7 @@ obj-$(CONFIG_PLAT_SPEAR)		+= spear/
 obj-y					+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
-obj-$(CONFIG_SUNXI_CCU)			+= sunxi-ng/
+obj-y					+= sunxi-ng/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
 obj-y					+= ti/
 obj-$(CONFIG_CLK_UNIPHIER)		+= uniphier/
diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index cbae3612a9ef..ee383658ff4d 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SUNXI_CCU
-	bool "Clock support for Allwinner SoCs"
+	tristate "Clock support for Allwinner SoCs"
 	depends on ARCH_SUNXI || COMPILE_TEST
 	select RESET_CONTROLLER
 	default ARCH_SUNXI
@@ -52,6 +52,7 @@ config SUN5I_CCU
 	bool "Support for the Allwinner sun5i family CCM"
 	default MACH_SUN5I
 	depends on MACH_SUN5I || COMPILE_TEST
+	depends on SUNXI_CCU=y
 
 config SUN6I_A31_CCU
 	tristate "Support for the Allwinner A31/A31s CCU"
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 9ebf5920c93b..6e9eb004fca0 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -1,24 +1,27 @@
 # SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SUNXI_CCU)		+= sunxi-ccu.o
+
 # Common objects
-obj-y				+= ccu_common.o
-obj-y				+= ccu_mmc_timing.o
-obj-y				+= ccu_reset.o
+sunxi-ccu-y			+= ccu_common.o
+sunxi-ccu-y			+= ccu_mmc_timing.o
+sunxi-ccu-y			+= ccu_reset.o
 
 # Base clock types
-obj-y				+= ccu_div.o
-obj-y				+= ccu_frac.o
-obj-y				+= ccu_gate.o
-obj-y				+= ccu_mux.o
-obj-y				+= ccu_mult.o
-obj-y				+= ccu_phase.o
-obj-y				+= ccu_sdm.o
+sunxi-ccu-y			+= ccu_div.o
+sunxi-ccu-y			+= ccu_frac.o
+sunxi-ccu-y			+= ccu_gate.o
+sunxi-ccu-y			+= ccu_mux.o
+sunxi-ccu-y			+= ccu_mult.o
+sunxi-ccu-y			+= ccu_phase.o
+sunxi-ccu-y			+= ccu_sdm.o
 
 # Multi-factor clocks
-obj-y				+= ccu_nk.o
-obj-y				+= ccu_nkm.o
-obj-y				+= ccu_nkmp.o
-obj-y				+= ccu_nm.o
-obj-y				+= ccu_mp.o
+sunxi-ccu-y			+= ccu_nk.o
+sunxi-ccu-y			+= ccu_nkm.o
+sunxi-ccu-y			+= ccu_nkmp.o
+sunxi-ccu-y			+= ccu_nm.o
+sunxi-ccu-y			+= ccu_mp.o
 
 # SoC support
 obj-$(CONFIG_SUNIV_F1C100S_CCU)	+= suniv-f1c100s-ccu.o
diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
index 3ab109582646..d9619ad32f5c 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -9,6 +9,7 @@
 #include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/iopoll.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 
 #include "ccu_common.h"
@@ -213,3 +214,5 @@ void of_sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
 		kfree(ccu);
 	}
 }
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 71313961cc54..1247c9455dea 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -964,6 +964,7 @@ config MMC_REALTEK_USB
 config MMC_SUNXI
 	tristate "Allwinner sunxi SD/MMC Host Controller support"
 	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on SUNXI_CCU
 	help
 	  This selects support for the SD/MMC Host Controller on
 	  Allwinner sunxi SoCs.
diff --git a/include/linux/clk/sunxi-ng.h b/include/linux/clk/sunxi-ng.h
index 3cd14acde0a1..cf32123b39f5 100644
--- a/include/linux/clk/sunxi-ng.h
+++ b/include/linux/clk/sunxi-ng.h
@@ -6,22 +6,7 @@
 #ifndef _LINUX_CLK_SUNXI_NG_H_
 #define _LINUX_CLK_SUNXI_NG_H_
 
-#include <linux/errno.h>
-
-#ifdef CONFIG_SUNXI_CCU
 int sunxi_ccu_set_mmc_timing_mode(struct clk *clk, bool new_mode);
 int sunxi_ccu_get_mmc_timing_mode(struct clk *clk);
-#else
-static inline int sunxi_ccu_set_mmc_timing_mode(struct clk *clk,
-						bool new_mode)
-{
-	return -ENOTSUPP;
-}
-
-static inline int sunxi_ccu_get_mmc_timing_mode(struct clk *clk)
-{
-	return -ENOTSUPP;
-}
-#endif
 
 #endif
-- 
2.31.1

