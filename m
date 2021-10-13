Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABE142CC7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJMVFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJMVFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:05:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAB1C061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LRqwGSwuKXO3H+yVf+j+z5vryNIn+pjozeW1SKMDOdQ=; b=vwosMkHu6LECB+q5x6QBh4OKTd
        Kne2UFVm7lVemdIM74XhWZLMjBpCB4f3DM58moaudiXpQ7ChC4Zvz9ktYSFYuScFHgPO8dHdq86dX
        o+H1Q4BVscJdHupZKI8NVF24dcuv3mzZRd08OdwpDDMjiStrTpbSAWb4bzMNFWwWK6c/uhxYa5480
        rlhduDNBdMO140tDhuVVDFpsLk6rwoUj0uSxZX8lvalpjNE16XixC9OUqcVQgb2T8lkOYquRXl3G/
        KSawRF9rxnG+g+KKBcFnV6jQe9qyOQ13aRSDvEdgtU8rEyCf82dl29yvZYap4pFtNf3TaYf7BY9yd
        eksYeW+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1malMJ-007nmA-2s; Wed, 13 Oct 2021 21:01:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9984830030B;
        Wed, 13 Oct 2021 23:00:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7562920193AF4; Wed, 13 Oct 2021 23:00:15 +0200 (CEST)
Date:   Wed, 13 Oct 2021 23:00:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <YWdI31noOUQVSA6w@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <20211013205259.44cvvaxiexiff5w5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013205259.44cvvaxiexiff5w5@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 01:52:59PM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 13, 2021 at 02:22:21PM +0200, Peter Zijlstra wrote:
> >  	/*
> > +	 * Rewrite the retpolines, must be done before alternatives since
> > +	 * those can rewrite the retpoline thunks.
> > +	 */
> 
> Why exactly is that a problem?  This code doesn't read the thunks.

The below problem :-) I didn't include it in the series, but I'm
thinking that's where I wants to go eventually.

---
Subject: x86,retpoline: Poison retpoline thunks for !X86_FEATURE_RETPOLINE
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Oct 12 10:30:56 CEST 2021

Now that objtool will out-of-line all retpoline thunk calls for
!RETPOLINE, poison them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/retpoline.S |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -32,9 +32,19 @@
 
 SYM_FUNC_START(__x86_indirect_thunk_\reg)
 
+#ifdef CONFIG_STACK_VALIDATION
+/*
+ * When objtool runs, there should not be any __x86_indirect_thunk_* calls
+ * left after alternatives, ensure this by patching it to UD2.
+ */
+	ALTERNATIVE_2 __stringify(RETPOLINE \reg), \
+		      __stringify(ud2), ALT_NOT(X86_FEATURE_RETPOLINE), \
+		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
+#else
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
 		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
 		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
+#endif
 
 SYM_FUNC_END(__x86_indirect_thunk_\reg)
 
