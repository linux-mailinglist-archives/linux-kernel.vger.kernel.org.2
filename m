Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4FA309E75
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhAaUBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:01:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231641AbhAaTyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:54:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABB3664E2B;
        Sun, 31 Jan 2021 17:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612113889;
        bh=ovkittzwtSOqCE/zpLG5WHbKUA+jYkgRYhrAHM2fk4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OnSyTx6RJCp+BOfacDR7OmucpGPsmnCns7E78FSFYqmUgLklV0Ay+nNQNWe3RIcIr
         VfCI+k+5EYfvaXptTP+DvEElhqkFXD7J1wLeO1RXkJ/07L2/1OqLcEdaiURQ+h7hf9
         XaMi2/X5djJnKHQXd70IvNb8QdQ31REfsS66TlqXA71NpDC3D5b1q5VoTYroiPStu6
         yq/k9SS5UcA4/UBAHuohsMdW5MERDdw8pE8nkKQopDUjzFjFvESW3m0DwgDP7UUGk9
         bA0sAiidZJL/IF/AoMfhX7Ea1EngwjMmu2seTWxU2hi/pZYrTbq+pWVNtx0SzQIZsM
         xfh3E1LC4e0aA==
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
Subject: [PATCH 03/11] x86/fault/32: Move is_f00f_bug() do do_kern_addr_fault()
Date:   Sun, 31 Jan 2021 09:24:34 -0800
Message-Id: <ed19363b46753f1a4cc980bf13487269c444a648.1612113550.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612113550.git.luto@kernel.org>
References: <cover.1612113550.git.luto@kernel.org>
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
index aff35c9ba018..87d30daa5e0a 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -445,10 +445,12 @@ static int is_errata100(struct pt_regs *regs, unsigned long address)
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
@@ -816,9 +818,6 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		return;
 	}
 
-	if (is_f00f_bug(regs, address))
-		return;
-
 	no_context(regs, error_code, address, SIGSEGV, si_code);
 }
 
@@ -1158,6 +1157,9 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
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

