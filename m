Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFAE3A6FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 22:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhFNUM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 16:12:28 -0400
Received: from foss.arm.com ([217.140.110.172]:45556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234563AbhFNUMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:12:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 597A612FC;
        Mon, 14 Jun 2021 13:10:14 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71AD63F694;
        Mon, 14 Jun 2021 13:10:12 -0700 (PDT)
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
        lcherian@marvell.com
Subject: [PATCH v4 07/24] x86/resctrl: Store the effective num_closid in the schema
Date:   Mon, 14 Jun 2021 20:09:24 +0000
Message-Id: <20210614200941.12383-8-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210614200941.12383-1-james.morse@arm.com>
References: <20210614200941.12383-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct resctrl_schema holds properties that vary with the style of
configuration that resctrl applies to a resource. There are already
two values for the hardware's num_closid, depending on whether the
architecture presents the L3 or L3CODE/L3DATA resources.

As the way CDP changes the number of control groups that resctrl can create
is part of the user-space interface, it should be managed by the filesystem
parts of resctrl. This allows the architecture code to only describe the
value the hardware supports.

Add num_closid to resctrl_schema. This is the value seen by the filesystem,
which may be different to the maximum value described by the arch code
when CDP is enabled.
These functions operate on the num_closid value that is exposed to
user-space:
* rdtgroup_parse_resource()
* rdtgroup_schemata_show()
* rdt_num_closids_show()
* closid_init()
These are changed to use the schema value instead. schemata_list_create()
sets this value, and reaches into the architecture specific structure to
get the value. This will eventually be replaced with a helper.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Fixed two spelling mistakes.

Changes since v2:
 * Expanded kerneldoc comment.
 * Shuffled commit message,

Changes since v1:
 * Added missing : in a comment.
 * Expanded commit message.
 * Reordered patches
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  9 +++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 13 ++++---------
 include/linux/resctrl.h                   |  4 ++++
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index a6f9548a8a59..fcd6ca73ac41 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -286,14 +286,12 @@ int update_domains(struct rdt_resource *r, int closid)
 static int rdtgroup_parse_resource(char *resname, char *tok,
 				   struct rdtgroup *rdtgrp)
 {
-	struct rdt_hw_resource *hw_res;
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		hw_res = resctrl_to_arch_res(s->res);
-		if (!strcmp(resname, r->name) && rdtgrp->closid < hw_res->num_closid)
+		if (!strcmp(resname, r->name) && rdtgrp->closid < s->num_closid)
 			return parse_line(tok, r, rdtgrp);
 	}
 	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
@@ -404,7 +402,6 @@ static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v)
 {
-	struct rdt_hw_resource *hw_res;
 	struct resctrl_schema *schema;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -432,8 +429,8 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 		} else {
 			closid = rdtgrp->closid;
 			list_for_each_entry(schema, &resctrl_schema_all, list) {
-				hw_res = resctrl_to_arch_res(schema->res);
-				if (closid < hw_res->num_closid)
+				r = schema->res;
+				if (closid < schema->num_closid)
 					show_doms(s, r, closid);
 			}
 		}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index aad891d691e0..da2e1c3a414e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -103,15 +103,12 @@ int closids_supported(void)
 
 static void closid_init(void)
 {
-	struct rdt_hw_resource *hw_res;
 	struct resctrl_schema *s;
 	int rdt_min_closid = 32;
 
 	/* Compute rdt_min_closid across all resources */
-	list_for_each_entry(s, &resctrl_schema_all, list) {
-		hw_res = resctrl_to_arch_res(s->res);
-		rdt_min_closid = min(rdt_min_closid, hw_res->num_closid);
-	}
+	list_for_each_entry(s, &resctrl_schema_all, list)
+		rdt_min_closid = min(rdt_min_closid, s->num_closid);
 
 	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
 
@@ -849,11 +846,8 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
 				struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = of->kn->parent->priv;
-	struct rdt_resource *r = s->res;
-	struct rdt_hw_resource *hw_res;
 
-	hw_res = resctrl_to_arch_res(r);
-	seq_printf(seq, "%d\n", hw_res->num_closid);
+	seq_printf(seq, "%u\n", s->num_closid);
 	return 0;
 }
 
@@ -2140,6 +2134,7 @@ static int schemata_list_create(void)
 
 		s->res = r;
 		s->conf_type = resctrl_to_arch_res(r)->conf_type;
+		s->num_closid = resctrl_to_arch_res(r)->num_closid;
 
 		INIT_LIST_HEAD(&s->list);
 		list_add(&s->list, &resctrl_schema_all);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 81073d0751c9..de0bef438e54 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -169,10 +169,14 @@ struct rdt_resource {
  * @conf_type:	Whether this schema is specific to code/data.
  * @res:	The resource structure exported by the architecture to describe
  *		the hardware that is configured by this schema.
+ * @num_closid:	The number of closid that can be used with this schema. When
+ *		features like CDP are enabled, this will be lower than the
+ *		hardware supports for the resource.
  */
 struct resctrl_schema {
 	struct list_head		list;
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
+	int				num_closid;
 };
 #endif /* _RESCTRL_H */
-- 
2.30.2

