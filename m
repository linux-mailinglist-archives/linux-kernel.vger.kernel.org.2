Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5362B3395BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhCLSAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:00:51 -0500
Received: from foss.arm.com ([217.140.110.172]:58778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232987AbhCLSA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:00:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A9CB101E;
        Fri, 12 Mar 2021 10:00:29 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B01433F7D7;
        Fri, 12 Mar 2021 10:00:26 -0800 (PST)
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
Subject: [PATCH v2 19/24] x86/resctrl: Make ctrlval arrays the same size
Date:   Fri, 12 Mar 2021 17:58:44 +0000
Message-Id: <20210312175849.8327-20-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312175849.8327-1-james.morse@arm.com>
References: <20210312175849.8327-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CODE and DATA resources have their own ctrlval arrays which are half
the size because num_closid was already adjusted.

Prior to having one ctrlval array for the resource, move the num_closid
correction into resctrl, so that the ctrlval arrays are all the same
size.

A short-lived quirk of this is that the caches are reset twice, once
for CODE once for DATA.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 10 +++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  9 +++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4db28ce114bd..f1d0d64e5d97 100644
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
+	if (hw_res->conf_type != CDP_BOTH)
+		m.high /= 2;
+
 	hw_res->msr_update(d, &m, r);
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 4ef8f90da043..a3e5c8b1b0cb 100644
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
2.30.0

