Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2DE3712F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 11:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhECJ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 05:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhECJZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 05:25:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB0CC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 02:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s5o4vQEaLgwOoh1Fmib+Iw0/gAmMNldp6drCnbbZgvY=; b=Uu/ARTImKC4N7vnpFJa3kmMyPb
        /9cjibnjkckAJ52ZVzcCVri5qz3xM8ECZ5uQMQOqSxXu4vna7m0EyloQwnopMpNJD9K3MgdFMzMgm
        4g+anLCjTe06hPV3b0OxGZ34pvRgDcjZdVvv3HklDs3shUYZ6DeyOpxm/Wdu1s9h93fawZvF9zk6R
        xE0sHetZJN8wgKDfAPeFkCoUxIDWSksplFya1pFOLkzUqwwmb8wu9ATf5NF2yuVgo2aOuYq5x7W2r
        MyAtykWX1/UgSbDDcceBpuAa1SEFbViRdFt5UqQXfpoggLIHOzgLkd4y+lDsUFCq7aKhLlaUGOAmg
        vz0LKY+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldUoX-00DWs0-4T; Mon, 03 May 2021 09:24:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0F5E3001D0;
        Mon,  3 May 2021 11:24:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A24612BC22555; Mon,  3 May 2021 11:24:25 +0200 (CEST)
Date:   Mon, 3 May 2021 11:24:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.comi>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2 1/4] sched/fair: Optimize checking for
 group_asym_packing
Message-ID: <YI/BSZ9OkOqCp/0F@hirez.programming.kicks-ass.net>
References: <20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com>
 <20210414020436.12980-2-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414020436.12980-2-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 07:04:33PM -0700, Ricardo Neri wrote:
> By checking local_group, we can avoid additional checks and invoking
> sched_asmy_prefer() when it is not needed.

This really could do with a few words on *why* that is correct. ISTR
thinking this made sense when I last looked at it, but today, after
having the brain reset by not looking at a computer for 4 days its not
immediate obvious anymore.

> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce20da67..4ef3fa0d5e8d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8455,7 +8455,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  	}
>  
>  	/* Check if dst CPU is idle and preferred to this group */
> -	if (env->sd->flags & SD_ASYM_PACKING &&
> +	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
>  	    env->idle != CPU_NOT_IDLE &&
>  	    sgs->sum_h_nr_running &&
>  	    sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
> -- 
> 2.17.1
> 
