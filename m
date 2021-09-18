Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF74D41061C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 13:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbhIRLws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 07:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhIRLwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 07:52:47 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2301EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 04:51:24 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d207so783527qkg.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 04:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g4n08dQJMaesgf8J0xabMK1i7+F7RpBHsMNZa6B0wFg=;
        b=kzWzPD2OTo3AoR3YUbcKUTvuPomBIwyHNutpylLO4dyxop9LNKyN83OOzTBf5xOfbG
         palrNbSl3yYDiHHkNdKTCkaUzLfPSjDceELxuIfSJDUODVmrHGOxwsPPEVhZ2XiXOlmu
         icto1EIK4b4TVOa0AYEFpqNsXTB3vn7QPZzOITfuaTlWDy+3cVheevaScmgyqm8RU8vO
         q7dnaiw19rTJJPTtIbJE5aepi2zTarHawu8cR4cXZeXI+6wLQaHZCDHR4k7awsZuArPC
         DrcCmM2+DynazvPFVqXCJ7MF41nk/2fh3tegc00LA/8ZjDQo+PBcxORZ8yBh8cTaWecq
         0NcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g4n08dQJMaesgf8J0xabMK1i7+F7RpBHsMNZa6B0wFg=;
        b=rldRbZE9mN2NOs4TfeuOo4m8FQNPUXO+v+Qac/K9Z5nKHgpdXaDxZyfAiMN13Z/cv3
         dbS75vN9xd17eoEiakCmQYp/dk7JKBEwCicXX7/H+/i1kJW8BLx5GtmlccoDQ+PFlONP
         J4culn24338lYDVIYMWip0gokYnr55LBpj3BeawlDPbLud6JqPG8u3QSZRtBhzSoPUpk
         MBTC214T/COMwRp2IPTYkCfbVDAm4R2ICZWUgvm3IYp4yYUn75VuVN9GZEmo7q8+Xpq8
         9W4Zs0dbD4+B18yoLsthlcJ5/vjmh/3VI360CBIPI2L2bc1dYtdJCQ7qtiN1NgPRLKMa
         M21A==
X-Gm-Message-State: AOAM5320MANS4myU9S6D6ysOFdGOfpwDlS0gVMG6wqPp8rjUI2qVHY5V
        9xW8vpUelRU3U1DlGbCMOFPNhQMtWLoX05RP63bjRw==
X-Google-Smtp-Source: ABdhPJw6nm/tu1SpaJKqigIsT+zeE1Q1htjNV3dad6CRknHLmXfrcki23xGNwNIDYw0HWj/iTdOC0pqCJ3mmdDzVrfs=
X-Received: by 2002:a37:f903:: with SMTP id l3mr14896801qkj.502.1631965883097;
 Sat, 18 Sep 2021 04:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210918083849.2696287-1-liushixin2@huawei.com>
In-Reply-To: <20210918083849.2696287-1-liushixin2@huawei.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Sat, 18 Sep 2021 13:50:47 +0200
Message-ID: <CAG_fn=X=k3w-jr3iCevB_t7Hh0r=qZ=nOxwk5ujsO+LZ7hA4Aw@mail.gmail.com>
Subject: Re: [PATCH] arm64: remove page granularity limitation from KFENCE
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Jisheng.Zhang@synaptics.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 10:10 AM Liu Shixin <liushixin2@huawei.com> wrote:
>
> Currently if KFENCE is enabled in arm64, the entire linear map will be
> mapped at page granularity which seems overkilled. Actually only the
> kfence pool requires to be mapped at page granularity. We can remove the
> restriction from KFENCE and force the linear mapping of the kfence pool
> at page granularity later in arch_kfence_init_pool().

There was a previous patch by Jisheng Zhang intended to remove this
requirement: https://lore.kernel.org/linux-arm-kernel/20210524180656.395e45=
f6@xhacker.debian/
Which of the two is more preferable?

> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  arch/arm64/include/asm/kfence.h | 69 ++++++++++++++++++++++++++++++++-
>  arch/arm64/mm/mmu.c             |  4 +-
>  2 files changed, 70 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfe=
nce.h
> index aa855c6a0ae6..bee101eced0b 100644
> --- a/arch/arm64/include/asm/kfence.h
> +++ b/arch/arm64/include/asm/kfence.h
> @@ -8,9 +8,76 @@
>  #ifndef __ASM_KFENCE_H
>  #define __ASM_KFENCE_H
>
> +#include <linux/kfence.h>
>  #include <asm/set_memory.h>
> +#include <asm/pgalloc.h>
>
> -static inline bool arch_kfence_init_pool(void) { return true; }
> +static inline int split_pud_page(pud_t *pud, unsigned long addr)
> +{
> +       int i;
> +       pmd_t *pmd =3D pmd_alloc_one(&init_mm, addr);
> +       unsigned long pfn =3D PFN_DOWN(__pa(addr));
> +
> +       if (!pmd)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < PTRS_PER_PMD; i++)
> +               set_pmd(pmd + i, pmd_mkhuge(pfn_pmd(pfn + i * PTRS_PER_PT=
E, PAGE_KERNEL)));
> +
> +       smp_wmb(); /* See comment in __pte_alloc */
> +       pud_populate(&init_mm, pud, pmd);
> +       flush_tlb_kernel_range(addr, addr + PUD_SIZE);
> +       return 0;
> +}
> +
> +static inline int split_pmd_page(pmd_t *pmd, unsigned long addr)
> +{
> +       int i;
> +       pte_t *pte =3D pte_alloc_one_kernel(&init_mm);
> +       unsigned long pfn =3D PFN_DOWN(__pa(addr));
> +
> +       if (!pte)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < PTRS_PER_PTE; i++)
> +               set_pte(pte + i, pfn_pte(pfn + i, PAGE_KERNEL));
> +
> +       smp_wmb(); /* See comment in __pte_alloc */
> +       pmd_populate_kernel(&init_mm, pmd, pte);
> +
> +       flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> +       return 0;
> +}
> +
> +static inline bool arch_kfence_init_pool(void)
> +{
> +       unsigned long addr;
> +       pgd_t *pgd;
> +       p4d_t *p4d;
> +       pud_t *pud;
> +       pmd_t *pmd;
> +
> +       for (addr =3D (unsigned long)__kfence_pool; is_kfence_address((vo=
id *)addr);
> +            addr +=3D PAGE_SIZE) {
> +               pgd =3D pgd_offset(&init_mm, addr);
> +               if (pgd_leaf(*pgd))
> +                       return false;
> +               p4d =3D p4d_offset(pgd, addr);
> +               if (p4d_leaf(*p4d))
> +                       return false;
> +               pud =3D pud_offset(p4d, addr);
> +               if (pud_leaf(*pud)) {
> +                       if (split_pud_page(pud, addr & PUD_MASK))
> +                               return false;
> +               }
> +               pmd =3D pmd_offset(pud, addr);
> +               if (pmd_leaf(*pmd)) {
> +                       if (split_pmd_page(pmd, addr & PMD_MASK))
> +                               return false;
> +               }
> +       }
> +       return true;
> +}
>
>  static inline bool kfence_protect_page(unsigned long addr, bool protect)
>  {
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index cfd9deb347c3..b2c79ccfb1c5 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -516,7 +516,7 @@ static void __init map_mem(pgd_t *pgdp)
>          */
>         BUILD_BUG_ON(pgd_index(direct_map_end - 1) =3D=3D pgd_index(direc=
t_map_end));
>
> -       if (can_set_direct_map() || crash_mem_map || IS_ENABLED(CONFIG_KF=
ENCE))
> +       if (can_set_direct_map() || crash_mem_map)
>                 flags |=3D NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>
>         /*
> @@ -1485,7 +1485,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>          * KFENCE requires linear map to be mapped at page granularity, s=
o that
>          * it is possible to protect/unprotect single pages in the KFENCE=
 pool.
>          */
> -       if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> +       if (can_set_direct_map())
>                 flags |=3D NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>
>         __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start)=
,
> --
> 2.18.0.huawei.25
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/20210918083849.2696287-1-liushixin2%40huawei.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
