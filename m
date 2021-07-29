Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914C43DAF3F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhG2Whp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:37:45 -0400
Received: from foss.arm.com ([217.140.110.172]:59412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235295AbhG2WhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:37:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BDA811D4;
        Thu, 29 Jul 2021 15:37:10 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 287043F70D;
        Thu, 29 Jul 2021 15:37:08 -0700 (PDT)
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
Subject: [PATCH v1 18/20] x86/resctrl: Rename and change the units of resctrl_cqm_threshold
Date:   Thu, 29 Jul 2021 22:36:08 +0000
Message-Id: <20210729223610.29373-19-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729223610.29373-1-james.morse@arm.com>
References: <20210729223610.29373-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl_cqm_threshold is stored in a hardware specific chunk size,
and exposed to user-space.

This means the filesystem parts of resctrl need to know how the hardware
counts, to convert the user provided byte value to chunks. The interface
between the architecture's resctrl code and the filesystem ought to
treat everything as bytes.

Change the unit of resctrl_cqm_threshold to bytes. resctrl_arch_rmid_read()
still returns its value in chunks, so this needs converting to bytes.
As all the callers have been touched, rename the variable to
resctrl_rmid_realloc_threshold, which describes what the value is for.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 -
 arch/x86/kernel/cpu/resctrl/monitor.c  | 34 ++++++++++++--------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  9 ++-----
 include/linux/resctrl.h                |  2 ++
 4 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 65b472d6b146..4569b4588185 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -97,7 +97,6 @@ struct rmid_read {
 	u64			val;
 };
 
-extern unsigned int resctrl_cqm_threshold;
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 9321c758752a..8e3efb0909a0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -37,8 +37,8 @@ static LIST_HEAD(rmid_free_lru);
  * @rmid_limbo_count     count of currently unused but (potentially)
  *     dirty RMIDs.
  *     This counts RMIDs that no one is currently using but that
- *     may have a occupancy value > intel_cqm_threshold. User can change
- *     the threshold occupancy value.
+ *     may have a occupancy value > resctrl_rmid_realloc_threshold. User can
+ *     change the threshold occupancy value.
  */
 static unsigned int rmid_limbo_count;
 
@@ -59,10 +59,10 @@ bool rdt_mon_capable;
 unsigned int rdt_mon_features;
 
 /*
- * This is the threshold cache occupancy at which we will consider an
+ * This is the threshold cache occupancy in bytes at which we will consider an
  * RMID available for re-allocation.
  */
-unsigned int resctrl_cqm_threshold;
+unsigned int resctrl_rmid_realloc_threshold;
 
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
 
@@ -220,14 +220,13 @@ int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_domain *d,
  */
 void __check_limbo(struct rdt_domain *d, bool force_free)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rmid_entry *entry;
-	struct rdt_resource *r;
 	u32 crmid = 1, nrmid;
 	bool rmid_dirty;
 	u64 val = 0;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-
 	/*
 	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
 	 * are marked as busy for occupancy < threshold. If the occupancy
@@ -242,10 +241,12 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 		entry = __rmid_entry(nrmid);
 
 		if (resctrl_arch_rmid_read(r, d, entry->rmid,
-					   QOS_L3_OCCUP_EVENT_ID, &val))
+					   QOS_L3_OCCUP_EVENT_ID, &val)) {
 			rmid_dirty = true;
-		else
-			rmid_dirty = (val >= resctrl_cqm_threshold);
+		} else {
+			val *= hw_res->mon_scale;
+			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
+		}
 
 		if (force_free || !rmid_dirty) {
 			clear_bit(entry->rmid, d->rmid_busy_llc);
@@ -286,13 +287,12 @@ int alloc_rmid(void)
 
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
-	struct rdt_resource *r;
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_domain *d;
 	int cpu, err;
 	u64 val = 0;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-
 	entry->busy = 0;
 	cpu = get_cpu();
 	list_for_each_entry(d, &r->domains, list) {
@@ -300,7 +300,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 			err = resctrl_arch_rmid_read(r, d, entry->rmid,
 						     QOS_L3_OCCUP_EVENT_ID,
 						     &val);
-			if (err || val <= resctrl_cqm_threshold)
+			val *= hw_res->mon_scale;
+			if (err || val <= resctrl_rmid_realloc_threshold)
 				continue;
 		}
 
@@ -736,10 +737,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	resctrl_cqm_threshold = cl_size * 1024 / r->num_rmid;
-
-	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */
-	resctrl_cqm_threshold /= hw_res->mon_scale;
+	resctrl_rmid_realloc_threshold = cl_size * 1024 / r->num_rmid;
 
 	ret = dom_data_init(r);
 	if (ret)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 4388685548a0..d33442cd5975 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1030,10 +1030,7 @@ static int rdt_delay_linear_show(struct kernfs_open_file *of,
 static int max_threshold_occ_show(struct kernfs_open_file *of,
 				  struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-
-	seq_printf(seq, "%u\n", resctrl_cqm_threshold * hw_res->mon_scale);
+	seq_printf(seq, "%u\n", resctrl_rmid_realloc_threshold);
 
 	return 0;
 }
@@ -1055,7 +1052,6 @@ static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
 static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 				       char *buf, size_t nbytes, loff_t off)
 {
-	struct rdt_hw_resource *hw_res;
 	unsigned int bytes;
 	int ret;
 
@@ -1066,8 +1062,7 @@ static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 	if (bytes > (boot_cpu_data.x86_cache_size * 1024))
 		return -EINVAL;
 
-	hw_res = resctrl_to_arch_res(of->kn->parent->priv);
-	resctrl_cqm_threshold = bytes / hw_res->mon_scale;
+	resctrl_rmid_realloc_threshold = bytes;
 
 	return nbytes;
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 530df8e195c0..26e75c07a8ac 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -256,4 +256,6 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 rmid, enum resctrl_event_id eventid);
 
+extern unsigned int resctrl_rmid_realloc_threshold;
+
 #endif /* _RESCTRL_H */
-- 
2.30.2

