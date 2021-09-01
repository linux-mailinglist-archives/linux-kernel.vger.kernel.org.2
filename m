Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79093FD2B3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbhIAFGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:06:49 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60825 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241925AbhIAFGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:06:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EFB325C019C;
        Wed,  1 Sep 2021 01:05:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 01 Sep 2021 01:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=4e2oI5zdlCz+Q
        FIe2+F59HWSrI67X+JBq24r/vRVDKE=; b=D0ViyHtVNMkHBLJQjKwP4OKlR/Ge8
        6NYtP1wT9FfZkmGHGVmYkmdeq/hAh4g2pwHMMYSCJzgsOrUVa1S0wohqEHsV0cfW
        4xIhmhNU064DJbK3MWVIHIad0kIUdwgWsuZe/tjni3go3ptXofNS751EM6ItQW88
        kc9JLkJOYQagW5ZUCtVTCeuP8JIrzrOXQl7LM518VLhQR4F3ra7Sq3Ck8lGxMblD
        Dm7NLKzABYoX/MRDtY79sp01Cim5LzxRYJh88NxjOrQdXehRVzoLzDqHNbJ2uG4i
        SD00me1a3D/RjuQ6Mleh3Wdglu/MD/zzNDuLS8b2025XO4f5tkaALgVSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=4e2oI5zdlCz+QFIe2+F59HWSrI67X+JBq24r/vRVDKE=; b=TIoAVugz
        CgRYpwBgL0OlnH7kL8PlRJRTAdyFUc0YZTp87/ZZh6N5ja/6OTAKQQeh5VHNYLOd
        VVfXXTnY1M7jaGBtJ4EmCQMnOHzgFs9KShaBGrwOCHQ/DUXIiBrUWXXCKF3MQgYC
        43g7Z+x0oWN65RQeh5vlpwbpeZzAaqoiGnpE2zet0C7N415KedFJn2f+3hpFbLsE
        cUzgvd4314W3MRGeqBXy8LZ4mm4G31yEW8x0IN+V6r2nsQNFCRReIMxpYZc+k7kB
        PGCOEHspYuHVe1DUJ4xrm7rVZkApHWF8vDlEY7SrQu+p9UBqHG5YJPvRxMhw1RXR
        MtC/mu3IuyKBQw==
X-ME-Sender: <xms:HwovYQob2UIRCHTFQ1ODF-JJ9irw9BJg_a-xWrvtVJlfBFNiu3AepQ>
    <xme:HwovYWqb6WUnrSqbBewdN9rQgIPfWcZseKPvY1ArjK8vjkCqDtWuGe8SphA0ZL5ie
    gx3g8337G3rnnqLtw>
X-ME-Received: <xmr:HwovYVPAMG_zuCBC1-CbTm2QAGal7vyQ6_3l9QvegRLQB2aD3kk-KOJVw9EKGCf2ivm-yoih9oVMlyUFKpf9rlUInfQpgQbXnjEqhDXoz2xeiwr3hEQGSbRX0t_tmmq3wqHvVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:HwovYX7h86_iggi_bPtW0oE7qTA5koQ6pwwoO7DAX9Dtme3YzYOuew>
    <xmx:HwovYf762WdlGevuaGYKIYqKCzOJJ0lkmoPaghv3pzmEhyMl5beyeA>
    <xmx:HwovYXiuXjZ2boWHiMCUpL7hWBAWHMaOSqc_oyNipiRUOgl0Wl2EIg>
    <xmx:HwovYZtjLBoSnB1CSTziKk6x4ZrHlAjGwQ-JB73_s1YrdfZQW9vlQA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:05:35 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 6/8] clk: sunxi-ng: Allow drivers to be built as modules
Date:   Wed,  1 Sep 2021 00:05:24 -0500
Message-Id: <20210901050526.45673-7-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901050526.45673-1-samuel@sholland.org>
References: <20210901050526.45673-1-samuel@sholland.org>
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

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/Kconfig             | 16 ++++++++--------
 drivers/clk/sunxi-ng/sun50i-a100-ccu.c   |  3 ++-
 drivers/clk/sunxi-ng/sun50i-a100-r-ccu.c |  3 ++-
 drivers/clk/sunxi-ng/sun50i-a64-ccu.c    |  6 ++++--
 drivers/clk/sunxi-ng/sun50i-h6-ccu.c     |  6 ++++--
 drivers/clk/sunxi-ng/sun8i-a83t-ccu.c    |  6 ++++--
 drivers/clk/sunxi-ng/sun8i-de2-ccu.c     |  8 +++++---
 drivers/clk/sunxi-ng/sun8i-r40-ccu.c     |  5 ++++-
 drivers/clk/sunxi-ng/sun9i-a80-ccu.c     |  6 ++++--
 drivers/clk/sunxi-ng/sun9i-a80-de-ccu.c  |  6 ++++--
 drivers/clk/sunxi-ng/sun9i-a80-usb-ccu.c |  6 ++++--
 11 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index cd46d8853876..7cfdf21717f7 100644
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
 
 config SUN8I_H3_CCU
@@ -83,16 +83,16 @@ config SUN8I_V3S_CCU
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
 
diff --git a/drivers/clk/sunxi-ng/sun50i-a100-ccu.c b/drivers/clk/sunxi-ng/sun50i-a100-ccu.c
index 5a813af9941c..5bb901c3b2f5 100644
--- a/drivers/clk/sunxi-ng/sun50i-a100-ccu.c
+++ b/drivers/clk/sunxi-ng/sun50i-a100-ccu.c
@@ -6,7 +6,6 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -1275,3 +1274,5 @@ static struct platform_driver sun50i_a100_ccu_driver = {
 	},
 };
 module_platform_driver(sun50i_a100_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun50i-a100-r-ccu.c b/drivers/clk/sunxi-ng/sun50i-a100-r-ccu.c
index 078ebdf8b093..6842d69616a4 100644
--- a/drivers/clk/sunxi-ng/sun50i-a100-r-ccu.c
+++ b/drivers/clk/sunxi-ng/sun50i-a100-r-ccu.c
@@ -5,7 +5,6 @@
 
 #include <linux/clk-provider.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -213,3 +212,5 @@ static struct platform_driver sun50i_a100_r_ccu_driver = {
 	},
 };
 module_platform_driver(sun50i_a100_r_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun50i-a64-ccu.c b/drivers/clk/sunxi-ng/sun50i-a64-ccu.c
index ffc5ef5fab3c..0e7ba14d58ca 100644
--- a/drivers/clk/sunxi-ng/sun50i-a64-ccu.c
+++ b/drivers/clk/sunxi-ng/sun50i-a64-ccu.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -982,4 +982,6 @@ static struct platform_driver sun50i_a64_ccu_driver = {
 		.of_match_table	= sun50i_a64_ccu_ids,
 	},
 };
-builtin_platform_driver(sun50i_a64_ccu_driver);
+module_platform_driver(sun50i_a64_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun50i-h6-ccu.c b/drivers/clk/sunxi-ng/sun50i-h6-ccu.c
index 8876358710c5..c28a09e4938d 100644
--- a/drivers/clk/sunxi-ng/sun50i-h6-ccu.c
+++ b/drivers/clk/sunxi-ng/sun50i-h6-ccu.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -1256,4 +1256,6 @@ static struct platform_driver sun50i_h6_ccu_driver = {
 		.of_match_table	= sun50i_h6_ccu_ids,
 	},
 };
-builtin_platform_driver(sun50i_h6_ccu_driver);
+module_platform_driver(sun50i_h6_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun8i-a83t-ccu.c b/drivers/clk/sunxi-ng/sun8i-a83t-ccu.c
index 067eb9bb4b53..8ae7b0417a6b 100644
--- a/drivers/clk/sunxi-ng/sun8i-a83t-ccu.c
+++ b/drivers/clk/sunxi-ng/sun8i-a83t-ccu.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -922,4 +922,6 @@ static struct platform_driver sun8i_a83t_ccu_driver = {
 		.of_match_table	= sun8i_a83t_ccu_ids,
 	},
 };
-builtin_platform_driver(sun8i_a83t_ccu_driver);
+module_platform_driver(sun8i_a83t_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun8i-de2-ccu.c b/drivers/clk/sunxi-ng/sun8i-de2-ccu.c
index 15d15448ac21..61c185cbc04a 100644
--- a/drivers/clk/sunxi-ng/sun8i-de2-ccu.c
+++ b/drivers/clk/sunxi-ng/sun8i-de2-ccu.c
@@ -5,8 +5,8 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
@@ -396,4 +396,6 @@ static struct platform_driver sunxi_de2_clk_driver = {
 		.of_match_table	= sunxi_de2_clk_ids,
 	},
 };
-builtin_platform_driver(sunxi_de2_clk_driver);
+module_platform_driver(sunxi_de2_clk_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun8i-r40-ccu.c b/drivers/clk/sunxi-ng/sun8i-r40-ccu.c
index 7347b65a5051..a090b21002b6 100644
--- a/drivers/clk/sunxi-ng/sun8i-r40-ccu.c
+++ b/drivers/clk/sunxi-ng/sun8i-r40-ccu.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
@@ -1373,4 +1374,6 @@ static struct platform_driver sun8i_r40_ccu_driver = {
 		.of_match_table	= sun8i_r40_ccu_ids,
 	},
 };
-builtin_platform_driver(sun8i_r40_ccu_driver);
+module_platform_driver(sun8i_r40_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun9i-a80-ccu.c b/drivers/clk/sunxi-ng/sun9i-a80-ccu.c
index bc0b89e18652..ae654078eca5 100644
--- a/drivers/clk/sunxi-ng/sun9i-a80-ccu.c
+++ b/drivers/clk/sunxi-ng/sun9i-a80-ccu.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -1247,4 +1247,6 @@ static struct platform_driver sun9i_a80_ccu_driver = {
 		.of_match_table	= sun9i_a80_ccu_ids,
 	},
 };
-builtin_platform_driver(sun9i_a80_ccu_driver);
+module_platform_driver(sun9i_a80_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun9i-a80-de-ccu.c b/drivers/clk/sunxi-ng/sun9i-a80-de-ccu.c
index 5be451411cb4..69303f5d7747 100644
--- a/drivers/clk/sunxi-ng/sun9i-a80-de-ccu.c
+++ b/drivers/clk/sunxi-ng/sun9i-a80-de-ccu.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
@@ -272,4 +272,6 @@ static struct platform_driver sun9i_a80_de_clk_driver = {
 		.of_match_table	= sun9i_a80_de_clk_ids,
 	},
 };
-builtin_platform_driver(sun9i_a80_de_clk_driver);
+module_platform_driver(sun9i_a80_de_clk_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun9i-a80-usb-ccu.c b/drivers/clk/sunxi-ng/sun9i-a80-usb-ccu.c
index 62417b6e4f74..a9cab6d70953 100644
--- a/drivers/clk/sunxi-ng/sun9i-a80-usb-ccu.c
+++ b/drivers/clk/sunxi-ng/sun9i-a80-usb-ccu.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -140,4 +140,6 @@ static struct platform_driver sun9i_a80_usb_clk_driver = {
 		.of_match_table	= sun9i_a80_usb_clk_ids,
 	},
 };
-builtin_platform_driver(sun9i_a80_usb_clk_driver);
+module_platform_driver(sun9i_a80_usb_clk_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.31.1

