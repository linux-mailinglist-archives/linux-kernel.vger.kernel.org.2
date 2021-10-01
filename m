Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E105A41F1C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355277AbhJAQFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:05:39 -0400
Received: from foss.arm.com ([217.140.110.172]:46620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355259AbhJAQFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:05:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C7E0101E;
        Fri,  1 Oct 2021 09:03:51 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FF4C3F766;
        Fri,  1 Oct 2021 09:03:49 -0700 (PDT)
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
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
Subject: [PATCH v2 10/23] x86/resctrl: Remove architecture copy of mbps_val
Date:   Fri,  1 Oct 2021 16:02:49 +0000
Message-Id: <20211001160302.31189-11-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211001160302.31189-1-james.morse@arm.com>
References: <20211001160302.31189-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resctrl arch code provides a second configuration array mbps_val[]
for the MBA software controller.

Since resctrl switched over to allocating and freeing its own array
when needed, nothing uses the arch code version.

Remove it.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Fixed spelling mistake
 * Capitalisation
---
 arch/x86/kernel/cpu/resctrl/core.c     | 20 ++++----------------
 arch/x86/kernel/cpu/resctrl/internal.h |  4 +---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
 3 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 1dd8428df008..feaf2fafa3c6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -397,7 +397,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 	return NULL;
 }
 
-void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
+void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	int i;
@@ -406,18 +406,14 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 	 * Initialize the Control MSRs to having no control.
 	 * For Cache Allocation: Set all bits in cbm
 	 * For Memory Allocation: Set b/w requested to 100%
-	 * and the bandwidth in MBps to U32_MAX
 	 */
-	for (i = 0; i < hw_res->num_closid; i++, dc++, dm++) {
+	for (i = 0; i < hw_res->num_closid; i++, dc++)
 		*dc = r->default_ctrl;
-		*dm = MBA_MAX_MBPS;
-	}
 }
 
 void domain_free(struct rdt_hw_domain *hw_dom)
 {
 	kfree(hw_dom->ctrl_val);
-	kfree(hw_dom->mbps_val);
 	kfree(hw_dom);
 }
 
@@ -426,23 +422,15 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct msr_param m;
-	u32 *dc, *dm;
+	u32 *dc;
 
 	dc = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->ctrl_val),
 			   GFP_KERNEL);
 	if (!dc)
 		return -ENOMEM;
 
-	dm = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->mbps_val),
-			   GFP_KERNEL);
-	if (!dm) {
-		kfree(dc);
-		return -ENOMEM;
-	}
-
 	hw_dom->ctrl_val = dc;
-	hw_dom->mbps_val = dm;
-	setup_default_ctrlval(r, dc, dm);
+	setup_default_ctrlval(r, dc);
 
 	m.low = 0;
 	m.high = hw_res->num_closid;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a7e2cbce29d5..796e13a0e8dc 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -308,14 +308,12 @@ struct mbm_state {
  *			  a resource
  * @d_resctrl:	Properties exposed to the resctrl file system
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
- * @mbps_val:	When mba_sc is enabled, this holds the bandwidth in MBps
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
 struct rdt_hw_domain {
 	struct rdt_domain		d_resctrl;
 	u32				*ctrl_val;
-	u32				*mbps_val;
 };
 
 static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
@@ -529,7 +527,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom,
 void mbm_handle_overflow(struct work_struct *work);
 void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
-void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm);
+void setup_default_ctrlval(struct rdt_resource *r, u32 *dc);
 u32 delay_bw_map(unsigned long bw, struct rdt_resource *r);
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9d402bc8bdff..52a7accbff8b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1966,7 +1966,7 @@ static int set_mba_sc(bool mba_sc)
 	r->membw.mba_sc = mba_sc;
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
-		setup_default_ctrlval(r, hw_dom->ctrl_val, hw_dom->mbps_val);
+		setup_default_ctrlval(r, hw_dom->ctrl_val);
 	}
 
 	if (is_mba_sc(r))
-- 
2.30.2

