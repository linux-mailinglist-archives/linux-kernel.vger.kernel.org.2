Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9600644D42C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhKKJlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:41:13 -0500
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:42839 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhKKJlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:41:12 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id C15B217D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:38:21 +0000 (GMT)
Received: (qmail 25583 invoked from network); 11 Nov 2021 09:38:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Nov 2021 09:38:21 -0000
Date:   Thu, 11 Nov 2021 09:38:19 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Srinivasan, Sadagopan" <Sadagopan.Srinivasan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20211111093819.GI3959@techsingularity.net>
References: <20211028130305.GS3959@techsingularity.net>
 <YYkGkx+Wq6Ol2N9i@hirez.programming.kicks-ass.net>
 <20211108115948.GH3959@techsingularity.net>
 <YYkyUT5etDBBjfIE@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YYkyUT5etDBBjfIE@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 03:21:05PM +0100, Peter Zijlstra wrote:
> > > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > > index 4e8698e62f07..08fb02510967 100644
> > > > --- a/kernel/sched/topology.c
> > > > +++ b/kernel/sched/topology.c
> > > > @@ -644,6 +644,7 @@ static void destroy_sched_domains(struct sched_domain *sd)
> > > >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> > > >  DEFINE_PER_CPU(int, sd_llc_size);
> > > >  DEFINE_PER_CPU(int, sd_llc_id);
> > > > +DEFINE_PER_CPU(int, sd_numaimb_shift);
> > > 
> > > Why does it make sense for this to be a per-cpu variable? Yes, I suppose
> > > people can get creative with cpusets, but what you're trying to capture
> > > seems like a global system propery, no?
> > > 
> > 
> > I thought things might get weird around CPU hotplug and as llc_size was
> > tracked per-cpu, I thought it made sense to also do it for
> > sd_numaimb_shift.
> 
> Ah, there were performance arguments for llc_id (saves a bunch of
> indirections trying to look up the LLC domain) and llc_size IIRC. While
> in this case, the user actually has a struct sched_domain handy.
> 

Very true or at least had recent access to the sd.

> > > Very true or at least had very recent access to it.
> > > 
> > > I think I'm with Valentin here, this seems like something that wants to
> > > use the sd/sd->child relation.
> > > 
> > > That also makes this the wrong place to do things since this is after
> > > the degenerate code.
> > > 
> > > Perhaps this can be done in sd_init(), after all, we build the thing
> > > bottom-up, so by the time we initialize the NODE, the MC level should
> > > already be present.
> > >
> > > I'm thinking you can perhaps use something like:
> > > 
> > > 	if (!(sd->flags & SD_SHARE_PKG_RESROUCES) &&
> > > 	    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> > > 
> > > 		/* this is the first domain not sharing LLC */
> > > 		sd->new_magic_imb = /*  magic incantation goes here */
> > > 	}
> > 
> > Thanks, I'll give it a shot and see what I come up with, it'll probably
> > take me a few days to clear my table of other crud to focus on it.
> 
> Sure thing.

At sd_init time, the sd span_weights and groups have not been fully
calculated yet so while the child domains are partially initialised,
we are missing some information, particularly the span of SD_NUMA (it
can be in inferred but it's non-obvious).

build_sched_domains
  build_sched_domain
    sd_init
  (record span_weight)
  build_sched_groups

I thought it would be easier to figure out the allowed numa imbalance
after groups are setup although basing it on the sd/sd->child relation
both addresses Zen and removes the magic "25%" value at least for 2-socket
machines with a change in behaviour for larger machines to balance
cache usage versus memory bandwidth.

It also became obvious when working on this that there was an inconsistency
between the domains used by find_busiest_group and find_idlest_group
which deserves a separate patch but included in this monolithic path.

End result;

---8<--
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8f0f778b7c91..a8832e6e97f0 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -86,6 +86,7 @@ struct sched_domain {
 	unsigned int busy_factor;	/* less balancing by factor if busy */
 	unsigned int imbalance_pct;	/* No balance until over watermark */
 	unsigned int cache_nice_tries;	/* Leave cache hot tasks for # tries */
+	unsigned int imb_numa_nr;	/* Nr imbalanced tasks allowed between nodes */
 
 	int nohz_idle;			/* NOHZ IDLE status */
 	int flags;			/* See SD_* */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f6a05d9b5443..582b739a5f02 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1531,6 +1531,7 @@ struct task_numa_env {
 
 	int src_cpu, src_nid;
 	int dst_cpu, dst_nid;
+	int imb_numa_nr;
 
 	struct numa_stats src_stats, dst_stats;
 
@@ -1927,7 +1928,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		dst_running = env->dst_stats.nr_running + 1;
 		imbalance = max(0, dst_running - src_running);
 		imbalance = adjust_numa_imbalance(imbalance, dst_running,
-							env->dst_stats.weight);
+						  env->imb_numa_nr);
 
 		/* Use idle CPU if there is no imbalance */
 		if (!imbalance) {
@@ -1992,8 +1993,10 @@ static int task_numa_migrate(struct task_struct *p)
 	 */
 	rcu_read_lock();
 	sd = rcu_dereference(per_cpu(sd_numa, env.src_cpu));
-	if (sd)
+	if (sd) {
 		env.imbalance_pct = 100 + (sd->imbalance_pct - 100) / 2;
+		env.imb_numa_nr = sd->imb_numa_nr;
+	}
 	rcu_read_unlock();
 
 	/*
@@ -8989,13 +8992,14 @@ static bool update_pick_idlest(struct sched_group *idlest,
 }
 
 /*
- * Allow a NUMA imbalance if busy CPUs is less than 25% of the domain.
- * This is an approximation as the number of running tasks may not be
- * related to the number of busy CPUs due to sched_setaffinity.
+ * Allow a NUMA imbalance if busy CPUs is less than the allowed
+ * imbalance. This is an approximation as the number of running
+ * tasks may not be related to the number of busy CPUs due to
+ * sched_setaffinity.
  */
-static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
+static inline bool allow_numa_imbalance(int dst_running, int imb_numa_nr)
 {
-	return (dst_running < (dst_weight >> 2));
+	return dst_running < imb_numa_nr;
 }
 
 /*
@@ -9134,7 +9138,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * a real need of migration, periodic load balance will
 			 * take care of it.
 			 */
-			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
+			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->imb_numa_nr))
 				return NULL;
 		}
 
@@ -9226,9 +9230,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 #define NUMA_IMBALANCE_MIN 2
 
 static inline long adjust_numa_imbalance(int imbalance,
-				int dst_running, int dst_weight)
+				int dst_running, int imb_numa_nr)
 {
-	if (!allow_numa_imbalance(dst_running, dst_weight))
+	if (!allow_numa_imbalance(dst_running, imb_numa_nr))
 		return imbalance;
 
 	/*
@@ -9340,7 +9344,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		/* Consider allowing a small imbalance between NUMA groups */
 		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-				busiest->sum_nr_running, busiest->group_weight);
+				busiest->sum_nr_running, env->sd->imb_numa_nr);
 		}
 
 		return;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 4e8698e62f07..a47cae382617 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2227,6 +2227,30 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		}
 	}
 
+	/* Calculate allowed NUMA imbalance */
+	for_each_cpu(i, cpu_map) {
+		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
+			struct sched_domain *child = sd->child;
+
+			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) &&
+			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
+				struct sched_domain *sd_numa = sd;
+				int imb_numa_nr, nr_groups;
+
+				nr_groups = sd->span_weight / child->span_weight;
+				imb_numa_nr = nr_groups / num_online_nodes();
+
+				while (sd_numa) {
+					if (sd_numa->flags & SD_NUMA) {
+						sd_numa->imb_numa_nr = imb_numa_nr;
+						break;
+					}
+					sd_numa = sd_numa->parent;
+				}
+			}
+		}
+	}
+
 	/* Calculate CPU capacity for physical packages and nodes */
 	for (i = nr_cpumask_bits-1; i >= 0; i--) {
 		if (!cpumask_test_cpu(i, cpu_map))

-- 
Mel Gorman
SUSE Labs
