Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254EE3F79A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbhHYQCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:02:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:25519 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241784AbhHYQBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:01:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="204750083"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="204750083"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:00:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="494317304"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2021 09:00:46 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v10 21/28] x86/fpu/amx: Initialize child's AMX state
Date:   Wed, 25 Aug 2021 08:54:06 -0700
Message-Id: <20210825155413.19673-22-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825155413.19673-1-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
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
index 0156ed3d2bc9..ce65c4871d70 100644
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
index 74941a490200..02681cce1d4e 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -300,6 +300,9 @@ int fpu_clone(struct task_struct *dst)
 		save_fpregs_to_fpstate(dst_fpu);
 	fpregs_unlock();
 
+	if (xfeatures_mask_all & XFEATURE_MASK_CLEARED_ON_CLONE)
+		dst_fpu->state->xsave.header.xfeatures &= ~XFEATURE_MASK_CLEARED_ON_CLONE;
+
 	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
 
 	trace_x86_fpu_copy_src(src_fpu);
-- 
2.17.1

