Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8689D36F8B7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 12:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhD3K5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 06:57:23 -0400
Received: from foss.arm.com ([217.140.110.172]:45226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhD3K5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 06:57:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32134113E;
        Fri, 30 Apr 2021 03:56:32 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE4243F70D;
        Fri, 30 Apr 2021 03:56:30 -0700 (PDT)
Date:   Fri, 30 Apr 2021 11:55:45 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] sunxi: Enforce consistent MMC numbering
Message-ID: <20210430115545.6a45d1dc@slackpad.fritz.box>
In-Reply-To: <20210430091035.i4zoyzb4c2l22msb@gilmour>
References: <20210419025246.21722-1-samuel@sholland.org>
        <CAGb2v642Z3iH7fUWa31Rb5j+nWdZ=sXn2BYw3_dyE9P6iuL0Cg@mail.gmail.com>
        <20210419095443.1548432e@slackpad.fritz.box>
        <20210430091035.i4zoyzb4c2l22msb@gilmour>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 11:10:35 +0200
Maxime Ripard <maxime@cerno.tech> wrote:

Hi Maxime,

> On Mon, Apr 19, 2021 at 09:54:43AM +0100, Andre Przywara wrote:
> > On Mon, 19 Apr 2021 11:17:19 +0800
> > Chen-Yu Tsai <wens@csie.org> wrote:
> > 
> > Hi,
> >   
> > > On Mon, Apr 19, 2021 at 10:52 AM Samuel Holland <samuel@sholland.org> wrote:  
> > > >
> > > > Dealing with the inconsistent numbering has been a major pain, and
> > > > there is a solution with (as far as I can tell) no tangible downsides.
> > > > So let's use it.  
> > 
> > Thanks Samuel for sending this!
> >   
> > > > Yes, I know the kernel supports UUIDs for root=. But UUIDs do not help
> > > > when referencing the whole, unpartitioned device, like is needed for
> > > > updating the bootloader and firmware. So for the use case of "write a
> > > > bootloader to the SD card, regardless of where the board is currently
> > > > booted from", I know of two options:
> > > >   - Dig around in sysfs to find the mmc number from the MMIO address,
> > > >     which means I have to know the MMIO addresses for every SoC, or
> > > >   - Apply patches like these.
> > > >
> > > > Samuel Holland (2):
> > > >   ARM: dts: sunxi: h3/h5: Enforce consistent MMC numbering
> > > >   arm64: dts: allwinner: Enforce consistent MMC numbering
> > > >
> > > >  arch/arm/boot/dts/sunxi-h3-h5.dtsi            | 6 ++++++
> > > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
> > > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 6 ++++++    
> > > 
> > > At least with Rockchip this is now done at the board level. IIRC it was
> > > a request from other people to not do it at the SoC level. I don't recall
> > > exactly who though.  
> > 
> > FWIW, I am very much in favour of these patches, at a SoC level:
> > The *SoC* BootROM imposes an order, by probing the first (by MMIO
> > address order) MMC controller first for boot devices. IIRC that's a
> > different story for Rockchip?
> > And if people really don't care about the order, then having a certain
> > order doesn't hurt, so we could as well use the "natural" order, as it
> > was before.  
> 
> This doesn't have anything to do with the BootRom though but what we
> provide to the userspace?

My argument was that there is a "natural" order, not only by the
location in the MMIO space, but on a more logical level: the "first" SD
controller is first checked by the BootROM, so the SoC puts a "number
0" tag on this particular one. This is just because I heard the
(reasonable) argument that location in MMIO space should not be
significant, and deriving an order from that is arbitrary.

> The userspace has no guarantee about the
> kernel enumeration order for any bus (but UART for some reason), I'm not
> really sure why MMC would be an exception.

Userspace is one thing, but arguably there are ways to find the
partition you are looking for, because you have all the kernel *and*
userlevel tools at hand. The question is whether this needs to be overly
complicated and harder for the user.
But the other, more pressing problem is the kernel-only code in
init/do_mounts.c, which has very limited means to find a
certain partition (see below).

> Especially since the kernel will not try to catch up, this will be
> bound to be broken on a regular basis.

What do you mean with "will not try to catch up"? Do you mean there
might be other kernel changes that spoil the numbering again, in the
future?

> And that aside, assuming that a device only has an eMMC this would
> create the mmc2 device, which is completely weird and inconsistent
> with how any other bus behaves.

You have a point there, but I don't see how this would be a problem. I
think one advantage is *consistent* numbering across reboots, so it
will always be mmc2, even if you add a WiFi chip later (some boards
have that as an option). Also those SD-card less system could surely
override the labels in their board .dts files?

> > Also UUIDs only help if you boot with an initramfs to resolve them,
> > which proves to be extra pain if you don't compile kernels on the
> > device, or not inside a distribution environment.  
> 
> I'm not sure what you mean? The kernel is perfectly able to resolve
> them. You can also use PARTLABEL if you want something more user
> friendly.

init/do_mounts.c supports PARTUUID only, but most people/distributions
use UUID, which is filesystem metadata, so not easily accessible for
the kernel early and on a partition level only. And IIRC PARTLABEL is
only available on GPT partitioned disks.
Also PARTUUID is set at partition time, so a user formatting her own SD
card (or just changing the partition table) will have a unique PARTUUID,
and it cannot be used from within a filesystem image or
prefabricated boot script to reference its own partition
(in /etc/fstab).
And in general UUIDs are not very human friendly, so their main domain
is to be handled by code. I definitely don't memorise a single one of
them, but I do remember root=/dev/mmcblk0p2.

I find it *very* annoying to load my development kernel over TFTP, then
booting them with the rootfs from SD card or eMMC, and seeing it fail
about 50% of the time, because the numbering is off.
 
Cheers,
Andre
