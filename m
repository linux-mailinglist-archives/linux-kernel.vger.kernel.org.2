Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18A63DAF2F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhG2Wgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:36:39 -0400
Received: from foss.arm.com ([217.140.110.172]:58972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234445AbhG2Wgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:36:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB4FB113E;
        Thu, 29 Jul 2021 15:36:27 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03AE93F70D;
        Thu, 29 Jul 2021 15:36:25 -0700 (PDT)
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
Subject: [PATCH v1 02/20] x86/resctrl: Merge mon_capable and mon_enabled
Date:   Thu, 29 Jul 2021 22:35:52 +0000
Message-Id: <20210729223610.29373-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729223610.29373-1-james.morse@arm.com>
References: <20210729223610.29373-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mon_enabled and mon_capable are always set as a pair by
rdt_get_mon_l3_config().

There is no point having two values.

Merge them together.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 4 ----
 arch/x86/kernel/cpu/resctrl/monitor.c  | 1 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++----
 include/linux/resctrl.h                | 4 ++--
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 53f3d275a98f..8828b5c1b6d2 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -459,10 +459,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 	for_each_rdt_resource(r)					      \
 		if (r->mon_capable)
 
-#define for_each_mon_enabled_rdt_resource(r)				      \
-	for_each_rdt_resource(r)					      \
-		if (r->mon_enabled)
-
 /* CPUID.(EAX=10H, ECX=ResID=1).EAX */
 union cpuid_0x10_1_eax {
 	struct {
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index eb227298487f..035e45e711ae 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -712,7 +712,6 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	l3_mon_evt_init(r);
 
 	r->mon_capable = true;
-	r->mon_enabled = true;
 
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 09d87dbd72ca..3eb5f94a9e7d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1763,7 +1763,7 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 			goto out_destroy;
 	}
 
-	for_each_mon_enabled_rdt_resource(r) {
+	for_each_mon_capable_rdt_resource(r) {
 		fflags =  r->fflags | RF_MON_INFO;
 		sprintf(name, "%s_MON", r->name);
 		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
@@ -2502,7 +2502,7 @@ void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r, unsigned int dom_id)
 	struct rdtgroup *prgrp, *crgrp;
 	char name[32];
 
-	if (!r->mon_enabled)
+	if (!r->mon_capable)
 		return;
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
@@ -2570,7 +2570,7 @@ void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 	struct rdtgroup *prgrp, *crgrp;
 	struct list_head *head;
 
-	if (!r->mon_enabled)
+	if (!r->mon_capable)
 		return;
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
@@ -2640,7 +2640,7 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 	 * Create the subdirectories for each domain. Note that all events
 	 * in a domain like L3 are grouped into a resource whose domain is L3
 	 */
-	for_each_mon_enabled_rdt_resource(r) {
+	for_each_mon_capable_rdt_resource(r) {
 		ret = mkdir_mondata_subdir_alldom(kn, r, prgrp);
 		if (ret)
 			goto out_destroy;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index ada0a02093a6..d715df9de37f 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -130,7 +130,7 @@ struct resctrl_schema;
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
- * @mon_enabled:	Is monitoring enabled for this feature
+ * @cdp_enabled		Is CDP enabled for this resource
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
  * @num_rmid:		Number of RMIDs available
@@ -149,7 +149,7 @@ struct resctrl_schema;
  */
 struct rdt_resource {
 	int			rid;
-	bool			mon_enabled;
+	bool			cdp_enabled;
 	bool			alloc_capable;
 	bool			mon_capable;
 	int			num_rmid;
-- 
2.30.2

