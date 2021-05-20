Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3E7389CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 06:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhETE5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 00:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETE5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 00:57:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE89DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 21:55:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b7so4145773plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 21:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7hUMPWC64LAsjcIj5xagu1FVPYx/So//vZuQ9Tazp4A=;
        b=IfRLXKPkRmQK2vqKG+W7DLxIvHkl6XlhmjYujlpvVgUwtUeW5ztTCuUO/qU1CW0YMI
         eNU8sZcbsJzBNRgOTj3LUImK2bUrtNtFcwYwyIs/ZOlJlRDL3BHXM1S8T2pyoosEU3aL
         YoI62eFmCWg+5Huqmv463Vx5vVADHyplpPv1P64n7Mp2eGINbiS4BmcSgyzWe7n4qk/4
         iNuUhnZZFOV5l6fzPyYHL2hh7vCzyHvQvAd5hJbHnnfYxl0D5d07xiI4W0IvNw6+WyEo
         aVhv6jxTJtUfyEU4xE8T8ELYQ/rZSEl0HPNyEnVDMWrl6sqvJeAuYeKfDxDo4Vu0DB3B
         ABiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7hUMPWC64LAsjcIj5xagu1FVPYx/So//vZuQ9Tazp4A=;
        b=IbXRQE/PYQBOHr6CKM6aONrEAY1QC9Sm0OxcW6log6yJLhC4/l2zOvfpSfguO1QqWv
         ghS+PECCw039JVwMC58q4OW5gCCxBY9SqWNSbTSNInrfMwjMswo5piaizd6ZlGGnDD7w
         Oiklirx9is407OoZbu14RKC3fkAzLKXofZhngU2bMGCMep6ttfGRcZVnOQgRXnOGxGR3
         iSc9YrxxTtX4Y0cFenSojwLtVZkwf06RqpYj7ASVp5/QJ96rsQECUofMFIFEftfxxcl+
         h8MCvmgJPPMBTnHoW7koERBfS8gI8gDrSKmto6WF5ONM+9+byeif06cSGcYIovjlIeav
         zMPw==
X-Gm-Message-State: AOAM533xohNgfgOx9Ob7kW9hFMx5B41GZebLZNF9gGttJMtXabWBbP//
        hApZcguIgferbc6lbXPSC36OrQ==
X-Google-Smtp-Source: ABdhPJyURTzdqzYxNX+DsrWg38Bv4qXb2YTaXDts0AQVao5QVwOGHeNqN6CyHLIZ2OkHTafwJjCzcA==
X-Received: by 2002:a17:90a:a505:: with SMTP id a5mr2822640pjq.58.1621486543191;
        Wed, 19 May 2021 21:55:43 -0700 (PDT)
Received: from x1 ([2601:1c0:4701:ae70:1ac3:31d1:689c:7daa])
        by smtp.gmail.com with ESMTPSA id m1sm446663pjo.10.2021.05.19.21.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 21:55:42 -0700 (PDT)
Date:   Wed, 19 May 2021 21:55:40 -0700
From:   Drew Fustini <drew@beagleboard.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wei Fu <tekkamanninja@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@gmail.com>
Subject: Re: [PATCH] riscv: mm: Fix W+X mappings at boot
Message-ID: <20210520045540.GA3236664@x1>
References: <20210516170038.7de9c866@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516170038.7de9c866@xhacker>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 05:00:38PM +0800, Jisheng Zhang wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> When the kernel mapping was moved the last 2GB of the address space,
> (__va(PFN_PHYS(max_low_pfn))) is much smaller than the .data section
> start address, the last set_memory_nx() in protect_kernel_text_data()
> will fail, thus the .data section is still mapped as W+X. This results
> in below W+X mapping waring at boot. Fix it by passing the correct
> .data section page num to the set_memory_nx().
> 
> [    0.396516] ------------[ cut here ]------------
> [    0.396889] riscv/mm: Found insecure W+X mapping at address (____ptrval____)/0xffffffff80c00000
> [    0.398347] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/ptdump.c:258 note_page+0x244/0x24a
> [    0.398964] Modules linked in:
> [    0.399459] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc1+ #14
> [    0.400003] Hardware name: riscv-virtio,qemu (DT)
> [    0.400591] epc : note_page+0x244/0x24a
> [    0.401368]  ra : note_page+0x244/0x24a
> [    0.401772] epc : ffffffff80007c86 ra : ffffffff80007c86 sp : ffffffe000e7bc30
> [    0.402304]  gp : ffffffff80caae88 tp : ffffffe000e70000 t0 : ffffffff80cb80cf
> [    0.402800]  t1 : ffffffff80cb80c0 t2 : 0000000000000000 s0 : ffffffe000e7bc80
> [    0.403310]  s1 : ffffffe000e7bde8 a0 : 0000000000000053 a1 : ffffffff80c83ff0
> [    0.403805]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 6c7e7a5137233100
> [    0.404298]  a5 : 6c7e7a5137233100 a6 : 0000000000000030 a7 : ffffffffffffffff
> [    0.404849]  s2 : ffffffff80e00000 s3 : 0000000040000000 s4 : 0000000000000000
> [    0.405393]  s5 : 0000000000000000 s6 : 0000000000000003 s7 : ffffffe000e7bd48
> [    0.405935]  s8 : ffffffff81000000 s9 : ffffffffc0000000 s10: ffffffe000e7bd48
> [    0.406476]  s11: 0000000000001000 t3 : 0000000000000072 t4 : ffffffffffffffff
> [    0.407016]  t5 : 0000000000000002 t6 : ffffffe000e7b978
> [    0.407435] status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
> [    0.408052] Call Trace:
> [    0.408343] [<ffffffff80007c86>] note_page+0x244/0x24a
> [    0.408855] [<ffffffff8010c5a6>] ptdump_hole+0x14/0x1e
> [    0.409263] [<ffffffff800f65c6>] walk_pgd_range+0x2a0/0x376
> [    0.409690] [<ffffffff800f6828>] walk_page_range_novma+0x4e/0x6e
> [    0.410146] [<ffffffff8010c5f8>] ptdump_walk_pgd+0x48/0x78
> [    0.410570] [<ffffffff80007d66>] ptdump_check_wx+0xb4/0xf8
> [    0.410990] [<ffffffff80006738>] mark_rodata_ro+0x26/0x2e
> [    0.411407] [<ffffffff8031961e>] kernel_init+0x44/0x108
> [    0.411814] [<ffffffff80002312>] ret_from_exception+0x0/0xc
> [    0.412309] ---[ end trace 7ec3459f2547ea83 ]---
> [    0.413141] Checked W+X mappings: failed, 512 W+X pages found
> 
> Fixes: 2bfc6cd81bd17e43 ("riscv: Move kernel mapping outside of linear mapping")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/mm/init.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 4faf8bd157ea..4c4c92ce0bb8 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -746,14 +746,18 @@ void __init protect_kernel_text_data(void)
>  	unsigned long init_data_start = (unsigned long)__init_data_begin;
>  	unsigned long rodata_start = (unsigned long)__start_rodata;
>  	unsigned long data_start = (unsigned long)_data;
> -	unsigned long max_low = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
> +#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
> +	unsigned long end_va = kernel_virt_addr + load_sz;
> +#else
> +	unsigned long end_va = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
> +#endif
>  
>  	set_memory_ro(text_start, (init_text_start - text_start) >> PAGE_SHIFT);
>  	set_memory_ro(init_text_start, (init_data_start - init_text_start) >> PAGE_SHIFT);
>  	set_memory_nx(init_data_start, (rodata_start - init_data_start) >> PAGE_SHIFT);
>  	/* rodata section is marked readonly in mark_rodata_ro */
>  	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> -	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
> +	set_memory_nx(data_start, (end_va - data_start) >> PAGE_SHIFT);
>  }
>  
>  void mark_rodata_ro(void)
> -- 
> 2.31.0
> 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

I know there is a new thread now with a different approach but I wanted
to say that this did fix that warning on the BeagleV Starlight beta
prototype board [1] with the StarFive JH7100 SoC [2]. I am using Emil's
starlight branch [3] which is a set of StarFive patches on top of
5.13-rc2. Emil included this W+X mapping patch [4]. It does fix the
warning on boot for me and the bootlog [5] shows:

  [    2.302598] Checked W+X mappings: passed, no W+X pages found

Thus if useful, here is my TB:

Tested-by: Drew Fustini <drew@beagleboard.org>

thanks,
drew

[1] https://github.com/beagleboard/beaglev-starlight
[2] https://github.com/starfive-tech/beaglev_doc
[3] https://github.com/esmil/linux/tree/starlight
[4] https://github.com/esmil/linux/commit/b865eb820db8b9b94a7a2d2619e46cc3251fb90d
[5] https://gist.github.com/pdp7/0bf9088d034384d29ba4e8418c9dfd91
