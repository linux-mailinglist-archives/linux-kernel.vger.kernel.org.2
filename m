Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CAD4568A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 04:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhKSDgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 22:36:48 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:57221 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233605AbhKSDgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 22:36:47 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6CAC83201D41;
        Thu, 18 Nov 2021 22:33:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 18 Nov 2021 22:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=jRMl/BUG3aaEg
        9QQS3XYBCb4qLuKtM+s/r2Q8m66TrI=; b=BvwXMPunmhEHSvzcwSEyGl3AF8x8o
        goZ+iT+CIQOk63S1h6ND8JXX92orr9UvTPIUfkmpZ74+JoBFI7XD1nwhqry64K8g
        HBLeRP9mUQRsdv7s3PNiMhEblojyf+KkntyGyLpfLViwhLK2Vv7F53zbmq3+ufnB
        fdXHhfxs2gO51ro+xKrPLIjTfaru5MKpnlztehdGYJCq6ywMlCqQNhYIAu7hJ2KN
        XZzhucTfi8qZpy3lK8t+CbaOJvV2iOxtSNMt5BJaBJtyGezKmoWLPmNA9VhngQv+
        pHXq+GamGbk6xQtMykbVWP7aVusQDPC4BetaAf5c7Ua4dp5b5H7tSEZBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=jRMl/BUG3aaEg9QQS3XYBCb4qLuKtM+s/r2Q8m66TrI=; b=PasCpggw
        jHgoKCUWlNwxNC+J5ALMWzW0ZcYVQf+ju51ZPkFwCRFtPYUn6VxehuxfCBCRJjFw
        zgKOKa6TDtXOdYoy+uOtppceuWEARF419K7A2f35Ty2gnMZpB3rSfiEX7/+Qs6ZO
        VWrMSSumdd2Ys2TLdMtxwwN5W15mJUZOzCUycQ7YTMSWKYYY0bsXVV4NG5R1PIHX
        qrTJQILvst053uM6xwXxy0Fa+B7ZXvT3BUSYLW16l9JJT4RhBKR5bF3i+AzoygQi
        jEuHHgScYGPQ5BX+5ub9nA5DJmuDR5Lyxn3Vt8pfkaiOIMTwVu2uGMw7PTlVS9vY
        r25+FOaZMEBQig==
X-ME-Sender: <xms:GBuXYQrv6wlyIzpQ88FUyLZfaPvumwsq_jhXm9hF2TRXZ5QCrjhr0w>
    <xme:GBuXYWrfZYPFlaWI7b5yGg2ZDjIEiZyfH5TxqJlCIDfC63KYWA6KMABFitmSKHX3y
    ACeud4Y0YKPJC_5Gw>
X-ME-Received: <xmr:GBuXYVO0MVIL4f4WuNp-GVQcRucHrHJjhy5nANy-jFmfzZd6LgKalKSelT2tG3HQpaGCmsTP6-DwiE6FGMKk4LHmp3B9KiZrweIAskvN2zINDIzmZWY8f6I_s62PK7kd6hkstQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:GBuXYX7FkyKsMUte8ua3dnnW7olftq7GUH0W8yFsxOz-dqVPzgi6dA>
    <xmx:GBuXYf4Oxgzy5E8TLXpdkqKQRdBwE0SwIshCFjPSOI7Hn2aZzwAF9w>
    <xmx:GBuXYXgy2_i9L0YzZlvxgR_IJwK-OezIHD0f-VZD8P6KLErNrXMp8w>
    <xmx:GRuXYZtXUk9XuqpZw68IRYuaWn9B0Rq7yWLAhnCMDz-669bUsOuduw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Nov 2021 22:33:44 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 2/4] clk: sunxi-ng: Allow drivers to be built as modules
Date:   Thu, 18 Nov 2021 21:33:35 -0600
Message-Id: <20211119033338.25486-3-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119033338.25486-1-samuel@sholland.org>
References: <20211119033338.25486-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it is useful to build all of the CCU drivers at once, only 1-3 of
them will be loaded at a time, or possibly none of them if the kernel is
booted on a non-sunxi platform. These CCU drivers are relatively large;
32-bit drivers have 30-50k of data each, while the 64-bit ones are
50-75k due to the increased pointer overhead. About half of that data
comes from relocations. Let's allow the user to build these drivers as
modules so only the necessary data is loaded.

As a first step, convert the CCUs that are already platform drivers.

When the drivers are built as modules, normally the file name becomes
the module name. However, the current file names are inconsistent with
the <platform>-<peripheral> name used everywhere else: the devicetree
bindings, the platform driver names, and the Kconfig symbols. Use
Makfile logic to rename the modules so they follow the usual pattern.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/clk/sunxi-ng/Kconfig             | 16 +++---
 drivers/clk/sunxi-ng/Makefile            | 64 ++++++++++++++++--------
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c |  4 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c   |  4 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c    |  7 ++-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c     |  7 ++-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c    |  7 ++-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c     |  9 ++--
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c     |  6 ++-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c  |  7 ++-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c |  7 ++-
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c     |  7 ++-
 12 files changed, 98 insertions(+), 47 deletions(-)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index e76e1676f0f0..c004ffc10ef7 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -13,22 +13,22 @@ config SUNIV_F1C100S_CCU
 	depends on MACH_SUNIV || COMPILE_TEST
 
 config SUN50I_A64_CCU
-	bool "Support for the Allwinner A64 CCU"
+	tristate "Support for the Allwinner A64 CCU"
 	default ARM64 && ARCH_SUNXI
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
 config SUN50I_A100_CCU
-	bool "Support for the Allwinner A100 CCU"
+	tristate "Support for the Allwinner A100 CCU"
 	default ARM64 && ARCH_SUNXI
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
 config SUN50I_A100_R_CCU
-	bool "Support for the Allwinner A100 PRCM CCU"
+	tristate "Support for the Allwinner A100 PRCM CCU"
 	default ARM64 && ARCH_SUNXI
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
 config SUN50I_H6_CCU
-	bool "Support for the Allwinner H6 CCU"
+	tristate "Support for the Allwinner H6 CCU"
 	default ARM64 && ARCH_SUNXI
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
@@ -69,7 +69,7 @@ config SUN8I_A33_CCU
 	depends on MACH_SUN8I || COMPILE_TEST
 
 config SUN8I_A83T_CCU
-	bool "Support for the Allwinner A83T CCU"
+	tristate "Support for the Allwinner A83T CCU"
 	default MACH_SUN8I
 	depends on MACH_SUN8I || COMPILE_TEST
 
@@ -84,16 +84,16 @@ config SUN8I_V3S_CCU
 	depends on MACH_SUN8I || COMPILE_TEST
 
 config SUN8I_DE2_CCU
-	bool "Support for the Allwinner SoCs DE2 CCU"
+	tristate "Support for the Allwinner SoCs DE2 CCU"
 	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
 
 config SUN8I_R40_CCU
-	bool "Support for the Allwinner R40 CCU"
+	tristate "Support for the Allwinner R40 CCU"
 	default MACH_SUN8I
 	depends on MACH_SUN8I || COMPILE_TEST
 
 config SUN9I_A80_CCU
-	bool "Support for the Allwinner A80 CCU"
+	tristate "Support for the Allwinner A80 CCU"
 	default MACH_SUN9I
 	depends on MACH_SUN9I || COMPILE_TEST
 
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 96c324306d97..1020ed49a588 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -21,24 +21,46 @@ obj-y				+= ccu_nm.o
 obj-y				+= ccu_mp.o
 
 # SoC support
-obj-$(CONFIG_SUNIV_F1C100S_CCU)	+= ccu-suniv-f1c100s.o
-obj-$(CONFIG_SUN50I_A64_CCU)	+= ccu-sun50i-a64.o
-obj-$(CONFIG_SUN50I_A100_CCU)	+= ccu-sun50i-a100.o
-obj-$(CONFIG_SUN50I_A100_R_CCU)	+= ccu-sun50i-a100-r.o
-obj-$(CONFIG_SUN50I_H6_CCU)	+= ccu-sun50i-h6.o
-obj-$(CONFIG_SUN50I_H616_CCU)	+= ccu-sun50i-h616.o
-obj-$(CONFIG_SUN50I_H6_R_CCU)	+= ccu-sun50i-h6-r.o
-obj-$(CONFIG_SUN4I_A10_CCU)	+= ccu-sun4i-a10.o
-obj-$(CONFIG_SUN5I_CCU)		+= ccu-sun5i.o
-obj-$(CONFIG_SUN6I_A31_CCU)	+= ccu-sun6i-a31.o
-obj-$(CONFIG_SUN8I_A23_CCU)	+= ccu-sun8i-a23.o
-obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
-obj-$(CONFIG_SUN8I_A83T_CCU)	+= ccu-sun8i-a83t.o
-obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
-obj-$(CONFIG_SUN8I_V3S_CCU)	+= ccu-sun8i-v3s.o
-obj-$(CONFIG_SUN8I_DE2_CCU)	+= ccu-sun8i-de2.o
-obj-$(CONFIG_SUN8I_R_CCU)	+= ccu-sun8i-r.o
-obj-$(CONFIG_SUN8I_R40_CCU)	+= ccu-sun8i-r40.o
-obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80.o
-obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80-de.o
-obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80-usb.o
+obj-$(CONFIG_SUNIV_F1C100S_CCU)	+= suniv-f1c100s-ccu.o
+obj-$(CONFIG_SUN50I_A64_CCU)	+= sun50i-a64-ccu.o
+obj-$(CONFIG_SUN50I_A100_CCU)	+= sun50i-a100-ccu.o
+obj-$(CONFIG_SUN50I_A100_R_CCU)	+= sun50i-a100-r-ccu.o
+obj-$(CONFIG_SUN50I_H6_CCU)	+= sun50i-h6-ccu.o
+obj-$(CONFIG_SUN50I_H6_R_CCU)	+= sun50i-h6-r-ccu.o
+obj-$(CONFIG_SUN50I_H616_CCU)	+= sun50i-h616-ccu.o
+obj-$(CONFIG_SUN4I_A10_CCU)	+= sun4i-a10-ccu.o
+obj-$(CONFIG_SUN5I_CCU)		+= sun5i-ccu.o
+obj-$(CONFIG_SUN6I_A31_CCU)	+= sun6i-a31-ccu.o
+obj-$(CONFIG_SUN8I_A23_CCU)	+= sun8i-a23-ccu.o
+obj-$(CONFIG_SUN8I_A33_CCU)	+= sun8i-a33-ccu.o
+obj-$(CONFIG_SUN8I_A83T_CCU)	+= sun8i-a83t-ccu.o
+obj-$(CONFIG_SUN8I_H3_CCU)	+= sun8i-h3-ccu.o
+obj-$(CONFIG_SUN8I_R40_CCU)	+= sun8i-r40-ccu.o
+obj-$(CONFIG_SUN8I_V3S_CCU)	+= sun8i-v3s-ccu.o
+obj-$(CONFIG_SUN8I_DE2_CCU)	+= sun8i-de2-ccu.o
+obj-$(CONFIG_SUN8I_R_CCU)	+= sun8i-r-ccu.o
+obj-$(CONFIG_SUN9I_A80_CCU)	+= sun9i-a80-ccu.o
+obj-$(CONFIG_SUN9I_A80_CCU)	+= sun9i-a80-de-ccu.o
+obj-$(CONFIG_SUN9I_A80_CCU)	+= sun9i-a80-usb-ccu.o
+
+suniv-f1c100s-ccu-y		+= ccu-suniv-f1c100s.o
+sun50i-a64-ccu-y		+= ccu-sun50i-a64.o
+sun50i-a100-ccu-y		+= ccu-sun50i-a100.o
+sun50i-a100-r-ccu-y		+= ccu-sun50i-a100-r.o
+sun50i-h6-ccu-y			+= ccu-sun50i-h6.o
+sun50i-h6-r-ccu-y		+= ccu-sun50i-h6-r.o
+sun50i-h616-ccu-y		+= ccu-sun50i-h616.o
+sun4i-a10-ccu-y			+= ccu-sun4i-a10.o
+sun5i-ccu-y			+= ccu-sun5i.o
+sun6i-a31-ccu-y			+= ccu-sun6i-a31.o
+sun8i-a23-ccu-y			+= ccu-sun8i-a23.o
+sun8i-a33-ccu-y			+= ccu-sun8i-a33.o
+sun8i-a83t-ccu-y		+= ccu-sun8i-a83t.o
+sun8i-h3-ccu-y			+= ccu-sun8i-h3.o
+sun8i-r40-ccu-y			+= ccu-sun8i-r40.o
+sun8i-v3s-ccu-y			+= ccu-sun8i-v3s.o
+sun8i-de2-ccu-y			+= ccu-sun8i-de2.o
+sun8i-r-ccu-y			+= ccu-sun8i-r.o
+sun9i-a80-ccu-y			+= ccu-sun9i-a80.o
+sun9i-a80-de-ccu-y		+= ccu-sun9i-a80-de.o
+sun9i-a80-usb-ccu-y		+= ccu-sun9i-a80-usb.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
index 804729e0a208..fddd6c877cec 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
@@ -5,7 +5,6 @@
 
 #include <linux/clk-provider.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -213,3 +212,6 @@ static struct platform_driver sun50i_a100_r_ccu_driver = {
 	},
 };
 module_platform_driver(sun50i_a100_r_ccu_driver);
+
+MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
index 1d475d5a3d91..5f93b5526e13 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
@@ -6,7 +6,6 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -1275,3 +1274,6 @@ static struct platform_driver sun50i_a100_ccu_driver = {
 	},
 };
 module_platform_driver(sun50i_a100_ccu_driver);
+
+MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index a8c5a92b7d0c..41519185600a 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -980,4 +980,7 @@ static struct platform_driver sun50i_a64_ccu_driver = {
 		.of_match_table	= sun50i_a64_ccu_ids,
 	},
 };
-builtin_platform_driver(sun50i_a64_ccu_driver);
+module_platform_driver(sun50i_a64_ccu_driver);
+
+MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index e5672c10d065..1a5e418923f6 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -1254,4 +1254,7 @@ static struct platform_driver sun50i_h6_ccu_driver = {
 		.of_match_table	= sun50i_h6_ccu_ids,
 	},
 };
-builtin_platform_driver(sun50i_h6_ccu_driver);
+module_platform_driver(sun50i_h6_ccu_driver);
+
+MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index 3c310aea8cfa..76cbd9e9e89f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -920,4 +920,7 @@ static struct platform_driver sun8i_a83t_ccu_driver = {
 		.of_match_table	= sun8i_a83t_ccu_ids,
 	},
 };
-builtin_platform_driver(sun8i_a83t_ccu_driver);
+module_platform_driver(sun8i_a83t_ccu_driver);
+
+MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index 573b5051d305..e7e3ddf4a227 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -5,8 +5,8 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
@@ -394,4 +394,7 @@ static struct platform_driver sunxi_de2_clk_driver = {
 		.of_match_table	= sunxi_de2_clk_ids,
 	},
 };
-builtin_platform_driver(sunxi_de2_clk_driver);
+module_platform_driver(sunxi_de2_clk_driver);
+
+MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index 8bb18d9add05..31eca0d3bc1e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
@@ -1371,4 +1372,7 @@ static struct platform_driver sun8i_r40_ccu_driver = {
 		.of_match_table	= sun8i_r40_ccu_ids,
 	},
 };
-builtin_platform_driver(sun8i_r40_ccu_driver);
+module_platform_driver(sun8i_r40_ccu_driver);
+
+MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
index 3cde2610f467..f2fe0e1cc3c0 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
@@ -270,4 +270,7 @@ static struct platform_driver sun9i_a80_de_clk_driver = {
 		.of_match_table	= sun9i_a80_de_clk_ids,
 	},
 };
-builtin_platform_driver(sun9i_a80_de_clk_driver);
+module_platform_driver(sun9i_a80_de_clk_driver);
+
+MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
index 0740e8978ae8..575ae4ccc65f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -138,4 +138,7 @@ static struct platform_driver sun9i_a80_usb_clk_driver = {
 		.of_match_table	= sun9i_a80_usb_clk_ids,
 	},
 };
-builtin_platform_driver(sun9i_a80_usb_clk_driver);
+module_platform_driver(sun9i_a80_usb_clk_driver);
+
+MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
index d416af29e0d3..730fd8e28014 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -1245,4 +1245,7 @@ static struct platform_driver sun9i_a80_ccu_driver = {
 		.of_match_table	= sun9i_a80_ccu_ids,
 	},
 };
-builtin_platform_driver(sun9i_a80_ccu_driver);
+module_platform_driver(sun9i_a80_ccu_driver);
+
+MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_LICENSE("GPL");
-- 
2.32.0

