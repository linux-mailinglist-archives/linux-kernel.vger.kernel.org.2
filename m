Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E729C3FEECA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345202AbhIBNhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbhIBNhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:37:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FA0C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8kfa2MKsmdYOUiNk6rN0IvGLIhZHes/AMFeLSQWuYHA=; b=PfATckDjjptioxTfeHiEZczFL/
        I5rl1uFWFUeXeMBDcdf5/ud9+5NWGoJBvyaE62PKpOITWoATBh0SIWRIiC9ZmwUPPhKLwEhbcKERR
        AxFKO9w3LSFltE+WNbxzmZ+im+o0mxn1eOPmU/WRcjAHy0svkpGEGNGAoJwrgqWT/E08xcHpnxMwS
        alP3HbilnLcrHC540OqrrRvjMV1LDZZgs5QVVb3OO9JKbxF5drwQoWojJA10aRHetrRXGu7nLDnQm
        d13frlp5WQHQG7/GzA6FcNIlCVfsXKnboNudHtjWd+KN0imFnP2F8p+SXS+D8sSxfBmrwBnAaN5n/
        Jl1OF4tQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLmro-003Vud-PH; Thu, 02 Sep 2021 13:35:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A90EF300332;
        Thu,  2 Sep 2021 15:34:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9586125D6898D; Thu,  2 Sep 2021 15:34:54 +0200 (CEST)
Date:   Thu, 2 Sep 2021 15:34:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>, Juergen Gross <jgross@suse.com>,
        andrew.cooper3@citrix.com, ndesaulniers@google.com
Subject: Re: [PATCH 02/24] x86/traps: Move arch/x86/kernel/traps.c to
 arch/x86/entry/
Message-ID: <YTDS/p/bnsTFzNES@hirez.programming.kicks-ass.net>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-3-jiangshanlai@gmail.com>
 <YTCGov+vvAMvso7q@suse.de>
 <1f327579-e62a-df65-0763-e88243829db3@linux.alibaba.com>
 <YTCsWpSmPYvXa1xz@hirez.programming.kicks-ass.net>
 <4c589fef-8c98-a6fc-693f-b205a7710e42@linux.alibaba.com>
 <YTC+FTo4uLLdyBxA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTC+FTo4uLLdyBxA@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 02:05:41PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 02, 2021 at 07:54:25PM +0800, Lai Jiangshan wrote:
> > For example, stack-protector is instrumenting many noninstr functions now
> > if the CONFIG is yes.  It is normally Ok and gcc is adding per-function control
> > on it.
> 
> IIRC the latest compiler have an attribute for this too, that really
> should be added to noinstr. Lemme go find.

Something like so... Nick ?

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 49b0ac8b6fd3..6a15c3d8df5c 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -62,6 +62,12 @@
 #define __no_sanitize_coverage
 #endif
 
+#if defined(CONFIG_STACKPROTECTOR)
+#define __no_stack_protector __attribute__((no_stack_protector))
+#else
+#define __no_stack_protector
+#endif
+
 /*
  * Not all versions of clang implement the type-generic versions
  * of the builtin overflow checkers. Fortunately, clang implements
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index cb9217fc60af..7ac0a3f11ba9 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -128,6 +128,12 @@
 #define __no_sanitize_coverage
 #endif
 
+#if defined(CONFIG_STACKPROTECTOR) && __has_attribute__(__no_stack_protector__)
+#define __no_stack_protector __attribute__((no_stack_protector))
+#else
+#define __no_stack_protector
+#endif
+
 #if GCC_VERSION >= 50100
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e4ea86fc584d..5ae1c08dba8d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -210,7 +210,8 @@ struct ftrace_likely_data {
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
 	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
+	__no_stack_protector
 
 #endif /* __KERNEL__ */
 
