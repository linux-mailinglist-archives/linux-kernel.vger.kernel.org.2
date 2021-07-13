Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00263C73B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbhGMQCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237091AbhGMQCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:02:45 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33CBA610C7;
        Tue, 13 Jul 2021 15:59:54 +0000 (UTC)
Date:   Tue, 13 Jul 2021 11:59:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shirish S <shirish.s@amd.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/debug: print column titles of show_state_filter()
Message-ID: <20210713115947.1c3bdbb8@oasis.local.home>
In-Reply-To: <20210713110518.52243-1-shirish.s@amd.com>
References: <20210713110518.52243-1-shirish.s@amd.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2021 16:35:18 +0530
Shirish S <shirish.s@amd.com> wrote:

> This addition in the debug output shall improve readablitly..
> Its not intuitive for users that the pid printed in last column
> is of parent process.
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>
> ---
>  kernel/sched/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d9ff40f4661..d95d46a89e7e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8194,6 +8194,11 @@ void show_state_filter(unsigned int state_filter)
>  {
>  	struct task_struct *g, *p;
>  
> +#if BITS_PER_LONG == 32
> +	pr_info("  task                PC stack   pid father\n");
> +#else
> +	pr_info("  task                        PC stack   pid father\n");
> +#endif

Or remove the ugly #ifdef logic and just have:

	pr_info("  task%*s", BITS_PER_LONG == 32 ? 38 : 46,
		"PC stack   pid father\n");

-- Steve

>  	rcu_read_lock();
>  	for_each_process_thread(g, p) {
>  		/*

