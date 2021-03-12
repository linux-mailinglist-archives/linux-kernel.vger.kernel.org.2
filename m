Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C483395C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhCLSBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:01:10 -0500
Received: from foss.arm.com ([217.140.110.172]:58864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233008AbhCLSAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:00:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 915351042;
        Fri, 12 Mar 2021 10:00:37 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBB9D3F7D7;
        Fri, 12 Mar 2021 10:00:35 -0800 (PST)
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
Subject: [PATCH v2 22/24] x86/resctrl: Merge the ctrl_val arrays
Date:   Fri, 12 Mar 2021 17:58:47 +0000
Message-Id: <20210312175849.8327-23-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312175849.8327-1-james.morse@arm.com>
References: <20210312175849.8327-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the CODE/DATA resources don't use overlapping slots in the
ctrl_val arrays, they can be merged. This allows the cdp_peer configuration
to be read from either resource's domain, instead of searching for the
matching flavour.

Doing this before merging the resources temporarily complicates
allocating and freeing the ctrl_val arrays. Add a helper to allocate
the ctrl_val array, that returns the value on the L2 or L3 resource
if it already exists. This gets removed once the resources are merged,
and there really is only one ctrl_val array.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Added underscores to ctrlval when its not in a function name
 * Removed temporary free_ctrlval_arrays() function.
 * Reduced churn in domain_setup_ctrlval().

Doing this before the resources are merged allows any bugs introduced to
be bisected to a smaller change, and keeps the rdt_cdp_peer_get() change
separate.
---
 arch/x86/kernel/cpu/resctrl/core.c | 66 ++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 8d5c1e9eefa1..5021a726e87d 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -509,6 +509,58 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
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
+
+	/*
+	 * If we changed the resource, we need to search for the underlying
+	 * domain. Doing this for all resources would make it tricky to add the
+	 * first resource, as domains aren't added to a resource list until
+	 * after the ctrlval arrays have been allocated.
+	 */
+	if (remapped)
+		underlying_domain = rdt_find_domain(&hw_res->resctrl, d->id,
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
@@ -516,11 +568,11 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
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
@@ -679,8 +731,14 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		if (d->plr)
 			d->plr->d = NULL;
 
-		kfree(hw_dom->ctrl_val);
-		kfree(hw_dom->mbps_val);
+		/* temporary: these four don't have a unique ctrlval array */
+		if ((r->rid != RDT_RESOURCE_L3CODE) &&
+		    (r->rid != RDT_RESOURCE_L3DATA) &&
+		    (r->rid != RDT_RESOURCE_L2CODE) &&
+		    (r->rid != RDT_RESOURCE_L2DATA)) {
+			kfree(hw_dom->ctrl_val);
+			kfree(hw_dom->mbps_val);
+		}
 		bitmap_free(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
-- 
2.30.0

