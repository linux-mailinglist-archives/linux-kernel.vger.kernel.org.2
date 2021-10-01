Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0775241F1C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355227AbhJAQFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:05:34 -0400
Received: from foss.arm.com ([217.140.110.172]:46562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355259AbhJAQFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:05:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3878E13D5;
        Fri,  1 Oct 2021 09:03:46 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C1B13F766;
        Fri,  1 Oct 2021 09:03:44 -0700 (PDT)
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
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
Subject: [PATCH v2 08/23] x86/resctrl: Create mba_sc configuration in the rdt_domain
Date:   Fri,  1 Oct 2021 16:02:47 +0000
Message-Id: <20211001160302.31189-9-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211001160302.31189-1-james.morse@arm.com>
References: <20211001160302.31189-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support resctrl's MBA software controller, the architecture must provide
a second configuration array to hold the mbps_val from user-space.

This complicates the interface between the architecture code.

Make the filesystem parts of resctrl create an array for the mba_sc
values when is_mba_sc() is set to true. The software controller
can be changed to use this, allowing the architecture code to only
consider the values configured in hardware.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Added missing error handling to mba_sc_domain_allocate() in
   domain_setup_mon_state()
 * Added comment about mba_sc_domain_allocate() races
 * Squashed out struct resctrl_mba_sc
 * Moved mount time alloc/free calls to set_mba_sc().
 * Removed mount check in resctrl_offline_domain()
 * Reword commit message
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 67 ++++++++++++++++++++++++++
 include/linux/resctrl.h                |  6 +++
 3 files changed, 73 insertions(+), 1 deletion(-)

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
index 38670bb810cb..9d402bc8bdff 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1889,6 +1889,64 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 		l3_qos_cfg_update(&hw_res->cdp_enabled);
 }
 
+static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_domain *d)
+{
+	u32 num_closid = resctrl_arch_get_num_closid(r);
+	int cpu = cpumask_any(&d->cpu_mask);
+	int i;
+
+	/*
+	 * d->mbps_val is allocated by a call to this function in set_mba_sc(),
+	 * and domain_setup_mon_state(). Both calls are guarded by is_mba_sc(),
+	 * which can only return true while the filesystem is mounted. The
+	 * two calls are prevented from racing as rdt_get_tree() takes the
+	 * cpuhp read lock before calling rdt_enable_ctx(ctx), which prevents
+	 * it running concurrently with resctrl_online_domain().
+	 */
+	lockdep_assert_cpus_held();
+
+	d->mbps_val = kcalloc_node(num_closid, sizeof(*d->mbps_val),
+				   GFP_KERNEL, cpu_to_node(cpu));
+	if (!d->mbps_val)
+		return -ENOMEM;
+
+	for (i = 0; i < num_closid; i++)
+		d->mbps_val[i] = MBA_MAX_MBPS;
+
+	return 0;
+}
+
+static int mba_sc_allocate(struct rdt_resource *r)
+{
+	struct rdt_domain *d;
+	int ret;
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
+	kfree(d->mbps_val);
+	d->mbps_val = NULL;
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
 /*
  * Enable or disable the MBA software controller
  * which helps user specify bandwidth in MBps.
@@ -1911,6 +1969,10 @@ static int set_mba_sc(bool mba_sc)
 		setup_default_ctrlval(r, hw_dom->ctrl_val, hw_dom->mbps_val);
 	}
 
+	if (is_mba_sc(r))
+		return mba_sc_allocate(r);
+
+	mba_sc_destroy(r);
 	return 0;
 }
 
@@ -3259,6 +3321,8 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 		__check_limbo(d, true);
 		cancel_delayed_work(&d->cqm_limbo);
 	}
+	if (is_mba_sc(r))
+		mba_sc_domain_destroy(r, d);
 	bitmap_free(d->rmid_busy_llc);
 	kfree(d->mbm_total);
 	kfree(d->mbm_local);
@@ -3291,6 +3355,9 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 		}
 	}
 
+	if (is_mba_sc(r))
+		return mba_sc_domain_allocate(r, d);
+
 	return 0;
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5d283bdd6162..355660d46612 100644
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
@@ -53,6 +56,8 @@ struct resctrl_staged_config {
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
  * @plr:		pseudo-locked region (if any) associated with domain
  * @staged_config:	parsed configuration to be applied
+ * @mbps_val:		Array of user specified control values for mba_sc,
+ *			indexed by closid
  */
 struct rdt_domain {
 	struct list_head		list;
@@ -67,6 +72,7 @@ struct rdt_domain {
 	int				cqm_work_cpu;
 	struct pseudo_lock_region	*plr;
 	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
+	u32				*mbps_val;
 };
 
 /**
-- 
2.30.2

