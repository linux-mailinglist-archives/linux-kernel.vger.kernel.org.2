Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4AE43B50C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhJZPHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbhJZPGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:06:18 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C313C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:03:54 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id j6so17332548ila.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tkcVniFj3EsSUAX6m/sspH5z9aXFixUQtCaiI8YxhYY=;
        b=RHirny+FHC/8Luklp3k8E2F00YXu87T539l/j4y4aya8hF2XauBihgUmdxurLi8p+H
         SmMSwaSh2AmP6Uq1GbVUUdhGsBlYlxOECxFclxKPT0Dpvy4RUWKhdikoNyl2e0WPGYc7
         9Kfg1rniBkkq3kdkgzPJoqgi2djnQN/iZFu36+gOkvEy5AV0uChpXXp4yBRX3myYMYbq
         DUkDwCSC3eN57waqyuMC//UWfQZgkaSDv6d1NtVnSlvdSiUEssVim6QCu703i+/YJ89p
         qI4qfhnKW5uNeoktWtHiHMBXMXPLwoQLtSy2kqbx/H5bleS0I4Kd12l5q2rkvpdh4aDr
         WJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tkcVniFj3EsSUAX6m/sspH5z9aXFixUQtCaiI8YxhYY=;
        b=A17V1r7tnQK1QW0si1EoV82wXxc3QGJf3gUTlGdOTBHI3EM64M31jFdddAjduvfLW/
         QiExwrHisaqwCUgWseWY1Nn+C3O4r5AMDj6xCpn3vm4rFzpDjCcpT77mf9yZEW0gUB/R
         HLB60wpXdZEfeAwRMtaJ2V5HbCjD1pyKo7mTx6riM2HZwy6OCGJycELjKsT2cLvM4FLj
         oYOKEGgS3DTXHYprOYTIUT/Bottto1HuREieFKn+NS2z5KzdCOagO7cl0/8kde1sNFhm
         XuMp3YxGV2K3UZwLSXaJBXCe6+VCTjbuAbgbtOukugS0o7e3Rur28un2WSqEfvLwHvWJ
         B62Q==
X-Gm-Message-State: AOAM530JHAlxvG5Ul20TQgev1/mRhiikhgNBUlwpyC6ZuuRA90vLfMNt
        9h6f1usZEprjAIo799Q1xNo=
X-Google-Smtp-Source: ABdhPJyBqNQv71Q9LY5rTbgwLveZJl5ilP9ls3UmlNvE9vSCO8HFJ5UevngO734jaIj3ZdForRhVJg==
X-Received: by 2002:a92:c244:: with SMTP id k4mr8489638ilo.138.1635260633513;
        Tue, 26 Oct 2021 08:03:53 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id k16sm10175244ior.50.2021.10.26.08.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 08:03:52 -0700 (PDT)
Date:   Tue, 26 Oct 2021 11:03:50 -0400
From:   Trevor Woerner <twoerner@gmail.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] mtdblock: Advertise about UBI and UBI block
Message-ID: <20211026150350.GA5136@localhost>
References: <20210801234509.18774-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210801234509.18774-1-ezequiel@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-08-01 @ 08:45:02 PM, Ezequiel Garcia wrote:
> Hi Richard, and everyone else:
> 
> Browsing the internet for "JFFS2 mtd" results in tutorials, articles
> and github.gists0 that point to mtdblock.
> 
> In fact, even the MTD wiki mentions that JFFS2
> needs mtdblock to mount a rootfs:
> 
>   http://www.linux-mtd.infradead.org/faq/jffs2.html
> 
> Moreover, I suspect there may be lots of users
> that still believe mtdblock is somehow needed to
> mount SquashFS.
> 
> I've taken a verbose route and added a pr_warn
> warning if the devices are NAND. I don't think using
> NAND without UBI is too wise, and given the amount
> of outdated tutorials I believe some advertising
> will help.

Not all NAND partitions on a device will contain linux root filesystems. For a
linux root filesystem perhaps using UBI/UBIFS is preferred, yet these messages
print out for each and every NAND partition:

	[    0.900827] Creating 8 MTD partitions on "nxp_lpc3220_slc":
	[    0.906431] 0x000000000000-0x000000020000 : "bootrom"
	[    0.913523] mtdblock: MTD device 'bootrom' is NAND, please consider using UBI block devices instead.
	[    0.933334] 0x000000020000-0x000000080000 : "uboot"
	[    0.940439] mtdblock: MTD device 'uboot' is NAND, please consider using UBI block devices instead.
	[    0.963322] 0x000000080000-0x000000440000 : "fbkernel"
	[    0.970655] mtdblock: MTD device 'fbkernel' is NAND, please consider using UBI block devices instead.
	[    0.993361] 0x000000440000-0x000000920000 : "fbrootfs"
	[    1.000725] mtdblock: MTD device 'fbrootfs' is NAND, please consider using UBI block devices instead.
	[    1.023315] 0x000000920000-0x000000ce0000 : "c_kernel"
	[    1.030722] mtdblock: MTD device 'c_kernel' is NAND, please consider using UBI block devices instead.
	[    1.053444] 0x000000ce0000-0x000000d00000 : "c__atags"
	[    1.060742] mtdblock: MTD device 'c__atags' is NAND, please consider using UBI block devices instead.
	[    1.083349] 0x000000d00000-0x000001000000 : "c_rootfs"
	[    1.090702] mtdblock: MTD device 'c_rootfs' is NAND, please consider using UBI block devices instead.
	[    1.113335] 0x000001000000-0x000020000000 : "mender"
	[    1.131627] mtdblock: MTD device 'mender' is NAND, please consider using UBI block devices instead.

NAND tends to be something found on older devices, the firmware/bootloaders
of older devices couldn't possibly understand UBI/UBIFS so many of these
partitions need be "raw" partitions, or use something that predates UBI.

Ironically my "mender" partition contains a UBI (with multiple UBIFSes inside)
yet I got the same "please use UBI" message as all the others (lol)

I'm specifying my partitions in DT with:

partitions {
        compatible = "fixed-partitions";
        #address-cells = <1>;
        #size-cells = <1>;

        mtd0@0       { label = "bootrom";   reg = <0x00000000 0x00020000>; };
        mtd1@20000   { label = "uboot";     reg = <0x00020000 0x00060000>; };
        mtd2@80000   { label = "fbkernel";  reg = <0x00080000 0x003c0000>; };
        mtd3@440000  { label = "fbrootfs";  reg = <0x00440000 0x004e0000>; };
        mtd4@920000  { label = "c_kernel";  reg = <0x00920000 0x003c0000>; };
        mtd5@ce0000  { label = "c__atags";  reg = <0x00ce0000 0x00020000>; };
        mtd6@d00000  { label = "c_rootfs";  reg = <0x00d00000 0x00300000>; };
        mtd7@1000000 { label = "mender";    reg = <0x01000000 0x1f000000>; };
};

which is why, I assume, I'm getting these messages. Is there a UBI-friendly
way to define them to avoid these messages?

Best regards,
	Trevor
