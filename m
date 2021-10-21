Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88688436DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhJUXHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:07:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:58059 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231772AbhJUXHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="315380010"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="315380010"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033244"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:20 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 03/23] x86/fpu/xstate: Provide xstate_calculate_size()
Date:   Thu, 21 Oct 2021 15:55:07 -0700
Message-Id: <20211021225527.10184-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out the size calculation from the paranoia check, so it can be used
for recalculating buffer sizes when dynamically enabled features becomes
supported.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
[ tglx: Adopted to changed base code ]
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 46 ++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index cbba3812a160..310c4201e056 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -549,6 +549,33 @@ static bool __init check_xstate_against_struct(int nr)
 	return true;
 }
 
+static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
+{
+	unsigned int size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
+	int i;
+
+	for_each_extended_xfeature(i, xfeatures) {
+		/* Align from the end of the previous feature */
+		if (xfeature_is_aligned(i))
+			size = ALIGN(size, 64);
+		/*
+		 * In compacted format the enabled features are packed,
+		 * i.e. disabled features do not occupy space.
+		 *
+		 * In non-compacted format the offsets are fixed and
+		 * disabled states still occupy space in the memory buffer.
+		 */
+		if (!compacted)
+			size = xfeature_uncompacted_offset(i);
+		/*
+		 * Add the feature size even for non-compacted format
+		 * to make the end result correct
+		 */
+		size += xfeature_size(i);
+	}
+	return size;
+}
+
 /*
  * This essentially double-checks what the cpu told us about
  * how large the XSAVE buffer needs to be.  We are recalculating
@@ -575,25 +602,8 @@ static bool __init paranoid_xstate_size_valid(unsigned int kernel_size)
 			XSTATE_WARN_ON(1);
 			return false;
 		}
-
-		/* Align from the end of the previous feature */
-		if (xfeature_is_aligned(i))
-			size = ALIGN(size, 64);
-		/*
-		 * In compacted format the enabled features are packed,
-		 * i.e. disabled features do not occupy space.
-		 *
-		 * In non-compacted format the offsets are fixed and
-		 * disabled states still occupy space in the memory buffer.
-		 */
-		if (!compacted)
-			size = xfeature_uncompacted_offset(i);
-		/*
-		 * Add the feature size even for non-compacted format
-		 * to make the end result correct
-		 */
-		size += xfeature_size(i);
 	}
+	size = xstate_calculate_size(fpu_kernel_cfg.max_features, compacted);
 	XSTATE_WARN_ON(size != kernel_size);
 	return size == kernel_size;
 }
-- 
2.17.1

