Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A704C3E92CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhHKNhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhHKNhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:37:31 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085EC604D7;
        Wed, 11 Aug 2021 13:37:06 +0000 (UTC)
Date:   Wed, 11 Aug 2021 09:36:59 -0400
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
Subject: Re: [PATCH] sched/debug: print column titles of
 show_state_filter()[V2]
Message-ID: <20210811093659.4177e890@oasis.local.home>
In-Reply-To: <20210714032705.79726-1-shirish.s@amd.com>
References: <20210714032705.79726-1-shirish.s@amd.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 08:57:05 +0530
Shirish S <shirish.s@amd.com> wrote:

> This addition in the debug output shall improve readablitly..
> Its not intuitive for users that the pid printed in last column
> is of parent process.

Hi Shirish,

perhaps add a before and after output to show people what you are
trying to improve, and that can help the maintainers see if it is a
useful patch or not.

Note, I'm only a reviewer of scheduling code, I'm not one that can pull
in the patch.

-- Steve


> 
> v2: Dropped #ifdef logic
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d9ff40f4661..22cee4c0f4b1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8194,6 +8194,9 @@ void show_state_filter(unsigned int state_filter)
>  {
>  	struct task_struct *g, *p;
>  
> +	pr_info("  task%*s", BITS_PER_LONG == 32 ? 38 : 46,
> +		"PC stack   pid father\n");
> +
>  	rcu_read_lock();
>  	for_each_process_thread(g, p) {
>  		/*

