Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C8041F1C6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355356AbhJAQGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:06:02 -0400
Received: from foss.arm.com ([217.140.110.172]:46740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355320AbhJAQFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:05:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5355C113E;
        Fri,  1 Oct 2021 09:04:02 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 503D43F766;
        Fri,  1 Oct 2021 09:04:00 -0700 (PDT)
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
Subject: [PATCH v2 14/23] x86/resctrl: Calculate bandwidth from the previous __mon_event_count() chunks
Date:   Fri,  1 Oct 2021 16:02:53 +0000
Message-Id: <20211001160302.31189-15-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211001160302.31189-1-james.morse@arm.com>
References: <20211001160302.31189-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mbm_bw_count() is only called by the mbm_handle_overflow() worker once a
second. It reads the hardware register, calculates the bandwidth and
updates m->prev_bw_msr which is used to hold the previous hardware register
value.

Operating directly on hardware register values makes it difficult to make
this code architecture independent, so that it can be moved to /fs/,
making the mba_sc feature something resctrl supports with no additional
support from the architecture.
Prior to calling mbm_bw_count(), mbm_update() reads from the same hardware
register using __mon_event_count().

Change mbm_bw_count() to use the current chunks value from
__mon_event_count() to calculate bandwidth. This means it no longer
operates on hardware register values.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * This patch was rewritten
---
 arch/x86/kernel/cpu/resctrl/internal.h |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 24 +++++++++++++++---------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 1b07e49564cf..0a5721e1cc07 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -289,7 +289,7 @@ struct rftype {
  * struct mbm_state - status for each MBM counter in each domain
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
  * @prev_msr:	Value of IA32_QM_CTR for this RMID last time we read it
- * @prev_bw_msr:Value of previous IA32_QM_CTR for bandwidth counting
+ * @prev_bw_chunks: Previous chunks value read when for bandwidth calculation
  * @prev_bw:	The most recent bandwidth in MBps
  * @delta_bw:	Difference between the current and previous bandwidth
  * @delta_comp:	Indicates whether to compute the delta_bw
@@ -297,7 +297,7 @@ struct rftype {
 struct mbm_state {
 	u64	chunks;
 	u64	prev_msr;
-	u64	prev_bw_msr;
+	u64	prev_bw_chunks;
 	u32	prev_bw;
 	u32	delta_bw;
 	bool	delta_comp;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 6c8226987dd6..a1232462db14 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -315,7 +315,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 
 	if (rr->first) {
 		memset(m, 0, sizeof(struct mbm_state));
-		m->prev_bw_msr = m->prev_msr = tval;
+		m->prev_msr = tval;
 		return 0;
 	}
 
@@ -329,27 +329,32 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 }
 
 /*
+ * mbm_bw_count() - Update bw count from values previously read by
+ *		    __mon_event_count().
+ * @rmid:	The rmid used to identify the cached mbm_state.
+ * @rr:		The struct rmid_read populated by __mon_event_count().
+ *
  * Supporting function to calculate the memory bandwidth
- * and delta bandwidth in MBps.
+ * and delta bandwidth in MBps. The chunks value previously read by
+ * __mon_event_count() is compared with the chunks value from the previous
+ * invocation. This must be called oncer per second to maintain values in MBps.
  */
 static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m = &rr->d->mbm_local[rmid];
-	u64 tval, cur_bw, chunks;
+	u64 cur_bw, chunks, cur_chunks;
 
-	tval = __rmid_read(rmid, rr->evtid);
-	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
-		return;
+	cur_chunks = rr->val;
+	chunks = cur_chunks - m->prev_bw_chunks;
+	m->prev_bw_chunks = cur_chunks;
 
-	chunks = mbm_overflow_count(m->prev_bw_msr, tval, hw_res->mbm_width);
-	cur_bw = (get_corrected_mbm_count(rmid, chunks) * hw_res->mon_scale) >> 20;
+	cur_bw = (chunks * hw_res->mon_scale) >> 20;
 
 	if (m->delta_comp)
 		m->delta_bw = abs(cur_bw - m->prev_bw);
 	m->delta_comp = false;
 	m->prev_bw = cur_bw;
-	m->prev_bw_msr = tval;
 }
 
 /*
@@ -509,6 +514,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
 	rr.first = false;
 	rr.r = r;
 	rr.d = d;
+	rr.val = 0;
 
 	/*
 	 * This is protected from concurrent reads from user
-- 
2.30.2

