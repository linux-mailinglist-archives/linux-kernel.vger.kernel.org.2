Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F463CA47F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhGORev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:34:51 -0400
Received: from foss.arm.com ([217.140.110.172]:56016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbhGOReE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:34:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90C691042;
        Thu, 15 Jul 2021 10:31:10 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EEBD3F7D8;
        Thu, 15 Jul 2021 10:31:08 -0700 (PDT)
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
Subject: [PATCH v6 06/24] x86/resctrl: Walk the resctrl schema list instead of an arch list
Date:   Thu, 15 Jul 2021 17:30:25 +0000
Message-Id: <20210715173043.14222-7-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When parsing a schema configuration value from user-space, resctrl
walks the architectures rdt_resources_all[] array to find a
matching struct rdt_resource.

Once the CDP resources are merged there will be one resource in
use by two schema. Anything walking rdt_resources_all[] on behalf
of a user-space request should walk the list of struct resctrl_schema
instead.

Change the users of for_each_alloc_enabled_rdt_resource() to walk
the schema instead. Schema were only created for alloc_enabled resources
so these two lists are currently equivalent.
schemata_list_create() and rdt_kill_sb() are ignored. The first
creates the schema list, and will eventually loop over the resource
indexes using an arch helper to retrieve the resource. rdt_kill_sb()
will eventually make use of an arch 'reset everything' helper.
After the filesystem code is moved, rdtgroup_pseudo_locked_in_hierarchy()
remains part of the x86 specific hooks to support pseudo lock. This code
walks each domain, and still does this after the separate resources are
merged.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * No one can spell pseudo

Changes since v2:
 * Shuffled commit message,

Changes since v1:
 * Expanded commit message
 * Split from a larger patch
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 23 +++++++++++++++--------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 18 ++++++++++++------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 08eef539cb6c..405b99d31ef9 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -287,10 +287,12 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
 				   struct rdtgroup *rdtgrp)
 {
 	struct rdt_hw_resource *hw_res;
+	struct resctrl_schema *s;
 	struct rdt_resource *r;
 
-	for_each_alloc_enabled_rdt_resource(r) {
-		hw_res = resctrl_to_arch_res(r);
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		r = s->res;
+		hw_res = resctrl_to_arch_res(s->res);
 		if (!strcmp(resname, r->name) && rdtgrp->closid < hw_res->num_closid)
 			return parse_line(tok, r, rdtgrp);
 	}
@@ -301,6 +303,7 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
+	struct resctrl_schema *s;
 	struct rdtgroup *rdtgrp;
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
@@ -331,8 +334,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 		goto out;
 	}
 
-	for_each_alloc_enabled_rdt_resource(r) {
-		list_for_each_entry(dom, &r->domains, list)
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		list_for_each_entry(dom, &s->res->domains, list)
 			dom->have_new_ctrl = false;
 	}
 
@@ -353,7 +356,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 			goto out;
 	}
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		r = s->res;
 		ret = update_domains(r, rdtgrp->closid);
 		if (ret)
 			goto out;
@@ -401,6 +405,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v)
 {
 	struct rdt_hw_resource *hw_res;
+	struct resctrl_schema *schema;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	int ret = 0;
@@ -409,8 +414,10 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (rdtgrp) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
-			for_each_alloc_enabled_rdt_resource(r)
+			list_for_each_entry(schema, &resctrl_schema_all, list) {
+				r = schema->res;
 				seq_printf(s, "%s:uninitialized\n", r->name);
+			}
 		} else if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
 			if (!rdtgrp->plr->d) {
 				rdt_last_cmd_clear();
@@ -424,8 +431,8 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			}
 		} else {
 			closid = rdtgrp->closid;
-			for_each_alloc_enabled_rdt_resource(r) {
-				hw_res = resctrl_to_arch_res(r);
+			list_for_each_entry(schema, &resctrl_schema_all, list) {
+				hw_res = resctrl_to_arch_res(schema->res);
 				if (closid < hw_res->num_closid)
 					show_doms(s, r, closid);
 			}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d7fd0712e76c..7502b7de3916 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -104,12 +104,12 @@ int closids_supported(void)
 static void closid_init(void)
 {
 	struct rdt_hw_resource *hw_res;
-	struct rdt_resource *r;
+	struct resctrl_schema *s;
 	int rdt_min_closid = 32;
 
 	/* Compute rdt_min_closid across all resources */
-	for_each_alloc_enabled_rdt_resource(r) {
-		hw_res = resctrl_to_arch_res(r);
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		hw_res = resctrl_to_arch_res(s->res);
 		rdt_min_closid = min(rdt_min_closid, hw_res->num_closid);
 	}
 
@@ -1276,11 +1276,13 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 {
 	struct rdt_hw_domain *hw_dom;
 	int closid = rdtgrp->closid;
+	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	bool has_cache = false;
 	struct rdt_domain *d;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		r = s->res;
 		if (r->rid == RDT_RESOURCE_MBA)
 			continue;
 		has_cache = true;
@@ -1418,6 +1420,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 static int rdtgroup_size_show(struct kernfs_open_file *of,
 			      struct seq_file *s, void *v)
 {
+	struct resctrl_schema *schema;
 	struct rdt_hw_domain *hw_dom;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -1449,7 +1452,8 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		goto out;
 	}
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(schema, &resctrl_schema_all, list) {
+		r = schema->res;
 		sep = false;
 		seq_printf(s, "%*s:", max_name_width, r->name);
 		list_for_each_entry(d, &r->domains, list) {
@@ -2815,10 +2819,12 @@ static void rdtgroup_init_mba(struct rdt_resource *r)
 /* Initialize the RDT group's allocations. */
 static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 {
+	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	int ret;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		r = s->res;
 		if (r->rid == RDT_RESOURCE_MBA) {
 			rdtgroup_init_mba(r);
 		} else {
-- 
2.30.2

