Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3C63B1A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhFWM35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhFWM3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:29:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECDBC0611C0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:45 -0700 (PDT)
Message-Id: <20210623121456.897372712@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=RIb4T5Yg72dEefgpY+eysjKsi/7WjnXAMS1WZsrd4po=;
        b=IqSk8XXZPEEDayT8yA9y6FqJ4kvRKFnZ8A0JDA3gtSIl65OXG+GW6GYSzcSbFytjM91Apz
        hIVRxW/kcMaSmkbQr3b1CO4c2W//C3oaGyvzfj3npRpKSIxrjyGlDik+rJz0NJdQKvqw/y
        GvNY4tI+TOyByyBN7rksG6LiE1hrOn7WsfTMhGQJL16C1nQMJK7EwXN11gPbDxEOQAqfK7
        Ybjc9BpaR67CFk+n4bv9/APtnxULQIlXKt0OLDUKdO1N14tDjPkVp+t0iSmL0uDWW+oAgF
        Kqlj/Vz77PdkKuY33Im8sDHzDCXlwwt1kdnVwz6saguocGJBVPdQQnpfzUiigA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=RIb4T5Yg72dEefgpY+eysjKsi/7WjnXAMS1WZsrd4po=;
        b=rbsoovfY0lcG/AOQfbLoWERwwyG1xAHXUdocguL9vHtlGr07aFIFxpwOkFq32IWpB6ROAe
        vvqy4XJRi1/YYcBA==
Date:   Wed, 23 Jun 2021 14:02:23 +0200
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
Subject: [patch V4 56/65] x86/pkru: Remove xstate fiddling from write_pkru()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PKRU value of a task is stored in task->thread.pkru when the task is
scheduled out. PKRU is restored on schedule in from there. So keeping the
XSAVE buffer up to date is a pointless exercise.

Remove the xstate fiddling and cleanup all related functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/pkru.h          |   17 ++++-------------
 arch/x86/include/asm/special_insns.h |   14 +-------------
 arch/x86/kvm/x86.c                   |    4 ++--
 3 files changed, 7 insertions(+), 28 deletions(-)

--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -41,23 +41,14 @@ static inline u32 read_pkru(void)
 
 static inline void write_pkru(u32 pkru)
 {
-	struct pkru_state *pk;
-
 	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return;
-
-	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
-
 	/*
-	 * The PKRU value in xstate needs to be in sync with the value that is
-	 * written to the CPU. The FPU restore on return to userland would
-	 * otherwise load the previous value again.
+	 * WRPKRU is relatively expensive compared to RDPKRU.
+	 * Avoid WRPKRU when it would not change the value.
 	 */
-	fpregs_lock();
-	if (pk)
-		pk->pkru = pkru;
-	__write_pkru(pkru);
-	fpregs_unlock();
+	if (pkru != rdpkru())
+		wrpkru(pkru);
 }
 
 static inline void pkru_write_default(void)
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -104,25 +104,13 @@ static inline void wrpkru(u32 pkru)
 		     : : "a" (pkru), "c"(ecx), "d"(edx));
 }
 
-static inline void __write_pkru(u32 pkru)
-{
-	/*
-	 * WRPKRU is relatively expensive compared to RDPKRU.
-	 * Avoid WRPKRU when it would not change the value.
-	 */
-	if (pkru == rdpkru())
-		return;
-
-	wrpkru(pkru);
-}
-
 #else
 static inline u32 rdpkru(void)
 {
 	return 0;
 }
 
-static inline void __write_pkru(u32 pkru)
+static inline void wrpkru(u32 pkru)
 {
 }
 #endif
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -943,7 +943,7 @@ void kvm_load_guest_xsave_state(struct k
 	    (kvm_read_cr4_bits(vcpu, X86_CR4_PKE) ||
 	     (vcpu->arch.xcr0 & XFEATURE_MASK_PKRU)) &&
 	    vcpu->arch.pkru != vcpu->arch.host_pkru)
-		__write_pkru(vcpu->arch.pkru);
+		write_pkru(vcpu->arch.pkru);
 }
 EXPORT_SYMBOL_GPL(kvm_load_guest_xsave_state);
 
@@ -957,7 +957,7 @@ void kvm_load_host_xsave_state(struct kv
 	     (vcpu->arch.xcr0 & XFEATURE_MASK_PKRU))) {
 		vcpu->arch.pkru = rdpkru();
 		if (vcpu->arch.pkru != vcpu->arch.host_pkru)
-			__write_pkru(vcpu->arch.host_pkru);
+			write_pkru(vcpu->arch.host_pkru);
 	}
 
 	if (kvm_read_cr4_bits(vcpu, X86_CR4_OSXSAVE)) {

