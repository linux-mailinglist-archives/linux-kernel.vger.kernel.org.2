Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331683CA477
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhGORef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:34:35 -0400
Received: from foss.arm.com ([217.140.110.172]:56226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231597AbhGOReY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:34:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 438E0113E;
        Thu, 15 Jul 2021 10:31:31 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 519EA3F881;
        Thu, 15 Jul 2021 10:31:29 -0700 (PDT)
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
Subject: [PATCH v6 14/24] x86/resctrl: Allow different CODE/DATA configurations to be staged
Date:   Thu, 15 Jul 2021 17:30:33 +0000
Message-Id: <20210715173043.14222-15-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the CDP resources can be merged, struct rdt_domain will
need an array of struct resctrl_staged_config, one per type of
configuration.

Use the type as an index to the array to ensure that a schema
configuration string can't specify the same domain twice. This
will allow two schema to apply configuration changes to one resource.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Add an empty line

Changes since v2:
 * Shuffled commit message,

Changes since v1:
 * Renamed max enum value CDP_NUM_TYPES
 * Whitespace and parenthesis
 * Missing word in the commit message
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 20 ++++++++++++++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  5 +++--
 include/linux/resctrl.h                   |  4 +++-
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 9ddfa7607234..f29848f98846 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -60,10 +60,11 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	     struct rdt_domain *d)
 {
+	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	unsigned long bw_val;
-	struct resctrl_staged_config *cfg = &d->staged_config;
 
+	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
 		return -EINVAL;
@@ -130,11 +131,12 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	      struct rdt_domain *d)
 {
-	struct resctrl_staged_config *cfg = &d->staged_config;
 	struct rdtgroup *rdtgrp = data->rdtgrp;
+	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	u32 cbm_val;
 
+	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
 		return -EINVAL;
@@ -192,6 +194,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
+	enum resctrl_conf_type t = s->conf_type;
 	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	struct rdt_parse_data data;
@@ -222,7 +225,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 			if (r->parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
-				cfg = &d->staged_config;
+				cfg = &d->staged_config[t];
 				/*
 				 * In pseudo-locking setup mode and just
 				 * parsed a valid CBM that should be
@@ -261,6 +264,7 @@ int update_domains(struct rdt_resource *r, int closid)
 	struct resctrl_staged_config *cfg;
 	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
+	enum resctrl_conf_type t;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
 	bool mba_sc;
@@ -276,9 +280,13 @@ int update_domains(struct rdt_resource *r, int closid)
 	mba_sc = is_mba_sc(r);
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
-		cfg = &hw_dom->d_resctrl.staged_config;
-		if (cfg->have_new_ctrl)
+		for (t = 0; t < CDP_NUM_TYPES; t++) {
+			cfg = &hw_dom->d_resctrl.staged_config[t];
+			if (!cfg->have_new_ctrl)
+				continue;
+
 			apply_config(hw_dom, cfg, closid, cpu_mask, mba_sc);
+		}
 	}
 
 	/*
@@ -350,7 +358,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		list_for_each_entry(dom, &s->res->domains, list)
-			memset(&dom->staged_config, 0, sizeof(dom->staged_config));
+			memset(dom->staged_config, 0, sizeof(dom->staged_config));
 	}
 
 	while ((tok = strsep(&buf, "\n")) != NULL) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 62cc82d7b06e..9f1354cb94e9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2751,6 +2751,7 @@ static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
 static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				 u32 closid)
 {
+	enum resctrl_conf_type t = s->conf_type;
 	struct rdt_resource *r_cdp = NULL;
 	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d_cdp = NULL;
@@ -2762,7 +2763,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	int i;
 
 	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
-	cfg = &d->staged_config;
+	cfg = &d->staged_config[t];
 	cfg->have_new_ctrl = false;
 	cfg->new_ctrl = r->cache.shareable_bits;
 	used_b = r->cache.shareable_bits;
@@ -2846,7 +2847,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r)
 	struct rdt_domain *d;
 
 	list_for_each_entry(d, &r->domains, list) {
-		cfg = &d->staged_config;
+		cfg = &d->staged_config[CDP_NONE];
 		cfg->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
 		cfg->have_new_ctrl = true;
 	}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index ff7f7d7e1348..51ba372f96cd 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -27,6 +27,8 @@ enum resctrl_conf_type {
 	CDP_DATA,
 };
 
+#define CDP_NUM_TYPES	(CDP_DATA + 1)
+
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
  * @new_ctrl:		new ctrl value to be loaded
@@ -64,7 +66,7 @@ struct rdt_domain {
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
 	struct pseudo_lock_region	*plr;
-	struct resctrl_staged_config	staged_config;
+	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
 };
 
 /**
-- 
2.30.2

