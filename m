Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A233CA476
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhGORed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:34:33 -0400
Received: from foss.arm.com ([217.140.110.172]:56196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231679AbhGOReW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:34:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 925E4106F;
        Thu, 15 Jul 2021 10:31:28 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F8E83F7D8;
        Thu, 15 Jul 2021 10:31:26 -0700 (PDT)
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
Subject: [PATCH v6 13/24] x86/resctrl: Group staged configuration into a separate struct
Date:   Thu, 15 Jul 2021 17:30:32 +0000
Message-Id: <20210715173043.14222-14-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When configuration changes are made, the new value is written
to struct rdt_domain's new_ctrl field and the have_new_ctrl flag
is set. Later new_ctrl is copied to hardware by a call to
update_domains().

Once the CDP resources are merged, there will be one new_ctrl
field in use by two struct resctrl_schema requiring a per-schema
IPI to copy the value to hardware.

Move new_ctrl and have_new_ctrl into a new struct resctrl_staged_config.
Before the CDP resources can be merged, struct rdt_domain will
need an array of these, one per type of configuration. Using the
type as an index to the array will ensure that a schema configuration
string can't specify the same domain twice.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v4:
 * Fixed a typo.

No changes since v3.

Changes since v2:
 * Shuffled commit message,

Changes since v1:
 * Expanded commit message
 * Removed explicit clearing of have_new_ctrl,
 * Moved ARRAY_SIZE() trickery to a later patch
 * Removed extra whitespace
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 43 +++++++++++++++--------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 22 +++++++-----
 include/linux/resctrl.h                   | 16 ++++++---
 3 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 104b285f8a60..9ddfa7607234 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -62,16 +62,17 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 {
 	struct rdt_resource *r = s->res;
 	unsigned long bw_val;
+	struct resctrl_staged_config *cfg = &d->staged_config;
 
-	if (d->have_new_ctrl) {
+	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
 		return -EINVAL;
 	}
 
 	if (!bw_validate(data->buf, &bw_val, r))
 		return -EINVAL;
-	d->new_ctrl = bw_val;
-	d->have_new_ctrl = true;
+	cfg->new_ctrl = bw_val;
+	cfg->have_new_ctrl = true;
 
 	return 0;
 }
@@ -129,11 +130,12 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	      struct rdt_domain *d)
 {
+	struct resctrl_staged_config *cfg = &d->staged_config;
 	struct rdtgroup *rdtgrp = data->rdtgrp;
 	struct rdt_resource *r = s->res;
 	u32 cbm_val;
 
-	if (d->have_new_ctrl) {
+	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
 		return -EINVAL;
 	}
@@ -175,8 +177,8 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 		}
 	}
 
-	d->new_ctrl = cbm_val;
-	d->have_new_ctrl = true;
+	cfg->new_ctrl = cbm_val;
+	cfg->have_new_ctrl = true;
 
 	return 0;
 }
@@ -190,6 +192,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
+	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	struct rdt_parse_data data;
 	char *dom = NULL, *id;
@@ -219,6 +222,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 			if (r->parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
+				cfg = &d->staged_config;
 				/*
 				 * In pseudo-locking setup mode and just
 				 * parsed a valid CBM that should be
@@ -229,7 +233,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 				 */
 				rdtgrp->plr->s = s;
 				rdtgrp->plr->d = d;
-				rdtgrp->plr->cbm = d->new_ctrl;
+				rdtgrp->plr->cbm = cfg->new_ctrl;
 				d->plr = rdtgrp->plr;
 				return 0;
 			}
@@ -239,14 +243,27 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	return -EINVAL;
 }
 
+static void apply_config(struct rdt_hw_domain *hw_dom,
+			 struct resctrl_staged_config *cfg, int closid,
+			 cpumask_var_t cpu_mask, bool mba_sc)
+{
+	struct rdt_domain *dom = &hw_dom->d_resctrl;
+	u32 *dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
+
+	if (cfg->new_ctrl != dc[closid]) {
+		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
+		dc[closid] = cfg->new_ctrl;
+	}
+}
+
 int update_domains(struct rdt_resource *r, int closid)
 {
+	struct resctrl_staged_config *cfg;
 	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
 	bool mba_sc;
-	u32 *dc;
 	int cpu;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
@@ -259,11 +276,9 @@ int update_domains(struct rdt_resource *r, int closid)
 	mba_sc = is_mba_sc(r);
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
-		dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
-		if (d->have_new_ctrl && d->new_ctrl != dc[closid]) {
-			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
-			dc[closid] = d->new_ctrl;
-		}
+		cfg = &hw_dom->d_resctrl.staged_config;
+		if (cfg->have_new_ctrl)
+			apply_config(hw_dom, cfg, closid, cpu_mask, mba_sc);
 	}
 
 	/*
@@ -335,7 +350,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		list_for_each_entry(dom, &s->res->domains, list)
-			dom->have_new_ctrl = false;
+			memset(&dom->staged_config, 0, sizeof(dom->staged_config));
 	}
 
 	while ((tok = strsep(&buf, "\n")) != NULL) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1f8c8d79d00b..62cc82d7b06e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2752,6 +2752,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				 u32 closid)
 {
 	struct rdt_resource *r_cdp = NULL;
+	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d_cdp = NULL;
 	struct rdt_resource *r = s->res;
 	u32 used_b = 0, unused_b = 0;
@@ -2761,8 +2762,9 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	int i;
 
 	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
-	d->have_new_ctrl = false;
-	d->new_ctrl = r->cache.shareable_bits;
+	cfg = &d->staged_config;
+	cfg->have_new_ctrl = false;
+	cfg->new_ctrl = r->cache.shareable_bits;
 	used_b = r->cache.shareable_bits;
 	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
 	for (i = 0; i < closids_supported(); i++, ctrl++) {
@@ -2786,29 +2788,29 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				peer_ctl = 0;
 			used_b |= *ctrl | peer_ctl;
 			if (mode == RDT_MODE_SHAREABLE)
-				d->new_ctrl |= *ctrl | peer_ctl;
+				cfg->new_ctrl |= *ctrl | peer_ctl;
 		}
 	}
 	if (d->plr && d->plr->cbm > 0)
 		used_b |= d->plr->cbm;
 	unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
 	unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
-	d->new_ctrl |= unused_b;
+	cfg->new_ctrl |= unused_b;
 	/*
 	 * Force the initial CBM to be valid, user can
 	 * modify the CBM based on system availability.
 	 */
-	d->new_ctrl = cbm_ensure_valid(d->new_ctrl, r);
+	cfg->new_ctrl = cbm_ensure_valid(cfg->new_ctrl, r);
 	/*
 	 * Assign the u32 CBM to an unsigned long to ensure that
 	 * bitmap_weight() does not access out-of-bound memory.
 	 */
-	tmp_cbm = d->new_ctrl;
+	tmp_cbm = cfg->new_ctrl;
 	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
 		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
 		return -ENOSPC;
 	}
-	d->have_new_ctrl = true;
+	cfg->have_new_ctrl = true;
 
 	return 0;
 }
@@ -2840,11 +2842,13 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 /* Initialize MBA resource with default values. */
 static void rdtgroup_init_mba(struct rdt_resource *r)
 {
+	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d;
 
 	list_for_each_entry(d, &r->domains, list) {
-		d->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
-		d->have_new_ctrl = true;
+		cfg = &d->staged_config;
+		cfg->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
+		cfg->have_new_ctrl = true;
 	}
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index e482ce790ce2..ff7f7d7e1348 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -27,13 +27,21 @@ enum resctrl_conf_type {
 	CDP_DATA,
 };
 
+/**
+ * struct resctrl_staged_config - parsed configuration to be applied
+ * @new_ctrl:		new ctrl value to be loaded
+ * @have_new_ctrl:	whether the user provided new_ctrl is valid
+ */
+struct resctrl_staged_config {
+	u32			new_ctrl;
+	bool			have_new_ctrl;
+};
+
 /**
  * struct rdt_domain - group of CPUs sharing a resctrl resource
  * @list:		all instances of this resource
  * @id:			unique id for this instance
  * @cpu_mask:		which CPUs share this resource
- * @new_ctrl:		new ctrl value to be loaded
- * @have_new_ctrl:	did user provide new_ctrl for this domain
  * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
  * @mbm_total:		saved state for MBM total bandwidth
  * @mbm_local:		saved state for MBM local bandwidth
@@ -42,13 +50,12 @@ enum resctrl_conf_type {
  * @mbm_work_cpu:	worker CPU for MBM h/w counters
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
  * @plr:		pseudo-locked region (if any) associated with domain
+ * @staged_config:	parsed configuration to be applied
  */
 struct rdt_domain {
 	struct list_head		list;
 	int				id;
 	struct cpumask			cpu_mask;
-	u32				new_ctrl;
-	bool				have_new_ctrl;
 	unsigned long			*rmid_busy_llc;
 	struct mbm_state		*mbm_total;
 	struct mbm_state		*mbm_local;
@@ -57,6 +64,7 @@ struct rdt_domain {
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
 	struct pseudo_lock_region	*plr;
+	struct resctrl_staged_config	staged_config;
 };
 
 /**
-- 
2.30.2

