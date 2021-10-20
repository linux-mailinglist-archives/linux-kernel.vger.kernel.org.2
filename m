Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EB1434997
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhJTLDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhJTLDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:03:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B504CC061746
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=B9SZ0h1lg4I5PZy9/1adb4GVp6aVKaUKbdGfQuEk928=; b=kC9uLcdVqiIqLFG282wZJX6xSn
        7pIYLyTzWHCDX14M4IE6Nv0gdMXPlwSaS0nraGPNMUbEjsIN+FQoP4kiM0Y6Vs/rENOTjIxmrXN1Z
        eHfIOSzztcwPf42j4ueyMXm+bwO5Gq/PCjrYnytOy29LwYyBogOz7FGwxoPQc90zngFK343LJ61Yn
        H6GOq8kDhwbOAiUXVwEa81DFgu17d3YtctuNma4Lh+AY8sp5yY4Y+NYjOVRvlY7dTccGfRIF9cF5S
        z0ncWkanYmlkeoVEsxN0k88vlGOJFdxEI+Eh7BNl1fs07Ge9IWP8R1SDUhWNZW8xpjaDJzlTrqM6a
        4MbKWQ6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9L1-00Aw16-H1; Wed, 20 Oct 2021 11:00:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2828230073F;
        Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F29AC201BB3CC; Wed, 20 Oct 2021 13:00:49 +0200 (CEST)
Message-ID: <20211020105842.920391949@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 20 Oct 2021 12:44:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH v2 07/14] x86/asm: Fixup odd GEN-for-each-reg.h usage
References: <20211020104442.021802560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently GEN-for-each-reg.h usage leaves GEN defined, relying on any
subsequent usage to start with #undef, which is rude.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/asm-prototypes.h |    6 +++---
 arch/x86/lib/retpoline.S              |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -19,19 +19,19 @@ extern void cmpxchg8b_emu(void);
 
 #ifdef CONFIG_RETPOLINE
 
-#undef GEN
 #define GEN(reg) \
 	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
 #include <asm/GEN-for-each-reg.h>
-
 #undef GEN
+
 #define GEN(reg) \
 	extern asmlinkage void __x86_indirect_alt_call_ ## reg (void);
 #include <asm/GEN-for-each-reg.h>
-
 #undef GEN
+
 #define GEN(reg) \
 	extern asmlinkage void __x86_indirect_alt_jmp_ ## reg (void);
 #include <asm/GEN-for-each-reg.h>
+#undef GEN
 
 #endif /* CONFIG_RETPOLINE */
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -55,10 +55,10 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 #define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
 #define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
 
-#undef GEN
 #define GEN(reg) THUNK reg
 #include <asm/GEN-for-each-reg.h>
-
 #undef GEN
+
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
+#undef GEN


