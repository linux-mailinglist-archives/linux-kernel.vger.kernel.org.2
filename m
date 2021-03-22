Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446EF343AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCVHwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhCVHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:51:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB88C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 00:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dt6zatLr1ldkapFUiR5unNuPn3qs8/VkjkQr1MrohGw=; b=XktlvvZbNG4e7JUjyiOiXvbGSS
        FPdV0amIImt4ImS2le+tAdlqavcURgIRlkzZfkNtOm5Ds0oxGONLWWku/R5CpAAjlt9NWCB4YCeqK
        l6sK0aYrjrdPVH1f+jmN/RxabXXd/sRL7V4nw7p5nXBugZTBx4KAJhK5Ojk0Wc2L3ZuGI+tM3/YWt
        VmhUHJEUZ6VvZ5+Yy6oaTi8Z2QZnTIld2+Fy/R/5NvvOzR2vUQd8HDVqGoM+/sNFJNrr8gFrIssjG
        /mnJUex5KFuZeMPhwcl5HsM4NvYFI6ndoF9ck81wKqNd1M6qrJKCT3bjWa/Xe6b1AlaRIO+0j7C3F
        9l+BBzTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOFIy-008ASg-KT; Mon, 22 Mar 2021 07:48:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1755F301A32;
        Mon, 22 Mar 2021 08:48:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ECFAF2CF553EB; Mon, 22 Mar 2021 08:48:48 +0100 (CET)
Date:   Mon, 22 Mar 2021 08:48:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [PATCH 1/6] sched: migration changes for core scheduling
Message-ID: <YFhL4CMPB+Pfo965@hirez.programming.kicks-ass.net>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
 <20210319203253.3352417-2-joel@joelfernandes.org>
 <20210320153457.GX4746@worktop.programming.kicks-ass.net>
 <28e13609-c526-c6ee-22a3-898652aed5e6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e13609-c526-c6ee-22a3-898652aed5e6@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 09:34:00PM +0800, Li, Aubrey wrote:
> Hi Peter,
> 
> On 2021/3/20 23:34, Peter Zijlstra wrote:
> > On Fri, Mar 19, 2021 at 04:32:48PM -0400, Joel Fernandes (Google) wrote:
> >> @@ -7530,8 +7543,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
> >>  	 * We do not migrate tasks that are:
> >>  	 * 1) throttled_lb_pair, or
> >>  	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
> >> -	 * 3) running (obviously), or
> >> -	 * 4) are cache-hot on their current CPU.
> >> +	 * 3) task's cookie does not match with this CPU's core cookie
> >> +	 * 4) running (obviously), or
> >> +	 * 5) are cache-hot on their current CPU.
> >>  	 */
> >>  	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
> >>  		return 0;
> >> @@ -7566,6 +7580,13 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
> >>  		return 0;
> >>  	}
> >>  
> >> +	/*
> >> +	 * Don't migrate task if the task's cookie does not match
> >> +	 * with the destination CPU's core cookie.
> >> +	 */
> >> +	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
> >> +		return 0;
> >> +
> >>  	/* Record that we found atleast one task that could run on dst_cpu */
> >>  	env->flags &= ~LBF_ALL_PINNED;
> >>  
> > 
> > This one is too strong.. persistent imbalance should be able to override
> > it.
> > 
> 
> IIRC, this change can avoid the following scenario:
> 
> One sysbench cpu thread(cookieA) and sysbench mysql thread(cookieB) running
> on the two siblings of core_1, the other sysbench cpu thread(cookieA) and
> sysbench mysql thread(cookieB) running on the two siblings of core2, which
> causes 50% force idle.
> 
> This is not an imbalance case.

But suppose there is an imbalance; then this cookie crud can forever
stall balance.

Imagine this cpu running a while(1); with a uniqie cookie on, then it
will _never_ accept other tasks == BAD.
