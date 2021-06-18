Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD49F3ACE9B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhFRPWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbhFRPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB73C06124C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:19:42 -0700 (PDT)
Message-Id: <20210618143446.445291166@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0dSVheBdT2C1SUe6+q+ORCYWtS6QZlFN/YbnYkZnvpc=;
        b=LL+7SCgSDUAyno29TGlEsg/ac36cRwEh4WijEgn5QPIUsmH0+GbE3drGUf9uIhxsNMk849
        lG22cy5jo371hNBDjJO5Bm9c17sghORpGGpfvZlH8UzuZOsaegmt0EVk/mqfhimKJcSKn1
        P1IoyPmKkxJv5JrZjHGylN3ZuPEE49vs/rRY5k44xfjQKR+uZtff/ifiDdywjThPLktNnY
        XVQz+dNVj9jLSRi8HWr8yR7sizyDanQOaHHnovr9+qDCH1noO/WjG0UzjwEmjrqgNyPQ2p
        J3YYAoyuxs+eGOUGeDOSlTkRVEDsW3HrrFxbOJf6Tkz0H1334ixWDxO0EvvmSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0dSVheBdT2C1SUe6+q+ORCYWtS6QZlFN/YbnYkZnvpc=;
        b=6U62WsAP/4HP/JbDV0Fi6ede0Q+0vwD+UFude+0BD360rllJh2JB6o09Z8Z/Uxxn9MrzPA
        qGzU5e/46eLts0Aw==
Date:   Fri, 18 Jun 2021 16:18:41 +0200
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
Subject: [patch V3 18/66] x86/fpu: Use copy_xstate_to_uabi_buf() in xfpregs_get()
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new functionality of copy_xstate_to_uabi_buf() to retrieve the
FX state when XSAVE* is in use. This avoids overwriting the FPU state
buffer with fpstate_sanitize_xstate() which is error prone and duplicated
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
V3: Adopted to function rename
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
+	if (!cpu_feature_enabled(X86_FEATURE_FXSR))
 		return -ENODEV;
 
 	fpu__prepare_read(fpu);
-	fpstate_sanitize_xstate(fpu);
 
-	return membuf_write(&to, &fpu->state.fxsave, sizeof(struct fxregs_state));
+	if (!use_xsave()) {
+		return membuf_write(&to, &fpu->state.fxsave,
+				    sizeof(fpu->state.fxsave));
+	}
+
+	copy_xstate_to_uabi_buf(to, &fpu->state.xsave, XSTATE_COPY_FX);
+	return 0;
 }
 
 int xfpregs_set(struct task_struct *target, const struct user_regset *regset,

