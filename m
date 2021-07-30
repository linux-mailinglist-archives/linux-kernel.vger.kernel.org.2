Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA0C3DBBA8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbhG3PHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:07:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:52626 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239685AbhG3PGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:06:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="298699139"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="298699139"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 08:06:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="508154965"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2021 08:06:07 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v9 20/26] x86/fpu/amx: Initialize child's AMX state
Date:   Fri, 30 Jul 2021 07:59:51 -0700
Message-Id: <20210730145957.7927-21-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210730145957.7927-1-chang.seok.bae@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
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
index e7c6396261ca..912b420cb148 100644
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
index 541628bfc8c0..387118127f93 100644
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

