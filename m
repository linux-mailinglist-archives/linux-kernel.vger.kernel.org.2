Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856193F6A36
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 22:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhHXUID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 16:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHXUIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 16:08:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DE9C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 13:07:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso3064788wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6x3j+OkRkyw9DV1B0EyAjBYSEA+AgCw5VMEZerH9gnk=;
        b=Cvsad9b3iy4PH2YjdA8xKFIwdztiL250XDd8wKeL25XYR6HdO44T1TXlyZ52MWcXPb
         LdO0OHh36NfmRmQxNtZmS4nt1SqbTMqQozcl2YxqnJwYqB7hb480YFZx1urY2inIAbpR
         nsOQiV07Ra3dt0tcRL479zXZZtEKrv57th/GvKa2rquaULzZ1eNgXwnsQ+mkGYrS0PUS
         KbCoRtSF82JzOX5sNCOkdUzRdYWpuq9S3VKYQ/Pj7Z23Ec5aw6V7ABi+LPQtIAnRfbhW
         Z8SNvdPqtqb8QBRbuWtjMfCmEhWBr71gZNVu41/Mjp8i8I83P86hzzJZTc3t+2Shv4K+
         t28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6x3j+OkRkyw9DV1B0EyAjBYSEA+AgCw5VMEZerH9gnk=;
        b=hqTpkGdjrDxwg+Ci/EyhnqUO52YJbDK8wlF3WCIh7DdmiNTyVk7J/5qS76o/aA/CSw
         Ft5vkhK36gd/v7VnCSbuKZddN4LAJ5jk/74+vYlg7L3mOueEAniwfikKd4A2B8NBktuY
         owsMFRQ0QKs8WjBB0rGUUHLmqoRZWFyYjeoWQKtJVzK6CDgYp8ss24cLin2jJ7b5A7qI
         8+NtiPdVvre8Vqg4pQq8lZdR8iMWTzVf27SfbAeanKqCA+McFi8wZjH1CBZbNYJntatf
         R6JYFNsmGxDHBEcjSxKMUEC+n5iWmm3HraSW7IDUpTWJMBBdjIbe79yZmOql6LFnfjp7
         f/Vw==
X-Gm-Message-State: AOAM533nmyAiZypEktSnrHN6ywWV8TyCiUtqVYtTd1x3yIg6QviUowPm
        CKS6Ln7ddMfcGaQdMu2JFQ==
X-Google-Smtp-Source: ABdhPJwsILYp3MZ7+BibFh27UDBGLt61Duv98lC0rb5IvSdcJpLuFiNyuej4/q2kV4060R4QURr2bg==
X-Received: by 2002:a05:600c:898:: with SMTP id l24mr5289108wmp.90.1629835636270;
        Tue, 24 Aug 2021 13:07:16 -0700 (PDT)
Received: from ?IPv6:2a02:810b:f40:4200:65a1:1952:1d23:2e04? ([2a02:810b:f40:4200:65a1:1952:1d23:2e04])
        by smtp.gmail.com with ESMTPSA id a18sm3015005wmg.43.2021.08.24.13.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 13:07:15 -0700 (PDT)
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <72d211b4-fe40-cc88-e831-9257ccad48af@gmail.com>
Date:   Tue, 24 Aug 2021 22:07:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824173741.GC623@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

thanks for your quick reply.

Am 24.08.21 um 19:37 schrieb Catalin Marinas:
> Hi Alex,
>
> Thanks for the report.
>
> On Tue, Aug 24, 2021 at 03:40:47PM +0200, Alex Bee wrote:
>> it seems there is a regression in arm64 memory mapping in 5.14, since it
>> fails on Rockchip RK3328 when the pl330 dmac tries to map with:
>>
>> [    8.921909] ------------[ cut here ]------------
>> [    8.921940] WARNING: CPU: 2 PID: 373 at kernel/dma/mapping.c:235 dma_map_resource+0x68/0xc0
>> [    8.921973] Modules linked in: spi_rockchip(+) fuse
>> [    8.921996] CPU: 2 PID: 373 Comm: systemd-udevd Not tainted 5.14.0-rc7 #1
>> [    8.922004] Hardware name: Pine64 Rock64 (DT)
>> [    8.922011] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>> [    8.922018] pc : dma_map_resource+0x68/0xc0
>> [    8.922026] lr : pl330_prep_slave_fifo+0x78/0xd0
>> [    8.922040] sp : ffff800012102ae0
>> [    8.922043] x29: ffff800012102ae0 x28: ffff000005c94800 x27: 0000000000000000
>> [    8.922056] x26: ffff000000566bd0 x25: 0000000000000001 x24: 0000000000000001
>> [    8.922067] x23: 0000000000000002 x22: ffff000000628c00 x21: 0000000000000001
>> [    8.922078] x20: ffff000000566bd0 x19: 0000000000000001 x18: 0000000000000000
>> [    8.922089] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>> [    8.922100] x14: 0000000000000277 x13: 0000000000000001 x12: 0000000000000000
>> [    8.922111] x11: 0000000000000001 x10: 00000000000008e0 x9 : ffff800012102a80
>> [    8.922123] x8 : ffff000000d14b80 x7 : ffff0000fe7b12f0 x6 : ffff0000fe7b1100
>> [    8.922134] x5 : fffffc000000000f x4 : 0000000000000000 x3 : 0000000000000001
>> [    8.922145] x2 : 0000000000000001 x1 : 00000000ff190800 x0 : ffff000000628c00
>> [    8.922158] Call trace:
>> [    8.922163]  dma_map_resource+0x68/0xc0
>> [    8.922173]  pl330_prep_slave_sg+0x58/0x220
>> [    8.922181]  rockchip_spi_prepare_dma+0xd8/0x2c0 [spi_rockchip]
>> [    8.922208]  rockchip_spi_transfer_one+0x294/0x3d8 [spi_rockchip]
> [...]
>> Note: This does not relate to the spi driver - when disabling this device in
>> the device tree it fails for any other (i2s, for instance) which uses dma.
>> Commenting out the failing check at [1], however, helps and the mapping
>> works again.
> Do you know which address dma_map_resource() is trying to map (maybe
> add some printk())? It's not supposed to map RAM, hence the warning.
> Random guess, the address is 0xff190800 (based on the x1 above but the
> regs might as well be mangled).

Confirmed:

[..]

[    8.353879] dma_map_resource Failed to map address 0xff190800

[..]

Alex

>
>> I tried to follow the recent changes for arm64 mm which could relate to the
>> check failing at [1] and reverting
>>    commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")
>> helps and makes it work again, but I'm 100% uncertain if that commit is
>> really the culprit.
>>
>> Note, that the firmware (legacy u-boot) injects memory configuration in the
>> device tree as follows:
>>
>> /memreserve/    0x00000000fcefc000 0x000000000000d000;
>> / {
>> ..
>>      compatible = "pine64,rock64\0rockchip,rk3328";
>> ..
>>      memory {
>>          reg = <0x00 0x200000 0x00 0xfee00000 0x00 0x00 0x00 0x00>;
>>          device_type = "memory";
>>      };
>>
>> ..
>> }
> Either pfn_valid() gets confused in 5.14 or something is wrong with the
> DT. I have a suspicion it's the former since reverting the above commit
> makes it disappear.
>
>> So: there is a "hole" in the mappable memory and reading the commit message
>> of
>>    commit a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify
>> pfn_valid()")
>> suggests, there was a change for that case recently.
> I think the change from the arm64 pfn_valid() to the generic one is
> avoiding the call to memblock_is_memory(). I wonder whether pfn_valid()
> returns true just because we have a struct page available but the memory
> may have been reserved.
>
> Cc'ing Mike R.
>
>> I also noticed there is a diff in the kernel log regarding memory init up
>> until 5.13.12 it says
>>
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000000200000-0x00000000feffffff]
>> [    0.000000]   DMA32    empty
>> [    0.000000]   Normal   empty
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000feffffff]
>> [    0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x00000000feffffff]
>> [    0.000000] On node 0 totalpages: 1043968
>> [    0.000000]   DMA zone: 16312 pages used for memmap
>> [    0.000000]   DMA zone: 0 pages reserved
>> [    0.000000]   DMA zone: 1043968 pages, LIFO batch:63
>>
>> In contrary in 5.14-rc7 it says:
>>
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000000200000-0x00000000feffffff]
>> [    0.000000]   DMA32    empty
>> [    0.000000]   Normal   empty
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000feffffff]
>> [    0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x00000000feffffff]
>> [    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
>> [    0.000000] On node 0, zone DMA: 4096 pages in unavailable ranges
>>
>> (note the "unavailable ranges")
>> I'm uncertain again here, if that diff is expected behavior because of those
>> recent mm changes for arm64.
>>
>> After reverting
>>    commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")
>> the log changes to
>>
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000000200000-0x00000000feffffff]
>> [    0.000000]   DMA32    empty
>> [    0.000000]   Normal   empty
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000feffffff]
>> [    0.000000] Initmem setup node 0 [mem
>> 0x0000000000200000-0x00000000feffffff]
>>
>> (no DMA zones here)
>>
>> As you might have noticed I have _zero_ clue about memory mapping and dma
>> subsystem - so let me know if there is any more information needed for that
>> and thanks for your help.
> Adding Robin as well, he has a better clue than us on DMA ;).
>
>> Alex
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/dma/mapping.c?id=e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93#n235
