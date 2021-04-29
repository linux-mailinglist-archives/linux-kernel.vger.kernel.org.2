Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6791B36EDF1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 18:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbhD2QOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 12:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhD2QOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 12:14:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFD4C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sjto5L9W4yTchVWVxZGdizaY2No4aG7xse7lrOyysJY=; b=jL/C6pnOsdbzk8QyLzkCXWeXYD
        GSITLuCJOJ72BcwJZdAMuzODezh95gYleNadR9An2m1nGxNhZKLgTlAaOMIUuvDdhrEL0qVQppor+
        ZQNFVC70kXIxlcPeBr0NEbgtXxurs9pa4T0LTXqMkmJijuxLYQTbOAr15qoRrIV5qZq9MMgnK4JzO
        nfuv8HSClIPdLsJPbOXNZnrM/4M1hKJENxJytlFLC2Rpav7gudeGbZ5oR/rCi8j9fvUpjfqSx5Si4
        dRhWYmBo9nQjJiXBTYI0JPzuDZCSvD0m6/zolk/uDYaBsu8CcTPROIombfLJpeIVw3SfnWOP0fyTZ
        W50CZaCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lc9HG-009rBw-O6; Thu, 29 Apr 2021 16:12:39 +0000
Date:   Thu, 29 Apr 2021 17:12:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
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
Message-ID: <20210429161234.GG1847222@casper.infradead.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
 <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
 <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429000225.GC10973@lespinasse.org>
 <CALCETrWybk8k8Z=9+x3Ns7zMUPMzganzPY47pqOJCbB3LkfQ+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWybk8k8Z=9+x3Ns7zMUPMzganzPY47pqOJCbB3LkfQ+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 05:05:17PM -0700, Andy Lutomirski wrote:
> On Wed, Apr 28, 2021 at 5:02 PM Michel Lespinasse <michel@lespinasse.org> wrote:
> > Thanks Paul for confirming / clarifying this. BTW, it would be good to
> > add this to the rcu header files, just so people have something to
> > reference to when they depend on such behavior (like fast GUP
> > currently does).
> 
> Or, even better, fast GUP could add an explicit RCU read lock.
> 
> >
> > Going back to my patch. I don't need to protect against THP splitting
> > here, as I'm only handling the small page case. So when
> > MMU_GATHER_RCU_TABLE_FREE is enabled, I *think* I could get away with
> > using only an rcu read lock, instead of disabling interrupts which
> > implicitly creates the rcu read lock. I'm not sure which way to go -
> > fast GUP always disables interrupts regardless of the
> > MMU_GATHER_RCU_TABLE_FREE setting, and I think there is a case to be
> > made for following the fast GUP stes rather than trying to be smarter.
> 
> How about adding some little helpers:
> 
> lockless_page_walk_begin();
> 
> lockless_page_walk_end();
> 
> these turn into RCU read locks if MMU_GATHER_RCU_TABLE_FREE and into
> irqsave otherwise.  And they're somewhat self-documenting.

One of the worst things we can do while holding a spinlock is take a
cache miss because we then delay for several thousand cycles to wait for
the cache line.  That gives every other CPU a really long opportunity
to slam into the spinlock and things go downhill fast at that point.
We've even seen patches to do things like read A, take lock L, then read
A to avoid the cache miss while holding the lock.

What sort of performance effect would it have to free page tables
under RCU for all architectures?  It's painful on s390 & powerpc because
different tables share the same struct page, but I have to believe that's
a solvable problem.
