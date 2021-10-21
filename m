Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807A7436DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhJUXIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:08:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:4522 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231515AbhJUXI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:08:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="292634928"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="292634928"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033491"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:29 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 23/23] x86/fpu/amx: Enable the AMX feature in 64-bit mode
Date:   Thu, 21 Oct 2021 15:55:27 -0700
Message-Id: <20211021225527.10184-24-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the AMX state components in XFEATURE_MASK_USER_SUPPORTED and the
TILE_DATA component to the dynamic states and update the permission check
table accordingly.

This is only effective on 64 bit kernels as for 32bit kernels
XFEATURE_MASK_TILE is defined as 0.

TILE_DATA is caller-saved state and the only dynamic state. Add build time
sanity check to ensure the assumption that every dynamic feature is caller-
saved.

Make AMX state depend on XFD as it is dynamic feature.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Changes from the tglx tree:
* Add compile time sanity check. (Dave Hansen)
* Make AMX depend on XFD.
---
 arch/x86/include/asm/fpu/xstate.h | 5 +++--
 arch/x86/kernel/cpu/cpuid-deps.c  | 1 +
 arch/x86/kernel/fpu/core.c        | 6 ++++++
 arch/x86/kernel/fpu/xstate.c      | 5 +++--
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 0c850def4d13..ffb08dc298bb 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -35,7 +35,8 @@
 				      XFEATURE_MASK_Hi16_ZMM	 | \
 				      XFEATURE_MASK_PKRU | \
 				      XFEATURE_MASK_BNDREGS | \
-				      XFEATURE_MASK_BNDCSR)
+				      XFEATURE_MASK_BNDCSR | \
+				      XFEATURE_MASK_XTILE)
 
 /*
  * Features which are restored when returning to user space.
@@ -46,7 +47,7 @@
 	(XFEATURE_MASK_USER_SUPPORTED & ~XFEATURE_MASK_PKRU)
 
 /* Features which are dynamically enabled for a process on request */
-#define XFEATURE_MASK_USER_DYNAMIC	0ULL
+#define XFEATURE_MASK_USER_DYNAMIC	XFEATURE_MASK_XTILE_DATA
 
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index d9ead9c20408..cb2fdd130aae 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -76,6 +76,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{}
 };
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index f66beea2d1f8..323ae0c2a137 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -496,6 +496,12 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
 		return 0;
 	}
 
+	/*
+	 * If a new feature is added, ensure all dynamic features are
+	 * caller-saved from here!
+	 */
+	BUILD_BUG_ON(XFEATURE_MASK_USER_DYNAMIC != XFEATURE_MASK_XTILE_DATA);
+
 	/*
 	 * Save the default portion of the current FPU state into the
 	 * clone. Assume all dynamic features to be defined as caller-
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 81b40f119ce7..3195dc116fa8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -404,7 +404,8 @@ static __init void os_xrstor_booting(struct xregs_state *xstate)
 	 XFEATURE_MASK_PKRU |			\
 	 XFEATURE_MASK_BNDREGS |		\
 	 XFEATURE_MASK_BNDCSR |			\
-	 XFEATURE_MASK_PASID)
+	 XFEATURE_MASK_PASID |			\
+	 XFEATURE_MASK_XTILE)
 
 /*
  * setup the xstate image representing the init state
@@ -1633,7 +1634,7 @@ static int __xstate_request_perm(u64 permitted, u64 requested)
  * Permissions array to map facilities with more than one component
  */
 static const u64 xstate_prctl_req[XFEATURE_MAX] = {
-	/* [XFEATURE_XTILE_DATA] = XFEATURE_MASK_XTILE, */
+	[XFEATURE_XTILE_DATA] = XFEATURE_MASK_XTILE_DATA,
 };
 
 static int xstate_request_perm(unsigned long idx)
-- 
2.17.1

