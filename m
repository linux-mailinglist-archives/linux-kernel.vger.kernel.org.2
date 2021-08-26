Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAFE3F8C95
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhHZRAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhHZRAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:00:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2985DC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tWtbvxDbQneua8skOdhQaeTLxmG7GmsaooskC+FoSew=; b=uiXP1vdrHQiBj6mPhTBTSmUahs
        82qkmlgnCNoN1BvUrCHw4ZefJzCUd2WSnFbBqeeUbPHrcF9orLwFU0T+ejBw0WOTHzK5qGG1vPBmh
        nKerlNJYEmbkHYk7f7Mr3A7qEMJzKG5v/yky1dJp1MehovCv6ehgld+8Db3mSm0geCcmaax3PCJ/T
        s8gHGWKnkXnLpBFCPqKT45kJqE7l4q1iOv1PB8l5jyOy8nYX0cVLOHDC1h4dYBgMdAruyZHihqmHI
        wZujUx9aaKuHGpYHDsdxjVGp6LgK//1+S1rFsh+j0VTgpRwjCstTywwhyiLMr3BzSOr1IUIdvIxso
        GIY/TcGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJIg5-00DUZV-Nw; Thu, 26 Aug 2021 16:56:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDF673008DE;
        Thu, 26 Aug 2021 18:56:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9C5C29CA38CF; Thu, 26 Aug 2021 18:56:31 +0200 (CEST)
Date:   Thu, 26 Aug 2021 18:56:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched: Fix get_push_task() vs migrate_disable()
Message-ID: <YSfHv7Ptrprccmgp@hirez.programming.kicks-ass.net>
References: <20210826133738.yiotqbtdaxzjsnfj@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826133738.yiotqbtdaxzjsnfj@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 03:37:38PM +0200, Sebastian Andrzej Siewior wrote:
> push_rt_task() attempts to move the currently running task away if the
> next runnable task has migration disabled and therefore is pinned on the
> current CPU.
> 
> The current task is retrieved via get_push_task() which only checks for
> nr_cpus_allowed == 1, but does not check whether the task has migration
> disabled and therefore cannot be moved either. The consequence is a
> pointless invocation of the migration thread which correctly observes
> that the task cannot be moved.
> 
> Return NULL if the task has migration disabled and cannot be moved to
> another CPU.
> 
> Fixes: a7c81556ec4d3 ("sched: Fix migrate_disable() vs rt/dl balancing")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks!
