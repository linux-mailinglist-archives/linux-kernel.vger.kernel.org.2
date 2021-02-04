Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF2430F482
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhBDOEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbhBDOBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:01:31 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA9DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tFbUE2BAlkR7eHrPeMaw32l4jorlo3n3mpeT61my3SQ=; b=1KYCkcwOjf3sgHciHRLJffcHb3
        iO2tIJZ1eloyOzXgFquNHeDl3M+sIdv+yJcVANVvP5igPPk5V5/VuiC/YfgidOWHBrz6ea3Hg9xNh
        fLaqRJ6LYIAlVubXWHK/+SGwg8dBemjMpIuGKGRn5BzrE/oJCYizaaB/VlWv8wsHnQ1XHu/m1FNe2
        n2YyL00wC6vYfnD9T76FP3ek7xBHV4eH+jtK2jcEyyWRa8P21SE5VS6TeKw/09ay38q0CT13mpcMt
        4FuefYdKf7X+6n6WKMJv/2ospvOp/hK/7k2XhOwnoc+rJ+nH7zHMjNwX+p23TKP7oqz1veJrSY1pb
        DX8axWHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7fAu-0008Rc-G6; Thu, 04 Feb 2021 14:00:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9035130066E;
        Thu,  4 Feb 2021 14:59:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 745312C12E919; Thu,  4 Feb 2021 14:59:58 +0100 (CET)
Date:   Thu, 4 Feb 2021 14:59:58 +0100
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
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core
 scheduling
Message-ID: <YBv93iXqI8UTw9tD@hirez.programming.kicks-ass.net>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org>
 <YBrUgxLfjcpjwgo6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBrUgxLfjcpjwgo6@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 05:51:15PM +0100, Peter Zijlstra wrote:
> 
> I'm slowly starting to go through this...
> 
> On Fri, Jan 22, 2021 at 08:17:01PM -0500, Joel Fernandes (Google) wrote:
> > +static bool sched_core_empty(struct rq *rq)
> > +{
> > +	return RB_EMPTY_ROOT(&rq->core_tree);
> > +}
> > +
> > +static struct task_struct *sched_core_first(struct rq *rq)
> > +{
> > +	struct task_struct *task;
> > +
> > +	task = container_of(rb_first(&rq->core_tree), struct task_struct, core_node);
> > +	return task;
> > +}
> 
> AFAICT you can do with:
> 
> static struct task_struct *sched_core_any(struct rq *rq)
> {
> 	return rb_entry(rq->core_tree.rb_node, struct task_struct, code_node);
> }
> 
> > +static void sched_core_flush(int cpu)
> > +{
> > +	struct rq *rq = cpu_rq(cpu);
> > +	struct task_struct *task;
> > +
> > +	while (!sched_core_empty(rq)) {
> > +		task = sched_core_first(rq);
> > +		rb_erase(&task->core_node, &rq->core_tree);
> > +		RB_CLEAR_NODE(&task->core_node);
> > +	}
> > +	rq->core->core_task_seq++;
> > +}
> 
> However,
> 
> > +	for_each_possible_cpu(cpu) {
> > +		struct rq *rq = cpu_rq(cpu);
> > +
> > +		WARN_ON_ONCE(enabled == rq->core_enabled);
> > +
> > +		if (!enabled || (enabled && cpumask_weight(cpu_smt_mask(cpu)) >= 2)) {
> > +			/*
> > +			 * All active and migrating tasks will have already
> > +			 * been removed from core queue when we clear the
> > +			 * cgroup tags. However, dying tasks could still be
> > +			 * left in core queue. Flush them here.
> > +			 */
> > +			if (!enabled)
> > +				sched_core_flush(cpu);
> > +
> > +			rq->core_enabled = enabled;
> > +		}
> > +	}
> 
> I'm not sure I understand. Is the problem that we're still schedulable
> during do_exit() after cgroup_exit() ? It could be argued that when we
> leave the cgroup there, we should definitely leave the tag group too.

That is, did you forget to implement cpu_cgroup_exit()?
