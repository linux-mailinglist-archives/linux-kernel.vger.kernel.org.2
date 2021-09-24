Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A274169AD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbhIXB5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 21:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXB5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:57:03 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5696FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 18:55:31 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTaQx-006pXk-LM; Fri, 24 Sep 2021 01:55:27 +0000
Date:   Fri, 24 Sep 2021 01:55:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-riscv@lists.infradead.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: fix a nasty sigreturn bug...
Message-ID: <YU0wDzeS/jXwkAca@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv has an equivalent of arm bug fixed by 653d48b22166; if signal
gets caught by an interrupt that hits when we have the right value
in a0 (-513), *and* another signal gets delivered upon sigreturn()
(e.g. included into the blocked mask for the first signal and posted
while the handler had been running), the syscall restart logics will
see regs->cause equal to EXC_SYSCALL (we are in a syscall, after all)
and a0 already restored to its original value (-513, which happens to
be -ERESTARTNOINTR) and assume that we need to apply the usual
syscall restart logics.
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index c2d5ecbe55264..f8fb85dc94b7a 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -121,6 +121,8 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
+	regs->cause = -1UL;
+
 	return regs->a0;
 
 badframe:
