Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A557B33E895
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 05:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhCQExW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 00:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQExH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 00:53:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B5C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 21:53:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so4694997pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 21:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bOxl3V+1KY/8zaD5pUmKYcp5UFMxN79rD/BTslHwRVI=;
        b=U0h7/IfExyTKR9yu6gUha/hKKszbmmte1DU+1SP6d3S/3CIPBb2IssZ6weDVC3axu5
         Amra2Dib6T7784UdJZrrFYNzoIezcnZVzOIjnL4PkQ8qr3fQEhDs9dIix4TrKLDc8Gcz
         riNmCzpa5lnqYNWqvrJ0Rkc4TVlN2xY1YtIhFR/AxrKCbWMnCeT2tgrQ+20tIjgI9YyB
         tV4L8w7PX0HH04D1co8yOP07qrKSgO0mBUN3ZZNpSbR2Twk67rlgg82UkfBVtmgaKWWA
         kxRXPENGKo/ASSBasO8bVN70EHeUCh1QJiy4UICGyCQt/xueATheoGbliYcKLbbszO/b
         ss8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bOxl3V+1KY/8zaD5pUmKYcp5UFMxN79rD/BTslHwRVI=;
        b=gV/k3o5ADdqtBAfN2v2geIr7UZxUiEOnJjY3V6HOlfpbC/IrSymYTLlggzWQ3vfrf0
         UeY5YUd5ayLkPfz5BYrEIhrF93Rtc+hirtNqHU5+NB1/3L7jO1uuEc5UYb8pZuUEogtc
         UTS2SX9yDcuL5x4kL8tPThswKbmLmhMroXtReGu88/BI6D6zgIV9qTm1aGsXiRCPQ6G4
         h/Met5rsXo//DWrPbCtPtDuWjLsYBpnEKAJrdwZ5AeFiTZcKdoU6cAiyITnshY7arV18
         EZ6vwQhGNqNP8mKbKVg/iviImPI48540DK91kaJicauLkcM9iF3c9OSwI27/PbMCQG+i
         K+Lg==
X-Gm-Message-State: AOAM530UbOUWOJXLmw7BLimiy0qljxdUE99dmkSFhfNZNKQi5mv8VVYd
        sfe3/+5633GYDxbKvUNtNqom8w==
X-Google-Smtp-Source: ABdhPJxYg8S6BCSDk4G2YF7NIsO7aZiy5c1IxedOg7sM8FHnbI38szc1bKtdAAn91bGNpRHTeGzHvg==
X-Received: by 2002:a17:90b:2284:: with SMTP id kx4mr2454622pjb.96.1615956786456;
        Tue, 16 Mar 2021 21:53:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 132sm18050138pfu.158.2021.03.16.21.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 21:53:05 -0700 (PDT)
Date:   Tue, 16 Mar 2021 21:53:05 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Mar 2021 21:52:48 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Fix out-of-bounds accesses in init_resources()
In-Reply-To: <20210312154634.3541844-1-geert@linux-m68k.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     geert@linux-m68k.org
Message-ID: <mhng-3252ea0a-bbbb-4024-ae06-cf2212aaa466@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 07:46:34 PST (-0800), geert@linux-m68k.org wrote:
> init_resources() allocates an array of resources, based on the current
> total number of memory regions and reserved memory regions.  However,
> allocating this array using memblock_alloc() might increase the number
> of reserved memory regions.  If that happens, populating the array later
> based on the new number of regions will cause out-of-bounds writes
> beyond the end of the allocated array.
>
> Fix this by allocating one more entry, which may or may not be used.
>
> Fixes: 797f0375dd2ef5cd ("RISC-V: Do not allocate memblock while iterating reserved memblocks")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Tested on vexriscv, which works now using L1_CACHE_SHIFT = 6, too.
>
> This issue may show up during early boot as:
>
>     Unable to handle kernel paging request at virtual address c8000008
>     Oops [#1]
>     CPU: 0 PID: 0 Comm: swapper Not tainted 5.11.0-orangecrab-00023-g7c4fc8e3e982-dirty #137
>     epc: c04d6660 ra : c04d6560 sp : c05ddf70
>      gp : c0678bc0 tp : c05e5b40 t0 : c8000000
>      t1 : 00030000 t2 : ffffffff s0 : c05ddfc0
>      s1 : c8000000 a0 : 00000000 a1 : c7ffffe0
>      a2 : 00000005 a3 : 00000001 a4 : 0000000c
>      a5 : 00000000 a6 : c04fe000 a7 : 0000000c
>      s2 : c04fe098 s3 : 000000a0 s4 : c7ffff60
>      s5 : c04fe0dc s6 : 80000200 s7 : c059f1d4
>      s8 : 81000200 s9 : c059f1f0 s10: 80000200
>      s11: c059f1d4 t3 : 405dbb60 t4 : c05e6f08
>      t5 : 81000200 t6 : 40501000
>     status: 00000100 badaddr: c8000008 cause: 0000000f
>     random: get_random_bytes called from print_oops_end_marker+0x38/0x7c with crng_init=0
>     ---[ end trace 0000000000000000 ]---
>
> or much later as:
>
>     Unable to handle kernel paging request at virtual address 69726573
> ---
>  arch/riscv/kernel/setup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index e85bacff1b5075ee..f8f15332caa20263 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -147,7 +147,8 @@ static void __init init_resources(void)
>  	bss_res.end = __pa_symbol(__bss_stop) - 1;
>  	bss_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>
> -	mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt) * sizeof(*mem_res);
> +	/* + 1 as memblock_alloc() might increase memblock.reserved.cnt */
> +	mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt + 1) * sizeof(*mem_res);
>  	mem_res = memblock_alloc(mem_res_sz, SMP_CACHE_BYTES);
>  	if (!mem_res)
>  		panic("%s: Failed to allocate %zu bytes\n", __func__, mem_res_sz);

Thanks, this is on fixes.
