Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CF23CA46F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhGOReV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:34:21 -0400
Received: from foss.arm.com ([217.140.110.172]:56068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234001AbhGOReJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:34:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2175106F;
        Thu, 15 Jul 2021 10:31:15 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0E2C3F7D8;
        Thu, 15 Jul 2021 10:31:13 -0700 (PDT)
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
Subject: [PATCH v6 08/24] x86/resctrl: Add resctrl_arch_get_num_closid()
Date:   Thu, 15 Jul 2021 17:30:27 +0000
Message-Id: <20210715173043.14222-9-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Fixed a spelling mistake, removed four spaces.

Changes since v2:
 * Added comment in rdt_hw_resource
 * Shuffled commit message,

Changes since v1:
 * Rewrote commit message
 * Whitespace fixes
 * num_closid becomes u32 in all occurrences to reduce surprises
---
 arch/x86/kernel/cpu/resctrl/core.c     | 5 +++++
 arch/x86/kernel/cpu/resctrl/internal.h | 8 ++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 ++--
 include/linux/resctrl.h                | 6 +++++-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c5b5c7227837..26e8d20cd072 100644
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
index b757928f9a46..199ac3d55045 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -371,7 +371,11 @@ struct rdt_parse_data {
  * struct rdt_hw_resource - arch private attributes of a resctrl resource
  * @conf_type:		The type that should be used when configuring. temporary
  * @r_resctrl:		Attributes of the resource used directly by resctrl.
- * @num_closid:		Maximum number of closid this hardware can support.
+ * @num_closid:		Maximum number of closid this hardware can support,
+ *			regardless of CDP. This is exposed via
+ *			resctrl_arch_get_num_closid() to avoid confusion
+ *			with struct resctrl_schema's property of the same name,
+ *			which has been corrected for features like CDP.
  * @msr_base:		Base MSR address for CBMs
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
@@ -384,7 +388,7 @@ struct rdt_parse_data {
 struct rdt_hw_resource {
 	enum resctrl_conf_type	conf_type;
 	struct rdt_resource	r_resctrl;
-	int			num_closid;
+	u32			num_closid;
 	unsigned int		msr_base;
 	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
 				 struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2f29b7d7d602..09ffe9a4a32b 100644
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
index 59d0fa78bb69..b9d200592e54 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -180,6 +180,10 @@ struct resctrl_schema {
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

