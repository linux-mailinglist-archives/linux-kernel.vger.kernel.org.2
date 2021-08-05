Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4C63E116D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhHEJg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhHEJg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:36:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B784DC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 02:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3XEEDb3hLIq11X5odcZdLZhPWWsD1ywJ/nuhepSVgpA=; b=c2MXMV0ZnZtSE3YjcEih1vErmz
        hOReUlzYqCAy4aIDtYSuj/kCu5FZQ+o+1RH6phwCrG4Y8MtPU2c2ns9D/q2rH2RMC8cTT+innKZZO
        M9ZDzH7f5rUsZ8/JRF6WRDdVe4bVdfo1t5tXPQFymJLB2cD/mPR+E1HHDzRVNvkRX7IkHvTtCcxaw
        Oz6A8AYK0e9ecaNPGxvg61RTGQPvKQBVAPyhIAvggCLzEEYMhBfrSxYtJmijYZL67SnVdsmnfGDum
        L2IYfw48do8+TPSemf+4Ufdcwdn2MQ6VWOzLbWTfEdz8m8sefK4+nL0DSjXoQgdPscX8oz+AFTKWD
        gUMd0ZiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBZmz-006oIj-2a; Thu, 05 Aug 2021 09:35:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5486B9862B0; Thu,  5 Aug 2021 11:35:44 +0200 (CEST)
Date:   Thu, 5 Aug 2021 11:35:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix missing clock update in
 migrate_task_rq_dl()
Message-ID: <20210805093544.GC22037@worktop.programming.kicks-ass.net>
References: <20210804135925.3734605-1-dietmar.eggemann@arm.com>
 <57f2dfe5-c1f5-4efb-e565-2e174228ee9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f2dfe5-c1f5-4efb-e565-2e174228ee9a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 10:16:26AM +0200, Daniel Bristot de Oliveira wrote:
> On 8/4/21 3:59 PM, Dietmar Eggemann wrote:
> > A missing clock update is causing the following warning:
> > 
> > rq->clock_update_flags < RQCF_ACT_SKIP
> > WARNING: CPU: 112 PID: 2041 at kernel/sched/sched.h:1453
> > sub_running_bw.isra.0+0x190/0x1a0
> > ...
> > CPU: 112 PID: 2041 Comm: sugov:112 Tainted: G W 5.14.0-rc1 #1
> > Hardware name: WIWYNN Mt.Jade Server System
> > B81.030Z1.0007/Mt.Jade Motherboard, BIOS 1.6.20210526 (SCP:
> > 1.06.20210526) 2021/05/26
> > ...
> > Call trace:
> >   sub_running_bw.isra.0+0x190/0x1a0
> >   migrate_task_rq_dl+0xf8/0x1e0
> >   set_task_cpu+0xa8/0x1f0
> >   try_to_wake_up+0x150/0x3d4
> >   wake_up_q+0x64/0xc0
> >   __up_write+0xd0/0x1c0
> >   up_write+0x4c/0x2b0
> >   cppc_set_perf+0x120/0x2d0
> >   cppc_cpufreq_set_target+0xe0/0x1a4 [cppc_cpufreq]
> >   __cpufreq_driver_target+0x74/0x140
> >   sugov_work+0x64/0x80
> >   kthread_worker_fn+0xe0/0x230
> >   kthread+0x138/0x140
> >   ret_from_fork+0x10/0x18
> > 
> > The task causing this is the `cppc_fie` DL task introduced by
> > commit 1eb5dde674f5 ("cpufreq: CPPC: Add support for frequency
> > invariance").
> > 
> > With CONFIG_ACPI_CPPC_CPUFREQ_FIE=y and schedutil cpufreq governor on
> > slow-switching system (like on this Ampere Altra WIWYNN Mt. Jade Arm
> > Server):
> > 
> > DL task `curr=sugov:112` lets `p=cppc_fie` migrate and since the latter
> > is in `non_contending` state, migrate_task_rq_dl() calls
> > 
> >   sub_running_bw()->__sub_running_bw()->cpufreq_update_util()->
> >   rq_clock()->assert_clock_updated()
> > 
> > on p.
> > 
> > Fix this by updating the clock for a non_contending task in
> > migrate_task_rq_dl() before calling sub_running_bw().
> > 
> > Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
