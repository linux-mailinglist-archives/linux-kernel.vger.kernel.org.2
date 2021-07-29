Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B123DAF31
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhG2Wgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:36:44 -0400
Received: from foss.arm.com ([217.140.110.172]:59022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234464AbhG2Wgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:36:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C7DD11FB;
        Thu, 29 Jul 2021 15:36:33 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 292D13F70D;
        Thu, 29 Jul 2021 15:36:31 -0700 (PDT)
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
Subject: [PATCH v1 04/20] x86/resctrl: Add domain offline callback for resctrl work
Date:   Thu, 29 Jul 2021 22:35:54 +0000
Message-Id: <20210729223610.29373-5-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729223610.29373-1-james.morse@arm.com>
References: <20210729223610.29373-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because domains are exposed to user-space via resctrl, the filesystem
must update its state when cpu hotplug callbacks are triggered.

Some of this work is common to any architecture that would support
resctrl, but the work is tied up with the architecture code to
free the memory.

Move the monitor subdir removal and the cancelling of the mbm/limbo
works into a new resctrl_offline_domain() call.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 24 +---------------
 arch/x86/kernel/cpu/resctrl/internal.h |  2 --
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 39 +++++++++++++++++++++++---
 include/linux/resctrl.h                |  1 +
 4 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 718f8ff00d87..56b3541617b5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -516,27 +516,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
-		/*
-		 * If resctrl is mounted, remove all the
-		 * per domain monitor data directories.
-		 */
-		if (static_branch_unlikely(&rdt_mon_enable_key))
-			rmdir_mondata_subdir_allrdtgrp(r, d->id);
+		resctrl_offline_domain(r, d);
 		list_del(&d->list);
-		if (r->mon_capable && is_mbm_enabled())
-			cancel_delayed_work(&d->mbm_over);
-		if (is_llc_occupancy_enabled() &&  has_busy_rmid(r, d)) {
-			/*
-			 * When a package is going down, forcefully
-			 * decrement rmid->ebusy. There is no way to know
-			 * that the L3 was flushed and hence may lead to
-			 * incorrect counts in rare scenarios, but leaving
-			 * the RMID as busy creates RMID leaks if the
-			 * package never comes back.
-			 */
-			__check_limbo(d, true);
-			cancel_delayed_work(&d->cqm_limbo);
-		}
 
 		/*
 		 * rdt_domain "d" is going to be freed below, so clear
@@ -547,9 +528,6 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 		kfree(hw_dom->ctrl_val);
 		kfree(hw_dom->mbps_val);
-		bitmap_free(d->rmid_busy_llc);
-		kfree(d->mbm_total);
-		kfree(d->mbm_local);
 		kfree(hw_dom);
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index be48a682dbdb..e12b55f815bf 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -522,8 +522,6 @@ void free_rmid(u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
-void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-				    unsigned int dom_id);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e1af1d81b924..cf0db0b7a5d0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2497,14 +2497,12 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
  * Remove all subdirectories of mon_data of ctrl_mon groups
  * and monitor groups with given domain id.
  */
-void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r, unsigned int dom_id)
+static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
+					   unsigned int dom_id)
 {
 	struct rdtgroup *prgrp, *crgrp;
 	char name[32];
 
-	if (!r->mon_capable)
-		return;
-
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		sprintf(name, "mon_%s_%02d", r->name, dom_id);
 		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
@@ -3229,6 +3227,39 @@ static int __init rdtgroup_setup_root(void)
 	return ret;
 }
 
+void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
+{
+	lockdep_assert_held(&rdtgroup_mutex); // the arch code took this for us
+
+	if (!r->mon_capable)
+		return;
+
+	/*
+	 * If resctrl is mounted, remove all the
+	 * per domain monitor data directories.
+	 */
+	if (static_branch_unlikely(&rdt_mon_enable_key))
+		rmdir_mondata_subdir_allrdtgrp(r, d->id);
+
+	if (r->mon_capable && is_mbm_enabled())
+		cancel_delayed_work(&d->mbm_over);
+	if (is_llc_occupancy_enabled() && has_busy_rmid(r, d)) {
+		/*
+		 * When a package is going down, forcefully
+		 * decrement rmid->ebusy. There is no way to know
+		 * that the L3 was flushed and hence may lead to
+		 * incorrect counts in rare scenarios, but leaving
+		 * the RMID as busy creates RMID leaks if the
+		 * package never comes back.
+		 */
+		__check_limbo(d, true);
+		cancel_delayed_work(&d->cqm_limbo);
+	}
+	bitmap_free(d->rmid_busy_llc);
+	kfree(d->mbm_total);
+	kfree(d->mbm_local);
+}
+
 static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 {
 	size_t tsize;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index cb48976a8d88..7aeeb4ac6bcc 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -196,5 +196,6 @@ void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 closid, enum resctrl_conf_type type,
 			     u32 *value);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
+void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
 
 #endif /* _RESCTRL_H */
-- 
2.30.2

