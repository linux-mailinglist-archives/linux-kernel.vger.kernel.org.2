Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DAA32205C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhBVTng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:43:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232985AbhBVTnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:43:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C27364EC1;
        Mon, 22 Feb 2021 19:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614022939;
        bh=g7I54Xx87A8O+3hHocomlXJ+qgIiONJK4DHpRS8aEOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rIM4/TITjHNhYlYnDD0kak708vDb9Erq7OvQPzCzEzZSjIRVvyGtGnL+ulWmM9Uxf
         v5Bxp372CZ7hEUEnE1ukKhAYyizQtGjKUT8dSyFsBrY7qQIUEyQ/DZtkldLumOqRJn
         ecSlrKGsL/0OL87leK4VmJ4fRZE58gAsTrRsCSNqLBZQwjlaPb4e843Jgt0s9gxeC2
         U7IMZuPedxkWB4yoApfzP0gMpZCNcimKQdYV7TM2iVi1GVSpg9xT6Og6uvs6Us6dI6
         01Yk58RfhUUgy22l6CKU3ItYbyCcaMJ58xq4xb25lB2ebOyxwZ8TnP5pKdJnXWgGj2
         OSH8KWds8YEhw==
Received: by pali.im (Postfix)
        id 4408EF17; Mon, 22 Feb 2021 20:42:17 +0100 (CET)
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
Subject: [PATCH mvebu v3 04/10] cpufreq: armada-37xx: Fix the AVS value for load L1
Date:   Mon, 22 Feb 2021 20:41:52 +0100
Message-Id: <20210222194158.12342-5-pali@kernel.org>
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

The original CPU voltage value for load L1 is too low for Armada 37xx SoC
when base CPU frequency is 1000 or 1200 MHz. It leads to instabilities
where CPU gets stuck soon after dynamic voltage scaling from load L1 to L0.

Update the CPU voltage value for load L1 accordingly when base frequency is
1000 or 1200 MHz. The minimal L1 value for base CPU frequency 1000 MHz is
updated from the original 1.05V to 1.108V and for 1200 MHz is updated to
1.155V. This minimal L1 value is used only in the case when it is lower
than value for L0.

This change fixes CPU instability issues on 1 GHz and 1.2 GHz variants of
Espressobin and 1 GHz Turris Mox.

Marvell previously for 1 GHz variant of Espressobin provided a patch [1]
suitable only for their Marvell Linux kernel 4.4 fork which workarounded
this issue. Patch forced CPU voltage value to 1.108V in all loads. But
such change does not fix CPU instability issues on 1.2 GHz variants of
Armada 3720 SoC.

During testing we come to the conclusion that using 1.108V as minimal
value for L1 load makes 1 GHz variants of Espressobin and Turris Mox boards
stable. And similarly 1.155V for 1.2 GHz variant of Espressobin.

These two values 1.108V and 1.155V are documented in Armada 3700 Hardware
Specifications as typical initial CPU voltage values.

Discussion about this issue is also at the Armbian forum [2].

[1] - https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/dc33b62c90696afb6adc7dbcc4ebbd48bedec269
[2] - https://forum.armbian.com/topic/10429-how-to-make-espressobin-v7-stable/

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
Tested-by: Philip Soares <philips@netisense.com>
Fixes: 1c3528232f4b ("cpufreq: armada-37xx: Add AVS support")
Cc: stable@vger.kernel.org
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 37 +++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index b8dc6c849579..c7683d447b11 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -73,6 +73,8 @@
 #define LOAD_LEVEL_NR	4
 
 #define MIN_VOLT_MV 1000
+#define MIN_VOLT_MV_FOR_L1_1000MHZ 1108
+#define MIN_VOLT_MV_FOR_L1_1200MHZ 1155
 
 /*  AVS value for the corresponding voltage (in mV) */
 static int avs_map[] = {
@@ -208,6 +210,8 @@ static u32 armada_37xx_avs_val_match(int target_vm)
  * - L2 & L3 voltage should be about 150mv smaller than L0 voltage.
  * This function calculates L1 & L2 & L3 AVS values dynamically based
  * on L0 voltage and fill all AVS values to the AVS value table.
+ * When base CPU frequency is 1000 or 1200 MHz then there is additional
+ * minimal avs value for load L1.
  */
 static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
 						struct armada_37xx_dvfs *dvfs)
@@ -239,6 +243,19 @@ static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
 		for (load_level = 1; load_level < LOAD_LEVEL_NR; load_level++)
 			dvfs->avs[load_level] = avs_min;
 
+		/*
+		 * Set the avs values for load L0 and L1 when base CPU frequency
+		 * is 1000/1200 MHz to its typical initial values according to
+		 * the Armada 3700 Hardware Specifications.
+		 */
+		if (dvfs->cpu_freq_max >= 1000*1000*1000) {
+			if (dvfs->cpu_freq_max >= 1200*1000*1000)
+				avs_min = armada_37xx_avs_val_match(MIN_VOLT_MV_FOR_L1_1200MHZ);
+			else
+				avs_min = armada_37xx_avs_val_match(MIN_VOLT_MV_FOR_L1_1000MHZ);
+			dvfs->avs[0] = dvfs->avs[1] = avs_min;
+		}
+
 		return;
 	}
 
@@ -258,6 +275,26 @@ static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
 	target_vm = avs_map[l0_vdd_min] - 150;
 	target_vm = target_vm > MIN_VOLT_MV ? target_vm : MIN_VOLT_MV;
 	dvfs->avs[2] = dvfs->avs[3] = armada_37xx_avs_val_match(target_vm);
+
+	/*
+	 * Fix the avs value for load L1 when base CPU frequency is 1000/1200 MHz,
+	 * otherwise the CPU gets stuck when switching from load L1 to load L0.
+	 * Also ensure that avs value for load L1 is not higher than for L0.
+	 */
+	if (dvfs->cpu_freq_max >= 1000*1000*1000) {
+		u32 avs_min_l1;
+
+		if (dvfs->cpu_freq_max >= 1200*1000*1000)
+			avs_min_l1 = armada_37xx_avs_val_match(MIN_VOLT_MV_FOR_L1_1200MHZ);
+		else
+			avs_min_l1 = armada_37xx_avs_val_match(MIN_VOLT_MV_FOR_L1_1000MHZ);
+
+		if (avs_min_l1 > dvfs->avs[0])
+			avs_min_l1 = dvfs->avs[0];
+
+		if (dvfs->avs[1] < avs_min_l1)
+			dvfs->avs[1] = avs_min_l1;
+	}
 }
 
 static void __init armada37xx_cpufreq_avs_setup(struct regmap *base,
-- 
2.20.1

