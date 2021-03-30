Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCDB34E472
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhC3Jb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhC3JbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:31:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA4EC061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EUmKC+YPtejvVccmAnyiDLoPlCvMPqkpWiSRatVK+w8=; b=a4UXMm4PtJM/MuF4repauTtOzc
        5t40u0vMNA/dheaqLHcEj3p/m3z4UaKQlFR8x5mx/O3oO5KJpQk2c3Tp+rlOoQeiSnCZu93uiK3ia
        CRYzHKo+DX1Dnyen8X2FUg9cvsjB6JfsC66u8Vo81KMcqllanUSFdAHLsDPNCaY+rZ5p/SSvQuScZ
        KWaLWzL5dAoyab9ywPvqUScIsUy7m9EX0cID9eSYnds02J3x3Ym2cW/KorK25GFIr9TQgzmeJQtCd
        JHZ3eCGbF36xAM5K/upDptOX8MiAdzwPfamRyuPBc4DCAAAXVMDHWk3ma8WavNZNGo20o7KtK5g1j
        /BfHYMrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRAeC-002mpR-D6; Tue, 30 Mar 2021 09:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 126B5304B90;
        Tue, 30 Mar 2021 11:26:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED98E200D0255; Tue, 30 Mar 2021 11:26:46 +0200 (CEST)
Date:   Tue, 30 Mar 2021 11:26:46 +0200
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
        dhiatt@digitalocean.com, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH resend 5/8] sched: cgroup cookie API for core scheduling
Message-ID: <YGLu1swpZPq4nhJk@hirez.programming.kicks-ass.net>
References: <20210324214020.34142-1-joel@joelfernandes.org>
 <20210324214020.34142-6-joel@joelfernandes.org>
 <YGLt/ltwa92lfCDK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGLt/ltwa92lfCDK@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


*sigh*, +tj

On Tue, Mar 30, 2021 at 11:23:10AM +0200, Peter Zijlstra wrote:
> On Wed, Mar 24, 2021 at 05:40:17PM -0400, Joel Fernandes (Google) wrote:
> > From: Josh Don <joshdon@google.com>
> > 
> > This adds the API to set/get the cookie for a given cgroup. This
> > interface lives at cgroup/cpu.core_tag.
> > 
> > The cgroup interface can be used to toggle a unique cookie value for all
> > descendent tasks, preventing these tasks from sharing with any others.
> > See Documentation/admin-guide/hw-vuln/core-scheduling.rst for a full
> > rundown of both this and the per-task API.
> 
> I refuse to read RST. Life's too short for that.
> 
> > +u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css,
> > +			  struct cftype *cft)
> > +{
> > +	return !!css_tg(css)->core_tagged;
> > +}
> > +
> > +int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
> > +			   u64 val)
> > +{
> > +	static DEFINE_MUTEX(sched_core_group_mutex);
> > +	struct task_group *tg = css_tg(css);
> > +	struct cgroup_subsys_state *css_tmp;
> > +	struct task_struct *p;
> > +	unsigned long group_cookie;
> > +	int ret = 0;
> > +
> > +	if (val > 1)
> > +		return -ERANGE;
> > +
> > +	if (!static_branch_likely(&sched_smt_present))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&sched_core_group_mutex);
> > +
> > +	if (!tg->core_tagged && val) {
> > +		/* Tag is being set. Check ancestors and descendants. */
> > +		if (cpu_core_get_group_cookie(tg) ||
> > +		    cpu_core_check_descendants(tg, true /* tag */)) {
> > +			ret = -EBUSY;
> > +			goto out_unlock;
> > +		}
> 
> So the desired semantics is to only allow a single tag on any upwards
> path? Isn't that in conflict with the cgroup requirements?
> 
> TJ?
> 
> > +	} else if (tg->core_tagged && !val) {
> > +		/* Tag is being reset. Check descendants. */
> > +		if (cpu_core_check_descendants(tg, true /* tag */)) {
> 
> I'm struggling to understand this. If, per the above, you cannot set
> when either a parent is already set or a child is set, then how can a
> child be set to refuse clearing?
> 
> > +			ret = -EBUSY;
> > +			goto out_unlock;
> > +		}
> > +	} else {
> > +		goto out_unlock;
> > +	}
> 
> 
