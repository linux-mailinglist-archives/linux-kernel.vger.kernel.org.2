Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C953CA47A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhGORel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:34:41 -0400
Received: from foss.arm.com ([217.140.110.172]:56306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234374AbhGORec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:34:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC9E311D4;
        Thu, 15 Jul 2021 10:31:38 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06A073F7D8;
        Thu, 15 Jul 2021 10:31:36 -0700 (PDT)
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
Subject: [PATCH v6 17/24] x86/resctrl: Pass configuration type to resctrl_arch_get_config()
Date:   Thu, 15 Jul 2021 17:30:36 +0000
Message-Id: <20210715173043.14222-18-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ctrl_val[] array for a struct rdt_hw_resource only holds
configurations of one type. The type is implicit.

Once the CDP resources are merged, the ctrl_val[] array will hold
all the configurations for the hardware resource. When a particular
type of configuration is needed, it must be specified explicitly.

Pass the expected type from the schema into resctrl_arch_get_config().
Nothing uses this yet, but once a single ctrl_val[] array is used
for the three struct rdt_hw_resources that share hardware, the type
will be used to return the correct configuration value from the
shared array.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
No changes since v3.

Changes since v2:
 * Shuffled commit message,
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  5 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 35 +++++++++++++++--------
 include/linux/resctrl.h                   |  3 +-
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 4da08ba0deda..9ead0c0bf6ee 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -402,7 +402,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 }
 
 void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
-			     u32 closid, u32 *value)
+			     u32 closid, enum resctrl_conf_type type, u32 *value)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 
@@ -424,7 +424,8 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 		if (sep)
 			seq_puts(s, ";");
 
-		resctrl_arch_get_config(r, dom, closid, &ctrl_val);
+		resctrl_arch_get_config(r, dom, closid, schema->conf_type,
+					&ctrl_val);
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e45e7150eb81..eb227298487f 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -442,7 +442,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
-	resctrl_arch_get_config(r_mba, dom_mba, closid, &user_bw);
+	resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE, &user_bw);
 	delta_bw = pmbm_data->delta_bw;
 	/*
 	 * resctrl_arch_get_config() chooses the mbps/ctrl value to return
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6b2be5633536..61037b239327 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -923,7 +923,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 		for (i = 0; i < closids_supported(); i++) {
 			if (!closid_allocated(i))
 				continue;
-			resctrl_arch_get_config(r, dom, i, &ctrl_val);
+			resctrl_arch_get_config(r, dom, i, s->conf_type,
+						&ctrl_val);
 			mode = rdtgroup_mode_by_closid(i);
 			switch (mode) {
 			case RDT_MODE_SHAREABLE:
@@ -1099,6 +1100,7 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
  *         Used to return the result.
  * @d_cdp: RDT domain that shares hardware with @d (RDT domain peer)
  *         Used to return the result.
+ * @peer_type: The CDP configuration type of the peer resource.
  *
  * RDT resources are managed independently and by extension the RDT domains
  * (RDT resource instances) are managed independently also. The Code and
@@ -1116,7 +1118,8 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
  */
 static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 			    struct rdt_resource **r_cdp,
-			    struct rdt_domain **d_cdp)
+			    struct rdt_domain **d_cdp,
+			    enum resctrl_conf_type *peer_type)
 {
 	struct rdt_resource *_r_cdp = NULL;
 	struct rdt_domain *_d_cdp = NULL;
@@ -1125,15 +1128,19 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 	switch (r->rid) {
 	case RDT_RESOURCE_L3DATA:
 		_r_cdp = &rdt_resources_all[RDT_RESOURCE_L3CODE].r_resctrl;
+		*peer_type = CDP_CODE;
 		break;
 	case RDT_RESOURCE_L3CODE:
 		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L3DATA].r_resctrl;
+		*peer_type = CDP_DATA;
 		break;
 	case RDT_RESOURCE_L2DATA:
 		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2CODE].r_resctrl;
+		*peer_type = CDP_CODE;
 		break;
 	case RDT_RESOURCE_L2CODE:
 		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2DATA].r_resctrl;
+		*peer_type = CDP_DATA;
 		break;
 	default:
 		ret = -ENOENT;
@@ -1184,7 +1191,8 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
  * Return: false if CBM does not overlap, true if it does.
  */
 static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
-				    unsigned long cbm, int closid, bool exclusive)
+				    unsigned long cbm, int closid,
+				    enum resctrl_conf_type type, bool exclusive)
 {
 	enum rdtgrp_mode mode;
 	unsigned long ctrl_b;
@@ -1199,7 +1207,7 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 
 	/* Check for overlap with other resource groups */
 	for (i = 0; i < closids_supported(); i++) {
-		resctrl_arch_get_config(r, d, i, (u32 *)&ctrl_b);
+		resctrl_arch_get_config(r, d, i, type, (u32 *)&ctrl_b);
 		mode = rdtgroup_mode_by_closid(i);
 		if (closid_allocated(i) && i != closid &&
 		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
@@ -1240,17 +1248,19 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
 			   unsigned long cbm, int closid, bool exclusive)
 {
+	enum resctrl_conf_type peer_type;
 	struct rdt_resource *r = s->res;
 	struct rdt_resource *r_cdp;
 	struct rdt_domain *d_cdp;
 
-	if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, exclusive))
+	if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, s->conf_type,
+				    exclusive))
 		return true;
 
-	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp) < 0)
+	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp, &peer_type) < 0)
 		return false;
 
-	return  __rdtgroup_cbm_overlaps(r_cdp, d_cdp, cbm, closid, exclusive);
+	return  __rdtgroup_cbm_overlaps(r_cdp, d_cdp, cbm, closid, peer_type, exclusive);
 }
 
 /**
@@ -1280,7 +1290,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 			continue;
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
-			resctrl_arch_get_config(r, d, closid, &ctrl);
+			resctrl_arch_get_config(r, d, closid, s->conf_type, &ctrl);
 			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
 				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
@@ -1454,7 +1464,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 				size = 0;
 			} else {
 				resctrl_arch_get_config(r, d, rdtgrp->closid,
-							&ctrl);
+							schema->conf_type, &ctrl);
 				if (r->rid == RDT_RESOURCE_MBA)
 					size = ctrl;
 				else
@@ -2747,6 +2757,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	enum resctrl_conf_type t = s->conf_type;
 	struct rdt_resource *r_cdp = NULL;
 	struct resctrl_staged_config *cfg;
+	enum resctrl_conf_type peer_type;
 	struct rdt_domain *d_cdp = NULL;
 	struct rdt_resource *r = s->res;
 	u32 used_b = 0, unused_b = 0;
@@ -2755,7 +2766,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	u32 peer_ctl, ctrl_val;
 	int i;
 
-	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
+	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp, &peer_type);
 	cfg = &d->staged_config[t];
 	cfg->have_new_ctrl = false;
 	cfg->new_ctrl = r->cache.shareable_bits;
@@ -2776,10 +2787,10 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 			 * with an exclusive group.
 			 */
 			if (d_cdp)
-				resctrl_arch_get_config(r_cdp, d_cdp, i, &peer_ctl);
+				resctrl_arch_get_config(r_cdp, d_cdp, i, peer_type, &peer_ctl);
 			else
 				peer_ctl = 0;
-			resctrl_arch_get_config(r, d, i, &ctrl_val);
+			resctrl_arch_get_config(r, d, i, s->conf_type, &ctrl_val);
 			used_b |= ctrl_val | peer_ctl;
 			if (mode == RDT_MODE_SHAREABLE)
 				cfg->new_ctrl |= ctrl_val | peer_ctl;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 3a2309403094..69d7387b7f22 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -201,6 +201,7 @@ struct resctrl_schema {
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
-			     u32 closid, u32 *value);
+			     u32 closid, enum resctrl_conf_type type,
+			     u32 *value);
 
 #endif /* _RESCTRL_H */
-- 
2.30.2

