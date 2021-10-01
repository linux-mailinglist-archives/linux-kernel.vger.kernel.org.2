Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75E741F1CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355297AbhJAQGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:06:14 -0400
Received: from foss.arm.com ([217.140.110.172]:46794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355299AbhJAQF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:05:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AE9C12FC;
        Fri,  1 Oct 2021 09:04:13 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E5773F766;
        Fri,  1 Oct 2021 09:04:11 -0700 (PDT)
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
Subject: [PATCH v2 18/23] x86/resctrl: Pass the required parameters into resctrl_arch_rmid_read()
Date:   Fri,  1 Oct 2021 16:02:57 +0000
Message-Id: <20211001160302.31189-19-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211001160302.31189-1-james.morse@arm.com>
References: <20211001160302.31189-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl_arch_rmid_read() is intended as the function that an
architecture agnostic resctrl filesystem driver can use to
read a value in bytes from a hardware register. Currently the function
returns the mbm values in chunks directly from hardware.

To convert this to bytes, some correction and overflow calculations
are needed. These depend on the resource and domain structures.
Overflow detection requires the old chunks value. None of this
is available to resctrl_arch_rmid_read(). MPAM requires the
resource and domain structures to find the MMIO device that holds
the registers.

Pass the resource and domain to resctrl_arch_rmid_read(). This make
rmid_dirty() to big, instead merge it with its only caller, the name is
kept as a local variable.

Signed-off-by: James Morse <james.morse@arm.com>
---
This is all a little noisy for __mon_event_count(), as the switch
statement work is now before the resctrl_arch_rmid_read() call.
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 31 +++++++++++++++------------
 include/linux/resctrl.h               | 15 ++++++++++++-
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index cf35eaf01042..f833bc01aeac 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -167,10 +167,14 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 		memset(am, 0, sizeof(*am));
 }
 
-int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
+int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_domain *d,
+			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
 	u64 msr_val;
 
+	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
+		return -EINVAL;
+
 	/*
 	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
 	 * with a valid event code for supported resource type and the bits
@@ -192,16 +196,6 @@ int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 	return 0;
 }
 
-static bool rmid_dirty(struct rmid_entry *entry)
-{
-	u64 val = 0;
-
-	if (resctrl_arch_rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID, &val))
-		return true;
-
-	return val >= resctrl_cqm_threshold;
-}
-
 /*
  * Check the RMIDs that are marked as busy for this domain. If the
  * reported LLC occupancy is below the threshold clear the busy bit and
@@ -213,6 +207,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	struct rmid_entry *entry;
 	struct rdt_resource *r;
 	u32 crmid = 1, nrmid;
+	bool rmid_dirty;
+	u64 val = 0;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
@@ -228,7 +224,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 			break;
 
 		entry = __rmid_entry(nrmid);
-		if (force_free || !rmid_dirty(entry)) {
+
+		if (resctrl_arch_rmid_read(r, d, entry->rmid,
+					   QOS_L3_OCCUP_EVENT_ID, &val))
+			rmid_dirty = true;
+		else
+			rmid_dirty = (val >= resctrl_cqm_threshold);
+
+		if (force_free || !rmid_dirty) {
 			clear_bit(entry->rmid, d->rmid_busy_llc);
 			if (!--entry->busy) {
 				rmid_limbo_count--;
@@ -278,7 +281,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	cpu = get_cpu();
 	list_for_each_entry(d, &r->domains, list) {
 		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
-			err = resctrl_arch_rmid_read(entry->rmid,
+			err = resctrl_arch_rmid_read(r, d, entry->rmid,
 						     QOS_L3_OCCUP_EVENT_ID,
 						     &val);
 			if (err || val <= resctrl_cqm_threshold)
@@ -336,7 +339,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 	if (rr->first)
 		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
 
-	rr->err = resctrl_arch_rmid_read(rmid, rr->evtid, &tval);
+	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval);
 	if (rr->err)
 		return rr->err;
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 01bdd8be590b..4215a0564206 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -218,7 +218,20 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
-int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *res);
+
+/**
+ * resctrl_arch_rmid_read() - Read the eventid counter correpsonding to rmid
+ *			      for this resource and domain.
+ * @r:			The resource that the counter should be read from.
+ * @d:			The domain that the counter should be read from.
+ * @rmid:		The rmid of the counter to read.
+ * @eventid:		The eventid to read, e.g. L3 occupancy.
+ * @val:		The result of the counter read in chunks.
+ *
+ * Returns 0 on success, or -EIO, -EINVAL etc on error.
+ */
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
+			   u32 rmid, enum resctrl_event_id eventid, u64 *val);
 
 /**
  * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
-- 
2.30.2

