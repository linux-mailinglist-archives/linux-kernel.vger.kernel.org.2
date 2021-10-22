Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E921043705A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 05:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhJVDHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 23:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231144AbhJVDHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 23:07:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 524D461504;
        Fri, 22 Oct 2021 03:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634871892;
        bh=rOOKX0MxxSjf3OnxKmLrh/v2fj0RUV88D11YpFGMGQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Te1ZB1HFPd+wtyIWy1Z//+NasRtCuvJYSA72syQIYymQcX6Qoa/9CJVvKzD/+sOW3
         CZitRium4NvKQvyIIM9VYZjYW1E9qeM3SSSbxVNV5dUTJhsKYE6zMtvhwQjHOPzcKq
         fV13gxGqF1pmGpJPc4sECiX+1LymUHAbUzasezcE=
Date:   Thu, 21 Oct 2021 20:04:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>, Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [PATCH v2 0/5] mm/mprotect: avoid unnecessary TLB flushes
Message-Id: <20211021200450.b13499c379a27dbfefe9f5e3@linux-foundation.org>
In-Reply-To: <20211021122112.592634-1-namit@vmware.com>
References: <20211021122112.592634-1-namit@vmware.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 05:21:07 -0700 Nadav Amit <nadav.amit@gmail.com> wrote:

> This patch-set is intended to remove unnecessary TLB flushes. It is
> based on feedback from v1 and several bugs I found in v1 myself.
> 
> Basically, there are 3 optimizations in this patch-set:
> 1. Avoiding TLB flushes on change_huge_pmd() that are only needed to
>    prevent the A/D bits from changing.
> 2. Use TLB batching infrastructure to batch flushes across VMAs and
>    do better/fewer flushes.
> 3. Avoid TLB flushes on permission demotion.
> 
> Andrea asked for the aforementioned (2) to come after (3), but this
> is not simple (specifically since change_prot_numa() needs the number
> of pages affected).

[1/5] appears to be a significant fix which should probably be
backported into -stable kernels.  If you agree with this then I suggest
it be prepared as a standalone patch, separate from the other four
patches.  With a cc:stable.

And the remaining patches are a performance optimization.  Has any
attempt been made to quantify the benefits?
