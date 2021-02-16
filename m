Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6C431C8FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhBPKmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:42:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:32790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhBPKm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:42:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F16764D9F;
        Tue, 16 Feb 2021 10:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613472105;
        bh=ASz9Sl1wTTYIwHfsTK6S3lnvdOhYftuFwTQN9OYls7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQRoYOE/VwptjfXPJutfQrrHRnE0kMLzGnkukKL8lj2RD3SDy3vsnSyx171Xv4F9/
         4MKpga6trHBaVLDO83lC9MZMw5GpYWR9KAlByVsNWdKRA12aghcb05LBZKAuBcNyAf
         T+/+KCBGRg4TUR7us7xoHJGaFik6nSvpOnPkpLkvowwPAMk8c4ecyDM2p7g6PQZCGz
         dUyMdIvN1lltz6aGDaCSO+a+xO1LQmIW6UlsUOfWnGGIxFCe3f77BPI8VxOJVqebtT
         8UM6ljdDBw+NspdKa8VDjuAJryVipiJ2d5BMdGobjTcCsnoMkvi+92liIz/lCdpjpD
         1dcLRxmGKj4oA==
Received: by pali.im (Postfix)
        id 9FFDF895; Tue, 16 Feb 2021 11:41:41 +0100 (CET)
Date:   Tue, 16 Feb 2021 11:41:41 +0100
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
Message-ID: <20210216104141.umy6zrrkal3dlj5j@pali>
References: <20210210180322.rlfxdussqhejqpo6@pali>
 <966f50f2-68b2-4d4f-85f0-396df112c0f4@www.fastmail.com>
 <20210211195559.n2j4jnchl2ho54mg@pali>
 <1ad78446-4a40-4c3e-8680-6dbf19616515@www.fastmail.com>
 <20210211234445.hbv2diphmgbir76u@pali>
 <000b92cc-9b54-4af9-b95c-d1317fb6f97f@www.fastmail.com>
 <20210213100139.ckrscepg72zjkj4f@pali>
 <c0b02aa0-1789-43a3-8d73-057890f703f1@www.fastmail.com>
 <20210214123310.d6armpep7kxbymbu@pali>
 <675b7a74-066b-4dc0-8dcb-f11c5606ae52@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675b7a74-066b-4dc0-8dcb-f11c5606ae52@www.fastmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 February 2021 21:48:08 nnet wrote:
> > Could you test following change instead of PATCH 04/10? I added here also
> > logic for 1.2 GHz variant with 1.132 V value another change is that
> > value for load L0 is not touched as it is stable.
> 
> These changes to patch 04/10 worked going 600 MHz <-> 1.2 GHz , _but_ only with:
> 
> ++#define MIN_VOLT_MV_FOR_L1_1200MHZ 1213
> 
> During this latest testing I saw freezes with 1132 mV.
> 
> I've had no lockups with 1213 mV which I just used from the values for L1/L0 from OTP.

I still do not know what is the meaning of values stored in OTP...
And there are more non-zero bits which are not used (yet).

Anyway, with your another test it looks like that limit is not based on
fixed value but rather on current L0 value. Therefore I'm thinking if
the correct way is instead to use L1 := L0 voltage value for 1/1.2 GHz
mode. Could you try following change instead of previous and PATCH 04/10?

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index b8dc6c849..12d0ff7b1 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -208,6 +208,8 @@ static u32 armada_37xx_avs_val_match(int target_vm)
  * - L2 & L3 voltage should be about 150mv smaller than L0 voltage.
  * This function calculates L1 & L2 & L3 AVS values dynamically based
  * on L0 voltage and fill all AVS values to the AVS value table.
+ * When base CPU frequency is 1000 or 1200 MHz then there is additional
+ * minimal avs value for load L1.
  */
 static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
 						struct armada_37xx_dvfs *dvfs)
@@ -239,17 +241,36 @@ static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
 		for (load_level = 1; load_level < LOAD_LEVEL_NR; load_level++)
 			dvfs->avs[load_level] = avs_min;
 
+		/*
+		 * Set the avs values for load L0 and L1 when base CPU frequency
+		 * is 1000/1200 MHz to its typical initial values according to
+		 * the Armada 3700 Hardware Specifications.
+		 */
+		if (dvfs->cpu_freq_max >= 1000*1000*1000) {
+			if (dvfs->cpu_freq_max >= 1200*1000*1000)
+				avs_min = armada_37xx_avs_val_match(1155);
+			else
+				avs_min = armada_37xx_avs_val_match(1108);
+			dvfs->avs[0] = dvfs->avs[1] = avs_min;
+		}
+
 		return;
 	}
 
 	/*
 	 * L1 voltage is equal to L0 voltage - 100mv and it must be
-	 * larger than 1000mv
+	 * larger than 1000mv. When base CPU frequency is 1000/1200 MHz,
+	 * L1 voltage must must be equal to L0 voltage, otherwise
+	 * the CPU gets stuck when switching from load L1 to load L0.
 	 */
 
-	target_vm = avs_map[l0_vdd_min] - 100;
-	target_vm = target_vm > MIN_VOLT_MV ? target_vm : MIN_VOLT_MV;
-	dvfs->avs[1] = armada_37xx_avs_val_match(target_vm);
+	if (dvfs->cpu_freq_max >= 1000*1000*1000) {
+		dvfs->avs[1] = dvfs->avs[0];
+	} else {
+		target_vm = avs_map[l0_vdd_min] - 100;
+		target_vm = target_vm > MIN_VOLT_MV ? target_vm : MIN_VOLT_MV;
+		dvfs->avs[1] = armada_37xx_avs_val_match(target_vm);
+	}
 
 	/*
 	 * L2 & L3 voltage is equal to L0 voltage - 150mv and it must
