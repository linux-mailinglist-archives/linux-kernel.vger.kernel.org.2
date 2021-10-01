Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F287641F7AA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 00:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356180AbhJAWrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 18:47:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:38147 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356138AbhJAWrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 18:47:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205756671"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="205756671"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 15:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="565344020"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2021 15:44:19 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v11 23/29] x86/fpu/xstate: Skip writing zeros to signal frame for dynamic user states if in INIT-state
Date:   Fri,  1 Oct 2021 15:37:22 -0700
Message-Id: <20211001223728.9309-24-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001223728.9309-1-chang.seok.bae@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, for XSTATE features in the INIT-state, XSAVE writes zeros to
the uncompressed destination buffer.

E.g., if you are not using AVX-512, you will still get a bunch of zeros on
the signal stack where live AVX-512 data would go.

For permssion-required states (currently AMX state), explicitly skip this
data transfer. The result is that the user buffer for the AMX region will
not be touched by XSAVE.

[ Reading XINUSE takes about 20-30 cycles, but writing zeros consumes about
  5-times or more, e.g., for XTILEDATA. ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v10:
* Simplify the sigframe XSAVE code: replace check for XFD STATE with
  XTILECFG and later STATE.

Changes from v9:
* Use cpu_feature_enabled() instead of boot_cpu_has(). (Borislav Petkov)

Changes from v5:
* Mentioned the optimization trade-offs in the changelog. (Dave Hansen)
* Added code comment.

Changes from v4:
* Added as a new patch.
---
 arch/x86/include/asm/fpu/internal.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 06be4c247c97..5f013fa0b205 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -355,8 +355,12 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 		mask = uabi_mask & ~xfeatures_mask_user_perm();
 
 		if (sig_xstate_expanded(current)) {
-			u64 cur_uabi_mask = uabi_mask & current->thread.fpu.state_mask;
+			u64 cur_uabi_mask;
 
+			if (cpu_feature_enabled(X86_FEATURE_XGETBV1))
+				cur_uabi_mask = uabi_mask & xgetbv(1);
+			else
+				cur_uabi_mask = uabi_mask & current->thread.fpu.state_mask;
 			mask |= cur_uabi_mask & xfeatures_mask_user_perm();
 		}
 	}
-- 
2.17.1

