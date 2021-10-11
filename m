Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F844285A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 05:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhJKDrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 23:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhJKDrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:47:21 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607D6C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 20:45:22 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m21so9557150pgu.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 20:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=65ujd5zWPxKALq+MmqVYqoTyiZcmFSF+8wsgTyrTV+k=;
        b=GOmKg7vgvi8duuzeIia+J3wyH8CQQAAhsJSo0RCw6MdSoO6pjsp1J+eeSt4cDQvw/o
         IsU3GIeKPYYx1UkDW6D2xZ7Q2163jKJvAZNvK75LvgPfk6M+9bCzuTON9fL4/z+V8xVa
         FRXn8sgkVxMWK0B6KOGHmSIOvpBmykiQepg7yMGSNYoxJOvowbkRo1UZQYxBbczwdb8M
         OLQIu6XZJS7wVNzN2tuXdeDWe8piRDeM0A5wA5qZ2mS5gADyMEN14Eb7hESfJ4tym0eO
         OggNMj94SOo1MFlO/Ao7jEtEcbz7er9AIKBLfrWwiZrXeUZhWBlTlsPf0ho2vZvKXxxU
         h2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=65ujd5zWPxKALq+MmqVYqoTyiZcmFSF+8wsgTyrTV+k=;
        b=16u+k9zjcjFEXnWRrhZJVkC0E7JGhlB+FcZUBdI1YyTQZZt4X43hU0rweVxxSl9E46
         thLqV+jNOJs6mIwteCllZyLcfU+n6NFKs0G229FmTVMrjL65AKsOqxKqxvYHvI/bHC34
         XI5MU3n+8AZ0IHgid8KuK93omUMYp150mDvkrE7l4jj3eWq4niXF763KQy55avydPrqI
         WrDyld2CIKZF7CcHjIAcIDHTP4p+sdMzKCM8a/95zWvpfpKBFCRRXrL2DdaKBPGtb8Uq
         N3LDFrwlKfCvkZvr9WQcw/bPKBaxuMGnYe8ljMhEcQx5VfATXAP4OFJOGOzc+/Lj8elM
         or/Q==
X-Gm-Message-State: AOAM532dsfkJSxxBAl3gY73i1iKimbHPYUbylu4wWcH72K1z8xySbLb+
        0RfK0Jd8kOBfo2fadxjg588=
X-Google-Smtp-Source: ABdhPJyTjnYl5mbT+ZZypHNSBbzp+kOAPW0Kby6t0DALxE7Ff9cvy2Z0drJdIn/eByUh753t5p8E7Q==
X-Received: by 2002:a05:6a00:230e:b0:44c:4f2d:9b00 with SMTP id h14-20020a056a00230e00b0044c4f2d9b00mr23213756pfh.24.1633923921548;
        Sun, 10 Oct 2021 20:45:21 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id d138sm5840290pfd.74.2021.10.10.20.45.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Oct 2021 20:45:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/2] mm/mprotect: use mmu_gather
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20210925205423.168858-2-namit@vmware.com>
Date:   Sun, 10 Oct 2021 20:45:17 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <B8D86FB6-8A9E-4133-9477-0008B3FE46A3@gmail.com>
References: <20210925205423.168858-1-namit@vmware.com>
 <20210925205423.168858-2-namit@vmware.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 25, 2021, at 1:54 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
> 
> From: Nadav Amit <namit@vmware.com>
> 
> change_pXX_range() currently does not use mmu_gather, but instead
> implements its own deferred TLB flushes scheme. This both complicates
> the code, as developers need to be aware of different invalidation
> schemes, and prevents opportunities to avoid TLB flushes or perform them
> in finer granularity.
> 
> Use mmu_gather in change_pXX_range(). As the pages are not released,
> only record the flushed range using tlb_flush_pXX_range().

Andrea pointed out that I do not take care of THP. Actually, there is
indeed a missing TLB flush on THP, but it is not required due to the
pmdp_invalidate(). Anyhow, the patch needs to address it cleanly, and
to try to avoid the flush on pmdp_invalidate(), which at least on x86
does not appear to be necessary.

There is an additional bug, as tlb_change_page_size() needs to be
called.

-- Jerome,

While I am reviewing my (bad) code, I wanted to understand whether
update of migration entries requires a TLB flush, because I do not
think I got that right either.

I thought they should not, but I now am not very sure. I am very
confused by the following code in migrate_vma_collect_pmd():

        pte_unmap_unlock(ptep - 1, ptl);

        /* Only flush the TLB if we actually modified any entries */
        if (unmapped)
                flush_tlb_range(walk->vma, start, end);


According to this code flush_tlb_range() is called without the ptl.
So theoretically there is a possible race:


	CPU0				CPU1
	----				----
	migrate_vma_collect_pmd()
	 set_pte_at() [ present->
			non-present]

	 pte_unmap_unlock()

					madvise(MADV_DONTNEED)
					 zap_pte_range()

					[ PTE non-present =>
					  no flush ]

So my questions:

1. Is there a reason the above scenario is invalid?
2. Does one need to flush a migration entry he updates it?

Thanks,
Nadav


