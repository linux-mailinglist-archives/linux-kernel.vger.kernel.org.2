Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531D442616D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 02:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhJHAl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 20:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJHAl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 20:41:56 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1BAC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 17:40:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cs11-20020a17090af50b00b0019fe3df3dddso6302522pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 17:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=CiJdBQLxWVV52n6YDRHOz0BpzyfN8Kd3tB41suXFSBk=;
        b=WT2eany3SCBNcar+N4ql4I+fGUoIsWuPTI6TXJKJ+ppRlYj5rpN4G1UUSa94Ez8dL4
         mZ3CrbRYJvNmOnGq9PB//pmZCWHOXkw/2NvuXqRmppiioU6/v5YvjgoGGzs1Ki54o+td
         +jsb7MMU9hwrz0FTbdRYYLfnqmJF5/k4hXqJobEKmvoo2h2aCDBmf0q5wGQ5Z9I6cGeA
         7CHdH0bcTO/Fla1MavXJijo18EqsIptWMtJ5vqmL8nG8IUv+adpa77R0kkbXaGZj+AiF
         3slaLnBRys3+DkUIAHqV5CmqXu8/PshB3DwhoSwDF4dwujFOmVPahFQ2eaQlToHS8dE5
         j8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CiJdBQLxWVV52n6YDRHOz0BpzyfN8Kd3tB41suXFSBk=;
        b=QTX+1AdE3PwF1BbJKHMxvjjxRLblImfADi5hZ688JE+dzr2118VKTQN1547n3B+QtM
         Y8D4WhrODhCsFzWpEt0wFcAzJdUF0KoLRD/W/tlaZBD3lI62fD6dS9gLO8PchytTz4dg
         YMVtE2k+RiI/u10+4V119w/kIuk8uhRCT5B1Pw6UzHfu/orDYYcOxzSvOVdPlIc48Jal
         1aoLplUMBl++JplU1kGayDe9W2d1LrebJX7hvFUUvEN7NBvxE8Bf+bfLm/mZIZxHyvhK
         aq5h6NzErYWDEZlEiIZwFBRYSZ8LJFpA5nzjOEdVRjSZEQBsbul21yEkWRhLUtL2ftqJ
         vRaA==
X-Gm-Message-State: AOAM5329UTLIiUKF9FBuFU6913fsUl5KeZOezApGVHMtjWpWSRHYUCUo
        szXOEnL2h7luzx1znhyhtG1BcA==
X-Google-Smtp-Source: ABdhPJycovvqtyRMvee5ON0mJKq/edruYWJVRTzYNc8JAVMsB4fbhKy68Hpl7eBFaEy7LPECJU/8rA==
X-Received: by 2002:a17:90b:1a84:: with SMTP id ng4mr8432175pjb.80.1633653601744;
        Thu, 07 Oct 2021 17:40:01 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z11sm9727350pjn.12.2021.10.07.17.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 17:40:01 -0700 (PDT)
Date:   Thu, 07 Oct 2021 17:40:01 -0700 (PDT)
X-Google-Original-Date: Thu, 07 Oct 2021 17:37:13 PDT (-0700)
Subject:     Re: [PATCH] riscv: Flush current cpu icache before other cpus
In-Reply-To: <20210918160221.111902-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-24d30083-a545-447b-a54c-d0bbb5d67c7a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2021 09:02:21 PDT (-0700), alex@ghiti.fr wrote:
> On SiFive Unmatched, I recently fell onto the following BUG when booting:
>
> [    0.000000] ftrace: allocating 36610 entries in 144 pages
> [    0.000000] Oops - illegal instruction [#1]
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.13.1+ #5
> [    0.000000] Hardware name: SiFive HiFive Unmatched A00 (DT)
> [    0.000000] epc : riscv_cpuid_to_hartid_mask+0x6/0xae
> [    0.000000]  ra : __sbi_rfence_v02+0xc8/0x10a
> [    0.000000] epc : ffffffff80007240 ra : ffffffff80009964 sp : ffffffff81803e10
> [    0.000000]  gp : ffffffff81a1ea70 tp : ffffffff8180f500 t0 : ffffffe07fe30000
> [    0.000000]  t1 : 0000000000000004 t2 : 0000000000000000 s0 : ffffffff81803e60
> [    0.000000]  s1 : 0000000000000000 a0 : ffffffff81a22238 a1 : ffffffff81803e10
> [    0.000000]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
> [    0.000000]  a5 : 0000000000000000 a6 : ffffffff8000989c a7 : 0000000052464e43
> [    0.000000]  s2 : ffffffff81a220c8 s3 : 0000000000000000 s4 : 0000000000000000
> [    0.000000]  s5 : 0000000000000000 s6 : 0000000200000100 s7 : 0000000000000001
> [    0.000000]  s8 : ffffffe07fe04040 s9 : ffffffff81a22c80 s10: 0000000000001000
> [    0.000000]  s11: 0000000000000004 t3 : 0000000000000001 t4 : 0000000000000008
> [    0.000000]  t5 : ffffffcf04000808 t6 : ffffffe3ffddf188
> [    0.000000] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000002
> [    0.000000] [<ffffffff80007240>] riscv_cpuid_to_hartid_mask+0x6/0xae
> [    0.000000] [<ffffffff80009474>] sbi_remote_fence_i+0x1e/0x26
> [    0.000000] [<ffffffff8000b8f4>] flush_icache_all+0x12/0x1a
> [    0.000000] [<ffffffff8000666c>] patch_text_nosync+0x26/0x32
> [    0.000000] [<ffffffff8000884e>] ftrace_init_nop+0x52/0x8c
> [    0.000000] [<ffffffff800f051e>] ftrace_process_locs.isra.0+0x29c/0x360
> [    0.000000] [<ffffffff80a0e3c6>] ftrace_init+0x80/0x130
> [    0.000000] [<ffffffff80a00f8c>] start_kernel+0x5c4/0x8f6
> [    0.000000] ---[ end trace f67eb9af4d8d492b ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
>
> While ftrace is looping over a list of addresses to patch, it always failed
> when patching the same function: riscv_cpuid_to_hartid_mask. Looking at the
> backtrace, the illegal instruction is encountered in this same function.
> However, patch_text_nosync, after patching the instructions, calls
> flush_icache_range. But looking at what happens in this function:
>
> flush_icache_range -> flush_icache_all
>                    -> sbi_remote_fence_i
>                    -> __sbi_rfence_v02
>                    -> riscv_cpuid_to_hartid_mask
>
> The icache and dcache of the current cpu are never synchronized between the
> patching of riscv_cpuid_to_hartid_mask and calling this same function.
>
> So fix this by flushing the current cpu's icache before asking for the other
> cpus to do the same.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/cacheflush.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 094118663285..89f81067e09e 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -16,6 +16,8 @@ static void ipi_remote_fence_i(void *info)
>
>  void flush_icache_all(void)
>  {
> +	local_flush_icache_all();
> +
>  	if (IS_ENABLED(CONFIG_RISCV_SBI))
>  		sbi_remote_fence_i(NULL);
>  	else

Thanks, this is on fixes (with the tags for stable)
