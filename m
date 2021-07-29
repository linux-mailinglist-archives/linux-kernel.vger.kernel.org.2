Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AD03DAF30
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhG2Wgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:36:42 -0400
Received: from foss.arm.com ([217.140.110.172]:58994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234722AbhG2Wge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:36:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 803CC11D4;
        Thu, 29 Jul 2021 15:36:30 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CD003F70D;
        Thu, 29 Jul 2021 15:36:28 -0700 (PDT)
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
Subject: [PATCH v1 03/20] x86/resctrl: Add domain online callback for resctrl work
Date:   Thu, 29 Jul 2021 22:35:53 +0000
Message-Id: <20210729223610.29373-4-james.morse@arm.com>
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
allocate the memory.

Move domain_setup_mon_state(), the monitor subdir creation call and the
mbm/limbo workers into a new resctrl_online_domain() call.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 53 +++------------------
 arch/x86/kernel/cpu/resctrl/internal.h |  2 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 65 ++++++++++++++++++++++++--
 include/linux/resctrl.h                |  1 +
 4 files changed, 67 insertions(+), 54 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 2a20fcce9cc2..718f8ff00d87 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -443,42 +443,6 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
-static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
-{
-	size_t tsize;
-
-	if (is_llc_occupancy_enabled()) {
-		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
-		if (!d->rmid_busy_llc)
-			return -ENOMEM;
-		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
-	}
-	if (is_mbm_total_enabled()) {
-		tsize = sizeof(*d->mbm_total);
-		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
-		if (!d->mbm_total) {
-			bitmap_free(d->rmid_busy_llc);
-			return -ENOMEM;
-		}
-	}
-	if (is_mbm_local_enabled()) {
-		tsize = sizeof(*d->mbm_local);
-		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
-		if (!d->mbm_local) {
-			bitmap_free(d->rmid_busy_llc);
-			kfree(d->mbm_total);
-			return -ENOMEM;
-		}
-	}
-
-	if (is_mbm_enabled()) {
-		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
-		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
-	}
-
-	return 0;
-}
-
 /*
  * domain_add_cpu - Add a cpu to a resource's domain list.
  *
@@ -498,6 +462,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	struct list_head *add_pos = NULL;
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
+	int err;
 
 	d = rdt_find_domain(r, id, &add_pos);
 	if (IS_ERR(d)) {
@@ -527,19 +492,13 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	if (r->mon_capable && domain_setup_mon_state(r, d)) {
-		kfree(d);
-		return;
-	}
-
 	list_add_tail(&d->list, add_pos);
 
-	/*
-	 * If resctrl is mounted, add
-	 * per domain monitor data directories.
-	 */
-	if (static_branch_unlikely(&rdt_mon_enable_key))
-		mkdir_mondata_subdir_allrdtgrp(r, d);
+	err = resctrl_online_domain(r, d);
+	if (err) {
+		list_del(&d->list);
+		kfree(d);
+	}
 }
 
 static void domain_remove_cpu(int cpu, struct rdt_resource *r)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 8828b5c1b6d2..be48a682dbdb 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -524,8 +524,6 @@ void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 				    unsigned int dom_id);
-void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-				    struct rdt_domain *d);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3eb5f94a9e7d..e1af1d81b924 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2563,16 +2563,13 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
  * Add all subdirectories of mon_data for "ctrl_mon" groups
  * and "monitor" groups with given domain id.
  */
-void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-				    struct rdt_domain *d)
+static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
+					   struct rdt_domain *d)
 {
 	struct kernfs_node *parent_kn;
 	struct rdtgroup *prgrp, *crgrp;
 	struct list_head *head;
 
-	if (!r->mon_capable)
-		return;
-
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		parent_kn = prgrp->mon.mon_data_kn;
 		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
@@ -3232,6 +3229,64 @@ static int __init rdtgroup_setup_root(void)
 	return ret;
 }
 
+static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
+{
+	size_t tsize;
+
+	if (is_llc_occupancy_enabled()) {
+		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
+		if (!d->rmid_busy_llc)
+			return -ENOMEM;
+	}
+	if (is_mbm_total_enabled()) {
+		tsize = sizeof(*d->mbm_total);
+		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		if (!d->mbm_total) {
+			bitmap_free(d->rmid_busy_llc);
+			return -ENOMEM;
+		}
+	}
+	if (is_mbm_local_enabled()) {
+		tsize = sizeof(*d->mbm_local);
+		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		if (!d->mbm_local) {
+			bitmap_free(d->rmid_busy_llc);
+			kfree(d->mbm_total);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
+{
+	int err;
+
+	lockdep_assert_held(&rdtgroup_mutex); // the arch code took this for us
+
+	if (!r->mon_capable)
+		return 0;
+
+	err = domain_setup_mon_state(r, d);
+	if (err)
+		return err;
+
+	if (is_mbm_enabled()) {
+		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
+		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
+	}
+
+	if (is_llc_occupancy_enabled())
+		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
+
+	/* If resctrl is mounted, add per domain monitor data directories. */
+	if (static_branch_unlikely(&rdt_enable_key))
+		mkdir_mondata_subdir_allrdtgrp(r, d);
+
+	return 0;
+}
+
 /*
  * rdtgroup_init - rdtgroup initialization
  *
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index d715df9de37f..cb48976a8d88 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -195,5 +195,6 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 closid, enum resctrl_conf_type type,
 			     u32 *value);
+int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 
 #endif /* _RESCTRL_H */
-- 
2.30.2

