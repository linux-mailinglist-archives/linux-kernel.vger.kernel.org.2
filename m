Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F11320CF8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 20:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBUTDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 14:03:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:53122 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230290AbhBUTCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 14:02:13 -0500
IronPort-SDR: JwQWoeOPaMIsesJNUdaJwQKZAysCKNUIX8UoaQysHy4mU4JdeE7uxHIZ0TuIY3FbDoVCSorgxY
 haq7B4jareOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="248330321"
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="248330321"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 11:01:28 -0800
IronPort-SDR: Z4Vd8CnfhRLEuS56PCrLxKOaKmhr05e32102CtyHR+uA8hMdGtN0Zjno2yjretpd7gf2A98jNj
 wWyzpd0p9Zow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="429792137"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2021 11:01:29 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v4 18/22] x86/fpu/amx: Define AMX state components and have it used for boot-time checks
Date:   Sun, 21 Feb 2021 10:56:33 -0800
Message-Id: <20210221185637.19281-19-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210221185637.19281-1-chang.seok.bae@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
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
Changes from v2:
* Updated the code comments.

Changes from v1:
* Rebased on the upstream kernel (5.10)
---
 arch/x86/include/asm/fpu/types.h  | 27 ++++++++++++++
 arch/x86/include/asm/fpu/xstate.h |  2 +
 arch/x86/kernel/fpu/xstate.c      | 62 +++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 6fc707c14350..2f297aa85d8f 100644
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
index cbb4795d2b45..4112dbf05f19 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -13,6 +13,8 @@
 
 #define XSTATE_CPUID		0x0000000d
 
+#define TILE_CPUID		0x0000001d
+
 #define FXSAVE_SIZE	512
 
 #define XSAVE_HDR_SIZE	    64
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 4421ef424670..7e708d6f43b5 100644
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
 
 struct xfeature_capflag_info {
@@ -60,6 +68,8 @@ static struct xfeature_capflag_info xfeature_capflags[] __initdata = {
 	{ XFEATURE_PT_UNIMPLEMENTED_SO_FAR,	X86_FEATURE_INTEL_PT },
 	{ XFEATURE_PKRU,			X86_FEATURE_PKU },
 	{ XFEATURE_PASID,			X86_FEATURE_ENQCMD },
+	{ XFEATURE_XTILE_CFG,			X86_FEATURE_AMX_TILE },
+	{ XFEATURE_XTILE_DATA,			X86_FEATURE_AMX_TILE }
 };
 
 /*
@@ -474,6 +484,8 @@ static void __init print_xstate_features(void)
 	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
 	print_xstate_feature(XFEATURE_MASK_PKRU);
 	print_xstate_feature(XFEATURE_MASK_PASID);
+	print_xstate_feature(XFEATURE_MASK_XTILE_CFG);
+	print_xstate_feature(XFEATURE_MASK_XTILE_DATA);
 }
 
 /*
@@ -733,6 +745,51 @@ static void __xstate_dump_leaves(void)
 	}								\
 } while (0)
 
+static void check_xtile_data_against_struct(int size)
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
+	 * Cross-check each tile size and find the maximum
+	 * number of supported tiles.
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
+		if (WARN_ONCE(tile_size != sizeof(struct xtile_data),
+			      "%s: struct is %zu bytes, cpu xtile %d bytes\n",
+			      __stringify(XFEATURE_XTILE_DATA),
+			      sizeof(struct xtile_data), tile_size))
+			__xstate_dump_leaves();
+
+		if (max > max_tile)
+			max_tile = max;
+	}
+
+	state_size = sizeof(struct xtile_data) * max_tile;
+	if (WARN_ONCE(size != state_size,
+		      "%s: calculated size is %u bytes, cpu state %d bytes\n",
+		      __stringify(XFEATURE_XTILE_DATA), state_size, size))
+		__xstate_dump_leaves();
+}
+
 /*
  * We have a C struct for each 'xstate'.  We need to ensure
  * that our software representation matches what the CPU
@@ -756,6 +813,11 @@ static void check_xstate_against_struct(int nr)
 	XCHECK_SZ(sz, nr, XFEATURE_Hi16_ZMM,  struct avx_512_hi16_state);
 	XCHECK_SZ(sz, nr, XFEATURE_PKRU,      struct pkru_state);
 	XCHECK_SZ(sz, nr, XFEATURE_PASID,     struct ia32_pasid_state);
+	XCHECK_SZ(sz, nr, XFEATURE_XTILE_CFG, struct xtile_cfg);
+
+	/* The tile data size varies between implementations */
+	if (nr == XFEATURE_XTILE_DATA)
+		check_xtile_data_against_struct(sz);
 
 	/*
 	 * Make *SURE* to add any feature numbers in below if
-- 
2.17.1

