Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3743CA480
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbhGORez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:34:55 -0400
Received: from foss.arm.com ([217.140.110.172]:56446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235743AbhGORep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:34:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0663A113E;
        Thu, 15 Jul 2021 10:31:52 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 141383F7D8;
        Thu, 15 Jul 2021 10:31:49 -0700 (PDT)
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
Subject: [PATCH v6 22/24] x86/resctrl: Remove rdt_cdp_peer_get()
Date:   Thu, 15 Jul 2021 17:30:41 +0000
Message-Id: <20210715173043.14222-23-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CDP is enabled, rdt_cdp_peer_get() finds the alternative
CODE/DATA resource and returns the alternative domain. This is used
to determine if bitmaps overlap when there are aliased entries
in the two struct rdt_hw_resources.

Now that the ctrl_val[] used by the CODE/DATA resources is the same,
the search for an alternate resource/domain is not needed.

Replace rdt_cdp_peer_get() with resctrl_peer_type(), which returns
the alternative type. This can be passed to resctrl_arch_get_config()
with the same resource and domain.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
No changes since v3.

Changes since v2:
 * Shuffled commit message,

Changes since v1:
 * Expanded commit mesasge.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 99 ++++----------------------
 1 file changed, 14 insertions(+), 85 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1f72517057e8..7cf4bf3583a9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1092,82 +1092,17 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
-/**
- * rdt_cdp_peer_get - Retrieve CDP peer if it exists
- * @r: RDT resource to which RDT domain @d belongs
- * @d: Cache instance for which a CDP peer is requested
- * @r_cdp: RDT resource that shares hardware with @r (RDT resource peer)
- *         Used to return the result.
- * @d_cdp: RDT domain that shares hardware with @d (RDT domain peer)
- *         Used to return the result.
- * @peer_type: The CDP configuration type of the peer resource.
- *
- * RDT resources are managed independently and by extension the RDT domains
- * (RDT resource instances) are managed independently also. The Code and
- * Data Prioritization (CDP) RDT resources, while managed independently,
- * could refer to the same underlying hardware. For example,
- * RDT_RESOURCE_L2CODE and RDT_RESOURCE_L2DATA both refer to the L2 cache.
- *
- * When provided with an RDT resource @r and an instance of that RDT
- * resource @d rdt_cdp_peer_get() will return if there is a peer RDT
- * resource and the exact instance that shares the same hardware.
- *
- * Return: 0 if a CDP peer was found, <0 on error or if no CDP peer exists.
- *         If a CDP peer was found, @r_cdp will point to the peer RDT resource
- *         and @d_cdp will point to the peer RDT domain.
- */
-static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
-			    struct rdt_resource **r_cdp,
-			    struct rdt_domain **d_cdp,
-			    enum resctrl_conf_type *peer_type)
+static enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type)
 {
-	struct rdt_resource *_r_cdp = NULL;
-	struct rdt_domain *_d_cdp = NULL;
-	int ret = 0;
-
-	switch (r->rid) {
-	case RDT_RESOURCE_L3DATA:
-		_r_cdp = &rdt_resources_all[RDT_RESOURCE_L3CODE].r_resctrl;
-		*peer_type = CDP_CODE;
-		break;
-	case RDT_RESOURCE_L3CODE:
-		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L3DATA].r_resctrl;
-		*peer_type = CDP_DATA;
-		break;
-	case RDT_RESOURCE_L2DATA:
-		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2CODE].r_resctrl;
-		*peer_type = CDP_CODE;
-		break;
-	case RDT_RESOURCE_L2CODE:
-		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2DATA].r_resctrl;
-		*peer_type = CDP_DATA;
-		break;
+	switch (my_type) {
+	case CDP_CODE:
+		return CDP_DATA;
+	case CDP_DATA:
+		return CDP_CODE;
 	default:
-		ret = -ENOENT;
-		goto out;
+	case CDP_NONE:
+		return CDP_NONE;
 	}
-
-	/*
-	 * When a new CPU comes online and CDP is enabled then the new
-	 * RDT domains (if any) associated with both CDP RDT resources
-	 * are added in the same CPU online routine while the
-	 * rdtgroup_mutex is held. It should thus not happen for one
-	 * RDT domain to exist and be associated with its RDT CDP
-	 * resource but there is no RDT domain associated with the
-	 * peer RDT CDP resource. Hence the WARN.
-	 */
-	_d_cdp = rdt_find_domain(_r_cdp, d->id, NULL);
-	if (WARN_ON(IS_ERR_OR_NULL(_d_cdp))) {
-		_r_cdp = NULL;
-		_d_cdp = NULL;
-		ret = -EINVAL;
-	}
-
-out:
-	*r_cdp = _r_cdp;
-	*d_cdp = _d_cdp;
-
-	return ret;
 }
 
 /**
@@ -1248,19 +1183,16 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
 			   unsigned long cbm, int closid, bool exclusive)
 {
-	enum resctrl_conf_type peer_type;
+	enum resctrl_conf_type peer_type = resctrl_peer_type(s->conf_type);
 	struct rdt_resource *r = s->res;
-	struct rdt_resource *r_cdp;
-	struct rdt_domain *d_cdp;
 
 	if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, s->conf_type,
 				    exclusive))
 		return true;
 
-	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp, &peer_type) < 0)
+	if (!resctrl_arch_get_cdp_enabled(r->rid))
 		return false;
-
-	return  __rdtgroup_cbm_overlaps(r_cdp, d_cdp, cbm, closid, peer_type, exclusive);
+	return  __rdtgroup_cbm_overlaps(r, d, cbm, closid, peer_type, exclusive);
 }
 
 /**
@@ -2756,11 +2688,9 @@ static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
 static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				 u32 closid)
 {
+	enum resctrl_conf_type peer_type = resctrl_peer_type(s->conf_type);
 	enum resctrl_conf_type t = s->conf_type;
-	struct rdt_resource *r_cdp = NULL;
 	struct resctrl_staged_config *cfg;
-	enum resctrl_conf_type peer_type;
-	struct rdt_domain *d_cdp = NULL;
 	struct rdt_resource *r = s->res;
 	u32 used_b = 0, unused_b = 0;
 	unsigned long tmp_cbm;
@@ -2768,7 +2698,6 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	u32 peer_ctl, ctrl_val;
 	int i;
 
-	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp, &peer_type);
 	cfg = &d->staged_config[t];
 	cfg->have_new_ctrl = false;
 	cfg->new_ctrl = r->cache.shareable_bits;
@@ -2788,8 +2717,8 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 			 * usage to ensure there is no overlap
 			 * with an exclusive group.
 			 */
-			if (d_cdp)
-				resctrl_arch_get_config(r_cdp, d_cdp, i, peer_type, &peer_ctl);
+			if (resctrl_arch_get_cdp_enabled(r->rid))
+				resctrl_arch_get_config(r, d, i, peer_type, &peer_ctl);
 			else
 				peer_ctl = 0;
 			resctrl_arch_get_config(r, d, i, s->conf_type, &ctrl_val);
-- 
2.30.2

