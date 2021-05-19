Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF5F3893B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355376AbhESQ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:27:49 -0400
Received: from foss.arm.com ([217.140.110.172]:48464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355278AbhESQ1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:27:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED7D1169C;
        Wed, 19 May 2021 09:25:39 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C7533F73D;
        Wed, 19 May 2021 09:25:38 -0700 (PDT)
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
Subject: [PATCH v3 15/24] x86/resctrl: Add a helper to read a closid's configuration
Date:   Wed, 19 May 2021 16:24:15 +0000
Message-Id: <20210519162424.27654-16-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210519162424.27654-1-james.morse@arm.com>
References: <20210519162424.27654-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions like show_doms() reach into the architecture's private
structure to retrieve the configuration from the struct rdt_hw_resource.

The hardware configuration may look completely different to the
values resctrl gets from user-space. The staged configuration
and resctrl_arch_update_domains() allow the architecture to
convert or translate these values.

Resctrl shouldn't read or write the ctrl_val[] values directly.
Add a helper to read the current configuration. This will allow another
architecture to scale the bitmaps if necessary, and possibly use controls
that don't take the user-space control format at all.
Of the remaining functions that access ctrl_val[] directly,
apply_config() is part of the architecture specifc code, and is called
via resctrl_arch_update_domains(). reset_all_ctrls() will be an
architecture specific helper.
update_mba_bw() manipulates both ctrl_val[], mbps_val[] and the
hardware. The mbps_val[] that matches the mba_sc state of the
resource is changed, but the other is left unchanged. Abstracting
this is the subject of later patches that affect set_mba_sc() too.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Shuffled commit message,

---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 16 ++++++---
 arch/x86/kernel/cpu/resctrl/monitor.c     |  6 +++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 43 ++++++++++-------------
 include/linux/resctrl.h                   |  2 ++
 4 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 271f5d28412a..1cd54402b02a 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -401,22 +401,30 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
+			     u32 closid, u32 *value)
+{
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+
+	if (!is_mba_sc(r))
+		*value = hw_dom->ctrl_val[closid];
+	else
+		*value = hw_dom->mbps_val[closid];
+}
+
 static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
 {
 	struct rdt_resource *r = schema->res;
-	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *dom;
 	bool sep = false;
 	u32 ctrl_val;
 
 	seq_printf(s, "%*s:", max_name_width, schema->name);
 	list_for_each_entry(dom, &r->domains, list) {
-		hw_dom = resctrl_to_arch_dom(dom);
 		if (sep)
 			seq_puts(s, ";");
 
-		ctrl_val = (!is_mba_sc(r) ? hw_dom->ctrl_val[closid] :
-			    hw_dom->mbps_val[closid]);
+		resctrl_arch_get_config(r, dom, closid, &ctrl_val);
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 76eea10f2e2c..647c0be76ea6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -442,8 +442,12 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
-	user_bw = hw_dom_mba->mbps_val[closid];
+	resctrl_arch_get_config(r_mba, dom_mba, closid, &user_bw);
 	delta_bw = pmbm_data->delta_bw;
+	/*
+	 * resctrl_arch_get_config() chooses the mbps/ctrl value to return
+	 * based on is_mba_sc(). For now, reach into the hw_dom.
+	 */
 	cur_msr_val = hw_dom_mba->ctrl_val[closid];
 
 	/*
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1dec9afd9ff4..57e4d793f576 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -910,27 +910,27 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 	int i, hwb, swb, excl, psl;
 	enum rdtgrp_mode mode;
 	bool sep = false;
-	u32 *ctrl;
+	u32 ctrl_val;
 
 	mutex_lock(&rdtgroup_mutex);
 	hw_shareable = r->cache.shareable_bits;
 	list_for_each_entry(dom, &r->domains, list) {
 		if (sep)
 			seq_putc(seq, ';');
-		ctrl = resctrl_to_arch_dom(dom)->ctrl_val;
 		sw_shareable = 0;
 		exclusive = 0;
 		seq_printf(seq, "%d=", dom->id);
-		for (i = 0; i < closids_supported(); i++, ctrl++) {
+		for (i = 0; i < closids_supported(); i++) {
 			if (!closid_allocated(i))
 				continue;
+			resctrl_arch_get_config(r, dom, i, &ctrl_val);
 			mode = rdtgroup_mode_by_closid(i);
 			switch (mode) {
 			case RDT_MODE_SHAREABLE:
-				sw_shareable |= *ctrl;
+				sw_shareable |= ctrl_val;
 				break;
 			case RDT_MODE_EXCLUSIVE:
-				exclusive |= *ctrl;
+				exclusive |= ctrl_val;
 				break;
 			case RDT_MODE_PSEUDO_LOCKSETUP:
 			/*
@@ -1188,7 +1188,6 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 {
 	enum rdtgrp_mode mode;
 	unsigned long ctrl_b;
-	u32 *ctrl;
 	int i;
 
 	/* Check for any overlap with regions used by hardware directly */
@@ -1199,9 +1198,8 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 	}
 
 	/* Check for overlap with other resource groups */
-	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
-	for (i = 0; i < closids_supported(); i++, ctrl++) {
-		ctrl_b = *ctrl;
+	for (i = 0; i < closids_supported(); i++) {
+		resctrl_arch_get_config(r, d, i, (u32 *)&ctrl_b);
 		mode = rdtgroup_mode_by_closid(i);
 		if (closid_allocated(i) && i != closid &&
 		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
@@ -1269,12 +1267,12 @@ bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
  */
 static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 {
-	struct rdt_hw_domain *hw_dom;
 	int closid = rdtgrp->closid;
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	bool has_cache = false;
 	struct rdt_domain *d;
+	u32 ctrl;
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
@@ -1282,10 +1280,8 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 			continue;
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
-			hw_dom = resctrl_to_arch_dom(d);
-			if (rdtgroup_cbm_overlaps(s, d,
-						  hw_dom->ctrl_val[closid],
-						  rdtgrp->closid, false)) {
+			resctrl_arch_get_config(r, d, closid, &ctrl);
+			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
 				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
 			}
@@ -1417,7 +1413,6 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			      struct seq_file *s, void *v)
 {
 	struct resctrl_schema *schema;
-	struct rdt_hw_domain *hw_dom;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	struct rdt_domain *d;
@@ -1453,15 +1448,13 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		sep = false;
 		seq_printf(s, "%*s:", max_name_width, schema->name);
 		list_for_each_entry(d, &r->domains, list) {
-			hw_dom = resctrl_to_arch_dom(d);
 			if (sep)
 				seq_putc(s, ';');
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 				size = 0;
 			} else {
-				ctrl = (!is_mba_sc(r) ?
-						hw_dom->ctrl_val[rdtgrp->closid] :
-						hw_dom->mbps_val[rdtgrp->closid]);
+				resctrl_arch_get_config(r, d, rdtgrp->closid,
+							&ctrl);
 				if (r->rid == RDT_RESOURCE_MBA)
 					size = ctrl;
 				else
@@ -2736,7 +2729,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	u32 used_b = 0, unused_b = 0;
 	unsigned long tmp_cbm;
 	enum rdtgrp_mode mode;
-	u32 peer_ctl, *ctrl;
+	u32 peer_ctl, ctrl_val;
 	int i;
 
 	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
@@ -2744,8 +2737,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	cfg->have_new_ctrl = false;
 	cfg->new_ctrl = r->cache.shareable_bits;
 	used_b = r->cache.shareable_bits;
-	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
-	for (i = 0; i < closids_supported(); i++, ctrl++) {
+	for (i = 0; i < closids_supported(); i++) {
 		if (closid_allocated(i) && i != closid) {
 			mode = rdtgroup_mode_by_closid(i);
 			if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
@@ -2761,12 +2753,13 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 			 * with an exclusive group.
 			 */
 			if (d_cdp)
-				peer_ctl = resctrl_to_arch_dom(d_cdp)->ctrl_val[i];
+				resctrl_arch_get_config(r_cdp, d_cdp, i, &peer_ctl);
 			else
 				peer_ctl = 0;
-			used_b |= *ctrl | peer_ctl;
+			resctrl_arch_get_config(r, d, i, &ctrl_val);
+			used_b |= ctrl_val | peer_ctl;
 			if (mode == RDT_MODE_SHAREABLE)
-				cfg->new_ctrl |= *ctrl | peer_ctl;
+				cfg->new_ctrl |= ctrl_val | peer_ctl;
 		}
 	}
 	if (d->plr && d->plr->cbm > 0)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index bd867bd8c2f4..aaa2c3244783 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -197,5 +197,7 @@ struct resctrl_schema {
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
+void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
+			     u32 closid, u32 *value);
 
 #endif /* _RESCTRL_H */
-- 
2.30.2

