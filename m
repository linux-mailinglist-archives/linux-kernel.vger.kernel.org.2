Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019493CA47D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhGOReq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:34:46 -0400
Received: from foss.arm.com ([217.140.110.172]:56366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234666AbhGOReh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:34:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22FE66D;
        Thu, 15 Jul 2021 10:31:44 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 306AF3F7D8;
        Thu, 15 Jul 2021 10:31:42 -0700 (PDT)
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
Subject: [PATCH v6 19/24] x86/resctrl: Apply offset correction when config is staged
Date:   Thu, 15 Jul 2021 17:30:38 +0000
Message-Id: <20210715173043.14222-20-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When resctrl comes to copy the CAT MSR values from the ctrl_val[] array
into hardware, it applies an offset adjustment based on the type of the
resource. CODE and DATA resources have their closid mapped into an
odd/even range. This mapping is based on a property of the resource.

This happens once the new control value has been written to the ctrl_val[]
array. Once the CDP resources are merged, there will only be a single
property that needs to cover both odd/even mappings to the single
ctrl_val[] array. The offset adjustment must be applied before the new
value is written to the array.

Move the logic from cat_wrmsr() to resctrl_arch_update_domains().
The value provided to apply_config() is now an index in the array,
not the closid. The parameters provided via struct msr_param are now
indexes too. As resctrl's use of closid is a u32, struct msr_param's
type is changed to match.
With this, the CODE and DATA resources only use the odd or even
indexes in the array. This allows the temporary num_closid/2 fixes in
domain_setup_ctrlval() and reset_all_ctrls() to be removed.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Fixed a fat-fingered 'unsinged u32' - oops!
 * Fixed a spelling mistake.

Changes since v2:
 * Shuffled commit message,

Changes since v1:
 * Removing the patch that moved the closid to the staged config means the
   min/max and return from apply_config() appears here.
---
 arch/x86/kernel/cpu/resctrl/core.c        | 15 +----------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 32 +++++++++++++++++------
 arch/x86/kernel/cpu/resctrl/internal.h    |  4 +--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  7 -----
 4 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9f8be5ee5e8a..990e41661b4a 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -195,11 +195,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 };
 
-static unsigned int cbm_idx(struct rdt_resource *r, unsigned int closid)
-{
-	return closid * r->cache.cbm_idx_mult + r->cache.cbm_idx_offset;
-}
-
 /*
  * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
  * as they do not have CPUID enumeration support for Cache allocation.
@@ -438,7 +433,7 @@ cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + cbm_idx(r, i), hw_dom->ctrl_val[i]);
+		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
@@ -549,14 +544,6 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 
 	m.low = 0;
 	m.high = hw_res->num_closid;
-
-	/*
-	 * temporary: the array is full-size, but cat_wrmsr() still re-maps
-	 * the index.
-	 */
-	if (hw_res->conf_type != CDP_NONE)
-		m.high /= 2;
-
 	hw_res->msr_update(d, &m, r);
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 9ead0c0bf6ee..fdb0e11a78dc 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -246,17 +246,29 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	return -EINVAL;
 }
 
-static void apply_config(struct rdt_hw_domain *hw_dom,
-			 struct resctrl_staged_config *cfg, int closid,
+static u32 cbm_idx(struct rdt_resource *r, unsigned int closid)
+{
+	if (r->rid == RDT_RESOURCE_MBA)
+		return closid;
+
+	return closid * r->cache.cbm_idx_mult + r->cache.cbm_idx_offset;
+}
+
+static bool apply_config(struct rdt_hw_domain *hw_dom,
+			 struct resctrl_staged_config *cfg, u32 idx,
 			 cpumask_var_t cpu_mask, bool mba_sc)
 {
 	struct rdt_domain *dom = &hw_dom->d_resctrl;
 	u32 *dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
 
-	if (cfg->new_ctrl != dc[closid]) {
+	if (cfg->new_ctrl != dc[idx]) {
 		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
-		dc[closid] = cfg->new_ctrl;
+		dc[idx] = cfg->new_ctrl;
+
+		return true;
 	}
+
+	return false;
 }
 
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
@@ -269,11 +281,12 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	struct rdt_domain *d;
 	bool mba_sc;
 	int cpu;
+	u32 idx;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
-	msr_param.low = closid;
+	msr_param.low = cbm_idx(r, closid);
 	msr_param.high = msr_param.low + 1;
 	msr_param.res = r;
 
@@ -285,7 +298,9 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 			if (!cfg->have_new_ctrl)
 				continue;
 
-			apply_config(hw_dom, cfg, closid, cpu_mask, mba_sc);
+			idx = cbm_idx(r, closid);
+			if (!apply_config(hw_dom, cfg, idx, cpu_mask, mba_sc))
+				continue;
 		}
 	}
 
@@ -405,11 +420,12 @@ void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 closid, enum resctrl_conf_type type, u32 *value)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	u32 idx = cbm_idx(r, closid);
 
 	if (!is_mba_sc(r))
-		*value = hw_dom->ctrl_val[closid];
+		*value = hw_dom->ctrl_val[idx];
 	else
-		*value = hw_dom->mbps_val[closid];
+		*value = hw_dom->mbps_val[idx];
 }
 
 static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index d89c251d7b5a..0260b1a63b86 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -332,8 +332,8 @@ static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
  */
 struct msr_param {
 	struct rdt_resource	*res;
-	int			low;
-	int			high;
+	u32			low;
+	u32			high;
 };
 
 static inline bool is_llc_occupancy_enabled(void)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 299af12c9fe4..1f72517057e8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2378,13 +2378,6 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	msr_param.low = 0;
 	msr_param.high = hw_res->num_closid;
 
-	/*
-	 * temporary: the array is full-sized, but cat_wrmsr() still re-maps
-	 * the index.
-	 */
-	if (hw_res->cdp_enabled)
-		msr_param.high /= 2;
-
 	/*
 	 * Disable resource control for this resource by setting all
 	 * CBMs in all domains to the maximum mask value. Pick one CPU
-- 
2.30.2

