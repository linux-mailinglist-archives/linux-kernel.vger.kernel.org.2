Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E11141F1C8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355336AbhJAQGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:06:09 -0400
Received: from foss.arm.com ([217.140.110.172]:46822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355334AbhJAQFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:05:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B8A413D5;
        Fri,  1 Oct 2021 09:04:10 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F2233F766;
        Fri,  1 Oct 2021 09:04:08 -0700 (PDT)
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
Subject: [PATCH v2 17/23] x86/resctrl: Abstract __rmid_read()
Date:   Fri,  1 Oct 2021 16:02:56 +0000
Message-Id: <20211001160302.31189-18-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211001160302.31189-1-james.morse@arm.com>
References: <20211001160302.31189-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__rmid_read() selects the specified eventid and returns the counter
value from the msr. The error handling is architecture specific, and
handled by the callers, rdtgroup_mondata_show() and __mon_event_count().

Error handling should be handled by architecture specific code, as
a different architecture may have different requirements. MPAM's
counters can report that they are 'not ready', requiring a second
read after a short delay. This should be hidden from resctrl.

Make __rmid_read() the architecture specific function for reading
a counter. Rename it resctrl_arch_rmid_read() and move the error
handling into it.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Return EINVAL from the impossible case in __mon_event_count() instead
   of an x86 hardware specific value.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +--
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     | 42 +++++++++++++++--------
 include/linux/resctrl.h                   |  1 +
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 25baacd331e0..c8ca7184c6d9 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -579,9 +579,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 
 	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
 
-	if (rr.val & RMID_VAL_ERROR)
+	if (rr.err == -EIO)
 		seq_puts(m, "Error\n");
-	else if (rr.val & RMID_VAL_UNAVAIL)
+	else if (rr.err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
 	else
 		seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f3f31315a907..eca7793d3342 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -40,7 +40,6 @@
  */
 #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
 
-
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -94,6 +93,7 @@ struct rmid_read {
 	struct rdt_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
+	int			err;
 	u64			val;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 35eef49954b0..cf35eaf01042 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -167,9 +167,9 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 		memset(am, 0, sizeof(*am));
 }
 
-static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
+int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
-	u64 val;
+	u64 msr_val;
 
 	/*
 	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
@@ -180,14 +180,24 @@ static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
 	 * are error bits.
 	 */
 	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
-	rdmsrl(MSR_IA32_QM_CTR, val);
+	rdmsrl(MSR_IA32_QM_CTR, msr_val);
 
-	return val;
+	if (msr_val & RMID_VAL_ERROR)
+		return -EIO;
+	if (msr_val & RMID_VAL_UNAVAIL)
+		return -EINVAL;
+
+	*val = msr_val;
+
+	return 0;
 }
 
 static bool rmid_dirty(struct rmid_entry *entry)
 {
-	u64 val = __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
+	u64 val = 0;
+
+	if (resctrl_arch_rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID, &val))
+		return true;
 
 	return val >= resctrl_cqm_threshold;
 }
@@ -259,8 +269,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r;
 	struct rdt_domain *d;
-	int cpu;
-	u64 val;
+	int cpu, err;
+	u64 val = 0;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
@@ -268,8 +278,10 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	cpu = get_cpu();
 	list_for_each_entry(d, &r->domains, list) {
 		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
-			val = __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
-			if (val <= resctrl_cqm_threshold)
+			err = resctrl_arch_rmid_read(entry->rmid,
+						     QOS_L3_OCCUP_EVENT_ID,
+						     &val);
+			if (err || val <= resctrl_cqm_threshold)
 				continue;
 		}
 
@@ -319,15 +331,15 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m;
-	u64 chunks, tval;
+	u64 chunks, tval = 0;
 
 	if (rr->first)
 		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
 
-	tval = __rmid_read(rmid, rr->evtid);
-	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
-		return tval;
-	}
+	rr->err = resctrl_arch_rmid_read(rmid, rr->evtid, &tval);
+	if (rr->err)
+		return rr->err;
+
 	switch (rr->evtid) {
 	case QOS_L3_OCCUP_EVENT_ID:
 		rr->val += tval;
@@ -343,7 +355,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 		 * Code would never reach here because an invalid
 		 * event id would fail the __rmid_read.
 		 */
-		return RMID_VAL_ERROR;
+		return -EINVAL;
 	}
 
 	if (rr->first) {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 04f30d80fc67..01bdd8be590b 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -218,6 +218,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
+int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *res);
 
 /**
  * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
-- 
2.30.2

