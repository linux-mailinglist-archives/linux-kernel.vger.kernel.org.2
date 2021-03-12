Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511123395B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhCLSAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:00:39 -0500
Received: from foss.arm.com ([217.140.110.172]:58592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232714AbhCLSAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:00:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED25D1042;
        Fri, 12 Mar 2021 10:00:07 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C9123F7D7;
        Fri, 12 Mar 2021 10:00:06 -0800 (PST)
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
Subject: [PATCH v2 11/24] x86/resctrl: Move the schemata names into struct resctrl_schema
Date:   Fri, 12 Mar 2021 17:58:36 +0000
Message-Id: <20210312175849.8327-12-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312175849.8327-1-james.morse@arm.com>
References: <20210312175849.8327-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the names used for the schemata file out of the resource and
into struct resctrl_schema. This allows one resource to have two
different names, based on the other schema properties.

Currently the names are copied as they must match the resource, which
is currently separate. Eventually resctrl will generate two names
for one resource.

The filesystem code should calculate max_name_width for padding the
schemata file, move this to live with the code that will generate
the names.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1;
 * Don't hardcode max_name_width, that leads to bugs
 * Move max_name_width to live with the code that will generate the name.
 * Fixed name/names typo
---
 arch/x86/kernel/cpu/resctrl/core.c        |  5 -----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 +++-------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 19 +++++++++++++++----
 include/linux/resctrl.h                   |  2 ++
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 078822bc58ae..4898fb6f70a4 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -778,13 +778,8 @@ static int resctrl_offline_cpu(unsigned int cpu)
 static __init void rdt_init_padding(void)
 {
 	struct rdt_resource *r;
-	int cl;
 
 	for_each_alloc_capable_rdt_resource(r) {
-		cl = strlen(r->name);
-		if (cl > max_name_width)
-			max_name_width = cl;
-
 		if (r->data_width > max_data_width)
 			max_data_width = r->data_width;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 4428ec499037..57c2b0e121d2 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -290,11 +290,9 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
 				   struct rdtgroup *rdtgrp)
 {
 	struct resctrl_schema *s;
-	struct rdt_resource *r;
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
-		r = s->res;
-		if (!strcmp(resname, r->name) && rdtgrp->closid < s->num_closid)
+		if (!strcmp(resname, s->name) && rdtgrp->closid < s->num_closid)
 			return parse_line(tok, s, rdtgrp);
 	}
 	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
@@ -388,7 +386,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 	bool sep = false;
 	u32 ctrl_val;
 
-	seq_printf(s, "%*s:", max_name_width, r->name);
+	seq_printf(s, "%*s:", max_name_width, schema->name);
 	list_for_each_entry(dom, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(dom);
 		if (sep)
@@ -408,7 +406,6 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 {
 	struct resctrl_schema *schema;
 	struct rdtgroup *rdtgrp;
-	struct rdt_resource *r;
 	int ret = 0;
 	u32 closid;
 
@@ -416,8 +413,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 	if (rdtgrp) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 			list_for_each_entry(schema, &resctrl_schema_all, list) {
-				r = schema->res;
-				seq_printf(s, "%s:uninitialized\n", r->name);
+				seq_printf(s, "%s:uninitialized\n", schema->name);
 			}
 		} else if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
 			if (!rdtgrp->plr->d) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1e59d3e9b861..1ff969d7de75 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1439,7 +1439,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			ret = -ENODEV;
 		} else {
 			seq_printf(s, "%*s:", max_name_width,
-				   rdtgrp->plr->s->res->name);
+				   rdtgrp->plr->s->name);
 			size = rdtgroup_cbm_to_size(rdtgrp->plr->s->res,
 						    rdtgrp->plr->d,
 						    rdtgrp->plr->cbm);
@@ -1451,7 +1451,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 	list_for_each_entry(schema, &resctrl_schema_all, list) {
 		r = schema->res;
 		sep = false;
-		seq_printf(s, "%*s:", max_name_width, r->name);
+		seq_printf(s, "%*s:", max_name_width, schema->name);
 		list_for_each_entry(d, &r->domains, list) {
 			hw_dom = resctrl_to_arch_dom(d);
 			if (sep)
@@ -1823,7 +1823,7 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
 		fflags =  r->fflags | RF_CTRL_INFO;
-		ret = rdtgroup_mkdir_info_resdir(s, r->name, fflags);
+		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
 		if (ret)
 			goto out_destroy;
 	}
@@ -2128,6 +2128,7 @@ static int schemata_list_create(void)
 {
 	struct rdt_resource *r;
 	struct resctrl_schema *s;
+	int ret, cl;
 
 	for_each_alloc_enabled_rdt_resource(r) {
 		s = kzalloc(sizeof(*s), GFP_KERNEL);
@@ -2138,6 +2139,16 @@ static int schemata_list_create(void)
 		s->conf_type = resctrl_to_arch_res(r)->conf_type;
 		s->num_closid = resctrl_arch_get_num_closid(r);
 
+		ret = snprintf(s->name, sizeof(s->name), r->name);
+		if (ret >= sizeof(s->name)) {
+			kfree(s);
+			return -EINVAL;
+		}
+
+		cl = strlen(s->name);
+		if (cl > max_name_width)
+			max_name_width = cl;
+
 		INIT_LIST_HEAD(&s->list);
 		list_add(&s->list, &resctrl_schema_all);
 	}
@@ -2771,7 +2782,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	 */
 	tmp_cbm = d->new_ctrl;
 	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
-		rdt_last_cmd_printf("No space on %s:%d\n", r->name, d->id);
+		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
 		return -ENOSPC;
 	}
 	d->have_new_ctrl = true;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 60650ec08eb2..384e232650a8 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -164,12 +164,14 @@ struct rdt_resource {
 /**
  * struct resctrl_schema - configuration abilities of a resource presented to user-space
  * @list:	Member of resctrl's schema list
+ * @name:	Name to use in "schemata" file
  * @conf_type:	Whether this entry is for code/data/both
  * @res:	The rdt_resource for this entry
  * @num_closid:	Number of CLOSIDs available for this resource
  */
 struct resctrl_schema {
 	struct list_head		list;
+	char				name[8];
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
 	u32				num_closid;
-- 
2.30.0

