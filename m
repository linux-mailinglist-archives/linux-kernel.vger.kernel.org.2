Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00968357E40
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhDHIhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:37:47 -0400
Received: from server.lespinasse.org ([63.205.204.226]:46927 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhDHIhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:37:45 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617871054; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=gH+b4I4bYfVPVRG0SYb4pP96/w8P3/5+22wPxKEwskg=;
 b=pgoXWpws4/PUCkj+rX0Qwd2+X7AYlNZlVOFvVF2tPzXLBl1jIJZaH9K9VkPgLmUouITnT
 AmkqIjnpxE/dUenDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617871054; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=gH+b4I4bYfVPVRG0SYb4pP96/w8P3/5+22wPxKEwskg=;
 b=MGs3R/B2t569QkXYWkSa9xq6ocgFqad1DlVj99zaBgEeiY+fGwpmjYuw1tUeWPhq+6jRf
 hHWHDBekGKfZTzaK+tA9qPr4pSKjWXzlRuhNcSbiPnCIwsJPjQl66v0J4WSD5uR8C9wGS+x
 EdB2A3cCPenSiMmsEQIzFGEKTcrIWj1EDSRlvvGI6YOwhKpxq+hEY15KStk1rI4alDoluCQ
 nuxQU/5fCd/vdpIJeaPwg4fjZB2lqAB4iXLmLrPHTvlN5imkREPxgpv81XG5n4aoTooiKma
 R31H2elk0i5vhPbeSvB8TSKG/31y5GkEMnK8kDG5iVUSvZ1B/RB2xmLfSXhg==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id D8EDB160253; Thu,  8 Apr 2021 01:37:34 -0700 (PDT)
Date:   Thu, 8 Apr 2021 01:37:34 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <michel@lespinasse.org>,
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
Message-ID: <20210408083734.GB27824@lespinasse.org>
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
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> 4. walk the vma tree
> 5. call ->map_pages
> 6. take ptlock
> 7. insert page(s)
> 8. drop ptlock
> if this all worked out, we're done, drop the RCU read lock and return.
> 9. increment vma refcount
> 10. drop RCU read lock
> 11. call ->fault
> 12. decrement vma refcount

Note that most of your proposed steps seem similar in principle to mine.
Looking at the fast path (steps 1-8):
- step 2 sounds like the speculative part of __handle_mm_fault()
- (step 3 not included in my proposal)
- step 4 is basically the lookup I currently have in the arch fault handler
- step 6 sounds like the speculative part of map_pte_lock()

I have working implementations for each step, while your proposal
summarizes each as a point item. It's not clear to me what to make of it;
presumably you would be "filling in the blanks" in a different way
than I have but you are not explaining how. Are you suggesting that
the precautions taken in each step to avoid races with mmap writers
would not be necessary in your proposal ? if that is the case, what is
the alternative mechanism would you use to handle such races ?

Going back to the source of this, you suggested not copying the VMA,
what is your proposed alternative ? Do you suggest that fault handlers
should deal with the vma potentially mutating under them ? Or should
mmap writers consider vmas as immutable and copy them whenever they
want to change them ? or are you implying a locking mechanism that would
prevent mmap writers from executing while the fault is running ?

> Compared to today, where we bump the refcount on the file underlying the
> vma, this is _better_ scalability -- different mappings of the same file
> will not contend on the file's refcount.
> 
> I suspect your huge VMA was anon, and that wouldn't need a vma refcount
> as faulting in new pages doesn't need to do I/O, just drop the RCU
> lock, allocate and retry.
