Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464AA30B3FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhBBAQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBBAP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:15:56 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50A7C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 16:15:00 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id b21so13578583pgk.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 16:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=c8//MWYPxllDiS7aiVWvuvZ5u+o3Llfwk59pxO392CA=;
        b=wcbV8xCkVuGdJEFtGv7Xqp2eeynTTNbHizH/im84FIh/EIpCJzQ7zYjYIa9eBay/zD
         H9zwuRAS2FRyJ6a0ktEVZLEO/NRXvbxRjIglMZ9hjl1AVzIECg93uRXgNd/ifpB0XLvn
         VdhgySsn7/9NEzA0jo65SYPTJKi3NBJDVwa9QJ8O0YW06GTjWqNdakvOFFgLPoTkeZt0
         03RRj/7aGLwp+7jl0sH3xlmBHcvGPWMEHYpzkbvxzGfgxR+vSNMQg1AYZFE0xKT9A62m
         L+dUQA/X1ahqSIQ3jvfp8T9WxpUbD/xOTEd6EcetqxseBPMNIY2Toos6p+tbh8bd/c08
         YZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=c8//MWYPxllDiS7aiVWvuvZ5u+o3Llfwk59pxO392CA=;
        b=WyE4wG8zhcNpfpW8u0cQZNdBkrVTnTirmGZ/43Y/ds4zqfszF4f/Oz2gWzT0lMhr11
         Zudoqd78ZmkwqGUZffj0j1a88H9wLOHqVVXK6vuAEwNxdsUXl2XYRJQGLuM+4xGFjVg/
         YvXoTym1L7hHOTsgEU0IE7YI0UK1+u1Ci4l1gCf4Q1EZajSnH1LlwbFcNmS3i423HL+E
         NxlHPjvgv1/PAA+NbygMqMgADW6dn9mhLapdJ+DStQAoyqFhy19g4qdMizw2vKz+N0iF
         3CeJR0UTTuw1f6lTwB6WBGgjklwRdJZUZHaUFDt3Mr1j3gXhHGHC/3h069mQyxQsyjZ5
         jDGw==
X-Gm-Message-State: AOAM5315NWhOMWq2KhN3qV2Dn491YVYNtRM+6Zq2zIiVAQNMdywkzFuY
        1+xRJmcaNzsEFBxCZnfP1cdBdw==
X-Google-Smtp-Source: ABdhPJw53jcn5hSuIG8ub4KmD6MDqHvXydl0r2qjhnl1FjYpKiDzNi4jrAIH68xn7NOoahHTgkQgsg==
X-Received: by 2002:a62:7acf:0:b029:1bd:e13a:fdbc with SMTP id v198-20020a627acf0000b02901bde13afdbcmr19006548pfc.52.1612224900461;
        Mon, 01 Feb 2021 16:15:00 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:117a:7890:cdb4:ef1c? ([2601:646:c200:1ef2:117a:7890:cdb4:ef1c])
        by smtp.gmail.com with ESMTPSA id x8sm564282pjf.55.2021.02.01.16.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 16:14:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 15/20] mm: detect deferred TLB flushes in vma granularity
Date:   Mon, 1 Feb 2021 16:14:58 -0800
Message-Id: <8F37526F-8189-483A-A16E-E0EB8662AD98@amacapital.net>
References: <A6E4897D-8D5A-4084-8288-8E43F3039921@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        X86 ML <x86@kernel.org>
In-Reply-To: <A6E4897D-8D5A-4084-8288-8E43F3039921@gmail.com>
To:     Nadav Amit <nadav.amit@gmail.com>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 1, 2021, at 2:04 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> On Jan 30, 2021, at 4:11 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>>=20
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Currently, deferred TLB flushes are detected in the mm granularity: if
>> there is any deferred TLB flush in the entire address space due to NUMA
>> migration, pte_accessible() in x86 would return true, and
>> ptep_clear_flush() would require a TLB flush. This would happen even if
>> the PTE resides in a completely different vma.
>=20
> [ snip ]
>=20
>> +static inline void read_defer_tlb_flush_gen(struct mmu_gather *tlb)
>> +{
>> +    struct mm_struct *mm =3D tlb->mm;
>> +    u64 mm_gen;
>> +
>> +    /*
>> +     * Any change of PTE before calling __track_deferred_tlb_flush() mus=
t be
>> +     * performed using RMW atomic operation that provides a memory barri=
ers,
>> +     * such as ptep_modify_prot_start().  The barrier ensure the PTEs ar=
e
>> +     * written before the current generation is read, synchronizing
>> +     * (implicitly) with flush_tlb_mm_range().
>> +     */
>> +    smp_mb__after_atomic();
>> +
>> +    mm_gen =3D atomic64_read(&mm->tlb_gen);
>> +
>> +    /*
>> +     * This condition checks for both first deferred TLB flush and for o=
ther
>> +     * TLB pending or executed TLB flushes after the last table that we
>> +     * updated. In the latter case, we are going to skip a generation, w=
hich
>> +     * would lead to a full TLB flush. This should therefore not cause
>> +     * correctness issues, and should not induce overheads, since anyhow=
 in
>> +     * TLB storms it is better to perform full TLB flush.
>> +     */
>> +    if (mm_gen !=3D tlb->defer_gen) {
>> +        VM_BUG_ON(mm_gen < tlb->defer_gen);
>> +
>> +        tlb->defer_gen =3D inc_mm_tlb_gen(mm);
>> +    }
>> +}
>=20
> Andy=E2=80=99s comments managed to make me realize this code is wrong. We m=
ust
> call inc_mm_tlb_gen(mm) every time.
>=20
> Otherwise, a CPU that saw the old tlb_gen and updated it in its local
> cpu_tlbstate on a context-switch. If the process was not running when the
> TLB flush was issued, no IPI will be sent to the CPU. Therefore, later
> switch_mm_irqs_off() back to the process will not flush the local TLB.
>=20
> I need to think if there is a better solution. Multiple calls to
> inc_mm_tlb_gen() during deferred flushes would trigger a full TLB flush
> instead of one that is specific to the ranges, once the flush actually tak=
es
> place. On x86 it=E2=80=99s practically a non-issue, since anyhow any updat=
e of more
> than 33-entries or so would cause a full TLB flush, but this is still ugly=
.
>=20

What if we had a per-mm ring buffer of flushes?  When starting a flush, we w=
ould stick the range in the ring buffer and, when flushing, we would read th=
e ring buffer to catch up.  This would mostly replace the flush_tlb_info str=
uct, and it would let us process multiple partial flushes together.=
