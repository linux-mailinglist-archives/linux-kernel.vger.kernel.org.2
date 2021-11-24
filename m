Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07C945B605
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240897AbhKXH7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbhKXH7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:59:35 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371B7C061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:56:26 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l16so2527488wrp.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VcjV0C2JAXQBDDMbeL+36DJY0eId/oRoFF8TPI/gCJ4=;
        b=vONA1Ak/5UD9tljIcxnytqMG5YKidkdZz2f3W5ZzKHTbuIByttaBV+eIc7p2lRydf/
         YJKoQqzF3ajYpF9yBD9eYQuneWienGrxoPW5+P6MN4yabn/h7mnTtgWquaITDNRI8R4H
         u0SqAqSeoqsrcAYYMu9BVVtq1JOTsb2a51bDv14M5s0238rw9P1n1ERe+Fvg4fPuVjfp
         Lecc3fyeqhMSPg8slhwX2Jn0yiXWqzuddt6/vxM3YWTlOiY211eCzQgK0xCn/Zuu51yl
         H3Zs3+BDIjy4emAs9OdZgbvx2RUwNmltWywZpMQrYILSRI+k4NR3+GbJ6VKvdZWcRObP
         UHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VcjV0C2JAXQBDDMbeL+36DJY0eId/oRoFF8TPI/gCJ4=;
        b=20A1M55UeytPhffjCQqFxKIvVGLAIaetl1D7AsOzvkh5GQ0Iav0wrNyZNSdrzWOo+M
         n0XQg38Xfa5xEBeRuT/zp3x6rVpDzuKXkGHP3XqCeDhD4DM+OjJaaq9mppFJ8htC574S
         KwEMIOdbGK7antJQ9kbY6/dg4WGWnWctxesEqC8OI83lv4G32efDceTdNa8KE1uVEBTd
         kmIk+OZPfBkonzsUb/PfkdTnftj2hF1L95wnCZvQmK9+Gp+xpphh19qqIoWgsopOq0SG
         Sya1id7Xfbo5sc7DeZkZJgCAmAvlJ93i391U2K7txvKE56dznPQzfOrKnLBKdlk7MSGQ
         aqug==
X-Gm-Message-State: AOAM533+SAVeZegh7o0HWf1O3xXv738xn5+twQXpgd2LBgDJGEE0x6YX
        cMMDDsqchquNy9cU3HP+GgSXCkWA5t3zLY8RDQpg3OO68V6QEClz
X-Google-Smtp-Source: ABdhPJwClJrX6knE8UTXut3s66kbbEuDAMqdQwXZqQSH7GKDBVNtaOB2rrww6+y9qLtab1P5o7Gg1d/oHpIJdpt7us4=
X-Received: by 2002:a05:6000:168e:: with SMTP id y14mr15173772wrd.331.1637740584557;
 Tue, 23 Nov 2021 23:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20211124060521.614015-1-guoren@kernel.org> <CAAhSdy1CZbdAPEYxFOhrn=wUcmc9Yea0ziMUmHjaudKdH2Yw1w@mail.gmail.com>
 <CAJF2gTRAXAmo4cVSfArf=eMU9CxXZr3kjaKcQ1u8764cnL+N_Q@mail.gmail.com>
In-Reply-To: <CAJF2gTRAXAmo4cVSfArf=eMU9CxXZr3kjaKcQ1u8764cnL+N_Q@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 24 Nov 2021 13:26:13 +0530
Message-ID: <CAAhSdy2_Vk5nPMUOni5JctV8Jd9NYh-WK=yZPXTN_yzaNdy-4g@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fixup one-page wasting
To:     Guo Ren <guoren@kernel.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Atish Patra <Atish.Patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 12:52 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Nov 24, 2021 at 2:55 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Wed, Nov 24, 2021 at 11:35 AM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > For small memory systems(Allwinner D1s/F133), one page size memory
> > > cannot be ignored.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Cc: Alexandre Ghiti <alex@ghiti.fr>
> > > Cc: Anup Patel <anup@brainfault.org>
> > > Cc: Atish Patra <Atish.Patra@wdc.com>
> >
> > This PATCH breaks the CPU hotplug functionality.
> >
> > When a CPU/HART is turned off and turned on at runtime, the
> > low-level relocate() will be called to enable MMU on the CPU
> > being brought-up which in-turn uses trampoline_pg_dir.
> Yeah, I forgot that.
>
> How about removing trampoline_pg_dir totally and using
> early_pg_dir/swapper_pg_dir for relocate directly?

The trampoline_pg_dir is to handle the case when RAM is
large enough such that RAM physical address range overlaps
kernel virtual address range (i.e. VA >= PAGE_OFFSET). This
is overlap of virtual address range and physical address range
can be problematic for low-level code which is trying to enable
MMU (such as the relocate() function).

Here's a old kernel thread which tries to summarize this:
https://lore.kernel.org/lkml/CAAhSdy3URWHVY_GPNb2yRBuctRELRtTTWPM2OpwUVSRFAyXyiA@mail.gmail.com/

Regards,
Anup

>
> >
> > Regards,
> > Anup
> >
> > > ---
> > >  arch/riscv/mm/init.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index 24b2b8044602..097bb3bc4020 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -241,9 +241,9 @@ unsigned long riscv_pfn_base __ro_after_init;
> > >  EXPORT_SYMBOL(riscv_pfn_base);
> > >
> > >  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> > > -pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> > >  static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
> > >
> > > +pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
> > >  pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
> > >  static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
> > >
> > > --
> > > 2.25.1
> > >
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
