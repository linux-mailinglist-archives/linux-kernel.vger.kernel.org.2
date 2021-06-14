Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6873A6C05
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbhFNQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:40:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55848 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbhFNQkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:00 -0400
Message-Id: <20210614155354.630211386@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vIGJlj6yAQUQhqtDz0ifh1jGuBG8HIiu+//WZQJJHaU=;
        b=lPzInPasKXtYjGW1tp/8kcfJymluNouQSBz02B91nbdbniL1KC2/W/L+WelFznGbAZZT7c
        utsCp9frmx/8DR7qSuJA+Yayc2rbCemOaN7DBK0EN3NrPdLpJzbS0XXmmC6SVZspz+wwaJ
        NGLzmMlUH6Q0SdKgMwIVKgBIHFcs8DcAifyN8nrx+grQ3bHcYXThJaVjkxwXL3bzElSO06
        6JMl8//ekmrxWjktkynbxB1nDF40zQym7kyNIqg5xAmykwX6k6/KE8/CIWhcrJlL/23M+t
        iRmIKv7nLax8mVyIOb8gMCu9avgirU+PTomHnLqYa+n7MrGlaS6QGyYQaBrHpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vIGJlj6yAQUQhqtDz0ifh1jGuBG8HIiu+//WZQJJHaU=;
        b=ECUaBiD3MLFxWrgyO9G3z7OQ/aPKB7p+V5pkOJSwv8WkaZxFtYR2tfnn4KdWLoD+5WRB0I
        ptlwgBDo15hVqmCw==
Date:   Mon, 14 Jun 2021 17:44:17 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch V2 09/52] x86/fpu: Reject invalid MXCSR values in
 copy_kernel_to_xstate()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of masking out reserved bits, check them and reject the provided
state as invalid if not zero.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/fpu/xstate.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1166,6 +1166,14 @@ int copy_kernel_to_xstate(struct xregs_s
 	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
+	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
+		const u32 *mxcsr = kbuf + offsetof(struct fxregs_state, mxcsr);
+
+		/* Reserved bits in MXCSR must be zero. */
+		if (*mxcsr & ~mxcsr_feature_mask)
+			return -EINVAL;
+	}
+
 	for (i = 0; i < XFEATURE_MAX; i++) {
 		u64 mask = ((u64)1 << i);
 
@@ -1196,9 +1204,6 @@ int copy_kernel_to_xstate(struct xregs_s
 	 */
 	xsave->header.xfeatures |= hdr.xfeatures;
 
-	/* mxcsr reserved bits must be masked to zero for historical reasons. */
-	xsave->i387.mxcsr &= mxcsr_feature_mask;
-
 	return 0;
 }
 

