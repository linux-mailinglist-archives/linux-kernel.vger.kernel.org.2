Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD764568AD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 04:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhKSDg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 22:36:56 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:40819 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233621AbhKSDgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 22:36:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id DECA43201D3E;
        Thu, 18 Nov 2021 22:33:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 18 Nov 2021 22:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=kPVtNGu2Cd9Z0
        5FhgNpKtOsuhsNoeBckHB2OqZ87G2Q=; b=EwJHMcKV0GxfUBCpvOzRmAPYbRLVr
        fMS7Lgi634lvEApH38OgvbKYEHOGQcf1y9ZXN7FhDWX1JSozEldAAGPVWPiSDB/Z
        0ZnXszgxwJKwaFbhfOuFauegmCZF1+fzek1ka//EhZglXL3CRCoPBO/CivrVwBU3
        jeRSOKkfwdpMXYOisfGzif6MOQRNvyPVjIIKL5xk8BTHMc01srgMvrzmtTd5S+rQ
        mGNNcJ6VjXj9uofF+qyNJj+2woEv+RyoRhK2K/lABxafxI5MV/FJl4yNXpYduS8v
        rWnPN6CZo7K1jvrTG+DnsKzGyvPLlmhhGnYARF9wWvgM4iMSdmXAdmzgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=kPVtNGu2Cd9Z05FhgNpKtOsuhsNoeBckHB2OqZ87G2Q=; b=PCBuyvKG
        8HmsNKT6Sc54+xF6AAr3pSaBV1TU6kjnJQB4yO5Jjdw8G7/+2yToqvHA94+6GCNs
        2CchqbxBGIKo/BxwRlCFWjXUiIIxp9OAlc8+aCDcc1yv7Qg3cazMNH9kXrsPsy66
        lZgLnPVblNfCsXh5QTd0PvzGDyIWWrW+XpcprGryuOrAaipPkclQpCxy6itk7b6M
        PtTx/sXAHx6D0rSjKYfrE/EtjgKAP5khyYNtqYB3BxDdpfSwtBiaBARi2e9AKNlA
        o0wMS0NDkwqFfAUn3N8OmLfCI1ntdwWmy1/sBY3BJH+cEbqtqxuvzq/p47v3mb4B
        1JF2sHw8rOO6Xw==
X-ME-Sender: <xms:HhuXYdRWJ4SkvgW1QVPfHpW6Yp88VHelncfHm3QRbaF4lNDpwCoGfQ>
    <xme:HhuXYWyMKMjKIk7VGpexAO6QGKGRmZAEB4SrH63KRBaKNfqekyPQ5iavEMca2X2mV
    hJxu1tnzIatQOOyyw>
X-ME-Received: <xmr:HhuXYS0qXbrH9GeWjgteAzn0gphG6sCBmExuMsWPkh6DNTm-c7fVJnO1QV2V7pp-u0NcF0WCS__jcZYc93d8VYCqzM9YaBp4h3H9ofq6qc9zKmQrsJjyaJvF1fgsB0GjB6bAWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:HhuXYVDP7jmhoOBsX_tTShvfQ758ce7fSKOHx7CUveloKeuPqSf0yA>
    <xmx:HhuXYWjp8_K4xR-nLGvd1x-C22_ZYKGQGWRNFVzB3D5WpWhYcogxHg>
    <xmx:HhuXYZptVHKUZLlVLk0rLBSLVdzvzGlMlZnV7Q3LIeRAPV1h0vpXaQ>
    <xmx:HhuXYfX3DkAojiBw-9v8DZ2cT9i7lOXdKjqwffgaLaMh8tFKOWJtHA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Nov 2021 22:33:49 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 4/4] clk: sunxi-ng: Allow the CCU core to be built as a module
Date:   Thu, 18 Nov 2021 21:33:37 -0600
Message-Id: <20211119033338.25486-5-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119033338.25486-1-samuel@sholland.org>
References: <20211119033338.25486-1-samuel@sholland.org>
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

(no changes since v1)

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
index 6afdedbce6a2..8d28a7a079d0 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -9,6 +9,7 @@
 #include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/iopoll.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 
 #include "ccu_common.h"
@@ -214,3 +215,5 @@ void of_sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
 		kfree(ccu);
 	}
 }
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5af8494c31b5..52b0b27a6839 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -966,6 +966,7 @@ config MMC_REALTEK_USB
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
2.32.0

