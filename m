Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58B93193C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhBKUBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:01:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbhBKT4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:56:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35E3164E15;
        Thu, 11 Feb 2021 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613073362;
        bh=NtykC3JX9VvS+pW6IU8EX2IEGkMX/SOoN9eWQt5qNN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fjWIxkXgp1fwYOR4AgR931ujQFKeA+fTGZv0WRt5lj1T3bXKdqzgR83WRQncTwBXh
         GrKgV2YvVaIen1awO/CYZFjfht5sP490j8jP50YBN6WnUKntoIBwacWRYTFxa6DK1V
         OhItMyvGHQvRc/icmU1aVaOaVUL4G79TyroLaq3SICHPKNE3u0GC2xlfHZMajQ8jrG
         tRJvwZxQFPEV/6+Gg7r28VgdtfgnczkJ/BiZSCadgYapwO/x7bCViBkht3TKfiXWup
         6mX0foNqewjMTIbIBQEECgPEH00r2XbL26mgCJZgQa06cH3c5ElAYRqDkpXVH1X7Mq
         YD2UT3RXuYr5g==
Received: by pali.im (Postfix)
        id C2ED6A80; Thu, 11 Feb 2021 20:55:59 +0100 (CET)
Date:   Thu, 11 Feb 2021 20:55:59 +0100
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
Message-ID: <20210211195559.n2j4jnchl2ho54mg@pali>
References: <20210209225630.mdwnzkvnaz3r4blt@pali>
 <a86c5069-d423-44db-92dd-b3e406b7ec91@www.fastmail.com>
 <20210210002619.43104a9b@kernel.org>
 <ac03801e-87e2-4e57-b131-bff52f03579d@www.fastmail.com>
 <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
 <a1277b1f-f829-4d02-9e54-68ab4faaa047@www.fastmail.com>
 <20210210092339.qy6wwuq6qr5m2ozr@pali>
 <d6971325-af71-4f71-91c2-7b661804c022@www.fastmail.com>
 <20210210180322.rlfxdussqhejqpo6@pali>
 <966f50f2-68b2-4d4f-85f0-396df112c0f4@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <966f50f2-68b2-4d4f-85f0-396df112c0f4@www.fastmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 February 2021 11:08:59 nnet wrote:
> On Wed, Feb 10, 2021, at 10:03 AM, Pali Rohár wrote:
> > > > Hello! Could you please enable userspace governor during kernel
> > > > compilation?
> > > > 
> > > >     CONFIG_CPU_FREQ_GOV_USERSPACE=y
> > > > 
> > > > It can be activated via command:
> > > > 
> > > >     echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> > > > 
> > > > After that you can "force" CPU frequency to specific value, e.g.:
> > > > 
> > > >     echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
> > > > 
> > > > I need to know which switch (from --> to freq) cause this system hang.
> > > > 
> > > > This patch series (via MIN_VOLT_MV_FOR_L0_L1_1GHZ) is fixing only
> > > > switching from 500 MHz to 1000 MHz on 1 GHz variant. As only this switch
> > > > is causing issue.
> > > > 
> > > > I have used following simple bash script to check that switching between
> > > > 500 MHz and 1 GHz is stable:
> > > > 
> > > >     while true; do
> > > >         echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > >         echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > >         echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > >         echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > >     done
> > > 
> > > echo userspace | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> > > while true; do
> > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > >   echo 600000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > done
> > > 
> > > >> +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
> > > 
> > > With 1108 I get a freeze within a minute. The last output to stdout is 600000.
> > > 
> > > With 1120 it takes a few minutes.
> > > 
> > > With any of 1225, 1155, 1132 the device doesn't freeze over the full 5 minute load test.
> > > 
> > > I'm using ondemand now with the above at 1132 without issue so far.
> > 
> > Great, thank you for testing!
> > 
> > Can you check if switching between any two lower frequencies 200000
> > 300000 600000 is stable?
> 
> This is stable using 1132 mV for MIN_VOLT_MV_FOR_L0_L1_1GHZ:
> 
> while true; do
>   # down
>   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
...

Hello!

Could you please re-run test without tee, in form as I have shown above?
UART is slow and printing something to console adds delay which decrease
probability that real issue is triggered as this is timing issue.

Also please do tests just between two frequencies in loop as I observed
that switching between more decreased probability to hit issue.

The real issue for 1 GHz variant of A3720 is only when doing switch from
500 MHz to 1 GHz. So could you try to do some tests also without
changing MIN_VOLT_MV_FOR_L0_L1_1GHZ and switching just between non-1.2
frequencies (to verify that on 1.2 GHz variant it is also from 600 MHz
to 1.2 GHz)?
