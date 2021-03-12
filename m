Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE9338859
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhCLJMi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 Mar 2021 04:12:38 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56555 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhCLJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:12:12 -0500
X-Originating-IP: 90.65.91.141
Received: from localhost (lfbn-lyo-1-1912-141.w90-65.abo.wanadoo.fr [90.65.91.141])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 464286000D;
        Fri, 12 Mar 2021 09:12:07 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andre Heider <a.heider@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?utf-8?Q?G=C3=A9rald?= Kerma <gerald@gk2.net>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: Re: [PATCH mvebu v3 00/10] Armada 37xx: Fix cpufreq changing base
 CPU speed to 800 MHz from 1000 MHz
In-Reply-To: <20210301192024.tgvp6f5zscbknepo@pali>
References: <20210114124032.12765-1-pali@kernel.org>
 <20210222194158.12342-1-pali@kernel.org>
 <20210301192024.tgvp6f5zscbknepo@pali>
Date:   Fri, 12 Mar 2021 10:12:06 +0100
Message-ID: <87a6r8ka6x.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pali,

> Hello Gregory!
>
> Patches are the for almost two months and more people have tested them.
> They are marked with Fixed/CC-stable tags, they should go also into
> stable trees as they are fixing CPU scaling and instability issues.
>
> Are there any issues with these patches? If not, could you please merge
> them for upcoming Linux version?

Actually I am not the maintainer of the clk and cpufreq subsystems, so
the only thing I can apply is the device tree relative patch.

Gregory

>
> On Monday 22 February 2021 20:41:48 Pali Rohár wrote:
>> Hello!
>> 
>> This is third version of patches for Armada 37xx cpufreq driver which
>> fix CPU scaling with 1 GHz base frequency.
>> 
>> The only change in this third version is modified patch 04/10 with fixes
>> for 1.2 GHz variant of Espressobin. Minimal CPU voltage in L1 load for
>> 1.2 GHz variant was increased to 1.155V.
>> 
>> Patches are now rebased on top of the kernel version 5.11 with all
>> collected Acked-by/Tested-by lines and are available also in my git
>> tree in branch a3720-cpufreq-issues:
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=a3720-cpufreq-issues
>> 
>> If you have other Armada 3720 boards with 1.2 GHz CPU, including
>> Espressobin V7, let us know if it is working fine for you.
>> 
>> Marek & Pali
>> 
>> Marek Behún (3):
>>   arm64: dts: marvell: armada-37xx: add syscon compatible to NB clk node
>>   cpufreq: armada-37xx: Fix setting TBG parent for load levels
>>   clk: mvebu: armada-37xx-periph: remove .set_parent method for CPU PM
>>     clock
>> 
>> Pali Rohár (7):
>>   cpufreq: armada-37xx: Fix the AVS value for load L1
>>   clk: mvebu: armada-37xx-periph: Fix switching CPU freq from 250 Mhz to
>>     1 GHz
>>   clk: mvebu: armada-37xx-periph: Fix workaround for switching from L1
>>     to L0
>>   cpufreq: armada-37xx: Fix driver cleanup when registration failed
>>   cpufreq: armada-37xx: Fix determining base CPU frequency
>>   cpufreq: armada-37xx: Remove cur_frequency variable
>>   cpufreq: armada-37xx: Fix module unloading
>> 
>>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi |   3 +-
>>  drivers/clk/mvebu/armada-37xx-periph.c       |  83 +++++++-------
>>  drivers/cpufreq/armada-37xx-cpufreq.c        | 111 +++++++++++++++----
>>  3 files changed, 135 insertions(+), 62 deletions(-)
>> 
>> -- 
>> 2.20.1
>> 

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
