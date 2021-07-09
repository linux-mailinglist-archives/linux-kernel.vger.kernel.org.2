Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0473C2212
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhGIKJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhGIKJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:09:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A752C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 03:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nWtuvjlUby+2YW9qFVAVvushQo1QCbdC5Mln1a1Goe0=; b=erC+chGa43xVyRkrhkhgvpaVwS
        b/Ksn3tS8xCCIJbVKBlWWveYqegJ8hcyaP1XByVgkPJlZPx6Cm111zdHisjbNJC3TeixztnG8cCIY
        ozyiU0cojOwXAE/MhXCE6sTXmYHJxeljorfyzuj/mk+/dcLBM3uvAWa+aqOAiLjz2tUts056WDBjd
        iO18meDVNg15YEeaarZeYKkx+oaGRpTXV6VPssjSXLu29BS3ctLFxt1dP8he89DZvjiU+KIbpJ55k
        uh8fR3qCewgiIHtewj/gvdEpeV7wOi/YN7ooBOidq8159XWl5gsyBFHxzeyt+nvefkuxCcUlzzCjO
        Km72sYrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1n5p-00ENHp-Ov; Fri, 09 Jul 2021 09:46:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 10A59300233;
        Fri,  9 Jul 2021 11:46:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C43A52058B98A; Fri,  9 Jul 2021 11:46:43 +0200 (CEST)
Date:   Fri, 9 Jul 2021 11:46:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     zhouchuangao <zhouchuangao@vivo.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sched/core: Print the time when the process
 entered the D state
Message-ID: <YOgbA/+Mm+tHKwqN@hirez.programming.kicks-ass.net>
References: <1625807160-112041-1-git-send-email-zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625807160-112041-1-git-send-email-zhouchuangao@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 10:05:59PM -0700, zhouchuangao wrote:
> Sometimes we need to trigger /proc/sysrq-trigger to view the information
> of the D state process in the system.
> e.g:
> echo w > /proc/sysrq-trigger
> 
> Here we print the scheduling time of the process, which is convenient
> for us to judge the state of the system and for debugging.
> 
> Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
> ---
>  kernel/sched/core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index cf16f8f..e03474d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8154,9 +8154,10 @@ void sched_show_task(struct task_struct *p)
>  	if (pid_alive(p))
>  		ppid = task_pid_nr(rcu_dereference(p->real_parent));
>  	rcu_read_unlock();
> -	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx\n",
> +	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx sched:%llu\n",
>  		free, task_pid_nr(p), ppid,
> -		(unsigned long)task_thread_info(p)->flags);
> +		(unsigned long)task_thread_info(p)->flags,
> +		p->sched_info.last_arrival);

How's that not a compile fail for SCHED_INFO=n ?
