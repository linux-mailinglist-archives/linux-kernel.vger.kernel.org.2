Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEEC38DCB6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhEWTks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:40:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:32000 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231996AbhEWTj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:57 -0400
IronPort-SDR: 5S7gP2RTm0YFQYRlgsMmzRvQ0ksZ0AHqtOGZxMXtEyz6TuKl+x3+gP8QZb/uVkkKwcerE2pzyH
 FaaG+53Iu3kw==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="198740687"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="198740687"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:29 -0700
IronPort-SDR: Obg+c7MKhy4yM5eQeyjvDhyM11v3R8Pi4/3XxzziR/lLM08DRd7G0+lk5lQmnGe3/X6RWLk2L/
 VV8ZFQdFciUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467136"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:29 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 24/28] x86/fpu/xstate: Use per-task xstate mask for saving xstate in signal frame
Date:   Sun, 23 May 2021 12:32:55 -0700
Message-Id: <20210523193259.26200-25-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entering a signal handler, the kernel saves xstate in signal frame. The
dynamic user state is better to be saved only when used. fpu->state_mask
can help to exclude unused states.

Returning from a signal handler, XRSTOR(S) re-initializes the excluded
state components.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v4:
* Updated the title and the changelog.
* Excluded the test case addition; separated out as a new patch.

Changes from v3:
* Removed 'no functional changes' in the changelog. (Borislav Petkov)

Changes from v1:
* Made it revertable (moved close to the end of the series).
* Included the test case.
---
 arch/x86/include/asm/fpu/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 6460d52991ba..4a3436684805 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -354,7 +354,7 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
  */
 static inline int copy_xregs_to_user(struct xregs_state __user *buf)
 {
-	u64 mask = xfeatures_mask_user();
+	u64 mask = current->thread.fpu.state_mask;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
-- 
2.17.1

