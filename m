Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF7838DCB9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhEWTk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:40:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:12061 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232009AbhEWTj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:58 -0400
IronPort-SDR: ncBjkgSqMH1QrG2HMSKfUjMFQORK9XfyII4cKgLINdHMQ94P0DQ4VkaYOr/x0qdHgszlc4XE+k
 W1H8YaHIMX5g==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="265703543"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265703543"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:29 -0700
IronPort-SDR: pW0i4o6A+8STy2bRHvm9yaPzFGeq+4YaoEIKgckMIxuHFFlImlHxxtt+KvleMDf6iFWo8nwjXR
 W6RV4tTzRrVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467141"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:29 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 25/28] x86/fpu/xstate: Skip writing zeros to signal frame for dynamic user states if in INIT-state
Date:   Sun, 23 May 2021 12:32:56 -0700
Message-Id: <20210523193259.26200-26-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, for xstate features in the INIT-state, XSAVE writes zeros to
the uncompressed destination buffer.

E.g., if you are not using AVX-512, you will still get a bunch of zeros on
the signal stack where live AVX-512 data would go.

For 'dynamic user state' (currently only XTILEDATA), explicitly skip this
data transfer. The result is that the user buffer for the AMX region will
not be touched by XSAVE.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v4:
* Added as a new patch.
---
 arch/x86/include/asm/fpu/internal.h | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 4a3436684805..131f2557fc85 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -354,11 +354,27 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
  */
 static inline int copy_xregs_to_user(struct xregs_state __user *buf)
 {
-	u64 mask = current->thread.fpu.state_mask;
-	u32 lmask = mask;
-	u32 hmask = mask >> 32;
+	u64 state_mask = current->thread.fpu.state_mask;
+	u64 dynamic_state_mask;
+	u32 lmask, hmask;
 	int err;
 
+	dynamic_state_mask = state_mask & xfeatures_mask_user_dynamic;
+	if (dynamic_state_mask && boot_cpu_has(X86_FEATURE_XGETBV1)) {
+		u64 dynamic_xinuse, dynamic_init;
+		u64 xinuse = xgetbv(1);
+
+		dynamic_xinuse = xinuse & dynamic_state_mask;
+		dynamic_init = ~(xinuse) & dynamic_state_mask;
+		if (dynamic_init) {
+			state_mask &= ~xfeatures_mask_user_dynamic;
+			state_mask |= dynamic_xinuse;
+		}
+	}
+
+	lmask = state_mask;
+	hmask = state_mask >> 32;
+
 	/*
 	 * Clear the xsave header first, so that reserved fields are
 	 * initialized to zero.
-- 
2.17.1

