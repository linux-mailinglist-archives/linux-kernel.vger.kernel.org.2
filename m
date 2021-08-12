Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225BB3EA6A9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbhHLOi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:38:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236908AbhHLOi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:38:59 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC3506108C;
        Thu, 12 Aug 2021 14:38:32 +0000 (UTC)
Date:   Thu, 12 Aug 2021 10:38:26 -0400
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
Message-ID: <20210812103826.27dfad5f@oasis.local.home>
In-Reply-To: <20210812110534.82349-1-shirish.s@amd.com>
References: <20210812110534.82349-1-shirish.s@amd.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 16:35:34 +0530
Shirish S <shirish.s@amd.com> wrote:

> This addition in the debug output shall improve readablitly..
> Its not intuitive for users that the pid printed in last column
> is of parent process.
> 
> Without this patch:
> 	localhost ~ # dmesg -w &
> 	localhost ~ # echo w > /proc/sysrq-trigger
> 	[22148.730225] sysrq: Show Blocked State
> 	localhost ~ #
> 
> With this patch:
> 	localhost ~ # dmesg -w &
> 	localhost ~ # echo w > /proc/sysrq-trigger
> 	[   99.979365] sysrq: Show Blocked State
> -->	[   99.983471]   task                        PC stack   pid father  
> 	localhost ~ #
> 

It would had been more informative, if there were content to those lists.

Just a few lines would be good enough. But the above, just looks like
you are adding a useless header. :-/

In fact, I would argue that the title should not be displayed if the
content is empty.

Also, s/father/parent/  or s/father/ppid/

-- Steve



> v2: Dropped #ifdef logic
> v3: Sample output in commit message
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 20ffcc044134..1c7ea3ef5a9f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8174,6 +8174,9 @@ void show_state_filter(unsigned int state_filter)
>  {
>  	struct task_struct *g, *p;
>  
> +	pr_info("  task%*s", BITS_PER_LONG == 32 ? 38 : 46,
> +		"PC stack   pid father\n");
> +
>  	rcu_read_lock();
>  	for_each_process_thread(g, p) {
>  		/*

