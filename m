Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C80542F21E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239400AbhJON2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:28:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232715AbhJON2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:28:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69A41611C3;
        Fri, 15 Oct 2021 13:26:43 +0000 (UTC)
Date:   Fri, 15 Oct 2021 09:26:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        yangyicong@hisilicon.com, Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] sched/fair: document the slow path and fast path in
 select_task_rq_fair
Message-ID: <20211015092641.2266cf59@gandalf.local.home>
In-Reply-To: <20211015041412.5569-1-21cnbao@gmail.com>
References: <20211015041412.5569-1-21cnbao@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 12:14:12 +0800
Barry Song <21cnbao@gmail.com> wrote:

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6951,6 +6951,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  			break;
>  		}
>  
> +		/*
> +		 * This is usually true only for WF_EXEC and WF_FORK, for WF_TTWU
> +		 * it is almost always false as sched_domain hasn't SD_BALANCE_WAKE
> +		 * in default

Comments are fine, but the above needs some grammar work.

		/*
		 * Usually only true for WF_EXEC and WF_FORK, as
		 * sched_domains usually do not have SD_BALANCE_WAKE set.
		 */

?

> +		 */
>  		if (tmp->flags & sd_flag)
>  			sd = tmp;
>  		else if (!want_affine)
> @@ -6958,7 +6963,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  	}
>  
>  	if (unlikely(sd)) {
> -		/* Slow path */
> +		/*
> +		 * Slow path, usually only for WF_EXEC and WF_FORK; WF_TTWU almost
> +		 * always goes to fast path as sched_domain hasn't SD_BALANCE_WAKE
> +		 * in default
> +		 */

As the only way to have sd set, is from the above if statement, I believe
this comment is redundant.

-- Steve


>  		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
>  	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
>  		/* Fast path */
