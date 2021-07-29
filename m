Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32453DAF32
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhG2Wgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:36:45 -0400
Received: from foss.arm.com ([217.140.110.172]:59046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234936AbhG2Wgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:36:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9D651FB;
        Thu, 29 Jul 2021 15:36:35 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D52D73F70D;
        Thu, 29 Jul 2021 15:36:33 -0700 (PDT)
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
Subject: [PATCH v1 05/20] x86/resctrl: Create mba_sc configuration in the rdt_domain
Date:   Thu, 29 Jul 2021 22:35:55 +0000
Message-Id: <20210729223610.29373-6-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729223610.29373-1-james.morse@arm.com>
References: <20210729223610.29373-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support resctrl's MBA software controller, the architecture must provide
a second configuration array to hold the mbps_val from user-space.

This complicates the interface between the architecture code.

Make the filesystem parts of resctrl create an array for the mba_sc
values when the struct resctrl_schema is created. The software controller
can be changed to use this, allowing the architecture code to only
consider the values configured in hardware.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 69 ++++++++++++++++++++++++++
 include/linux/resctrl.h                | 13 +++++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e12b55f815bf..a7e2cbce29d5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -36,7 +36,6 @@
 #define MBM_OVERFLOW_INTERVAL		1000
 #define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
-#define MBA_MAX_MBPS			U32_MAX
 #define MAX_MBA_BW_AMD			0x800
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cf0db0b7a5d0..185f9bb992d1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2030,6 +2030,60 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 			     struct rdtgroup *prgrp,
 			     struct kernfs_node **mon_data_kn);
 
+static int mba_sc_domain_allocate(struct rdt_resource *res,
+				  struct rdt_domain *d)
+{
+	u32 num_closid = closid_free_map_len;
+	int cpu = cpumask_any(&d->cpu_mask);
+	int i;
+
+	d->mba_sc = kcalloc_node(num_closid, sizeof(*d->mba_sc),
+				 GFP_KERNEL, cpu_to_node(cpu));
+	if (!d->mba_sc)
+		return -ENOMEM;
+
+	for (i = 0; i < num_closid; i++)
+		d->mba_sc[i].mbps_val = MBA_MAX_MBPS;
+
+	return 0;
+}
+
+static int mba_sc_allocate(struct rdt_resource *r)
+{
+	struct rdt_domain *d;
+	int ret;
+
+	lockdep_assert_cpus_held();
+
+	if (!is_mba_sc(r))
+		return 0;
+
+	list_for_each_entry(d, &r->domains, list) {
+		ret = mba_sc_domain_allocate(r, d);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static void mba_sc_domain_destroy(struct rdt_resource *r,
+				  struct rdt_domain *d)
+{
+	kfree(d->mba_sc);
+	d->mba_sc = NULL;
+}
+
+static void mba_sc_destroy(struct rdt_resource *r)
+{
+	struct rdt_domain *d;
+
+	lockdep_assert_cpus_held();
+
+	list_for_each_entry(d, &r->domains, list)
+		mba_sc_domain_destroy(r, d);
+}
+
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 {
 	int ret = 0;
@@ -2117,17 +2171,27 @@ static int schemata_list_create(void)
 
 		if (ret)
 			break;
+
+		ret = mba_sc_allocate(r);
+		if (ret)
+			break;
 	}
 
 	return ret;
 }
 
+/*
+ * During rdt_kill_sb(), the mba_sc state is reset before
+ * destroy_schemata_list() is called: unconditionally try to free the
+ * array.
+ */
 static void schemata_list_destroy(void)
 {
 	struct resctrl_schema *s, *tmp;
 
 	list_for_each_entry_safe(s, tmp, &resctrl_schema_all, list) {
 		list_del(&s->list);
+		mba_sc_destroy(s->res);
 		kfree(s);
 	}
 }
@@ -3255,6 +3319,8 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 		__check_limbo(d, true);
 		cancel_delayed_work(&d->cqm_limbo);
 	}
+	if (static_branch_unlikely(&rdt_enable_key) && is_mba_sc(r))
+		mba_sc_domain_destroy(r, d);
 	bitmap_free(d->rmid_busy_llc);
 	kfree(d->mbm_total);
 	kfree(d->mbm_local);
@@ -3287,6 +3353,9 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 		}
 	}
 
+	if (is_mba_sc(r))
+		mba_sc_domain_allocate(r, d);
+
 	return 0;
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 7aeeb4ac6bcc..3c8522d63261 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -15,6 +15,9 @@ int proc_resctrl_show(struct seq_file *m,
 
 #endif
 
+/* max value for struct resctrl_mba_sc's mbps_val */
+#define MBA_MAX_MBPS   U32_MAX
+
 /**
  * enum resctrl_conf_type - The type of configuration.
  * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
@@ -39,6 +42,14 @@ struct resctrl_staged_config {
 	bool			have_new_ctrl;
 };
 
+/**
+ * struct resctrl_mba_sc - per-closid values for the control loop
+ * @mbps_val:		The user's specified control value
+ */
+struct resctrl_mba_sc {
+	u32		mbps_val;
+};
+
 /**
  * struct rdt_domain - group of CPUs sharing a resctrl resource
  * @list:		all instances of this resource
@@ -53,6 +64,7 @@ struct resctrl_staged_config {
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
  * @plr:		pseudo-locked region (if any) associated with domain
  * @staged_config:	parsed configuration to be applied
+ * @mba_sc:	the mba software controller properties, indexed by closid
  */
 struct rdt_domain {
 	struct list_head		list;
@@ -67,6 +79,7 @@ struct rdt_domain {
 	int				cqm_work_cpu;
 	struct pseudo_lock_region	*plr;
 	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
+	struct resctrl_mba_sc		*mba_sc;
 };
 
 /**
-- 
2.30.2

