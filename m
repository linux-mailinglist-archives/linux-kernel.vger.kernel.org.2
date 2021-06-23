Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFD93B19ED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhFWM0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhFWM0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE9EC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:23:56 -0700 (PDT)
Message-Id: <20210623121452.901736860@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0dSVheBdT2C1SUe6+q+ORCYWtS6QZlFN/YbnYkZnvpc=;
        b=XjlPk7PhMlLqg0wAxGxdiBudauLQaFew+fnqpEMgwhkr5wKagy+kH8aQ4yn4CZWJ3V5zQp
        yDyufqVo5FDevszh8+bYKLb0WCkUqs1pa9X0Ho7SAtAYlFdjPE3Bf8WJ7DvqgI8auEtdKw
        b+92IBuaVIP30yb3uWNOfyafY+blOiO3anfMot5p8nYewaGtGojd88ou1nutbrvF59k4+3
        6Q3gB7bEkPbdnUiLqokSlvJ0Sb5ALXT1tTX+tpw8bTThlOscBgkFzPdL3w4a0usn89Dfb9
        sb9pHdKcKn1NDanYgmFq2ueAhC38yRtFSzPMf1szetTeeylY6/Zr8x1AaW/FmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0dSVheBdT2C1SUe6+q+ORCYWtS6QZlFN/YbnYkZnvpc=;
        b=Z4dtZ3ZKpfjackbntE6NhiMUQfYm5CQvua3HgolFaz4GkJnBtuSeZy2K4p0kOxgt3VmZBD
        wfJUB7WcnHweCOCw==
Date:   Wed, 23 Jun 2021 14:01:43 +0200
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
        Kan Liang <kan.liang@linux.intel.com>,
        "Chang Seok Bae" <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [patch V4 16/65] x86/fpu: Use copy_xstate_to_uabi_buf() in xfpregs_get()
References: <20210623120127.327154589@linutronix.de>
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

