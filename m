Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3333A9B51
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhFPNBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhFPNBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:01:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C794AC061574;
        Wed, 16 Jun 2021 05:59:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so4077231wmq.1;
        Wed, 16 Jun 2021 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=l/oMsFxIFv+rrDp5gXOVJ8GhAlzw+ukQx0tghH/ohds=;
        b=Jw8v/duCg2WpLuNJavbMLDd7QWEQcAC4ie8R1wE6kJlyEn29GTCH2UTur/NJfT1kPr
         JdG/qpQ/3YhxmmTUSdacH/9A624whdt12F4jJusU8Q0aYOfIgEwtQr0gXRgBR4GLlurO
         G6WkDlfMNkMERFTNHl90J8ugp5tZzPJFSzRZWxKWGS4Sh2ZL4sCnZN7BT+Gz57vcO++5
         vuvedycewcukCK5KBopFGAlVKICKav9dOY0g34a6H1Qnuu76SbF/GYJE0rbI0wg7tCeB
         3EtB2SR/Yuk+HuuuFNZDtB1Q0TXLxtZiG+uXrRmatGM0SIht/fqBHbSCFn+2B0HW6ZgB
         7S8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=l/oMsFxIFv+rrDp5gXOVJ8GhAlzw+ukQx0tghH/ohds=;
        b=QvzgDa1Y/fIRtD/55eeD6Awno57FRhsYKd8ti6VePxZMmFcOFoPdgvLq0PV4hw+rfn
         8t7EuUPwSO0iDjpBfQ17ytwfd3BNSUMrX1hj3FJ3hBisKEZJAVhqQU5bVKpo0WENaVzn
         Cx5RpIGemv6IKPJpADvWad2HylHSz5W3fnxRsmUyDML0bGVQN1aO827SZs7zssVZbjX4
         ZMqaSZg+4rc/GbICIT64fVqcsGS2IRsRZ3NrpzRxNmkhP64BKWSBGCy31PyC6jsf2kKF
         vspZ5v4BDaCX3hK+rcwhshHgZURD5rsKaVPWSxXOrqT9q/lfxuwfOOC3xMdBD6PaimTU
         BWxg==
X-Gm-Message-State: AOAM531QzHE2hmY+iBbzbmPXGtYW6BRImHb4spUv+fCPCHQiOPAEbB0u
        vlfiV8wBTo86B9hXwLkHKQo=
X-Google-Smtp-Source: ABdhPJwJrXoS3NM7sWYc1X9KPPYdazEqcvsVgUamQyY88Xd3Tb8w2bOVMNeCwSkpfeUsrQFDt+lh+w==
X-Received: by 2002:a05:600c:1908:: with SMTP id j8mr11333648wmq.86.1623848344462;
        Wed, 16 Jun 2021 05:59:04 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id q20sm2682074wrf.45.2021.06.16.05.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 05:59:04 -0700 (PDT)
Date:   Wed, 16 Jun 2021 14:59:02 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-block@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel panic when scanning MTD partitions
Message-ID: <YMn1lhq4Sl9ipY9a@Red>
References: <YMntfiE7J8r0dtV1@Red>
 <1424d9da-5e11-3ba8-82ae-85f95f60ca9d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1424d9da-5e11-3ba8-82ae-85f95f60ca9d@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Jun 16, 2021 at 06:54:41AM -0600, Jens Axboe a �crit :
> On 6/16/21 6:24 AM, Corentin Labbe wrote:
> > Hello
> > 
> > When scanning MTD partitions my kernel panic:
> > Searching for RedBoot partition table in 30000000.flash at offset 0xfe0000
> > 7 RedBoot partitions found on MTD device 30000000.flash
> > Creating 7 MTD partitions on "30000000.flash":
> > 0x000000000000-0x000000020000 : "BOOT"
> > 8<--- cut here ---
> > Unable to handle kernel NULL pointer dereference at virtual address 00000034
> > pgd = (ptrval)
> > [00000034] *pgd=00000000
> > Internal error: Oops: 17 [#1] PREEMPT ARM
> > Modules linked in:
> > CPU: 0 PID: 1 Comm: swapper Not tainted 5.13.0-rc6-next-20210615+ #101
> > Hardware name: Gemini (Device Tree)
> > PC is at _set_bit+0x20/0x4c
> > LR is at blk_queue_write_cache+0x20/0x5c
> > pc : [<c02f2194>]    lr : [<c029d6c0>]    psr: 60000093
> > sp : c1439ca0  ip : 60000013  fp : c4058c00
> > r10: 00000000  r9 : c4058ab8  r8 : c1c553b8
> > r7 : c3f71080  r6 : 00000000  r5 : 00000000  r4 : 00000000
> > r3 : 00020000  r2 : 00000011  r1 : 00000034  r0 : 00000000
> > Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > Control: 0000397f  Table: 02338000  DAC: 00000053
> > Register r0 information: NULL pointer
> > Register r1 information: non-paged memory
> > Register r2 information: non-paged memory
> > Register r3 information: non-paged memory
> > Register r4 information: NULL pointer
> > Register r5 information: NULL pointer
> > Register r6 information: NULL pointer
> > Register r7 information: slab kmalloc-128 start c3f71080 pointer offset 0 size 128
> > Register r8 information: slab dentry start c1c553b8 pointer offset 0 size 40
> > Register r9 information: slab kmalloc-1k start c4058800 pointer offset 696 size 1024
> > Register r10 information: NULL pointer
> > Register r11 information: slab kmalloc-1k start c4058c00 pointer offset 0 size 1024
> > Register r12 information: non-paged memory
> > Process swapper (pid: 1, stack limit = 0x(ptrval))
> > Stack: (0xc1439ca0 to 0xc143a000)
> > 9ca0: c231a480 c07ab67c 00000000 c03cd1b8 00000000 c00f4b18 c07ab67c c231a480
> > 9cc0: c4058c00 c07ab67c 05a00000 c03ce474 c07ab67c c4058c00 c07ab658 c03ccf88
> > 9ce0: c4058c00 c07ab660 c07ab434 c03c7328 c068ab50 00000000 c4058cf8 c40912c0
> > 9d00: ffffffff 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 9d20: 00000101 00000000 00000001 c03c6ba8 00000000 00020000 00000001 00000001
> > 9d40: c4058c00 00000000 00000000 4af56ea3 00000000 c4058800 c4058800 c406f000
> > 9d60: 00000007 c03ca0fc 00000000 00000000 00000007 c07ab638 c05c6c84 00000000
> > 9d80: 00000007 c4058800 c1438000 00000000 00000000 c03c9f90 00000001 c05c6c88
> > 9da0: 00000000 00000000 c406f000 00000007 c07ab638 4af56ea3 00002201 c4058800
> > 9dc0: c05c6c84 00000000 00000000 c221c2a0 c2215810 00000000 00000000 c03c7694
> > 9de0: 00000001 c4009c20 c4008500 c2215800 c221c2a0 c03dc4a0 00000000 c0196864
> > 9e00: 00000000 c4008500 c4052b58 00000000 00000002 4af56ea3 00000000 00000000
> > 9e20: c2215810 c07ab928 00000000 c07ab928 00000000 c07bb000 c06f73e0 c037b898
> > 9e40: c2215810 c0815554 00000000 00000000 c07ab928 c03796fc c2215810 c07ab928
> > 9e60: c2215854 c07ab928 c071c830 c06d408c c07bb000 c0379b4c c2215810 00000000
> > 9e80: c2215854 c037a0ec 00000000 c07ab928 c2215810 c07a9fb0 c071c830 c037a17c
> > 9ea0: 00000000 c07ab928 c037a0f4 c0377584 c143e11c c143e10c c140c530 4af56ea3
> > 9ec0: c07ab928 c4008480 00000000 c0378a68 c068d2f4 c068d2f4 c06f73e0 c07ab928
> > 9ee0: 00000000 00000000 c07bb000 c037a818 c07117f8 ffffe000 00000000 c00097ac
> > 9f00: c1403b00 c1403b08 c1403aff c0035200 00000000 c0694bc0 0000009f 00000000
> > 9f20: 00000000 c06f73e0 00000006 00000006 00000000 c1403b16 c1403b1d 4af56ea3
> > 9f40: 00000000 00000006 0000009f 4af56ea3 c071c84c c0724380 00000007 c1403b00
> > 9f60: c071c850 c06f8108 00000006 00000006 00000000 c06f73e0 00000000 0000009f
> > 9f80: c0558560 00000000 c0558560 00000000 00000000 00000000 00000000 00000000
> > 9fa0: 00000000 c0558570 00000000 c0008348 00000000 00000000 00000000 00000000
> > 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> > [<c02f2194>] (_set_bit) from [<c029d6c0>] (blk_queue_write_cache+0x20/0x5c)
> > [<c029d6c0>] (blk_queue_write_cache) from [<c03cd1b8>] (add_mtd_blktrans_dev+0x218/0x3cc)
> > [<c03cd1b8>] (add_mtd_blktrans_dev) from [<c03ce474>] (mtdblock_add_mtd+0x60/0x78)
> > [<c03ce474>] (mtdblock_add_mtd) from [<c03ccf88>] (blktrans_notify_add+0x3c/0x54)
> > [<c03ccf88>] (blktrans_notify_add) from [<c03c7328>] (add_mtd_device+0x3bc/0x5e8)
> > [<c03c7328>] (add_mtd_device) from [<c03ca0fc>] (add_mtd_partitions+0xc4/0x16c)
> > [<c03ca0fc>] (add_mtd_partitions) from [<c03c9f90>] (parse_mtd_partitions+0x370/0x418)
> > [<c03c9f90>] (parse_mtd_partitions) from [<c03c7694>] (mtd_device_parse_register+0x74/0x2c4)
> > [<c03c7694>] (mtd_device_parse_register) from [<c03dc4a0>] (physmap_flash_probe+0x5e8/0x808)
> > [<c03dc4a0>] (physmap_flash_probe) from [<c037b898>] (platform_probe+0x5c/0xbc)
> > [<c037b898>] (platform_probe) from [<c03796fc>] (really_probe+0xf8/0x4e8)
> > [<c03796fc>] (really_probe) from [<c0379b4c>] (driver_probe_device+0x60/0xb8)
> > [<c0379b4c>] (driver_probe_device) from [<c037a0ec>] (device_driver_attach+0xa8/0xb0)
> > [<c037a0ec>] (device_driver_attach) from [<c037a17c>] (__driver_attach+0x88/0x11c)
> > [<c037a17c>] (__driver_attach) from [<c0377584>] (bus_for_each_dev+0x78/0xc4)
> > [<c0377584>] (bus_for_each_dev) from [<c0378a68>] (bus_add_driver+0xe8/0x1d0)
> > [<c0378a68>] (bus_add_driver) from [<c037a818>] (driver_register+0x88/0x118)
> > [<c037a818>] (driver_register) from [<c00097ac>] (do_one_initcall+0x50/0x1e0)
> > [<c00097ac>] (do_one_initcall) from [<c06f8108>] (kernel_init_freeable+0x178/0x200)
> > [<c06f8108>] (kernel_init_freeable) from [<c0558570>] (kernel_init+0x10/0x100)
> > [<c0558570>] (kernel_init) from [<c0008348>] (ret_from_fork+0x14/0x2c)
> > Exception stack(0xc1439fb0 to 0xc1439ff8)
> > 9fa0:                                     00000000 00000000 00000000 00000000
> > 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > Code: e3a03001 e1a03213 e10fc000 e321f093 (e7912100) 
> > ---[ end trace f3b2f52ba3b0d435 ]---
> > Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> > ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> > 
> > This happen on 5.13.0-rc6-next-20210615+ on my ARM Gemini ssi1328.
> 
> Should be fixed once for-next updates the block branch.
> 

Thanks, do you have a link to the fix ? or patch name.

Regards
