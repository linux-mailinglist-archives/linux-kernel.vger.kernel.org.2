Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504563EC093
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhHNFAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhHNFAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:00:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35115C061575
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:00:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a8so18334349pjk.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=B7FsBNBl1wj9+CpdzAHHpu0R9bUtnuFq39y817XmkFk=;
        b=NJdF3EZsOlDwSne+vtkjUBcH1AZOC4GOUjlZ5fnpjrHxP9WE/gpfot+AqbVzKwkbdg
         F3YXEEG5HM3l6othuu3gEz8SfuxLZD1R8zlakNoSwb/WsayG9ZQQKx8OStvLWo4F7uIA
         EnX3sP9b3wSLCjK9c5aGuQO8nEI5hkOuul/oxQQt/3EPBFB6VwFl1Ih0vkkkkB0ssauE
         CXofDqJ0+mvig3ij/AoqcoxnIY4BhMKwVCfAiKWHpnLbydLgydaF/cKZUnmYYFVYz5A/
         GfmbeEcNhwHdb5/wnKh75F7WkLUoOTJ390BFtWDL8hrPxQWKzG9ZK/HmgzfxK6ncNUuO
         HcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=B7FsBNBl1wj9+CpdzAHHpu0R9bUtnuFq39y817XmkFk=;
        b=QE4quJMhhZ+mMTWLOnoXxsGnknNsRzmDZfw/renEI8lWvsBkHnGTFhma2kenCXO+gd
         t7GWdLdPRi3DpHCSlpOfi3UJTxTXMJekl680NCUc2BTsxShSNmjGtj/GPcD6OGQ9gdBh
         OepVtT4RERgD+JrsbWJg/v1YYlKqTlFb3C0y9BcCzGQrdJ3KwGi3QrFgPGvVoFU9sJGD
         4ToxDogmKKzWH857BKYxaFvmUbLd8tWb0wVsKMD95yQJAryFfMR+Qxjm1xa5d0mDXNrN
         dhTl633XgfsoNqFcOB9fYhwQ1CwP4ggC8ehGrcCrR1CyLlTUADaWRH4CjmCbBG3bGf39
         HaQg==
X-Gm-Message-State: AOAM533C3C7jAUmnLBLYoHU5MA4MYf9KtKjYXnUXw6p0/6BnKOnLL9tU
        xMNWj5XWMB/IEF1qlsSlFRQVCQ==
X-Google-Smtp-Source: ABdhPJwMlw7acwFz2mAUfup1HEbyw3SEnSxVvFM1Chp5vy1/GQc4QIe3ivH9k5TurwcCpV58whzhow==
X-Received: by 2002:a17:902:c602:b029:12c:daac:c89f with SMTP id r2-20020a170902c602b029012cdaacc89fmr4663469plr.78.1628917218314;
        Fri, 13 Aug 2021 22:00:18 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 4sm3252160pjb.21.2021.08.13.22.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 22:00:17 -0700 (PDT)
Date:   Fri, 13 Aug 2021 22:00:17 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Aug 2021 15:33:53 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: fix the global name pfn_base confliction error
In-Reply-To: <20210728071557.400163-1-nek.in.cn@gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        alex@ghiti.fr, anup@brainfault.org,
        Atish Patra <Atish.Patra@wdc.com>, liguozhu@hisilicon.com,
        wangkefeng.wang@huawei.com, vitaly.wool@konsulko.com,
        guoren@linux.alibaba.com, jszhang@kernel.org, rppt@kernel.org,
        mick@ics.forth.gr, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, guohanjun@huawei.com,
        wangzhou1@hisilicon.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nek.in.cn@gmail.com
Message-ID: <mhng-90c1822d-54dc-4212-bddd-515bba4787e7@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 00:15:57 PDT (-0700), nek.in.cn@gmail.com wrote:
> From: Kenneth Lee <liguozhu@hisilicon.com>
>
> RISCV uses a global variable pfn_base for page/pfn translation. But this
> is a common name and will be used elsewhere. In those cases, the
> page-pfn macros which refer to this name will be referred to the
> local/input variable instead. (such as in vfio_pin_pages_remote). This
> make everything wrong.
>
> This patch changes the name from pfn_base to riscv_pfn_base to fix
> this problem
>
> Chagne from V1:
> 	use riscv_pfn_base instead of riscv_global_pfn_base.
>
> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> ---
>  arch/riscv/include/asm/page.h | 4 ++--
>  arch/riscv/mm/init.c          | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index cca8764aed83..c690e83bde23 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -79,8 +79,8 @@ typedef struct page *pgtable_t;
>  #endif
>
>  #ifdef CONFIG_MMU
> -extern unsigned long pfn_base;
> -#define ARCH_PFN_OFFSET		(pfn_base)
> +extern unsigned long riscv_pfn_base;
> +#define ARCH_PFN_OFFSET		(riscv_pfn_base)
>  #else
>  #define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
>  #endif /* CONFIG_MMU */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index a14bf3910eec..788f12bb586b 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -228,8 +228,8 @@ static struct pt_alloc_ops _pt_ops __initdata;
>  #define pt_ops _pt_ops
>  #endif
>
> -unsigned long pfn_base __ro_after_init;
> -EXPORT_SYMBOL(pfn_base);
> +unsigned long riscv_pfn_base __ro_after_init;
> +EXPORT_SYMBOL(riscv_pfn_base);
>
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> @@ -572,7 +572,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
>  #endif
>
> -	pfn_base = PFN_DOWN(kernel_map.phys_addr);
> +	riscv_pfn_base = PFN_DOWN(kernel_map.phys_addr);
>
>  	/*
>  	 * Enforce boot alignment requirements of RV32 and

Thanks, this is on for-next.
