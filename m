Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A721A3A6FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 22:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhFNURR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 16:17:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57458 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhFNURM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:17:12 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623701708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GcF4L/PJ2zhQ+1ZAZQJ1sut/3O3JGVdorF5KDH2wryk=;
        b=bthr06o5x2i8IZjR3Haeu0ZciLSDnGUrZ7jN0bfYkWFQGNzY1myCS/VInmVTN7pRZqtV3C
        9ABSDqtpIZxlv7sEfPad5c3SXMUJnBUd05FIflwqldbsReVekOn1czyQS0rz6A7iCnTgt+
        znrOGeB+KMw3FwqIZQTYSnzF4S/qvQRovfsBjr0/pzCCWDA8of1FmyMPALy00UQ2EJqzx7
        oNmXCfFlzyNrJsVkxdFyKSO8nfziPLauO/Abq/SfiDe4PRc1IPOjjAOQkNOBemQJWuv9mI
        2XX86qgcO65+LnBjkHG1flAjRe9r4vUj8wR1FM1sdCfNHiPWK9gBh3kAUXoCTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623701708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GcF4L/PJ2zhQ+1ZAZQJ1sut/3O3JGVdorF5KDH2wryk=;
        b=inhyMISw2Ofl1EV3VJbhyra2OS5jt80np7iwugxUcVGnRxzirp2tueMeGU9jQEdQzeatqz
        KIiDo+vZcFGWMRDw==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [patch] x86/fpu: x86/fpu: Preserve supervisor states in sanitize_restored_user_xstate()
In-Reply-To: <20210614154408.673478623@linutronix.de>
References: <20210614154408.673478623@linutronix.de>
Date:   Mon, 14 Jun 2021 22:15:08 +0200
Message-ID: <877diwursj.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sanitize_restored_user_xstate() preserves the supervisor states only
when the fx_only argument is zero, which allows unpriviledged user space
to put supervisor states back into init state.

Preserve them unconditionally.

Fixes: 5d6b6a6f9b5c ("x86/fpu/xstate: Update sanitize_restored_xstate() for supervisor xstates")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/fpu/signal.c |   26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -221,28 +221,18 @@ sanitize_restored_user_xstate(union fpre
 
 	if (use_xsave()) {
 		/*
-		 * Note: we don't need to zero the reserved bits in the
-		 * xstate_header here because we either didn't copy them at all,
-		 * or we checked earlier that they aren't set.
+		 * Clear all features bit which are not set in
+		 * user_xfeatures and clear all extended features
+		 * for fx_only mode.
 		 */
+		u64 mask = fx_only ? XFEATURE_MASK_FPSSE : user_xfeatures;
 
 		/*
-		 * 'user_xfeatures' might have bits clear which are
-		 * set in header->xfeatures. This represents features that
-		 * were in init state prior to a signal delivery, and need
-		 * to be reset back to the init state.  Clear any user
-		 * feature bits which are set in the kernel buffer to get
-		 * them back to the init state.
-		 *
-		 * Supervisor state is unchanged by input from userspace.
-		 * Ensure supervisor state bits stay set and supervisor
-		 * state is not modified.
+		 * Supervisor state has to be preserved. The sigframe
+		 * restore can only modify user features, i.e. @mask
+		 * cannot contain them.
 		 */
-		if (fx_only)
-			header->xfeatures = XFEATURE_MASK_FPSSE;
-		else
-			header->xfeatures &= user_xfeatures |
-					     xfeatures_mask_supervisor();
+		header->xfeatures &= mask | xfeatures_mask_supervisor();
 	}
 
 	if (use_fxsr()) {
