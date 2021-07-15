Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80953CA46B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhGOReC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:34:02 -0400
Received: from foss.arm.com ([217.140.110.172]:55930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231410AbhGORd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:33:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B413A6D;
        Thu, 15 Jul 2021 10:31:02 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C20AC3F7D8;
        Thu, 15 Jul 2021 10:31:00 -0700 (PDT)
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
Subject: [PATCH v6 03/24] x86/resctrl: Add a separate schema list for resctrl
Date:   Thu, 15 Jul 2021 17:30:22 +0000
Message-Id: <20210715173043.14222-4-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resctrl exposes schemata to user-space, which allow the control values
to be specified for a group of tasks.

User-visible properties of the interface, (such as the schemata names
and how the values are parsed) are rooted in a struct provided by the
architecture code. (struct rdt_hw_resource). Once a second architecture
uses resctrl, this would allow user-visible properties to diverge
between architectures.

These properties should come from the resctrl code that will be common
to all architectures. Resctrl has no per-schema structure, only struct
rdt_{hw_,}resource. Create a struct resctrl_schema to hold the
rdt_resource. Before a second architecture can be supported, this
structure will also need to hold the schema name visible to user-space
and the type of configuration values for resctrl.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Fixed a spelling mistake, removed a space.

Changes since v2:
 * Expanded comments.
 * Shuffled commit message,

Changes since v1:
 * Renamed resctrl_all_schema list
 * Used schemata_list as a prefix to make these easier to search for
 * Added kerneldoc string
 * Removed 'pending configuration' reference in commit message
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 43 +++++++++++++++++++++++++-
 include/linux/resctrl.h                | 11 +++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 6276beed64a8..94f4c683b7c3 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -110,6 +110,7 @@ extern unsigned int resctrl_cqm_threshold;
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
+extern struct list_head resctrl_schema_all;
 
 enum rdt_group_type {
 	RDTCTRL_GROUP = 0,
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d190a21845ce..3e0b6aa94571 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -39,6 +39,9 @@ static struct kernfs_root *rdt_root;
 struct rdtgroup rdtgroup_default;
 LIST_HEAD(rdt_all_groups);
 
+/* list of entries for the schemata file */
+LIST_HEAD(resctrl_schema_all);
+
 /* Kernel fs node for "info" directory under root */
 static struct kernfs_node *kn_info;
 
@@ -2109,6 +2112,35 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 	return ret;
 }
 
+static int schemata_list_create(void)
+{
+	struct resctrl_schema *s;
+	struct rdt_resource *r;
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		s = kzalloc(sizeof(*s), GFP_KERNEL);
+		if (!s)
+			return -ENOMEM;
+
+		s->res = r;
+
+		INIT_LIST_HEAD(&s->list);
+		list_add(&s->list, &resctrl_schema_all);
+	}
+
+	return 0;
+}
+
+static void schemata_list_destroy(void)
+{
+	struct resctrl_schema *s, *tmp;
+
+	list_for_each_entry_safe(s, tmp, &resctrl_schema_all, list) {
+		list_del(&s->list);
+		kfree(s);
+	}
+}
+
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
@@ -2130,11 +2162,17 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (ret < 0)
 		goto out_cdp;
 
+	ret = schemata_list_create();
+	if (ret) {
+		schemata_list_destroy();
+		goto out_mba;
+	}
+
 	closid_init();
 
 	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
 	if (ret < 0)
-		goto out_mba;
+		goto out_schemata_free;
 
 	if (rdt_mon_capable) {
 		ret = mongroup_create_dir(rdtgroup_default.kn,
@@ -2184,6 +2222,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		kernfs_remove(kn_mongrp);
 out_info:
 	kernfs_remove(kn_info);
+out_schemata_free:
+	schemata_list_destroy();
 out_mba:
 	if (ctx->enable_mba_mbps)
 		set_mba_sc(false);
@@ -2425,6 +2465,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	rmdir_all_sub();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
+	schemata_list_destroy();
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a4c89dafd7fa..5a21d483da6a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -153,4 +153,15 @@ struct rdt_resource {
 
 };
 
+/**
+ * struct resctrl_schema - configuration abilities of a resource presented to
+ *			   user-space
+ * @list:	Member of resctrl_schema_all.
+ * @res:	The resource structure exported by the architecture to describe
+ *		the hardware that is configured by this schema.
+ */
+struct resctrl_schema {
+	struct list_head		list;
+	struct rdt_resource		*res;
+};
 #endif /* _RESCTRL_H */
-- 
2.30.2

