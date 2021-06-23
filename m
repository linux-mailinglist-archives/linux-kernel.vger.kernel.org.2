Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357573B19F8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhFWM1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhFWM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:27 -0400
Message-Id: <20210623121454.111665161@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=K5fT8WgBPPoznBiSIkeWKP31Ik0El/34bHemO4mnuU4=;
        b=V8bkQhzatF1y2Vf1knjqAsNOrnPnKjO+0FDMbfCMM9S/rJW9liNh2TEOkREI17qNseg3jy
        Vi24fGCardnUio22g+HbVBya7W2Zp7VN5MKetmuwZJbCVGY9jx5tP/i43CQLazZR9cd3zT
        J0KmICdosUOr8g99/qc9QwI4pkPSzbTJT7h0wL6t2VJX4H9eC7zGLLIXvuvRTiJI6fhTAm
        4XU5i15XHPN48jpBdg7AQsJZEFQbWrgS/VNGY3RvKmXeGbaFPo4ZLyiKTVn21W4i+Kr8ys
        e70tCsPg6FwRMshaH+6OI5n5dhlqk7QTNDMcNHY3SpjDJy7saWIe5tYY5BNNYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=K5fT8WgBPPoznBiSIkeWKP31Ik0El/34bHemO4mnuU4=;
        b=bsLgwMlyAxKbc3khS1qi6B9Dzwsy7pU7PYwLRLRreyEKo1YXl4s8wEDzErvVsEEy9r3KwS
        2FfVSoYc085LiUBg==
Date:   Wed, 23 Jun 2021 14:01:55 +0200
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
Subject: [patch V4 28/65] x86/math-emu: Rename frstor()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is in the way of renaming the low level hardware accessors to match
the instruction name. Prepend it with FPU_ which is consistent vs. the
rest of the emulation code.

No functional change.

Reported-by Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Bring back the lost fix.
---
 arch/x86/math-emu/fpu_proto.h  |    2 +-
 arch/x86/math-emu/load_store.c |    2 +-
 arch/x86/math-emu/reg_ld_str.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/math-emu/fpu_proto.h
+++ b/arch/x86/math-emu/fpu_proto.h
@@ -144,7 +144,7 @@ extern int FPU_store_int16(FPU_REG *st0_
 extern int FPU_store_bcd(FPU_REG *st0_ptr, u_char st0_tag, u_char __user *d);
 extern int FPU_round_to_int(FPU_REG *r, u_char tag);
 extern u_char __user *fldenv(fpu_addr_modes addr_modes, u_char __user *s);
-extern void frstor(fpu_addr_modes addr_modes, u_char __user *data_address);
+extern void FPU_frstor(fpu_addr_modes addr_modes, u_char __user *data_address);
 extern u_char __user *fstenv(fpu_addr_modes addr_modes, u_char __user *d);
 extern void fsave(fpu_addr_modes addr_modes, u_char __user *data_address);
 extern int FPU_tagof(FPU_REG *ptr);
--- a/arch/x86/math-emu/load_store.c
+++ b/arch/x86/math-emu/load_store.c
@@ -240,7 +240,7 @@ int FPU_load_store(u_char type, fpu_addr
 		   fix-up operations. */
 		return 1;
 	case 022:		/* frstor m94/108byte */
-		frstor(addr_modes, (u_char __user *) data_address);
+		FPU_frstor(addr_modes, (u_char __user *) data_address);
 		/* Ensure that the values just loaded are not changed by
 		   fix-up operations. */
 		return 1;
--- a/arch/x86/math-emu/reg_ld_str.c
+++ b/arch/x86/math-emu/reg_ld_str.c
@@ -1117,7 +1117,7 @@ u_char __user *fldenv(fpu_addr_modes add
 	return s;
 }
 
-void frstor(fpu_addr_modes addr_modes, u_char __user *data_address)
+void FPU_frstor(fpu_addr_modes addr_modes, u_char __user *data_address)
 {
 	int i, regnr;
 	u_char __user *s = fldenv(addr_modes, data_address);

