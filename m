Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE3F436DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhJUXHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:07:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:58072 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232230AbhJUXHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="315380052"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="315380052"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033352"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:24 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 11/23] x86/fpu: Reset permission and fpstate on exec()
Date:   Thu, 21 Oct 2021 15:55:15 -0700
Message-Id: <20211021225527.10184-12-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On exec(), extended register states saved in the buffer is cleared. With
dynamic features, each task carries variables besides the register states.
The struct fpu has permission information and struct fpstate contains
buffer size and feature masks. They are all dynamically updated with
dynamic features.

Reset the current task's entire FPU data before an exec() so that the new
task starts with default permission and fpstate.

Rename the register state reset function because the old naming confuses as
it does not reset struct fpstate.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Changes from the tglx tree:
* Add as a new patch.
---
 arch/x86/kernel/fpu/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 177f27687261..073a8fc281d8 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -547,7 +547,7 @@ static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 /*
  * Reset current->fpu memory state to the init values.
  */
-static void fpu_reset_fpstate(void)
+static void fpu_reset_fpregs(void)
 {
 	struct fpu *fpu = &current->thread.fpu;
 
@@ -582,7 +582,7 @@ void fpu__clear_user_states(struct fpu *fpu)
 
 	fpregs_lock();
 	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
-		fpu_reset_fpstate();
+		fpu_reset_fpregs();
 		fpregs_unlock();
 		return;
 	}
@@ -612,7 +612,8 @@ void fpu__clear_user_states(struct fpu *fpu)
 
 void fpu_flush_thread(void)
 {
-	fpu_reset_fpstate();
+	fpstate_reset(&current->thread.fpu);
+	fpu_reset_fpregs();
 }
 /*
  * Load FPU context before returning to userspace.
-- 
2.17.1

