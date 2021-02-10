Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9E4316E39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhBJSN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:13:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232563AbhBJSE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:04:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D85064EDF;
        Wed, 10 Feb 2021 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612980205;
        bh=maRX1T+Ro0oy2r659rdvDYRCax4wwk9nvVhKfUDtrm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmFfJfsjS+TQ/xy3noDUA/mlEgw9RKuWiE+8HDnsEuN4A+Pxp5jKk3MAzBGbxb+Oh
         YzLqSM63x/t1chIrfMCm4TKvazUQouStJEwmeHYS4+oH5uB3ksh9UopWZOTo9xdVqv
         jaqMiTjMMqfOSdjnnyBYLw+O3cZqYRKWTI2qPcYKW+1fkbGPRQfxuUt+byqn1LZUJV
         fS8wgQ9bPYz0126OW34PVQ3Z9BxjWzFAJqAi2Ab0jTcJEk5B1hcnIsCdUL7fHUDWTm
         SOfwl7VOqXN0faOtwlgILZPlZDmfUaYZvO1bzLXD39jeOP0YzrhU/IZeZ905mJD4IZ
         D/rH+iozij0Yg==
Received: by pali.im (Postfix)
        id E5342A56; Wed, 10 Feb 2021 19:03:22 +0100 (CET)
Date:   Wed, 10 Feb 2021 19:03:22 +0100
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
Message-ID: <20210210180322.rlfxdussqhejqpo6@pali>
References: <20210209224223.p22yhjdy7ibzepss@pali>
 <93745280-dbe9-491c-a79d-c9c364b83880@www.fastmail.com>
 <20210209225630.mdwnzkvnaz3r4blt@pali>
 <a86c5069-d423-44db-92dd-b3e406b7ec91@www.fastmail.com>
 <20210210002619.43104a9b@kernel.org>
 <ac03801e-87e2-4e57-b131-bff52f03579d@www.fastmail.com>
 <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
 <a1277b1f-f829-4d02-9e54-68ab4faaa047@www.fastmail.com>
 <20210210092339.qy6wwuq6qr5m2ozr@pali>
 <d6971325-af71-4f71-91c2-7b661804c022@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6971325-af71-4f71-91c2-7b661804c022@www.fastmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 February 2021 09:34:07 nnet wrote:
> On Wed, Feb 10, 2021, at 1:23 AM, Pali Rohár wrote:
> > On Tuesday 09 February 2021 18:07:41 nnet wrote:
> > > On Tue, Feb 9, 2021, at 5:51 PM, nnet wrote:
> > > > On Tue, Feb 9, 2021, at 5:31 PM, nnet wrote:
> > > > > On Tue, Feb 9, 2021, at 3:26 PM, Marek Behún wrote:
> > > > > > On Tue, 09 Feb 2021 15:16:45 -0800
> > > > > > nnet <nnet@fastmail.fm> wrote:
> > > > > > 
> > > > > > > I've two of these and I've just swapped them (and re-pasted the heat sinks).
> > > > > > > 
> > > > > > > The second one ran under load for awhile and now has frozen as well.
> > > > > > > 
> > > > > > > Under a moderate load `wget -O /dev/null <large.bin>` @X00Mbits they are fine.
> > > > > > > 
> > > > > > > Under a 1 min speed test of load ~200Mbits routed WireGuard they freeze.
> > > > > > > 
> > > > > > > They fine with both those workloads @1000_800.
> > > > > > > 
> > > > > > > Perhaps it's heat? Unfortunately I don't have any numbers on that ATM.
> > > > > > 
> > > > > > Try disabling cpufreq in kernel completely, compile boot image at
> > > > > > 1200 MHz. If it continues freezing, then I fear we can't help you with
> > > > > > 1200 MHz :(
> > > > > 
> > > > > cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies 
> > > > > 200000 300000 600000 1200000 
> > > > > 
> > > > > I'm not getting any freezes with 1.2GHz fixed after 20 minutes of load:
> > > > > 
> > > > > echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
> > > > > 
> > > > > Setting it back to min 200MHz I get a freeze within a minute:
> > > > > 
> > > > > echo 200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
> > 
> > Hello! Could you please enable userspace governor during kernel
> > compilation?
> > 
> >     CONFIG_CPU_FREQ_GOV_USERSPACE=y
> > 
> > It can be activated via command:
> > 
> >     echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> > 
> > After that you can "force" CPU frequency to specific value, e.g.:
> > 
> >     echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
> > 
> > I need to know which switch (from --> to freq) cause this system hang.
> > 
> > This patch series (via MIN_VOLT_MV_FOR_L0_L1_1GHZ) is fixing only
> > switching from 500 MHz to 1000 MHz on 1 GHz variant. As only this switch
> > is causing issue.
> > 
> > I have used following simple bash script to check that switching between
> > 500 MHz and 1 GHz is stable:
> > 
> >     while true; do
> >         echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> >         echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> >         echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> >         echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> >     done
> 
> echo userspace | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> while true; do
>   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
>   echo 600000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed;
> done
> 
> >> +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
> 
> With 1108 I get a freeze within a minute. The last output to stdout is 600000.
> 
> With 1120 it takes a few minutes.
> 
> With any of 1225, 1155, 1132 the device doesn't freeze over the full 5 minute load test.
> 
> I'm using ondemand now with the above at 1132 without issue so far.

Great, thank you for testing!

Can you check if switching between any two lower frequencies 200000
300000 600000 is stable?

> >> Update the CPU voltage value for loads L0 and L1 accordingly when base
> >> frequency is 1000 or 1200 MHz. The minimal value is updated from the
> >> original 1.05V to 1.108V.
> 
> Perhaps similiar to how a minimum of 1108 mV is useful when shifting to 1GHz, using a minimum of 1132 is useful when shifting to 1.2GHz.

Maybe... We can only wait if Marvell provide some details about this
issue.

> > (of course on 1.2 GHz variant you need to adjust values as only
> > following frequencies 200000 300000 600000 1200000 are supported)
> > 
> > > > > > Marek
> > > > > >
> > > > 
> > > > > +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
> > > > 
> > > > Based on the below at boot time might an equivalent of the above need 
> > > > to be 1225 for 1.2GHz?
> > > > 
> > > > 1200_750
> > > > SVC REV: 5, CPU VDD voltage: 1.225V
> > > > 
> > > > 1000_800
> > > > SVC REV: 5, CPU VDD voltage: 1.108V
> > 
> > This value is printed in WTMI avs.c by following code:
> > 
> >     shift = OTP_SVC_SPEED_1000_OFF;
> >     (OR)
> >     shift = OTP_SVC_SPEED_1200_OFF;
> > 
> >     vdd_otp = ((otp_data[OTP_DATA_SVC_SPEED_ID] >> shift) +
> >                 AVS_VDD_BASE) & AVS_VDD_MASK;
> >     regval |= (vdd_otp << HIGH_VDD_LIMIT_OFF);
> >     regval |= (vdd_otp << LOW_VDD_LIMIT_OFF);
> >     printf("SVC REV: %d, CPU VDD voltage: %s\n", svc_rev,
> >             avis_dump[vdd_otp].desc);
> > 
> > So voltage value is read from the OTP memory.
> > 
> > But I do not know what this value means.

Link to code: https://github.com/MarvellEmbeddedProcessors/A3700-utils-marvell/blob/master/wtmi/sys_init/avs.c

You can read this OTP memory (otp_data[] array) in U-Boot by command:

    md d0012604 1; md d0012604 1; md d0012604 1

> > > I did this for a quick test for 1.2GHz:
> > > 
> > > +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1225
> > > 
> > > This is working well so far. Frequency is shifting up/down with load applied/stopped.
> >
