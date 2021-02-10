Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8621531623A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhBJJ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:28:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhBJJYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:24:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6694E64DB1;
        Wed, 10 Feb 2021 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612949022;
        bh=oO2ra4rCsA8isDsXvlKjVgpSfxzLG4pt6aZLIilyCLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtvMtokUh5uRH2xaeT2qOIz8UIBGWpnsyrOZ7rNHI6N3Pb7jvej8V5N9DrMfq7Hsw
         M6KgY1VIoop+am42kzmFiucfBE/RDkj6bG5M+z3jYyO8O7TQFDZm0N9NY6pVE2XCg5
         p79niI0jXeHcaZAnVZ3pZux+l9I0HoOydjb0tsJoKkoCGXjIsTr6CDKTKrXrWGSaCp
         ovopCtFfyAnCRmGQjcQvDAUGCOv2M/sp8tXi/J1R3OdZF/vzGZBzBcOcHg5nNBqZmx
         H7bBsepov3895UtKk6K6V5+s05x8JHToI/ckeRSl3Rjp1HCgiJ1P/q0K6xAGwyZTzM
         UnRj86AIx4s1g==
Received: by pali.im (Postfix)
        id E7CB0A56; Wed, 10 Feb 2021 10:23:39 +0100 (CET)
Date:   Wed, 10 Feb 2021 10:23:39 +0100
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
Message-ID: <20210210092339.qy6wwuq6qr5m2ozr@pali>
References: <20210209213330.hnc7op72zoj24mgz@pali>
 <7b0988cc-eeb8-4ea7-92f6-e8234ca910d3@www.fastmail.com>
 <20210209224223.p22yhjdy7ibzepss@pali>
 <93745280-dbe9-491c-a79d-c9c364b83880@www.fastmail.com>
 <20210209225630.mdwnzkvnaz3r4blt@pali>
 <a86c5069-d423-44db-92dd-b3e406b7ec91@www.fastmail.com>
 <20210210002619.43104a9b@kernel.org>
 <ac03801e-87e2-4e57-b131-bff52f03579d@www.fastmail.com>
 <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
 <a1277b1f-f829-4d02-9e54-68ab4faaa047@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1277b1f-f829-4d02-9e54-68ab4faaa047@www.fastmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 February 2021 18:07:41 nnet wrote:
> On Tue, Feb 9, 2021, at 5:51 PM, nnet wrote:
> > On Tue, Feb 9, 2021, at 5:31 PM, nnet wrote:
> > > On Tue, Feb 9, 2021, at 3:26 PM, Marek Behún wrote:
> > > > On Tue, 09 Feb 2021 15:16:45 -0800
> > > > nnet <nnet@fastmail.fm> wrote:
> > > > 
> > > > > I've two of these and I've just swapped them (and re-pasted the heat sinks).
> > > > > 
> > > > > The second one ran under load for awhile and now has frozen as well.
> > > > > 
> > > > > Under a moderate load `wget -O /dev/null <large.bin>` @X00Mbits they are fine.
> > > > > 
> > > > > Under a 1 min speed test of load ~200Mbits routed WireGuard they freeze.
> > > > > 
> > > > > They fine with both those workloads @1000_800.
> > > > > 
> > > > > Perhaps it's heat? Unfortunately I don't have any numbers on that ATM.
> > > > 
> > > > Try disabling cpufreq in kernel completely, compile boot image at
> > > > 1200 MHz. If it continues freezing, then I fear we can't help you with
> > > > 1200 MHz :(
> > > 
> > > cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies 
> > > 200000 300000 600000 1200000 
> > > 
> > > I'm not getting any freezes with 1.2GHz fixed after 20 minutes of load:
> > > 
> > > echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
> > > 
> > > Setting it back to min 200MHz I get a freeze within a minute:
> > > 
> > > echo 200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq

Hello! Could you please enable userspace governor during kernel
compilation?

    CONFIG_CPU_FREQ_GOV_USERSPACE=y

It can be activated via command:

    echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor

After that you can "force" CPU frequency to specific value, e.g.:

    echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed

I need to know which switch (from --> to freq) cause this system hang.

This patch series (via MIN_VOLT_MV_FOR_L0_L1_1GHZ) is fixing only
switching from 500 MHz to 1000 MHz on 1 GHz variant. As only this switch
is causing issue.

I have used following simple bash script to check that switching between
500 MHz and 1 GHz is stable:

    while true; do
        echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
        echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
        echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
        echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
    done

(of course on 1.2 GHz variant you need to adjust values as only
following frequencies 200000 300000 600000 1200000 are supported)

> > > > Marek
> > > >
> > 
> > > +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
> > 
> > Based on the below at boot time might an equivalent of the above need 
> > to be 1225 for 1.2GHz?
> > 
> > 1200_750
> > SVC REV: 5, CPU VDD voltage: 1.225V
> > 
> > 1000_800
> > SVC REV: 5, CPU VDD voltage: 1.108V

This value is printed in WTMI avs.c by following code:

    shift = OTP_SVC_SPEED_1000_OFF;
    (OR)
    shift = OTP_SVC_SPEED_1200_OFF;

    vdd_otp = ((otp_data[OTP_DATA_SVC_SPEED_ID] >> shift) +
                AVS_VDD_BASE) & AVS_VDD_MASK;
    regval |= (vdd_otp << HIGH_VDD_LIMIT_OFF);
    regval |= (vdd_otp << LOW_VDD_LIMIT_OFF);
    printf("SVC REV: %d, CPU VDD voltage: %s\n", svc_rev,
            avis_dump[vdd_otp].desc);

So voltage value is read from the OTP memory.

But I do not know what this value means.

> I did this for a quick test for 1.2GHz:
> 
> +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1225
> 
> This is working well so far. Frequency is shifting up/down with load applied/stopped.
