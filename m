Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE30230E022
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhBCQxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhBCQxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:53:01 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90361C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 08:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LRuQQ/TiLUC5JMAELdQabsqA6mbE/jmkJNaJ/Pha76M=; b=1xIHBqiQDaxysRCpMbX7WOMuVm
        OnJDi9V/wvFQrkhskS91PLYPDeO6S4h4jnJasd7F7kEt/9nBqEqnxZ0fdYK2Hy7ks1lFS/O3DaVSn
        YDmdvvvmqnotiUzU6G0KoVWxZGP5iJ1rOED6tNQGG1tRRtLLVbhVnzqXQw2VvXaPamaKGn9ivFcXr
        /wHiQkn4vQuo7YvLlwgoWV+9mS9pbBb6SwVDNIApdoNcsKUbDV1MkC1EO51+lnyVq/hKspBN86PZR
        UtVleQB0kMySe1pReRs88IPrXNTwoR7Q6BWo0Iq6C1fI0GGZxk5vK91kbJqwDEDZc9V4bXH2gQhho
        e8poS0uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7LN9-0003cz-Oh; Wed, 03 Feb 2021 16:51:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4FF930066E;
        Wed,  3 Feb 2021 17:51:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BEA682C18B5C7; Wed,  3 Feb 2021 17:51:15 +0100 (CET)
Date:   Wed, 3 Feb 2021 17:51:15 +0100
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
Message-ID: <YBrUgxLfjcpjwgo6@hirez.programming.kicks-ass.net>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123011704.1901835-3-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm slowly starting to go through this...

On Fri, Jan 22, 2021 at 08:17:01PM -0500, Joel Fernandes (Google) wrote:
> +static bool sched_core_empty(struct rq *rq)
> +{
> +	return RB_EMPTY_ROOT(&rq->core_tree);
> +}
> +
> +static struct task_struct *sched_core_first(struct rq *rq)
> +{
> +	struct task_struct *task;
> +
> +	task = container_of(rb_first(&rq->core_tree), struct task_struct, core_node);
> +	return task;
> +}

AFAICT you can do with:

static struct task_struct *sched_core_any(struct rq *rq)
{
	return rb_entry(rq->core_tree.rb_node, struct task_struct, code_node);
}

> +static void sched_core_flush(int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +	struct task_struct *task;
> +
> +	while (!sched_core_empty(rq)) {
> +		task = sched_core_first(rq);
> +		rb_erase(&task->core_node, &rq->core_tree);
> +		RB_CLEAR_NODE(&task->core_node);
> +	}
> +	rq->core->core_task_seq++;
> +}

However,

> +	for_each_possible_cpu(cpu) {
> +		struct rq *rq = cpu_rq(cpu);
> +
> +		WARN_ON_ONCE(enabled == rq->core_enabled);
> +
> +		if (!enabled || (enabled && cpumask_weight(cpu_smt_mask(cpu)) >= 2)) {
> +			/*
> +			 * All active and migrating tasks will have already
> +			 * been removed from core queue when we clear the
> +			 * cgroup tags. However, dying tasks could still be
> +			 * left in core queue. Flush them here.
> +			 */
> +			if (!enabled)
> +				sched_core_flush(cpu);
> +
> +			rq->core_enabled = enabled;
> +		}
> +	}

I'm not sure I understand. Is the problem that we're still schedulable
during do_exit() after cgroup_exit() ? It could be argued that when we
leave the cgroup there, we should definitely leave the tag group too.



