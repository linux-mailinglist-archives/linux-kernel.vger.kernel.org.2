Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6B13395B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhCLSAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:00:13 -0500
Received: from foss.arm.com ([217.140.110.172]:58516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232398AbhCLSAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:00:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 528BC101E;
        Fri, 12 Mar 2021 10:00:00 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85CFE3F7D7;
        Fri, 12 Mar 2021 09:59:58 -0800 (PST)
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
Subject: [PATCH v2 08/24] x86/resctrl: Add resctrl_arch_get_num_closid()
Date:   Fri, 12 Mar 2021 17:58:33 +0000
Message-Id: <20210312175849.8327-9-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312175849.8327-1-james.morse@arm.com>
References: <20210312175849.8327-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl chooses whether to enable CDP, once it does, half the number
of closid are available. MPAM doesn't behave like this, an in-kernel user
of MPAM could be 'using CDP' while resctrl is not. (e.g. a KVM guest)

To move the 'half the closids' behaviour to be part of the filesystem code,
each schema would have a num_closids. This may be different from the
single resources num_closid if CDP is in use. An abstraction between the
hardware property, and the way resctrl is using it is needed.

Add a helper to read the resource's num_closid from the arch code. This
should return the number of closid that the resource supports, regardless
of whether CDP is in use.

This helper is used in the one remaining path that is specific to the
filesystem: schemata_list_create().

In contrast reset_all_ctrls() sets up a structure for modifying the
hardware, it is part of the architecture code, the maximum closid should
be the maximum value the hardware has, regardless of the way resctrl is
using it. All the uses in core.c are naturally part of the architecture
specific code.

For now return the hw_res->num_closid, which is already adjusted for CDP.
Once the CODE/DATA/BOTH resources are merged, resctrl can make the
adjustment when copying the value to the schema's num_closid.

Using a type with an obvious size for the architecture specific helper
means changing the type of num_closid to u32, which matches the type
already used by struct rdtgroup.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Rewrote commit message
 * Whitespace fixes
 * num_closid becomes u32 in all occurences to reduce surprises
---
 arch/x86/kernel/cpu/resctrl/core.c     | 5 +++++
 arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 ++--
 include/linux/resctrl.h                | 6 +++++-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 048c82e3baca..078822bc58ae 100644
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
index 57484d2f6214..51a6e5f2f035 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -370,7 +370,7 @@ struct rdt_parse_data {
 struct rdt_hw_resource {
 	enum resctrl_conf_type	conf_type;
 	struct rdt_resource	resctrl;
-	int			num_closid;
+	u32			num_closid;
 	unsigned int		msr_base;
 	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
 				 struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1ff883f68ee1..a8d8499e6919 100644
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
index 0ff10468940b..5bd48c1ed497 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -171,6 +171,10 @@ struct resctrl_schema {
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
2.30.0

