Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8C13CA483
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhGORfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:35:03 -0400
Received: from foss.arm.com ([217.140.110.172]:56500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235580AbhGORev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:34:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 632FF6D;
        Thu, 15 Jul 2021 10:31:57 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7038B3F7D8;
        Thu, 15 Jul 2021 10:31:55 -0700 (PDT)
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
Subject: [PATCH v6 24/24] x86/resctrl: Merge the CDP resources
Date:   Thu, 15 Jul 2021 17:30:43 +0000
Message-Id: <20210715173043.14222-25-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl uses struct rdt_resource to describe the available hardware
resources. The domains of the CDP aliases share a single ctrl_val[]
array. The only differences between the struct rdt_hw_resource
aliases is the name and conf_type.

The name from struct rdt_hw_resource is visible to user-space. To
support another architecture, as many user-visible details should be
handled in the filesystem parts of the code that is common to all
architectures. The name and conf_type go together.

Remove conf_type and the CDP aliases. When CDP is supported and
enabled, schemata_list_create() can create two schema using the
single resource, generating the CODE/DATA suffix to the schema
name itself.
This allows the alloc_ctrlval_array() and complications around free()ing
the ctrl_val arrays to be removed.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Added braces around an else
 * Removed a space.

Changes since v2:
 * Removed stray conf_type that remained in the arch specific struct
 * Shuffled commit message,

Changes since v1:
 * rdt_get_cdp_config() is kept for its comment.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 178 ++-----------------------
 arch/x86/kernel/cpu/resctrl/internal.h |   6 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 140 +++++++++----------
 3 files changed, 85 insertions(+), 239 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4c0b1265ffd4..4b8813bafffd 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -62,7 +62,6 @@ mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
 struct rdt_hw_resource rdt_resources_all[] = {
 	[RDT_RESOURCE_L3] =
 	{
-		.conf_type			= CDP_NONE,
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L3,
 			.name			= "L3",
@@ -78,45 +77,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
-	[RDT_RESOURCE_L3DATA] =
-	{
-		.conf_type			= CDP_DATA,
-		.r_resctrl = {
-			.rid			= RDT_RESOURCE_L3DATA,
-			.name			= "L3DATA",
-			.cache_level		= 3,
-			.cache = {
-				.min_cbm_bits	= 1,
-			},
-			.domains		= domain_init(RDT_RESOURCE_L3DATA),
-			.parse_ctrlval		= parse_cbm,
-			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
-		},
-		.msr_base		= MSR_IA32_L3_CBM_BASE,
-		.msr_update		= cat_wrmsr,
-	},
-	[RDT_RESOURCE_L3CODE] =
-	{
-		.conf_type			= CDP_CODE,
-		.r_resctrl = {
-			.rid			= RDT_RESOURCE_L3CODE,
-			.name			= "L3CODE",
-			.cache_level		= 3,
-			.cache = {
-				.min_cbm_bits	= 1,
-			},
-			.domains		= domain_init(RDT_RESOURCE_L3CODE),
-			.parse_ctrlval		= parse_cbm,
-			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
-		},
-		.msr_base		= MSR_IA32_L3_CBM_BASE,
-		.msr_update		= cat_wrmsr,
-	},
 	[RDT_RESOURCE_L2] =
 	{
-		.conf_type			= CDP_NONE,
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L2,
 			.name			= "L2",
@@ -132,45 +94,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
-	[RDT_RESOURCE_L2DATA] =
-	{
-		.conf_type			= CDP_DATA,
-		.r_resctrl = {
-			.rid			= RDT_RESOURCE_L2DATA,
-			.name			= "L2DATA",
-			.cache_level		= 2,
-			.cache = {
-				.min_cbm_bits	= 1,
-			},
-			.domains		= domain_init(RDT_RESOURCE_L2DATA),
-			.parse_ctrlval		= parse_cbm,
-			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
-		},
-		.msr_base		= MSR_IA32_L2_CBM_BASE,
-		.msr_update		= cat_wrmsr,
-	},
-	[RDT_RESOURCE_L2CODE] =
-	{
-		.conf_type			= CDP_CODE,
-		.r_resctrl = {
-			.rid			= RDT_RESOURCE_L2CODE,
-			.name			= "L2CODE",
-			.cache_level		= 2,
-			.cache = {
-				.min_cbm_bits	= 1,
-			},
-			.domains		= domain_init(RDT_RESOURCE_L2CODE),
-			.parse_ctrlval		= parse_cbm,
-			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
-		},
-		.msr_base		= MSR_IA32_L2_CBM_BASE,
-		.msr_update		= cat_wrmsr,
-	},
 	[RDT_RESOURCE_MBA] =
 	{
-		.conf_type			= CDP_NONE,
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_MBA,
 			.name			= "MB",
@@ -339,40 +264,24 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	r->alloc_enabled = true;
 }
 
-static void rdt_get_cdp_config(int level, int type)
+static void rdt_get_cdp_config(int level)
 {
-	struct rdt_resource *r_l = &rdt_resources_all[level].r_resctrl;
-	struct rdt_hw_resource *hw_res_l = resctrl_to_arch_res(r_l);
-	struct rdt_resource *r = &rdt_resources_all[type].r_resctrl;
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-
-	hw_res->num_closid = hw_res_l->num_closid;
-	r->cache.cbm_len = r_l->cache.cbm_len;
-	r->default_ctrl = r_l->default_ctrl;
-	r->cache.shareable_bits = r_l->cache.shareable_bits;
-	r->data_width = (r->cache.cbm_len + 3) / 4;
-	r->alloc_capable = true;
 	/*
 	 * By default, CDP is disabled. CDP can be enabled by mount parameter
 	 * "cdp" during resctrl file system mount time.
 	 */
-	r->alloc_enabled = false;
 	rdt_resources_all[level].cdp_enabled = false;
-	rdt_resources_all[type].cdp_enabled = false;
-	r_l->cdp_capable = true;
-	r->cdp_capable = true;
+	rdt_resources_all[level].r_resctrl.cdp_capable = true;
 }
 
 static void rdt_get_cdp_l3_config(void)
 {
-	rdt_get_cdp_config(RDT_RESOURCE_L3, RDT_RESOURCE_L3DATA);
-	rdt_get_cdp_config(RDT_RESOURCE_L3, RDT_RESOURCE_L3CODE);
+	rdt_get_cdp_config(RDT_RESOURCE_L3);
 }
 
 static void rdt_get_cdp_l2_config(void)
 {
-	rdt_get_cdp_config(RDT_RESOURCE_L2, RDT_RESOURCE_L2DATA);
-	rdt_get_cdp_config(RDT_RESOURCE_L2, RDT_RESOURCE_L2CODE);
+	rdt_get_cdp_config(RDT_RESOURCE_L2);
 }
 
 static void
@@ -509,57 +418,6 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 	}
 }
 
-static u32 *alloc_ctrlval_array(struct rdt_resource *r, struct rdt_domain *d,
-				bool mba_sc)
-{
-	/* these are for the underlying hardware, they may not match r/d */
-	struct rdt_domain *underlying_domain;
-	struct rdt_hw_resource *hw_res;
-	struct rdt_hw_domain *hw_dom;
-	bool remapped;
-
-	switch (r->rid) {
-	case RDT_RESOURCE_L3DATA:
-	case RDT_RESOURCE_L3CODE:
-		hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
-		remapped = true;
-		break;
-	case RDT_RESOURCE_L2DATA:
-	case RDT_RESOURCE_L2CODE:
-		hw_res = &rdt_resources_all[RDT_RESOURCE_L2];
-		remapped = true;
-		break;
-	default:
-		hw_res = resctrl_to_arch_res(r);
-		remapped = false;
-	}
-
-	/*
-	 * If we changed the resource, we need to search for the underlying
-	 * domain. Doing this for all resources would make it tricky to add the
-	 * first resource, as domains aren't added to a resource list until
-	 * after the ctrlval arrays have been allocated.
-	 */
-	if (remapped)
-		underlying_domain = rdt_find_domain(&hw_res->r_resctrl, d->id,
-						    NULL);
-	else
-		underlying_domain = d;
-	hw_dom = resctrl_to_arch_dom(underlying_domain);
-
-	if (mba_sc) {
-		if (hw_dom->mbps_val)
-			return hw_dom->mbps_val;
-		return kmalloc_array(hw_res->num_closid,
-				     sizeof(*hw_dom->mbps_val), GFP_KERNEL);
-	} else {
-		if (hw_dom->ctrl_val)
-			return hw_dom->ctrl_val;
-		return kmalloc_array(hw_res->num_closid,
-				     sizeof(*hw_dom->ctrl_val), GFP_KERNEL);
-	}
-}
-
 static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
@@ -567,11 +425,13 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	struct msr_param m;
 	u32 *dc, *dm;
 
-	dc = alloc_ctrlval_array(r, d, false);
+	dc = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->ctrl_val),
+			   GFP_KERNEL);
 	if (!dc)
 		return -ENOMEM;
 
-	dm = alloc_ctrlval_array(r, d, true);
+	dm = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->mbps_val),
+			   GFP_KERNEL);
 	if (!dm) {
 		kfree(dc);
 		return -ENOMEM;
@@ -730,14 +590,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		if (d->plr)
 			d->plr->d = NULL;
 
-		/* temporary: these four don't have a unique ctrlval array */
-		if (r->rid != RDT_RESOURCE_L3CODE &&
-		    r->rid != RDT_RESOURCE_L3DATA &&
-		    r->rid != RDT_RESOURCE_L2CODE &&
-		    r->rid != RDT_RESOURCE_L2DATA) {
-			kfree(hw_dom->ctrl_val);
-			kfree(hw_dom->mbps_val);
-		}
+		kfree(hw_dom->ctrl_val);
+		kfree(hw_dom->mbps_val);
 		bitmap_free(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
@@ -1017,11 +871,7 @@ static __init void rdt_init_res_defs_intel(void)
 		hw_res = resctrl_to_arch_res(r);
 
 		if (r->rid == RDT_RESOURCE_L3 ||
-		    r->rid == RDT_RESOURCE_L3DATA ||
-		    r->rid == RDT_RESOURCE_L3CODE ||
-		    r->rid == RDT_RESOURCE_L2 ||
-		    r->rid == RDT_RESOURCE_L2DATA ||
-		    r->rid == RDT_RESOURCE_L2CODE) {
+		    r->rid == RDT_RESOURCE_L2) {
 			r->cache.arch_has_sparse_bitmaps = false;
 			r->cache.arch_has_empty_bitmaps = false;
 			r->cache.arch_has_per_cpu_cfg = false;
@@ -1041,11 +891,7 @@ static __init void rdt_init_res_defs_amd(void)
 		hw_res = resctrl_to_arch_res(r);
 
 		if (r->rid == RDT_RESOURCE_L3 ||
-		    r->rid == RDT_RESOURCE_L3DATA ||
-		    r->rid == RDT_RESOURCE_L3CODE ||
-		    r->rid == RDT_RESOURCE_L2 ||
-		    r->rid == RDT_RESOURCE_L2DATA ||
-		    r->rid == RDT_RESOURCE_L2CODE) {
+		    r->rid == RDT_RESOURCE_L2) {
 			r->cache.arch_has_sparse_bitmaps = true;
 			r->cache.arch_has_empty_bitmaps = true;
 			r->cache.arch_has_per_cpu_cfg = true;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 0260b1a63b86..b82b7def4242 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -369,7 +369,6 @@ struct rdt_parse_data {
 
 /**
  * struct rdt_hw_resource - arch private attributes of a resctrl resource
- * @conf_type:		The type that should be used when configuring. temporary
  * @r_resctrl:		Attributes of the resource used directly by resctrl.
  * @num_closid:		Maximum number of closid this hardware can support,
  *			regardless of CDP. This is exposed via
@@ -387,7 +386,6 @@ struct rdt_parse_data {
  * msr_update and msr_base.
  */
 struct rdt_hw_resource {
-	enum resctrl_conf_type	conf_type;
 	struct rdt_resource	r_resctrl;
 	u32			num_closid;
 	unsigned int		msr_base;
@@ -418,11 +416,7 @@ extern struct dentry *debugfs_resctrl;
 
 enum resctrl_res_level {
 	RDT_RESOURCE_L3,
-	RDT_RESOURCE_L3DATA,
-	RDT_RESOURCE_L3CODE,
 	RDT_RESOURCE_L2,
-	RDT_RESOURCE_L2DATA,
-	RDT_RESOURCE_L2CODE,
 	RDT_RESOURCE_MBA,
 
 	/* Must be the last */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7cf4bf3583a9..89123a4977cf 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1880,10 +1880,10 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 	if (!r->cdp_capable)
 		return;
 
-	if (r == &rdt_resources_all[RDT_RESOURCE_L2DATA].r_resctrl)
+	if (r->rid == RDT_RESOURCE_L2)
 		l2_qos_cfg_update(&hw_res->cdp_enabled);
 
-	if (r == &rdt_resources_all[RDT_RESOURCE_L3DATA].r_resctrl)
+	if (r->rid == RDT_RESOURCE_L3)
 		l3_qos_cfg_update(&hw_res->cdp_enabled);
 }
 
@@ -1912,68 +1912,42 @@ static int set_mba_sc(bool mba_sc)
 	return 0;
 }
 
-static int cdp_enable(int level, int data_type, int code_type)
+static int cdp_enable(int level)
 {
-	struct rdt_resource *r_ldata = &rdt_resources_all[data_type].r_resctrl;
-	struct rdt_resource *r_lcode = &rdt_resources_all[code_type].r_resctrl;
 	struct rdt_resource *r_l = &rdt_resources_all[level].r_resctrl;
 	int ret;
 
-	if (!r_l->alloc_capable || !r_ldata->alloc_capable ||
-	    !r_lcode->alloc_capable)
+	if (!r_l->alloc_capable)
 		return -EINVAL;
 
 	ret = set_cache_qos_cfg(level, true);
-	if (!ret) {
-		r_l->alloc_enabled = false;
-		r_ldata->alloc_enabled = true;
-		r_lcode->alloc_enabled = true;
+	if (!ret)
 		rdt_resources_all[level].cdp_enabled = true;
-		rdt_resources_all[data_type].cdp_enabled = true;
-		rdt_resources_all[code_type].cdp_enabled = true;
-	}
+
 	return ret;
 }
 
-static void cdp_disable(int level, int data_type, int code_type)
+static void cdp_disable(int level)
 {
 	struct rdt_hw_resource *r_hw = &rdt_resources_all[level];
-	struct rdt_resource *r = &r_hw->r_resctrl;
-
-	r->alloc_enabled = r->alloc_capable;
 
 	if (r_hw->cdp_enabled) {
-		rdt_resources_all[data_type].r_resctrl.alloc_enabled = false;
-		rdt_resources_all[code_type].r_resctrl.alloc_enabled = false;
 		set_cache_qos_cfg(level, false);
 		r_hw->cdp_enabled = false;
-		rdt_resources_all[data_type].cdp_enabled = false;
-		rdt_resources_all[code_type].cdp_enabled = false;
 	}
 }
 
 int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
 {
 	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
-	enum resctrl_res_level code_type, data_type;
 
 	if (!hw_res->r_resctrl.cdp_capable)
 		return -EINVAL;
 
-	if (l == RDT_RESOURCE_L3) {
-		code_type = RDT_RESOURCE_L3CODE;
-		data_type = RDT_RESOURCE_L3DATA;
-	} else if (l == RDT_RESOURCE_L2) {
-		code_type = RDT_RESOURCE_L2CODE;
-		data_type = RDT_RESOURCE_L2DATA;
-	} else {
-		return -EINVAL;
-	}
-
 	if (enable)
-		return cdp_enable(l, data_type, code_type);
+		return cdp_enable(l);
 
-	cdp_disable(l, data_type, code_type);
+	cdp_disable(l);
 
 	return 0;
 }
@@ -2072,48 +2046,80 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 	return ret;
 }
 
-static int schemata_list_create(void)
+static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type)
 {
 	struct resctrl_schema *s;
-	struct rdt_resource *r;
+	const char *suffix = "";
 	int ret, cl;
 
+	s = kzalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	s->res = r;
+	s->num_closid = resctrl_arch_get_num_closid(r);
+	if (resctrl_arch_get_cdp_enabled(r->rid))
+		s->num_closid /= 2;
+
+	s->conf_type = type;
+	switch (type) {
+	case CDP_CODE:
+		suffix = "CODE";
+		break;
+	case CDP_DATA:
+		suffix = "DATA";
+		break;
+	case CDP_NONE:
+		suffix = "";
+		break;
+	}
+
+	ret = snprintf(s->name, sizeof(s->name), "%s%s", r->name, suffix);
+	if (ret >= sizeof(s->name)) {
+		kfree(s);
+		return -EINVAL;
+	}
+
+	cl = strlen(s->name);
+
+	/*
+	 * If CDP is supported by this resource, but not enabled,
+	 * include the suffix. This ensures the tabular format of the
+	 * schemata file does not change between mounts of the filesystem.
+	 */
+	if (r->cdp_capable && !resctrl_arch_get_cdp_enabled(r->rid))
+		cl += 4;
+
+	if (cl > max_name_width)
+		max_name_width = cl;
+
+	INIT_LIST_HEAD(&s->list);
+	list_add(&s->list, &resctrl_schema_all);
+
+	return 0;
+}
+
+static int schemata_list_create(void)
+{
+	struct rdt_resource *r;
+	int ret = 0;
+
 	for_each_alloc_enabled_rdt_resource(r) {
-		s = kzalloc(sizeof(*s), GFP_KERNEL);
-		if (!s)
-			return -ENOMEM;
+		if (resctrl_arch_get_cdp_enabled(r->rid)) {
+			ret = schemata_list_add(r, CDP_CODE);
+			if (ret)
+				break;
 
-		s->res = r;
-		s->conf_type = resctrl_to_arch_res(r)->conf_type;
-		s->num_closid = resctrl_arch_get_num_closid(r);
-		if (resctrl_arch_get_cdp_enabled(r->rid))
-			s->num_closid /= 2;
-
-		ret = snprintf(s->name, sizeof(s->name), r->name);
-		if (ret >= sizeof(s->name)) {
-			kfree(s);
-			return -EINVAL;
+			ret = schemata_list_add(r, CDP_DATA);
+		} else {
+			ret = schemata_list_add(r, CDP_NONE);
 		}
 
-		cl = strlen(s->name);
-
-		/*
-		 * If CDP is supported by this resource, but not enabled,
-		 * include the suffix. This ensures the tabular format of the
-		 * schemata file does not change between mounts of the
-		 * filesystem.
-		 */
-		if (r->cdp_capable && !resctrl_arch_get_cdp_enabled(r->rid))
-			cl += 4;
-
-		if (cl > max_name_width)
-			max_name_width = cl;
-
-		INIT_LIST_HEAD(&s->list);
-		list_add(&s->list, &resctrl_schema_all);
+		if (ret)
+			break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static void schemata_list_destroy(void)
-- 
2.30.2

