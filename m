Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6778F3DBB8F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbhG3PGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:06:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:52628 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239454AbhG3PGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:06:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="298699122"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="298699122"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 08:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="508154929"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2021 08:06:05 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v9 10/26] x86/fpu/xstate: Update the XSTATE buffer address finder to support dynamic states
Date:   Fri, 30 Jul 2021 07:59:41 -0700
Message-Id: <20210730145957.7927-11-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210730145957.7927-1-chang.seok.bae@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__raw_xsave_addr() returns the requested component's pointer in an XSTATE
buffer, by simply looking up the offset table. The offset used to be fixed,
but, with dynamic user states, it becomes variable.

get_xstate_size() has a routine to find an offset at runtime. Refactor to
use it for the address finder.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v5:
* Updated for future proofed __raw_xsave_addr().

Changes from v3:
* Added the function description in the kernel-doc style. (Borislav Petkov)
* Removed 'no functional change' in the changelog. (Borislav Petkov)
---
 arch/x86/kernel/fpu/xstate.c | 78 ++++++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 26f6d5e0f1ed..98ab10e4da3b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -182,6 +182,38 @@ static bool xfeature_is_supervisor(int xfeature_nr)
 	return ecx & 1;
 }
 
+/**
+ * get_xstate_comp_offset - Find the feature's offset in the compacted
+ *			    format.
+ * @mask:	This bitmap tells which components reserved in the format.
+ * @feature_nr:	The feature number
+ *
+ * Returns:	The offset value
+ */
+static unsigned int get_xstate_comp_offset(u64 mask, int feature_nr)
+{
+	u64 xmask = BIT_ULL(feature_nr + 1) - 1;
+	unsigned int next_offset, offset = 0;
+	int i;
+
+	if ((xfeatures_mask_all & xmask) == (mask & xmask))
+		return xstate_comp_offsets[feature_nr];
+
+	/*
+	 * With the given mask, no relevant size is found. Calculate it by
+	 * summing up each state size.
+	 */
+	for (next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE, i = FIRST_EXTENDED_XFEATURE;
+	     i <= feature_nr; i++) {
+		if (!(mask & BIT_ULL(i)))
+			continue;
+
+		offset = xstate_aligns[i] ? ALIGN(next_offset, 64) : next_offset;
+		next_offset += xstate_sizes[i];
+	}
+	return offset;
+}
+
 /**
  * get_xstate_size - Calculate an xstate buffer size
  * @mask:	This bitmap tells which components reserved in the buffer.
@@ -193,8 +225,8 @@ static bool xfeature_is_supervisor(int xfeature_nr)
  */
 unsigned int get_xstate_size(u64 mask)
 {
-	unsigned int size;
-	int i, nr;
+	unsigned int offset;
+	int nr;
 
 	if (!mask)
 		return 0;
@@ -213,22 +245,8 @@ unsigned int get_xstate_size(u64 mask)
 	if (!boot_cpu_has(X86_FEATURE_XSAVES))
 		return xstate_offsets[nr] + xstate_sizes[nr];
 
-	if ((xfeatures_mask_all & (BIT_ULL(nr + 1) - 1)) == mask)
-		return xstate_comp_offsets[nr] + xstate_sizes[nr];
-
-	/*
-	 * With the given mask, no relevant size is found so far. So,
-	 * calculate it by summing up each state size.
-	 */
-	for (size = FXSAVE_SIZE + XSAVE_HDR_SIZE, i = FIRST_EXTENDED_XFEATURE; i <= nr; i++) {
-		if (!(mask & BIT_ULL(i)))
-			continue;
-
-		if (xstate_aligns[i])
-			size = ALIGN(size, 64);
-		size += xstate_sizes[i];
-	}
-	return size;
+	offset = get_xstate_comp_offset(mask, nr);
+	return offset + xstate_sizes[nr];
 }
 
 /*
@@ -980,19 +998,29 @@ void fpu__resume_cpu(void)
  */
 static void *__raw_xsave_addr(struct fpu *fpu, int xfeature_nr)
 {
+	unsigned int offset;
 	void *xsave;
 
 	if (!xfeature_enabled(xfeature_nr)) {
-		WARN_ON_FPU(1);
-		return NULL;
-	}
+		goto not_found;
+	} else if (!fpu) {
+		xsave = &init_fpstate.xsave;
 
-	if (fpu)
+		offset = get_xstate_comp_offset(xfeatures_mask_all, xfeature_nr);
+		if (offset > sizeof(init_fpstate))
+			goto not_found;
+	} else if (!(fpu->state_mask & BIT_ULL(xfeature_nr))) {
+		goto not_found;
+	} else {
 		xsave = &fpu->state->xsave;
-	else
-		xsave = &init_fpstate.xsave;
+		offset = get_xstate_comp_offset(fpu->state_mask, xfeature_nr);
+	}
+
+	return xsave + offset;
 
-	return xsave + xstate_comp_offsets[xfeature_nr];
+not_found:
+	WARN_ON_FPU(1);
+	return NULL;
 }
 /*
  * Given the xsave area and a state inside, this function returns the
-- 
2.17.1

