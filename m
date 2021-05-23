Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1BD38DCBA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhEWTk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:40:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:31998 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231995AbhEWTj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:57 -0400
IronPort-SDR: AJthNP2yhyZGdGipgUO/IxV9E1OdserKhuU12GOO8cmOkttb9zIdOGYiwKZabjs8HbZ7qxpffe
 YF+KR/M2MkEw==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="198740685"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="198740685"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:29 -0700
IronPort-SDR: H9eAq4y9dV2jn5njKhDVitm/BHoXd7ufmdyiKeK+gKsVowwwnjlzzVMlE9MzPHLI8IHQ5keKz/
 yKdzfFJBD9rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467130"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:29 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 22/28] x86/fpu/amx: Enable the AMX feature in 64-bit mode
Date:   Sun, 23 May 2021 12:32:53 -0700
Message-Id: <20210523193259.26200-23-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
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
Changes from v4:
* Removed the irrelevant line from the changelog. (Thomas Gleixner)
---
 arch/x86/include/asm/fpu/xstate.h | 3 ++-
 arch/x86/kernel/fpu/init.c        | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 2c9156e4f799..a4751fbb7acd 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -34,7 +34,8 @@
 				      XFEATURE_MASK_Hi16_ZMM	 | \
 				      XFEATURE_MASK_PKRU | \
 				      XFEATURE_MASK_BNDREGS | \
-				      XFEATURE_MASK_BNDCSR)
+				      XFEATURE_MASK_BNDCSR | \
+				      XFEATURE_MASK_XTILE)
 
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index f2fcdcc979e7..046889f31037 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -219,8 +219,12 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  */
 u64 __init fpu__get_supported_xfeatures_mask(void)
 {
-	return XFEATURE_MASK_USER_SUPPORTED |
-	       XFEATURE_MASK_SUPERVISOR_SUPPORTED;
+	u64 mask = XFEATURE_MASK_USER_SUPPORTED | XFEATURE_MASK_SUPERVISOR_SUPPORTED;
+
+	if (!IS_ENABLED(CONFIG_X86_64))
+		mask &= ~(XFEATURE_MASK_XTILE);
+
+	return mask;
 }
 
 /* Legacy code to initialize eager fpu mode. */
-- 
2.17.1

