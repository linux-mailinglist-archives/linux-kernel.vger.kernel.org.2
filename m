Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBC2315C29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhBJBZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:25:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:45627 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234626AbhBIW6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:58:38 -0500
IronPort-SDR: zXmIj6z2+J4Ed3rJ2oTDMKHcwls5Q5Pgh1jpRP0csmO6oImolOiARoi/vXbuysglzA0hIlqJxj
 mxoVRJ5U3tCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="161724168"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="161724168"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 14:40:56 -0800
IronPort-SDR: 4RYtv+8AEX1aaQ0qX+Z81rJy4IcRhgJMBsUpD+IhYThrl2VI55h/ImYqoKaQsUIqcoqVtVWRaN
 CCS/fnMVwRVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="379297489"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2021 14:38:39 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     Alison Schofield <alison.schofield@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com
Subject: [PATCH] x86, sched: Allow NUMA nodes to share an LLC on Intel platforms
Date:   Tue,  9 Feb 2021 14:39:43 -0800
Message-Id: <20210209223943.9834-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1340ccfa9a9a ("x86,sched: Allow topologies where NUMA nodes
share an LLC") added a vendor and model specific check to skip the
topology_sane() check for Intel's Sky Lake Server CPUs where NUMA
nodes shared an LLC.

This topology is no longer a quirk for Intel CPUs as Ice Lake and
Sapphire Rapids CPUs exhibit the same topology. Rather than maintain
the quirk list, define a synthetic flag that directs the scheduler
to allow this topology without warning for all Intel CPUs when NUMA
is configured.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: brice.goglin@gmail.com
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/kernel/cpu/intel.c        | 15 +++++++++++++++
 arch/x86/kernel/smpboot.c          | 23 ++---------------------
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 84b887825f12..bec74b90d3d6 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -421,5 +421,6 @@
 #define X86_BUG_TAA			X86_BUG(22) /* CPU is affected by TSX Async Abort(TAA) */
 #define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* CPU may incur MCE during certain page attribute changes */
 #define X86_BUG_SRBDS			X86_BUG(24) /* CPU may leak RNG bits if not mitigated */
+#define X86_BUG_NUMA_SHARES_LLC		X86_BUG(25) /* CPU may enumerate an LLC shared by multiple NUMA nodes */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 816fdbec795a..027348261080 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -719,6 +719,21 @@ static void init_intel(struct cpuinfo_x86 *c)
 		tsx_disable();
 
 	split_lock_init();
+
+	/*
+	 * Set X86_BUG_NUMA_SHARES_LLC to allow topologies where NUMA
+	 * nodes share an LLC. In Sub-NUMA Clustering mode Intel CPUs
+	 * may enumerate an LLC as shared by multiple NUMA nodes. The
+	 * LLC is shared for off-package data access but private to
+	 * the NUMA node for on-package access. This topology first
+	 * appeared in SKYLAKE_X. It was treated as a quirk and allowed.
+	 * This topology reappeared in ICELAKE_X and SAPPHIRERAPIDS_X.
+	 * Rather than maintain a list of quirk CPUS, allow this topology
+	 * on all Intel CPUs with NUMA configured. When this X86_BUG is
+	 * set, the scheduler accepts this topology without warning.
+	 */
+	if (IS_ENABLED(CONFIG_NUMA))
+		set_cpu_bug(c, X86_BUG_NUMA_SHARES_LLC);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 117e24fbfd8a..7d05c3552795 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -458,26 +458,6 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return false;
 }
 
-/*
- * Define snc_cpu[] for SNC (Sub-NUMA Cluster) CPUs.
- *
- * These are Intel CPUs that enumerate an LLC that is shared by
- * multiple NUMA nodes. The LLC on these systems is shared for
- * off-package data access but private to the NUMA node (half
- * of the package) for on-package access.
- *
- * CPUID (the source of the information about the LLC) can only
- * enumerate the cache as being shared *or* unshared, but not
- * this particular configuration. The CPU in this case enumerates
- * the cache to be shared across the entire package (spanning both
- * NUMA nodes).
- */
-
-static const struct x86_cpu_id snc_cpu[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, NULL),
-	{}
-};
-
 static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
 	int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
@@ -495,7 +475,8 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	 * means 'c' does not share the LLC of 'o'. This will be
 	 * reflected to userspace.
 	 */
-	if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu))
+	if (!topology_same_node(c, o) &&
+	    boot_cpu_has_bug(X86_BUG_NUMA_SHARES_LLC))
 		return false;
 
 	return topology_sane(c, o, "llc");
-- 
2.20.1

