Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C8230EB94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 05:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhBDEg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 23:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBDEgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 23:36:24 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840B6C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 20:35:44 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r38so1232163pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 20:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=4X92vLOYs5EboXzPezxnnsFVbPHhM0RsUWdLAfVqQj8=;
        b=b7f9edkSS1CUQqiYd8b7kD8v4BqIn9d96GehBcJSXSrKP8s0ON41z7MBkwLpqG1W3/
         f5XtrWyvhGZUywOeKpsAbRNybp+nhOC9vkBtWF5UQtnRlwGUf6oBxBsXyj/GI9mdyUQp
         Um7qho+ReGt4FyczzNTw0SWpsCGCO9NwFBp8c9xioIyWs/zXxITwgsD/E42HGmmiJ5mE
         xM3ODUMqINTGHZw2bvc5nOxLRPI2dEZ3MKgN6xxmJnE1BnBNIQHPLO+S7FuRRzY1CqJx
         Hg0sVQKgbx2cUaCcZU418kIaT7hkliyz/q6jCMRcACOFYYDTFJ7YNvsv9S7XgyLWelO0
         nUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=4X92vLOYs5EboXzPezxnnsFVbPHhM0RsUWdLAfVqQj8=;
        b=g3APeSr0l67AoFtcp02AM3+gmqBv3JbV3lko9x8Eq0r6jOyVkFLGkfbEt0Le//Jywe
         P8fwmHM4iBp1atcpman1sWgVcpmTHKSGLRjHv5sHDuOLDCj7uZF0/iRDhy9MURNPsKk8
         Qex61gWF0DI1Y8pyNbQw2WqkxHm1ywU8HvWKhVVU+R+QR1MzTfj9YF3Sq2Td6PtyrHQu
         AA4stTjyV6RdYYzu3Eu8c7q7sHbFylzzwV4z40ZEUIoWOo6mYDsu2gBJdBt4/Rd+7CVz
         iwUtC7dEDxqKPFvdTt3sEa4tVBC/eIu2AjJ5iHSxet1U52rONfmJt2vIbuOxzs7IMzq4
         xrtg==
X-Gm-Message-State: AOAM533CW87CRaWQsVJpjB0QpyXuMWjf3qaeZ+C9zYg51lUbY9VGpX3O
        86WSRkCrI9KhpXa5izSJk0BSUQ==
X-Google-Smtp-Source: ABdhPJzjQijeI77xOprY6nvP9sFHEzE1nBuKYQLzvoRgZg5eL/5d3b/qfEH7oRfT5kFntr9RT/Julg==
X-Received: by 2002:a63:c70c:: with SMTP id n12mr7176702pgg.347.1612413344069;
        Wed, 03 Feb 2021 20:35:44 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:d820:f724:6e86:8eec? ([2601:646:c200:1ef2:d820:f724:6e86:8eec])
        by smtp.gmail.com with ESMTPSA id g17sm4643834pgg.78.2021.02.03.20.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 20:35:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 15/20] mm: detect deferred TLB flushes in vma granularity
Date:   Wed, 3 Feb 2021 20:35:41 -0800
Message-Id: <2C897630-F042-45B3-8868-340B3A9FA49E@amacapital.net>
References: <846661D8-0963-4DCF-AE8D-1417064CB721@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        X86 ML <x86@kernel.org>
In-Reply-To: <846661D8-0963-4DCF-AE8D-1417064CB721@gmail.com>
To:     Nadav Amit <nadav.amit@gmail.com>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 2, 2021, at 12:52 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
> =EF=BB=BF
>>=20
>>> On Feb 1, 2021, at 4:14 PM, Andy Lutomirski <luto@amacapital.net> wrote:=

>>>=20
>>>=20
>>>> On Feb 1, 2021, at 2:04 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>>>=20
>>> Andy=E2=80=99s comments managed to make me realize this code is wrong. W=
e must
>>> call inc_mm_tlb_gen(mm) every time.
>>>=20
>>> Otherwise, a CPU that saw the old tlb_gen and updated it in its local
>>> cpu_tlbstate on a context-switch. If the process was not running when th=
e
>>> TLB flush was issued, no IPI will be sent to the CPU. Therefore, later
>>> switch_mm_irqs_off() back to the process will not flush the local TLB.
>>>=20
>>> I need to think if there is a better solution. Multiple calls to
>>> inc_mm_tlb_gen() during deferred flushes would trigger a full TLB flush
>>> instead of one that is specific to the ranges, once the flush actually t=
akes
>>> place. On x86 it=E2=80=99s practically a non-issue, since anyhow any upd=
ate of more
>>> than 33-entries or so would cause a full TLB flush, but this is still ug=
ly.
>>=20
>> What if we had a per-mm ring buffer of flushes?  When starting a flush, w=
e would stick the range in the ring buffer and, when flushing, we would read=
 the ring buffer to catch up.  This would mostly replace the flush_tlb_info s=
truct, and it would let us process multiple partial flushes together.
>=20
> I wanted to sleep on it, and went back and forth on whether it is the righ=
t
> direction, hence the late response.
>=20
> I think that what you say make sense. I think that I even tried to do once=

> something similar for some reason, but my memory plays tricks on me.
>=20
> So tell me what you think on this ring-based solution. As you said, you ke=
ep
> per-mm ring of flush_tlb_info. When you queue an entry, you do something
> like:
>=20
> #define RING_ENTRY_INVALID (0)
>=20
>  gen =3D inc_mm_tlb_gen(mm);
>  struct flush_tlb_info *info =3D mm->ring[gen % RING_SIZE];
>  spin_lock(&mm->ring_lock);

Once you are holding the lock, you should presumably check that the ring did=
n=E2=80=99t overflow while you were getting the lock =E2=80=94 if new_tlb_ge=
n > gen, abort.

>  WRITE_ONCE(info->new_tlb_gen, RING_ENTRY_INVALID);
>  smp_wmb();
>  info->start =3D start;
>  info->end =3D end;
>  info->stride_shift =3D stride_shift;
>  info->freed_tables =3D freed_tables;
>  smp_store_release(&info->new_tlb_gen, gen);
>  spin_unlock(&mm->ring_lock);
>=20

Seems reasonable.  I=E2=80=99m curious how this ends up getting used.

> When you flush you use the entry generation as a sequence lock. On overflo=
w
> of the ring (i.e., sequence number mismatch) you perform a full flush:
>=20
>  for (gen =3D mm->tlb_gen_completed; gen < mm->tlb_gen; gen++) {
>    struct flush_tlb_info *info =3D &mm->ring[gen % RING_SIZE];
>=20
>    // detect overflow and invalid entries
>    if (smp_load_acquire(info->new_tlb_gen) !=3D gen)
>        goto full_flush;
>=20
>    start =3D min(start, info->start);
>    end =3D max(end, info->end);
>    stride_shift =3D min(stride_shift, info->stride_shift);
>    freed_tables |=3D info.freed_tables;
>    smp_rmb();
>=20
>    // seqlock-like check that the information was not updated=20
>    if (READ_ONCE(info->new_tlb_gen) !=3D gen)
>        goto full_flush;
>  }
>=20
> On x86 I suspect that performing a full TLB flush would anyhow be the best=

> thing to do if there is more than a single entry. I am also not sure that i=
t
> makes sense to check the ring from flush_tlb_func_common() (i.e., in each
> IPI handler) as it might cause cache thrashing.
>=20
> Instead it may be better to do so from flush_tlb_mm_range(), when the
> flushes are initiated, and use an aggregated flush_tlb_info for the flush.=

>=20
> It may also be better to have the ring arch-independent, so it would
> resemble more of mmu_gather (the parts about the TLB flush information,
> without the freed pages stuff).
>=20
> We can detect deferred TLB flushes either by storing =E2=80=9Cdeferred_gen=
=E2=80=9D in the
> page-tables/VMA (as I did) or by going over the ring, from tlb_gen_complet=
ed
> to tlb_gen, and checking for an overlap. I think page-tables would be most=

> efficient/scalable, but perhaps going over the ring would be easier to
> understand logic.
>=20
> Makes sense? Thoughts?
