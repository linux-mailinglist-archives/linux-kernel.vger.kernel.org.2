Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BED030FCD0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbhBDTac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbhBDOye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:54:34 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D87DC061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eP1V3TSpPXmQZ6Iaw87n257Y5591XfLc3An7kGyi4kI=; b=orrfsRHvpJPtMIBC53dBItHHHV
        MkgElGDNKsNh/M8QlxNTfwJyrD+XhiulESI2lfNOdXB2QFJAlG36ab0Lua+zWHcUFSe3MuSBragtm
        O9+f+XpHwrEHT+2Mskdp9fDf8AhXDTvcZENhPRQtakFAT4rP8MYohaIkTnUm6mYEVWTUF24E8ZAkj
        cn6wxHqJIJa6MMXnHe2CHqjLBDUq9oxPgV/k0Ef7BJN44UzAr4IsGisWKKW+q4ZF4OPkoQl+b7uSb
        vnz138/ogrbCFK9FI4LAcaX3fanyOZ3OIZ3JXwoVfbnBYbI7UQfBCz4+SUJI5fiKRBLzlqsTc29Jp
        1laoa31g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7g0A-0005Dq-HR; Thu, 04 Feb 2021 14:52:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E12203003D8;
        Thu,  4 Feb 2021 15:52:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C22082138F7C4; Thu,  4 Feb 2021 15:52:53 +0100 (CET)
Date:   Thu, 4 Feb 2021 15:52:53 +0100
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
Message-ID: <YBwKRaNKJ8lD8DgZ@hirez.programming.kicks-ass.net>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123011704.1901835-3-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 08:17:01PM -0500, Joel Fernandes (Google) wrote:
> +static void sched_core_update_cookie(struct task_struct *p, unsigned long cookie,
> +				     enum sched_core_cookie_type cookie_type)
> +{
> +	struct rq_flags rf;
> +	struct rq *rq;
> +
> +	if (!p)
> +		return;
> +
> +	rq = task_rq_lock(p, &rf);
> +
> +	switch (cookie_type) {
> +	case sched_core_task_cookie_type:
> +		p->core_task_cookie = cookie;
> +		break;
> +	case sched_core_group_cookie_type:
> +		p->core_group_cookie = cookie;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +	}
> +
> +	/* Set p->core_cookie, which is the overall cookie */
> +	__sched_core_update_cookie(p);
> +
> +	if (sched_core_enqueued(p)) {
> +		sched_core_dequeue(rq, p);
> +		if (!p->core_cookie) {
> +			task_rq_unlock(rq, p, &rf);
> +			return;
> +		}
> +	}
> +
> +	if (sched_core_enabled(rq) &&
> +	    p->core_cookie && task_on_rq_queued(p))
> +		sched_core_enqueue(task_rq(p), p);
> +
> +	/*
> +	 * If task is currently running or waking, it may not be compatible
> +	 * anymore after the cookie change, so enter the scheduler on its CPU
> +	 * to schedule it away.
> +	 */
> +	if (task_running(rq, p) || p->state == TASK_WAKING)
> +		resched_curr(rq);

I'm not immediately seeing the need for that WAKING test. Since we're
holding it's rq->lock, the only place that task can be WAKING is on the
wake_list. And if it's there, it needs to acquire rq->lock to get
enqueued, and rq->lock again to get scheduled.

What am I missing?

> +
> +	task_rq_unlock(rq, p, &rf);
> +}
