Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84557325490
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhBYRdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhBYRdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:33:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FADC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ww8ipOst8GbveiTvOaDMMaZrpR8vD/2Cq+k5zcspXqA=; b=paAIEUvVWl4rXXM9lK2H74nS40
        r1/GuSDOiKBCOoEd8accZONl5Zhrr2If/UqTPdZ/S5qKVeQfVqSHG0GEsVW4a+9N4Cp1m4OCdjfEw
        /76+Km0HfdQKdBZcm3QUNZGxWnQYSqOKvEHa0h4g30LAJrIJyYmYGKyHqisjaobvWHDi/CXt4Vu5n
        92okHsFJ0ayQ4EY3mWz5nIrzG1g+XDQi9rOSn7N+BHmjJR+CHuimZorvXygeUA8zBoX8GF9Gug18k
        IdK/zQLfuBM63sH5hSPL56PFbLcDlRGs/w8n1xcJYSyaZB63j6AvnJYbFhf+Vf/BGHxoNeFVoe/ds
        qldzHCWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFKVR-00Ay26-5c; Thu, 25 Feb 2021 17:32:54 +0000
Date:   Thu, 25 Feb 2021 17:32:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC 0/6] x86: prefetch_page() vDSO call
Message-ID: <20210225173253.GB2858050@casper.infradead.org>
References: <20210225072910.2811795-1-namit@vmware.com>
 <20210225121645.GZ2858050@casper.infradead.org>
 <0EFCDB0B-DB73-4866-9C0B-7192737CA372@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0EFCDB0B-DB73-4866-9C0B-7192737CA372@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 04:56:50PM +0000, Nadav Amit wrote:
> 
> > On Feb 25, 2021, at 4:16 AM, Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > On Wed, Feb 24, 2021 at 11:29:04PM -0800, Nadav Amit wrote:
> >> Just as applications can use prefetch instructions to overlap
> >> computations and memory accesses, applications may want to overlap the
> >> page-faults and compute or overlap the I/O accesses that are required
> >> for page-faults of different pages.
> > 
> > Isn't this madvise(MADV_WILLNEED)?
> 
> Good point that I should have mentioned. In a way prefetch_page() a
> combination of mincore() and MADV_WILLNEED.
> 
> There are 4 main differences from MADV_WILLNEED:
> 
> 1. Much lower invocation cost if the readahead is not needed: this allows
> to prefetch pages more abundantly.

That seems like something that could be fixed in libc -- if we add a
page prefetch vdso call, an application calling posix_madvise() could
be implemented by calling this fast path.  Assuming the performance
increase justifies this extra complexity.

> 2. Return value: return value tells you whether the page is accessible.
> This makes it usable for coroutines, for instance. In this regard the
> call is more similar to mincore() than MADV_WILLNEED.

I don't quite understand the programming model you're describing here.

> 3. The PTEs are mapped if the pages are already present in the
> swap/page-cache, preventing an additional page-fault just to map them.

We could enhance madvise() to do this, no?

> 4. Avoiding heavy-weight reclamation on low memory (this may need to
> be selective, and can be integrated with MADV_WILLNEED).

Likewise.

I don't want to add a new Linux-specific call when there's already a
POSIX interface that communicates the exact same thing.  The return
value seems like the only problem.

https://pubs.opengroup.org/onlinepubs/9699919799/functions/posix_madvise.html
