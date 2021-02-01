Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9FE30B28D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 23:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhBAWG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 17:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhBAWF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:05:29 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D584C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 14:04:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u15so10849380plf.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 14:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=560t6fBoRJB7pYk+ynZBL69vW684cbwpnt+V28G7u9E=;
        b=QPkHQFq6Z49wZLxc9MO+bZW/z2SwMNCcUMkQkCgAyST/fL4TXcwsxZoC/1MYxtYHru
         RgWmLK9mnhYR3Y5crET85kdbAIBm39MKCeCqR0vcHL4KorrO+bhSXUWJnuYcyG8xixdX
         UnLRCgP/6pBgGHvLIysFxidvtauEaBQp6U9ayK0Ms03mm7exV3F3J1QLICXsfOedHQOM
         8kgWZalGMxShVN0ymQn6t6KlDqhFgxZx7vS91rCnJyPn/YjvKZ1p80y2hGnB84MSJldA
         Zzu1KpCtamr+lYDDdpT8xdIMBsDwBymmGs8J5d3oS/eqN37JA7pqvanI71ExM9yCde4T
         zUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=560t6fBoRJB7pYk+ynZBL69vW684cbwpnt+V28G7u9E=;
        b=nZwUSXNRQjfsLA/D+kIeQTADUk6YBMOOQJDCdIkwiKHArQdJ3NAwaYpKC1Dxl0RWX0
         4eF/qVjmk0QWtPy1RLVuv7EV0qGmV7W0Vua3+XnWNTnVzSBTweca+LNuYigWhC+qYmuU
         8gmvcqzSw9b8JChQly91FNgx/4TDLE1D9/qIsZuzl3VBe4+k9C4SKhkQZj4dWuSZY/oC
         hGtDpnf3x7q09Uoqqysbr0hjmawywhjDW65Q0ZZ7a8Uiqwu7ibmWCtlgc+9rVxy7O3fx
         lLMUgklvWbTS2GncgjukThgH/0rt9VgjmomMt2FAqWC+hAByMwvO1koGtNXZGhGHqWg5
         sD9A==
X-Gm-Message-State: AOAM531086m1HFYqNQn1p1qa+CQZEJ/l4U1qVqrOrMMSLSymGVBsItAJ
        ykpm2hyUDL/eEvI4IyDxDyR8K59cbCemdg==
X-Google-Smtp-Source: ABdhPJwCsZCRkAE/Mwiu7DtQNEGp0BUUgOUSP+osTV8dFNdnbg9ewRz/DzXZpVRBIuKdXvYUlPotZQ==
X-Received: by 2002:a17:90b:14cf:: with SMTP id jz15mr919036pjb.180.1612217088619;
        Mon, 01 Feb 2021 14:04:48 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id e21sm18869724pgv.74.2021.02.01.14.04.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 14:04:47 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC 15/20] mm: detect deferred TLB flushes in vma granularity
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20210131001132.3368247-16-namit@vmware.com>
Date:   Mon, 1 Feb 2021 14:04:45 -0800
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        X86 ML <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6E4897D-8D5A-4084-8288-8E43F3039921@gmail.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-16-namit@vmware.com>
To:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 30, 2021, at 4:11 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
> From: Nadav Amit <namit@vmware.com>
>=20
> Currently, deferred TLB flushes are detected in the mm granularity: if
> there is any deferred TLB flush in the entire address space due to =
NUMA
> migration, pte_accessible() in x86 would return true, and
> ptep_clear_flush() would require a TLB flush. This would happen even =
if
> the PTE resides in a completely different vma.

[ snip ]

> +static inline void read_defer_tlb_flush_gen(struct mmu_gather *tlb)
> +{
> +	struct mm_struct *mm =3D tlb->mm;
> +	u64 mm_gen;
> +
> +	/*
> +	 * Any change of PTE before calling __track_deferred_tlb_flush() =
must be
> +	 * performed using RMW atomic operation that provides a memory =
barriers,
> +	 * such as ptep_modify_prot_start().  The barrier ensure the =
PTEs are
> +	 * written before the current generation is read, synchronizing
> +	 * (implicitly) with flush_tlb_mm_range().
> +	 */
> +	smp_mb__after_atomic();
> +
> +	mm_gen =3D atomic64_read(&mm->tlb_gen);
> +
> +	/*
> +	 * This condition checks for both first deferred TLB flush and =
for other
> +	 * TLB pending or executed TLB flushes after the last table that =
we
> +	 * updated. In the latter case, we are going to skip a =
generation, which
> +	 * would lead to a full TLB flush. This should therefore not =
cause
> +	 * correctness issues, and should not induce overheads, since =
anyhow in
> +	 * TLB storms it is better to perform full TLB flush.
> +	 */
> +	if (mm_gen !=3D tlb->defer_gen) {
> +		VM_BUG_ON(mm_gen < tlb->defer_gen);
> +
> +		tlb->defer_gen =3D inc_mm_tlb_gen(mm);
> +	}
> +}

Andy=E2=80=99s comments managed to make me realize this code is wrong. =
We must
call inc_mm_tlb_gen(mm) every time.

Otherwise, a CPU that saw the old tlb_gen and updated it in its local
cpu_tlbstate on a context-switch. If the process was not running when =
the
TLB flush was issued, no IPI will be sent to the CPU. Therefore, later
switch_mm_irqs_off() back to the process will not flush the local TLB.

I need to think if there is a better solution. Multiple calls to
inc_mm_tlb_gen() during deferred flushes would trigger a full TLB flush
instead of one that is specific to the ranges, once the flush actually =
takes
place. On x86 it=E2=80=99s practically a non-issue, since anyhow any =
update of more
than 33-entries or so would cause a full TLB flush, but this is still =
ugly.

