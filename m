Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7493ACE82
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhFRPVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhFRPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBCAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:19:21 -0700 (PDT)
Message-Id: <20210618143444.438635017@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NV3dF4mvbZ3pyRCUcLgbs+oTmEaMPjaISeC3pG6mczo=;
        b=kPSezow3dDo175GUjH1nvJrFASaKf6QtTjosiGFFds6amdKl7Wo3Bg+H4VyYTk7CZ8/uOV
        SDc6U6IxrCc4IFNVmFUs8r+8hfMjK2mDEHy8fsIZ50NRZCQcWurhokMZKkntdLXU5IgMdl
        KN9GaO9upOMk/D98hzE9OaY1tfxgl6/iO4GfA/xKICLRaywwxmfVsL02/Df6gl7XtdTqWV
        TmQxNORUH8M0cpgM+aBofMqSxyJe0Y6OYKyH7D+aQHfVv35Yk9G7yPMx3XY0M7A028+CAP
        UnAnws3XzEPBD8kCo2r8rG/dGW/nHVYmxiHkDaa31cby1JivlMD2V8t7MBtBJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NV3dF4mvbZ3pyRCUcLgbs+oTmEaMPjaISeC3pG6mczo=;
        b=z2BMhRIMzi8wIKfR/WOdi5nzxgs6CfGYxoZiFhNtW/eUE2e7Crxovc3k0rIa9athKEyPDo
        sgYK4C53eh36s4Aw==
Date:   Fri, 18 Jun 2021 16:18:24 +0200
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
Subject: [patch V3 01/66] x86/fpu: x86/fpu: Preserve supervisor states in
 sanitize_restored_user_xstate()
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

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

