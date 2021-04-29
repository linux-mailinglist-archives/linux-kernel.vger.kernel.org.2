Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECDA36E893
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbhD2KVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:21:09 -0400
Received: from foss.arm.com ([217.140.110.172]:46158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240271AbhD2KUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:20:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB1BA101E;
        Thu, 29 Apr 2021 03:20:05 -0700 (PDT)
Received: from e120189.arm.com (unknown [10.57.56.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B855F3F70D;
        Thu, 29 Apr 2021 03:20:02 -0700 (PDT)
From:   Pierre.Gondois@arm.com
To:     linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        qperret@qperret.net, dietmar.eggemann@arm.com
Cc:     Lukasz.Luba@arm.com, Vincent.Donnefort@arm.com,
        Pierre Gondois <Pierre.Gondois@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Subject: [PATCH v2 1/2] sched/fair: Only compute base_energy_pd if necessary
Date:   Thu, 29 Apr 2021 11:19:47 +0100
Message-Id: <20210429101948.31224-2-Pierre.Gondois@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429101948.31224-1-Pierre.Gondois@arm.com>
References: <20210429101948.31224-1-Pierre.Gondois@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre Gondois <Pierre.Gondois@arm.com>

find_energy_efficient_cpu() searches the best energy CPU
to place a task on. To do so, the energy of each performance domain
(pd) is computed w/ and w/o the task placed in each pd.

The energy of a pd w/o the task (base_energy_pd) is computed prior
knowing whether a CPU is available in the pd.

Move the base_energy_pd computation after looping through the CPUs
of a pd and only computes it if at least one CPU is available.

Suggested-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
---
 kernel/sched/fair.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0dba0ebc3657..c5351366fb93 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6620,13 +6620,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 	for (; pd; pd = pd->next) {
 		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
+		bool compute_prev_delta = false;
 		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
 
-		/* Compute the 'base' energy of the pd, without @p */
-		base_energy_pd = compute_energy(p, -1, pd);
-		base_energy += base_energy_pd;
-
 		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
@@ -6647,25 +6644,34 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (!fits_capacity(util, cpu_cap))
 				continue;
 
-			/* Always use prev_cpu as a candidate. */
 			if (cpu == prev_cpu) {
-				prev_delta = compute_energy(p, prev_cpu, pd);
-				prev_delta -= base_energy_pd;
-				best_delta = min(best_delta, prev_delta);
-			}
-
-			/*
-			 * Find the CPU with the maximum spare capacity in
-			 * the performance domain
-			 */
-			if (spare_cap > max_spare_cap) {
+				/* Always use prev_cpu as a candidate. */
+				compute_prev_delta = true;
+			} else if (spare_cap > max_spare_cap) {
+				/*
+				 * Find the CPU with the maximum spare capacity
+				 * in the performance domain.
+				 */
 				max_spare_cap = spare_cap;
 				max_spare_cap_cpu = cpu;
 			}
 		}
 
+		if (max_spare_cap_cpu < 0 && !compute_prev_delta)
+			continue;
+
+		/* Compute the 'base' energy of the pd, without @p */
+		base_energy_pd = compute_energy(p, -1, pd);
+		base_energy += base_energy_pd;
+
+		if (compute_prev_delta) {
+			prev_delta = compute_energy(p, prev_cpu, pd);
+			prev_delta -= base_energy_pd;
+			best_delta = min(best_delta, prev_delta);
+		}
+
 		/* Evaluate the energy impact of using this CPU. */
-		if (max_spare_cap_cpu >= 0 && max_spare_cap_cpu != prev_cpu) {
+		if (max_spare_cap_cpu >= 0) {
 			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
 			cur_delta -= base_energy_pd;
 			if (cur_delta < best_delta) {
-- 
2.17.1

