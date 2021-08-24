Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D643F5F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbhHXNlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237568AbhHXNle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:41:34 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91202C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 06:40:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso1913205wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=WM83eOC6aODiMJf3m8T4eHvsH6CKQKlde1ED7pGGDB0=;
        b=SpNyimnl22BG9jTYMQjLk4887eYjBCYvrLwpD/rW43xYP5opD5HLpAXiCz+WL7sNh/
         dwK8RND9PDQV06k3mxdbJvxa4d6a7klS3mtlmU3dlcBKiJ/QdrbUwbuGBzU2F6TZNtgN
         RAwVWvV3+S+QS63WYlW81cmlDaFgHMGis2sE6GVfwGLLDtRtTg7QvsrzzEPDtOz40Ee1
         /S/vPxIlY1FkDuiIIs8QjxkGap62oM74bzM0lnsVZbDAlZoHcklUWhU0XvojJjt06svS
         02K9D550ikzrptMl3DHn4u/s+yvEV7Un2DoFqRdwtAsZGNv2InrWoYRdeapK3LWkQ4Oy
         MBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=WM83eOC6aODiMJf3m8T4eHvsH6CKQKlde1ED7pGGDB0=;
        b=mMyoMnMfRBvK4QqtEkkNadUmcd6N8bemQAItprAq2Z5uX7V+vPTHq3DCmV/lgVKEmE
         XbJ5y70kFUdBXeaXSU62lRJsygxsPxyaX7vVdSknTxQaTUJPt1LEfuRw+lT2KgT0Myiv
         /VgqWTSa1w5n5MpGbLvrNx/pIyKH1DdaT8zCDXAlysl0qguGF2VDMtZf/bEtHnbFMGEe
         f+M6JQLeBfhj4r08gevNMpYY976iDG2ubi3pFyRMm6wHr6XzdrLnGZpBCX5bTDrVAymK
         azyp05mhJ/rtzyKSRlxg8dfNHRTJdk9s7J4IRXfSO3kQ5ZsWdkevyedUHHVlSX5F2Av0
         81iw==
X-Gm-Message-State: AOAM533WvqMOglz3HfD7gsJe+QPRu48K5f2mjqYDvmg8eCbz/V2GfpVa
        sIErnMo2vr/tcYtyzFZy8aQqvHsxSQ==
X-Google-Smtp-Source: ABdhPJyIDcRyaK/nn0CULlwObzImyM8VRidpal6jvcOzm8xLT3+IVW5K7rvdul2RT37hmhphMATr+Q==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr4145985wmz.93.1629812449159;
        Tue, 24 Aug 2021 06:40:49 -0700 (PDT)
Received: from [192.168.200.23] (ip5b434083.dynamic.kabel-deutschland.de. [91.67.64.131])
        by smtp.gmail.com with ESMTPSA id z126sm2660793wmc.11.2021.08.24.06.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 06:40:48 -0700 (PDT)
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Alex Bee <knaerzche@gmail.com>
Subject: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
Date:   Tue, 24 Aug 2021 15:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list(s),

it seems there is a regression in arm64 memory mapping in 5.14, since it 
fails on Rockchip RK3328 when the pl330 dmac tries to map with:

[    8.921909] ------------[ cut here ]------------
[    8.921940] WARNING: CPU: 2 PID: 373 at kernel/dma/mapping.c:235 
dma_map_resource+0x68/0xc0
[    8.921973] Modules linked in: spi_rockchip(+) fuse
[    8.921996] CPU: 2 PID: 373 Comm: systemd-udevd Not tainted 
5.14.0-rc7 #1
[    8.922004] Hardware name: Pine64 Rock64 (DT)
[    8.922011] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[    8.922018] pc : dma_map_resource+0x68/0xc0
[    8.922026] lr : pl330_prep_slave_fifo+0x78/0xd0
[    8.922040] sp : ffff800012102ae0
[    8.922043] x29: ffff800012102ae0 x28: ffff000005c94800 x27: 
0000000000000000
[    8.922056] x26: ffff000000566bd0 x25: 0000000000000001 x24: 
0000000000000001
[    8.922067] x23: 0000000000000002 x22: ffff000000628c00 x21: 
0000000000000001
[    8.922078] x20: ffff000000566bd0 x19: 0000000000000001 x18: 
0000000000000000
[    8.922089] x17: 0000000000000000 x16: 0000000000000000 x15: 
0000000000000000
[    8.922100] x14: 0000000000000277 x13: 0000000000000001 x12: 
0000000000000000
[    8.922111] x11: 0000000000000001 x10: 00000000000008e0 x9 : 
ffff800012102a80
[    8.922123] x8 : ffff000000d14b80 x7 : ffff0000fe7b12f0 x6 : 
ffff0000fe7b1100
[    8.922134] x5 : fffffc000000000f x4 : 0000000000000000 x3 : 
0000000000000001
[    8.922145] x2 : 0000000000000001 x1 : 00000000ff190800 x0 : 
ffff000000628c00
[    8.922158] Call trace:
[    8.922163]  dma_map_resource+0x68/0xc0
[    8.922173]  pl330_prep_slave_sg+0x58/0x220
[    8.922181]  rockchip_spi_prepare_dma+0xd8/0x2c0 [spi_rockchip]
[    8.922208]  rockchip_spi_transfer_one+0x294/0x3d8 [spi_rockchip]
[    8.922220]  spi_transfer_one_message+0x284/0x57c
[    8.922232]  __spi_pump_messages+0x3dc/0x650
[    8.922240]  __spi_sync+0x3e4/0x48c
[    8.922247]  spi_sync+0x30/0x54
[    8.922253]  spi_mem_exec_op+0x264/0x444
[    8.922260]  spi_nor_spimem_read_data+0x148/0x160
[    8.922269]  spi_nor_read_data+0x30/0x40
[    8.922276]  spi_nor_read_sfdp+0x74/0xe4
[    8.922285]  spi_nor_parse_sfdp+0x1d0/0x1130
[    8.922293]  spi_nor_sfdp_init_params+0x3c/0x90
[    8.922304]  spi_nor_scan+0x7b4/0xacc
[    8.922311]  spi_nor_probe+0x94/0x2d0
[    8.922317]  spi_mem_probe+0x6c/0xb0
[    8.922325]  spi_probe+0x84/0xe4
[    8.922335]  really_probe+0xb4/0x45c
[    8.922349]  __driver_probe_device+0x114/0x190
[    8.922358]  driver_probe_device+0x40/0x100
[    8.922367]  __device_attach_driver+0x98/0x130
[    8.922375]  bus_for_each_drv+0x78/0xd0
[    8.922383]  __device_attach+0xdc/0x1c0
[    8.922391]  device_initial_probe+0x14/0x20
[    8.922400]  bus_probe_device+0x98/0xa0
[    8.922408]  device_add+0x36c/0x8c0
[    8.922416]  __spi_add_device+0x74/0x170
[    8.922423]  spi_add_device+0x64/0xa4
[    8.922429]  of_register_spi_device+0x21c/0x36c
[    8.922436]  spi_register_controller+0x5e0/0x834
[    8.922443]  devm_spi_register_controller+0x24/0x80
[    8.922450]  rockchip_spi_probe+0x434/0x5b0 [spi_rockchip]
[    8.922468]  platform_probe+0x68/0xe0
[    8.922478]  really_probe+0xb4/0x45c
[    8.922487]  __driver_probe_device+0x114/0x190
[    8.922497]  driver_probe_device+0x40/0x100
[    8.922507]  __driver_attach+0xcc/0x1e0
[    8.922516]  bus_for_each_dev+0x70/0xd0
[    8.922524]  driver_attach+0x24/0x30
[    8.922533]  bus_add_driver+0x140/0x234
[    8.922540]  driver_register+0x78/0x130
[    8.922547]  __platform_driver_register+0x28/0x34
[    8.922554]  rockchip_spi_driver_init+0x20/0x1000 [spi_rockchip]
[    8.922566]  do_one_initcall+0x50/0x1b0
[    8.922579]  do_init_module+0x54/0x250
[    8.922589]  load_module+0x2230/0x285c
[    8.922597]  __do_sys_finit_module+0xbc/0x12c
[    8.922605]  __arm64_sys_finit_module+0x24/0x30
[    8.922613]  invoke_syscall+0x48/0x114
[    8.922625]  el0_svc_common+0x40/0xfc
[    8.922632]  do_el0_svc_compat+0x20/0x50
[    8.922640]  el0_svc_compat+0x2c/0x54
[    8.922652]  el0t_32_sync_handler+0x90/0x140
[    8.922660]  el0t_32_sync+0x19c/0x1a0
[    8.922669] ---[ end trace 2245d8ba23a1d75c ]---

Note: This does not relate to the spi driver - when disabling this 
device in the device tree it fails for any other (i2s, for instance) 
which uses dma.
Commenting out the failing check at [1], however, helps and the mapping 
works again.

I tried to follow the recent changes for arm64 mm which could relate to 
the check failing at [1] and reverting
   commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")
helps and makes it work again, but I'm 100% uncertain if that commit is 
really the culprit.

Note, that the firmware (legacy u-boot) injects memory configuration in 
the device tree as follows:

/memreserve/    0x00000000fcefc000 0x000000000000d000;
/ {
..
     compatible = "pine64,rock64\0rockchip,rk3328";
..
     memory {
         reg = <0x00 0x200000 0x00 0xfee00000 0x00 0x00 0x00 0x00>;
         device_type = "memory";
     };

..
}

So: there is a "hole" in the mappable memory and reading the commit 
message of
   commit a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify 
pfn_valid()")
suggests, there was a change for that case recently.

I also noticed there is a diff in the kernel log regarding memory init 
up until 5.13.12 it says

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000200000-0x00000000feffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000200000-0x00000000feffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000200000-0x00000000feffffff]
[    0.000000] On node 0 totalpages: 1043968
[    0.000000]   DMA zone: 16312 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 1043968 pages, LIFO batch:63


In contrary in 5.14-rc7 it says:

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000200000-0x00000000feffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000200000-0x00000000feffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000200000-0x00000000feffffff]
[    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 4096 pages in unavailable ranges

(note the "unavailable ranges")
I'm uncertain again here, if that diff is expected behavior because of 
those recent mm changes for arm64.

After reverting
   commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")
the log changes to

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000200000-0x00000000feffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000200000-0x00000000feffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000200000-0x00000000feffffff]

(no DMA zones here)

As you might have noticed I have _zero_ clue about memory mapping and 
dma subsystem - so let me know if there is any more information needed 
for that and thanks for your help.

Alex

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/dma/mapping.c?id=e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93#n235

