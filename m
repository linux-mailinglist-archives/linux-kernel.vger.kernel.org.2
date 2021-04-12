Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5B735C916
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242345AbhDLOp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbhDLOpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:45:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189D3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uELYZ4IQcrbpt0a9i9NAzW81i1oJqwg2V7TpDRNRtF8=; b=ev7YJokTeZp3zKC2a1B8htOcLG
        SZrlkUW89Tq/sVUq51lYbMJLAJS8FXt+/XTdlUVM73UW5TkbUtinHIeuU+ujEdjONBQezHa5LU6Fu
        PGbXdwuGUuG3ewlVGNZpm76QWCV8mhVmrMxEZI5UNkOUq5YsgeuW3dzcka/bX6MnJJPYkwCsW4/XL
        fBexWp+fq3+YL9FoBV3jMJshjAC/KprUntiRiTIbj9RWrW+DfNuK5Pt0qkODF6A/6Tlxk/8f3J2Wk
        RcEsY/kxIgw30BBba47dAijTnd5oEQDUAUfpcG6yOK4wEDc/VAjHEQbOIXOchoBB4OLYFBBRJ769L
        6hXO6YKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVxob-004TdK-17; Mon, 12 Apr 2021 14:45:25 +0000
Date:   Mon, 12 Apr 2021 15:45:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] locking: Add split_lock
Message-ID: <20210412144525.GM2531743@casper.infradead.org>
References: <20210409025131.4114078-3-willy@infradead.org>
 <87blaj1sqf.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blaj1sqf.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 04:29:28PM +0200, Thomas Gleixner wrote:
> On Fri, Apr 09 2021 at 03:51, Matthew Wilcox wrote:
> > Bitlocks do not currently participate in lockdep.  Conceptually, a
> > bit_spinlock is a split lock, eg across each bucket in a hash table.
> > The struct split_lock gives us somewhere to record the lockdep_map.
> 
> I like the concept, but the name is strange. The only purpose of 
> 
> > +struct split_lock {
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +	struct lockdep_map dep_map;
> > +#endif
> > +};
> 
> is to have a place to stick the lockdep map into. So it's not a lock
> construct as the name suggests, it's just auxiliary data when lockdep is
> enabled.

That's the implementation _today_, but conceptually, it's a single lock.
I was thinking that for non-RT, we could put a qspinlock in there for a
thread to spin on if the bit is contended.  It'd need a bit of ingenuity
to make sure that a thread unlocking a bitlock made sure that a thread
spinning on the qspinlock saw the wakeup, but it should be doable.

Anyway, from the point of view of the user, they should be declaring
"this is the lock", not "this is the lock tracking structure", right?

> I know you hinted that RT could make use of that data structure and the
> fact that it's mandatory for the various lock functions, but that's not
> really feasible if this is related to a hash with a bit spinlock per
> bucket as the data structure is hash global.
> 
> Sure, we can do pointer math to find out the bucket index and do
> something from there, but I'm not sure whether that really helps. Need
> to stare at the remaining few places where bit spinlocks are an issue on
> RT.

I obviously don't understand exactly what the RT patchset does.  My
thinking was that you could handle the bit locks like rw sems, and
sacrifice the scalability of per-bucket-lock for the determinism of
a single PI lock.
