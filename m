Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2FC3196D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhBKXpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhBKXp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:45:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 284F264E3B;
        Thu, 11 Feb 2021 23:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613087088;
        bh=wQXGVk868n3TbuqXz8QxMQD0DTXYejr5p+M0qMtusRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KYWBotRFeq6+rowJG6umFGURsI6nWcvVed1jYJU0Q9exfcFa8bnq1quBHBjTjBy/+
         c+FN1FEiXNy7AktduAy64s2ERtbHd3eh8XW/PlezYwu7Xa1+D9uzFr8otm2tFGEYPg
         QgJZSwbHWfy00PqE1ZZ/wXWiWVXq2nWUxjJ01bvoikQkP7EtD9L7S/K4n1oVdogWZG
         skhCDZAZGpHXyLQ5jZ+9M8EQDiZzUvePwvT8+S//Aq5m/rP1MEMpFHxUTcCYf3oBn0
         /IgUU5DrepWGPMRz8PDQK5XKJXMSWz0NAxqikylazqn+s2trkjacU2a1YSw+gmgx7x
         2I6uGkGMCaOhw==
Received: by pali.im (Postfix)
        id 002CDA80; Fri, 12 Feb 2021 00:44:45 +0100 (CET)
Date:   Fri, 12 Feb 2021 00:44:45 +0100
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
Message-ID: <20210211234445.hbv2diphmgbir76u@pali>
References: <20210210002619.43104a9b@kernel.org>
 <ac03801e-87e2-4e57-b131-bff52f03579d@www.fastmail.com>
 <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
 <a1277b1f-f829-4d02-9e54-68ab4faaa047@www.fastmail.com>
 <20210210092339.qy6wwuq6qr5m2ozr@pali>
 <d6971325-af71-4f71-91c2-7b661804c022@www.fastmail.com>
 <20210210180322.rlfxdussqhejqpo6@pali>
 <966f50f2-68b2-4d4f-85f0-396df112c0f4@www.fastmail.com>
 <20210211195559.n2j4jnchl2ho54mg@pali>
 <1ad78446-4a40-4c3e-8680-6dbf19616515@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ad78446-4a40-4c3e-8680-6dbf19616515@www.fastmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 February 2021 12:22:52 nnet wrote:
> On Thu, Feb 11, 2021, at 11:55 AM, Pali Rohár wrote:
> > On Wednesday 10 February 2021 11:08:59 nnet wrote:
> > > On Wed, Feb 10, 2021, at 10:03 AM, Pali Rohár wrote:
> > > > > > Hello! Could you please enable userspace governor during kernel
> > > > > > compilation?
> > > > > > 
> > > > > >     CONFIG_CPU_FREQ_GOV_USERSPACE=y
> > > > > > 
> > > > > > It can be activated via command:
> > > > > > 
> > > > > >     echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> > > > > > 
> > > > > > After that you can "force" CPU frequency to specific value, e.g.:
> > > > > > 
> > > > > >     echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
> > > > > > 
> > > > > > I need to know which switch (from --> to freq) cause this system hang.
> > > > > > 
> > > > > > This patch series (via MIN_VOLT_MV_FOR_L0_L1_1GHZ) is fixing only
> > > > > > switching from 500 MHz to 1000 MHz on 1 GHz variant. As only this switch
> > > > > > is causing issue.
> > > > > > 
> > > > > > I have used following simple bash script to check that switching between
> > > > > > 500 MHz and 1 GHz is stable:
> > > > > > 
> > > > > >     while true; do
> > > > > >         echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > >         echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > >         echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > >         echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > >     done
> > > > > 
> > > > > echo userspace | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> > > > > while true; do
> > > > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > >   echo 600000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > done
> > > > > 
> > > > > >> +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
> > > > > 
> > > > > With 1108 I get a freeze within a minute. The last output to stdout is 600000.
> > > > > 
> > > > > With 1120 it takes a few minutes.
> > > > > 
> > > > > With any of 1225, 1155, 1132 the device doesn't freeze over the full 5 minute load test.
> > > > > 
> > > > > I'm using ondemand now with the above at 1132 without issue so far.
> > > > 
> > > > Great, thank you for testing!
> > > > 
> > > > Can you check if switching between any two lower frequencies 200000
> > > > 300000 600000 is stable?
> > > 
> > > This is stable using 1132 mV for MIN_VOLT_MV_FOR_L0_L1_1GHZ:
> > > 
> > > while true; do
> > >   # down
> > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > ...
> > 
> > Hello!
> > 
> > Could you please re-run test without tee, in form as I have shown above?
> > UART is slow and printing something to console adds delay which decrease
> > probability that real issue is triggered as this is timing issue.
> 
> The test was done over SSH.

Ok! But it is still better to not print any results as it adds unwanted
delay between frequency switching.

> > Also please do tests just between two frequencies in loop as I observed
> > that switching between more decreased probability to hit issue.
> 
> > > > > echo userspace | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> > > > > while true; do
> > > > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > >   echo 600000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> > > > > done
> 
> The first test ^ switched between 600 MHz and 1.2 GHz.
> 
> > The real issue for 1 GHz variant of A3720 is only when doing switch from
> > 500 MHz to 1 GHz. So could you try to do some tests also without
> > changing MIN_VOLT_MV_FOR_L0_L1_1GHZ and switching just between non-1.2
> > frequencies (to verify that on 1.2 GHz variant it is also from 600 MHz
> > to 1.2 GHz)?
> 
> With 1108 mV and switching between 600 MHz and 1.2GHz, I always saw a freeze within a minute.

I mean to try switching with 1.108 V between 200 MHz and 300 MHz or
between 300 MHz and 600 MHz. To check that issue is really only with
switch from 600 MHz to 1.2 GHz.

I need to know if current settings are fine for 200, 300 and 600 MHz
frequencies and the only 600 --> 1200 needs to be fixed.
