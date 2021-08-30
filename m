Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289883FBA1E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbhH3Q2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:28:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53072 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhH3Q2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:28:17 -0400
Message-ID: <20210830162545.374070793@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630340843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CdDMKripyC5JqUdmahEtpqbvao2Su811r2SZEGw5D98=;
        b=K+vtFqyzPX7XO8cX2qzUu/dy0nj9ex9U6fdJ2pSSYeZ5HQEXLJaSg2XuI6qNt6eBr4Rr78
        0qAP1JMn1BfZ2SM0z9bMHeFnYD/qPdahqvyW3jNxARNvfd5LUlv1DLoCV0Jsrj2WEBb77s
        iG91R2o6SqTMSYiOY3xGuv7kKfkQqza0vASrVwUwsOwS8+IcPJmMo0/tBrfDxv3yAbCMnT
        whJVKvhSPX/g87h3qesL5R4oKLMTkV4waJxcHTMo0IankvAOlSUacXpJfboeSRiJnwYAWp
        ThNUhlfsZhuwH4w8p3K4XSi3RPxLxdEl8vhUNTkBbIiycPfrSHmgSrB0Dp8TKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630340843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CdDMKripyC5JqUdmahEtpqbvao2Su811r2SZEGw5D98=;
        b=6eAm/h1GqKvKl2WcbMoJrWViLCtr9gsswyOOSIf47q/z+ZNI5iJULsdR0WXQlfFVkbha4o
        9wqIGS+2UhN06LAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
References: <20210830154702.247681585@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Mon, 30 Aug 2021 18:27:22 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FPU restore from a signal frame can trigger various exceptions. The
exceptions are caught with an exception table entry. The handler of this
entry sets the error return value to the negated exception number.

Any other exception than #PF is fatal and recovery is not possible. This
relies on the fact that the #PF exception number is the same as EFAULT, but
that's not really obvious.

Check the error code for -X86_TRAP_PF instead of checking it for -EFAULT to
make it clear how that works.

There is still confusion due to the return code conversion which will be
cleaned up separately.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -13,6 +13,7 @@
 #include <asm/fpu/xstate.h>
 
 #include <asm/sigframe.h>
+#include <asm/trapnr.h>
 #include <asm/trace/fpu.h>
 
 static struct _fpx_sw_bytes fx_sw_reserved __ro_after_init;
@@ -275,7 +276,7 @@ static int restore_fpregs_from_user(void
 		fpregs_unlock();
 
 		/* Try to handle #PF, but anything else is fatal. */
-		if (ret != -EFAULT)
+		if (ret != -X86_TRAP_PF)
 			return -EINVAL;
 
 		ret = fault_in_pages_readable(buf, size);

