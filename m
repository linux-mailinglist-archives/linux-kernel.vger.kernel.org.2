Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9169A36F0A3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhD2ThB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 15:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhD2Tg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 15:36:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C43C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AuBuKJtfecHwtKNKpCmxc6lcyXSAmiHHw7MgDTeW7ko=; b=JrwAldHMLpLgEzU0P7+eBtdIWD
        TKHT2PzsS5jt8F3IoPwNFkuypPPQtIgd3ZETtz9Z4zU0DBLbhDVZdX2mWomE/51XA4822ajz6/zbT
        DyhKWMAbD+9IeA6yiCGjuUG5hJixoez1oQVYGrS4lP5sb4yW3x1VoaoqzG3KVxXBS1h6VRk/W7u5t
        3HI6xNURfQoXVTT1iO18RRaAfcleLYXlUo+ErlmgpOXCfeJoltW9IJa4Q/CqoFKSOSRKB9Jgus5Yi
        JM7WYLTdWnMoFle+d9wVwE4vYqu5bpUJRg+QXPlrolbPCFi7ol5BPIt+PgfCe7RSsxycFvQDhgI4w
        6f8feC4A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcCR6-00A3cd-MN; Thu, 29 Apr 2021 19:35:01 +0000
Date:   Thu, 29 Apr 2021 20:34:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 13/37] mm: implement speculative handling in
 __handle_mm_fault().
Message-ID: <20210429193456.GI1847222@casper.infradead.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
 <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
 <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429000225.GC10973@lespinasse.org>
 <CALCETrWybk8k8Z=9+x3Ns7zMUPMzganzPY47pqOJCbB3LkfQ+A@mail.gmail.com>
 <20210429161234.GG1847222@casper.infradead.org>
 <20210429191428.GD10973@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429191428.GD10973@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 12:14:28PM -0700, Michel Lespinasse wrote:
> On Thu, Apr 29, 2021 at 05:12:34PM +0100, Matthew Wilcox wrote:
> > One of the worst things we can do while holding a spinlock is take a
> > cache miss because we then delay for several thousand cycles to wait for
> > the cache line.  That gives every other CPU a really long opportunity
> > to slam into the spinlock and things go downhill fast at that point.
> > We've even seen patches to do things like read A, take lock L, then read
> > A to avoid the cache miss while holding the lock.
> 
> I understand the effect your are describing, but I do not see how it
> applies here - what cacheline are we likely to miss on when using
> local_irq_disable() that we wouldn't touch if using rcu_read_lock() ?

It's the same cache lines in both cases.  The difference is that in one
case we have interrupts disabled (and a spinlock held?  i wasn't clear
on that) and in the other case, we just have preemption disabled.

> > What sort of performance effect would it have to free page tables
> > under RCU for all architectures?  It's painful on s390 & powerpc because
> > different tables share the same struct page, but I have to believe that's
> > a solvable problem.
> 
> I agree using RCU to free page tables would be a good thing to try.
> I am afraid of adding that to this patchset though, as it seems
> somewhate unrelated and adds risk. IMO we are most likely to find
> justification for pushing this if/when we try accessing remote mm's without
> taking the mmap lock, since disabling IPIs clearly wouldn't work there.

I think that needs to happen _before_ this patchset.  Creating a mess and
then trying to clean it up later isn't a great way to do development.
