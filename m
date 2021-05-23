Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EEE38DCB2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhEWTkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:40:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:31996 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231986AbhEWTj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:57 -0400
IronPort-SDR: q+xfRowZlj1whWV6P6cbHAXrku0ggi1sVyvLEhueotdOKiKSYEgC1GHA3n6K8fRO33+YvQ61Mc
 C4yM1IC40XdQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="198740682"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="198740682"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:28 -0700
IronPort-SDR: NMSrrrT5KDc5qYjAj+ZcAE4tKa5UCXHtrWjtJs4ICIcp1BdJu8Dldvs3gWGUYB0SCMQyLX25CK
 +nGz1GjfbOxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467096"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:28 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 12/28] x86/fpu/xstate: Update the xstate buffer address finder to support dynamic states
Date:   Sun, 23 May 2021 12:32:43 -0700
Message-Id: <20210523193259.26200-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__raw_xsave_addr() returns the requested component's pointer in an xstate
buffer, by simply looking up the offset table. The offset used to be fixed,
but, with dynamic user states, it becomes variable.

get_xstate_size() has a routine to find an offset at runtime. Refactor to
use it for the address finder.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v3:
* Added the function description in the kernel-doc style. (Borislav Petkov)
* Removed 'no functional change' in the changelog. (Borislav Petkov)
---
 arch/x86/kernel/fpu/xstate.c | 80 ++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 773f594bd730..9d3cd9775b76 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -175,6 +175,40 @@ static bool xfeature_is_supervisor(int xfeature_nr)
 	return ecx & 1;
 }
 
+/**
+ * get_xstate_comp_offset() - Find the feature's offset in the compacted format
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
+	if ((mask & xmask) == (xfeatures_mask_all & xmask))
+		return xstate_comp_offsets[feature_nr];
+
+	/*
+	 * With the given mask, no relevant size is found. Calculate it by summing
+	 * up each state size.
+	 */
+
+	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
+
+	for (i = FIRST_EXTENDED_XFEATURE; i <= feature_nr; i++) {
+		if (!(mask & BIT_ULL(i)))
+			continue;
+
+		offset = xstate_aligns[i] ? ALIGN(next_offset, 64) : next_offset;
+		next_offset += xstate_sizes[i];
+	}
+
+	return offset;
+}
+
 /**
  * get_xstate_size() - calculate an xstate buffer size
  * @mask:	This bitmap tells which components reserved in the buffer.
@@ -186,9 +220,8 @@ static bool xfeature_is_supervisor(int xfeature_nr)
  */
 unsigned int get_xstate_size(u64 mask)
 {
-	unsigned int size;
-	u64 xmask;
-	int i, nr;
+	unsigned int offset;
+	int nr;
 
 	if (!mask)
 		return 0;
@@ -207,24 +240,8 @@ unsigned int get_xstate_size(u64 mask)
 	if (!using_compacted_format())
 		return xstate_offsets[nr] + xstate_sizes[nr];
 
-	xmask = BIT_ULL(nr + 1) - 1;
-
-	if (mask == (xmask & xfeatures_mask_all))
-		return xstate_comp_offsets[nr] + xstate_sizes[nr];
-
-	/*
-	 * With the given mask, no relevant size is found so far. So, calculate
-	 * it by summing up each state size.
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
@@ -1048,17 +1065,20 @@ static void *__raw_xsave_addr(struct fpu *fpu, int xfeature_nr)
 {
 	void *xsave;
 
-	if (!xfeature_enabled(xfeature_nr)) {
-		WARN_ON_FPU(1);
-		return NULL;
-	}
-
-	if (fpu)
-		xsave = &fpu->state->xsave;
-	else
+	if (!xfeature_enabled(xfeature_nr))
+		goto not_found;
+	else if (!fpu)
 		xsave = &init_fpstate.xsave;
+	else if (!(fpu->state_mask & BIT_ULL(xfeature_nr)))
+		goto not_found;
+	else
+		xsave = &fpu->state->xsave;
+
+	return xsave + get_xstate_comp_offset(fpu->state_mask, xfeature_nr);
 
-	return xsave + xstate_comp_offsets[xfeature_nr];
+not_found:
+	WARN_ON_FPU(1);
+	return NULL;
 }
 /*
  * Given the xsave area and a state inside, this function returns the
-- 
2.17.1

