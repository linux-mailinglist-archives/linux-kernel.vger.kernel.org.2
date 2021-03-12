Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E663395AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhCLSAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:00:08 -0500
Received: from foss.arm.com ([217.140.110.172]:58424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231557AbhCLR7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:59:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8C93106F;
        Fri, 12 Mar 2021 09:59:49 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD88F3F7D7;
        Fri, 12 Mar 2021 09:59:47 -0800 (PST)
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
Subject: [PATCH v2 04/24] x86/resctrl: Pass the schema in info dir's private pointer
Date:   Fri, 12 Mar 2021 17:58:29 +0000
Message-Id: <20210312175849.8327-5-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312175849.8327-1-james.morse@arm.com>
References: <20210312175849.8327-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving properties that resctrl exposes to user-space into the core
'fs' code, (e.g. the name of the schema), means some of the functions
that back the filesystem need the schema struct (to where the properties
are moved), but currently take the resource.

Once the CDP resources are merged, the resource doesn't reflect the
right level of information.

For the info dirs that represent a control, the information needed
is in the schema, as this is how the resource is being used. For the
monitors, its the resource as L3CODE_MON doesn't make sense, and would
monitor data too.

This difference means the type of the private pointers varies
between control and monitor info dirs.

If the flags are RF_MON_INFO, its a struct rdt_resource. If the
flags are RF_CTRL_INFO, its a struct resctrl_schema. Nothing in
res_common_files[] has both flags.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Added comment above removed for_each_alloc_enabled_rdt_resource() to hint
   at symmetry.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 38 +++++++++++++++++---------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 73a695e7096d..92b94d85c689 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -848,7 +848,8 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
 static int rdt_num_closids_show(struct kernfs_open_file *of,
 				struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 	struct rdt_hw_resource *hw_res;
 
 	hw_res = resctrl_to_arch_res(r);
@@ -859,7 +860,8 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
 static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%x\n", r->default_ctrl);
 	return 0;
@@ -868,7 +870,8 @@ static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->cache.min_cbm_bits);
 	return 0;
@@ -877,7 +880,8 @@ static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
 static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 				   struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%x\n", r->cache.shareable_bits);
 	return 0;
@@ -900,13 +904,14 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			      struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
 	/*
 	 * Use unsigned long even though only 32 bits are used to ensure
 	 * test_bit() is used safely.
 	 */
 	unsigned long sw_shareable = 0, hw_shareable = 0;
 	unsigned long exclusive = 0, pseudo_locked = 0;
+	struct rdt_resource *r = s->res;
 	struct rdt_domain *dom;
 	int i, hwb, swb, excl, psl;
 	enum rdtgrp_mode mode;
@@ -978,7 +983,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 static int rdt_min_bw_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->membw.min_bw);
 	return 0;
@@ -1009,7 +1015,8 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 static int rdt_bw_gran_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->membw.bw_gran);
 	return 0;
@@ -1018,7 +1025,8 @@ static int rdt_bw_gran_show(struct kernfs_open_file *of,
 static int rdt_delay_linear_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->membw.delay_linear);
 	return 0;
@@ -1038,7 +1046,8 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
 static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
 					 struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	if (r->membw.throttle_mode == THREAD_THROTTLE_PER_THREAD)
 		seq_puts(seq, "per-thread\n");
@@ -1771,14 +1780,14 @@ int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
 	return ret;
 }
 
-static int rdtgroup_mkdir_info_resdir(struct rdt_resource *r, char *name,
+static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 				      unsigned long fflags)
 {
 	struct kernfs_node *kn_subdir;
 	int ret;
 
 	kn_subdir = kernfs_create_dir(kn_info, name,
-				      kn_info->mode, r);
+				      kn_info->mode, priv);
 	if (IS_ERR(kn_subdir))
 		return PTR_ERR(kn_subdir);
 
@@ -1795,6 +1804,7 @@ static int rdtgroup_mkdir_info_resdir(struct rdt_resource *r, char *name,
 
 static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 {
+	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	unsigned long fflags;
 	char name[32];
@@ -1809,9 +1819,11 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	if (ret)
 		goto out_destroy;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	/* loop over enabled controls, these are all alloc_enabled */
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		r = s->res;
 		fflags =  r->fflags | RF_CTRL_INFO;
-		ret = rdtgroup_mkdir_info_resdir(r, r->name, fflags);
+		ret = rdtgroup_mkdir_info_resdir(s, r->name, fflags);
 		if (ret)
 			goto out_destroy;
 	}
-- 
2.30.0

