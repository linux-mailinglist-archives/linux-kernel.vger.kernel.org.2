Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C83CA481
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhGORe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:34:57 -0400
Received: from foss.arm.com ([217.140.110.172]:56472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232437AbhGORes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:34:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B45F9106F;
        Thu, 15 Jul 2021 10:31:54 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C22793F7D8;
        Thu, 15 Jul 2021 10:31:52 -0700 (PDT)
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
Subject: [PATCH v6 23/24] x86/resctrl: Expand resctrl_arch_update_domains()'s msr_param range
Date:   Thu, 15 Jul 2021 17:30:42 +0000
Message-Id: <20210715173043.14222-24-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl_arch_update_domains() specifies the one closid that has
been modified and needs copying to the hardware.
resctrl_arch_update_domains() takes a struct rdt_resource and a
closid as arguments, but copies all the staged configurations
for that closid into the ctrl_val[] array.

resctrl_arch_update_domains() is called once per schema, but
once the resources and domains are merged, the second call of
a L2CODE/L2DATA pair will find no staged configurations, as
they were previously applied. The msr_param of the first call
only has one index, so would only have update the hardware
for the last staged configuration.

To avoid a second round of IPIs when changing L2CODE and L2DATA
in one go, expand the range of the msr_param if multiple staged
configurations are found.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
No changes since v3.

Changes since v2:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 04d54d942527..9e1c6730520b 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -292,6 +292,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 		return -ENOMEM;
 
 	mba_sc = is_mba_sc(r);
+	msr_param.res = NULL;
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
 		for (t = 0; t < CDP_NUM_TYPES; t++) {
@@ -303,9 +304,14 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 			if (!apply_config(hw_dom, cfg, idx, cpu_mask, mba_sc))
 				continue;
 
-			msr_param.low = idx;
-			msr_param.high = msr_param.low + 1;
-			msr_param.res = r;
+			if (!msr_param.res) {
+				msr_param.low = idx;
+				msr_param.high = msr_param.low + 1;
+				msr_param.res = r;
+			} else {
+				msr_param.low = min(msr_param.low, idx);
+				msr_param.high = max(msr_param.high, idx + 1);
+			}
 		}
 	}
 
-- 
2.30.2

