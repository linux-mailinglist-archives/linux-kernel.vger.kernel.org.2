Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1C541A9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbhI1HlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:41:24 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:47853 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239363AbhI1HlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:41:11 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 355FE3200B7A;
        Tue, 28 Sep 2021 03:39:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 28 Sep 2021 03:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=tsgrduVjDdssl
        IuzVMotW+kMboVIt1vEZe888BN/7B4=; b=lTc++QtU6eHKmw741rky8pFk4REmp
        htGWEfBGfft1GnlzaM5MT2TPD7VGQmJyaJQSIYnqFmZMWYRGPJIc6Xh7gOSvRXZw
        3z1jeuZfDXpI5b0yQYblm6ZgRj/saTMI7DJjtXj1Dq4TsokvhgtSDkjgj/74+onx
        XEIpQyR+prtxqPFxR0NcjPZNUxXjOHFsBMZ2v8naIByZO1OrxmiqjAqGPxfLPSKl
        E9HlflwQdDFpy5SufKToWrgCE2ou5/jyKPgM2E0g2zyAIC/r5nrCs7RdhnLgeEnl
        WFzECeMVziJSESaUNIrXsfL5FZd8mpFX7dBzmeA/yRh589d9Qn9cAp0cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=tsgrduVjDdsslIuzVMotW+kMboVIt1vEZe888BN/7B4=; b=aGzqDP0B
        AUX55zr3hPib8R/OBcOt327Y7aHIxf2VPAqAvkIWQYZOfjm4ZH6O0M7QJc7b/JgB
        Yc7SwVNxOQaCmq4iBMTtQN69CJmJ9RMveVAQ4tQFo1kAC91BL0nx3KmQxb2HQ9HR
        cWbo5FQqOsDN5kLKEQ3GTodnMjJXwu3rsc1yeIXZe9Kaocso8DJoRV1ziliaR5h7
        vP7bpK0Ca4FicLZ3TQtpu1mg3fwSAGpHe8fW8B9VNWsSTUZ5GkGdg7wPn0GO07Dh
        C1PDCXNG7scC3P6jHm2PZRNg/AkmQ2nf6P00QL1e7ndg5wOti3PLgUz7ysXN+2D1
        w6SHb9UYpdDLNA==
X-ME-Sender: <xms:s8ZSYXZW75qrWuWtdEYwtx3RlyMch4rcmgQx15scxOfZn1wcLvReDA>
    <xme:s8ZSYWbwU1AyVfCZVB5JgEAhOl-des11h1YJbAquqmtZ-1I2dULgIFRP0dcQJs9qk
    -IvBaM3blgB5Z6xFA>
X-ME-Received: <xmr:s8ZSYZ9XIafnhxnVzOz-SBVaxrhwOuIILNQJGyCDDrFu7SkcCsDTnqesdloAEcoXEr-an7GVNXzQyCYyR1rMn6hsOFAw0EzX2PuXrdHm2CXjCj4dNK0OJuBqj12ZyLn8-_7r_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejledguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheej
    vdfgjeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:s8ZSYdqUYgtAY4YOwwkakWNNrKStMMrbbvGIDIg1GmgWO_uE3-KKUA>
    <xmx:s8ZSYSoB8eueC5FUwGTpOPu2nRgNyxqJWDeIDly_yYEEHr1QMSxulA>
    <xmx:s8ZSYTTXR_zaPVU5BR2-xE8Nhq0nKUz52ksF_oc7sgdv2YaF-MKARw>
    <xmx:s8ZSYedl4T093Zm7mhS6EFibCcwzuDWe6EiDYETeFGTd2IVpjnaFdw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 03:39:31 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 4/4] clk: sunxi-ng: Allow the CCU core to be built as a module
Date:   Tue, 28 Sep 2021 02:39:22 -0500
Message-Id: <20210928073922.34264-5-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928073922.34264-1-samuel@sholland.org>
References: <20210928073922.34264-1-samuel@sholland.org>
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
index e42312121e51..6afe36bd2c0a 100644
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
index de88b6e0ec69..727ff755eca4 100644
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
index 1020ed49a588..659d55150c32 100644
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
index fe35336f6b87..81915500b0ee 100644
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

