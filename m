Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD98A44ACD3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbhKILsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhKILsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:48:20 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1658AC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:45:34 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1mkPZ3-0003n8-1T; Tue, 09 Nov 2021 12:45:21 +0100
Date:   Tue, 9 Nov 2021 11:45:12 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Trevor Woerner <twoerner@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] mtdblock: Advertise about UBI and UBI block
Message-ID: <YYpfSNY9hOPmu165@makrotopia.org>
References: <20210801234509.18774-1-ezequiel@collabora.com>
 <20211026150350.GA5136@localhost>
 <876982414.38679.1635274892099.JavaMail.zimbra@nod.at>
 <20211028133119.GA21237@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028133119.GA21237@localhost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 09:31:19AM -0400, Trevor Woerner wrote:
> On Tue 2021-10-26 @ 09:01:32 PM, Richard Weinberger wrote:
> > Trevor,
> > 
> > ----- Ursprüngliche Mail -----
> > > Von: "Trevor Woerner" <twoerner@gmail.com>
> > > An: "Ezequiel Garcia" <ezequiel@collabora.com>
> > > CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "richard"
> > > <richard@nod.at>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>
> > > Gesendet: Dienstag, 26. Oktober 2021 17:03:50
> > > Betreff: Re: [PATCH 0/3] mtdblock: Advertise about UBI and UBI block
> > 
> > > On Sun 2021-08-01 @ 08:45:02 PM, Ezequiel Garcia wrote:
> > >> Hi Richard, and everyone else:
> > >> 
> > >> Browsing the internet for "JFFS2 mtd" results in tutorials, articles
> > >> and github.gists0 that point to mtdblock.
> > >> 
> > >> In fact, even the MTD wiki mentions that JFFS2
> > >> needs mtdblock to mount a rootfs:
> > >> 
> > >>   http://www.linux-mtd.infradead.org/faq/jffs2.html
> > >> 
> > >> Moreover, I suspect there may be lots of users
> > >> that still believe mtdblock is somehow needed to
> > >> mount SquashFS.
> > >> 
> > >> I've taken a verbose route and added a pr_warn
> > >> warning if the devices are NAND. I don't think using
> > >> NAND without UBI is too wise, and given the amount
> > >> of outdated tutorials I believe some advertising
> > >> will help.
> > > 
> > > Not all NAND partitions on a device will contain linux root filesystems. For a
> > > linux root filesystem perhaps using UBI/UBIFS is preferred, yet these messages
> > > print out for each and every NAND partition:
> > > 
> > >	[    0.900827] Creating 8 MTD partitions on "nxp_lpc3220_slc":
> > >	[    0.906431] 0x000000000000-0x000000020000 : "bootrom"
> > >	[    0.913523] mtdblock: MTD device 'bootrom' is NAND, please consider using UBI
> > >	block devices instead.
> > >	[    0.933334] 0x000000020000-0x000000080000 : "uboot"
> > >	[    0.940439] mtdblock: MTD device 'uboot' is NAND, please consider using UBI
> > >	block devices instead.
> > >	[    0.963322] 0x000000080000-0x000000440000 : "fbkernel"
> > >	[    0.970655] mtdblock: MTD device 'fbkernel' is NAND, please consider using
> > >	UBI block devices instead.
> > >	[    0.993361] 0x000000440000-0x000000920000 : "fbrootfs"
> > >	[    1.000725] mtdblock: MTD device 'fbrootfs' is NAND, please consider using
> > >	UBI block devices instead.
> > >	[    1.023315] 0x000000920000-0x000000ce0000 : "c_kernel"
> > >	[    1.030722] mtdblock: MTD device 'c_kernel' is NAND, please consider using
> > >	UBI block devices instead.
> > >	[    1.053444] 0x000000ce0000-0x000000d00000 : "c__atags"
> > >	[    1.060742] mtdblock: MTD device 'c__atags' is NAND, please consider using
> > >	UBI block devices instead.
> > >	[    1.083349] 0x000000d00000-0x000001000000 : "c_rootfs"
> > >	[    1.090702] mtdblock: MTD device 'c_rootfs' is NAND, please consider using
> > >	UBI block devices instead.
> > >	[    1.113335] 0x000001000000-0x000020000000 : "mender"
> > >	[    1.131627] mtdblock: MTD device 'mender' is NAND, please consider using UBI
> > >	block devices instead.
> > > 
> > > NAND tends to be something found on older devices, the firmware/bootloaders
> > > of older devices couldn't possibly understand UBI/UBIFS so many of these
> > > partitions need be "raw" partitions, or use something that predates UBI.
> > > 
> > > Ironically my "mender" partition contains a UBI (with multiple UBIFSes inside)
> > > yet I got the same "please use UBI" message as all the others (lol)
> > > 
> > > I'm specifying my partitions in DT with:
> > > 
> > > partitions {
> > >        compatible = "fixed-partitions";
> > >        #address-cells = <1>;
> > >        #size-cells = <1>;
> > > 
> > >        mtd0@0       { label = "bootrom";   reg = <0x00000000 0x00020000>; };
> > >        mtd1@20000   { label = "uboot";     reg = <0x00020000 0x00060000>; };
> > >        mtd2@80000   { label = "fbkernel";  reg = <0x00080000 0x003c0000>; };
> > >        mtd3@440000  { label = "fbrootfs";  reg = <0x00440000 0x004e0000>; };
> > >        mtd4@920000  { label = "c_kernel";  reg = <0x00920000 0x003c0000>; };
> > >        mtd5@ce0000  { label = "c__atags";  reg = <0x00ce0000 0x00020000>; };
> > >        mtd6@d00000  { label = "c_rootfs";  reg = <0x00d00000 0x00300000>; };
> > >        mtd7@1000000 { label = "mender";    reg = <0x01000000 0x1f000000>; };
> > > };
> > > 
> > > which is why, I assume, I'm getting these messages. Is there a UBI-friendly
> > > way to define them to avoid these messages?
> > 
> > Hmm, maybe it makes sense to advertise it only once and not for each mtdblock device.
> 
> Are there known bugs or issues using ubi/jffs2/squashfs on top of mtdblock? Is
> mtdblock being deprecated? If so I could certainly understand warning users of
> the situation.

In case of NAND flash, using mtdblock is generally not such a good idea
as you miss out on features which are essential for the vitality of the
flash (wear-leveling and such).

UBI works on top of mtd device, it cannot work on top of mtdblock.

For JFFS2 we got a hack which allows mounting using the mtdblock device
but actually also uses the mtd device under the hood (being able to
mount using mtdblock is a pure convenience feature for easier
compatibility with userspace tools).

So generally, when using mtdblock on top of NAND flash you are doing
less-than-optimal in every case.

> 
> Is there a safe/easy way to update an older device in a way that wipes
> the entire flash while running from flash? If not then having the kernel
> perpetually advertising that I'm not using my flash a certain way isn't very
> useful, especially if there aren't any underlying reasons why my usage isn't
> valid.

There are very good reasons for not using mtdblock on NAND flash, such
as the complete lack of wear-leveling (which is mandatory if you want
that flash to survive a couple of write cycles).

Legacy setups are sometimes not easy to migrate, to do things properly
you may have to replace or modify the way the device loads the kernel
from flash during boot, like I did for a recent SPI-NAND based WiFi
router:
https://github.com/dangowrt/linksys-e8450-openwrt-installer
