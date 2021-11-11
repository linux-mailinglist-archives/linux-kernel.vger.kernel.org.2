Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F4144D596
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhKKLOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhKKLOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:14:31 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644DDC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 03:11:42 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id i6so11024567uae.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 03:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rd8f8WRpMktJEX9D5RQAXplnhjjqVXveRVmq5lp6uzk=;
        b=YCphi/Zvmf3SZvO0xLJJy+uodAmehuHe9mSfm4tsYEYUEGMl00DAIc0CNFMm34LoRd
         b1uSED2ruIMIgtvREuJdSGI28K6tIAK0Kk1AsWknuFkEH20eL0gtsaNQqdN9UDdwbVBJ
         6CWdq3F40LL2Dja8+TBBysIsGy/l49gmJRGNgvUX+JYLhTYVAXJ22PYH6+FMs45DojRM
         bZJjO+c5oeJlPdTXTssoDcesnu654cDNkGg3GgPekNHd9Qfp8/adFZQCYW6H+DcbVqNm
         ruIGTcj1sd5wr3jKKSg2gaSgREoSoIFhPUUNkxmRmZ319AElrH21ZzAA50h32cqDocTF
         eF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rd8f8WRpMktJEX9D5RQAXplnhjjqVXveRVmq5lp6uzk=;
        b=ha8kTVBobbrx4xOnZO7hWq4lIA1DPnfp8F23h4ODpD3LuQjwVgHT6tCd4EzH/ptDXX
         jdgfiZXRmfg4b8WUog9Q4L7GD0ss6VSp3QCeAIynAM1yVUTit1Mjkes4eYuGRY3LZHEN
         uNbRiFYPESQpNh5P6XlBiCb504ND7tH8Wtt2ZylqNqeCrKt58QlleoSaD/uQBU3c+gUB
         VIoIT2j+ni+w0g/4WdfyXuvkoriiVHmo1XSrVL0zb10GKVSpPORQbTHNnyAZ7hey3KO+
         R7UcoSyC3NMJ3C3VuoKvWLDbZanXD69bROqcZdXuunr37ukG/RoQpRHCHyEA92akvo4U
         k1EA==
X-Gm-Message-State: AOAM533ER67QYdilJNMpOD21g+8/jFYVjjd5Qsu1+E8Erd0ZBGfQU7U7
        mu43foDSgbj274mf4e0PtZ8T0rczyQqvgP1qWPc8NQ==
X-Google-Smtp-Source: ABdhPJxP5ABXat5DxnXQteuBu8DiUygI1NLxYAywdmuESE0qDoONGynY5NMqUpI4aXGa4FCGTBPdRlGWRdCS4wQ2jiA=
X-Received: by 2002:a67:ee88:: with SMTP id n8mr9576188vsp.58.1636629101227;
 Thu, 11 Nov 2021 03:11:41 -0800 (PST)
MIME-Version: 1.0
References: <20211111041510.402534-1-yuzhao@google.com> <20211111041510.402534-2-yuzhao@google.com>
 <20211111085907.GA5407@willie-the-truck>
In-Reply-To: <20211111085907.GA5407@willie-the-truck>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 11 Nov 2021 04:11:29 -0700
Message-ID: <CAOUHufZriWxEaYNmQaOGF26Bxv-2qOwLFpK_NhmL-GDVLtFDJw@mail.gmail.com>
Subject: Re: [PATCH v5 01/10] mm: x86, arm64: add arch_has_hw_pte_young()
To:     Will Deacon <will@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        page-reclaim@google.com, holger@applied-asynchrony.com,
        iam@valdikss.org.ru, Konstantin Kharlamov <hi-angel@yandex.ru>,
        catalin.marinas@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 1:59 AM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Nov 10, 2021 at 09:15:01PM -0700, Yu Zhao wrote:
> > Some architectures automatically set the accessed bit in PTEs, e.g.,
> > x86 and arm64 v8.2. On architectures that do not have this capability,
> > clearing the accessed bit in a PTE triggers a page fault following the
> > TLB miss of this PTE.
> >
> > Being aware of this capability can help make better decisions, i.e.,
> > whether to limit the size of each batch of PTEs and the burst of
> > batches when clearing the accessed bit.
> >
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> > ---
> >  arch/arm64/include/asm/cpufeature.h |  5 +++++
> >  arch/arm64/include/asm/pgtable.h    | 13 ++++++++-----
> >  arch/arm64/kernel/cpufeature.c      | 10 ++++++++++
> >  arch/arm64/tools/cpucaps            |  1 +
> >  arch/x86/include/asm/pgtable.h      |  6 +++---
> >  include/linux/pgtable.h             | 13 +++++++++++++
> >  mm/memory.c                         | 14 +-------------
> >  7 files changed, 41 insertions(+), 21 deletions(-)
>
> *Please* cc the maintainers on arch patches. I asked you that last time,
> too:
>
> https://lore.kernel.org/r/20210819091923.GA15467@willie-the-truck
>
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 6ec7036ef7e1..940615d33845 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2157,6 +2157,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> >               .matches = has_hw_dbm,
> >               .cpu_enable = cpu_enable_hw_dbm,
> >       },
> > +     {
> > +             .desc = "Hardware update of the Access flag",
> > +             .type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > +             .capability = ARM64_HW_AF,
> > +             .sys_reg = SYS_ID_AA64MMFR1_EL1,
> > +             .sign = FTR_UNSIGNED,
> > +             .field_pos = ID_AA64MMFR1_HADBS_SHIFT,
> > +             .min_field_value = 1,
> > +             .matches = has_cpuid_feature,
> > +     },
>
> As before, please don't make this a system feature as it will prohibit
> onlining of late CPUs with mismatched access flag support and I really
> don't see that being necessary.
>
> You should just be able to use arch_faults_on_old_pte() as-is.

Well, I did explain why last time and there weren't any pushbacks
after I listed my reasons:

1) there is no known hardware that does this, i.e., having mismatching
accessed bit capabilities.
2) there are no foreseeable benefits in supporting such a theoretical use case

There are many other opportunities ARM could explore, e.g., supporting
the accessed bit on non-leaf entries as x86 has been for decades.
Dwelling on this theoretical use case, IMO, is just a typical example
of overengineering.

But I do hear you -- as I mentioned last time, I don't have a problem
with doing it your way. Please touch on the two points I raised so
that I know where we stand. Otherwise I might again assume I've
convinced you to do it my way :)

Also why should I be able to use arch_faults_on_old_pte() as-is? This
implies we can make the following decisions based on the same
information.
1) set the accessed bit since the CPU we are running on won't do it for us
2) don't clear the accessed bit on too many entries since the CPU we
are running on will have a page fault upon seeing cleared accessed bit
on an entry
Are there conditions equivalent? Technically no, but it probably would
make no difference anyway.

My real problem with arch_faults_on_old_pte() is that it needs to be
called with preemption disabled. Again, IMO, a static branch for such
a common capability (from x86 perspective) is a no-brainer, because
there is zero return on investment in leaving the door open for
mismatching accessed bit capabilities.
