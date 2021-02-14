Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF4A31B05B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 13:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhBNMd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 07:33:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhBNMdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 07:33:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7D7B64E56;
        Sun, 14 Feb 2021 12:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613305993;
        bh=r1Wwjfw01iYqtMxmd3Dcij/7q1K2DV0c9LYJ99AUvsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2pC0SRCBC53SPPF4V6Iua3sUsUL6S7d9duKDgaiXv52TQgZtqtoQCPJuos20EwVQ
         aMod1VPbwi+eMdtXtyvPtGextkNm2fj11WQw8kIaLfywcYJE/LUaf5Rxtltrkn5Jfp
         lPta+y5yRnqPqp6HyI+SKtlHLOlJc2ZdpMvVPkXmPtWFKKMdvef7OG/jFkE0JuRdCl
         heypVfdRtzoaFj4lqw321wOzPakBrzGJNX+9Jwm4dQVqU+MXg3+5cIiNjR+vNyLYCh
         57tE4K2NvWJhpJV73E6Di5S+DCkNCMHvR7IKiEEYDkJBLONNl6OWi+IxBhD4VMUvsD
         co/BCW3VvNSmA==
Received: by pali.im (Postfix)
        id 6089A77C; Sun, 14 Feb 2021 13:33:10 +0100 (CET)
Date:   Sun, 14 Feb 2021 13:33:10 +0100
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
Message-ID: <20210214123310.d6armpep7kxbymbu@pali>
References: <20210210092339.qy6wwuq6qr5m2ozr@pali>
 <d6971325-af71-4f71-91c2-7b661804c022@www.fastmail.com>
 <20210210180322.rlfxdussqhejqpo6@pali>
 <966f50f2-68b2-4d4f-85f0-396df112c0f4@www.fastmail.com>
 <20210211195559.n2j4jnchl2ho54mg@pali>
 <1ad78446-4a40-4c3e-8680-6dbf19616515@www.fastmail.com>
 <20210211234445.hbv2diphmgbir76u@pali>
 <000b92cc-9b54-4af9-b95c-d1317fb6f97f@www.fastmail.com>
 <20210213100139.ckrscepg72zjkj4f@pali>
 <c0b02aa0-1789-43a3-8d73-057890f703f1@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0b02aa0-1789-43a3-8d73-057890f703f1@www.fastmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 February 2021 10:30:19 nnet wrote:
> On Sat, Feb 13, 2021, at 2:01 AM, Pali Rohár wrote:
> > On Thursday 11 February 2021 16:41:13 nnet wrote:
> > > On Thu, Feb 11, 2021, at 3:44 PM, Pali Rohár wrote:
> > > > On Thursday 11 February 2021 12:22:52 nnet wrote:
> > > > > On Thu, Feb 11, 2021, at 11:55 AM, Pali Rohár wrote:
> > > > > > On Wednesday 10 February 2021 11:08:59 nnet wrote:
> > > > > > > On Wed, Feb 10, 2021, at 10:03 AM, Pali Rohár wrote:
> > > > > > > > > > Hello! Could you please enable userspace governor during kernel
> > > > > > > > > > compilation?
> > > > > > > > > > 
> > > > > > > > > >     CONFIG_CPU_FREQ_GOV_USERSPACE=y
> > > > > > > > > > 
> > > > > > > > > > It can be activated via command:
> > > > > > > > > > 
> > > > > > > > > >     echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> > > > > > > > > > 
> > > > > > > > > > After that you can "force" CPU frequency to specific value, e.g.:
> > > > > > > > > > 
> > > > > > > > > >     echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
> > > > > > > > > > 
> > > > > > > > > > I need to know which switch (from --> to freq) cause this system hang.
> > > > > > > > > > 
> > > > > > > > > > This patch series (via MIN_VOLT_MV_FOR_L0_L1_1GHZ) is fixing only
> > > > > > > > > > switching from 500 MHz to 1000 MHz on 1 GHz variant. As only this switch
> > > > > > > > > > is causing issue.
> > > > > > > > > > 
> > > > > > > > > > I have used following simple bash script to check that switching between
> > > > > > > > > > 500 MHz and 1 GHz is stable:
> > > > > > > > > > 
> > > > > > > > > >     while true; do
> > > > > > > > > >         echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > > > > > >         echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > > > > > >         echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > > > > > >         echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > > > > > >     done
> > > > > > > > > 
> > > > > > > > > echo userspace | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> > > > > > > > > while true; do
> > > > > > > > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > > > > >   echo 600000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > > > > > done
> > > > > > > > > 
> > > > > > > > > >> +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
> > > > > > > > > 
> > > > > > > > > With 1108 I get a freeze within a minute. The last output to stdout is 600000.
> > > > > > > > > 
> > > > > > > > > With 1120 it takes a few minutes.
> > > > > > > > > 
> > > > > > > > > With any of 1225, 1155, 1132 the device doesn't freeze over the full 5 minute load test.
> > > > > > > > > 
> > > > > > > > > I'm using ondemand now with the above at 1132 without issue so far.
> > > > > > > > 
> > > > > > > > Great, thank you for testing!
> > > > > > > > 
> > > > > > > > Can you check if switching between any two lower frequencies 200000
> > > > > > > > 300000 600000 is stable?
> > > > > > > 
> > > > > > > This is stable using 1132 mV for MIN_VOLT_MV_FOR_L0_L1_1GHZ:
> > > > > > > 
> > > > > > > while true; do
> > > > > > >   # down
> > > > > > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > > ...
> > > > > > 
> > > > > > Hello!
> > > > > > 
> > > > > > Could you please re-run test without tee, in form as I have shown above?
> > > > > > UART is slow and printing something to console adds delay which decrease
> > > > > > probability that real issue is triggered as this is timing issue.
> > > > > 
> > > > > The test was done over SSH.
> > > > 
> > > > Ok! But it is still better to not print any results as it adds unwanted
> > > > delay between frequency switching.
> > > > 
> > > > > > Also please do tests just between two frequencies in loop as I observed
> > > > > > that switching between more decreased probability to hit issue.
> > > > > 
> > > > > > > > > echo userspace | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> > > > > > > > > while true; do
> > > > > > > > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > > > > >   echo 600000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > > > > > done
> > > > > 
> > > > > The first test ^ switched between 600 MHz and 1.2 GHz.
> > > > > 
> > > > > > The real issue for 1 GHz variant of A3720 is only when doing switch from
> > > > > > 500 MHz to 1 GHz. So could you try to do some tests also without
> > > > > > changing MIN_VOLT_MV_FOR_L0_L1_1GHZ and switching just between non-1.2
> > > > > > frequencies (to verify that on 1.2 GHz variant it is also from 600 MHz
> > > > > > to 1.2 GHz)?
> > > > > 
> > > > > With 1108 mV and switching between 600 MHz and 1.2GHz, I always saw a freeze within a minute.
> > > > 
> > > > I mean to try switching with 1.108 V between 200 MHz and 300 MHz or
> > > > between 300 MHz and 600 MHz. To check that issue is really only with
> > > > switch from 600 MHz to 1.2 GHz.
> > > 
> > > With:
> > > 
> > > +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
> > > 
> > > with 5 min load:
> > > 
> > > # no lock-up
> > > 
> > > echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> > > while true; do
> > >   echo 200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > >   echo 300000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > done
> > > 
> > > # no lock-up
> > > 
> > > echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> > > while true; do
> > >   echo 300000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > >   echo 600000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > done
> > > 
> > > # lock-up with 10 seconds of load applied
> > > 
> > > echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> > > while true; do
> > >   echo 600000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > >   echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > done
> > 
> > Ok! So it really looks like that on 1.2 GHz is the same issue. We need
> > to increase voltage for L1 load (600 MHz). But question is what is the
> > threshold (it is 1132 mV or lower?) 
> 
> Lower then 1132 mV causes freezes. No freezes with 1132 mV.
> 
> > and second question is what
> > increasing minimal voltage may cause with board.
> 
> I don't have any further information on the issue and device then that experience.
> 
> I've tested on two of these devices which suggests it's not an oddity with one instance of it.

Ok, thank you for information.

Could you test following change instead of PATCH 04/10? I added here also
logic for 1.2 GHz variant with 1.132 V value and another change is that
value for load L0 is not touched as it is stable.

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index b8dc6c849..8a4afb048 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -73,6 +73,8 @@
 #define LOAD_LEVEL_NR	4
 
 #define MIN_VOLT_MV 1000
+#define MIN_VOLT_MV_FOR_L1_1000MHZ 1108
+#define MIN_VOLT_MV_FOR_L1_1200MHZ 1132
 
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
@@ -239,6 +243,18 @@ static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
 		for (load_level = 1; load_level < LOAD_LEVEL_NR; load_level++)
 			dvfs->avs[load_level] = avs_min;
 
+		/*
+		 * Set the avs value for load L0 and L1 when base CPU frequency is 1000/1200 MHz,
+		 * otherwise the CPU gets stuck when switching from load L1 to load L0.
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
 
@@ -258,6 +274,26 @@ static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
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

> > 
> > Basically there is absolutely no information about 1.2 GHz variant and
> > this issue...
> >
> > > > I need to know if current settings are fine for 200, 300 and 600 MHz
> > > > frequencies and the only 600 --> 1200 needs to be fixed.
> > > >
> >
