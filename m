Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B4D357D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhDHHPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDHHPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:15:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F827C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 00:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=StYLePuuoo1XC5Jko4tHPSj6QF8XVGj1hCI5fOcFvEc=; b=RRv4czO5rzvVATFiqXAps7RsW6
        U4WwkGaM9mOoALv0NcI86/xEWPYkqM4bfyTW+eqcTAObBaP4w3ADY74z4gvaiajNzOIT+Sq/jH9qP
        dLLBUJREVeH+776kGJROdFQZB7tV9cMx86ol4ZDkcxB3Rr+WO+/WgVPUnSWf8ELSWHmkCRxlpVYz3
        t1Ivtbuhz8GLTWhXF50p7wjnPUFZKqaSuySfKnwJNz6/1FJeJgq0p+dfZPrHWIS79pQjev3LiQzHB
        NJKnAPlrvW8r7QJSoU84vjetAc4wWhIkkSRl6+IAs9YYRFt61qoh9qeXYq13teBMeNO2Ut/9dUh/v
        skrHz/Fw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUOrI-00FkEw-0D; Thu, 08 Apr 2021 07:13:49 +0000
Date:   Thu, 8 Apr 2021 08:13:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20210408071343.GJ2531743@casper.infradead.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-25-michel@lespinasse.org>
 <YG3EYjVDrZ54QCLq@hirez.programming.kicks-ass.net>
 <20210407212027.GE25738@lespinasse.org>
 <20210407212712.GH2531743@casper.infradead.org>
 <YG6qCtRcz2ESUiFy@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG6qCtRcz2ESUiFy@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 09:00:26AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 07, 2021 at 10:27:12PM +0100, Matthew Wilcox wrote:
> > Doing I/O without any lock held already works; it just uses the file
> > refcount.  It would be better to use a vma refcount, as I already said.
> 
> The original workload that I developed SPF for (waaaay back when) was
> prefaulting a single huge vma. Using a vma refcount was a total loss
> because it resulted in the same cacheline contention that down_read()
> was having.
> 
> As such, I'm always incredibly sad to see mention of vma refcounts.
> They're fundamentally not solving the problem :/

OK, let me outline my locking scheme because I think it's rather better
than Michel's.  The vma refcount is the slow path.

1. take the RCU read lock
2. walk the pgd/p4d/pud/pmd
3. allocate page tables if necessary.  *handwave GFP flags*.
4. walk the vma tree
5. call ->map_pages
6. take ptlock
7. insert page(s)
8. drop ptlock
if this all worked out, we're done, drop the RCU read lock and return.
9. increment vma refcount
10. drop RCU read lock
11. call ->fault
12. decrement vma refcount

Compared to today, where we bump the refcount on the file underlying the
vma, this is _better_ scalability -- different mappings of the same file
will not contend on the file's refcount.

I suspect your huge VMA was anon, and that wouldn't need a vma refcount
as faulting in new pages doesn't need to do I/O, just drop the RCU
lock, allocate and retry.
