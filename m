Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C996B402F3B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346256AbhIGT5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346170AbhIGT5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:57:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B66C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:56:25 -0700 (PDT)
Message-ID: <20210907195004.161996229@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631044583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a7Wv01T8o7f/lHSmbG1OlY9G45DQgw4FmmXe+1nvRxg=;
        b=4te0cJr1pXvC3vt1snn5zElBUQmaGDzQq0NEeZwFcs0QVbeXVbGpQd6scP661MiPkxO5jV
        F57qXLJnaa2Pbm36/pQamu/XKYJd1+D3Uo1yaG4KbZcyJ4X1b9oLvz/bD+Gkb5LpuKoZ32
        0WNbkYjoIMI+2vuar6YZdvSstSmiHILMUxDdU+5jIdqVIbLYWr47fKNGWxHMFDKlcYjGhs
        DDn8+CkTDnOjPpN637Gt5OyB08s1XTkKApMz+xmTG9FyAmn6ePv9WUv7pqpoX6rNTbWxKv
        1MBB+aw735O0ATgUmkJWEcps84OxBne6/NQE9kTPj48syqwCk9FXvP0H4gtM+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631044583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a7Wv01T8o7f/lHSmbG1OlY9G45DQgw4FmmXe+1nvRxg=;
        b=8BAsCsg6LRXIgG8rbWd7NV89cAgWg6B7twNaJNM4RdA+DGtcGdEVrkrvM6IH1g/s8y+VX8
        GpwjNEGaea9whyAQ==
3Message-ID: <20210907193229.370353258@linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2 07/20] x86/copy_mc: Use EX_TYPE_DEFAULT_MCE_SAFE for
 exception fixups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Tue,  7 Sep 2021 21:56:23 +0200 (CEST)
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

