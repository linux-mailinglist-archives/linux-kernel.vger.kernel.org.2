Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26583A950C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhFPIca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbhFPIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:32:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38780C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v8wzYunwBieuIQynzoH9RoOaxPah69I7Fsd9nOFE6KE=; b=WgtXclb6hQxKiYod4urCr83+rc
        rCx25hC+FLWdoRx0xB3prlUGCE3b3H5cmR1pWMLJzeaT4twDamYzbrh5wt4U5VzqaW5nKp/kB86WP
        1dIGnPPMk3SZKwN3kf7GlHSXy0chKdPkb0oAas+fB9y9iXR5yDsATdW6DE3+okRehQyvRMXSYW5MM
        sT4W/F11ZkbvT4oQZDCUa52eilXl3m2Q/mdiNUEJ/35YIhI/am7mW2bHkMXQBo8MBPm4LksfvMJQA
        VJyIF+MhPjkQqjAotW3TwxQDAJxreMBR22df3H+vW/IwMrVePl4R/m9aIt97iRNbxmQXxtIUVe184
        53cnZNOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltQvW-007nz1-HQ; Wed, 16 Jun 2021 08:29:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B48BA300252;
        Wed, 16 Jun 2021 10:29:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7098420277F84; Wed, 16 Jun 2021 10:29:33 +0200 (CEST)
Date:   Wed, 16 Jun 2021 10:29:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched, fair: try to prevent migration thread from
 preempting non-cfs task
Message-ID: <YMm2bWq9XfaPeSka@hirez.programming.kicks-ass.net>
References: <20210615121551.31138-1-laoar.shao@gmail.com>
 <20210615203534.GA4272@worktop.programming.kicks-ass.net>
 <CALOAHbBuZJaK+fEg7toRUHJNP8rJKDoADeAUxorUuNU17kdTOA@mail.gmail.com>
 <YMmlAP/QhE6SWhCF@hirez.programming.kicks-ass.net>
 <CAKfTPtAh3eOtzZUPqmhkw6FAOjOietZrB_qMOfOprp0oWO+CvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAh3eOtzZUPqmhkw6FAOjOietZrB_qMOfOprp0oWO+CvA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 09:29:55AM +0200, Vincent Guittot wrote:
> On Wed, 16 Jun 2021 at 09:15, Peter Zijlstra <peterz@infradead.org> wrote:

> > The suggestion was adding a cfs_migration thread, specifically for
> > active balance (and maybe numa). Just not sure the cost of carrying yet
> > another per-cpu kernel thread is worth the benefit.
> 
> Also, this will not completely remove the problem but only further
> reduce the race window because the rq is locked and the irq disable in
> active_load_balance_cpu_stop().

It removes the problem of active migration interfering with this
worklaod, because the FIFO1 task will never run until that is done
(assuming he manages to not have his workload at FIFO1).

