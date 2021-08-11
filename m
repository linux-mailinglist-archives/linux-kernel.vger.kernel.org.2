Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A418A3E9628
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhHKQjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:39:18 -0400
Received: from foss.arm.com ([217.140.110.172]:54376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhHKQjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:39:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2A301063;
        Wed, 11 Aug 2021 09:38:53 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A65643F718;
        Wed, 11 Aug 2021 09:38:51 -0700 (PDT)
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
Subject: [PATCH v7 25/24] x86/resctrl: Make resctrl_arch_get_config() return its value
Date:   Wed, 11 Aug 2021 16:38:31 +0000
Message-Id: <20210811163831.14917-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728170637.25610-1-james.morse@arm.com>
References: <20210728170637.25610-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl_arch_get_config() has no return, but does pass a single value
back via one of its arguments.

Return the value instead.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++-------
 arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 20 ++++++++++++--------
 include/linux/resctrl.h                   |  5 ++---
 4 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 9e1c6730520b..4f79f1ad7f28 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -427,16 +427,15 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
-void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
-			     u32 closid, enum resctrl_conf_type type, u32 *value)
+u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
+			    u32 closid, enum resctrl_conf_type type)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	u32 idx = get_config_index(closid, type);
 
 	if (!is_mba_sc(r))
-		*value = hw_dom->ctrl_val[idx];
-	else
-		*value = hw_dom->mbps_val[idx];
+		return hw_dom->ctrl_val[idx];
+	return hw_dom->mbps_val[idx];
 }
 
 static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
@@ -451,8 +450,8 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 		if (sep)
 			seq_puts(s, ";");
 
-		resctrl_arch_get_config(r, dom, closid, schema->conf_type,
-					&ctrl_val);
+		ctrl_val = resctrl_arch_get_config(r, dom, closid,
+						   schema->conf_type);
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index eb227298487f..b0741bee79fc 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -442,7 +442,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
-	resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE, &user_bw);
+	user_bw = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
 	delta_bw = pmbm_data->delta_bw;
 	/*
 	 * resctrl_arch_get_config() chooses the mbps/ctrl value to return
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 89123a4977cf..b57b3db9a6a7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -923,8 +923,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 		for (i = 0; i < closids_supported(); i++) {
 			if (!closid_allocated(i))
 				continue;
-			resctrl_arch_get_config(r, dom, i, s->conf_type,
-						&ctrl_val);
+			ctrl_val = resctrl_arch_get_config(r, dom, i,
+							   s->conf_type);
 			mode = rdtgroup_mode_by_closid(i);
 			switch (mode) {
 			case RDT_MODE_SHAREABLE:
@@ -1142,7 +1142,7 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 
 	/* Check for overlap with other resource groups */
 	for (i = 0; i < closids_supported(); i++) {
-		resctrl_arch_get_config(r, d, i, type, (u32 *)&ctrl_b);
+		ctrl_b = resctrl_arch_get_config(r, d, i, type);
 		mode = rdtgroup_mode_by_closid(i);
 		if (closid_allocated(i) && i != closid &&
 		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
@@ -1222,7 +1222,8 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 			continue;
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
-			resctrl_arch_get_config(r, d, closid, s->conf_type, &ctrl);
+			ctrl = resctrl_arch_get_config(r, d, closid,
+						       s->conf_type);
 			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
 				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
@@ -1395,8 +1396,9 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 				size = 0;
 			} else {
-				resctrl_arch_get_config(r, d, rdtgrp->closid,
-							schema->conf_type, &ctrl);
+				ctrl = resctrl_arch_get_config(r, d,
+							       rdtgrp->closid,
+							       schema->conf_type);
 				if (r->rid == RDT_RESOURCE_MBA)
 					size = ctrl;
 				else
@@ -2724,10 +2726,12 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 			 * with an exclusive group.
 			 */
 			if (resctrl_arch_get_cdp_enabled(r->rid))
-				resctrl_arch_get_config(r, d, i, peer_type, &peer_ctl);
+				peer_ctl = resctrl_arch_get_config(r, d, i,
+								   peer_type);
 			else
 				peer_ctl = 0;
-			resctrl_arch_get_config(r, d, i, s->conf_type, &ctrl_val);
+			ctrl_val = resctrl_arch_get_config(r, d, i,
+							   s->conf_type);
 			used_b |= ctrl_val | peer_ctl;
 			if (mode == RDT_MODE_SHAREABLE)
 				cfg->new_ctrl |= ctrl_val | peer_ctl;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 18dd764af0dd..21deb5212bbd 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -194,8 +194,7 @@ struct resctrl_schema {
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
-void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
-			     u32 closid, enum resctrl_conf_type type,
-			     u32 *value);
+u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
+			    u32 closid, enum resctrl_conf_type type);
 
 #endif /* _RESCTRL_H */
-- 
2.30.2

