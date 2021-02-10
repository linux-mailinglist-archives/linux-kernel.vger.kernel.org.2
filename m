Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1A7315D6F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhBJCiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:38:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234612AbhBJCfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:35:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D86164E56;
        Wed, 10 Feb 2021 02:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924431;
        bh=RxJygLjpvIPl2zBVenfw/Z7XZIfEEYn/JwDbs+OamJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XjzouALJMaN3lBoRGnYdRxYmQhiiC+Kipkp+xwcCTWfHrVT9MZEtdUGYNxWZzwuKO
         UWLdahPwi56t/MWMexEVMu0BoKXMx9TcwGPUR4esmlf4Zs61YLEDmeypvPVvYvIXO2
         rXvqIf5NM6SbJ9ufz+SmsVHhjlcKAREV9oT/etJYeg57ERrNVCNNVM4TuFOQHfZPXn
         p2rXWFoNtH3Z63bvGSPaqIMnERSlaxaPoIhRGZ+p229Jp7Jf+RLe1nMe4+BT/Hk/aZ
         QZ82fbZ8snKS4yGykyky8TZ9T5Lp/7YwWlthEAsevE0dB9cEWmI9MDir9fhHSQt7Q4
         FrsX2Ut2uNZPw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 04/14] x86/fault/32: Move is_f00f_bug() to do_kern_addr_fault()
Date:   Tue,  9 Feb 2021 18:33:36 -0800
Message-Id: <e9668729a48ce6754022b0a4415631e8ebdd00e7.1612924255.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612924255.git.luto@kernel.org>
References: <cover.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bad_area() and its relatives are called from many places in fault.c, and
exactly one of them wants the F00F workaround.

__bad_area_nosemaphore() no longer contains any kernel fault code, which
prepares for further cleanups.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 91cf7a672c04..3ffed003f281 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -482,10 +482,12 @@ static int is_errata100(struct pt_regs *regs, unsigned long address)
 }
 
 /* Pentium F0 0F C7 C8 bug workaround: */
-static int is_f00f_bug(struct pt_regs *regs, unsigned long address)
+static int is_f00f_bug(struct pt_regs *regs, unsigned long error_code,
+		       unsigned long address)
 {
 #ifdef CONFIG_X86_F00F_BUG
-	if (boot_cpu_has_bug(X86_BUG_F00F) && idt_is_f00f_address(address)) {
+	if (boot_cpu_has_bug(X86_BUG_F00F) && !(error_code & X86_PF_USER) &&
+	    idt_is_f00f_address(address)) {
 		handle_invalid_op(regs);
 		return 1;
 	}
@@ -853,9 +855,6 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		return;
 	}
 
-	if (is_f00f_bug(regs, address))
-		return;
-
 	no_context(regs, error_code, address, SIGSEGV, si_code);
 }
 
@@ -1195,6 +1194,9 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 	}
 #endif
 
+	if (is_f00f_bug(regs, hw_error_code, address))
+		return;
+
 	/* Was the fault spurious, caused by lazy TLB invalidation? */
 	if (spurious_kernel_fault(hw_error_code, address))
 		return;
-- 
2.29.2

