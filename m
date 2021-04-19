Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E81363E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhDSIzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:55:40 -0400
Received: from foss.arm.com ([217.140.110.172]:38622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhDSIzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:55:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BDA51FB;
        Mon, 19 Apr 2021 01:55:07 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C81B3F85F;
        Mon, 19 Apr 2021 01:55:05 -0700 (PDT)
Date:   Mon, 19 Apr 2021 09:54:43 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] sunxi: Enforce consistent MMC numbering
Message-ID: <20210419095443.1548432e@slackpad.fritz.box>
In-Reply-To: <CAGb2v642Z3iH7fUWa31Rb5j+nWdZ=sXn2BYw3_dyE9P6iuL0Cg@mail.gmail.com>
References: <20210419025246.21722-1-samuel@sholland.org>
        <CAGb2v642Z3iH7fUWa31Rb5j+nWdZ=sXn2BYw3_dyE9P6iuL0Cg@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 11:17:19 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

Hi,

> On Mon, Apr 19, 2021 at 10:52 AM Samuel Holland <samuel@sholland.org> wrote:
> >
> > Dealing with the inconsistent numbering has been a major pain, and
> > there is a solution with (as far as I can tell) no tangible downsides.
> > So let's use it.

Thanks Samuel for sending this!

> > Yes, I know the kernel supports UUIDs for root=. But UUIDs do not help
> > when referencing the whole, unpartitioned device, like is needed for
> > updating the bootloader and firmware. So for the use case of "write a
> > bootloader to the SD card, regardless of where the board is currently
> > booted from", I know of two options:
> >   - Dig around in sysfs to find the mmc number from the MMIO address,
> >     which means I have to know the MMIO addresses for every SoC, or
> >   - Apply patches like these.
> >
> > Samuel Holland (2):
> >   ARM: dts: sunxi: h3/h5: Enforce consistent MMC numbering
> >   arm64: dts: allwinner: Enforce consistent MMC numbering
> >
> >  arch/arm/boot/dts/sunxi-h3-h5.dtsi            | 6 ++++++
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 6 ++++++  
> 
> At least with Rockchip this is now done at the board level. IIRC it was
> a request from other people to not do it at the SoC level. I don't recall
> exactly who though.

FWIW, I am very much in favour of these patches, at a SoC level:
The *SoC* BootROM imposes an order, by probing the first (by MMIO
address order) MMC controller first for boot devices. IIRC that's a
different story for Rockchip?
And if people really don't care about the order, then having a certain
order doesn't hurt, so we could as well use the "natural" order, as it
was before.

Also UUIDs only help if you boot with an initramfs to resolve them,
which proves to be extra pain if you don't compile kernels on the
device, or not inside a distribution environment.


One thing I was wondering about though is that U-Boot currently defines
"mmc1 = &mmc2;", so that the eMMC is always MMC device 1. This is also
the BootROM probe order (MMC1 is never touched). I wonder if we should
mimic this here, since MMC2 is clearly the device for eMMC (due to
8-bit bus width support)? So from a block device perspective we would
have always have mmcblk0 and mmcblk1.
Otherwise it would conflict with U-Boot's current fixup[1], so
U-Boot's DT would either need to deviate or create boot script breakages
there.

Cheers,
Andre

[1]
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/sunxi-u-boot.dtsi#L14-16
