Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3E6321372
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhBVJwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:52:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhBVJvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:51:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5BE664E13;
        Mon, 22 Feb 2021 09:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613987473;
        bh=Yu/qN8STAau22SmwxKcvT5Lel5uW0oN72WFz+Pv29SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojMcOtCF8a6RX8HGZnEdqE1r3Rb7ZEEPIj86z2Tq5ncrGQBXtlLZmKGK9h7EEqzso
         frAx2sa7klpY1ZxLTOUX5QhlxClfFmLgOPymUQHCfvHSbtuG5/XK22qk077SPBHYoU
         QEO/taupT2HnwZylbF8/1rBEEX/S3v5XMbBmTbLR9XTgfAg+6pcc1A6c/P+znfqhj5
         D2ahVEXud88bF2HO5uBRY97+p2F/Wo7qd0mTfFYsDgUh6/oxrZYiyOVRV6lzgICRHK
         UjOKzsQd/YzHLsG/3wosV7tHADShns2JHDc8s5M5GY/jz4gUUtMxjS4UJPALcEFQU8
         GWoSNM9oC43Zg==
Received: by pali.im (Postfix)
        id 72680C9A; Mon, 22 Feb 2021 10:51:11 +0100 (CET)
Date:   Mon, 22 Feb 2021 10:51:11 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     nnet <nnet@fastmail.fm>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, a.heider@gmail.com,
        andrew@lunn.ch, gerald@gk2.net, gregory.clement@bootlin.com,
        kostap@marvell.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        luka.perkov@sartura.hr, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, rmk+kernel@armlinux.org.uk,
        sboyd@kernel.org, tmn505@gmail.com, vladimir.vid@sartura.hr
Subject: Re: [PATCH mvebu v2 00/10] Armada 37xx: Fix cpufreq changing base
 CPU speed to 800 MHz from 1000 MHz
Message-ID: <20210222095111.zcokx4g3sqghjgyl@pali>
References: <20210211234445.hbv2diphmgbir76u@pali>
 <000b92cc-9b54-4af9-b95c-d1317fb6f97f@www.fastmail.com>
 <20210213100139.ckrscepg72zjkj4f@pali>
 <c0b02aa0-1789-43a3-8d73-057890f703f1@www.fastmail.com>
 <20210214123310.d6armpep7kxbymbu@pali>
 <675b7a74-066b-4dc0-8dcb-f11c5606ae52@www.fastmail.com>
 <20210216104141.umy6zrrkal3dlj5j@pali>
 <d057d7f7-27a5-45ec-88f0-a653572a8ca6@www.fastmail.com>
 <20210219193302.odcjcaukxxjaedd5@pali>
 <c0ade595-9bfa-4cfc-8c87-0e955173d5db@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0ade595-9bfa-4cfc-8c87-0e955173d5db@www.fastmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 February 2021 19:17:40 nnet wrote:
> > Could you test if 1.155V voltage for L1 is stable on 1.2 GHz variant?
> 
> ++#define MIN_VOLT_MV_FOR_L1_1200MHZ 1155
> ...
> ++              if (avs_min_l1 > dvfs->avs[0])
> ++                      avs_min_l1 = dvfs->avs[0];
> ++
> ++              if (dvfs->avs[1] < avs_min_l1)
> ++                      dvfs->avs[1] = avs_min_l1;
> 
> This works fine. Tested with switching 600MHz to 1.2GHz under load.

Perfect! Therefore here is final version of patch 04/10 for both 1 GHz
and 1.2 GHz variants of A3720 SoC. I will resend whole patch series.
Could I add your Tested-by line to patch series?

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index b8dc6c849..c7683d447 100644
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
