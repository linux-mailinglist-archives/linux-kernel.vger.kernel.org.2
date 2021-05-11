Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607A737A11B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhEKHrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhEKHro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:47:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE48C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IH4rmQ69j2Fl6JxxC9cJyX9AxXhBsr98IbbacKhqIvM=; b=qi3xwOZ9HiLAagKybL1W+Ska+8
        mQlewraGSGeKqo0VAqIASaeP8ohM59EKr/llcnqy9S/NL8ZHHLsDqJRVHCM0DOFGDTrbqD8wch7V2
        6mtWtUeSnDkDMpU64lw7VJ8ex5OemtdgwzG3zwrJKMTEx4fRxQKnIpcwZV+VhkfCRpPLbGWWF2QMd
        c4Augr4qMRd8NFfBMzI6y1F/aIUbTB+gNXStldO+c32G8Yt2UbUpNb88/OF03XMi4zOrPFs1ueUPn
        sfLU/UU4H8EVFfPIubhixea+YB39eOq1pCzUCdO++B7re/x3EIzQaM6BvVw9WNAfN6oNzTKqZzwGq
        3HlMDWhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgN5l-0073br-BY; Tue, 11 May 2021 07:46:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A2B99871B5; Tue, 11 May 2021 09:46:05 +0200 (CEST)
Date:   Tue, 11 May 2021 09:46:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, neilb@suse.de,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] locking: Add split_lock
Message-ID: <20210511074605.GC5618@worktop.programming.kicks-ass.net>
References: <20210409025131.4114078-3-willy@infradead.org>
 <87blaj1sqf.ffs@nanos.tec.linutronix.de>
 <20210412144525.GM2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412144525.GM2531743@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 03:45:25PM +0100, Matthew Wilcox wrote:
> On Mon, Apr 12, 2021 at 04:29:28PM +0200, Thomas Gleixner wrote:
> > is to have a place to stick the lockdep map into. So it's not a lock
> > construct as the name suggests, it's just auxiliary data when lockdep is
> > enabled.
> 
> That's the implementation _today_, but conceptually, it's a single lock.
> I was thinking that for non-RT, we could put a qspinlock in there for a
> thread to spin on if the bit is contended.  It'd need a bit of ingenuity
> to make sure that a thread unlocking a bitlock made sure that a thread
> spinning on the qspinlock saw the wakeup, but it should be doable.

queued_write_lock_slowpath() does more or less exactly what you
describe.

I just worry about loss of concurrency if we were to do that. Where
currently we could be spinning on 5 different hash buckets and make
individual progress, doing what you propose would limit that.

Imagine having one bit-spinlock taken and another cpu contending, it
would go into the queue. Then do the same with another bit-spinlock,
with another two CPUs, the second again goes into that same queue.

So now we have 2 CPUs owning a bit-spinlock, and 2 CPUs stuck in the
queue. Suppose the second bit-spinlock is released, this would make the
queue-tail elegible to aquire, but it's stuck behind the queue-head
which is still waiting for its bit-spinlock. So it'll stay queued and we
loose concurrency.

Anyway, I think all this is worthwhile just to get bit-spinlock lockdep
coverage. And it's not like we can't change any of this when/if we get a
better idea or something.

