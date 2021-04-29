Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32F136F04A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 21:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhD2TSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 15:18:00 -0400
Received: from server.lespinasse.org ([63.205.204.226]:59883 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242622AbhD2TPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 15:15:16 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619723668; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=nrbq9B7dG+NCQxkteDtV1okkrNphDZCfGcOZNCMSQkU=;
 b=2aFz00E0Y24Rhdz7Fqx5QsvnOFlMBK1oW0+IhoIU9Irj5snllxZmt2t1v5ilB6npR5/w5
 gaVcVTxxmISCbNZCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619723668; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=nrbq9B7dG+NCQxkteDtV1okkrNphDZCfGcOZNCMSQkU=;
 b=X7rNkDBMH428Ypz2fZG/kkDKqTWsYVMzTG+fA/iXVsd6nSYsDKIT4PYIS8Cme++SNHnZh
 gmU0NDZXd4iTNvb7sVYdFR/ZPQYQVFdMMc75zP9tCObIoNqx/s2PATVl9JF56lzXUdlkESP
 7dQphM7PjcxgdcjddepwWQMWw8RZc5/PGaGiHpARm/Un9y4uGL/3ok28vtoJJgrauQaH+1f
 S5YqOHXFtRfvQqg8Qou7DgyKFbBh1INSxBaiIwweReMIWHs1lYBNm++XqrDmNfxv78wcs8Z
 jVgi867PySjlJzDpRZPFiWMLwQoW3mT+NET6t6HBddX60PBj2FmYNtwc3PDg==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 3E71D160305; Thu, 29 Apr 2021 12:14:28 -0700 (PDT)
Date:   Thu, 29 Apr 2021 12:14:28 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>,
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
Message-ID: <20210429191428.GD10973@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
 <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
 <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429000225.GC10973@lespinasse.org>
 <CALCETrWybk8k8Z=9+x3Ns7zMUPMzganzPY47pqOJCbB3LkfQ+A@mail.gmail.com>
 <20210429161234.GG1847222@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429161234.GG1847222@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 05:12:34PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 28, 2021 at 05:05:17PM -0700, Andy Lutomirski wrote:
> > On Wed, Apr 28, 2021 at 5:02 PM Michel Lespinasse <michel@lespinasse.org> wrote:
> > > Thanks Paul for confirming / clarifying this. BTW, it would be good to
> > > add this to the rcu header files, just so people have something to
> > > reference to when they depend on such behavior (like fast GUP
> > > currently does).
> > 
> > Or, even better, fast GUP could add an explicit RCU read lock.
> > 
> > >
> > > Going back to my patch. I don't need to protect against THP splitting
> > > here, as I'm only handling the small page case. So when
> > > MMU_GATHER_RCU_TABLE_FREE is enabled, I *think* I could get away with
> > > using only an rcu read lock, instead of disabling interrupts which
> > > implicitly creates the rcu read lock. I'm not sure which way to go -
> > > fast GUP always disables interrupts regardless of the
> > > MMU_GATHER_RCU_TABLE_FREE setting, and I think there is a case to be
> > > made for following the fast GUP stes rather than trying to be smarter.
> > 
> > How about adding some little helpers:
> > 
> > lockless_page_walk_begin();
> > 
> > lockless_page_walk_end();
> > 
> > these turn into RCU read locks if MMU_GATHER_RCU_TABLE_FREE and into
> > irqsave otherwise.  And they're somewhat self-documenting.
> 
> One of the worst things we can do while holding a spinlock is take a
> cache miss because we then delay for several thousand cycles to wait for
> the cache line.  That gives every other CPU a really long opportunity
> to slam into the spinlock and things go downhill fast at that point.
> We've even seen patches to do things like read A, take lock L, then read
> A to avoid the cache miss while holding the lock.

I understand the effect your are describing, but I do not see how it
applies here - what cacheline are we likely to miss on when using
local_irq_disable() that we wouldn't touch if using rcu_read_lock() ?

> What sort of performance effect would it have to free page tables
> under RCU for all architectures?  It's painful on s390 & powerpc because
> different tables share the same struct page, but I have to believe that's
> a solvable problem.

I agree using RCU to free page tables would be a good thing to try.
I am afraid of adding that to this patchset though, as it seems
somewhate unrelated and adds risk. IMO we are most likely to find
justification for pushing this if/when we try accessing remote mm's without
taking the mmap lock, since disabling IPIs clearly wouldn't work there.

--
Michel "walken" Lespinasse
