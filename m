Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F1143D72A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhJ0XIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhJ0XIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:08:51 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C48C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:06:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h193so4501984pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qq3Zte+b3gvW8aVUSoj11hufNXWtcNy5WKvRt4opsbo=;
        b=7y5UZL3rxbZp4tvqsYjA0PSihfwGo2dxmv9dANT4KDkwtKlsd4EoZH5BgFjkxWwrJE
         2/gCrvWOjjaEVpOr6/JrF6H+ZzfKQox2Vg9ZHvu9PXip1qdGjyF8mUGSQEqhxy/YUnBa
         IrpRZJuZPA/8znNDIcvJBYFnlOS8M6mdo1HVcNspkw2G737P6sBVl923LGfWRi2k1/OK
         jQfkqKacsO5o+iNweytFnLyVs6V9iBR3RnJ6zjCInvvzrw4SAFPkJ2VIpeLXj1Yc5ome
         Tp6cF3kgiluFW/TayK9FlC+IsK/GJwSP9fnxFwx97BTeLHMDp1HvQAch5PPeqqY/cv6M
         ImcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qq3Zte+b3gvW8aVUSoj11hufNXWtcNy5WKvRt4opsbo=;
        b=UxmUlrnHiairgiHHQoKISulUpbFCXnMK8N5SKIX+Z59tFoxAbM7SlIoNV0EXAyPwlO
         UnhbHKa7yk2RlSXLaBWKZgwiUhCTklGj04lAjy9RFlDCOT/lLZQs9MFLEM03FMRsrb8h
         nce2cbfqVXMv3osE1a19TE0zgS6XVFMCiHKXrO+qbNjSek3GXepUiT7O9BnEX12gXHGN
         PwnwgQsI4mToYB1kpWG13eXasfnADrwiicOhzCoTrf6c9zWXqlBTeE2bxbaeZbSkzYZV
         6ZMFvAapFYeiDO3eU60hSvbEf+RdyperKgHnpA72mmwEU5hlYAWIj6EhOsK3lgbzTYi4
         WwbQ==
X-Gm-Message-State: AOAM531uHAzFlz0MhAW4kPQLyWac1hwwLHykG4VrAB+yNU2O9rmFPMx6
        SyjiMcRhbG9e5yKBcBt25vMm3g==
X-Google-Smtp-Source: ABdhPJyEhOalg4/dY/3KpRqiR/tNPNHZi5ofV+HXu1SYzAcPhIDj9GCXCztUYI7qBkfpEe/S5DxTVQ==
X-Received: by 2002:a63:84c6:: with SMTP id k189mr479739pgd.245.1635375984652;
        Wed, 27 Oct 2021 16:06:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:60fc:a50:6d27:9fd3])
        by smtp.gmail.com with ESMTPSA id j1sm751742pgb.5.2021.10.27.16.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:06:24 -0700 (PDT)
Date:   Wed, 27 Oct 2021 16:06:24 -0700 (PDT)
X-Google-Original-Date: Wed, 27 Oct 2021 16:06:21 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv: Fix asan-stack clang build
In-Reply-To: <20211027045843.1770770-1-alexandre.ghiti@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        alexandre.ghiti@canonical.com, nathan@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexandre.ghiti@canonical.com
Message-ID: <mhng-41b64d3e-5a5a-4d59-86fc-80f2148823e8@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 21:58:42 PDT (-0700), alexandre.ghiti@canonical.com wrote:
> Nathan reported that because KASAN_SHADOW_OFFSET was not defined in
> Kconfig, it prevents asan-stack from getting disabled with clang even
> when CONFIG_KASAN_STACK is disabled: fix this by defining the
> corresponding config.
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> ---
>  arch/riscv/Kconfig             | 6 ++++++
>  arch/riscv/include/asm/kasan.h | 3 +--
>  arch/riscv/mm/kasan_init.c     | 3 +++
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c1abbc876e5b..79250b1ed54e 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -162,6 +162,12 @@ config PAGE_OFFSET
>  	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>  	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>
> +config KASAN_SHADOW_OFFSET
> +	hex
> +	depends on KASAN_GENERIC
> +	default 0xdfffffc800000000 if 64BIT
> +	default 0xffffffff if 32BIT

I thought I posted this somewhere, but this is exactly what my first 
guess was.  The problem is that it's hanging on boot for me.  I don't 
really have anything exotic going on, it's just a defconfig with 
CONFIG_KASAN=y running in QEMU.

Does this boot for you?

> +
>  config ARCH_FLATMEM_ENABLE
>  	def_bool !NUMA
>
> diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
> index a2b3d9cdbc86..b00f503ec124 100644
> --- a/arch/riscv/include/asm/kasan.h
> +++ b/arch/riscv/include/asm/kasan.h
> @@ -30,8 +30,7 @@
>  #define KASAN_SHADOW_SIZE	(UL(1) << ((CONFIG_VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
>  #define KASAN_SHADOW_START	KERN_VIRT_START
>  #define KASAN_SHADOW_END	(KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
> -#define KASAN_SHADOW_OFFSET	(KASAN_SHADOW_END - (1ULL << \
> -					(64 - KASAN_SHADOW_SCALE_SHIFT)))
> +#define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>
>  void kasan_init(void);
>  asmlinkage void kasan_early_init(void);
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index d7189c8714a9..8175e98b9073 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -17,6 +17,9 @@ asmlinkage void __init kasan_early_init(void)
>  	uintptr_t i;
>  	pgd_t *pgd = early_pg_dir + pgd_index(KASAN_SHADOW_START);
>
> +	BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
> +		KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
> +
>  	for (i = 0; i < PTRS_PER_PTE; ++i)
>  		set_pte(kasan_early_shadow_pte + i,
>  			mk_pte(virt_to_page(kasan_early_shadow_page),
