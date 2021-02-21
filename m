Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0241320CFE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 20:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhBUTGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 14:06:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:53122 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230391AbhBUTC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 14:02:29 -0500
IronPort-SDR: OX4vAyV1yyk3JGxORkgWk9UfS5RrAgRhuwdgLmgWSv3XyFZ+l+CblB+2LbMhG0JoPeER+S12+E
 7SsDAY53RR3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="248330325"
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="248330325"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 11:01:29 -0800
IronPort-SDR: ChmxsxYV8wdGAv3hd4Sdee6g4To+JpqeOd7rxl63lwfi9NflOtuzX9LFIcFlAROQajovQ5qOqu
 IFTvTxJI/iTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="429792139"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2021 11:01:29 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v4 19/22] x86/fpu/amx: Enable the AMX feature in 64-bit mode
Date:   Sun, 21 Feb 2021 10:56:34 -0800
Message-Id: <20210221185637.19281-20-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210221185637.19281-1-chang.seok.bae@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 64-bit mode, include the AMX state components in
XFEATURE_MASK_USER_SUPPORTED.

The XFD feature will be used to dynamically expand the xstate per-task
buffer on the first use.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/fpu/xstate.h | 3 ++-
 arch/x86/kernel/fpu/init.c        | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 4112dbf05f19..9e5c28f3beaa 100644
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

