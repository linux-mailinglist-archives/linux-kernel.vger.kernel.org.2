Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3C641F1C5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355291AbhJAQF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:05:59 -0400
Received: from foss.arm.com ([217.140.110.172]:46768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355327AbhJAQFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:05:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08E3013A1;
        Fri,  1 Oct 2021 09:04:05 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C0593F766;
        Fri,  1 Oct 2021 09:04:02 -0700 (PDT)
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
Subject: [PATCH v2 15/23] x86/recstrl: Add per-rmid arch private storage for overflow and chunks
Date:   Fri,  1 Oct 2021 16:02:54 +0000
Message-Id: <20211001160302.31189-16-james.morse@arm.com>
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
the mbm values in chunks directly from hardware. For bandwidth
counters the resctrl filesystem uses this to calculate the number of
bytes ever seen.

MPAM's scaling of counters can be changed at runtime, reducing the
resolution but increasing the range. When this is changed the prev_msr
values need to be converted by the architecture code.

Add an array for per-rmid private storage. The prev_msr and chunks
values will move here to allow resctrl_arch_rmid_read() to always
return the number of bytes read by this counter without assistance
from the filesystem. The values are moved in later patches when
the overflow and correction calls are moved into
resctrl_arch_rmid_read().

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 34 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h | 13 ++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 583fb41db06d..f527489a607a 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -413,6 +413,8 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 
 void domain_free(struct rdt_hw_domain *hw_dom)
 {
+	kfree(hw_dom->arch_mbm_total);
+	kfree(hw_dom->arch_mbm_local);
 	kfree(hw_dom->ctrl_val);
 	kfree(hw_dom);
 }
@@ -438,6 +440,33 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
+/**
+ * arch_domain_mbm_alloc() - Allocate arch private storage for the mbm counters
+ * @num_rmid:	The size of the mbm counter array
+ * @hw_dom:	The domain that owns the allocated the arrays
+ *
+ * On error, call domain_free()
+ */
+static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
+{
+	size_t tsize;
+
+	if (is_mbm_total_enabled()) {
+		tsize = sizeof(*hw_dom->arch_mbm_total);
+		hw_dom->arch_mbm_total = kcalloc(num_rmid, tsize, GFP_KERNEL);
+		if (!hw_dom->arch_mbm_total)
+			return -ENOMEM;
+	}
+	if (is_mbm_local_enabled()) {
+		tsize = sizeof(*hw_dom->arch_mbm_local);
+		hw_dom->arch_mbm_local = kcalloc(num_rmid, tsize, GFP_KERNEL);
+		if (!hw_dom->arch_mbm_local)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /*
  * domain_add_cpu - Add a cpu to a resource's domain list.
  *
@@ -487,6 +516,11 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
+	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
+		domain_free(hw_dom);
+		return;
+	}
+
 	list_add_tail(&d->list, add_pos);
 
 	err = resctrl_online_domain(r, d);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 0a5721e1cc07..aaae900a8ef3 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -303,17 +303,30 @@ struct mbm_state {
 	bool	delta_comp;
 };
 
+/**
+ * struct arch_mbm_state - values used to compute resctrl_arch_rmid_read()s
+ *			   return value.
+ * @prev_msr	Value of IA32_QM_CTR for this RMID last time we read it
+ */
+struct arch_mbm_state {
+	u64	prev_msr;
+};
+
 /**
  * struct rdt_hw_domain - Arch private attributes of a set of CPUs that share
  *			  a resource
  * @d_resctrl:	Properties exposed to the resctrl file system
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
+ * @arch_mbm_total:	arch private state for MBM total bandwidth
+ * @arch_mbm_local:	arch private state for MBM local bandwidth
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
 struct rdt_hw_domain {
 	struct rdt_domain		d_resctrl;
 	u32				*ctrl_val;
+	struct arch_mbm_state		*arch_mbm_total;
+	struct arch_mbm_state		*arch_mbm_local;
 };
 
 static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
-- 
2.30.2

