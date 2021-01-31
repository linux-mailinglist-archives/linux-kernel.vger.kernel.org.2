Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6103309999
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhAaBSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhAaBSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:18:15 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE2DC061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:17:35 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 8so2626863plc.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TVAc/O4BQg40Zvd5wwprmJLnqrBGfA6RYSuDOYbL/4Y=;
        b=KoluyyXdtETTHNX66nK0bhp5C7D+4iJnvV+Sh2JJQ9IntaD25EraRDo0uus6cYrHHk
         Z7j8AgMsbs/iYF0ytpMGeXibMrjk+LGg3zi4zCoKX3tQy5qfBhJDikCkflQ1LxBwNq8x
         3YbPfnlVxYPJ+yDzqeGPAeTO7+xKnWweYAP9g5IPB+Y/6fFe99CVQvUUM1Og5Tz4bMpx
         Ho3WhoIOBmkEDkpt3re1bco5nr6d0QTQodXGpBRRJbRYYd1Ctm18hEDjOh8t/D93aoAt
         0nmLx/IcPkv4QAGIZYyp3d/vfQJTMYvni5wjS3g3C1a+jctBBh9k0zWd/pT1TQVXu6qH
         8jDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TVAc/O4BQg40Zvd5wwprmJLnqrBGfA6RYSuDOYbL/4Y=;
        b=QqOmssawCgGPRu0rHGbvy5rWCvHbjSrAQiO0pJXs2csdY2I4xYiWQVK6YRltpmM7if
         qYL3E8qJ5cJmr4xirBTxFQ0ONEB6QYpnJq75MQ8ToZURWs2jh0lleDkmonXRPXYkqzQd
         l9t50PAu8RwJhsISGrJ6kOvtD9mfY9DqcZSciTTBeqqqyKxuh40nl+BXcce20vsdUY4j
         prUXvEuJ2Pi3YS3/Y1RYZ4pnIYrcs0TgqZCV8lVKW2+SaBtBGQXLbVyJ1nq6XCSxSPCX
         JSI1bNA5b4wefP9MOMzDmYhfzl9Rn912jFtoGAT1YnNF/BJsm8maJPGBzKqvlHLuKCB9
         o3UQ==
X-Gm-Message-State: AOAM533lECZ+OUA2JDUV7D7Ns18HtA48Nv7QWAzE6Ley1ihKvQcZrSWP
        LGfF2X/IBmM4qnwMqF7yArw=
X-Google-Smtp-Source: ABdhPJw6Cn2YL+xxNnKPOYM1u/zRC4Z1Ao8ivjdXT4i17YveNo2HWBMIGvoPgrk6ZiirJ8qfUcwIzQ==
X-Received: by 2002:a17:902:c381:b029:e1:54b8:921 with SMTP id g1-20020a170902c381b02900e154b80921mr63551plg.40.1612055854346;
        Sat, 30 Jan 2021 17:17:34 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id j6sm12781913pfg.159.2021.01.30.17.17.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jan 2021 17:17:33 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC 03/20] mm/mprotect: do not flush on permission promotion
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrWxyMsD5zEoaFS-aVfkV=QiVWa7pCU_JE3AYDEEU8Hqvg@mail.gmail.com>
Date:   Sat, 30 Jan 2021 17:17:31 -0800
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <68D3C593-A88C-4100-90E9-E90F7733344F@gmail.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-4-namit@vmware.com>
 <CALCETrWxyMsD5zEoaFS-aVfkV=QiVWa7pCU_JE3AYDEEU8Hqvg@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 30, 2021, at 5:07 PM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> Adding Andrew Cooper, who has a distressingly extensive understanding
> of the x86 PTE magic.
>=20
> On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> =
wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Currently, using mprotect() to unprotect a memory region or uffd to
>> unprotect a memory region causes a TLB flush. At least on x86, as
>> protection is promoted, no TLB flush is needed.
>>=20
>> Add an arch-specific pte_may_need_flush() which tells whether a TLB
>> flush is needed based on the old PTE and the new one. Implement an =
x86
>> pte_may_need_flush().
>>=20
>> For x86, besides the simple logic that PTE protection promotion or
>> changes of software bits does require a flush, also add logic that
>> considers the dirty-bit. If the dirty-bit is clear and write-protect =
is
>> set, no TLB flush is needed, as x86 updates the dirty-bit atomically
>> on write, and if the bit is clear, the PTE is reread.
>>=20
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Yu Zhao <yuzhao@google.com>
>> Cc: Nick Piggin <npiggin@gmail.com>
>> Cc: x86@kernel.org
>> ---
>> arch/x86/include/asm/tlbflush.h | 44 =
+++++++++++++++++++++++++++++++++
>> include/asm-generic/tlb.h       |  4 +++
>> mm/mprotect.c                   |  3 ++-
>> 3 files changed, 50 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/x86/include/asm/tlbflush.h =
b/arch/x86/include/asm/tlbflush.h
>> index 8c87a2e0b660..a617dc0a9b06 100644
>> --- a/arch/x86/include/asm/tlbflush.h
>> +++ b/arch/x86/include/asm/tlbflush.h
>> @@ -255,6 +255,50 @@ static inline void arch_tlbbatch_add_mm(struct =
arch_tlbflush_unmap_batch *batch,
>>=20
>> extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch =
*batch);
>>=20
>> +static inline bool pte_may_need_flush(pte_t oldpte, pte_t newpte)
>> +{
>> +       const pteval_t ignore_mask =3D _PAGE_SOFTW1 | _PAGE_SOFTW2 |
>> +                                    _PAGE_SOFTW3 | _PAGE_ACCESSED;
>=20
> Why is accessed ignored?  Surely clearing the accessed bit needs a
> flush if the old PTE is present.

I am just following the current scheme in the kernel (x86):

int ptep_clear_flush_young(struct vm_area_struct *vma,
                           unsigned long address, pte_t *ptep)
{
        /*
         * On x86 CPUs, clearing the accessed bit without a TLB flush
         * doesn't cause data corruption. [ It could cause incorrect
         * page aging and the (mistaken) reclaim of hot pages, but the
         * chance of that should be relatively low. ]
         *
         * So as a performance optimization don't flush the TLB when
         * clearing the accessed bit, it will eventually be flushed by
         * a context switch or a VM operation anyway. [ In the rare
         * event of it not getting flushed for a long time the delay
         * shouldn't really matter because there's no real memory
         * pressure for swapout to react to. ]
         */
        return ptep_test_and_clear_young(vma, address, ptep);
}


>=20
>> +       const pteval_t enable_mask =3D _PAGE_RW | _PAGE_DIRTY | =
_PAGE_GLOBAL;
>> +       pteval_t oldval =3D pte_val(oldpte);
>> +       pteval_t newval =3D pte_val(newpte);
>> +       pteval_t diff =3D oldval ^ newval;
>> +       pteval_t disable_mask =3D 0;
>> +
>> +       if (IS_ENABLED(CONFIG_X86_64) || IS_ENABLED(CONFIG_X86_PAE))
>> +               disable_mask =3D _PAGE_NX;
>> +
>> +       /* new is non-present: need only if old is present */
>> +       if (pte_none(newpte))
>> +               return !pte_none(oldpte);
>> +
>> +       /*
>> +        * If, excluding the ignored bits, only RW and dirty are =
cleared and the
>> +        * old PTE does not have the dirty-bit set, we can avoid a =
flush. This
>> +        * is possible since x86 architecture set the dirty bit =
atomically while
>=20
> s/set/sets/
>=20
>> +        * it caches the PTE in the TLB.
>> +        *
>> +        * The condition considers any change to RW and dirty as not =
requiring
>> +        * flush if the old PTE is not dirty or not writable for =
simplification
>> +        * of the code and to consider (unlikely) cases of changing =
dirty-bit of
>> +        * write-protected PTE.
>> +        */
>> +       if (!(diff & ~(_PAGE_RW | _PAGE_DIRTY | ignore_mask)) &&
>> +           (!(pte_dirty(oldpte) || !pte_write(oldpte))))
>> +               return false;
>=20
> This logic seems confusing to me.  Is your goal to say that, if the
> old PTE was clean and writable and the new PTE is write-protected,
> then no flush is needed?

Yes.

> If so, I would believe you're right, but I'm
> not convinced you've actually implemented this.  Also, there may be
> other things going on that need flushing, e.g. a change of the address
> or an accessed bit or NX change.

The first part (diff & ~(_PAGE_RW | _PAGE_DIRTY | ignore_mask) is =
supposed
to capture changes of address, NX-bit, etc.

The second part is indeed wrong. It should have been:
 (!pte_dirty(oldpte) || !pte_write(oldpte))

>=20
> Also, CET makes this extra bizarre.

I saw something about the not-writeable-and-dirty considered =
differently. I
need to have a look, but I am not sure it affects anything.

