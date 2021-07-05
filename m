Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EED3BB61F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 06:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhGEEZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 00:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhGEEZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 00:25:15 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B19C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 21:22:38 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so4965502otp.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 21:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kfRAzBSP4/7qnCPncWqYbFEeRhV7ReeLUsJD8sApSPM=;
        b=czFD6A+UDeWWvtfkEWb0Cjhdx7+xilCpLzApy/QbKQ2I5lIRTkF3vfMGisD6wmnllI
         7niuDIg1fiPpCnZTpP4rF+NSGHu+dZRNcX2CN8tb76iGyKlwjxitT3GGGMOBLsJ54Xye
         rbdQVC6HjMC7ZzbINxdB40yk9q7O4uWEpINgkqd++qw1i7nxksIeKJo1RNF9ssP5hhcT
         y079+KqWS8H1H+k2/7O3XFpajil9CVRIM0CLkfg51M8BHVf3YAtpqasf7uVINPa8SvSB
         xar/GK8KYefhZg/VjHwqf657PU0qiBk/AteXSKS6b34npI8Cp6nSh57cwLcFq+uxRURv
         ATOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kfRAzBSP4/7qnCPncWqYbFEeRhV7ReeLUsJD8sApSPM=;
        b=mL639FGstuW+eBx0U4pUALx//PU6CjolnK5gobeVyDegeGNeYjXooKZ/TjgP09yalh
         cncMKHXiEtMA7UwB+G+0IJ8DmuCUNRYrV/k2dipIa5kvYvDzSrNYzLuvytMifke9S/7x
         eL3/8e787RVJkRxt7fiBxdSA7UB/JT9hqFTwFY3sbNogkZWnIRYWLZHdIUoGo7qMO8Mm
         PYZ8ED7QsmG/ddL+bggOdgPzXilggRHwnAN0be+5Rrxo6zHz3steUkvO02/kVD1/ht14
         vp1oNQ4G8G5CsRsXpBHD+7N5zgmJjQTDNGpEXIMnIXjz/L0PDdqBRHxM0ms/K2kxTcf9
         GX6A==
X-Gm-Message-State: AOAM533QkfHevgh5vcGY6+lIMlRSi43G/uzqdgPw8NmY/pLE+cNx103c
        AOtcyVeE2yxtKzSewC6ue58=
X-Google-Smtp-Source: ABdhPJxKSHqoZ1rAMZZoQiZuvgWWJAmVo1on8xhqASv17f9mNExuPvmr3nJQRoiGk5r8OP3HVC7KdA==
X-Received: by 2002:a9d:4e03:: with SMTP id p3mr9070283otf.214.1625458958090;
        Sun, 04 Jul 2021 21:22:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i133sm2496183oia.2.2021.07.04.21.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 21:22:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 4 Jul 2021 21:22:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 4/4] arm: extend pfn_valid to take into account freed
 memory map alignment
Message-ID: <20210705042236.GA1463419@roeck-us.net>
References: <20210630071211.21011-1-rppt@kernel.org>
 <20210630071211.21011-5-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630071211.21011-5-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 10:12:11AM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> When unused memory map is freed the preserved part of the memory map is
> extended to match pageblock boundaries because lots of core mm
> functionality relies on homogeneity of the memory map within pageblock
> boundaries.
> 
> Since pfn_valid() is used to check whether there is a valid memory map
> entry for a PFN, make it return true also for PFNs that have memory map
> entries even if there is no actual memory populated there.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>

With this patch in place, the romulus-bmc emulation in qemu gets the
following traceback:

[    2.863406] WARNING: CPU: 0 PID: 1 at arch/arm/mm/ioremap.c:287 __arm_ioremap_pfn_caller+0xf0/0x1dc
[    2.864812] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-09882-ga180bd1d7e16 #1
[    2.865263] Hardware name: Generic DT based system
[    2.865711] Backtrace: 
[    2.866063] [<80b07e58>] (dump_backtrace) from [<80b080ac>] (show_stack+0x20/0x24)
[    2.866633]  r7:00000009 r6:0000011f r5:60000153 r4:80ddd1c0
[    2.866922] [<80b0808c>] (show_stack) from [<80b18df0>] (dump_stack_lvl+0x58/0x74)
[    2.867117] [<80b18d98>] (dump_stack_lvl) from [<80b18e20>] (dump_stack+0x14/0x1c)
[    2.867309]  r5:80118cac r4:80dc6774
[    2.867404] [<80b18e0c>] (dump_stack) from [<80122fcc>] (__warn+0xe4/0x150)
[    2.867583] [<80122ee8>] (__warn) from [<80b08850>] (warn_slowpath_fmt+0x88/0xc0)
[    2.867774]  r7:0000011f r6:80dc6774 r5:00000000 r4:814c4000
[    2.867917] [<80b087cc>] (warn_slowpath_fmt) from [<80118cac>] (__arm_ioremap_pfn_caller+0xf0/0x1dc)
[    2.868158]  r9:00000001 r8:9ef00000 r7:80e8b0d4 r6:0009ef00 r5:00000000 r4:00100000
[    2.868346] [<80118bbc>] (__arm_ioremap_pfn_caller) from [<80118df8>] (__arm_ioremap_caller+0x60/0x68)
[    2.868581]  r9:9ef00000 r8:821b6dc0 r7:00100000 r6:00000000 r5:815d1010 r4:80118d98
[    2.868761] [<80118d98>] (__arm_ioremap_caller) from [<80118fcc>] (ioremap+0x28/0x30)
[    2.868958] [<80118fa4>] (ioremap) from [<8062871c>] (__devm_ioremap_resource+0x154/0x1c8)
[    2.869169]  r5:815d1010 r4:814c5d2c
[    2.869263] [<806285c8>] (__devm_ioremap_resource) from [<8062899c>] (devm_ioremap_resource+0x14/0x18)
[    2.869495]  r9:9e9f57a0 r8:814c4000 r7:815d1000 r6:815d1010 r5:8177c078 r4:815cf400
[    2.869676] [<80628988>] (devm_ioremap_resource) from [<8091c6e4>] (fsi_master_acf_probe+0x1a8/0x5d8)
[    2.869909] [<8091c53c>] (fsi_master_acf_probe) from [<80723dbc>] (platform_probe+0x68/0xc8)
[    2.870124]  r9:80e9dadc r8:00000000 r7:815d1010 r6:810c1000 r5:815d1010 r4:00000000
[    2.870306] [<80723d54>] (platform_probe) from [<80721208>] (really_probe+0x1cc/0x470)
[    2.870512]  r7:815d1010 r6:810c1000 r5:00000000 r4:815d1010
[    2.870651] [<8072103c>] (really_probe) from [<807215cc>] (__driver_probe_device+0x120/0x1fc)
[    2.870872]  r7:815d1010 r6:810c1000 r5:810c1000 r4:815d1010
[    2.871013] [<807214ac>] (__driver_probe_device) from [<807216e8>] (driver_probe_device+0x40/0xd8)
[    2.871244]  r9:80e9dadc r8:00000000 r7:815d1010 r6:810c1000 r5:812feaa0 r4:812fe994
[    2.871428] [<807216a8>] (driver_probe_device) from [<80721a58>] (__driver_attach+0xa8/0x1d4)
[    2.871647]  r9:80e9dadc r8:00000000 r7:00000000 r6:810c1000 r5:815d1054 r4:815d1010
[    2.871830] [<807219b0>] (__driver_attach) from [<8071ee8c>] (bus_for_each_dev+0x88/0xc8)
[    2.872040]  r7:00000000 r6:814c4000 r5:807219b0 r4:810c1000
[    2.872194] [<8071ee04>] (bus_for_each_dev) from [<80722208>] (driver_attach+0x28/0x30)
[    2.872418]  r7:810a2aa0 r6:00000000 r5:821b6000 r4:810c1000
[    2.872570] [<807221e0>] (driver_attach) from [<8071f80c>] (bus_add_driver+0x114/0x200)
[    2.872788] [<8071f6f8>] (bus_add_driver) from [<80722ec4>] (driver_register+0x98/0x128)
[    2.873011]  r7:81011d0c r6:814c4000 r5:00000000 r4:810c1000
[    2.873167] [<80722e2c>] (driver_register) from [<80725240>] (__platform_driver_register+0x2c/0x34)
[    2.873408]  r5:814dcb80 r4:80f2a764
[    2.873513] [<80725214>] (__platform_driver_register) from [<80f2a784>] (fsi_master_acf_init+0x20/0x28)
[    2.873766] [<80f2a764>] (fsi_master_acf_init) from [<80f014a8>] (do_one_initcall+0x108/0x290)
[    2.874007] [<80f013a0>] (do_one_initcall) from [<80f01840>] (kernel_init_freeable+0x1ac/0x230)
[    2.874248]  r9:80e9dadc r8:80f3987c r7:80f3985c r6:00000007 r5:814dcb80 r4:80f627a4
[    2.874456] [<80f01694>] (kernel_init_freeable) from [<80b19f44>] (kernel_init+0x20/0x138)
[    2.874691]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:80b19f24
[    2.874894]  r4:00000000
[    2.874977] [<80b19f24>] (kernel_init) from [<80100170>] (ret_from_fork+0x14/0x24)
[    2.875231] Exception stack(0x814c5fb0 to 0x814c5ff8)
[    2.875535] 5fa0:                                     00000000 00000000 00000000 00000000
[    2.875849] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.876133] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.876363]  r5:80b19f24 r4:00000000
[    2.876683] ---[ end trace b2f74b8536829970 ]---
[    2.876911] fsi-master-acf gpio-fsi: ioremap failed for resource [mem 0x9ef00000-0x9effffff]
[    2.877492] fsi-master-acf gpio-fsi: Error -12 mapping coldfire memory
[    2.877689] fsi-master-acf: probe of gpio-fsi failed with error -12

Reverting it fixes the problem. Also, the ioremap failure is no longer seen
after reverting this patch.

Guenter

---
bisect log:

# bad: [a180bd1d7e16173d965b263c5a536aa40afa2a2a] iov_iter: remove uaccess_kernel() warning from iov_iter_init()
# good: [303392fd5c160822bf778270b28ec5ea50cab2b4] Merge tag 'leds-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds
git bisect start 'HEAD' '303392fd5c16'
# good: [2bb919b62f6e5959552a90a399d09d683afa3d1d] Merge tag 's390-5.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect good 2bb919b62f6e5959552a90a399d09d683afa3d1d
# good: [5390473ec1697b71af0e9d63ef7aaa7ecd27e2c9] rcu: Don't penalize priority boosting when there is nothing to boost
git bisect good 5390473ec1697b71af0e9d63ef7aaa7ecd27e2c9
# good: [641faf1b9064c270a476a424e60063bb05df3ee9] Merge branches 'bitmaprange.2021.05.10c', 'doc.2021.05.10c', 'fixes.2021.05.13a', 'kvfree_rcu.2021.05.10c', 'mmdumpobj.2021.05.10c', 'nocb.2021.05.12a', 'srcu.2021.05.12a', 'tasks.2021.05.18a' and 'torture.2021.05.10c' into HEAD
git bisect good 641faf1b9064c270a476a424e60063bb05df3ee9
# good: [b930226f3db870cfb683c2744aeb0d29deb4cddc] kcsan: Document "value changed" line
git bisect good b930226f3db870cfb683c2744aeb0d29deb4cddc
# bad: [a412897fb546fbb291095be576165ce757eff70b] Merge tag 'memblock-v5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
git bisect bad a412897fb546fbb291095be576165ce757eff70b
# good: [f921f53e089a12a192808ac4319f28727b35dc0f] memblock: align freed memory map on pageblock boundaries with SPARSEMEM
git bisect good f921f53e089a12a192808ac4319f28727b35dc0f
# bad: [a4d5613c4dc6d413e0733e37db9d116a2a36b9f3] arm: extend pfn_valid to take into account freed memory map alignment
git bisect bad a4d5613c4dc6d413e0733e37db9d116a2a36b9f3
# good: [023accf5cdc1e504a9b04187ec23ff156fe53d90] memblock: ensure there is no overflow in memblock_overlaps_region()
git bisect good 023accf5cdc1e504a9b04187ec23ff156fe53d90
# first bad commit: [a4d5613c4dc6d413e0733e37db9d116a2a36b9f3] arm: extend pfn_valid to take into account freed memory map alignment
