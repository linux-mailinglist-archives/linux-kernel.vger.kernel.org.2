Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77833320D03
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 20:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhBUTHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 14:07:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:2102 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhBUTCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 14:02:49 -0500
IronPort-SDR: v2K388FoOp+YwJCmpgVALKWDYeBYF9Vp+pUQJuMv0sLYceadl03YUaAbT5JH/yi/dZNANQIgEq
 GOz8xv7Xi2ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="184382828"
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="184382828"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 11:01:29 -0800
IronPort-SDR: IKM2npi+IW40bLIDIhUdRXe17q9KYc8lYKScauePByQSZlwTikVOShQP+gf/zYCuXo/kh3zBU6
 igBt24Xj+6Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="429792118"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2021 11:01:27 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v4 13/22] x86/fpu/xstate: Update the xstate context copy function to support dynamic states
Date:   Sun, 21 Feb 2021 10:56:28 -0800
Message-Id: <20210221185637.19281-14-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210221185637.19281-1-chang.seok.bae@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace() and signal return paths use xstate context copy functions. They
allow callers to read (or write) xstate values in the target's buffer. With
dynamic user states, a component's position in the buffer may vary and the
initial value is not always stored in init_fpstate.

Change the helpers to find a component's offset accordingly.

When copying an initial value, explicitly check the init_fpstate coverage.
If not found, reset the memory in the destination. Otherwise, copy values
from init_fpstate.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v3:
* Cleaned up the code change with more comments.
* Removed 'no functional change' in the changelog. (Borislav Petkov)

Changes from v2:
* Updated the changelog with task->fpu removed. (Borislav Petkov)
---
 arch/x86/kernel/fpu/xstate.c | 69 ++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 84b55f51bdb7..c57877df797d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -301,7 +301,7 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 	 * in a special way already:
 	 */
 	feature_bit = 0x2;
-	xfeatures = (xfeatures_mask_user() & ~xfeatures) >> 2;
+	xfeatures = (xfeatures_mask_user() & fpu->state_mask & ~xfeatures) >> feature_bit;
 
 	/*
 	 * Update all the remaining memory layouts according to their
@@ -310,12 +310,19 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 	 */
 	while (xfeatures) {
 		if (xfeatures & 0x1) {
-			int offset = xstate_comp_offsets[feature_bit];
+			int offset = get_xstate_comp_offset(fpu->state_mask, feature_bit);
 			int size = xstate_sizes[feature_bit];
 
-			memcpy((void *)fx + offset,
-			       (void *)&init_fpstate.xsave + offset,
-			       size);
+			/*
+			 * init_fpstate does not include the dynamic user states
+			 * as having initial values with zeros.
+			 */
+			if (xfeatures_mask_user_dynamic & BIT_ULL(feature_bit))
+				memset((void *)fx + offset, 0, size);
+			else
+				memcpy((void *)fx + offset,
+				       (void *)&init_fpstate.xsave + offset,
+				       size);
 		}
 
 		xfeatures >>= 1;
@@ -1291,15 +1298,31 @@ static void fill_gap(struct membuf *to, unsigned *last, unsigned offset)
 {
 	if (*last >= offset)
 		return;
-	membuf_write(to, (void *)&init_fpstate.xsave + *last, offset - *last);
+
+	/*
+	 * Copy initial data.
+	 *
+	 * init_fpstate buffer has the minimum size as excluding the dynamic user
+	 * states. But their initial values are zeros.
+	 */
+	if (offset <= get_xstate_config(XSTATE_MIN_SIZE))
+		membuf_write(to, (void *)&init_fpstate.xsave + *last, offset - *last);
+	else
+		membuf_zero(to, offset - *last);
 	*last = offset;
 }
 
+/*
+ * @from: If NULL, copy zeros.
+ */
 static void copy_part(struct membuf *to, unsigned *last, unsigned offset,
 		      unsigned size, void *from)
 {
 	fill_gap(to, last, offset);
-	membuf_write(to, from, size);
+	if (from)
+		membuf_write(to, from, size);
+	else
+		membuf_zero(to, size);
 	*last = offset + size;
 }
 
@@ -1351,15 +1374,27 @@ void copy_xstate_to_kernel(struct membuf to, struct fpu *fpu)
 		  sizeof(header), &header);
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+		u64 mask = BIT_ULL(i);
+		void *src;
+
+		if (!(xfeatures_mask_user() & mask))
+			continue;
+
 		/*
-		 * Copy only in-use xstates:
+		 * Copy states if used. Otherwise, copy the initial data.
 		 */
-		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(fpu, i);
 
-			copy_part(&to, &last, xstate_offsets[i],
-				  xstate_sizes[i], src);
-		}
+		if (header.xfeatures & mask)
+			src = __raw_xsave_addr(fpu, i);
+		else
+			/*
+			 * init_fpstate buffer does not include the dynamic
+			 * user state data as having initial values with zeros.
+			 */
+			src = (xfeatures_mask_user_dynamic & mask) ?
+			      NULL : (void *)&init_fpstate.xsave + last;
+
+		copy_part(&to, &last, xstate_offsets[i], xstate_sizes[i], src);
 
 	}
 	fill_gap(&to, &last, size);
@@ -1392,6 +1427,9 @@ int copy_kernel_to_xstate(struct fpu *fpu, const void *kbuf)
 		if (hdr.xfeatures & mask) {
 			void *dst = __raw_xsave_addr(fpu, i);
 
+			if (!dst)
+				continue;
+
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
@@ -1449,6 +1487,9 @@ int copy_user_to_xstate(struct fpu *fpu, const void __user *ubuf)
 		if (hdr.xfeatures & mask) {
 			void *dst = __raw_xsave_addr(fpu, i);
 
+			if (!dst)
+				continue;
+
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
@@ -1529,7 +1570,7 @@ void copy_supervisor_to_kernel(struct fpu *fpu)
 			continue;
 
 		/* Move xfeature 'i' into its normal location */
-		memmove(xbuf + xstate_comp_offsets[i],
+		memmove(xbuf + get_xstate_comp_offset(fpu->state_mask, i),
 			xbuf + xstate_supervisor_only_offsets[i],
 			xstate_sizes[i]);
 	}
-- 
2.17.1

