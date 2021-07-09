Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8FE3C23F6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhGINJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhGINJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:09:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9E2C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MHl6PjKelgshfUpwifUdwaVS5ADSo7pyK3UmQuoRtkg=; b=q7CzdxV2I2+j1/WtUAo8h9Wd5v
        J8KiroIDfJAxtxiZksr/kDsrh9Kx2O0AGelqrEDAam4aciLnQrI6/T6sD7xDb1MKv/26oEFkKnrAk
        QHo9QT/cS/8FdQe47oldXbZbw/TqFSXZAA1lAbwCSvDNFthMyLUMje8NJzxsUy6uivM7tb9WytS9x
        2VkRU1gRI4bYdhnY9fiwGFJWbPvhnu+apSbCslehwr4z0p3PyQz1cVz0lCFiUVEV4MIX6XDyPJjp8
        mI54CMdRmWviP0R6QCXAqPm1JEckbPVUnM+k7AQgADWTHQe4k4Xx/IoZ0UB4cLKdTFdFLn4RJNS3X
        w4E4Nynw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1qD3-00G5RF-7v; Fri, 09 Jul 2021 13:06:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4971300233;
        Fri,  9 Jul 2021 15:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 828A2200E1E64; Fri,  9 Jul 2021 15:06:23 +0200 (CEST)
Date:   Fri, 9 Jul 2021 15:06:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     zhouchuangao <zhouchuangao@vivo.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/sched/core: Print the time when the process
 entered the D state
Message-ID: <YOhJz84zdiSkJvST@hirez.programming.kicks-ass.net>
References: <1625831689-122629-1-git-send-email-zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625831689-122629-1-git-send-email-zhouchuangao@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 04:54:49AM -0700, zhouchuangao wrote:
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
>  kernel/sched/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index cf16f8f..ab422ab 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8154,10 +8154,12 @@ void sched_show_task(struct task_struct *p)
>  	if (pid_alive(p))
>  		ppid = task_pid_nr(rcu_dereference(p->real_parent));
>  	rcu_read_unlock();
> -	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx\n",
> +	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx",
>  		free, task_pid_nr(p), ppid,
>  		(unsigned long)task_thread_info(p)->flags);
> -
> +#ifdef CONFIG_SCHED_INFO
> +	pr_cont(" sched:%llu\n", p->sched_info.last_arrival);

"sched:" isn't really descriptive here, is it?

> +#endif

Also, you lost the "\n" for SCHED_INFO=n.

Please, take more than 5 minutes to fix the issues and test your patch
before sending it again.

>  	print_worker_info(KERN_INFO, p);
>  	print_stop_info(KERN_INFO, p);
>  	show_stack(p, NULL, KERN_INFO);
> -- 
> 2.7.4
> 
