Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5891A30A7E8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhBAMpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBAMps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:45:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617DCC061573;
        Mon,  1 Feb 2021 04:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iS8iy+q7Izh8AM4pbDoHtBgYLQUACj4slse1odTb8Xw=; b=m7ji0VO1MSn1lX6BI0jJ/Yb9pR
        9LbSnyqEyG+WShVFDi6LLpOxh725y4TN5ZOzvkdZzaqe2VLLrMyA0w5DmjmAmnD9zsr9kHInq0sjB
        ii38K9XKQhFn7sOI40UlVOovRxxAgm9h9jejp9eCBLKegUodvH0TprmeRQ27HIdL/dZ9Y9TeAXH+T
        AH4kD9PgJxscyRe30c+nsFbhAUZbIF86CVRIvrNnDHqiAHo82ZC5vwPaZdUNJSPPkp0ldDsBPBc8P
        BJXcBzycInlMsr0+a7N0JA8WObI/EMjH6YDE79gmnKGPIcRn4F4Lq0ejsbhou5qIjm5vd3EqnQ2UW
        /oN5DJpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6YZH-00Dm54-Iu; Mon, 01 Feb 2021 12:44:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D8C9303A02;
        Mon,  1 Feb 2021 13:44:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65B2620C8E303; Mon,  1 Feb 2021 13:44:34 +0100 (CET)
Date:   Mon, 1 Feb 2021 13:44:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [RFC 00/20] TLB batching consolidation and enhancements
Message-ID: <YBf3sl3M+j3hJRoM@hirez.programming.kicks-ass.net>
References: <20210131001132.3368247-1-namit@vmware.com>
 <1612063149.2awdsvvmhj.astroid@bobo.none>
 <A1589669-34AE-4E15-8358-79BAD7C72520@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A1589669-34AE-4E15-8358-79BAD7C72520@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 07:57:01AM +0000, Nadav Amit wrote:
> > On Jan 30, 2021, at 7:30 PM, Nicholas Piggin <npiggin@gmail.com> wrote:

> > I'll go through the patches a bit more closely when they all come 
> > through. Sparc and powerpc of course need the arch lazy mode to get 
> > per-page/pte information for operations that are not freeing pages, 
> > which is what mmu gather is designed for.
> 
> IIUC you mean any PTE change requires a TLB flush. Even setting up a new PTE
> where no previous PTE was set, right?

These are the HASH architectures. Their hardware doesn't walk the
page-tables, but it consults a hash-table to resolve page translations.

They _MUST_ flush the entries under the PTL to avoid ever seeing
conflicting information, which will make them really unhappy. They can
do this because they have TLBI broadcast.

There's a few more details I'm sure, but those seem to have slipped from
my mind.
