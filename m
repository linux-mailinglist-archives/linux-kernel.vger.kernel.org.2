Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B25C3395AF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhCLSAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:00:10 -0500
Received: from foss.arm.com ([217.140.110.172]:58446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232362AbhCLR7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:59:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB89E1396;
        Fri, 12 Mar 2021 09:59:52 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF4E43F7D7;
        Fri, 12 Mar 2021 09:59:50 -0800 (PST)
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
Subject: [PATCH v2 05/24] x86/resctrl: Label the resources with their configuration type
Date:   Fri, 12 Mar 2021 17:58:30 +0000
Message-Id: <20210312175849.8327-6-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312175849.8327-1-james.morse@arm.com>
References: <20210312175849.8327-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The names of resources are used for the schemata name presented to
user-space. These should be part of the filesystem code that is common
to all architectures, as otherwise different architectures could
accidentally support different schemata.

resctrl should be able to generate 'L3, L3CODE, L3DATA' from the
architectures description of a cache at level 3 that supports CDP,
creating two separate struct resctrl_schema for the CDP case that
share the same resource, but differ in name and configuration type.

The configuration type is needed in struct resctrl_schema to generate
the name, and as an index into the array of per-domain staged
configurations that is added by a later patch.

Currently the resources are different for these types, the type
is currently encoded in the name, (and cbm_idx_offset).

Label all the entries in rdt_resources_all[], and copy that value to
struct resctrl_schema.

Copying the value ensures there is no mismatch, but allows the filesystem
parts of resctrl to be modified to use the schema. Once the resources are
merged, the filesystem code can assign this value based on the schema
being created.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * {cdp,conf}_type typo
 * Added kerneldoc comment
---
 arch/x86/kernel/cpu/resctrl/core.c     | 7 +++++++
 arch/x86/kernel/cpu/resctrl/internal.h | 2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 1 +
 include/linux/resctrl.h                | 8 ++++++++
 4 files changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index ca43a7491fda..048c82e3baca 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -62,6 +62,7 @@ mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
 struct rdt_hw_resource rdt_resources_all[] = {
 	[RDT_RESOURCE_L3] =
 	{
+		.conf_type			= CDP_BOTH,
 		.resctrl = {
 			.rid			= RDT_RESOURCE_L3,
 			.name			= "L3",
@@ -81,6 +82,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L3DATA] =
 	{
+		.conf_type			= CDP_DATA,
 		.resctrl = {
 			.rid			= RDT_RESOURCE_L3DATA,
 			.name			= "L3DATA",
@@ -100,6 +102,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L3CODE] =
 	{
+		.conf_type			= CDP_CODE,
 		.resctrl = {
 			.rid			= RDT_RESOURCE_L3CODE,
 			.name			= "L3CODE",
@@ -119,6 +122,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L2] =
 	{
+		.conf_type			= CDP_BOTH,
 		.resctrl = {
 			.rid			= RDT_RESOURCE_L2,
 			.name			= "L2",
@@ -138,6 +142,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L2DATA] =
 	{
+		.conf_type			= CDP_DATA,
 		.resctrl = {
 			.rid			= RDT_RESOURCE_L2DATA,
 			.name			= "L2DATA",
@@ -157,6 +162,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L2CODE] =
 	{
+		.conf_type			= CDP_CODE,
 		.resctrl = {
 			.rid			= RDT_RESOURCE_L2CODE,
 			.name			= "L2CODE",
@@ -176,6 +182,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_MBA] =
 	{
+		.conf_type			= CDP_BOTH,
 		.resctrl = {
 			.rid			= RDT_RESOURCE_MBA,
 			.name			= "MB",
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 8a9da490134b..57484d2f6214 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -361,12 +361,14 @@ struct rdt_parse_data {
 
 /**
  * struct rdt_hw_resource - hw attributes of a resctrl resource
+ * @conf_type:		The type that should be used when configuring. temporary
  * @num_closid:		Number of CLOSIDs available.
  * @msr_base:		Base MSR address for CBMs
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  */
 struct rdt_hw_resource {
+	enum resctrl_conf_type	conf_type;
 	struct rdt_resource	resctrl;
 	int			num_closid;
 	unsigned int		msr_base;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 92b94d85c689..b5702238797b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2135,6 +2135,7 @@ static int schemata_list_create(void)
 			return -ENOMEM;
 
 		s->res = r;
+		s->conf_type = resctrl_to_arch_res(r)->conf_type;
 
 		INIT_LIST_HEAD(&s->list);
 		list_add(&s->list, &resctrl_schema_all);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 092ff0c13b9b..c6f749f54765 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -15,6 +15,12 @@ int proc_resctrl_show(struct seq_file *m,
 
 #endif
 
+enum resctrl_conf_type {
+	CDP_BOTH,
+	CDP_CODE,
+	CDP_DATA,
+};
+
 /**
  * struct rdt_domain - group of CPUs sharing a resctrl resource
  * @list:		all instances of this resource
@@ -157,10 +163,12 @@ struct rdt_resource {
 /**
  * struct resctrl_schema - configuration abilities of a resource presented to user-space
  * @list:	Member of resctrl's schema list
+ * @conf_type:	Whether this entry is for code/data/both
  * @res:	The rdt_resource for this entry
  */
 struct resctrl_schema {
 	struct list_head		list;
+	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
 };
 #endif /* _RESCTRL_H */
-- 
2.30.0

