Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724803A6C10
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhFNQk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:40:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55858 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbhFNQkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:13 -0400
Message-Id: <20210614155355.744726133@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QX1VoycMN9gsrXlDDoDt65mZa5mTaOiskCaBMc3isOA=;
        b=sEnfohLFb12KCgsMKH/Z5uuV8ocO5C2G38ny3N6+mSYx0LyEHpSbtwlUH+hjpW9alVEFLr
        khINsgaDg1DdYsuXrBBLAF/kLIGY857Fw6Ef3HcT5UkWo8uACdrYRB7WWjbCfGOuCokZVd
        rd2WEAVo+HZzNWcniD001vWbY+z/wqzuWzfrgLk9Z0lH0PiKI5qjTJdDjdnoQL/Otv6ZRe
        AyV/949wfU3JXqDNeb9g+r9Rfr60rJVCBzGTJGInuY8pjdH1MamBjo38KJ6Xnu8nQkCHyX
        nygFz6Hjjz6BwLVY9a0cgaCConMFm/eup7XztrK3OzMB6qt50nGzt63hwmzgbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QX1VoycMN9gsrXlDDoDt65mZa5mTaOiskCaBMc3isOA=;
        b=YOAGH+VlrMv56pQ6QAuDX1xJ20dCS1r2gKLDnp2ZG0yjCSFx8mn8PUL/EmCfpHW6C69dc4
        qGKlNr6NpXmht7Cg==
Date:   Mon, 14 Jun 2021 17:44:28 +0200
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
Subject: [patch V2 20/52] x86/fpu: Cleanup arch_set_user_pkey_access()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is having a sanity check with a WARN_ON_ONCE() but happily
proceeds when the pkey argument is out of range.

Clean it up.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/xstate.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -887,11 +887,10 @@ EXPORT_SYMBOL_GPL(get_xsave_addr);
  * rights for @pkey to @init_val.
  */
 int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val)
+			      unsigned long init_val)
 {
-	u32 old_pkru;
-	int pkey_shift = (pkey * PKRU_BITS_PER_PKEY);
-	u32 new_pkru_bits = 0;
+	u32 old_pkru, new_pkru_bits = 0;
+	int pkey_shift;
 
 	/*
 	 * This check implies XSAVE support.  OSPKE only gets
@@ -905,7 +904,8 @@ int arch_set_user_pkey_access(struct tas
 	 * values originating from in-kernel users.  Complain
 	 * if a bad value is observed.
 	 */
-	WARN_ON_ONCE(pkey >= arch_max_pkey());
+	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
+		return -EINVAL;
 
 	/* Set the bits we need in PKRU:  */
 	if (init_val & PKEY_DISABLE_ACCESS)
@@ -914,6 +914,7 @@ int arch_set_user_pkey_access(struct tas
 		new_pkru_bits |= PKRU_WD_BIT;
 
 	/* Shift the bits in to the correct place in PKRU for pkey: */
+	pkey_shift = pkey * PKRU_BITS_PER_PKEY;
 	new_pkru_bits <<= pkey_shift;
 
 	/* Get old PKRU and mask off any old bits in place: */

