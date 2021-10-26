Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF0E43BA19
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhJZTEH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Oct 2021 15:04:07 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:58456 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238481AbhJZTEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:04:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3046361EAE61;
        Tue, 26 Oct 2021 21:01:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0Uej2VSHJAXt; Tue, 26 Oct 2021 21:01:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5634F61EAE6D;
        Tue, 26 Oct 2021 21:01:32 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RJhtugjmg9J7; Tue, 26 Oct 2021 21:01:32 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 351E461EAE61;
        Tue, 26 Oct 2021 21:01:32 +0200 (CEST)
Date:   Tue, 26 Oct 2021 21:01:32 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Trevor Woerner <twoerner@gmail.com>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <876982414.38679.1635274892099.JavaMail.zimbra@nod.at>
In-Reply-To: <20211026150350.GA5136@localhost>
References: <20210801234509.18774-1-ezequiel@collabora.com> <20211026150350.GA5136@localhost>
Subject: Re: [PATCH 0/3] mtdblock: Advertise about UBI and UBI block
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF93 (Linux)/8.8.12_GA_3809)
Thread-Topic: mtdblock: Advertise about UBI and UBI block
Thread-Index: ygsGgewhiNEi2q8Y/RdrIOGb8OTitg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trevor,

----- Ursprüngliche Mail -----
> Von: "Trevor Woerner" <twoerner@gmail.com>
> An: "Ezequiel Garcia" <ezequiel@collabora.com>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "richard"
> <richard@nod.at>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>
> Gesendet: Dienstag, 26. Oktober 2021 17:03:50
> Betreff: Re: [PATCH 0/3] mtdblock: Advertise about UBI and UBI block

> On Sun 2021-08-01 @ 08:45:02 PM, Ezequiel Garcia wrote:
>> Hi Richard, and everyone else:
>> 
>> Browsing the internet for "JFFS2 mtd" results in tutorials, articles
>> and github.gists0 that point to mtdblock.
>> 
>> In fact, even the MTD wiki mentions that JFFS2
>> needs mtdblock to mount a rootfs:
>> 
>>   http://www.linux-mtd.infradead.org/faq/jffs2.html
>> 
>> Moreover, I suspect there may be lots of users
>> that still believe mtdblock is somehow needed to
>> mount SquashFS.
>> 
>> I've taken a verbose route and added a pr_warn
>> warning if the devices are NAND. I don't think using
>> NAND without UBI is too wise, and given the amount
>> of outdated tutorials I believe some advertising
>> will help.
> 
> Not all NAND partitions on a device will contain linux root filesystems. For a
> linux root filesystem perhaps using UBI/UBIFS is preferred, yet these messages
> print out for each and every NAND partition:
> 
>	[    0.900827] Creating 8 MTD partitions on "nxp_lpc3220_slc":
>	[    0.906431] 0x000000000000-0x000000020000 : "bootrom"
>	[    0.913523] mtdblock: MTD device 'bootrom' is NAND, please consider using UBI
>	block devices instead.
>	[    0.933334] 0x000000020000-0x000000080000 : "uboot"
>	[    0.940439] mtdblock: MTD device 'uboot' is NAND, please consider using UBI
>	block devices instead.
>	[    0.963322] 0x000000080000-0x000000440000 : "fbkernel"
>	[    0.970655] mtdblock: MTD device 'fbkernel' is NAND, please consider using
>	UBI block devices instead.
>	[    0.993361] 0x000000440000-0x000000920000 : "fbrootfs"
>	[    1.000725] mtdblock: MTD device 'fbrootfs' is NAND, please consider using
>	UBI block devices instead.
>	[    1.023315] 0x000000920000-0x000000ce0000 : "c_kernel"
>	[    1.030722] mtdblock: MTD device 'c_kernel' is NAND, please consider using
>	UBI block devices instead.
>	[    1.053444] 0x000000ce0000-0x000000d00000 : "c__atags"
>	[    1.060742] mtdblock: MTD device 'c__atags' is NAND, please consider using
>	UBI block devices instead.
>	[    1.083349] 0x000000d00000-0x000001000000 : "c_rootfs"
>	[    1.090702] mtdblock: MTD device 'c_rootfs' is NAND, please consider using
>	UBI block devices instead.
>	[    1.113335] 0x000001000000-0x000020000000 : "mender"
>	[    1.131627] mtdblock: MTD device 'mender' is NAND, please consider using UBI
>	block devices instead.
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
>        compatible = "fixed-partitions";
>        #address-cells = <1>;
>        #size-cells = <1>;
> 
>        mtd0@0       { label = "bootrom";   reg = <0x00000000 0x00020000>; };
>        mtd1@20000   { label = "uboot";     reg = <0x00020000 0x00060000>; };
>        mtd2@80000   { label = "fbkernel";  reg = <0x00080000 0x003c0000>; };
>        mtd3@440000  { label = "fbrootfs";  reg = <0x00440000 0x004e0000>; };
>        mtd4@920000  { label = "c_kernel";  reg = <0x00920000 0x003c0000>; };
>        mtd5@ce0000  { label = "c__atags";  reg = <0x00ce0000 0x00020000>; };
>        mtd6@d00000  { label = "c_rootfs";  reg = <0x00d00000 0x00300000>; };
>        mtd7@1000000 { label = "mender";    reg = <0x01000000 0x1f000000>; };
> };
> 
> which is why, I assume, I'm getting these messages. Is there a UBI-friendly
> way to define them to avoid these messages?

Hmm, maybe it makes sense to advertise it only once and not for each mtdblock device.

Thanks,
//richard
