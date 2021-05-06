Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65A4375BE8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbhEFTo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbhEFTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06531C0613ED
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kFfqEufoIQb0/o5iFIo5FIoTlMfJ/zwdMcpq4uS6qSs=; b=hq8qP9rmExfa7s3B5OVsv6VyQw
        EEvAGibZ2qBKj9IHdFFTttrGz2g3Dv3ZZdbrHeBuXH/zFTyVnXs6xxCnIB5+GD+MFqMy+z/rHXrOG
        K8FUn6jGRTSplDLkzTI7kQqC8yKl0AEjBQQeTZpddQnrEb6cc8I0L3cbInbgMjYXqCD6VX13fSnjv
        xHftAlcBtIPe+9jlbUK68qAr0K7IgFFZCswkCI9NQZyvHuRPuOZTeiS7U3LLV3NXwPoSxhrkCVFIq
        Rvf+QHlu1cx+8doYyDr9nP4AANGvrPwGA/oNTybPq+/tOzLHnEDG0UXkIIVfLxnswsk/8bvkJOkv3
        atR8B9/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lejtT-002ADI-VR; Thu, 06 May 2021 19:42:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 296DF300391;
        Thu,  6 May 2021 21:42:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DC65B20B96F96; Thu,  6 May 2021 21:42:38 +0200 (CEST)
Message-ID: <20210506194158.216763632@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 06 May 2021 21:34:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 13/13] jump_label,x86: Allow short NOPs
References: <20210506193352.719596001@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that objtool is able to rewrite jump_label instructions, have the
compiler emit a JMP, such that it can decide on the optimal encoding,
and set jump_entry::key bit1 to indicate that objtool should rewrite
the instruction to a matching NOP.

For x86_64-allyesconfig this gives:

jl\     NOP     JMP
short:  22997   124
long:   30874   90

IOW, we save (22997+124) * 3 bytes of kernel text in hotpaths.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/jump_label.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -28,6 +28,22 @@
 	_ASM_PTR "%c0 + %c1 - .\n\t"			\
 	".popsection \n\t"
 
+#ifdef CONFIG_STACK_VALIDATION
+
+static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
+{
+	asm_volatile_goto("1:"
+		"jmp %l[l_yes] # objtool NOPs this \n\t"
+		JUMP_TABLE_ENTRY
+		: :  "i" (key), "i" (2 | branch) : : l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+#else
+
 static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"
@@ -40,6 +56,8 @@ static __always_inline bool arch_static_
 	return true;
 }
 
+#endif /* STACK_VALIDATION */
+
 static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"


