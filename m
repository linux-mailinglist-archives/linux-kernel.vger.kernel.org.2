Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D11D3CA473
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhGORe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:34:28 -0400
Received: from foss.arm.com ([217.140.110.172]:56136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234845AbhGOReR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:34:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 747926D;
        Thu, 15 Jul 2021 10:31:23 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 821303F7D8;
        Thu, 15 Jul 2021 10:31:21 -0700 (PDT)
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
Subject: [PATCH v6 11/24] x86/resctrl: Add a helper to read/set the CDP configuration
Date:   Thu, 15 Jul 2021 17:30:30 +0000
Message-Id: <20210715173043.14222-12-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whether CDP is enabled for a hardware resource like the L3 cache can
be found by inspecting the alloc_enabled flags of the L3CODE/L3DATA
struct rdt_hw_resources, even if they aren't in use.

Once these resources are merged, the flags can't be compared. Whether
CDP is enabled needs tracking explicitly. If another architecture is
emulating CDP the behaviour may not be per-resource. 'cdp_capable'
needs to be visible to resctrl, even if its not in use, as this
affects the padding of the schemata table visible to user-space.

Add cdp_enabled to struct rdt_hw_resource and cdp_capable to struct
rdt_resource. Add resctrl_arch_set_cdp_enabled() to let resctrl enable
or disable CDP on a resource. resctrl_arch_get_cdp_enabled() lets it
read the current state.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v4:
 * Moved cdp_capable to be visible outside the arch specific struct.
 * Moved this patch earlier in the series.

Changes since v3:
 * Fixed a spelling mistake.

Changes since v2:
 * Merged rdt_domain_reconfigure_cdp() changes here.
 * Shuffled commit message,

Changes since v1:
 * Added prototype for resctrl_arch_set_cdp_enabled()
 * s/Currently/Previously/
 * rdt_get_cdp_config() accesses the array directly as most of the code
   here disappears once the resources are merged.

It isn't practical for MPAM to hide the CDP emulation by applying the same
'L3' configuration to the two closid that are in use, as this would
then consume two monitors, which are likely to be in short supply.
---
 arch/x86/kernel/cpu/resctrl/core.c        |  4 ++
 arch/x86/kernel/cpu/resctrl/internal.h    | 11 +++-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 75 +++++++++++++----------
 include/linux/resctrl.h                   |  3 +-
 5 files changed, 62 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 26e8d20cd072..87b5aa7683ee 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -374,6 +374,10 @@ static void rdt_get_cdp_config(int level, int type)
 	 * "cdp" during resctrl file system mount time.
 	 */
 	r->alloc_enabled = false;
+	rdt_resources_all[level].cdp_enabled = false;
+	rdt_resources_all[type].cdp_enabled = false;
+	r_l->cdp_capable = true;
+	r->cdp_capable = true;
 }
 
 static void rdt_get_cdp_l3_config(void)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f2e370ff4b4e..b8b45bae4b5b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -380,6 +380,7 @@ struct rdt_parse_data {
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  * @mbm_width:		Monitor width, to detect and correct for overflow.
+ * @cdp_enabled:	CDP state of this resource
  *
  * Members of this structure are either private to the architecture
  * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
@@ -394,6 +395,7 @@ struct rdt_hw_resource {
 				 struct rdt_resource *r);
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
+	bool			cdp_enabled;
 };
 
 static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
@@ -414,7 +416,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
 extern struct dentry *debugfs_resctrl;
 
-enum {
+enum resctrl_res_level {
 	RDT_RESOURCE_L3,
 	RDT_RESOURCE_L3DATA,
 	RDT_RESOURCE_L3CODE,
@@ -435,6 +437,13 @@ static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
 	return &hw_res->r_resctrl;
 }
 
+static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
+{
+	return rdt_resources_all[l].cdp_enabled;
+}
+
+int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
+
 /*
  * To return the common struct rdt_resource, which is contained in struct
  * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 3c035a7fa61d..db813f819ad6 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -688,8 +688,8 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 	 *   resource, the portion of cache used by it should be made
 	 *   unavailable to all future allocations from both resources.
 	 */
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].r_resctrl.alloc_enabled ||
-	    rdt_resources_all[RDT_RESOURCE_L2DATA].r_resctrl.alloc_enabled) {
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3) ||
+	    resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2)) {
 		rdt_last_cmd_puts("CDP enabled\n");
 		return -EINVAL;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 305dcf8850a0..cc9dacd73438 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1940,14 +1940,16 @@ static int set_cache_qos_cfg(int level, bool enable)
 /* Restore the qos cfg state when a domain comes online */
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 {
-	if (!r->alloc_capable)
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	if (!r->cdp_capable)
 		return;
 
 	if (r == &rdt_resources_all[RDT_RESOURCE_L2DATA].r_resctrl)
-		l2_qos_cfg_update(&r->alloc_enabled);
+		l2_qos_cfg_update(&hw_res->cdp_enabled);
 
 	if (r == &rdt_resources_all[RDT_RESOURCE_L3DATA].r_resctrl)
-		l3_qos_cfg_update(&r->alloc_enabled);
+		l3_qos_cfg_update(&hw_res->cdp_enabled);
 }
 
 /*
@@ -1991,51 +1993,62 @@ static int cdp_enable(int level, int data_type, int code_type)
 		r_l->alloc_enabled = false;
 		r_ldata->alloc_enabled = true;
 		r_lcode->alloc_enabled = true;
+		rdt_resources_all[level].cdp_enabled = true;
+		rdt_resources_all[data_type].cdp_enabled = true;
+		rdt_resources_all[code_type].cdp_enabled = true;
 	}
 	return ret;
 }
 
-static int cdpl3_enable(void)
-{
-	return cdp_enable(RDT_RESOURCE_L3, RDT_RESOURCE_L3DATA,
-			  RDT_RESOURCE_L3CODE);
-}
-
-static int cdpl2_enable(void)
-{
-	return cdp_enable(RDT_RESOURCE_L2, RDT_RESOURCE_L2DATA,
-			  RDT_RESOURCE_L2CODE);
-}
-
 static void cdp_disable(int level, int data_type, int code_type)
 {
-	struct rdt_resource *r = &rdt_resources_all[level].r_resctrl;
+	struct rdt_hw_resource *r_hw = &rdt_resources_all[level];
+	struct rdt_resource *r = &r_hw->r_resctrl;
 
 	r->alloc_enabled = r->alloc_capable;
 
-	if (rdt_resources_all[data_type].r_resctrl.alloc_enabled) {
+	if (r_hw->cdp_enabled) {
 		rdt_resources_all[data_type].r_resctrl.alloc_enabled = false;
 		rdt_resources_all[code_type].r_resctrl.alloc_enabled = false;
 		set_cache_qos_cfg(level, false);
+		r_hw->cdp_enabled = false;
+		rdt_resources_all[data_type].cdp_enabled = false;
+		rdt_resources_all[code_type].cdp_enabled = false;
 	}
 }
 
-static void cdpl3_disable(void)
+int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
 {
-	cdp_disable(RDT_RESOURCE_L3, RDT_RESOURCE_L3DATA, RDT_RESOURCE_L3CODE);
-}
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
+	enum resctrl_res_level code_type, data_type;
 
-static void cdpl2_disable(void)
-{
-	cdp_disable(RDT_RESOURCE_L2, RDT_RESOURCE_L2DATA, RDT_RESOURCE_L2CODE);
+	if (!hw_res->r_resctrl.cdp_capable)
+		return -EINVAL;
+
+	if (l == RDT_RESOURCE_L3) {
+		code_type = RDT_RESOURCE_L3CODE;
+		data_type = RDT_RESOURCE_L3DATA;
+	} else if (l == RDT_RESOURCE_L2) {
+		code_type = RDT_RESOURCE_L2CODE;
+		data_type = RDT_RESOURCE_L2DATA;
+	} else {
+		return -EINVAL;
+	}
+
+	if (enable)
+		return cdp_enable(l, data_type, code_type);
+
+	cdp_disable(l, data_type, code_type);
+
+	return 0;
 }
 
 static void cdp_disable_all(void)
 {
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].r_resctrl.alloc_enabled)
-		cdpl3_disable();
-	if (rdt_resources_all[RDT_RESOURCE_L2DATA].r_resctrl.alloc_enabled)
-		cdpl2_disable();
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
+		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
+		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
 }
 
 /*
@@ -2113,10 +2126,10 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 	int ret = 0;
 
 	if (ctx->enable_cdpl2)
-		ret = cdpl2_enable();
+		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
 
 	if (!ret && ctx->enable_cdpl3)
-		ret = cdpl3_enable();
+		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
 
 	if (!ret && ctx->enable_mba_mbps)
 		ret = set_mba_sc(true);
@@ -3199,10 +3212,10 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 
 static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 {
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].r_resctrl.alloc_enabled)
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
 		seq_puts(seq, ",cdp");
 
-	if (rdt_resources_all[RDT_RESOURCE_L2DATA].r_resctrl.alloc_enabled)
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
 		seq_puts(seq, ",cdpl2");
 
 	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 979592c869e6..4b30571fbc8e 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -142,6 +142,7 @@ struct resctrl_schema;
  * @parse_ctrlval:	Per resource function pointer to parse control values
  * @evt_list:		List of monitoring events
  * @fflags:		flags to choose base and info files
+ * @cdp_capable:	Is the CDP feature available on this resource
  */
 struct rdt_resource {
 	int			rid;
@@ -163,7 +164,7 @@ struct rdt_resource {
 						 struct rdt_domain *d);
 	struct list_head	evt_list;
 	unsigned long		fflags;
-
+	bool			cdp_capable;
 };
 
 /**
-- 
2.30.2

