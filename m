Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1128641F1CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355392AbhJAQGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:06:24 -0400
Received: from foss.arm.com ([217.140.110.172]:46908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355280AbhJAQGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:06:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08ED1113E;
        Fri,  1 Oct 2021 09:04:19 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C8D53F766;
        Fri,  1 Oct 2021 09:04:16 -0700 (PDT)
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
Subject: [PATCH v2 20/23] x86/resctrl: Move get_corrected_mbm_count() into resctrl_arch_rmid_read()
Date:   Fri,  1 Oct 2021 16:02:59 +0000
Message-Id: <20211001160302.31189-21-james.morse@arm.com>
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
read a value in bytes from a counter. Currently the function returns
the mbm values in chunks directly from hardware. When reading a bandwidth
counter, get_corrected_mbm_count() must be used to correct the
value read.

get_corrected_mbm_count() is architecture specific, this work should be
done in resctrl_arch_rmid_read().

Move the function calls. This allows the resctrl filesystems's chunks
value to be removed in favour of the architecture private version.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 2d0a6bba4a01..65b472d6b146 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -279,14 +279,12 @@ struct rftype {
 
 /**
  * struct mbm_state - status for each MBM counter in each domain
- * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
  * @prev_bw_chunks: Previous chunks value read when for bandwidth calculation
  * @prev_bw:	The most recent bandwidth in MBps
  * @delta_bw:	Difference between the current and previous bandwidth
  * @delta_comp:	Indicates whether to compute the delta_bw
  */
 struct mbm_state {
-	u64	chunks;
 	u64	prev_bw_chunks;
 	u32	prev_bw;
 	u32	delta_bw;
@@ -296,9 +294,11 @@ struct mbm_state {
 /**
  * struct arch_mbm_state - values used to compute resctrl_arch_rmid_read()s
  *			   return value.
+ * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
  * @prev_msr	Value of IA32_QM_CTR for this RMID last time we read it
  */
 struct arch_mbm_state {
+	u64	chunks;
 	u64	prev_msr;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 4e8bb86ce4a5..eb2502645433 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -204,7 +204,9 @@ int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_domain *d,
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
-		*val = mbm_overflow_count(am->prev_msr, msr_val, hw_res->mbm_width);
+		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
+						 hw_res->mbm_width);
+		*val = get_corrected_mbm_count(rmid, am->chunks);
 		am->prev_msr = msr_val;
 	} else {
 		*val = msr_val;
@@ -374,9 +376,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 		return 0;
 	}
 
-	m->chunks += tval;
-
-	rr->val += get_corrected_mbm_count(rmid, m->chunks);
+	rr->val += tval;
 
 	return 0;
 }
-- 
2.30.2

