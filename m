Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB063CC42B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhGQPi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:38:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:24190 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235227AbhGQPiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:38:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="210853881"
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="210853881"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2021 08:35:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="631387050"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2021 08:35:10 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v8 21/26] x86/fpu/amx: Enable the AMX feature in 64-bit mode
Date:   Sat, 17 Jul 2021 08:28:58 -0700
Message-Id: <20210717152903.7651-22-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210717152903.7651-1-chang.seok.bae@intel.com>
References: <20210717152903.7651-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 64-bit mode, include the AMX state components in
XFEATURE_MASK_USER_SUPPORTED.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v5:
* Adjusted macro changes and moved the disabling code for non-64-bit mode
  for the new base changes.

Changes from v4:
* Removed the irrelevant line from the changelog. (Thomas Gleixner)
---
 arch/x86/include/asm/fpu/xstate.h | 3 ++-
 arch/x86/kernel/fpu/xstate.c      | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 80bf107d515c..a5d8c8c5478f 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -35,7 +35,8 @@
 				      XFEATURE_MASK_Hi16_ZMM	 | \
 				      XFEATURE_MASK_PKRU | \
 				      XFEATURE_MASK_BNDREGS | \
-				      XFEATURE_MASK_BNDCSR)
+				      XFEATURE_MASK_BNDCSR | \
+				      XFEATURE_MASK_XTILE)
 
 /*
  * Features which are restored when returning to user space.
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 205901f5e89c..52349086209a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -538,7 +538,8 @@ static void __init print_xstate_offset_size(void)
 	 XFEATURE_MASK_PKRU |			\
 	 XFEATURE_MASK_BNDREGS |		\
 	 XFEATURE_MASK_BNDCSR |			\
-	 XFEATURE_MASK_PASID)
+	 XFEATURE_MASK_PASID |			\
+	 XFEATURE_MASK_XTILE)
 
 /*
  * setup the xstate image representing the init state
@@ -1054,6 +1055,9 @@ void __init fpu__init_system_xstate(void)
 	xfeatures_mask_all &= XFEATURE_MASK_USER_SUPPORTED |
 			      XFEATURE_MASK_SUPERVISOR_SUPPORTED;
 
+	if (!IS_ENABLED(CONFIG_X86_64))
+		xfeatures_mask_all &= ~XFEATURE_MASK_XTILE;
+
 	/* Store it for paranoia check at the end */
 	xfeatures = xfeatures_mask_all;
 	/* Do not support the dynamically allocated buffer yet. */
-- 
2.17.1

