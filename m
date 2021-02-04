Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969A230EADB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 04:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhBDDVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 22:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhBDDVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:21:10 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E98C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 19:20:30 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o63so1160758pgo.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 19:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Avw1TvqUwwHus+EY+wpOA2zHC5567oW2FndNzavcGMs=;
        b=a1lFTIeFdl1IMuLaJ7vUSL/IHJb7veyblDNBwyc22xfZ75e9D+Qdn5TD6UuaEp0ayJ
         S7sjPNgj71rM8MI8XTAD/nqDHWma+NQPoAubY/qRTW2Na+x+QPP59WUqm+/Fwn9Leqpg
         3n9O2SzSF17JgBOHAfeC0BFIaac0j607pV3J0KJc97AN8Curd/e77qGwMPoDkj5hJJEJ
         64ZK8MwdVvEfgFlDSWmIeBQ0M8u3AOs4HznxpX2eo7ABy3yE72qGs0aUcFJEADXujyes
         g9vg10dz2OkBfjfmnuETKW1OfadT0JZyUVXlpLZgfoUTq+xl8xxsmkabkp5GE/IHNXpf
         +6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Avw1TvqUwwHus+EY+wpOA2zHC5567oW2FndNzavcGMs=;
        b=TlApq8mzUfg8wnHgrpoSRroF36ja7Cj7vC6qF32eu14hRiFRsc5x4uBsWXR8drFMzF
         dQ6vbzV1TIO8nP+4Ejaj2z3QmNfMm4A3pLA9T13TbF3YqZ4rbTChCLzCi1ZcyMunDJNX
         PWHE6FiQBHxoovTyj4wb7+v16IqFSQqlxc6xF0IxeCrgGgYcnhETyy4XH8f0Vr/KXMZO
         fpVcCO6NrbH5G2VQj+JtfKcGqLYHV+7/fEABjyq5wGr8ZEI6UzmC/Nm/yLFZZWikjayT
         2kJ7RGdKCgDsPpSEpfAUEgFYN1Xxd5HGsvyaBIV8T4hddp20NYNCopwMXGByosWGIx0Y
         szdA==
X-Gm-Message-State: AOAM533ypaRGHRLJumVXkHE0gfUVGuVmdGKp/KDeO0614Unf047gWQmk
        xwESlfTNmFc3oRrirU8Hvs0=
X-Google-Smtp-Source: ABdhPJwVtlCJKPyKiEzTVjy3HD2y12zdzMlEF//8xAMCROr1/HklX1eIFL9MWntKUqjeUWGFccIX/g==
X-Received: by 2002:a63:c702:: with SMTP id n2mr6734803pgg.382.1612408829510;
        Wed, 03 Feb 2021 19:20:29 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id y6sm3667118pfn.123.2021.02.03.19.20.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 19:20:28 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC 01/20] mm/tlb: fix fullmm semantics
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20210203094459.GA18493@willie-the-truck>
Date:   Wed, 3 Feb 2021 19:20:26 -0800
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Zhao <yuzhao@google.com>, Nick Piggin <npiggin@gmail.com>,
        X86 ML <x86@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3EA63C0E-3420-4194-AA4F-A05A0B0AFF95@gmail.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-2-namit@vmware.com>
 <YBfntzMgNlMDOP9s@hirez.programming.kicks-ass.net>
 <52673507-2C30-4AC6-8EBC-B5A313827FB0@gmail.com>
 <YBkwyEL2FKxlsgZ5@hirez.programming.kicks-ass.net>
 <5E9B0429-7E72-4E86-B91B-4718C4134B0F@gmail.com>
 <20210203094459.GA18493@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 3, 2021, at 1:44 AM, Will Deacon <will@kernel.org> wrote:
>=20
> On Tue, Feb 02, 2021 at 01:35:38PM -0800, Nadav Amit wrote:
>>> On Feb 2, 2021, at 3:00 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>>=20
>>> On Tue, Feb 02, 2021 at 01:32:36AM -0800, Nadav Amit wrote:
>>>>> On Feb 1, 2021, at 3:36 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>>>>=20
>>>>>=20
>>>>> https://lkml.kernel.org/r/20210127235347.1402-1-will@kernel.org
>>>>=20
>>>> I have seen this series, and applied my patches on it.
>>>>=20
>>>> Despite Will=E2=80=99s patches, there were still inconsistencies =
between fullmm
>>>> and need_flush_all.
>>>>=20
>>>> Am I missing something?
>>>=20
>>> I wasn't aware you were on top. I'll look again.
>>=20
>> Looking on arm64=E2=80=99s tlb_flush() makes me think that there is =
currently a bug
>> that this patch fixes. Arm64=E2=80=99s tlb_flush() does:
>>=20
>>       /*
>>        * If we're tearing down the address space then we only care =
about
>>        * invalidating the walk-cache, since the ASID allocator won't
>>        * reallocate our ASID without invalidating the entire TLB.
>>        */
>>       if (tlb->fullmm) {
>>               if (!last_level)
>>                       flush_tlb_mm(tlb->mm);
>>               return;
>>       }=20
>>=20
>> But currently tlb_mmu_finish() can mistakenly set fullmm incorrectly =
(if
>> mm_tlb_flush_nested() is true), which might skip the TLB flush.
>=20
> But in that case isn't 'freed_tables' set to 1, so 'last_level' will =
be
> false and we'll do the flush in the code above?

Indeed. You are right. So no rush.=
