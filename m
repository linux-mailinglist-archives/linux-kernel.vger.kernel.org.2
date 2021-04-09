Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA8B359FA3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhDINOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbhDINOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:14:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A07EC061760;
        Fri,  9 Apr 2021 06:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ODdLGt0xKOkWY8w0Qmu5rwQh5fXIPCvtEKbmytPnJKY=; b=ZQa1uSmz+v3gZReZDrhdCTluuN
        cBmmo+dtfk4MwHzL0ABFrO0lcfNieE3qDcX8AB7dYTEYnYrTtekAcL9hVouqJAnM38gpjwFoMLkEF
        cIrw4SbVfyPnWD1EvtmhHiZVXdBfP8g5wNzPnIhbNrawwPadiryNfPtSErXWzz64GIPTL5sZORBIH
        e9dyD/OKKi0oNEWXJMaIaWv9k2gn4f/iC77E9y6DZEjr1OgJfft4BfubnwRiyDaEXDGPYezeOkPsU
        YNmL9ESWZ7XJmg3nabA9oqYeU3gmkU9/USyuIhvM52BHe17Z5FlNLNlfnln3dbAlxnjj9FcLm8YZ9
        R5ChKzBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUqwp-000PZY-Ss; Fri, 09 Apr 2021 13:13:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7CA52300084;
        Fri,  9 Apr 2021 15:13:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 588512C255671; Fri,  9 Apr 2021 15:13:19 +0200 (CEST)
Date:   Fri, 9 Apr 2021 15:13:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Malcolm <dmalcolm@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <YHBS70ZQ6gOpMk2K@hirez.programming.kicks-ass.net>
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
 <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
 <YHA2jPIaj0p23mv8@hirez.programming.kicks-ass.net>
 <5f78b7e2f9ae937271ef52ee9e999a91c2719da9.camel@redhat.com>
 <YHBCoijoopbsDn29@hirez.programming.kicks-ass.net>
 <YHBQPr8q0cx4iUfN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHBQPr8q0cx4iUfN@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 03:01:50PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 09, 2021 at 02:03:46PM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 09, 2021 at 07:55:42AM -0400, David Malcolm wrote:
> 
> > > Sorry if this is a dumb question, but does the function attribute:
> > >   __attribute__ ((pure)) 
> > > help here?  It's meant to allow multiple calls to a predicate to be
> > > merged - though I'd be nervous of using it here, the predicate isn't
> > > 100% pure, since AIUI the whole point of what you've built is for
> > > predicates that very rarely change - but can change occasionally.
> > 
> > I actually tried that, but it doesn't seem to work. Given the function
> > arguments are all compile time constants it should DTRT AFAICT, but
> > alas.
> 
> FWIW, I tried the below patch and GCC-10.2.1 on current tip/master.

I also just tried __attribute__((__const__)), which is stronger still
than __pure__ and that's also not working :/

I then also tried to replace the __buildin_types_compatible_p() magic in
static_branch_unlikely() with _Generic(), but still no joy.


---
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 610a05374c02..f14c6863b911 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -14,7 +14,7 @@
 #include <linux/stringify.h>
 #include <linux/types.h>
 
-static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
+static __always_inline __attribute_const__ bool arch_static_branch(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"
 		".byte " __stringify(BYTES_NOP5) "\n\t"
@@ -30,7 +30,7 @@ static __always_inline bool arch_static_branch(struct static_key * const key, co
 	return true;
 }
 
-static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
+static __always_inline __attribute_const__ bool arch_static_branch_jump(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"
 		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 05f5554d860f..2c250d8b9a02 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -195,12 +195,12 @@ struct module;
 #define JUMP_TYPE_LINKED	2UL
 #define JUMP_TYPE_MASK		3UL
 
-static __always_inline bool static_key_false(struct static_key *key)
+static __always_inline __attribute_const__ bool static_key_false(struct static_key * const key)
 {
 	return arch_static_branch(key, false);
 }
 
-static __always_inline bool static_key_true(struct static_key *key)
+static __always_inline __attribute_const__ bool static_key_true(struct static_key * const key)
 {
 	return !arch_static_branch(key, true);
 }
@@ -466,6 +466,18 @@ extern bool ____wrong_branch_error(void);
  * See jump_label_type() / jump_label_init_type().
  */
 
+#if 1
+
+#define static_branch_likely(x)	_Generic(*(x),					\
+	struct static_key_true:	!arch_static_branch(&(x)->key, true),		\
+	struct static_key_false: !arch_static_branch_jump(&(x)->key, true))
+
+#define static_branch_unlikely(x) _Generic(*(x),				\
+	struct static_key_true:	arch_static_branch_jump(&(x)->key, false),	\
+	struct static_key_false: arch_static_branch(&(x)->key, false))
+
+#else
+
 #define static_branch_likely(x)							\
 ({										\
 	bool branch;								\
@@ -490,6 +502,8 @@ extern bool ____wrong_branch_error(void);
 	unlikely_notrace(branch);							\
 })
 
+#endif
+
 #else /* !CONFIG_JUMP_LABEL */
 
 #define static_branch_likely(x)		likely_notrace(static_key_enabled(&(x)->key))
