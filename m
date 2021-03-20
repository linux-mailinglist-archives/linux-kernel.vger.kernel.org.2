Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EB7342DD1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhCTPgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhCTPgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:36:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C377C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m/lHHBauPJoTi+xzkV1LtzuzjqXxwKLqACh+FHnxGBU=; b=LgNJtdggLE5+sv3lPkc+znvkby
        3o9HPbUyjQXWz0D67uM5Hq8DXEOqfzoPS1BriJnayxUccdPFZFBjJ8GZ59MQIgLT0UmmSjOZfq+t7
        XPzE9jr9i6pNjTTXWAVsY9xuPt63vpo6PVBzWywa+1SOde3Y/fWZq9zE8SWuNxYyjQoXfG9X5N95I
        BJGd3JjkKCXJ18sJxxR0bcGNxGiugyVAiqU5Hilm748jEQEzRw2CdZj8/6Cfzd9qSFExBx/fi1raS
        Wkoazp9qBq+EkitD6KfVbG2f0fjFyXms8tIxNANJ0S/Dc+P1T7wJ3qKAXUh0/onqcQlZATJ/vJcsj
        RLdL+jYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNdcx-008zTy-0R; Sat, 20 Mar 2021 15:34:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D57BF9864FF; Sat, 20 Mar 2021 16:34:57 +0100 (CET)
Date:   Sat, 20 Mar 2021 16:34:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>, chris.hyser@oracle.com,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH 1/6] sched: migration changes for core scheduling
Message-ID: <20210320153457.GX4746@worktop.programming.kicks-ass.net>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
 <20210319203253.3352417-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319203253.3352417-2-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 04:32:48PM -0400, Joel Fernandes (Google) wrote:
> @@ -7530,8 +7543,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	 * We do not migrate tasks that are:
>  	 * 1) throttled_lb_pair, or
>  	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
> -	 * 3) running (obviously), or
> -	 * 4) are cache-hot on their current CPU.
> +	 * 3) task's cookie does not match with this CPU's core cookie
> +	 * 4) running (obviously), or
> +	 * 5) are cache-hot on their current CPU.
>  	 */
>  	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>  		return 0;
> @@ -7566,6 +7580,13 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  		return 0;
>  	}
>  
> +	/*
> +	 * Don't migrate task if the task's cookie does not match
> +	 * with the destination CPU's core cookie.
> +	 */
> +	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
> +		return 0;
> +
>  	/* Record that we found atleast one task that could run on dst_cpu */
>  	env->flags &= ~LBF_ALL_PINNED;
>  

This one is too strong.. persistent imbalance should be able to override
it.
