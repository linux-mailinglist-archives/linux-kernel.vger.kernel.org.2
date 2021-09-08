Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFE7403AAA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhIHNbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:31:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51014 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349498AbhIHNaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:30 -0400
Message-ID: <20210908132525.328706042@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=a7Wv01T8o7f/lHSmbG1OlY9G45DQgw4FmmXe+1nvRxg=;
        b=HeaF7S///vODPbBAmcjgrFL2aqwse64qLOReOFigpeFxvcvlAZDkg2zsSOd08aNdIFo7Rm
        Yda2Wc55zf1o48ydrA1NAQPzA7cdOXsqi2vPBarQa/aS6Pfh51X3xHP9dBZ98GVN/zzf0G
        gBEvxSO0PIqbuSGWRUbxKZRr+NlCg+sMuLO7wTHCmDfNSNO/4EYKI+xVx2+pv9pwDQGLGl
        UzSxJQQrTqCdpfGAeayuO+89KArf4jvAbPDm2sp7yFlK4mL2A//D8opUr8E2urS958LXT7
        tFeNjdWk9+QV6x061UZJTXp3PItp/57VjA1S6NywbqzjAUwwMGFaaXV64nCR6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=a7Wv01T8o7f/lHSmbG1OlY9G45DQgw4FmmXe+1nvRxg=;
        b=Z6sCOA8hrofY0ymWo5ZaaSy74coVyptGdvczIqjpLF8tl8t0X9M57JshPzRYPRYokvY/QX
        oySDz+CcZMOqtIBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 07/20] x86/copy_mc: Use EX_TYPE_DEFAULT_MCE_SAFE for
 exception fixups
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:21 +0200 (CEST)
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

