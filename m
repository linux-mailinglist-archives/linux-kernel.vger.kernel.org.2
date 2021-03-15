Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2977B33C54F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhCOSNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhCOSMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:12:46 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0324EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:12:46 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n132so34421705iod.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fKYmnTB6DXaLcQZf4n09mIgyLcDIP+NwqQZDD2xiRY=;
        b=ce0oxV3QtCW7e5n3oKOkctWUwAZKQevwIxOW/h/kU0WoYIW2/XQ6PCGFS+NG1N34Fi
         65SgsTOSg+4qxg6ex8lEBKFsaDq8mbL9+HeJuu6JqPXZCc3ujJFLQXeWgithGkGhoAzZ
         dNLkgFoEwWfjHdpEzglI+MTmtoG35bSrt9Z4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fKYmnTB6DXaLcQZf4n09mIgyLcDIP+NwqQZDD2xiRY=;
        b=E8YHqU8Bt9u+FhU2yKBxolNlI8BXdXw1bqGTwVtxqVsGjHjvNpi3QAN6APAQekD1m+
         VgvZu+lMGWdt8s8wRHbzBfdtiex6IaL+HoqbvtDP1lkDNcwSzYYuzIMzakKFC1FVHxj5
         sAgZHd+fNG6k9rLoyv42AWxiPniu1FJRdxe6h8UGHH311Z4KLPdrgYo/diY9TGQtGDH6
         eYKjIzTvODOlrsKH32bJe4fG2oPw/QjoDQ/CeO7gpyImoQtPc7aqdfkK8IjMPvMa7vIJ
         FI3unrf07685bkRYVocriV+rMT2ZWRVpGpSKS7gK7uEP3YBDrvHL+ru15S2cgnhwC6DI
         p1Jw==
X-Gm-Message-State: AOAM533c/EDiUIhwUQtIYS9ifQNVz0GNHuaNJrSYOftHtTRIFzO/Q5kU
        Fa5JyfXaUVcOdzlSc9V+XWl/qG3fux0p0qDtHXrP
X-Google-Smtp-Source: ABdhPJyRxPbGeTzjInwuEoXj/XmofRze7tZLVAUfwqTGtBYTfRhhRVaJarBzC5WQ1nXSPG4cQupDOuMNrgtMc6LOijA=
X-Received: by 2002:a05:6638:238c:: with SMTP id q12mr10833915jat.114.1615831965491;
 Mon, 15 Mar 2021 11:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210312154634.3541844-1-geert@linux-m68k.org>
In-Reply-To: <20210312154634.3541844-1-geert@linux-m68k.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 15 Mar 2021 11:12:34 -0700
Message-ID: <CAOnJCULrkGjQgdUM+XTmSLfXmiioRDmBMb3p7rA06wHNTBcdGg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix out-of-bounds accesses in init_resources()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 7:46 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
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
>         bss_res.end = __pa_symbol(__bss_stop) - 1;
>         bss_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>
> -       mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt) * sizeof(*mem_res);
> +       /* + 1 as memblock_alloc() might increase memblock.reserved.cnt */
> +       mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt + 1) * sizeof(*mem_res);
>         mem_res = memblock_alloc(mem_res_sz, SMP_CACHE_BYTES);
>         if (!mem_res)
>                 panic("%s: Failed to allocate %zu bytes\n", __func__, mem_res_sz);
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Thanks for catching the bug & fixing it.


Reviewed-by: Atish Patra <atish.patra@wdc.com>
-- 
Regards,
Atish
