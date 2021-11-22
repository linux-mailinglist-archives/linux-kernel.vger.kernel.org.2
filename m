Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B214593C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 18:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbhKVRRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 12:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbhKVRRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 12:17:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9500AC061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zOirHszz+bpBnEblUbcGaSjAL3qUgtR0wowjfGjAO9U=; b=O9PpQsceSyr+UTj7br597v7WXn
        Re2bO6kt+t2ZXIl430OI32rNhUwnycUUVb2kHQYT/SESGK20BH0jQyw5QF7AZ0ehiamPl7P0vc8N8
        vr/j41WiAq5jHfAWzJeV2FN+5C4W/JKwnPrJqVquht3dy0dcuCAFyG9HCpk11TZ389pmH3bMqKI/F
        BpzYaav4jkImznDDSwp1M+UmlFFm1RHHg0nwLPuX/sYfhnt/WTLrNOPkQS94V8I1UMoqRoBbQHXUR
        hJNhFJgbfgylFGF56C0YkCV95Ow11SU+zG4nl6GhA28XDd39u+viR+C6muo8ZFFk/aXvhsgfHWENz
        /3bwEr1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpCtF-00HWQN-SU; Mon, 22 Nov 2021 17:14:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1324230070C;
        Mon, 22 Nov 2021 18:13:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EEB3A2C1F3778; Mon, 22 Nov 2021 18:13:58 +0100 (CET)
Message-ID: <20211122170805.149482391@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 22 Nov 2021 18:03:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com
Subject: [RFC][PATCH 3/6] x86: Add ENDBR to IRET-to-Self
References: <20211122170301.764232470@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRET-to-Self chunks trigger forward code references without ENDBR,
fix that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S        |    2 ++
 arch/x86/include/asm/sync_core.h |    2 ++
 2 files changed, 4 insertions(+)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -39,6 +39,7 @@
 #include <asm/trapnr.h>
 #include <asm/nospec-branch.h>
 #include <asm/fsgsbase.h>
+#include <asm/ibt.h>
 #include <linux/err.h>
 
 #include "calling.h"
@@ -1309,6 +1310,7 @@ SYM_CODE_START(asm_exc_nmi)
 	iretq			/* continues at repeat_nmi below */
 	UNWIND_HINT_IRET_REGS
 1:
+	ENDBR
 #endif
 
 repeat_nmi:
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -6,6 +6,7 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/special_insns.h>
+#include <asm/ibt.h>
 
 #ifdef CONFIG_X86_32
 static inline void iret_to_self(void)
@@ -34,6 +35,7 @@ static inline void iret_to_self(void)
 		"pushq $1f\n\t"
 		"iretq\n\t"
 		"1:"
+		ASM_ENDBR
 		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
 }
 #endif /* CONFIG_X86_32 */


