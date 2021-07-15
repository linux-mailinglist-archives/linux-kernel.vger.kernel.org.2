Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5402A3CA482
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhGORfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:35:00 -0400
Received: from foss.arm.com ([217.140.110.172]:56366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234651AbhGORem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:34:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53698106F;
        Thu, 15 Jul 2021 10:31:49 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61A983F7D8;
        Thu, 15 Jul 2021 10:31:47 -0700 (PDT)
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
Subject: [PATCH v6 21/24] x86/resctrl: Merge the ctrl_val arrays
Date:   Thu, 15 Jul 2021 17:30:40 +0000
Message-Id: <20210715173043.14222-22-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each struct rdt_hw_resource has its own ctrl_val[] array. When CDP is
enabled, two resources are in use, each with its own ctrl_val[] array
that holds half of the configuration used by hardware. One uses the
odd slots, the other the even. rdt_cdp_peer_get() is the helper to
find the alternate resource, its domain, and corresponding entry
in the other ctrl_val[] array.

Once the CDP resources are merged there will be one struct rdt_hw_resource
and one ctrl_val[] array for each hardware resource. This will
include changes to rdt_cdp_peer_get(), making it hard to bisect any
issue.

Merge the ctrl_val[] arrays for three CODE/DATA/NONE resources first.
Doing this before merging the resources temporarily complicates
allocating and freeing the ctrl_val arrays. Add a helper to allocate
the ctrl_val array, that returns the value on the L2 or L3 resource
if it already exists. This gets removed once the resources are merged,
and there really is only one ctrl_val[] array.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Removed some parenthesis that disappear in a later patch.

Changes since v2:
 * Shuffled commit message,

Changes since v1:
 * Added underscores to ctrlval when its not in a function name
 * Removed temporary free_ctrlval_arrays() function.
 * Reduced churn in domain_setup_ctrlval().
---
 arch/x86/kernel/cpu/resctrl/core.c | 65 ++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c6b953fe7fdf..4c0b1265ffd4 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -509,6 +509,57 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 	}
 }
 
+static u32 *alloc_ctrlval_array(struct rdt_resource *r, struct rdt_domain *d,
+				bool mba_sc)
+{
+	/* these are for the underlying hardware, they may not match r/d */
+	struct rdt_domain *underlying_domain;
+	struct rdt_hw_resource *hw_res;
+	struct rdt_hw_domain *hw_dom;
+	bool remapped;
+
+	switch (r->rid) {
+	case RDT_RESOURCE_L3DATA:
+	case RDT_RESOURCE_L3CODE:
+		hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
+		remapped = true;
+		break;
+	case RDT_RESOURCE_L2DATA:
+	case RDT_RESOURCE_L2CODE:
+		hw_res = &rdt_resources_all[RDT_RESOURCE_L2];
+		remapped = true;
+		break;
+	default:
+		hw_res = resctrl_to_arch_res(r);
+		remapped = false;
+	}
+
+	/*
+	 * If we changed the resource, we need to search for the underlying
+	 * domain. Doing this for all resources would make it tricky to add the
+	 * first resource, as domains aren't added to a resource list until
+	 * after the ctrlval arrays have been allocated.
+	 */
+	if (remapped)
+		underlying_domain = rdt_find_domain(&hw_res->r_resctrl, d->id,
+						    NULL);
+	else
+		underlying_domain = d;
+	hw_dom = resctrl_to_arch_dom(underlying_domain);
+
+	if (mba_sc) {
+		if (hw_dom->mbps_val)
+			return hw_dom->mbps_val;
+		return kmalloc_array(hw_res->num_closid,
+				     sizeof(*hw_dom->mbps_val), GFP_KERNEL);
+	} else {
+		if (hw_dom->ctrl_val)
+			return hw_dom->ctrl_val;
+		return kmalloc_array(hw_res->num_closid,
+				     sizeof(*hw_dom->ctrl_val), GFP_KERNEL);
+	}
+}
+
 static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
@@ -516,11 +567,11 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	struct msr_param m;
 	u32 *dc, *dm;
 
-	dc = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->ctrl_val), GFP_KERNEL);
+	dc = alloc_ctrlval_array(r, d, false);
 	if (!dc)
 		return -ENOMEM;
 
-	dm = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->mbps_val), GFP_KERNEL);
+	dm = alloc_ctrlval_array(r, d, true);
 	if (!dm) {
 		kfree(dc);
 		return -ENOMEM;
@@ -679,8 +730,14 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		if (d->plr)
 			d->plr->d = NULL;
 
-		kfree(hw_dom->ctrl_val);
-		kfree(hw_dom->mbps_val);
+		/* temporary: these four don't have a unique ctrlval array */
+		if (r->rid != RDT_RESOURCE_L3CODE &&
+		    r->rid != RDT_RESOURCE_L3DATA &&
+		    r->rid != RDT_RESOURCE_L2CODE &&
+		    r->rid != RDT_RESOURCE_L2DATA) {
+			kfree(hw_dom->ctrl_val);
+			kfree(hw_dom->mbps_val);
+		}
 		bitmap_free(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
-- 
2.30.2

