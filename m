Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F8D322062
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhBVTnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232983AbhBVTnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:43:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA22B64E02;
        Mon, 22 Feb 2021 19:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614022939;
        bh=ABuBsMdkyLfGL+k7g+MNLq9V3ierJFRdHgGS1x45AwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgKjJJjHWloLza27ScGiZXzMizkKHkPE7YQD0NKcyQHlNpRwjdUM0J5MllDZhCF64
         bZOpbvMNSHotVzw1oTzglbwoLV6U1bYIpSiDFv4+fZSnjCfT2RfYfRcb3ev+GfJMkh
         +LenIZlQyWUADO/CRCGdvZvh3no/5G1Mw8jAiROyC+FGXkeMj/7AEFRoGh5/gqCJLr
         WNuf9NX44CWM0tBM3hMqNTPT8B5g3f9RcbgTQgEAjICqoMLLTF1mU0be+r2CBapPSz
         VKoSxMCle/DRlabWKUm5bxHNh7R7LN4onRmS++WFCj7fbwsEKCCa5CCI197MKVftN/
         MHKZWs5c2MqVg==
Received: by pali.im (Postfix)
        id B724AEB8; Mon, 22 Feb 2021 20:42:16 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andre Heider <a.heider@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?G=C3=A9rald=20Kerma?= <gerald@gk2.net>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH mvebu v3 02/10] cpufreq: armada-37xx: Fix setting TBG parent for load levels
Date:   Mon, 22 Feb 2021 20:41:50 +0100
Message-Id: <20210222194158.12342-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222194158.12342-1-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
 <20210222194158.12342-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Behún <kabel@kernel.org>

With CPU frequency determining software [1] we have discovered that
after this driver does one CPU frequency change, the base frequency of
the CPU is set to the frequency of TBG-A-P clock, instead of the TBG
that is parent to the CPU.

This can be reproduced on EspressoBIN and Turris MOX:
  cd /sys/devices/system/cpu/cpufreq/policy0
  echo powersave >scaling_governor
  echo performance >scaling_governor

Running the mhz tool before this driver is loaded reports 1000 MHz, and
after loading the driver and executing commands above the tool reports
800 MHz.

The change of TBG clock selector is supposed to happen in function
armada37xx_cpufreq_dvfs_setup. Before the function returns, it does
this:
  parent = clk_get_parent(clk);
  clk_set_parent(clk, parent);

The armada-37xx-periph clock driver has the .set_parent method
implemented correctly for this, so if the method was actually called,
this would work. But since the introduction of the common clock
framework in commit b2476490ef11 ("clk: introduce the common clock..."),
the clk_set_parent function checks whether the parent is actually
changing, and if the requested new parent is same as the old parent
(which is obviously the case for the code above), the .set_parent method
is not called at all.

This patch fixes this issue by filling the correct TBG clock selector
directly in the armada37xx_cpufreq_dvfs_setup during the filling of
other registers at the same address. But the determination of CPU TBG
index cannot be done via the common clock framework, therefore we need
to access the North Bridge Peripheral Clock registers directly in this
driver.

[1] https://github.com/wtarreau/mhz

Signed-off-by: Marek Behún <kabel@kernel.org>
Tested-by: Pali Rohár <pali@kernel.org>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
Tested-by: Philip Soares <philips@netisense.com>
Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
Cc: stable@vger.kernel.org
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 35 ++++++++++++++++++---------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index b4af4094309b..b8dc6c849579 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -25,6 +25,10 @@
 
 #include "cpufreq-dt.h"
 
+/* Clk register set */
+#define ARMADA_37XX_CLK_TBG_SEL		0
+#define ARMADA_37XX_CLK_TBG_SEL_CPU_OFF	22
+
 /* Power management in North Bridge register set */
 #define ARMADA_37XX_NB_L0L1	0x18
 #define ARMADA_37XX_NB_L2L3	0x1C
@@ -120,10 +124,15 @@ static struct armada_37xx_dvfs *armada_37xx_cpu_freq_info_get(u32 freq)
  * will be configured then the DVFS will be enabled.
  */
 static void __init armada37xx_cpufreq_dvfs_setup(struct regmap *base,
-						 struct clk *clk, u8 *divider)
+						 struct regmap *clk_base, u8 *divider)
 {
+	u32 cpu_tbg_sel;
 	int load_lvl;
-	struct clk *parent;
+
+	/* Determine to which TBG clock is CPU connected */
+	regmap_read(clk_base, ARMADA_37XX_CLK_TBG_SEL, &cpu_tbg_sel);
+	cpu_tbg_sel >>= ARMADA_37XX_CLK_TBG_SEL_CPU_OFF;
+	cpu_tbg_sel &= ARMADA_37XX_NB_TBG_SEL_MASK;
 
 	for (load_lvl = 0; load_lvl < LOAD_LEVEL_NR; load_lvl++) {
 		unsigned int reg, mask, val, offset = 0;
@@ -142,6 +151,11 @@ static void __init armada37xx_cpufreq_dvfs_setup(struct regmap *base,
 		mask = (ARMADA_37XX_NB_CLK_SEL_MASK
 			<< ARMADA_37XX_NB_CLK_SEL_OFF);
 
+		/* Set TBG index, for all levels we use the same TBG */
+		val = cpu_tbg_sel << ARMADA_37XX_NB_TBG_SEL_OFF;
+		mask = (ARMADA_37XX_NB_TBG_SEL_MASK
+			<< ARMADA_37XX_NB_TBG_SEL_OFF);
+
 		/*
 		 * Set cpu divider based on the pre-computed array in
 		 * order to have balanced step.
@@ -160,14 +174,6 @@ static void __init armada37xx_cpufreq_dvfs_setup(struct regmap *base,
 
 		regmap_update_bits(base, reg, mask, val);
 	}
-
-	/*
-	 * Set cpu clock source, for all the level we keep the same
-	 * clock source that the one already configured. For this one
-	 * we need to use the clock framework
-	 */
-	parent = clk_get_parent(clk);
-	clk_set_parent(clk, parent);
 }
 
 /*
@@ -358,11 +364,16 @@ static int __init armada37xx_cpufreq_driver_init(void)
 	struct platform_device *pdev;
 	unsigned long freq;
 	unsigned int cur_frequency, base_frequency;
-	struct regmap *nb_pm_base, *avs_base;
+	struct regmap *nb_clk_base, *nb_pm_base, *avs_base;
 	struct device *cpu_dev;
 	int load_lvl, ret;
 	struct clk *clk, *parent;
 
+	nb_clk_base =
+		syscon_regmap_lookup_by_compatible("marvell,armada-3700-periph-clock-nb");
+	if (IS_ERR(nb_clk_base))
+		return -ENODEV;
+
 	nb_pm_base =
 		syscon_regmap_lookup_by_compatible("marvell,armada-3700-nb-pm");
 
@@ -439,7 +450,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
 	armada37xx_cpufreq_avs_configure(avs_base, dvfs);
 	armada37xx_cpufreq_avs_setup(avs_base, dvfs);
 
-	armada37xx_cpufreq_dvfs_setup(nb_pm_base, clk, dvfs->divider);
+	armada37xx_cpufreq_dvfs_setup(nb_pm_base, nb_clk_base, dvfs->divider);
 	clk_put(clk);
 
 	for (load_lvl = ARMADA_37XX_DVFS_LOAD_0; load_lvl < LOAD_LEVEL_NR;
-- 
2.20.1

