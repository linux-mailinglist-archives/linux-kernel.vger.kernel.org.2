Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E1A3FB2F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhH3JOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbhH3JOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:14:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D456C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ME7Y4XMLkd2ywGoBwxzGUpsqU/l8DEpJzNl4Cx6nTiY=; b=UYD/5OXLS5PVjkjsPGVZaPiYHP
        CbH7xa8SQVxS5bhUZnZbfk3mjkBeRvrAc++p/X5ry8iMhS+fycnq9inZsE/0gLDE4CNUlxr0jhA4c
        2598YOZbF+5vLuDxCDXC8eKGagkXeu5v+n7fNixwXpTbcqGXIRSmUu0ETPc/CLR2Enai8LU6JozDd
        3jHGV30PtDOklkqoDjaKYWru/ylnngUWiRMGSdxAAT4FD41RhLdWMukyqOXJ38o3L8G2/tOuzKcZj
        +wsGWn0+sSte+94sATxol+aB4usOUXtD6eihV0jj6iPKCSmJNJn1GUXTW8vnUJFEu536plOUmx2NS
        G4SHhCzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKdKv-00HXnP-94; Mon, 30 Aug 2021 09:12:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA99698186D; Mon, 30 Aug 2021 11:12:12 +0200 (CEST)
Date:   Mon, 30 Aug 2021 11:12:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH V2] sched: Prevent balance_push() on remote runqueues
Message-ID: <20210830091212.GG4353@worktop.programming.kicks-ass.net>
References: <87tujb0yn1.ffs@tglx>
 <87eeae11cr.ffs@tglx>
 <87zgt1hdw7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgt1hdw7.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 03:55:52PM +0200, Thomas Gleixner wrote:
> sched_setscheduler() and rt_mutex_setprio() invoke the run-queue balance
> callback after changing priorities or the scheduling class of a task. The
> run-queue for which the callback is invoked can be local or remote.
> 
> That's not a problem for the regular rq::push_work which is serialized with
> a busy flag in the run-queue struct, but for the balance_push() work which
> is only valid to be invoked on the outgoing CPU that's wrong. It not only
> triggers the debug warning, but also leaves the per CPU variable push_work
> unprotected, which can result in double enqueues on the stop machine list.
> 
> Remove the warning and validate that the function is invoked on the
> outgoing CPU.
> 
> Fixes: ae7927023243 ("sched: Optimize finish_lock_switch()")
> Reported-by: Sebastian Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!
