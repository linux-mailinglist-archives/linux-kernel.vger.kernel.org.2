Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F5338DCB3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhEWTkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:40:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:32000 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231987AbhEWTj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:57 -0400
IronPort-SDR: 5oczCrOFOu3jt8niKWdQ24BifZc4TOesY2EiOyLVboeCDMXR6zBU017AzNh/rjMKN0cW3rZLVW
 avhYkBXv4LaQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="198740683"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="198740683"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:28 -0700
IronPort-SDR: BhZuZx5buJwTKzuw5aNYqaGfwNUJn0b2mcgMA+BK4fAMbosK9TtWo+iDmdRLT3wJKBXNpXJ99U
 7p6tHYDpP7vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467099"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:28 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 13/28] x86/fpu/xstate: Update the xstate context copy function to support dynamic states
Date:   Sun, 23 May 2021 12:32:44 -0700
Message-Id: <20210523193259.26200-14-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
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
index 9d3cd9775b76..299373669a5d 100644
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
@@ -1297,15 +1304,31 @@ static void fill_gap(struct membuf *to, unsigned *last, unsigned offset)
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
 
@@ -1357,15 +1380,27 @@ void copy_xstate_to_kernel(struct membuf to, struct fpu *fpu)
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
@@ -1398,6 +1433,9 @@ int copy_kernel_to_xstate(struct fpu *fpu, const void *kbuf)
 		if (hdr.xfeatures & mask) {
 			void *dst = __raw_xsave_addr(fpu, i);
 
+			if (!dst)
+				continue;
+
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
@@ -1455,6 +1493,9 @@ int copy_user_to_xstate(struct fpu *fpu, const void __user *ubuf)
 		if (hdr.xfeatures & mask) {
 			void *dst = __raw_xsave_addr(fpu, i);
 
+			if (!dst)
+				continue;
+
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
@@ -1535,7 +1576,7 @@ void copy_supervisor_to_kernel(struct fpu *fpu)
 			continue;
 
 		/* Move xfeature 'i' into its normal location */
-		memmove(xbuf + xstate_comp_offsets[i],
+		memmove(xbuf + get_xstate_comp_offset(fpu->state_mask, i),
 			xbuf + xstate_supervisor_only_offsets[i],
 			xstate_sizes[i]);
 	}
-- 
2.17.1

