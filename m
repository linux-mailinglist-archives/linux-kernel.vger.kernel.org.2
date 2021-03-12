Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF0D3395BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhCLSAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:00:47 -0500
Received: from foss.arm.com ([217.140.110.172]:58710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232984AbhCLSAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:00:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE14E101E;
        Fri, 12 Mar 2021 10:00:20 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C7453F7D7;
        Fri, 12 Mar 2021 10:00:18 -0800 (PST)
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
        D Scott Phillips OS <scott@os.amperecomputing.com>
Subject: [PATCH v2 16/24] x86/resctrl: Add a helper to read/set the CDP configuration
Date:   Fri, 12 Mar 2021 17:58:41 +0000
Message-Id: <20210312175849.8327-17-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312175849.8327-1-james.morse@arm.com>
References: <20210312175849.8327-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously whether CDP is enabled is described in the alloc_enabled
and alloc_capable flags, which are set differently between the L3
and L3CODE+L3DATA resources.

To merge these resources, to give us one configuration, the CDP state
of the resource needs tracking explicitly. Add cdp_capable and cdp_enabled
as something the arch code manages.

resctrl_arch_set_cdp_enabled() lets resctrl enable or disable CDP
on a resource. resctrl_arch_get_cdp_enabled() lets it read the
current state.

With Arm's MPAM, separate code and data closids is a part of the
CPU configuration. Enabling CDP for one resource means it is enable
for all resources, as all resources would need to configure both
interpretations of the closid value.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Added prototype for resctrl_arch_set_cdp_enabled()
 * s/Currently/Previously/
 * rdt_get_cdp_config() accesses the array directly as most of the code
   here disappears once the resrouces are merged.

It isn't practical for MPAM to hide the CDP emulation by applying the same
'L3' configuration to the two closid that are in use, as this would
then consume two monitors, which are likely to be in short supply.
---
 arch/x86/kernel/cpu/resctrl/core.c        |  4 ++
 arch/x86/kernel/cpu/resctrl/internal.h    | 13 ++++-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 67 +++++++++++++----------
 4 files changed, 57 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4898fb6f70a4..4db28ce114bd 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -374,6 +374,10 @@ static void rdt_get_cdp_config(int level, int type)
 	 * "cdp" during resctrl file system mount time.
 	 */
 	r->alloc_enabled = false;
+	rdt_resources_all[level].cdp_enabled = false;
+	rdt_resources_all[type].cdp_enabled = false;
+	rdt_resources_all[level].cdp_capable = true;
+	rdt_resources_all[type].cdp_capable = true;
 }
 
 static void rdt_get_cdp_l3_config(void)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ff1d58dee66b..9bafe3b32035 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -366,6 +366,8 @@ struct rdt_parse_data {
  * @msr_base:		Base MSR address for CBMs
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
+ * @cdp_enabled:	CDP state of this resource
+ * @cdp_capable:	Is the CDP feature available on this resource
  */
 struct rdt_hw_resource {
 	enum resctrl_conf_type	conf_type;
@@ -376,6 +378,8 @@ struct rdt_hw_resource {
 				 struct rdt_resource *r);
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
+	bool			cdp_enabled;
+	bool			cdp_capable;
 };
 
 static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
@@ -396,7 +400,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
 extern struct dentry *debugfs_resctrl;
 
-enum {
+enum resctrl_res_level {
 	RDT_RESOURCE_L3,
 	RDT_RESOURCE_L3DATA,
 	RDT_RESOURCE_L3CODE,
@@ -417,6 +421,13 @@ static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
 	return &hw_res->resctrl;
 }
 
+static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
+{
+	return rdt_resources_all[l].cdp_enabled;
+}
+
+int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
+
 #define for_each_rdt_resource(r)					      \
 	for (r = &rdt_resources_all[0].resctrl;				      \
 	     r < &rdt_resources_all[RDT_NUM_RESOURCES].resctrl;		      \
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 0ec6e335468c..d4ab1909a7bc 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -684,8 +684,8 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 	 *   resource, the portion of cache used by it should be made
 	 *   unavailable to all future allocations from both resources.
 	 */
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl.alloc_enabled ||
-	    rdt_resources_all[RDT_RESOURCE_L2DATA].resctrl.alloc_enabled) {
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3) ||
+	    resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2)) {
 		rdt_last_cmd_puts("CDP enabled\n");
 		return -EINVAL;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 340bbeabb994..55c17adf763c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1984,51 +1984,62 @@ static int cdp_enable(int level, int data_type, int code_type)
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
-	struct rdt_resource *r = &rdt_resources_all[level].resctrl;
+	struct rdt_hw_resource *r_hw = &rdt_resources_all[level];
+	struct rdt_resource *r = &r_hw->resctrl;
 
 	r->alloc_enabled = r->alloc_capable;
 
-	if (rdt_resources_all[data_type].resctrl.alloc_enabled) {
+	if (r_hw->cdp_enabled) {
 		rdt_resources_all[data_type].resctrl.alloc_enabled = false;
 		rdt_resources_all[code_type].resctrl.alloc_enabled = false;
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
+	if (!hw_res->cdp_capable)
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
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl.alloc_enabled)
-		cdpl3_disable();
-	if (rdt_resources_all[RDT_RESOURCE_L2DATA].resctrl.alloc_enabled)
-		cdpl2_disable();
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
+		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
+		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
 }
 
 /*
@@ -2106,10 +2117,10 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 	int ret = 0;
 
 	if (ctx->enable_cdpl2)
-		ret = cdpl2_enable();
+		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
 
 	if (!ret && ctx->enable_cdpl3)
-		ret = cdpl3_enable();
+		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
 
 	if (!ret && ctx->enable_mba_mbps)
 		ret = set_mba_sc(true);
@@ -3208,10 +3219,10 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 
 static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 {
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl.alloc_enabled)
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
 		seq_puts(seq, ",cdp");
 
-	if (rdt_resources_all[RDT_RESOURCE_L2DATA].resctrl.alloc_enabled)
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
 		seq_puts(seq, ",cdpl2");
 
 	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].resctrl))
-- 
2.30.0

