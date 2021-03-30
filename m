Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8CA34E464
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhC3J2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhC3J11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:27:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636E8C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0fngYHWkiVPzsn57KSFrmq+VbGZL32q82eot96bjcd8=; b=IXQr0FPgom1Vt8+FHZsO4rPZF4
        uKWKQXk1Hcruo31SSKkx19LSftYAbPmQL2vgrxg9erN7VnTbQ6W3N/ipiTVltSxCu/zoD+MDoIByn
        7keFTbXHxgtZl4RzJBgVy13oK9QOIiNjSs/om4p+BClztua8ZvlTYsGIWgQrKUhG8m/bHeH1iZ2Rc
        kw1qFQ8cbNxfwLG4Hf3aAjPVj4koAgq/I2DiaI3S48IlOx/vCFTUrSvhLq92hU7nBczVBQ+v7tbLS
        rrdpp0KqIsrT5n3Welr96s7EnMG3YszJTq/7D8FgbOtLEbgDGUm3Vg33T2V/Huh8wdC1KNboJaAaj
        udloVC6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRAah-002mZ7-Kb; Tue, 30 Mar 2021 09:23:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C494D307001;
        Tue, 30 Mar 2021 11:23:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D7B3200D0253; Tue, 30 Mar 2021 11:23:10 +0200 (CEST)
Date:   Tue, 30 Mar 2021 11:23:10 +0200
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
        Tom Lendacky <thomas.lendacky@amd.com>, dhiatt@digitalocean.com
Subject: Re: [PATCH resend 5/8] sched: cgroup cookie API for core scheduling
Message-ID: <YGLt/ltwa92lfCDK@hirez.programming.kicks-ass.net>
References: <20210324214020.34142-1-joel@joelfernandes.org>
 <20210324214020.34142-6-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324214020.34142-6-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 05:40:17PM -0400, Joel Fernandes (Google) wrote:
> From: Josh Don <joshdon@google.com>
> 
> This adds the API to set/get the cookie for a given cgroup. This
> interface lives at cgroup/cpu.core_tag.
> 
> The cgroup interface can be used to toggle a unique cookie value for all
> descendent tasks, preventing these tasks from sharing with any others.
> See Documentation/admin-guide/hw-vuln/core-scheduling.rst for a full
> rundown of both this and the per-task API.

I refuse to read RST. Life's too short for that.

> +u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css,
> +			  struct cftype *cft)
> +{
> +	return !!css_tg(css)->core_tagged;
> +}
> +
> +int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
> +			   u64 val)
> +{
> +	static DEFINE_MUTEX(sched_core_group_mutex);
> +	struct task_group *tg = css_tg(css);
> +	struct cgroup_subsys_state *css_tmp;
> +	struct task_struct *p;
> +	unsigned long group_cookie;
> +	int ret = 0;
> +
> +	if (val > 1)
> +		return -ERANGE;
> +
> +	if (!static_branch_likely(&sched_smt_present))
> +		return -EINVAL;
> +
> +	mutex_lock(&sched_core_group_mutex);
> +
> +	if (!tg->core_tagged && val) {
> +		/* Tag is being set. Check ancestors and descendants. */
> +		if (cpu_core_get_group_cookie(tg) ||
> +		    cpu_core_check_descendants(tg, true /* tag */)) {
> +			ret = -EBUSY;
> +			goto out_unlock;
> +		}

So the desired semantics is to only allow a single tag on any upwards
path? Isn't that in conflict with the cgroup requirements?

TJ?

> +	} else if (tg->core_tagged && !val) {
> +		/* Tag is being reset. Check descendants. */
> +		if (cpu_core_check_descendants(tg, true /* tag */)) {

I'm struggling to understand this. If, per the above, you cannot set
when either a parent is already set or a child is set, then how can a
child be set to refuse clearing?

> +			ret = -EBUSY;
> +			goto out_unlock;
> +		}
> +	} else {
> +		goto out_unlock;
> +	}


