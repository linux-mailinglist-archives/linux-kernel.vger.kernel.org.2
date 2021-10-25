Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491DB439909
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbhJYOuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbhJYOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:49:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515C8C061746
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9zTZKotE/06dWTi4W5P4OMa0jVpcFau6Zrykd6qrN8Y=; b=ju+l9zGCwvhF5vAjglxCk0/Xyw
        OWWEctEESmPjf1rmdmpZAOqHFgZuZLKtVWxQ9vE9W6grH7d4bsAnYZKXDDu6B96VaYVXY+eZsEIGD
        cwTwaZEO93lyTO4CZaIl7m0sxvq5GR+AWhMrx2t20artkGBR9MP5zHbEMH1mnLf7kRoPbK2doJzV9
        EGIE36pAo3/SDr59mmt/6YJ8VwHA9l+wb86OX/4dCbZauxGVPJ/M3jkBY5CLYayEjeArcPIGdN1ES
        z8m0TaWGQC6sVh6VMbxDkHkY/Ws14Dcg9naqW/x9Okpk5c+hHeEkQMRSkc2eBMFeeYMghP/eE8zvR
        YBsd4eJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf1DR-00GByd-6o; Mon, 25 Oct 2021 14:45:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3F2E3003A9;
        Mon, 25 Oct 2021 16:44:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB17F29DEC081; Mon, 25 Oct 2021 16:44:44 +0200 (CEST)
Date:   Mon, 25 Oct 2021 16:44:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
Message-ID: <YXbC3NRWDDfsW6DG@hirez.programming.kicks-ass.net>
References: <20211025122102.46089-1-frederic@kernel.org>
 <20211025122102.46089-3-frederic@kernel.org>
 <YXa3q2AOH0T+smFy@hirez.programming.kicks-ass.net>
 <CAMj1kXELqoVp5zBcQ8g+0O56sBq9qAEDO-7OTenDkpRcb7oeQQ@mail.gmail.com>
 <YXa85OTw7i3Bg9yj@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXa85OTw7i3Bg9yj@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 04:19:16PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 25, 2021 at 04:08:37PM +0200, Ard Biesheuvel wrote:

> > > Ooohh, but what if you go from !func to NOP.
> > >
> > > assuming:
> > >
> > >         .literal = 0
> > >         BTI C
> > >         RET
> > >
> > > Then
> > >
> > >         CPU0                    CPU1
> > >
> > >         [S] literal = func      [I] NOP
> > >         [S] insn[1] = NOP       [L] x16 = literal (NULL)
> > >                                 b x16
> > >                                 *BANG*
> > >
> > > Is that possible? (total lack of memory ordering etc..)
> > >
> > 
> > The CBZ will branch to the RET instruction if x16 == 0x0, so this
> > should not happen.
> 
> Oooh, I missed that :/ I was about to suggest writing the address of a
> bare 'ret' trampoline instead of NULL into the literal.

Perhaps a little something like so.. Shaves 2 instructions off each
trampoline.

--- a/arch/arm64/include/asm/static_call.h
+++ b/arch/arm64/include/asm/static_call.h
@@ -11,9 +11,7 @@
 	    "	hint 	34	/* BTI C */				\n" \
 		insn "							\n" \
 	    "	ldr	x16, 0b						\n" \
-	    "	cbz	x16, 1f						\n" \
 	    "	br	x16						\n" \
-	    "1:	ret							\n" \
 	    "	.popsection						\n")
 
 #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -90,6 +90,11 @@ int __kprobes aarch64_insn_write(void *a
 	return __aarch64_insn_write(addr, &i, AARCH64_INSN_SIZE);
 }
 
+asm("__static_call_ret:		\n"
+    "	ret			\n")
+
+extern void __static_call_ret(void);
+
 void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 {
 	/*
@@ -97,9 +102,7 @@ void arch_static_call_transform(void *si
 	 *  0x0	bti c		<--- trampoline entry point
 	 *  0x4	<branch or nop>
 	 *  0x8	ldr x16, <literal>
-	 *  0xc	cbz x16, 20
-	 * 0x10	br x16
-	 * 0x14	ret
+	 *  0xc	br x16
 	 */
 	struct {
 		u64	literal;
@@ -113,6 +116,7 @@ void arch_static_call_transform(void *si
 	insns.insn[0] = cpu_to_le32(insn);
 
 	if (!func) {
+		insns.literal = (unsigned long)&__static_call_ret;
 		insn = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_LR,
 						   AARCH64_INSN_BRANCH_RETURN);
 	} else {
