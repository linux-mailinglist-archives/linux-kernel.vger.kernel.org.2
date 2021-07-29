Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088033DAF33
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhG2Wgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:36:47 -0400
Received: from foss.arm.com ([217.140.110.172]:59078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229928AbhG2Wgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:36:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6513A106F;
        Thu, 29 Jul 2021 15:36:38 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 717F33F70D;
        Thu, 29 Jul 2021 15:36:36 -0700 (PDT)
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
Subject: [PATCH v1 06/20] x86/resctrl: Switch over to the resctrl mbps_val list
Date:   Thu, 29 Jul 2021 22:35:56 +0000
Message-Id: <20210729223610.29373-7-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729223610.29373-1-james.morse@arm.com>
References: <20210729223610.29373-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to resctrl's software controller follow the same path as
other configuration updates, but they don't modify the hardware state.
rdtgroup_schemata_write() uses parse_line() and the resource's
ctrlval_parse function to stage the configuration.
resctrl_arch_update_domains() then updates the mbps_val[] array
instead, and resctrl_arch_update_domains() skips the rdt_ctrl_update()
call that would update hardware.

This complicates the interface between resctrl's filesystem parts
and architecture specific code. It should be possible for mba_sc
to be completely implemented by the filesystem parts of resctrl. This
would allow it to work on a second architecture with no additional code.

Change parse_bw() to write the configuration value directly to the
mba_sc[] array in the domain structure. Change rdtgroup_schemata_write()
to skip the call to resctrl_arch_update_domains(), meaning all the
mba_sc specific code in resctrl_arch_update_domains() can be removed.
On the read-side, show_doms() and update_mba_bw() are changed to read
the mba_sc[] array from the domain structure. With this,
resctrl_arch_get_config() no longer needs to consider mba_sc resources.

Change parse_bw() to write these values directly, meaning
rdtgroup_schemata_write() never needs to call update_domains()
for mba_sc resources.

Get show_doms() to test is_mba_sc() and retrieve the value
directly, instead of using get_config() for the hardware value.

This means the arch code's resctrl_arch_get_config() and
resctrl_arch_update_domains() no longer need to be aware of
mba_sc, and we can get rid of the update_mba_bw() code that
reaches into the hw_dom to get the msr value.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 45 ++++++++++++++---------
 arch/x86/kernel/cpu/resctrl/monitor.c     | 10 ++---
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 9e1c6730520b..56789ea11185 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -61,6 +61,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	     struct rdt_domain *d)
 {
 	struct resctrl_staged_config *cfg;
+	u32 closid = data->rdtgrp->closid;
 	struct rdt_resource *r = s->res;
 	unsigned long bw_val;
 
@@ -72,6 +73,12 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 
 	if (!bw_validate(data->buf, &bw_val, r))
 		return -EINVAL;
+
+	if (is_mba_sc(r)) {
+		d->mba_sc[closid].mbps_val = bw_val;
+		return 0;
+	}
+
 	cfg->new_ctrl = bw_val;
 	cfg->have_new_ctrl = true;
 
@@ -261,14 +268,13 @@ static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
 
 static bool apply_config(struct rdt_hw_domain *hw_dom,
 			 struct resctrl_staged_config *cfg, u32 idx,
-			 cpumask_var_t cpu_mask, bool mba_sc)
+			 cpumask_var_t cpu_mask)
 {
 	struct rdt_domain *dom = &hw_dom->d_resctrl;
-	u32 *dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
 
-	if (cfg->new_ctrl != dc[idx]) {
+	if (cfg->new_ctrl != hw_dom->ctrl_val[idx]) {
 		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
-		dc[idx] = cfg->new_ctrl;
+		hw_dom->ctrl_val[idx] = cfg->new_ctrl;
 
 		return true;
 	}
@@ -284,14 +290,12 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	enum resctrl_conf_type t;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
-	bool mba_sc;
 	int cpu;
 	u32 idx;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
-	mba_sc = is_mba_sc(r);
 	msr_param.res = NULL;
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
@@ -301,7 +305,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 				continue;
 
 			idx = get_config_index(closid, t);
-			if (!apply_config(hw_dom, cfg, idx, cpu_mask, mba_sc))
+			if (!apply_config(hw_dom, cfg, idx, cpu_mask))
 				continue;
 
 			if (!msr_param.res) {
@@ -315,11 +319,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 		}
 	}
 
-	/*
-	 * Avoid writing the control msr with control values when
-	 * MBA software controller is enabled
-	 */
-	if (cpumask_empty(cpu_mask) || mba_sc)
+	if (cpumask_empty(cpu_mask))
 		goto done;
 	cpu = get_cpu();
 	/* Update resource control msr on this CPU if it's in cpu_mask. */
@@ -406,6 +406,14 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
+
+		/*
+		 * Writes to mba_sc resources update the software controller,
+		 * not the control msr.
+		 */
+		if (is_mba_sc(r))
+			continue;
+
 		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
 		if (ret)
 			goto out;
@@ -433,10 +441,7 @@ void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	u32 idx = get_config_index(closid, type);
 
-	if (!is_mba_sc(r))
-		*value = hw_dom->ctrl_val[idx];
-	else
-		*value = hw_dom->mbps_val[idx];
+	*value = hw_dom->ctrl_val[idx];
 }
 
 static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
@@ -451,8 +456,12 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 		if (sep)
 			seq_puts(s, ";");
 
-		resctrl_arch_get_config(r, dom, closid, schema->conf_type,
-					&ctrl_val);
+		if (is_mba_sc(r))
+			ctrl_val = dom->mba_sc[closid].mbps_val;
+		else
+			resctrl_arch_get_config(r, dom, closid,
+						schema->conf_type, &ctrl_val);
+
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 035e45e711ae..dcf3a73e2c17 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -442,13 +442,11 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
-	resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE, &user_bw);
+	user_bw = dom_mba->mba_sc[closid].mbps_val;
 	delta_bw = pmbm_data->delta_bw;
-	/*
-	 * resctrl_arch_get_config() chooses the mbps/ctrl value to return
-	 * based on is_mba_sc(). For now, reach into the hw_dom.
-	 */
-	cur_msr_val = hw_dom_mba->ctrl_val[closid];
+
+	/* MBA monitor resource doesn't support CDP */
+	resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE, &cur_msr_val);
 
 	/*
 	 * For Ctrl groups read data from child monitor groups.
-- 
2.30.2

