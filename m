Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4919C3DAF3E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhG2Whn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:37:43 -0400
Received: from foss.arm.com ([217.140.110.172]:59436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235581AbhG2WhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:37:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 305141FB;
        Thu, 29 Jul 2021 15:37:13 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C1173F70D;
        Thu, 29 Jul 2021 15:37:11 -0700 (PDT)
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
Subject: [PATCH v1 19/20] x86/resctrl: Add resctrl_rmid_realloc_limit to abstract x86's boot_cpu_data
Date:   Thu, 29 Jul 2021 22:36:09 +0000
Message-Id: <20210729223610.29373-20-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729223610.29373-1-james.morse@arm.com>
References: <20210729223610.29373-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl_rmid_realloc_threshold can be set by user-space. The maximum
value is specified by the architecture.

Currently max_threshold_occ_write() reads the maximum value from
boot_cpu_data.x86_cache_size, which is not portable to another
architecture.

Add resctrl_rmid_realloc_limit to describe the maximum size in bytes
that user-space can set the threshold to.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c  | 9 +++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 include/linux/resctrl.h                | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 8e3efb0909a0..18eba1bb032f 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -64,6 +64,11 @@ unsigned int rdt_mon_features;
  */
 unsigned int resctrl_rmid_realloc_threshold;
 
+/*
+ * This is the maximum value for the reallocation threshold, in bytes.
+ */
+unsigned int resctrl_rmid_realloc_limit;
+
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
 
 /*
@@ -718,9 +723,9 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	unsigned int cl_size = boot_cpu_data.x86_cache_size;
 	int ret;
 
+	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
 	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
 	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
@@ -737,7 +742,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	resctrl_rmid_realloc_threshold = cl_size * 1024 / r->num_rmid;
+	resctrl_rmid_realloc_threshold = resctrl_rmid_realloc_limit / r->num_rmid;
 
 	ret = dom_data_init(r);
 	if (ret)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d33442cd5975..20c871ad5166 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1059,7 +1059,7 @@ static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 	if (ret)
 		return ret;
 
-	if (bytes > (boot_cpu_data.x86_cache_size * 1024))
+	if (bytes > resctrl_rmid_realloc_limit)
 		return -EINVAL;
 
 	resctrl_rmid_realloc_threshold = bytes;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 26e75c07a8ac..ce7c7472da7d 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -257,5 +257,6 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 rmid, enum resctrl_event_id eventid);
 
 extern unsigned int resctrl_rmid_realloc_threshold;
+extern unsigned int resctrl_rmid_realloc_limit;
 
 #endif /* _RESCTRL_H */
-- 
2.30.2

