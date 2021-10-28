Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9257B43E24A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhJ1Ndv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhJ1Ndu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:33:50 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E60C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 06:31:23 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id g25so3005355qvf.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vtcm+cVDOBMQDVtuIHnCW+Jxhn6Pk4wSFgRiWHBeVNY=;
        b=HO1OOsaSM0hufdukw2ilon9Xex9Jnv9qQ+IkBO+hVTz0fyLoFM0rnwnCdx84Zun6X6
         h15QuMuah7hHrp23BSPVXN7de8q581aTq3W2Z5uNyyts8fJzcPcRa1r+W8iBDhW/EK6f
         e7o6UpIWkOc6Hl6ls+zqgIHIPNRRUwU+o1lc15FrsCjbtjyuXQpTWIjhcqRquDi3/CtM
         zoFm+HxUbjFHIU8F6Gi4c1JHZlVZGvpCDdG4io4Chqn64NDEGwvFspPyNVHMSqnQ9JEi
         4Uw5M8eOLidcPorLFl1iRvJFkbxCZXk9IDoThkNk/dZQZvBJoagsMjEQv8hSaQk2Zi+o
         2J6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vtcm+cVDOBMQDVtuIHnCW+Jxhn6Pk4wSFgRiWHBeVNY=;
        b=ljT8VF0b0YfoQjMcFxzswWTM9oSe7bsfYme0eB5l/+Bv9o4sWI/fX7hgSquu+UwiMi
         X1EiY5XGwggmpNwnlx5iEgrk/KCd6/trMSbznVnD+PzHFC/gaRsNYq3aCz84JiQQ0UOy
         j3ZeGcwttSmsbsIV/R4K1sjU7gWid1uiIdU9Nym55Sk/Ux53NQfZe4kJ0bPakkdKw+sd
         AujkmV1ixd58Jc8GGMA/8IBlRw/+B+8EIg92xpSWbEWE327dGOk5g6VjLGs14oYqqe9V
         N1JOEoI1gAGov9YOA9BJPlcu4C2YnYUWvtjC4UWZ0bUYLpPOnp8mhKoB7nLOHHDBqkz1
         AOdQ==
X-Gm-Message-State: AOAM532az5bT19eN3znMdLLA205B3zN5ZZSo+gzWnvxmOXcjSjU7+iTN
        Shzm03oAYETKoiFlLalGrWw=
X-Google-Smtp-Source: ABdhPJyUY18X671/2pSGXpXoiWAbPSpeqwbtTgratogff+hDZC0XPS6OUASRhTResJBtoQ+ZmGTj7w==
X-Received: by 2002:a05:6214:1786:: with SMTP id ct6mr4022776qvb.58.1635427882948;
        Thu, 28 Oct 2021 06:31:22 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id bs33sm1955780qkb.130.2021.10.28.06.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 06:31:22 -0700 (PDT)
Date:   Thu, 28 Oct 2021 09:31:19 -0400
From:   Trevor Woerner <twoerner@gmail.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] mtdblock: Advertise about UBI and UBI block
Message-ID: <20211028133119.GA21237@localhost>
References: <20210801234509.18774-1-ezequiel@collabora.com>
 <20211026150350.GA5136@localhost>
 <876982414.38679.1635274892099.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <876982414.38679.1635274892099.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-10-26 @ 09:01:32 PM, Richard Weinberger wrote:
> Trevor,
> 
> ----- Ursprüngliche Mail -----
> > Von: "Trevor Woerner" <twoerner@gmail.com>
> > An: "Ezequiel Garcia" <ezequiel@collabora.com>
> > CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "richard"
> > <richard@nod.at>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>
> > Gesendet: Dienstag, 26. Oktober 2021 17:03:50
> > Betreff: Re: [PATCH 0/3] mtdblock: Advertise about UBI and UBI block
> 
> > On Sun 2021-08-01 @ 08:45:02 PM, Ezequiel Garcia wrote:
> >> Hi Richard, and everyone else:
> >> 
> >> Browsing the internet for "JFFS2 mtd" results in tutorials, articles
> >> and github.gists0 that point to mtdblock.
> >> 
> >> In fact, even the MTD wiki mentions that JFFS2
> >> needs mtdblock to mount a rootfs:
> >> 
> >>   http://www.linux-mtd.infradead.org/faq/jffs2.html
> >> 
> >> Moreover, I suspect there may be lots of users
> >> that still believe mtdblock is somehow needed to
> >> mount SquashFS.
> >> 
> >> I've taken a verbose route and added a pr_warn
> >> warning if the devices are NAND. I don't think using
> >> NAND without UBI is too wise, and given the amount
> >> of outdated tutorials I believe some advertising
> >> will help.
> > 
> > Not all NAND partitions on a device will contain linux root filesystems. For a
> > linux root filesystem perhaps using UBI/UBIFS is preferred, yet these messages
> > print out for each and every NAND partition:
> > 
> >	[    0.900827] Creating 8 MTD partitions on "nxp_lpc3220_slc":
> >	[    0.906431] 0x000000000000-0x000000020000 : "bootrom"
> >	[    0.913523] mtdblock: MTD device 'bootrom' is NAND, please consider using UBI
> >	block devices instead.
> >	[    0.933334] 0x000000020000-0x000000080000 : "uboot"
> >	[    0.940439] mtdblock: MTD device 'uboot' is NAND, please consider using UBI
> >	block devices instead.
> >	[    0.963322] 0x000000080000-0x000000440000 : "fbkernel"
> >	[    0.970655] mtdblock: MTD device 'fbkernel' is NAND, please consider using
> >	UBI block devices instead.
> >	[    0.993361] 0x000000440000-0x000000920000 : "fbrootfs"
> >	[    1.000725] mtdblock: MTD device 'fbrootfs' is NAND, please consider using
> >	UBI block devices instead.
> >	[    1.023315] 0x000000920000-0x000000ce0000 : "c_kernel"
> >	[    1.030722] mtdblock: MTD device 'c_kernel' is NAND, please consider using
> >	UBI block devices instead.
> >	[    1.053444] 0x000000ce0000-0x000000d00000 : "c__atags"
> >	[    1.060742] mtdblock: MTD device 'c__atags' is NAND, please consider using
> >	UBI block devices instead.
> >	[    1.083349] 0x000000d00000-0x000001000000 : "c_rootfs"
> >	[    1.090702] mtdblock: MTD device 'c_rootfs' is NAND, please consider using
> >	UBI block devices instead.
> >	[    1.113335] 0x000001000000-0x000020000000 : "mender"
> >	[    1.131627] mtdblock: MTD device 'mender' is NAND, please consider using UBI
> >	block devices instead.
> > 
> > NAND tends to be something found on older devices, the firmware/bootloaders
> > of older devices couldn't possibly understand UBI/UBIFS so many of these
> > partitions need be "raw" partitions, or use something that predates UBI.
> > 
> > Ironically my "mender" partition contains a UBI (with multiple UBIFSes inside)
> > yet I got the same "please use UBI" message as all the others (lol)
> > 
> > I'm specifying my partitions in DT with:
> > 
> > partitions {
> >        compatible = "fixed-partitions";
> >        #address-cells = <1>;
> >        #size-cells = <1>;
> > 
> >        mtd0@0       { label = "bootrom";   reg = <0x00000000 0x00020000>; };
> >        mtd1@20000   { label = "uboot";     reg = <0x00020000 0x00060000>; };
> >        mtd2@80000   { label = "fbkernel";  reg = <0x00080000 0x003c0000>; };
> >        mtd3@440000  { label = "fbrootfs";  reg = <0x00440000 0x004e0000>; };
> >        mtd4@920000  { label = "c_kernel";  reg = <0x00920000 0x003c0000>; };
> >        mtd5@ce0000  { label = "c__atags";  reg = <0x00ce0000 0x00020000>; };
> >        mtd6@d00000  { label = "c_rootfs";  reg = <0x00d00000 0x00300000>; };
> >        mtd7@1000000 { label = "mender";    reg = <0x01000000 0x1f000000>; };
> > };
> > 
> > which is why, I assume, I'm getting these messages. Is there a UBI-friendly
> > way to define them to avoid these messages?
> 
> Hmm, maybe it makes sense to advertise it only once and not for each mtdblock device.

Are there known bugs or issues using ubi/jffs2/squashfs on top of mtdblock? Is
mtdblock being deprecated? If so I could certainly understand warning users of
the situation.

Is there a safe/easy way to update an older device in a way that wipes
the entire flash while running from flash? If not then having the kernel
perpetually advertising that I'm not using my flash a certain way isn't very
useful, especially if there aren't any underlying reasons why my usage isn't
valid.
