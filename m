Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651593DAF40
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbhG2Whe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:37:34 -0400
Received: from foss.arm.com ([217.140.110.172]:59354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235422AbhG2WhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:37:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 069E6106F;
        Thu, 29 Jul 2021 15:37:05 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12D123F70D;
        Thu, 29 Jul 2021 15:37:02 -0700 (PDT)
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
Subject: [PATCH v1 16/20] x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()
Date:   Thu, 29 Jul 2021 22:36:06 +0000
Message-Id: <20210729223610.29373-17-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729223610.29373-1-james.morse@arm.com>
References: <20210729223610.29373-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl_arch_rmid_read() is intended as the function that an
architecture agnostic resctrl filesystem driver can use to
read a value in bytes from a counter. Currently the function returns
the mbm values in chunks directly from hardware. When reading a bandwidth
counter, mbm_overflow_count() must be used to correct for any possible
overflow.

mbm_overflow_count() is architecture specific, its behaviour should
be part of resctrl_arch_rmid_read().

Move the mbm_overflow_count() calls into resctrl_arch_rmid_read().
This allows the resctrl filesystems's prev_msr to be removed in
favour of the architecture private version.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 --
 arch/x86/kernel/cpu/resctrl/monitor.c  | 42 ++++++++++++++------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index eca7793d3342..2d0a6bba4a01 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -280,7 +280,6 @@ struct rftype {
 /**
  * struct mbm_state - status for each MBM counter in each domain
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
- * @prev_msr:	Value of IA32_QM_CTR for this RMID last time we read it
  * @prev_bw_chunks: Previous chunks value read when for bandwidth calculation
  * @prev_bw:	The most recent bandwidth in MBps
  * @delta_bw:	Difference between the current and previous bandwidth
@@ -288,7 +287,6 @@ struct rftype {
  */
 struct mbm_state {
 	u64	chunks;
-	u64	prev_msr;
 	u64	prev_bw_chunks;
 	u32	prev_bw;
 	u32	delta_bw;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index aa85cfd95904..39f7e74a4236 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -164,9 +164,20 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 		memset(m, 0, sizeof(*m));
 }
 
+static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
+{
+	u64 shift = 64 - width, chunks;
+
+	chunks = (cur_msr << shift) - (prev_msr << shift);
+	return chunks >>= shift;
+}
+
 int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_domain *d,
 			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct arch_mbm_state *m;
 	u64 msr_val;
 
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
@@ -188,7 +199,13 @@ int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_domain *d,
 	if (msr_val & RMID_VAL_UNAVAIL)
 		return -EINVAL;
 
-	*val = msr_val;
+	m = get_arch_mbm_state(hw_dom, rmid, eventid);
+	if (m) {
+		*val = mbm_overflow_count(m->prev_msr, msr_val, hw_res->mbm_width);
+		m->prev_msr = msr_val;
+	} else {
+		*val = msr_val;
+	}
 
 	return 0;
 }
@@ -319,19 +336,10 @@ void free_rmid(u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
-static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
-{
-	u64 shift = 64 - width, chunks;
-
-	chunks = (cur_msr << shift) - (prev_msr << shift);
-	return chunks >>= shift;
-}
-
 static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 {
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m;
-	u64 chunks, tval = 0;
+	u64 tval = 0;
 
 	if (rr->first)
 		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
@@ -354,13 +362,11 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 
 	if (rr->first) {
 		memset(m, 0, sizeof(struct mbm_state));
-		m->prev_bw_chunks = m->prev_msr = tval;
+		m->prev_bw_chunks = tval;
 		return 0;
 	}
 
-	chunks = mbm_overflow_count(m->prev_msr, tval, hw_res->mbm_width);
-	m->chunks += chunks;
-	m->prev_msr = tval;
+	m->chunks += tval;
 
 	rr->val += get_corrected_mbm_count(rmid, m->chunks);
 
@@ -375,14 +381,12 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m = &rr->d->mbm_local[rmid];
-	u64 tval = 0, cur_bw, chunks, bw_chunks;
+	u64 tval = 0, cur_bw, bw_chunks;
 
 	if (resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval))
 		return;
 
-	chunks = mbm_overflow_count(m->prev_msr, tval, hw_res->mbm_width);
-	m->chunks += chunks;
-	m->prev_msr = tval;
+	m->chunks += tval;
 	bw_chunks = get_corrected_mbm_count(rmid, m->chunks);
 
 	cur_bw = (bw_chunks - m->prev_bw_chunks) * hw_res->mon_scale;
-- 
2.30.2

