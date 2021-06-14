Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC3F3A6C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhFNQkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbhFNQkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CAFC061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:38:05 -0700 (PDT)
Message-Id: <20210614155355.241932488@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=m/kXvcadWJhBJr8vFnWue+Z6Bi+JsQhAgz+ZPUc/yEI=;
        b=l/77irG3jgWzKPrIQ5zm/YeCyHThkskUozUSlL+WAuwQMRnRVcKRcPDCunM6CviFec6/e1
        BAxz1PyvMMRSQDgqBVpCy5fldQpR2j8j2LA+w28icoO4VGc0xpbY2yLc4zQ9TU3pXAIfFO
        tF8HoXiriIXRZCgb2zZJ0maPhJ008ApMB87XyCo8MuGe3KJCWxCpPu4POru1Brg6g/cl8k
        RQ9VjKNgS2a80gMwich5mLhvxOo/3Qry+oW5NgwJ6O+MccuvaUT0LQmtxlrSq0Z2lkJ3a8
        nwaO7crDnKIpD1YMRdYCp4Ua4KgDWjwo6MfzzXWOrqQdPw9qWox9ePP9DXDa0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=m/kXvcadWJhBJr8vFnWue+Z6Bi+JsQhAgz+ZPUc/yEI=;
        b=3UVgPhDoo3b/4x7MbAdGWk/whbuKQbSVVVIUjCqi2ZL5jFIECpdRe+jPZl4Y89LWJF/1+Y
        4OmW0YWiZaKVqhBw==
Date:   Mon, 14 Jun 2021 17:44:23 +0200
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
Subject: [patch V2 15/52] x86/fpu: Use copy_uabi_xstate_to_membuf() in xfpregs_get()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new functionality of copy_uabi_xstate_to_membuf() to retrieve the
FX state when XSAVE* is in use. This avoids to overwrite the FPU state
buffer with fpstate_sanitize_xstate() which is error prone and duplicated
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/fpu/regset.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -33,13 +33,18 @@ int xfpregs_get(struct task_struct *targ
 {
 	struct fpu *fpu = &target->thread.fpu;
 
-	if (!boot_cpu_has(X86_FEATURE_FXSR))
+	if (!static_cpu_has(X86_FEATURE_FXSR))
 		return -ENODEV;
 
 	fpu__prepare_read(fpu);
-	fpstate_sanitize_xstate(fpu);
 
-	return membuf_write(&to, &fpu->state.fxsave, sizeof(struct fxregs_state));
+	if (!use_xsave()) {
+		return membuf_write(&to, &fpu->state.fxsave,
+				    sizeof(fpu->state.fxsave));
+	}
+
+	copy_uabi_xstate_to_membuf(to, &fpu->state.xsave, XSTATE_COPY_FX);
+	return 0;
 }
 
 int xfpregs_set(struct task_struct *target, const struct user_regset *regset,

