Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662D5459AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 04:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhKWDsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 22:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhKWDsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 22:48:02 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE1FC061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 19:44:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d5so36481856wrc.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 19:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prwznrXYx9FivXvITlLw7CLoLZmuSVyES8AT5odxIYI=;
        b=5xkqb0Srh9HW2cGmAjMw/k8621P0nS5Xol4Wut4aWzRk0M1N1D5DMem+F9C9MArH0h
         Rv2nrncH79zJ680Zm/eIBFDEdu9IABBCtf6j2MANu0FviFQvMN9rZdmkoVVhso0I5c3n
         N8Hl9c/OQ1ZYynCCUhLBHkeVcDzzH6buwP8KMEAouNTiMmYoBUETfUbw+ktLQQZjasQK
         YMd1KV85JWJ/8EuXs2GuvO+0oVVTy9agvsQAVVzAkewCZxyuWIidU+Fxz8fH0DviECbh
         2jO/oE3jailGlq7GUJ5LPB71S4nnmFGzqo+C+6dHV44mWlLlQXhyeuoG8AePQ9+gR2Ly
         7n9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prwznrXYx9FivXvITlLw7CLoLZmuSVyES8AT5odxIYI=;
        b=1eckPrsIqTW8Zv0jfMHpEPCGrib77lnvKiM2DaLJUT+8k1jyQt/kM8ihe7+RMnrR/l
         WzPzkq6s3slAWI1pDgEQwc2x8djaoWE5xJHBkrpAv2gMWllC20jfyF74xSLID1ZQI3Aq
         l0mxSep0jV2wEITaGtlFze2HW4BcwKx+EtzH6BPp0fbwHxmfqR+QzlLdyq1Ijx0vBKVK
         HdTFGkW16sEtLywn8UnxzuP1TWJHZ2e24Vcz7ImIa+MPn7LL2bc8/Gt9tPnUpp/ZH4wO
         4SeKYYDTcL8mJVZkf0kJSsSH7nNHnINIvnNoqJxkLgUAQkw4+bYW5jzKzQoK0lemyos3
         jMWA==
X-Gm-Message-State: AOAM531QcY79HvowKyc+qlTqEd1Hiy3fzfx/VkkSqoxuPe3XlsTlfgSc
        dkegDwO48tygpEZZylO1uacq6Y12EZUUDMCIBlVsTA==
X-Google-Smtp-Source: ABdhPJwbO/w5z/3wD3ekcFIK1oSZgbGqncwHscSdr5bvFbKNmUUhZy7QC+PbD7hxLl/SwXJxZCTL1ySIMY4ZauFM+gc=
X-Received: by 2002:a5d:628f:: with SMTP id k15mr3327019wru.363.1637639092147;
 Mon, 22 Nov 2021 19:44:52 -0800 (PST)
MIME-Version: 1.0
References: <20211123015717.542631-1-guoren@kernel.org> <20211123015717.542631-3-guoren@kernel.org>
In-Reply-To: <20211123015717.542631-3-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 23 Nov 2021 09:14:40 +0530
Message-ID: <CAAhSdy0LLu4o6uOB8t_Wv6jsOrrrSMx0pv1E1B5F679gan3i6g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] riscv: Add early_param to decrease firmware region
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, atishp@rivosinc.com,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup.patel@wdc.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Alex

On Tue, Nov 23, 2021 at 7:27 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Using riscv.fw_size in cmdline to tell the kernel what the
> firmware (opensbi) size is. Then reserve the proper size of
> firmware to save memory instead of the whole 2MB. It's helpful
> to satisfy a small memory system (D1s/F133 from Allwinner).
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/mm/init.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 920e78f8c3e4..f7db6d40213d 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -159,6 +159,15 @@ static int __init early_mem(char *p)
>  }
>  early_param("mem", early_mem);
>
> +static phys_addr_t firmware_size __initdata;
> +static int __init early_get_firmware_size(char *arg)
> +{
> +       firmware_size = memparse(arg, &arg);
> +
> +       return 0;
> +}
> +early_param("riscv.fwsz", early_get_firmware_size);
> +

We have avoided any RISC-V specific kernel parameter till now
and I don't think adding "riscv.fwsz" is the right approach.

OpenSBI adds a reserved memory node (mmode_resv@8000000)
to mark the memory where it is running as reserved. In fact, all
M-mode runtime firmware should be adding a reserved memory
node just like OpenSBI.

Regards,
Anup

>  static void __init setup_bootmem(void)
>  {
>         phys_addr_t vmlinux_end = __pa_symbol(&_end);
> @@ -224,7 +233,10 @@ static void __init setup_bootmem(void)
>         /*
>          * Reserve OpenSBI region and depends on PMP to deny accesses.
>          */
> -       memblock_reserve(__pa(PAGE_OFFSET), LOAD_OFFSET);
> +       if (firmware_size > PAGE_SIZE)
> +               memblock_reserve(__pa(PAGE_OFFSET), firmware_size);
> +       else
> +               memblock_reserve(__pa(PAGE_OFFSET), LOAD_OFFSET);
>
>         early_init_fdt_scan_reserved_mem();
>         dma_contiguous_reserve(dma32_phys_limit);
> --
> 2.25.1
>
