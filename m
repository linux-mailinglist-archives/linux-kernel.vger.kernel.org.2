Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31073B19F4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhFWM04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhFWM0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BEBC061760
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:04 -0700 (PDT)
Message-Id: <20210623121453.635764326@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=12h4JTTW0YJqkmMVMRoBj49CzVR9KDBA7AcXATEmIV8=;
        b=ycAv7JMnbK/KhvR0FP66cMwMDirZ3+fo0QT0ExH41SKQzeDTH2B94SCFphS90H/BGipT3i
        VjB7g8q8nlrPwAtL0Dbif2TL9hoaDAHzq3BSB4TxwSC3GOW72rUCWILxiLGBuuTCdALIqq
        lD6j0/EaY1X4y+rJ9ovKlRcacG1dKGpPcOCL0XrG+bbJ8feXmstOu0iZKHwpfhLwQWVAnT
        uZW5xBqxBCnjtXn/ll2LemIKXfG8aUllkeSnTXWfuFX0xUkaCzfKq2pP5tGcsDIGwm3o09
        NwXp4QNkQyxWbBnfgQgDs5ZxEdP6am4S7uxzjK7mVTWZlRjNbVLzD3j/hojFkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=12h4JTTW0YJqkmMVMRoBj49CzVR9KDBA7AcXATEmIV8=;
        b=qiggz81nNHXIDwP+qYbKYbTRVCJ7ZTzN+FMQarsB/mCsgi0EsqBNLlOB3PaC9znqdUQDfx
        RWlDixaqNO8coGCw==
Date:   Wed, 23 Jun 2021 14:01:50 +0200
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
Subject: [patch V4 23/65] x86/fpu: Cleanup arch_set_user_pkey_access()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function does a sanity check with a WARN_ON_ONCE() but happily proceeds
when the pkey argument is out of range.

Clean it up.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/fpu/xstate.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -912,11 +912,10 @@ EXPORT_SYMBOL_GPL(get_xsave_addr);
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
@@ -930,7 +929,8 @@ int arch_set_user_pkey_access(struct tas
 	 * values originating from in-kernel users.  Complain
 	 * if a bad value is observed.
 	 */
-	WARN_ON_ONCE(pkey >= arch_max_pkey());
+	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
+		return -EINVAL;
 
 	/* Set the bits we need in PKRU:  */
 	if (init_val & PKEY_DISABLE_ACCESS)
@@ -939,6 +939,7 @@ int arch_set_user_pkey_access(struct tas
 		new_pkru_bits |= PKRU_WD_BIT;
 
 	/* Shift the bits in to the correct place in PKRU for pkey: */
+	pkey_shift = pkey * PKRU_BITS_PER_PKEY;
 	new_pkru_bits <<= pkey_shift;
 
 	/* Get old PKRU and mask off any old bits in place: */

