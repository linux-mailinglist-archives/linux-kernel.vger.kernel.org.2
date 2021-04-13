Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B80B35E152
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhDMOYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhDMOYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:24:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9145C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=deY/9d9Hz6tWJgl4rOEiB2UW/dKEJlVldD6F7jVBx1g=; b=nT7qnaFUxiNqyfEJW0ue3nG2+k
        jWvpIjhM2j9zXgnz7Renjkn5YjUAyTeI0UzFaZd7CV7Jk8uZUIHmI7+a2yZqwsIGFSeTYaUus8R/E
        J/V+n0p6XMa2U3KpB6DgzUcAO0LuFpGr6JZgguSLw/eF1N0sChR5/+fFci845rxPRwoVk6Jevl0CK
        ++UpKdIG2UUxXv6vHXJkaGi2AlUuvIl14SIp4rxc4KvcS7qe+0mPnzodLaKqWT+sQt/h3haeNUab4
        orE+/DyJVie+Y1sCqswt7pq7cDLPzJftUEE2UHFlhK3lH+JeE+SXnJpEeONzBZixQR1nmm7CITifT
        g1kVvZfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWJxj-009VAP-M0; Tue, 13 Apr 2021 14:24:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85EDB300033;
        Tue, 13 Apr 2021 16:24:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49D212011333C; Tue, 13 Apr 2021 16:24:18 +0200 (CEST)
Date:   Tue, 13 Apr 2021 16:24:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     qianjun.kernel@gmail.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched/fair:Reduce unnecessary check preempt in the
 sched tick
Message-ID: <YHWpknBamqQz2rpJ@hirez.programming.kicks-ass.net>
References: <20210413131842.44430-1-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413131842.44430-1-qianjun.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 09:18:42PM +0800, qianjun.kernel@gmail.com wrote:
> From: jun qian <qianjun.kernel@gmail.com>
> 
> If it has been determined that the current cpu need resched in the
> early stage of for_each_sched_entity, then there is no need to check
> preempt in the subsequent se->parent entity_tick.

Right, but does it actually do anything, except increase linecount?

> Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> ---
>  kernel/sched/fair.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1a68a0536add..c0d135100d54 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4352,8 +4352,13 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  {
>  	unsigned long ideal_runtime, delta_exec;
>  	struct sched_entity *se;
> +	struct rq *rq = rq_of(cfs_rq);
>  	s64 delta;
>  
> +	/* If the TIF_NEED_RESCHED has been set, it is no need to check again */
> +	if (test_tsk_need_resched(rq->curr))
> +		return;
> +
>  	ideal_runtime = sched_slice(cfs_rq, curr);
>  	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
>  	if (delta_exec > ideal_runtime) {

Also, I think that's placed wrong; this way we can mis clear_buddies().
