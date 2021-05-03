Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65230371395
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 12:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhECKZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 06:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhECKZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 06:25:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD2EC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 03:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1RS7j43eYEaxt//CyiyABIilDambnV6N0W8pq3iz0Eg=; b=EQTCrckYl5z9DBBZ4IiAQPwNqy
        mLkS67as+O+2jRiQPz30fDvkvUL7RNGMK8lkxj+ahxrQifOzM1HPW2xevDR+FKW5amlSXccoGOwht
        muneAgpIYEpeFz0YZHpTsVpDAgYH8lR20khUMS7zduYJUuo54RlnquL8L+BRix2t5xSFzKk1rsjWi
        yBi+m9HHKcDU/QjJswbhoEp8nDIESGJFJgODU4zHg0WvPyGLpVL/c3HeChLJjeHil3BP01nI2F/mh
        EC9iHsEyUUvAw8t4kVMw36flMn+e3nGDT3XQ/MftZ+Me2sJy9qYXSLsDV6YylbekzAhMwjsps2yPN
        SHvK9CrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldVjl-00DeUh-Et; Mon, 03 May 2021 10:23:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8CECB3001D0;
        Mon,  3 May 2021 12:23:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4281F2BC22572; Mon,  3 May 2021 12:23:36 +0200 (CEST)
Date:   Mon, 3 May 2021 12:23:36 +0200
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
Subject: Re: [PATCH v2 3/4] sched/fair: Consider SMT in ASYM_PACKING load
 balance
Message-ID: <YI/PKAkjLeaKEXrn@hirez.programming.kicks-ass.net>
References: <20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com>
 <20210414020436.12980-4-ricardo.neri-calderon@linux.intel.com>
 <YI/KSfWuGLhPnilr@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YI/KSfWuGLhPnilr@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 12:02:49PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 13, 2021 at 07:04:35PM -0700, Ricardo Neri wrote:
> > @@ -8507,6 +8616,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >  	if (!sgs->sum_h_nr_running)
> >  		return false;
> >  
> > +	/*
> > +	 * @sg may have been tentatively classified as group_asym_packing.
> > +	 * Now that we have sufficient information about @sds.local, reassess
> > +	 * if asym packing migration can be done. Reclassify @sg. The only
> > +	 * possible results are group_has_spare and group_fully_busy.
> > +	 */
> > +	if (sgs->group_type == group_asym_packing &&
> > +	    !asym_can_pull_tasks(env->dst_cpu, sds, sgs, sg)) {
> > +		sgs->group_asym_packing = 0;
> > +		sgs->group_type = group_classify(env->sd->imbalance_pct, sg, sgs);
> > +	}
> 
> So if this really is all about not having sds.local in
> update_sd_lb_stats(), then that seems fixable. Let me haz a try.

How's this then?

---
 kernel/sched/fair.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3bdc41f22909..e9dcbee5b3d9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8437,6 +8437,21 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
+static inline bool
+sched_asym(struct lb_env *env, struct sd_lb_stats *sds, struct sched_group *group)
+{
+	/*
+	 * Because sd->groups starts with the local group, anything that isn't
+	 * the local group will have access to the local state.
+	 */
+	if (group == sds->local)
+		return false;
+
+	/* XXX do magic here */
+
+	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
+}
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -8445,6 +8460,7 @@ group_type group_classify(unsigned int imbalance_pct,
  * @sg_status: Holds flag indicating the status of the sched_group
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
+				      struct sd_lb_stats *sds,
 				      struct sched_group *group,
 				      struct sg_lb_stats *sgs,
 				      int *sg_status)
@@ -8453,7 +8469,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	memset(sgs, 0, sizeof(*sgs));
 
-	local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
+	local_group = group == sds->local;
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
@@ -8498,9 +8514,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	/* Check if dst CPU is idle and preferred to this group */
 	if (env->sd->flags & SD_ASYM_PACKING &&
-	    env->idle != CPU_NOT_IDLE &&
-	    sgs->sum_h_nr_running &&
-	    sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
+	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
+	    sched_asym(env, sds, group)) {
 		sgs->group_asym_packing = 1;
 	}
 
@@ -9016,7 +9031,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
 
-		update_sg_lb_stats(env, sg, sgs, &sg_status);
+		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
 
 		if (local_group)
 			goto next_group;
