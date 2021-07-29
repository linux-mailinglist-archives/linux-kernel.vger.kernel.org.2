Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A163DAF3D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhG2Whj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:37:39 -0400
Received: from foss.arm.com ([217.140.110.172]:59466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235692AbhG2WhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:37:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEDCE106F;
        Thu, 29 Jul 2021 15:37:15 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB0593F70D;
        Thu, 29 Jul 2021 15:37:13 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com
Subject: [PATCH v1 20/20] x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes
Date:   Thu, 29 Jul 2021 22:36:10 +0000
Message-Id: <20210729223610.29373-21-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729223610.29373-1-james.morse@arm.com>
References: <20210729223610.29373-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl_arch_rmid_read() returns a value in chunks, as read from the
hardware. This needs scaling to bytes by mon_scale, as provided by
the architecture code.

Now that resctrl_arch_rmid_read() performs the overflow and corrections
itself, it may as well return a value in bytes directly.

Move the mon_scale conversion into resctrl_arch_rmid_read().

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  6 ++----
 arch/x86/kernel/cpu/resctrl/internal.h    |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c     | 22 +++++++++-------------
 include/linux/resctrl.h                   |  2 +-
 4 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 3269ee954941..6b6598811922 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -549,7 +549,6 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
-	struct rdt_hw_resource *hw_res;
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -569,8 +568,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	domid = md.u.domid;
 	evtid = md.u.evtid;
 
-	hw_res = &rdt_resources_all[resid];
-	r = &hw_res->r_resctrl;
+	r = &rdt_resources_all[resid].r_resctrl;
 	d = rdt_find_domain(r, domid, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
@@ -584,7 +582,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	else if (rr.err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
 	else
-		seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
+		seq_printf(m, "%llu\n", rr.val);
 
 out:
 	rdtgroup_kn_unlock(of->kn);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 4569b4588185..3bf4b32fc531 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -278,13 +278,13 @@ struct rftype {
 
 /**
  * struct mbm_state - status for each MBM counter in each domain
- * @prev_bw_chunks: Previous chunks value read when for bandwidth calculation
+ * @prev_bw_bytes: Previous bytes value read when for bandwidth calculation
  * @prev_bw:	The most recent bandwidth in MBps
  * @delta_bw:	Difference between the current and previous bandwidth
  * @delta_comp:	Indicates whether to compute the delta_bw
  */
 struct mbm_state {
-	u64	prev_bw_chunks;
+	u64	prev_bw_bytes;
 	u32	prev_bw;
 	u32	delta_bw;
 	bool	delta_comp;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 18eba1bb032f..7de6e7aa2778 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -183,7 +183,7 @@ int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_domain *d,
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct arch_mbm_state *m;
-	u64 msr_val;
+	u64 msr_val, chunks;
 
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
 		return -EINVAL;
@@ -208,10 +208,11 @@ int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_domain *d,
 	if (m) {
 		m->chunks += mbm_overflow_count(m->prev_msr, msr_val,
 						hw_res->mbm_width);
-		*val = get_corrected_mbm_count(rmid, m->chunks);
+		chunks = get_corrected_mbm_count(rmid, m->chunks);
+		*val = chunks * hw_res->mon_scale;
 		m->prev_msr = msr_val;
 	} else {
-		*val = msr_val;
+		*val = msr_val * hw_res->mon_scale;
 	}
 
 	return 0;
@@ -226,7 +227,6 @@ int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_domain *d,
 void __check_limbo(struct rdt_domain *d, bool force_free)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rmid_entry *entry;
 	u32 crmid = 1, nrmid;
 	bool rmid_dirty;
@@ -249,7 +249,6 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 					   QOS_L3_OCCUP_EVENT_ID, &val)) {
 			rmid_dirty = true;
 		} else {
-			val *= hw_res->mon_scale;
 			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
 		}
 
@@ -293,7 +292,6 @@ int alloc_rmid(void)
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_domain *d;
 	int cpu, err;
 	u64 val = 0;
@@ -305,7 +303,6 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 			err = resctrl_arch_rmid_read(r, d, entry->rmid,
 						     QOS_L3_OCCUP_EVENT_ID,
 						     &val);
-			val *= hw_res->mon_scale;
 			if (err || val <= resctrl_rmid_realloc_threshold)
 				continue;
 		}
@@ -370,7 +367,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 
 	if (rr->first) {
 		memset(m, 0, sizeof(struct mbm_state));
-		m->prev_bw_chunks = tval;
+		m->prev_bw_bytes = tval;
 		return 0;
 	}
 
@@ -385,21 +382,20 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
  */
 static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 {
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m = &rr->d->mbm_local[rmid];
-	u64 cur_bw, bw_chunks = 0;
+	u64 cur_bw, bw_bytes = 0;
 
-	if (resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &bw_chunks))
+	if (resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &bw_bytes))
 		return;
 
-	cur_bw = (bw_chunks - m->prev_bw_chunks) * hw_res->mon_scale;
+	cur_bw = (bw_bytes - m->prev_bw_bytes);
 	cur_bw >>= 20;
 
 	if (m->delta_comp)
 		m->delta_bw = abs(cur_bw - m->prev_bw);
 	m->delta_comp = false;
 	m->prev_bw = cur_bw;
-	m->prev_bw_chunks = bw_chunks;
+	m->prev_bw_bytes = bw_bytes;
 }
 
 /*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index ce7c7472da7d..f63af6d4c10e 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -236,7 +236,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
  * @d:			The domain that the counter should be read from.
  * @rmid:		The rmid of the counter to read.
  * @eventid:		The eventid to read, e.g. L3 occupancy.
- * @val:		The result of the counter read in chunks.
+ * @val:		The result of the counter read in bytes.
  *
  * Returns 0 on success, or -EIO, -EINVAL etc on error.
  */
-- 
2.30.2

