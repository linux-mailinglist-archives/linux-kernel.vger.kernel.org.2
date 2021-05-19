Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090C43893A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355338AbhESQ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:27:17 -0400
Received: from foss.arm.com ([217.140.110.172]:48162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355289AbhESQ0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:26:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8C111650;
        Wed, 19 May 2021 09:25:22 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 207B53F73D;
        Wed, 19 May 2021 09:25:21 -0700 (PDT)
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
Subject: [PATCH v3 08/24] x86/resctrl: Add resctrl_arch_get_num_closid()
Date:   Wed, 19 May 2021 16:24:08 +0000
Message-Id: <20210519162424.27654-9-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210519162424.27654-1-james.morse@arm.com>
References: <20210519162424.27654-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To initialise struct resctrl_schema's num_closid, schemata_list_create()
reaches into the architectures private structure to retrieve num_closid
from the struct rdt_hw_resource. The 'half the closids' behaviour
should be part of the filesystem parts of resctrl that are the same
on any architecture. struct resctrl_schema's num_closid should
include any correction for CDP.

Having two properties called num_closid is likely to be confusing when
they have different values.

Add a helper to read the resource's num_closid from the arch code. This
should return the number of closid that the resource supports, regardless
of whether CDP is in use. Once the CDP resources are merged,
schemata_list_create() can apply the correction itself.
Using a type with an obvious size for the arch helper means changing
the type of num_closid to u32, which matches the type already used by
struct rdtgroup.

reset_all_ctrls() does not use resctrl_arch_get_num_closid(), even
though it sets up a structure for modifying the hardware. This function
will be part of the architecture code, the maximum closid should be the
maximum value the hardware has, regardless of the way resctrl is using
it. All the uses of num_closid in core.c are naturally part of the
architecture specific code.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Added comment in rdt_hw_resource
 * Shuffled commit message,

Changes since v1:
 * Rewrote commit message
 * Whitespace fixes
 * num_closid becomes u32 in all occurences to reduce surprises
---
 arch/x86/kernel/cpu/resctrl/core.c     | 5 +++++
 arch/x86/kernel/cpu/resctrl/internal.h | 8 ++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 ++--
 include/linux/resctrl.h                | 6 +++++-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9ba12c3d175a..b406cca56ed4 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -450,6 +450,11 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
 	return NULL;
 }
 
+u32 resctrl_arch_get_num_closid(struct rdt_resource *r)
+{
+	return resctrl_to_arch_res(r)->num_closid;
+}
+
 void rdt_ctrl_update(void *arg)
 {
 	struct msr_param *m = arg;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 47d055087bd1..f2f9d7fe6168 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -366,7 +366,11 @@ struct rdt_parse_data {
  * struct rdt_hw_resource - arch private attributes of a resctrl resource
  * @conf_type:		The type that should be used when configuring. temporary
  * @resctrl:		Attributes of the resource used directly by resctrl.
- * @num_closid:		Maximum number of closid this hardware can support.
+ * @num_closid:		Maximum number of closid this hardware can support,
+ * 			regardless of CDP. This is exposed via
+ * 			resctrl_arch_get_num_closid() to avoid confusion
+ * 			with struct resctrl_schema's property of the same name,
+ * 			which has been corrected for features like CDP.
  * @msr_base:		Base MSR address for CBMs
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
@@ -379,7 +383,7 @@ struct rdt_parse_data {
 struct rdt_hw_resource {
 	enum resctrl_conf_type	conf_type;
 	struct rdt_resource	resctrl;
-	int			num_closid;
+	u32			num_closid;
 	unsigned int		msr_base;
 	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
 				 struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index da2e1c3a414e..39ec0344963e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -104,7 +104,7 @@ int closids_supported(void)
 static void closid_init(void)
 {
 	struct resctrl_schema *s;
-	int rdt_min_closid = 32;
+	u32 rdt_min_closid = 32;
 
 	/* Compute rdt_min_closid across all resources */
 	list_for_each_entry(s, &resctrl_schema_all, list)
@@ -2134,7 +2134,7 @@ static int schemata_list_create(void)
 
 		s->res = r;
 		s->conf_type = resctrl_to_arch_res(r)->conf_type;
-		s->num_closid = resctrl_to_arch_res(r)->num_closid;
+		s->num_closid = resctrl_arch_get_num_closid(r);
 
 		INIT_LIST_HEAD(&s->list);
 		list_add(&s->list, &resctrl_schema_all);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 616a66143dbb..25cd6d788fe0 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -177,6 +177,10 @@ struct resctrl_schema {
 	struct list_head		list;
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
-	int				num_closid;
+	u32				num_closid;
 };
+
+/* The number of closid supported by this resource regardless of CDP */
+u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
+
 #endif /* _RESCTRL_H */
-- 
2.30.2

