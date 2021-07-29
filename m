Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718493DAF38
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhG2WhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:37:02 -0400
Received: from foss.arm.com ([217.140.110.172]:59222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235347AbhG2Wgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:36:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D133B113E;
        Thu, 29 Jul 2021 15:36:51 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDA293F70D;
        Thu, 29 Jul 2021 15:36:49 -0700 (PDT)
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
Subject: [PATCH v1 11/20] x86/resctrl: Calculate bandwidth from the total bytes counter
Date:   Thu, 29 Jul 2021 22:36:01 +0000
Message-Id: <20210729223610.29373-12-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729223610.29373-1-james.morse@arm.com>
References: <20210729223610.29373-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mbm_bw_count() maintains its own copy of prev_msr to allow it to
calculate the bandwidth as the number of chunks counted since the
last time mbm_bw_count() was invoked.

The prev_msr and chunks values are in a format specific to the
architecture. MPAM's monitor scaling can be enabled for some
counters and not others. If the value is changed once the bandwidth
counter passes some threshold, the prev_msr values need to be
converted to the new scale. Having two prev_msr values is a
hindrance to moving this logic behind an architecture specific
function that returns the counters number of bytes.

Change mbm_bw_count() to calculate the total number of bytes the
counter has seen in the same way as __mon_event_count(), then
calculate the bandwidth from that. prev_bw_msr is replaced by
prev_bw_chunks, the chunks value from the last time mbm_bw_count()
was invoked.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 15 ++++++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

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
index b178329d3661..af60e154f0ed 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -316,7 +316,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 
 	if (rr->first) {
 		memset(m, 0, sizeof(struct mbm_state));
-		m->prev_bw_msr = m->prev_msr = tval;
+		m->prev_bw_chunks = m->prev_msr = tval;
 		return 0;
 	}
 
@@ -337,20 +337,25 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m = &rr->d->mbm_local[rmid];
-	u64 tval, cur_bw, chunks;
+	u64 tval, cur_bw, chunks, bw_chunks;
 
 	tval = __rmid_read(rmid, rr->evtid);
 	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
 		return;
 
-	chunks = mbm_overflow_count(m->prev_bw_msr, tval, hw_res->mbm_width);
-	cur_bw = (get_corrected_mbm_count(rmid, chunks) * hw_res->mon_scale) >> 20;
+	chunks = mbm_overflow_count(m->prev_msr, tval, hw_res->mbm_width);
+	m->chunks += chunks;
+	m->prev_msr = tval;
+	bw_chunks = get_corrected_mbm_count(rmid, m->chunks);
+
+	cur_bw = (bw_chunks - m->prev_bw_chunks) * hw_res->mon_scale;
+	cur_bw >>= 20;
 
 	if (m->delta_comp)
 		m->delta_bw = abs(cur_bw - m->prev_bw);
 	m->delta_comp = false;
 	m->prev_bw = cur_bw;
-	m->prev_bw_msr = tval;
+	m->prev_bw_chunks = bw_chunks;
 }
 
 /*
-- 
2.30.2

