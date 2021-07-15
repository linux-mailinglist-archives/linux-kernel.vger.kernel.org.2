Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9F3CA475
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbhGORe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:34:29 -0400
Received: from foss.arm.com ([217.140.110.172]:56158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231687AbhGOReT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:34:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06AEE1042;
        Thu, 15 Jul 2021 10:31:26 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14C203F7D8;
        Thu, 15 Jul 2021 10:31:23 -0700 (PDT)
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
Subject: [PATCH v6 12/24] x86/resctrl: Move the schemata names into struct resctrl_schema
Date:   Thu, 15 Jul 2021 17:30:31 +0000
Message-Id: <20210715173043.14222-13-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl 'info' directories and schema parsing use the schema name.
This lives in the struct rdt_resource, and is specified by the
architecture code.

Once the CDP resources are merged, there will only be one resource
(and one name) in use by two schema. To allow the CDP CODE/DATA
property to be the type of configuration the schema uses, the
name should also be per-schema.

Add a name field to struct resctrl_schema, and use this wherever
the schema name is exposed (or read from) user-space. Calculating
max_name_width for padding the schemata file also moves as this is
visible to user-space. As the names in struct rdt_resource already
include the CDP information, schemata_list_create() copies them.
schemata_list_create() includes the length of the CDP suffix when
calculating max_name_width in preparation for CDP resources being
merged.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v4:
 * Fixed a typo
 * Add the length of the CDP suffix when the resource is capable but CDP
   is not enabled.

Changes since v3:
 * Removed a space,

Changes since v2:
 * Shuffled commit message,

Changes since v1:
 * Don't hardcode max_name_width, that leads to bugs
 * Move max_name_width to live with the code that will generate the name.
 * Fixed name/names typo
---
 arch/x86/kernel/cpu/resctrl/core.c        |  5 ----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 +++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 29 +++++++++++++++++++----
 include/linux/resctrl.h                   |  2 ++
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 87b5aa7683ee..755118a9ef38 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -782,13 +782,8 @@ static int resctrl_offline_cpu(unsigned int cpu)
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
index 0ee1ded5b8ff..104b285f8a60 100644
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
index cc9dacd73438..1f8c8d79d00b 100644
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
@@ -2141,6 +2141,7 @@ static int schemata_list_create(void)
 {
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
+	int ret, cl;
 
 	for_each_alloc_enabled_rdt_resource(r) {
 		s = kzalloc(sizeof(*s), GFP_KERNEL);
@@ -2151,6 +2152,26 @@ static int schemata_list_create(void)
 		s->conf_type = resctrl_to_arch_res(r)->conf_type;
 		s->num_closid = resctrl_arch_get_num_closid(r);
 
+		ret = snprintf(s->name, sizeof(s->name), r->name);
+		if (ret >= sizeof(s->name)) {
+			kfree(s);
+			return -EINVAL;
+		}
+
+		cl = strlen(s->name);
+
+		/*
+		 * If CDP is supported by this resource, but not enabled,
+		 * include the suffix. This ensures the tabular format of the
+		 * schemata file does not change between mounts of the
+		 * filesystem.
+		 */
+		if (r->cdp_capable && !resctrl_arch_get_cdp_enabled(r->rid))
+			cl += 4;
+
+		if (cl > max_name_width)
+			max_name_width = cl;
+
 		INIT_LIST_HEAD(&s->list);
 		list_add(&s->list, &resctrl_schema_all);
 	}
@@ -2784,7 +2805,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	 */
 	tmp_cbm = d->new_ctrl;
 	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
-		rdt_last_cmd_printf("No space on %s:%d\n", r->name, d->id);
+		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
 		return -ENOSPC;
 	}
 	d->have_new_ctrl = true;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 4b30571fbc8e..e482ce790ce2 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -171,6 +171,7 @@ struct rdt_resource {
  * struct resctrl_schema - configuration abilities of a resource presented to
  *			   user-space
  * @list:	Member of resctrl_schema_all.
+ * @name:	The name to use in the "schemata" file.
  * @conf_type:	Whether this schema is specific to code/data.
  * @res:	The resource structure exported by the architecture to describe
  *		the hardware that is configured by this schema.
@@ -180,6 +181,7 @@ struct rdt_resource {
  */
 struct resctrl_schema {
 	struct list_head		list;
+	char				name[8];
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
 	u32				num_closid;
-- 
2.30.2

