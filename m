Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6F7402FA1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346753AbhIGU0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346564AbhIGU0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:26:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E2AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:24:53 -0700 (PDT)
Message-ID: <20210907200848.642474947@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=a7Wv01T8o7f/lHSmbG1OlY9G45DQgw4FmmXe+1nvRxg=;
        b=jqswp1Zmn/OAg3otSd2j4TrpY4cz7zblEBZvTP2iDyV2OXhoGeCXgyR246/KGJbejbxNnF
        DqF9zaL/1PuYB6hUxT6ixxTWS2Q2+E9pDQZ9Q/L+UnStUROEdCHUCBXZxSpcsSu5f46dwm
        6sJVWmhKoOwSJgFZkZT7DZIo3iPemG/q+YcVVXocaNufl4dYCROG7D/22poKi0n+mXZVdW
        Z4fyTCTyzlTpN//n4cIBfa2pJbW0x+X3M7G6J2YHaQSiqgSRbzqAzfoMHbrknoVg1bVrB3
        vH7+51Ro3J7UG8oB9xXpToeVa168krpNlsZNKoKm1bGlQzag0b8HOavZYVwPKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=a7Wv01T8o7f/lHSmbG1OlY9G45DQgw4FmmXe+1nvRxg=;
        b=XWWJj1fDFw4K/KoLVLU0wI/imUOGf5yo77r6RV4gfTZO/ArnAFE5gsuSetMWgYwyn6lFEX
        LeQsJ5F3V+eHiNBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 07/20] x86/copy_mc: Use EX_TYPE_DEFAULT_MCE_SAFE for
 exception fixups
References: <20210907200722.067068005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  7 Sep 2021 22:24:51 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing in that code uses the trap number which was stored by the exception
fixup which is instantiated via _ASM_EXTABLE_FAULT().

Use _ASM_EXTABLE(... EX_TYPE_DEFAULT_MCE_SAFE) instead which just handles
the IP fixup and the type indicates to the #MC handler that the call site
can handle the abort caused by #MC correctly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/lib/copy_mc_64.S |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/lib/copy_mc_64.S
+++ b/arch/x86/lib/copy_mc_64.S
@@ -107,9 +107,9 @@ SYM_FUNC_END(copy_mc_fragile)
 
 	.previous
 
-	_ASM_EXTABLE_FAULT(.L_read_leading_bytes, .E_leading_bytes)
-	_ASM_EXTABLE_FAULT(.L_read_words, .E_read_words)
-	_ASM_EXTABLE_FAULT(.L_read_trailing_bytes, .E_trailing_bytes)
+	_ASM_EXTABLE_TYPE(.L_read_leading_bytes, .E_leading_bytes, EX_TYPE_DEFAULT_MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_read_words, .E_read_words, EX_TYPE_DEFAULT_MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_read_trailing_bytes, .E_trailing_bytes, EX_TYPE_DEFAULT_MCE_SAFE)
 	_ASM_EXTABLE(.L_write_leading_bytes, .E_leading_bytes)
 	_ASM_EXTABLE(.L_write_words, .E_write_words)
 	_ASM_EXTABLE(.L_write_trailing_bytes, .E_trailing_bytes)
@@ -149,5 +149,5 @@ SYM_FUNC_END(copy_mc_enhanced_fast_strin
 
 	.previous
 
-	_ASM_EXTABLE_FAULT(.L_copy, .E_copy)
+	_ASM_EXTABLE_TYPE(.L_copy, .E_copy, EX_TYPE_DEFAULT_MCE_SAFE)
 #endif /* !CONFIG_UML */

