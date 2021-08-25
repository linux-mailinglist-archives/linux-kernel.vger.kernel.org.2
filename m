Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A033F79AE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242066AbhHYQC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:02:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:32813 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241950AbhHYQBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:01:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="281267301"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="281267301"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="494317300"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2021 09:00:45 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v10 20/28] x86/fpu/amx: Define AMX state components and have it used for boot-time checks
Date:   Wed, 25 Aug 2021 08:54:05 -0700
Message-Id: <20210825155413.19673-21-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825155413.19673-1-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
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

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
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
 arch/x86/include/asm/fpu/xstate.h |  2 +
 arch/x86/kernel/fpu/xstate.c      | 80 ++++++++++++++++++++++++++++++-
 3 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 51acc637ca98..835108da00e4 100644
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
index d896061933bb..0156ed3d2bc9 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -14,6 +14,8 @@
 
 #define XSTATE_CPUID		0x0000000d
 
+#define TILE_CPUID		0x0000001d
+
 #define FXSAVE_SIZE	512
 
 #define XSAVE_HDR_SIZE	    64
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 10be7b833279..c6244d891dc2 100644
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
@@ -342,6 +352,8 @@ static void __init print_xstate_features(void)
 	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
 	print_xstate_feature(XFEATURE_MASK_PKRU);
 	print_xstate_feature(XFEATURE_MASK_PASID);
+	print_xstate_feature(XFEATURE_MASK_XTILE_CFG);
+	print_xstate_feature(XFEATURE_MASK_XTILE_DATA);
 }
 
 /*
@@ -615,6 +627,67 @@ static void __xstate_dump_leaves(void)
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
@@ -638,6 +711,11 @@ static int check_xstate_against_struct(int nr)
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
@@ -647,7 +725,7 @@ static int check_xstate_against_struct(int nr)
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

