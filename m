Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34A6400AC5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351078AbhIDKQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbhIDKQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:16:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CD9C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 03:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zEr8Lbr9wQ3RfxgktRFywCR1x79QNbubTTty1+FgQv8=; b=i+oae/o5GXNNdzIciEbGbHPoH3
        witsMQivlXzFdYRXF7zcmw0EwSzYTuQ+fKKU96NJhIMvURf7VWa9LmlmEusFeRtC4hceSmwiRVuvI
        ljmu/mi4YyfIsZoYWuSd/ag4jBa/n84LPiNVuDqJOrc44ZQ2f6k36ekIp7MLj5PZv7txu3BgYOLvy
        BsW9O5sJgWbF3WkveQCudFjpzjDMX8WjL6RKF4ZHRfJV9Njal6eSRYbFiKh8z6RhrHS6Jwuwyw/53
        LE/CyDeyycbOKvvI8FIcnlaXCDg+RpNGyJSl2zuUPalxBkFgjnBL9oHdpUk+rR7i0+jZLUy/5Yg7h
        HyJDk+SA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMSgw-005EDH-2W; Sat, 04 Sep 2021 10:14:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A032F986283; Sat,  4 Sep 2021 12:14:29 +0200 (CEST)
Date:   Sat, 4 Sep 2021 12:14:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] locking: rwbase: Take care of ordering guarantee for
 fastpath reader
Message-ID: <20210904101429.GB4323@worktop.programming.kicks-ass.net>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
 <YTC7sariSyBW48nh@hirez.programming.kicks-ass.net>
 <YTI2UjKy+C7LeIf+@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTI2UjKy+C7LeIf+@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 10:50:58PM +0800, Boqun Feng wrote:
> > 	 * ordering, either is strong enough to provide ACQUIRE order
> > 	 * for the above load of @readers.
> > 	 */
> > 	rwbase_set_and_save_current_state(state);
> > 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> > 
> > 	while (readers) {
> > 		...
> > 		readers = atomic_read(&rwb->readers);
> 
> The above should be _acquire(), right? Pairs with the last reader
> exiting the critical section and dec ->readers to 0. If so, it
> undermines the necessity of the restructure?

This is the one that's followed by set_current_state(), no?

