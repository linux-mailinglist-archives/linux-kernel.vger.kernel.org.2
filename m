Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E66D44E800
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhKLN5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 08:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhKLN5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:57:41 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7FDC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:54:49 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c8so37667496ede.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFbOW47p++5Cp7MSuv9aXwO4crIHKcrlkESq3jT8ocg=;
        b=Ur8+BeDCD+UMR8C8nKTwJEK15dxhz2iLjUphXEkjzZztJ6qPmHvwI70j32vyEM8lKi
         f6YfuZLkoGDclsn1UGjXTYVwDH47MZT7W6QAt2umrbdrhXunB3/eBjrX7hDBJFKdx+m0
         W4RBBbsRTJASpIDX65wR32iTHH0n09Sf6Exbi18kVWP8a93dnYDEYulI5mt8AEjA6C0/
         6aNOimPnL6NUpe4G8fHKuNWWs++GXjJoolIoUwMOYmZ5WEClrEE6Hcmaiww/pkcQ1mKO
         MLzZTZbuzE1UlRQcYGY/gV1EK5sYDADmKX1lI/IBrnfMfs/Z3VDMzDYUTH3hmJQ1V+nd
         fDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFbOW47p++5Cp7MSuv9aXwO4crIHKcrlkESq3jT8ocg=;
        b=ikQnfC7LQ7xTbWorkncv+otWPMDr2Loh5Ntlc4HhwmtaXHWc1Ud15DMVNT4aMGVaWt
         JusroV5ogCvok9C4lL2YBqkxeaom2bTZ2vwhper69NJ+HqsW85oFGE9LA7iWoXcbCysM
         aIMu2paLasSEwO+0vZrGpyZ8eJH+OPZrKg2nq8sauO1BgNVL2vLbQV0ATubAhf3AAYku
         XoXGQrVAJA7G4xVt6Zgp/tNCRY8SkmgnMcghDtPi3pAedDF3yF2A5LSL1rBQMX9WVGvn
         gJqzGf1EjgzDGQ5VlIF2rkI2o6ayUfXFktfsMfhzH5WKtC0pbXYZmOj2LsnjnEjrE9HK
         JGpQ==
X-Gm-Message-State: AOAM531SCAmLR9649z+ew07LO8cBDcZ/olNfBCogKibb67YhNGZGnUo4
        YwcrppxdYNxH3AWDgAzph1lnC1mCuudRLHtigTCTwA==
X-Google-Smtp-Source: ABdhPJzaqmsZEbM3GUit9fpvX2daP0NAhbrhk9sbziTXHiAWVmKZ+Cpzej44QCqyqBaTr7O7zaBkFNJyKFPxLr9tL7A=
X-Received: by 2002:a17:907:3f9d:: with SMTP id hr29mr19337115ejc.369.1636725287586;
 Fri, 12 Nov 2021 05:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20210801234509.18774-1-ezequiel@collabora.com> <20211026150350.GA5136@localhost>
In-Reply-To: <20211026150350.GA5136@localhost>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 12 Nov 2021 10:54:36 -0300
Message-ID: <CAAEAJfD0ctKon7onbj5cCgN9OUnXpQ-gxG=DF6hXD9hW+Pw83A@mail.gmail.com>
Subject: Re: [PATCH 0/3] mtdblock: Advertise about UBI and UBI block
To:     Trevor Woerner <twoerner@gmail.com>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trevor,

I am not reachable at ezequiel at collabora.com, so I missed this
thread. Sorry about the delay, replying.

On Tue, 26 Oct 2021 at 12:05, Trevor Woerner <twoerner@gmail.com> wrote:
>
> On Sun 2021-08-01 @ 08:45:02 PM, Ezequiel Garcia wrote:
> > Hi Richard, and everyone else:
> >
> > Browsing the internet for "JFFS2 mtd" results in tutorials, articles
> > and github.gists0 that point to mtdblock.
> >
> > In fact, even the MTD wiki mentions that JFFS2
> > needs mtdblock to mount a rootfs:
> >
> >   http://www.linux-mtd.infradead.org/faq/jffs2.html
> >
> > Moreover, I suspect there may be lots of users
> > that still believe mtdblock is somehow needed to
> > mount SquashFS.
> >
> > I've taken a verbose route and added a pr_warn
> > warning if the devices are NAND. I don't think using
> > NAND without UBI is too wise, and given the amount
> > of outdated tutorials I believe some advertising
> > will help.
>
> Not all NAND partitions on a device will contain linux root filesystems. For a
> linux root filesystem perhaps using UBI/UBIFS is preferred, yet these messages
> print out for each and every NAND partition:
>
>         [    0.900827] Creating 8 MTD partitions on "nxp_lpc3220_slc":
>         [    0.906431] 0x000000000000-0x000000020000 : "bootrom"
>         [    0.913523] mtdblock: MTD device 'bootrom' is NAND, please consider using UBI block devices instead.
>         [    0.933334] 0x000000020000-0x000000080000 : "uboot"
>         [    0.940439] mtdblock: MTD device 'uboot' is NAND, please consider using UBI block devices instead.
>         [    0.963322] 0x000000080000-0x000000440000 : "fbkernel"
>         [    0.970655] mtdblock: MTD device 'fbkernel' is NAND, please consider using UBI block devices instead.
>         [    0.993361] 0x000000440000-0x000000920000 : "fbrootfs"
>         [    1.000725] mtdblock: MTD device 'fbrootfs' is NAND, please consider using UBI block devices instead.
>         [    1.023315] 0x000000920000-0x000000ce0000 : "c_kernel"
>         [    1.030722] mtdblock: MTD device 'c_kernel' is NAND, please consider using UBI block devices instead.
>         [    1.053444] 0x000000ce0000-0x000000d00000 : "c__atags"
>         [    1.060742] mtdblock: MTD device 'c__atags' is NAND, please consider using UBI block devices instead.
>         [    1.083349] 0x000000d00000-0x000001000000 : "c_rootfs"
>         [    1.090702] mtdblock: MTD device 'c_rootfs' is NAND, please consider using UBI block devices instead.
>         [    1.113335] 0x000001000000-0x000020000000 : "mender"
>         [    1.131627] mtdblock: MTD device 'mender' is NAND, please consider using UBI block devices instead.
>
> NAND tends to be something found on older devices, the firmware/bootloaders
> of older devices couldn't possibly understand UBI/UBIFS so many of these
> partitions need be "raw" partitions, or use something that predates UBI.
>
> Ironically my "mender" partition contains a UBI (with multiple UBIFSes inside)
> yet I got the same "please use UBI" message as all the others (lol)
>
> I'm specifying my partitions in DT with:
>
> partitions {
>         compatible = "fixed-partitions";
>         #address-cells = <1>;
>         #size-cells = <1>;
>
>         mtd0@0       { label = "bootrom";   reg = <0x00000000 0x00020000>; };
>         mtd1@20000   { label = "uboot";     reg = <0x00020000 0x00060000>; };
>         mtd2@80000   { label = "fbkernel";  reg = <0x00080000 0x003c0000>; };
>         mtd3@440000  { label = "fbrootfs";  reg = <0x00440000 0x004e0000>; };
>         mtd4@920000  { label = "c_kernel";  reg = <0x00920000 0x003c0000>; };
>         mtd5@ce0000  { label = "c__atags";  reg = <0x00ce0000 0x00020000>; };
>         mtd6@d00000  { label = "c_rootfs";  reg = <0x00d00000 0x00300000>; };
>         mtd7@1000000 { label = "mender";    reg = <0x01000000 0x1f000000>; };
> };
>
> which is why, I assume, I'm getting these messages. Is there a UBI-friendly
> way to define them to avoid these messages?
>

I feel the messages are actually helping you. You should not have mtdblock
on any of these MTD devices, if I understood correctly, since you are not
mounting a filesystem on any of them.

Just disable MTDBLOCK on your build and you will be good to go.

I am inclined to just leave the warnings, although they look spammy,
precisely to help catch this mis-setups.

Thanks,
Ezequiel
