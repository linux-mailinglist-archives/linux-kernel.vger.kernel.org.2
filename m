Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4484B3ACEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbhFRPXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:23:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56586 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbhFRPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:59 -0400
Message-Id: <20210618143447.223513172@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=12h4JTTW0YJqkmMVMRoBj49CzVR9KDBA7AcXATEmIV8=;
        b=mfvoKDcjhnbS0pF7sosyzYE4sh6JoHcIqoZ0Wlz8kusy9W/LRaN69hSLTZJOk/7CLgYLMu
        N11UcF7Tvw9E291WvWOmuAdzhTmri49VeZEP5USg/wpj57D5MLvOmB9am3/bgP4mGz7NNh
        ILfo+FTyxkxtIMmtD9yQqszIqWCbt6mzf3/8ogRa7R3Sc/e+tEnJz/UMPXwaSMyH9laZE5
        QpObWxNSV3DlS9Nnx6Sv6O3PXXku1YAqxWR99WaRn9GuzRz5lXrqw7/dPi4OjlK3RQXrhA
        /gtvcHI+h5NBP14fL07V3Hd7paZfUr7zvBP8q8qYvT2rRHVodAGFOTeKZL8APw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=12h4JTTW0YJqkmMVMRoBj49CzVR9KDBA7AcXATEmIV8=;
        b=mc+RPW1wxynTldA8swzHwq0F3lJcaPJ5BO2P22JSOuY5zcnwXYNpbLgF5EITWqxBE+5aju
        +Zpo0yUEjSRRNWBg==
Date:   Fri, 18 Jun 2021 16:18:48 +0200
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
Subject: [patch V3 25/66] x86/fpu: Cleanup arch_set_user_pkey_access()
References: <20210618141823.161158090@linutronix.de>
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

