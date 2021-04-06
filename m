Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F0B35499E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 02:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbhDFASS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 20:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:32876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241600AbhDFASR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 20:18:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91602613DF;
        Tue,  6 Apr 2021 00:18:09 +0000 (UTC)
Date:   Mon, 5 Apr 2021 20:18:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] sched/debug: Use sched_debug_lock to serialize use
 of cgroup_path[] only
Message-ID: <20210405201807.4ee7778d@gandalf.local.home>
In-Reply-To: <20210405234203.23526-1-longman@redhat.com>
References: <20210405234203.23526-1-longman@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Apr 2021 19:42:03 -0400
Waiman Long <longman@redhat.com> wrote:

> +/*
> + * All the print_cpu() callers from sched_debug_show() will be allowed
> + * to contend for sched_debug_lock and use group_path[] as their SEQ_printf()
> + * calls will be much faster. However only one print_cpu() caller from
> + * sysrq_sched_debug_show() which outputs to the console will be allowed
> + * to use group_path[]. Another parallel console writer will have to use
> + * a shorter stack buffer instead. Since the console output will be garbled
> + * anyway, truncation of some cgroup paths shouldn't be a big issue.
> + */
> +#define SEQ_printf_task_group_path(m, tg, fmt...)			\
> +{									\
> +	unsigned long flags;						\
> +	int token = m ? TOKEN_NA					\
> +		      : xchg_acquire(&console_token, TOKEN_NONE);	\
> +									\
> +	if (token == TOKEN_NONE) {					\
> +		char buf[128];						\
> +		task_group_path(tg, buf, sizeof(buf));			\
> +		SEQ_printf(m, fmt, buf);				\
> +	} else {							\
> +		spin_lock_irqsave(&sched_debug_lock, flags);		\
> +		task_group_path(tg, group_path, sizeof(group_path));	\
> +		SEQ_printf(m, fmt, group_path);				\
> +		spin_unlock_irqrestore(&sched_debug_lock, flags);	\
> +		if (token == TOKEN_ACQUIRED)				\
> +			smp_store_release(&console_token, token);	\
> +	}								\
>  }
>  #endif

And you said my suggestion was complex!

I'll let others review this.

-- Steve
