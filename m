Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9833F8CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbhHZRPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhHZRPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:15:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4330C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2pCN7FQrk4lL/jfCos2t4Y0DYWNruWk+mo0K2UjcJ1U=; b=KZLXdbWWVkiUoDDUHMKT5xE8fk
        3jPvxDVYhDIHK5luzOIivN3WChLnXdkkjkjWZ5tnZYYX3SuIeOJNV/+95MP1leagLHpP3T47SB+rQ
        L1jqKn+kottPYZghh5Dt78kOEZ1fuYAOIHjA8PyTH17eIVIGXN/arbXO4kWmS/tkqr/dIpLzRjObe
        7wY/QuC7lOckO8On+S+Ovi/3+ZKxm39yxvwRdYtqCdCeWhnM4zoX6EVheVLjrVV39AuSFFa/Sc2DP
        M8EAL7wyBpp8dN8eFseaFH9x2sJr9E2+n9kRqQNMzXNxAbqrEgHAw9tJmuYFZ8ijh8wx00ukbmcW+
        2hDreciw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJIx6-00DF2m-Bp; Thu, 26 Aug 2021 17:14:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF1E3300024;
        Thu, 26 Aug 2021 19:14:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CD012C596C79; Thu, 26 Aug 2021 19:14:06 +0200 (CEST)
Date:   Thu, 26 Aug 2021 19:14:06 +0200
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
Subject: Re: [PATCH] sched: Switch wait_task_inactive to HRTIMER_MODE_REL_HARD
Message-ID: <YSfL3vdbuXWvI/Ya@hirez.programming.kicks-ass.net>
References: <20210826170408.vm7rlj7odslshwch@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826170408.vm7rlj7odslshwch@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 07:04:08PM +0200, Sebastian Andrzej Siewior wrote:
> With PREEMPT_RT enabled all hrtimers callbacks will be invoked in
> softirq mode unless they are explicitly marked as HRTIMER_MODE_HARD.
> During boot kthread_bind() is used for the creation of per-CPU threads
> and then hangs in wait_task_inactive() if the ksoftirqd is not
> yet up and running.
> The hang disappeared since commit
>    26c7295be0c5e ("kthread: Do not preempt current task if it is going to call schedule()")
> 
> but enabling function trace on boot reliably leads to the freeze on boot
> behaviour again.
> The timer in wait_task_inactive() can not be directly used by a user
> interface to abuse it and create a mass wake up of several tasks at the
> same time leading to long sections with disabled interrupts.
> Therefore it is safe to make the timer HRTIMER_MODE_REL_HARD.
> 
> Switch the timer to HRTIMER_MODE_REL_HARD.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks!
