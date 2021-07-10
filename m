Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC03C34A5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 15:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhGJNM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 09:12:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:52358 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231446AbhGJNLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 09:11:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="209867328"
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="209867328"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2021 06:09:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="488742409"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2021 06:09:09 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v7 20/26] x86/fpu/amx: Initialize child's AMX state
Date:   Sat, 10 Jul 2021 06:03:07 -0700
Message-Id: <20210710130313.5072-21-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210710130313.5072-1-chang.seok.bae@intel.com>
References: <20210710130313.5072-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assure that a forked child starts AMX registers in the INIT-state.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v5:
* Introduced a new define. (Andy Lutomirski)

Changes from v4:
* Added as a new patch. This was missing on previous versions.
---
 arch/x86/include/asm/fpu/xstate.h | 3 +++
 arch/x86/kernel/fpu/core.c        | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index dbf0db1df9bf..bd7df0e7fc2b 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -80,6 +80,9 @@
 				      XFEATURE_MASK_INDEPENDENT | \
 				      XFEATURE_MASK_SUPERVISOR_UNSUPPORTED)
 
+/* Volatile states that a child does not inherit. */
+#define XFEATURE_MASK_CLEARED_ON_CLONE	XFEATURE_MASK_XTILE
+
 #ifdef CONFIG_X86_64
 #define REX_PREFIX	"0x48, "
 #else
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index ed127c4d182b..e8912b5b9369 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -299,6 +299,9 @@ int fpu_clone(struct task_struct *dst)
 		save_fpregs_to_fpstate(dst_fpu);
 	fpregs_unlock();
 
+	if (xfeatures_mask_all & XFEATURE_MASK_CLEARED_ON_CLONE)
+		dst_fpu->state->xsave.header.xfeatures &= ~XFEATURE_MASK_CLEARED_ON_CLONE;
+
 	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
 
 	trace_x86_fpu_copy_src(src_fpu);
-- 
2.17.1

