Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0B03893B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355396AbhESQ1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:27:55 -0400
Received: from foss.arm.com ([217.140.110.172]:48488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355260AbhESQ1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:27:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26DFB16F2;
        Wed, 19 May 2021 09:25:47 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B6B43F73D;
        Wed, 19 May 2021 09:25:45 -0700 (PDT)
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
Subject: [PATCH v3 18/24] x86/resctrl: Make ctrlval arrays the same size
Date:   Wed, 19 May 2021 16:24:18 +0000
Message-Id: <20210519162424.27654-19-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210519162424.27654-1-james.morse@arm.com>
References: <20210519162424.27654-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CODE and DATA resources report a num_closid that is half the
actual size supported by the hardware. This behaviour is visible
to user-space when CDP is enabled.
The CODE and DATA resources have their own ctrlval arrays which are half
the size of the underlying hardware because num_closid was already
adjusted. One holds the odd configurations values, the other even.

Before the CDP resources can be merged, the 'half the closids'
behaviour needs to be implemented by schemata_list_create(), but
this causes the ctrl_val[] array to be full sized.

Remove the logic from the architecture specific rdt_get_cdp_config()
setup, and add it to schemata_list_create(). Functions that
walk take num_closid directly from struct rdt_hw_resource also
have to halve num_closid as only the lower half of each array is
in use. domain_setup_ctrlval() and reset_all_ctrls() both copy
struct rdt_hw_resource's num_closid to a struct msr_param. Correct
the value here. This is temporary as a subsequent patch will merge
the all three ctrl_val[] arrays such that when CDP is in use, the
CODA/DATA layout in the array matches the hardware. reset_all_ctrls()'s
loop over the whole of ctrl_val[] is not touched as this is harmless,
and will be required as it is once the resources are merged.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Shuffled commit message,

 arch/x86/kernel/cpu/resctrl/core.c     | 10 +++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  9 +++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index a2cbd2832d73..0d18227a366b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -363,7 +363,7 @@ static void rdt_get_cdp_config(int level, int type)
 	struct rdt_resource *r = &rdt_resources_all[type].resctrl;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
-	hw_res->num_closid = hw_res_l->num_closid / 2;
+	hw_res->num_closid = hw_res_l->num_closid;
 	r->cache.cbm_len = r_l->cache.cbm_len;
 	r->default_ctrl = r_l->default_ctrl;
 	r->cache.shareable_bits = r_l->cache.shareable_bits;
@@ -549,6 +549,14 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 
 	m.low = 0;
 	m.high = hw_res->num_closid;
+
+	/*
+	 * temporary: the array is full-size, but cat_wrmsr() still re-maps
+	 * the index.
+	 */
+	if (hw_res->conf_type != CDP_NONE)
+		m.high /= 2;
+
 	hw_res->msr_update(d, &m, r);
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 740d2d0ff4df..e8006e332d1a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2154,6 +2154,8 @@ static int schemata_list_create(void)
 		s->res = r;
 		s->conf_type = resctrl_to_arch_res(r)->conf_type;
 		s->num_closid = resctrl_arch_get_num_closid(r);
+		if (resctrl_arch_get_cdp_enabled(r->rid))
+			s->num_closid /= 2;
 
 		ret = snprintf(s->name, sizeof(s->name), r->name);
 		if (ret >= sizeof(s->name)) {
@@ -2366,6 +2368,13 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	msr_param.low = 0;
 	msr_param.high = hw_res->num_closid;
 
+	/*
+	 * temporary: the array is full-sized, but cat_wrmsr() still re-maps
+	 * the index.
+	 */
+	if (hw_res->cdp_enabled)
+		msr_param.high /= 2;
+
 	/*
 	 * Disable resource control for this resource by setting all
 	 * CBMs in all domains to the maximum mask value. Pick one CPU
-- 
2.30.2

