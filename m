Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A383F3DAF36
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhG2Wg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:36:57 -0400
Received: from foss.arm.com ([217.140.110.172]:59166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235206AbhG2Wgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:36:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8488F1FB;
        Thu, 29 Jul 2021 15:36:46 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 914F73F70D;
        Thu, 29 Jul 2021 15:36:44 -0700 (PDT)
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
Subject: [PATCH v1 09/20] x86/resctrl: Abstract and use supports_mba_mbps()
Date:   Thu, 29 Jul 2021 22:35:59 +0000
Message-Id: <20210729223610.29373-10-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729223610.29373-1-james.morse@arm.com>
References: <20210729223610.29373-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To determine whether the mba_mbps option to resctrl should be supported,
resctrl tests the boot cpus' x86_vendor.

This isn't portable, and needs abstracting behind a helper so this check
can be part of the filesystem code that moves to /fs/.

Re-use the tests set_mba_sc() does to determine if the mba_sc is supported
on this system. An 'alloc_capable' test is added so that this property
isn't implied by 'linear'.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e321ea5de562..4388685548a0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1888,17 +1888,26 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 }
 
 /*
- * Enable or disable the MBA software controller
- * which helps user specify bandwidth in MBps.
  * MBA software controller is supported only if
  * MBM is supported and MBA is in linear scale.
  */
+static bool supports_mba_mbps(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+
+	return (is_mbm_enabled() &&
+		r->alloc_capable && is_mba_linear());
+}
+
+/*
+ * Enable or disable the MBA software controller
+ * which helps user specify bandwidth in MBps.
+ */
 static int set_mba_sc(bool mba_sc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 
-	if (!is_mbm_enabled() || !is_mba_linear() ||
-	    mba_sc == is_mba_sc(r))
+	if (!supports_mba_mbps() || mba_sc == is_mba_sc(r))
 		return -EINVAL;
 
 	r->membw.mba_sc = mba_sc;
@@ -2317,7 +2326,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->enable_cdpl2 = true;
 		return 0;
 	case Opt_mba_mbps:
-		if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		if (supports_mba_mbps())
 			return -EINVAL;
 		ctx->enable_mba_mbps = true;
 		return 0;
-- 
2.30.2

