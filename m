Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9371F41F7A1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 00:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356184AbhJAWrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 18:47:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:38147 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356170AbhJAWqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 18:46:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205756663"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="205756663"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 15:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="565344011"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2021 15:44:18 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v11 20/29] x86/fpu/amx: Define AMX state components and have it used for boot-time checks
Date:   Fri,  1 Oct 2021 15:37:19 -0700
Message-Id: <20211001223728.9309-21-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001223728.9309-1-chang.seok.bae@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux uses check_xstate_against_struct() to sanity check the size of
XSTATE-enabled features. AMX is the XSAVE-enabled feature, and its size is
not hard-coded but discoverable at run-time via CPUID.

The AMX state is composed of state components 17 and 18, which are all user
state components. The first component is the XTILECFG state of a 64-byte
tile-related control register. The state component 18, called XTILEDATA,
contains the actual tile data, and the state size varies on
implementations. The architectural maximum, as defined in the CPUID(0x1d,
1): EAX[15:0], is a byte less than 64KB. The first implementation supports
8KB.

Check the XTILEDATA state size dynamically. The feature introduces the new
tile register, TMM. Define one register struct only and read the number of
registers from CPUID. Cross-check the overall size with CPUID again.

Define that the permission-required states are XTILECFG and above.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v10:
* Expand permission-required states to include XTILECFG and later, rather
  than just XFD-protected states.

Changes from v8:
* bugfix: Fix off-by-one-error in check_xstate_against_struct() feature
  number argument.

Changes from v4:
* Changed to return an error when tile data size mismatches. (Thomas Gleixner)
* Updated the function description and code comments.

Changes from v2:
* Updated the code comments.

Changes from v1:
* Rebased on the upstream kernel (5.10)
---
 arch/x86/include/asm/fpu/types.h  | 27 +++++++++++
 arch/x86/include/asm/fpu/xstate.h |  6 ++-
 arch/x86/kernel/fpu/xstate.c      | 80 ++++++++++++++++++++++++++++++-
 3 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 617184b0afec..1e0a6f73d8a9 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -120,6 +120,9 @@ enum xfeature {
 	XFEATURE_RSRVD_COMP_13,
 	XFEATURE_RSRVD_COMP_14,
 	XFEATURE_LBR,
+	XFEATURE_RSRVD_COMP_16,
+	XFEATURE_XTILE_CFG,
+	XFEATURE_XTILE_DATA,
 
 	XFEATURE_MAX,
 };
@@ -136,11 +139,15 @@ enum xfeature {
 #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
 #define XFEATURE_MASK_PASID		(1 << XFEATURE_PASID)
 #define XFEATURE_MASK_LBR		(1 << XFEATURE_LBR)
+#define XFEATURE_MASK_XTILE_CFG	(1 << XFEATURE_XTILE_CFG)
+#define XFEATURE_MASK_XTILE_DATA	(1 << XFEATURE_XTILE_DATA)
 
 #define XFEATURE_MASK_FPSSE		(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
 #define XFEATURE_MASK_AVX512		(XFEATURE_MASK_OPMASK \
 					 | XFEATURE_MASK_ZMM_Hi256 \
 					 | XFEATURE_MASK_Hi16_ZMM)
+#define XFEATURE_MASK_XTILE		(XFEATURE_MASK_XTILE_DATA \
+					 | XFEATURE_MASK_XTILE_CFG)
 
 #define FIRST_EXTENDED_XFEATURE	XFEATURE_YMM
 
@@ -153,6 +160,9 @@ struct reg_256_bit {
 struct reg_512_bit {
 	u8	regbytes[512/8];
 };
+struct reg_1024_byte {
+	u8	regbytes[1024];
+};
 
 /*
  * State component 2:
@@ -255,6 +265,23 @@ struct arch_lbr_state {
 	u64 ler_to;
 	u64 ler_info;
 	struct lbr_entry		entries[];
+};
+
+/*
+ * State component 17: 64-byte tile configuration register.
+ */
+struct xtile_cfg {
+	u64				tcfg[8];
+} __packed;
+
+/*
+ * State component 18: 1KB tile data register.
+ * Each register represents 16 64-byte rows of the matrix
+ * data. But the number of registers depends on the actual
+ * implementation.
+ */
+struct xtile_data {
+	struct reg_1024_byte		tmm;
 } __packed;
 
 /*
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index e0437dfd897b..e3d431e04bbf 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -16,6 +16,8 @@
 
 #define XSTATE_CPUID		0x0000000d
 
+#define TILE_CPUID		0x0000001d
+
 #define FXSAVE_SIZE	512
 
 #define XSAVE_HDR_SIZE	    64
@@ -37,8 +39,8 @@
 				      XFEATURE_MASK_BNDREGS | \
 				      XFEATURE_MASK_BNDCSR)
 
-/* Require ARCH_SET_STATE_ENABLE for future features  */
-#define XFEATURE_MASK_PERMISSION_REQUIRED GENMASK_ULL(63, XFEATURE_MAX)
+/* Require ARCH_SET_STATE_ENABLE from XTILE_CFG and later states */
+#define XFEATURE_MASK_PERMISSION_REQUIRED GENMASK_ULL(63, XFEATURE_XTILE_CFG)
 
 /*
  * Features which are restored when returning to user space.
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index e5a734d88660..2ebc98c4b496 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -41,6 +41,14 @@ static const char *xfeature_names[] =
 	"Protection Keys User registers",
 	"PASID state",
 	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"AMX Tile config"		,
+	"AMX Tile data"			,
+	"unknown xstate feature"	,
 };
 
 static unsigned short xsave_cpuid_features[] __initdata = {
@@ -54,6 +62,8 @@ static unsigned short xsave_cpuid_features[] __initdata = {
 	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]	= X86_FEATURE_INTEL_PT,
 	[XFEATURE_PKRU]				= X86_FEATURE_PKU,
 	[XFEATURE_PASID]			= X86_FEATURE_ENQCMD,
+	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
+	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
 };
 
 /*
@@ -343,6 +353,8 @@ static void __init print_xstate_features(void)
 	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
 	print_xstate_feature(XFEATURE_MASK_PKRU);
 	print_xstate_feature(XFEATURE_MASK_PASID);
+	print_xstate_feature(XFEATURE_MASK_XTILE_CFG);
+	print_xstate_feature(XFEATURE_MASK_XTILE_DATA);
 }
 
 /*
@@ -616,6 +628,67 @@ static void __xstate_dump_leaves(void)
 	}								\
 } while (0)
 
+/**
+ * check_xtile_data_against_struct - Check tile data state size.
+ *
+ * Calculate the state size by multiplying the single tile size which is
+ * recorded in a C struct, and the number of tiles that the CPU informs.
+ * Compare the provided size with the calculation.
+ *
+ * @size:	The tile data state size
+ *
+ * Returns:	0 on success, -EINVAL on mismatch.
+ */
+static int check_xtile_data_against_struct(int size)
+{
+	u32 max_palid, palid, state_size;
+	u32 eax, ebx, ecx, edx;
+	u16 max_tile;
+
+	/*
+	 * Check the maximum palette id:
+	 *   eax: the highest numbered palette subleaf.
+	 */
+	cpuid_count(TILE_CPUID, 0, &max_palid, &ebx, &ecx, &edx);
+
+	/*
+	 * Cross-check each tile size and find the maximum number of
+	 * supported tiles.
+	 */
+	for (palid = 1, max_tile = 0; palid <= max_palid; palid++) {
+		u16 tile_size, max;
+
+		/*
+		 * Check the tile size info:
+		 *   eax[31:16]:  bytes per title
+		 *   ebx[31:16]:  the max names (or max number of tiles)
+		 */
+		cpuid_count(TILE_CPUID, palid, &eax, &ebx, &edx, &edx);
+		tile_size = eax >> 16;
+		max = ebx >> 16;
+
+		if (tile_size != sizeof(struct xtile_data)) {
+			pr_err("%s: struct is %zu bytes, cpu xtile %d bytes\n",
+			       __stringify(XFEATURE_XTILE_DATA),
+			       sizeof(struct xtile_data), tile_size);
+			__xstate_dump_leaves();
+			return -EINVAL;
+		}
+
+		if (max > max_tile)
+			max_tile = max;
+	}
+
+	state_size = sizeof(struct xtile_data) * max_tile;
+	if (size != state_size) {
+		pr_err("%s: calculated size is %u bytes, cpu state %d bytes\n",
+		       __stringify(XFEATURE_XTILE_DATA), state_size, size);
+		__xstate_dump_leaves();
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /*
  * We have a C struct for each 'xstate'.  We need to ensure
  * that our software representation matches what the CPU
@@ -639,6 +712,11 @@ static int check_xstate_against_struct(int nr)
 	XCHECK_SZ(sz, nr, XFEATURE_Hi16_ZMM,  struct avx_512_hi16_state);
 	XCHECK_SZ(sz, nr, XFEATURE_PKRU,      struct pkru_state);
 	XCHECK_SZ(sz, nr, XFEATURE_PASID,     struct ia32_pasid_state);
+	XCHECK_SZ(sz, nr, XFEATURE_XTILE_CFG, struct xtile_cfg);
+
+	/* The tile data size varies between implementations. */
+	if (nr == XFEATURE_XTILE_DATA)
+		check_xtile_data_against_struct(sz);
 
 	/*
 	 * Make *SURE* to add any feature numbers in below if
@@ -648,7 +726,7 @@ static int check_xstate_against_struct(int nr)
 	if ((nr < XFEATURE_YMM) ||
 	    (nr >= XFEATURE_MAX) ||
 	    (nr == XFEATURE_PT_UNIMPLEMENTED_SO_FAR) ||
-	    ((nr >= XFEATURE_RSRVD_COMP_11) && (nr <= XFEATURE_LBR))) {
+	    ((nr >= XFEATURE_RSRVD_COMP_11) && (nr <= XFEATURE_RSRVD_COMP_16))) {
 		pr_err("no structure for xstate: %d\n", nr);
 		XSTATE_WARN_ON(1);
 		return -EINVAL;
-- 
2.17.1

