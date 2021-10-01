Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37A441F1C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355289AbhJAQF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:05:56 -0400
Received: from foss.arm.com ([217.140.110.172]:46678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355290AbhJAQFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:05:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8ECB101E;
        Fri,  1 Oct 2021 09:03:56 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC48F3F766;
        Fri,  1 Oct 2021 09:03:54 -0700 (PDT)
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
Subject: [PATCH v2 12/23] x86/resctrl: Abstract and use supports_mba_mbps()
Date:   Fri,  1 Oct 2021 16:02:51 +0000
Message-Id: <20211001160302.31189-13-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211001160302.31189-1-james.morse@arm.com>
References: <20211001160302.31189-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To determine whether the mba_MBps option to resctrl should be supported,
resctrl tests the boot cpus' x86_vendor.

This isn't portable, and needs abstracting behind a helper so this check
can be part of the filesystem code that moves to /fs/.

Re-use the tests set_mba_sc() does to determine if the mba_sc is supported
on this system. An 'alloc_capable' test is added so that support for the
controls isn't implied by the 'delay_linear' property, which is always
true for MPAM.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Capitalisation
 * Added MPAM example in commit message
 * Fixed supports_mba_mbps() logic error in rdt_parse_param()
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 069c209be1d5..1207271cce23 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1948,17 +1948,26 @@ static void mba_sc_destroy(struct rdt_resource *r)
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
+		if (!supports_mba_mbps())
 			return -EINVAL;
 		ctx->enable_mba_mbps = true;
 		return 0;
-- 
2.30.2

