Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096C1399FFD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFCLmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhFCLmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:42:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126C4C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 04:40:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u7so69465wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 04:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYpmgRyaGdNiF1ga7YiU1y1buioqsQI13Dyz7fcF4zU=;
        b=e6JkglIV14AN/ZpXb9f8lfWO87m04PkKP8T54Z02esIUvyA2cNi3cNCw+N/dr8zLT0
         QVM24Nqm3BD46X0/xLevxfHHvTHi2X3lo0kUdR32Y8iO0xJCKwvOYPZp5qIx9gad8rYL
         Qa0mQsg5zfe3rBxta5CaqyVbEQR/M1Yf5UCKnAC+Bols2CmSi3z0id4GiBewWBCCPY4W
         Se51uRDDv7HFXSdvUJETd89kt66DrCZdly6D3uBrzaHA9Z4FWLLIISlCgJp5G8FA0O0f
         v0pZr4myh4JH+INsyw1FSgI7mxfaoiu88tW6Anm5kYWNszyaOzjXUzIZJmKS2rFgkcKQ
         buSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYpmgRyaGdNiF1ga7YiU1y1buioqsQI13Dyz7fcF4zU=;
        b=V7XT59zqcYwx1E1rtlfCTwhQKP1sn1KVVz7DhU9LFqe8KXo/uVigUjcJNsFCZNDNdh
         yEyrFvQ7y73l2bnAKW1f7Ab05Y7G6RURIktkyE6yJpFG1tyfVlO0ATuvtEjJGMB8Jjr9
         lvN813/y0iWqdzCJfHZJxvKTU10LZwLibqPmYGX4qfxRN4J0KIIDuBqSwMJR0aPCc23D
         r4GYUK3nhAfdhcT6z9814tVqIQxBGYSYlp36PuzBKYF9m7Mb1vFiv2KGd4z4J/yyCqJ9
         8aF5evu5BayVZ6Z0pYcDh/i4oDZYxyvCrrojtIQONcm9CdZCSMtO/a35IfjOf0MdcRaK
         fBcQ==
X-Gm-Message-State: AOAM532lXwCE2P18Z/aaui0TO49ac7vMdazdxbSw1kgqK3gMi+KIqjzk
        9eahYPY5/Iv0wbZYB4li+pFzDYH1XR+Ff2xJwpzJWQ==
X-Google-Smtp-Source: ABdhPJzWs24S7KvixuXlVGA5sJEbS4CgNMowpCDSL9j4He92oJi3LqU6BSluuEMD2qXIrXaHegJgdzOCgOlCkz/jQKc=
X-Received: by 2002:a5d:540b:: with SMTP id g11mr11184759wrv.390.1622720407576;
 Thu, 03 Jun 2021 04:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210603082749.1256129-1-alex@ghiti.fr> <20210603082749.1256129-2-alex@ghiti.fr>
In-Reply-To: <20210603082749.1256129-2-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 3 Jun 2021 17:09:56 +0530
Message-ID: <CAAhSdy2O2o4Dpgwo3keT1P_Qutb21Zb_kEbZNnXKyw2duTJu1w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] riscv: Factorize xip and !xip kernel address
 conversion macros
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 1:59 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> To simplify the kernel address conversion code, make the same definition of
> kernel_mapping_pa_to_va and kernel_mapping_va_to_pa compatible for both xip
> and !xip kernel by defining XIP_OFFSET to 0 in !xip kernel.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

I think subject of the patch should be:
"Simplify address conversion macros for xip and !xip kernel"

Otherwise it looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/page.h    | 14 +++-----------
>  arch/riscv/include/asm/pgtable.h |  2 ++
>  2 files changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 6a7761c86ec2..6e004d8fda4d 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -93,9 +93,7 @@ extern unsigned long va_pa_offset;
>  #ifdef CONFIG_64BIT
>  extern unsigned long va_kernel_pa_offset;
>  #endif
> -#ifdef CONFIG_XIP_KERNEL
>  extern unsigned long va_kernel_xip_pa_offset;
> -#endif
>  extern unsigned long pfn_base;
>  #define ARCH_PFN_OFFSET                (pfn_base)
>  #else
> @@ -103,6 +101,7 @@ extern unsigned long pfn_base;
>  #ifdef CONFIG_64BIT
>  #define va_kernel_pa_offset    0
>  #endif
> +#define va_kernel_xip_pa_offset 0
>  #define ARCH_PFN_OFFSET                (PAGE_OFFSET >> PAGE_SHIFT)
>  #endif /* CONFIG_MMU */
>
> @@ -110,29 +109,22 @@ extern unsigned long kernel_virt_addr;
>
>  #ifdef CONFIG_64BIT
>  #define linear_mapping_pa_to_va(x)     ((void *)((unsigned long)(x) + va_pa_offset))
> -#ifdef CONFIG_XIP_KERNEL
>  #define kernel_mapping_pa_to_va(y)     ({                                              \
>         unsigned long _y = y;                                                           \
>         (_y >= CONFIG_PHYS_RAM_BASE) ?                                                  \
>                 (void *)((unsigned long)(_y) + va_kernel_pa_offset + XIP_OFFSET) :      \
>                 (void *)((unsigned long)(_y) + va_kernel_xip_pa_offset);                \
>         })
> -#else
> -#define kernel_mapping_pa_to_va(x)     ((void *)((unsigned long)(x) + va_kernel_pa_offset))
> -#endif
>  #define __pa_to_va_nodebug(x)          linear_mapping_pa_to_va(x)
>
>  #define linear_mapping_va_to_pa(x)     ((unsigned long)(x) - va_pa_offset)
> -#ifdef CONFIG_XIP_KERNEL
>  #define kernel_mapping_va_to_pa(y) ({                                          \
>         unsigned long _y = y;                                                   \
>         (_y < kernel_virt_addr + XIP_OFFSET) ?                                  \
>                 ((unsigned long)(_y) - va_kernel_xip_pa_offset) :               \
>                 ((unsigned long)(_y) - va_kernel_pa_offset - XIP_OFFSET);       \
>         })
> -#else
> -#define kernel_mapping_va_to_pa(x)     ((unsigned long)(x) - va_kernel_pa_offset)
> -#endif
> +
>  #define __va_to_pa_nodebug(x)  ({                                              \
>         unsigned long _x = x;                                                   \
>         (_x < kernel_virt_addr) ?                                               \
> @@ -141,7 +133,7 @@ extern unsigned long kernel_virt_addr;
>  #else
>  #define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + va_pa_offset))
>  #define __va_to_pa_nodebug(x)  ((unsigned long)(x) - va_pa_offset)
> -#endif
> +#endif /* CONFIG_64BIT */
>
>  #ifdef CONFIG_DEBUG_VIRTUAL
>  extern phys_addr_t __virt_to_phys(unsigned long x);
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index bde8ce3bfe7c..d98e931a31e5 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -77,6 +77,8 @@
>
>  #ifdef CONFIG_XIP_KERNEL
>  #define XIP_OFFSET             SZ_8M
> +#else
> +#define XIP_OFFSET             0
>  #endif
>
>  #ifndef __ASSEMBLY__
> --
> 2.30.2
>
