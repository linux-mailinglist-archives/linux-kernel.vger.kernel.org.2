Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFD73576CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhDGV2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhDGV2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:28:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9C3C061761
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 14:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=otglDvep5sGkMy7KSFfJkw3zbakk63WSycFVlUg1TqE=; b=k210fC5qr7A1PRLdfR1aLQElA6
        0DIe535HrWQzEyYMzcAdiU3nutuYI1KV7Kq+n3O+Qwd371xG62ipWeRoGx2yChAsT+y0tQWP50hkB
        pAwNSOlsY8ughxldJagntHF+qUDKQfvr68rUgIRHrytmVtWGVpXPdjw5PFInOJM0Y0hMMo+nijP2d
        Nx5uEWIWEFxURPhfHavS28wdP97gS9zlKx4eVpRqgjjcwy9VQn5kbvnu9pABlKZ0014LBLu3dsYMv
        8/CVF2jQGOm7ZH0U5rzxv+Ey1/kaAp4IrFzZ+wFK+ryVQqCZcE8Z0CUiIQwERNb9Ggag7NjBQ2iqV
        enWi+B9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUFhg-00F7NP-FZ; Wed, 07 Apr 2021 21:27:31 +0000
Date:   Wed, 7 Apr 2021 22:27:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20210407212712.GH2531743@casper.infradead.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-25-michel@lespinasse.org>
 <YG3EYjVDrZ54QCLq@hirez.programming.kicks-ass.net>
 <20210407212027.GE25738@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407212027.GE25738@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 02:20:27PM -0700, Michel Lespinasse wrote:
> On Wed, Apr 07, 2021 at 04:40:34PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 06, 2021 at 06:44:49PM -0700, Michel Lespinasse wrote:
> > > In the speculative case, call the vm_ops->fault() method from within
> > > an rcu read locked section, and verify the mmap sequence lock at the
> > > start of the section. A match guarantees that the original vma is still
> > > valid at that time, and that the associated vma->vm_file stays valid
> > > while the vm_ops->fault() method is running.
> > > 
> > > Note that this implies that speculative faults can not sleep within
> > > the vm_ops->fault method. We will only attempt to fetch existing pages
> > > from the page cache during speculative faults; any miss (or prefetch)
> > > will be handled by falling back to non-speculative fault handling.
> > > 
> > > The speculative handling case also does not preallocate page tables,
> > > as it is always called with a pre-existing page table.
> > 
> > So what's wrong with SRCU ? Laurent mumbled something about frequent
> > SRCU kthread activity being a problem; is that still so and is that
> > fundamentally unfixable?
> > 
> > Because to me it seems a much more natural solution to the whole thing.
> 
> The short answer is that I did not try SRCU. My thought process was,
> page cache already uses an RCU read lock, I just need to expand its
> scope a little.
> 
> Using SRCU might allow us to hit disk during speculative faults; OTOH
> we may need to switch to a more robust validation mechanism than the
> global counter to reap any benefits.

Why would you want to do I/O under SRCU?!  The benefit of SRCU is that
you can allocate page tables under SRCU.

Doing I/O without any lock held already works; it just uses the file
refcount.  It would be better to use a vma refcount, as I already said.
