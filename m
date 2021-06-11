Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19A93A3B43
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 07:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhFKFPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 01:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhFKFPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 01:15:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9252613B8;
        Fri, 11 Jun 2021 05:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623388419;
        bh=ikXTuxUtKCmcVn7KzA0q7Ur2mS5OTZCN1NPG7jjaKMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFFBUB6UA9HgqQr+XKqOoWtZ4Y0egWedEcd6j1ygUlyNdUiDQyhCyBDIFJrmJ6qtw
         Y7Q0vK4NzO7yzclFnROFaDIQefftJc3dkcHqc3qk+ahulZhY9hfA/AWHZ4CLlqaqTL
         V6T9yaDPcpiUpC32nyjnSxUcSQHuiC/oQkoboVNl054IUce0wyZmLteh2JvbGyvBY8
         jR7YUMM1jC5RUc9lxP07SChHg3AtavBTVG5SEbsJGdgZt0pm83QNjJLXEcoHawf1jq
         fGgmPck7e8eedUINmXHNWQ/9vqytEmJS3D6LLW7ag1qPEjPUO84gq5jTN3+vbsv420
         R3fxvs4ZHHmEw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/2] x86/fpu: Improve FPU APIs for independent features
Date:   Thu, 10 Jun 2021 22:13:37 -0700
Message-Id: <657f57d4a50f0bdab7c74bf8ca47b413583b6db4.1623388344.git.luto@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623388344.git.luto@kernel.org>
References: <cover.1623388344.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having the functions that save and restore independent features accept,
but ignore, non-independent features is confusing, so instead require
that only independent features be independently saved and restored.

Remove a bunch of nonsense comments from the save and restore functions:
saving and restoring the XSAVE header makes no sense.

Document that fpu__clear_all() does not clear independent features.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/fpu/xstate.h |  5 ++++-
 arch/x86/kernel/fpu/core.c        |  3 +++
 arch/x86/kernel/fpu/xstate.c      | 33 +++++++++++--------------------
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 5802b1715c7f..3bc5e6c9e47a 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -34,7 +34,10 @@
 				      XFEATURE_MASK_BNDREGS | \
 				      XFEATURE_MASK_BNDCSR)
 
-/* All currently supported supervisor features */
+/*
+ * All currently supported supervisor features that are saved and
+ * restored as part of the main task XSAVE buffers.
+ */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
 
 /*
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 571220ac8bea..9af361464c66 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -390,6 +390,9 @@ void fpu__clear_user_states(struct fpu *fpu)
 	fpu__clear(fpu, true);
 }
 
+/*
+ * This does not affect independent features -- see XFEATURE_MASK_INDEPENDENT.
+ */
 void fpu__clear_all(struct fpu *fpu)
 {
 	fpu__clear(fpu, false);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d582275164ad..15bb87f4f510 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1292,29 +1292,26 @@ void copy_supervisor_to_kernel(struct xregs_state *xstate)
  * @xstate: A pointer to an xsave area
  * @mask: Represent the independent supervisor features saved into the xsave area
  *
- * Only the independent supervisor states sets in the mask are saved into the xsave
- * area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of independent
- * supervisor feature). Besides the independent supervisor states, the legacy
- * region and XSAVE header are also saved into the xsave area. The supervisor
- * features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
- * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not saved.
+ * The XSAVE header in the target buffer must already be initialized, as the
+ * XSAVES instruction may not fully initialize the XSAVE header.
  *
  * The xsave area must be 64-bytes aligned.
  */
 void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
 {
-	u64 independent_mask = xfeatures_mask_independent() & mask;
 	u32 lmask, hmask;
 	int err;
 
+	WARN_ON_FPU(mask & ~xfeatures_mask_independent());
+
 	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
 		return;
 
-	if (WARN_ON_FPU(!independent_mask))
+	if (WARN_ON_FPU(!mask))
 		return;
 
-	lmask = independent_mask;
-	hmask = independent_mask >> 32;
+	lmask = mask;
+	hmask = mask >> 32;
 
 	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
 
@@ -1328,29 +1325,23 @@ void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
  * @xstate: A pointer to an xsave area
  * @mask: Represent the independent supervisor features restored from the xsave area
  *
- * Only the independent supervisor states sets in the mask are restored from the
- * xsave area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of
- * independent supervisor feature). Besides the independent supervisor states, the
- * legacy region and XSAVE header are also restored from the xsave area. The
- * supervisor features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
- * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not restored.
- *
  * The xsave area must be 64-bytes aligned.
  */
 void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask)
 {
-	u64 independent_mask = xfeatures_mask_independent() & mask;
 	u32 lmask, hmask;
 	int err;
 
+	WARN_ON_FPU(mask & ~xfeatures_mask_independent());
+
 	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
 		return;
 
-	if (WARN_ON_FPU(!independent_mask))
+	if (WARN_ON_FPU(!mask))
 		return;
 
-	lmask = independent_mask;
-	hmask = independent_mask >> 32;
+	lmask = mask;
+	hmask = mask >> 32;
 
 	XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
 
-- 
2.31.1

