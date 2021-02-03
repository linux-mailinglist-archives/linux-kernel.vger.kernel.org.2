Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EF830D68F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhBCJqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233540AbhBCJpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:45:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6420764E11;
        Wed,  3 Feb 2021 09:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612345505;
        bh=lhbZyN+uLB12V6jsdAtPmy/DGC3Xe63XTP2uoMfd/dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OWskC4OC5mrzI55l8SJ3lM0b5PB+xg25xmyFGjGqM9TRHjFdKz+oMinRfSVK7Tlgp
         JT+AHTiBdF+hrpJq9cwiCr+qo0ehvWHVyeTfaFdRs6c+RWT1gI+KHGyIX9HlMQJJe5
         hTPd5vFK3Q62m6X4S5068+6S34E9DB7qbdOF7xgS70TddVeWW1APADT5s/hamG0jr9
         eHdF/eMx2jITz+PxZVlXZSr9bDxPQiCtOjr4bEpugM32sL1xGxtsB/Unjdq0xykv30
         LqlUwx+IO6qiAtv7S4O1ThteeZ0dv7CsMH8/akLm5EofGY726P5LWP+99ro0j0Lymf
         7zU7msHH/HFQw==
Date:   Wed, 3 Feb 2021 09:44:59 +0000
From:   Will Deacon <will@kernel.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Zhao <yuzhao@google.com>, Nick Piggin <npiggin@gmail.com>,
        X86 ML <x86@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 01/20] mm/tlb: fix fullmm semantics
Message-ID: <20210203094459.GA18493@willie-the-truck>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-2-namit@vmware.com>
 <YBfntzMgNlMDOP9s@hirez.programming.kicks-ass.net>
 <52673507-2C30-4AC6-8EBC-B5A313827FB0@gmail.com>
 <YBkwyEL2FKxlsgZ5@hirez.programming.kicks-ass.net>
 <5E9B0429-7E72-4E86-B91B-4718C4134B0F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5E9B0429-7E72-4E86-B91B-4718C4134B0F@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 01:35:38PM -0800, Nadav Amit wrote:
> > On Feb 2, 2021, at 3:00 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Tue, Feb 02, 2021 at 01:32:36AM -0800, Nadav Amit wrote:
> >>> On Feb 1, 2021, at 3:36 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >>> 
> >>> 
> >>> https://lkml.kernel.org/r/20210127235347.1402-1-will@kernel.org
> >> 
> >> I have seen this series, and applied my patches on it.
> >> 
> >> Despite Will’s patches, there were still inconsistencies between fullmm
> >> and need_flush_all.
> >> 
> >> Am I missing something?
> > 
> > I wasn't aware you were on top. I'll look again.
> 
> Looking on arm64’s tlb_flush() makes me think that there is currently a bug
> that this patch fixes. Arm64’s tlb_flush() does:
> 
>        /*
>         * If we're tearing down the address space then we only care about
>         * invalidating the walk-cache, since the ASID allocator won't
>         * reallocate our ASID without invalidating the entire TLB.
>         */
>        if (tlb->fullmm) {
>                if (!last_level)
>                        flush_tlb_mm(tlb->mm);
>                return;
>        } 
> 
> But currently tlb_mmu_finish() can mistakenly set fullmm incorrectly (if
> mm_tlb_flush_nested() is true), which might skip the TLB flush.

But in that case isn't 'freed_tables' set to 1, so 'last_level' will be
false and we'll do the flush in the code above?

Will
