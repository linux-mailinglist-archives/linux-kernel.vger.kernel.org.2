Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F43333CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhCJMl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:41:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhCJMl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:41:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D99464FE5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615380088;
        bh=f+YgqVr0L2oHebaFxvBEhuo3MZHnaLfKLLHAywKNOqk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KYtSSwhfRR0rAYrzA5MdZ8VmX0tWHJ5q5cTvaqlIolJi+V0MffxiNQXeSDzl12BsS
         RZfRx4r1ZAVex8p71QB7ase+IMaa/OIPxvmwsyHDuUL+wgXSdKys9eloPUOhiKaVfw
         yfi4XIDmtJE73UKaOvBZjtuuab3pzGzJTdBxA+mDCG2PhcqNoA6IJ1g3Ut05cj6pQQ
         crmNnwNUM1z2JA/aweFrk04E9DZmIcer7kw19xdLhgGAKQ4l6/bqBN9HmIcWGLv1QA
         SRMj6XEuKpR4EnSPEvYFX4goV79sAwgCsB4lw7ur5inTXpxmbCuEUTKLHiEc9LY0nl
         x71a0vh4A6tcA==
Received: by mail-ot1-f41.google.com with SMTP id f8so11172519otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:41:28 -0800 (PST)
X-Gm-Message-State: AOAM533zl15ch510mjx18L0js15xrNVX1KOMBKJx1QzSzh0/Z7xBHs+W
        h2fxOOzYNfuiIhxnU3uIQRItGVUmCgXElcgVmbU=
X-Google-Smtp-Source: ABdhPJxODq5RDbRk0wzzsh+DKisSMdeikcI11xOweFvStxpZcJUP8Ncwcll4zJe7bxValgoczajqpU/fXB6fxBakimQ=
X-Received: by 2002:a9d:6e15:: with SMTP id e21mr1398007otr.77.1615380087833;
 Wed, 10 Mar 2021 04:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20210310003216.410037-1-msalter@redhat.com> <20210310111649.GA29413@willie-the-truck>
In-Reply-To: <20210310111649.GA29413@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 10 Mar 2021 13:41:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH52Y7YAzVfMGbOntXcDP4S=P7kLuvwA0Twh7odbdgyoQ@mail.gmail.com>
Message-ID: <CAMj1kXH52Y7YAzVfMGbOntXcDP4S=P7kLuvwA0Twh7odbdgyoQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: fix runtime fallback to 48-bt VA when 52-bit
 VA is enabled
To:     Will Deacon <will@kernel.org>
Cc:     Mark Salter <msalter@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 at 12:18, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Mar 09, 2021 at 07:32:16PM -0500, Mark Salter wrote:
> > I ran into an early boot soft lockup on a Qualcomm Amberwing using a v5.11
> > kernel configured for 52-bit VA. This turned into a panic with a v5.12-rc2
> > kernel.
> >
> > The problem is that when we fall back to 48-bit VA, idmap_t0sz is not
> > updated. Later, the kvm hypervisor uses idmap_t0sz to set its tcr_el2 and
> > hangs (v5.11). After commit 1401bef703a4 ("arm64: mm: Always update TCR_EL1
> > from __cpu_set_tcr_t0sz()"), the kernel panics when trying to use the idmap
> > to call idmap_cpu_replace_ttbr1().
> >
> > Oddly, other systems (thunderX2 and Ampere eMag) which don't support 52-bit
> > VA seem to handle the setting of an unsupported t0sz without any apparent
> > problems. Indeed, if one reads back the tcr written with t0sz==12, the
> > value read has t0sz==16. Not so with Amberwing.
>
> Nice, you have one of those elusive platforms!
>
> > Fixes: 90ec95cda91a ("arm64: mm: Introduce VA_BITS_MIN")
> > Signed-off-by: Mark Salter <msalter@redhat.com>
> > ---
> >  arch/arm64/kernel/head.S | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index 66b0e0b66e31..2bcbbb26292e 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -291,6 +291,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
> >        */
> >       adrp    x0, idmap_pg_dir
> >       adrp    x3, __idmap_text_start          // __pa(__idmap_text_start)
> > +     mov     x4, TCR_T0SZ(VA_BITS)
> >
> >  #ifdef CONFIG_ARM64_VA_BITS_52
> >       mrs_s   x6, SYS_ID_AA64MMFR2_EL1
> > @@ -299,6 +300,13 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
> >       cbnz    x6, 1f
> >  #endif
> >       mov     x5, #VA_BITS_MIN
> > +#ifdef CONFIG_ARM64_VA_BITS_52
> > +     mov     x4, TCR_T0SZ(VA_BITS_MIN)
> > +     adr_l   x6, idmap_t0sz
> > +     str     x4, [x6]
> > +     dmb     sy
> > +     dc      ivac, x6                // Invalidate potentially stale cache line
> > +#endif
> >  1:
> >       adr_l   x6, vabits_actual
> >       str     x5, [x6]
> > @@ -319,7 +327,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
> >        */
> >       adrp    x5, __idmap_text_end
> >       clz     x5, x5
> > -     cmp     x5, TCR_T0SZ(VA_BITS)   // default T0SZ small enough?
> > +     cmp     x5, x4                  // default T0SZ small enough?
> >       b.ge    1f                      // .. then skip VA range extension
>
> Could we instead have the default value be 48-bit, and then avoid having
> to update the variable in both cases? e.g. something along the lines of
> the entirely untested diff below?
>

There is one other occurrence that needs to be updated. I will have a
stab at fixing this along these lines, and there are a couple of other
things that need cleaning up.



> --->8
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 66b0e0b66e31..fb795123896f 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -319,7 +319,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>          */
>         adrp    x5, __idmap_text_end
>         clz     x5, x5
> -       cmp     x5, TCR_T0SZ(VA_BITS)   // default T0SZ small enough?
> +       cmp     x5, TCR_T0SZ(VA_BITS_MIN)       // default T0SZ small enough?
>         b.ge    1f                      // .. then skip VA range extension
>
>         adr_l   x6, idmap_t0sz
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 3802cfbdd20d..4c5603c41870 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -40,7 +40,7 @@
>  #define NO_BLOCK_MAPPINGS      BIT(0)
>  #define NO_CONT_MAPPINGS       BIT(1)
>
> -u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
> +u64 idmap_t0sz = TCR_T0SZ(VA_BITS_MIN);
>  u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
>
>  u64 __section(".mmuoff.data.write") vabits_actual;
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
