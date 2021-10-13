Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE53042C04C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhJMMov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbhJMMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:44:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCF7C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BHufXlydcA+e/J1i+oz2BTUx2pH1zGwuIbU9laghguk=; b=TqVlZWcTlsj5iL1KgalNSCg1OG
        8rwY66qZA4Gu0lX5Mp9LYF97qAasN8MJ8sgxBy1E8JyG8/f/wT7Pk/9N73vvhvKDksHcOGerO74QG
        0s2kmfgUVij1TMv8yuBM3XFBTwoYmiEod16ja2ko5m/NWDrqc9h8AVkd2bkhPlQBfWHSrDRwWRkyh
        ZaQEZIB2n2k12mtqq8ihEHQpVJFpuvw+4QaJl5un4AOk42f1M4g/g3WlUpLXo0zX7wSjtUAZCnkLr
        QLyA4yNYk+vOUDoWpJBF7U/fs9MqPSpICyR2Gmb56nVRQdnSQhEJB5K6c5JAoQTwYLEt0AWmaWHHM
        rrAA8Hng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1madYM-007QZU-I6; Wed, 13 Oct 2021 12:40:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2176130077A;
        Wed, 13 Oct 2021 14:40:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D305E20D89521; Wed, 13 Oct 2021 14:40:13 +0200 (CEST)
Message-ID: <20211013123645.706163435@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 13 Oct 2021 14:22:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH 9/9] bpf,x86: Respect X86_FEATURE_RETPOLINE*
References: <20211013122217.304265366@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current BPF codegen doesn't respect X86_FEATURE_RETPOLINE* flags and
unconditionally emits a thunk call, this is sub-optimal and doesn't
match the regular, compiler generated, code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/net/bpf_jit_comp.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2123,14 +2123,18 @@ static int emit_fallback_jump(u8 **pprog
 	int err = 0;
 
 #ifdef CONFIG_RETPOLINE
-	/* Note that this assumes the the compiler uses external
-	 * thunks for indirect calls. Both clang and GCC use the same
-	 * naming convention for external thunks.
-	 */
-	err = emit_jump(&prog, __x86_indirect_thunk_rdx, prog);
-#else
-	EMIT2(0xFF, 0xE2);	/* jmp rdx */
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+		if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD)) {
+			/* The AMD retpoline can be easily emitted inline. */
+			EMIT3(0x0F, 0xAE, 0xE8);	/* lfence */
+			EMIT2(0xFF, 0xE2);		/* jmp rdx */
+		} else {
+			/* Call the retpoline thunk */
+			err = emit_jump(&prog, __x86_indirect_thunk_rdx, prog);
+		}
+	} else
 #endif
+	EMIT2(0xFF, 0xE2);	/* jmp rdx */
 	*pprog = prog;
 	return err;
 }


