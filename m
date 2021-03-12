Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0393395B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhCLSAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:00:41 -0500
Received: from foss.arm.com ([217.140.110.172]:58616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232859AbhCLSAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:00:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68644101E;
        Fri, 12 Mar 2021 10:00:10 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95D513F7D7;
        Fri, 12 Mar 2021 10:00:08 -0800 (PST)
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
Subject: [PATCH v2 12/24] x86/resctrl: Group staged configuration into a separate struct
Date:   Fri, 12 Mar 2021 17:58:37 +0000
Message-Id: <20210312175849.8327-13-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312175849.8327-1-james.morse@arm.com>
References: <20210312175849.8327-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm's MPAM may have surprisingly large bitmaps for its cache
portions as the architecture allows up to 4K portions. The size
exposed via resctrl may not be the same, some scaling may
occur.

The values written to hardware may be unlike the values received
from resctrl, e.g. MBA percentages may be backed by a bitmap,
or a maximum value that isn't a percentage.

Previously the values to be used by hardware are written directly
to the ctrl_val array by the resctrl filesystem code before
rdt_ctrl_update() uses a function pointer to write the values to
hardware. This is a problem if scaling or conversion is needed by the
architecture as the hardware values will be different, possibly
requiring a second copy of the array.

To avoid having two copies, the arch code should own the ctrl_val array
(to allow scaling and conversion), and provide helpers to expose
the values in the format resctrl expects. The existing update_domains()
will be part of the architecture specific code.

Currently each domain has a have_new_ctrl flag, which indicates the
domains new_ctrl value should be written into the ctrl_val array and the
hardware updated if the value is different. For lack of a better term,
this is called staging the configuration. The changes are applied by
update_domains(), which takes a resource and a closid as arguments.
The have_new_ctrl flag is used to detect duplicate schemas being
specified by user-space. (e.g. "L3:0=0xff;0=0xff")

Once the resources are merged, staged configuration changes for
CODE and DATA types of resource would be written to the same domain.
The domain needs to hold a staged configuration for each type of
configuration.

Move the new_ctrl bitmap value and flag into a struct. Eventually
there will be an array of these, the values in the struct need to be
specified per type configuration, and there can be one configuration of
each type staged.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
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
index 57c2b0e121d2..a47a792fdcb3 100644
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
+	struct rdt_domain *dom = &hw_dom->resctrl;
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
+		cfg = &hw_dom->resctrl.staged_config;
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
index 1ff969d7de75..0867319cf5ec 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2729,6 +2729,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				 u32 closid)
 {
 	struct rdt_resource *r_cdp = NULL;
+	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d_cdp = NULL;
 	struct rdt_resource *r = s->res;
 	u32 used_b = 0, unused_b = 0;
@@ -2738,8 +2739,9 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
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
@@ -2763,29 +2765,29 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
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
@@ -2817,11 +2819,13 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
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
index 384e232650a8..2d0f1f6e0998 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -21,13 +21,21 @@ enum resctrl_conf_type {
 	CDP_DATA,
 };
 
+/**
+ * struct resctrl_staged_config - parsed configuration to be applied
+ * @new_ctrl:		new ctrl value to be loaded
+ * @have_new_ctrl:	whether the user provide new_ctrl is valid
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
@@ -36,13 +44,12 @@ enum resctrl_conf_type {
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
@@ -51,6 +58,7 @@ struct rdt_domain {
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
 	struct pseudo_lock_region	*plr;
+	struct resctrl_staged_config	staged_config;
 };
 
 /**
-- 
2.30.0

