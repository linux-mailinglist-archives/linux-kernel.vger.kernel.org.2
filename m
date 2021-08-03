Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718CD3DF0E9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhHCO6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbhHCO6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:58:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3281C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4XEofjew4uTXoMFin5UF1rmHGlAEvaewOm9MXFjvnoE=; b=ORY7jqvXKbFhI5FGaWYWvNkx4K
        rerHBgcWvP7TeWTNhY/nzEdy+dvPnLbngoQzAe6y8B4crvS1ONLEJjT5atXFSXnJkNNW81VN3npJE
        uUEOFEFWmiXll1v7d7wMNBhN7y6WlQQMtRLxKph+kCT7+iYUBO/7ASrZL/hfpv8TBex7HuLLmFBlq
        U0d7D2vZ4K93M9snVozj1SvjWmJPixBKsLgHF38Te3anVY9Kg2TtkomeA53PrrQ3EaTyy849JSQHh
        yfUtyg4+Z2/L7XcN66H/JppEa8or5XmZK/17rARZJNWWrdkRP3Gx2b+CYEEbZcS8mLkIZMDdF/sKW
        4/qJZrzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAvq0-004nIr-A8; Tue, 03 Aug 2021 14:56:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 719123000F2;
        Tue,  3 Aug 2021 16:56:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 34AEC2C9D4E7C; Tue,  3 Aug 2021 16:56:11 +0200 (CEST)
Date:   Tue, 3 Aug 2021 16:56:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bristot@redhat.com, bsegall@google.com,
        mgorman@suse.de, Mark Simmons <msimmons@redhat.com>
Subject: Re: [PATCH v2] sched/rt: Fix double enqueue caused by
 rt_effective_prio
Message-ID: <YQlZCwcrEvuZ6f1n@hirez.programming.kicks-ass.net>
References: <20210803104501.38333-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803104501.38333-1-juri.lelli@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 12:45:01PM +0200, Juri Lelli wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Double enqueues in rt runqueues (list) have been reported while running
> a simple test that spawns a number of threads doing a short sleep/run
> pattern while being concurrently setscheduled between rt and fair class.
> 
> WARNING: CPU: 3 PID: 2825 at kernel/sched/rt.c:1294 enqueue_task_rt+0x355/0x360
> CPU: 3 PID: 2825 Comm: setsched__13
> RIP: 0010:enqueue_task_rt+0x355/0x360
> Call Trace:
>  __sched_setscheduler+0x581/0x9d0
>  _sched_setscheduler+0x63/0xa0
>  do_sched_setscheduler+0xa0/0x150
>  __x64_sys_sched_setscheduler+0x1a/0x30
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> list_add double add: new=ffff9867cb629b40, prev=ffff9867cb629b40,
>                      next=ffff98679fc67ca0.
> kernel BUG at lib/list_debug.c:31!
> invalid opcode: 0000 [#1] PREEMPT_RT SMP PTI
> CPU: 3 PID: 2825 Comm: setsched__13
> RIP: 0010:__list_add_valid+0x41/0x50
> Call Trace:
>  enqueue_task_rt+0x291/0x360
>  __sched_setscheduler+0x581/0x9d0
>  _sched_setscheduler+0x63/0xa0
>  do_sched_setscheduler+0xa0/0x150
>  __x64_sys_sched_setscheduler+0x1a/0x30
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> __sched_setscheduler() uses rt_effective_prio() to handle proper queuing
> of priority boosted tasks that are setscheduled while being boosted.
> rt_effective_prio() is however called twice per each
> __sched_setscheduler() call: first directly by __sched_setscheduler()
> before dequeuing the task and then by __setscheduler() to actually do
> the priority change. If the priority of the pi_top_task is concurrently
> being changed however, it might happen that the two calls return
> different results. If, for example, the first call returned the same rt
> priority the task was running at and the second one a fair priority, the
> task won't be removed by the rt list (on_list still set) and then
> enqueued in the fair runqueue. When eventually setscheduled back to rt
> it will be seen as enqueued already and the WARNING/BUG be issued.
> 
> Fix this by calling rt_effective_prio() only once and then reusing the
> return value. While at it refactor code as well for clarity. Concurrent
> priority inheritance handling is still safe and will eventually converge
> to a new state by following the inheritance chain(s).
> 
> Fixes: 0782e63bc6fe ("sched: Handle priority boosted tasks proper in setscheduler()")
> Reported-by: Mark Simmons <msimmons@redhat.com>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> [squashed Peterz changes; added changelog]
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
