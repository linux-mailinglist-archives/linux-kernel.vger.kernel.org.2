Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D098357DEE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhDHIT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhDHIT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:19:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492FCC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IymSJi3wLgOG0IzE9yca3IGjFJaMyWTnXOUsfwmn+KU=; b=EvYBSYjkUjg5S2KM24uOJSh5Ka
        AhZmRkDaREim8RiokpMJcaNURrWh1juhBQW8NMbfYJ3kbVocstKff/OJt6UBaH9ZW2Xi0AJ7cJB3b
        6TX3q9ItDKKsDK1yJFx5Tu4US+5gQCofeqxDJedhLE52MyIlCoQV9Ee9PUlFS2XBkX5O8Uqs01nE1
        5fqzdBzlHDVGDPOtQaVcNKvxodIf1D1x9RAdQF5vZ3/KfLk13c6XrByNbCpgNEkQVAvOaeavXSmN2
        TJG2ku5+Y5zRGUhzM3HRfGce6mnTkmp3YjGa7QFMopPZv6gldk3Tv/nc77QF982O+WrnYNCEx9xmi
        L5ZGYXlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUPsQ-007K0q-5s; Thu, 08 Apr 2021 08:18:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 563F830069C;
        Thu,  8 Apr 2021 10:18:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40DD52BE3AEB4; Thu,  8 Apr 2021 10:18:57 +0200 (CEST)
Date:   Thu, 8 Apr 2021 10:18:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 24/37] mm: implement speculative handling in
 __do_fault()
Message-ID: <YG68cRmRjsU+Tv6+@hirez.programming.kicks-ass.net>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-25-michel@lespinasse.org>
 <YG3EYjVDrZ54QCLq@hirez.programming.kicks-ass.net>
 <20210407212027.GE25738@lespinasse.org>
 <20210407212712.GH2531743@casper.infradead.org>
 <YG6qCtRcz2ESUiFy@hirez.programming.kicks-ass.net>
 <20210408071343.GJ2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408071343.GJ2531743@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 08:13:43AM +0100, Matthew Wilcox wrote:
> On Thu, Apr 08, 2021 at 09:00:26AM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 07, 2021 at 10:27:12PM +0100, Matthew Wilcox wrote:
> > > Doing I/O without any lock held already works; it just uses the file
> > > refcount.  It would be better to use a vma refcount, as I already said.
> > 
> > The original workload that I developed SPF for (waaaay back when) was
> > prefaulting a single huge vma. Using a vma refcount was a total loss
> > because it resulted in the same cacheline contention that down_read()
> > was having.
> > 
> > As such, I'm always incredibly sad to see mention of vma refcounts.
> > They're fundamentally not solving the problem :/
> 
> OK, let me outline my locking scheme because I think it's rather better
> than Michel's.  The vma refcount is the slow path.
> 
> 1. take the RCU read lock
> 2. walk the pgd/p4d/pud/pmd
> 3. allocate page tables if necessary.  *handwave GFP flags*.

The problem with allocating page-tables was that you can race with
zap_page_range() if you're not holding mmap_sem, and as such can install
a page-table after, in which case it leaks.

IIRC that was solvable, but it did need a bit of care.

> 4. walk the vma tree
> 5. call ->map_pages

I can't remember ->map_pages().. I think that's 'new'. git-blame tells
me that's 2014, and I did the original SPF in 2010.

Yes, that looks like a useful thing to have, it does the non-blocking
part of ->fault().

I suppose the thing missing here is that if ->map_pages() does not
return a page, we have:

  goto 9

> 6. take ptlock
> 7. insert page(s)
> 8. drop ptlock
> if this all worked out, we're done, drop the RCU read lock and return.

> 9. increment vma refcount
> 10. drop RCU read lock
> 11. call ->fault
> 12. decrement vma refcount

And here we do 6-8 again, right?

> Compared to today, where we bump the refcount on the file underlying the
> vma, this is _better_ scalability -- different mappings of the same file
> will not contend on the file's refcount.
>
> I suspect your huge VMA was anon, and that wouldn't need a vma refcount
> as faulting in new pages doesn't need to do I/O, just drop the RCU
> lock, allocate and retry.

IIRC yes, it was either a huge matrix setup or some database thing, I
can't remember. But the thing was, we didn't have that ->map_pages(), so
we had to call ->fault(), which can sleep, so I had to use SRCU across
the whole thing (or rather, I hacked up preemptible-rcu, because SRCU
was super primitive back then). It did kick start significant SRCU
rework IIRC. Anyway, that's all ancient history.
