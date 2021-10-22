Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF1437060
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 05:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhJVDJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 23:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232462AbhJVDJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 23:09:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C367E61507;
        Fri, 22 Oct 2021 03:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634872006;
        bh=hehnqJ0TdJ0oTumpWm2Z7IQhH3FhJbTA99K6hy2daDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lL9M+IUOIWxlAjIje/cXUcaqf4psXejtDNY2+TcyvMervYHdDAT+EWywSAmKL2NYG
         ZrNpKGFzs1nBub0D4XyexXytz9beAgi6j7lhzyOOTIxQUphoIf02tzHvuh7YkCJs0E
         tYklmMvz6OcoYQhA5j4kBupaSCNwU8MN2120YzwY=
Date:   Thu, 21 Oct 2021 20:06:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [PATCH] mm: use correct VMA flags when freeing page-tables
Message-Id: <20211021200643.770f9d7bd3469b2ec9d6c401@linux-foundation.org>
In-Reply-To: <20211021122322.592822-1-namit@vmware.com>
References: <20211021122322.592822-1-namit@vmware.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 05:23:22 -0700 Nadav Amit <nadav.amit@gmail.com> wrote:

> From: Nadav Amit <namit@vmware.com>
> 
> Consistent use of the mmu_gather interface requires a call to
> tlb_start_vma() and tlb_end_vma() for each VMA. free_pgtables() does not
> follow this pattern.
> 
> Certain architectures need tlb_start_vma() to be called in order for
> tlb_update_vma_flags() to update the VMA flags (tlb->vma_exec and
> tlb->vma_huge), which are later used for the proper TLB flush to be
> issued. Since tlb_start_vma() is not called, this can lead to the wrong
> VMA flags being used when the flush is performed.
> 
> Specifically, the munmap syscall would call unmap_region(), which unmaps
> the VMAs and then frees the page-tables. A flush is needed after
> the page-tables are removed to prevent page-walk caches from holding
> stale entries, but this flush would use the flags of the VMA flags of
> the last VMA that was flushed. This does not appear to be right.

Any thoughts on what the worst-case end-user cisible effects of this
would be?

Again, I'm wondering about the desirability of a -stable backport.

> Use tlb_start_vma() and tlb_end_vma() to prevent this from happening.
> This might lead to unnecessary calls to flush_cache_range() on certain
> arch's. If needed, a new flag can be added to mmu_gather to indicate
> that the flush is not needed.

