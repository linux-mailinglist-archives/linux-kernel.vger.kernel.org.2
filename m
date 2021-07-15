Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B7A3CA470
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhGOReY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:34:24 -0400
Received: from foss.arm.com ([217.140.110.172]:56092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234128AbhGOReL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:34:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 486B6113E;
        Thu, 15 Jul 2021 10:31:18 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 563703F7D8;
        Thu, 15 Jul 2021 10:31:16 -0700 (PDT)
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
Subject: [PATCH v6 09/24] x86/resctrl: Pass the schema to resctrl filesystem functions
Date:   Thu, 15 Jul 2021 17:30:28 +0000
Message-Id: <20210715173043.14222-10-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the CDP resources are merged, there will be two struct
resctrl_schema for one struct rdt_resource. CDP becomes a type of
configuration that belongs to the schema.

Helpers like rdtgroup_cbm_overlaps() need access to the schema to
query the configuration (or configurations) based on schema properties.

Change these functions to take a struct schema instead of the
struct rdt_resource. All the modified functions are part of the filesystem
code that will move to /fs/resctrl once it is possible to support a
second architecture.

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
 * split from a larger patch
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 23 +++++++++++++----------
 arch/x86/kernel/cpu/resctrl/internal.h    |  6 +++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 19 +++++++++++--------
 include/linux/resctrl.h                   |  3 ++-
 4 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index d10fddaef5f4..219b057e65b0 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -57,9 +57,10 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	     struct rdt_domain *d)
 {
+	struct rdt_resource *r = s->res;
 	unsigned long bw_val;
 
 	if (d->have_new_ctrl) {
@@ -125,10 +126,11 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
-int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
+int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	      struct rdt_domain *d)
 {
 	struct rdtgroup *rdtgrp = data->rdtgrp;
+	struct rdt_resource *r = s->res;
 	u32 cbm_val;
 
 	if (d->have_new_ctrl) {
@@ -160,12 +162,12 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 	 * The CBM may not overlap with the CBM of another closid if
 	 * either is exclusive.
 	 */
-	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, true)) {
+	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, true)) {
 		rdt_last_cmd_puts("Overlaps with exclusive group\n");
 		return -EINVAL;
 	}
 
-	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, false)) {
+	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, false)) {
 		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
 		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 			rdt_last_cmd_puts("Overlaps with other group\n");
@@ -185,9 +187,10 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
  * separated by ";". The "id" is in decimal, and must match one of
  * the "id"s for this resource.
  */
-static int parse_line(char *line, struct rdt_resource *r,
+static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
+	struct rdt_resource *r = s->res;
 	struct rdt_parse_data data;
 	char *dom = NULL, *id;
 	struct rdt_domain *d;
@@ -213,7 +216,7 @@ static int parse_line(char *line, struct rdt_resource *r,
 		if (d->id == dom_id) {
 			data.buf = dom;
 			data.rdtgrp = rdtgrp;
-			if (r->parse_ctrlval(&data, r, d))
+			if (r->parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
 				/*
@@ -292,7 +295,7 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
 		if (!strcmp(resname, r->name) && rdtgrp->closid < s->num_closid)
-			return parse_line(tok, r, rdtgrp);
+			return parse_line(tok, s, rdtgrp);
 	}
 	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
 	return -EINVAL;
@@ -377,8 +380,9 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
-static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
+static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
 {
+	struct rdt_resource *r = schema->res;
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *dom;
 	bool sep = false;
@@ -429,9 +433,8 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 		} else {
 			closid = rdtgrp->closid;
 			list_for_each_entry(schema, &resctrl_schema_all, list) {
-				r = schema->res;
 				if (closid < schema->num_closid)
-					show_doms(s, r, closid);
+					show_doms(s, schema, closid);
 			}
 		}
 	} else {
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 199ac3d55045..299c1960eae7 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -401,9 +401,9 @@ static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r
 	return container_of(r, struct rdt_hw_resource, r_resctrl);
 }
 
-int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
+int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	      struct rdt_domain *d);
-int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	     struct rdt_domain *d);
 
 extern struct mutex rdtgroup_mutex;
@@ -506,7 +506,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
-bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
 			   unsigned long cbm, int closid, bool exclusive);
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
 				  unsigned long cbm);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 09ffe9a4a32b..53d281a9f54f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1221,7 +1221,7 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 
 /**
  * rdtgroup_cbm_overlaps - Does CBM overlap with other use of hardware
- * @r: Resource to which domain instance @d belongs.
+ * @s: Schema for the resource to which domain instance @d belongs.
  * @d: The domain instance for which @closid is being tested.
  * @cbm: Capacity bitmask being tested.
  * @closid: Intended closid for @cbm.
@@ -1239,9 +1239,10 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
  *
  * Return: true if CBM overlap detected, false if there is no overlap
  */
-bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
 			   unsigned long cbm, int closid, bool exclusive)
 {
+	struct rdt_resource *r = s->res;
 	struct rdt_resource *r_cdp;
 	struct rdt_domain *d_cdp;
 
@@ -1282,7 +1283,8 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
 			hw_dom = resctrl_to_arch_dom(d);
-			if (rdtgroup_cbm_overlaps(r, d, hw_dom->ctrl_val[closid],
+			if (rdtgroup_cbm_overlaps(s, d,
+						  hw_dom->ctrl_val[closid],
 						  rdtgrp->closid, false)) {
 				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
@@ -2712,11 +2714,12 @@ static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
  * Set the RDT domain up to start off with all usable allocations. That is,
  * all shareable and unused bits. All-zero CBM is invalid.
  */
-static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
+static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				 u32 closid)
 {
 	struct rdt_resource *r_cdp = NULL;
 	struct rdt_domain *d_cdp = NULL;
+	struct rdt_resource *r = s->res;
 	u32 used_b = 0, unused_b = 0;
 	unsigned long tmp_cbm;
 	enum rdtgrp_mode mode;
@@ -2786,13 +2789,13 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
  * If there are no more shareable bits available on any domain then
  * the entire allocation will fail.
  */
-static int rdtgroup_init_cat(struct rdt_resource *r, u32 closid)
+static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 {
 	struct rdt_domain *d;
 	int ret;
 
-	list_for_each_entry(d, &r->domains, list) {
-		ret = __init_one_rdt_domain(d, r, closid);
+	list_for_each_entry(d, &s->res->domains, list) {
+		ret = __init_one_rdt_domain(d, s, closid);
 		if (ret < 0)
 			return ret;
 	}
@@ -2823,7 +2826,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 		if (r->rid == RDT_RESOURCE_MBA) {
 			rdtgroup_init_mba(r);
 		} else {
-			ret = rdtgroup_init_cat(r, rdtgrp->closid);
+			ret = rdtgroup_init_cat(s, rdtgrp->closid);
 			if (ret < 0)
 				return ret;
 		}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b9d200592e54..979592c869e6 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -121,6 +121,7 @@ struct resctrl_membw {
 };
 
 struct rdt_parse_data;
+struct resctrl_schema;
 
 /**
  * struct rdt_resource - attributes of a resctrl resource
@@ -158,7 +159,7 @@ struct rdt_resource {
 	u32			default_ctrl;
 	const char		*format_str;
 	int			(*parse_ctrlval)(struct rdt_parse_data *data,
-						 struct rdt_resource *r,
+						 struct resctrl_schema *s,
 						 struct rdt_domain *d);
 	struct list_head	evt_list;
 	unsigned long		fflags;
-- 
2.30.2

