Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232763F74F0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbhHYMT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbhHYMT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:19:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E43C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 05:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j58vJa1yyCGC8B7ocrEm5VQCweho0YuWJUtQ5No+Oko=; b=fsTTwaPnJTmvgxn9bBSCfuQznW
        +QccneTlX+8yqXvNGNObJL/w/vL5ooDXsFM3UPmXjLNJT4a5RMJzbhGnXkRJFl1aXMCls2F/GhODd
        Q6fXXzSKgwxfHchVeh6pEZ3u/7n2VWOKPf7HQm+Myh0fHk7tq0X83ZO/EmnVkgwWmlmErU8VrRkJ/
        VIrgffsBqdatm4Ij6DbnamOCw3oEx1ks+YZd92T+wuvixn+oGr2Sgwm3X6pT0oTCbsE/21j3f3XE+
        9MJ6OebERjw0UR4ylVDa6jxzjnEFjmre3p9Qa61pJqdELQD6nOYNFftO9/4eDF1ke0BEWNPplr8jZ
        SIXwbS2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIrp5-00CHKu-Cd; Wed, 25 Aug 2021 12:16:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABF333005AD;
        Wed, 25 Aug 2021 14:16:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C26A20C92CB9; Wed, 25 Aug 2021 14:16:01 +0200 (CEST)
Date:   Wed, 25 Aug 2021 14:16:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com, sam@ravnborg.org, masahiroy@kernel.org,
        hca@linux.ibm.com, nickhu@andestech.com, vgupta@kernel.org
Subject: Re: [PATCH v2 06/24] x86: Always inline
 context_tracking_guest_enter()
Message-ID: <YSY0gSLyTL3kIfP8@hirez.programming.kicks-ass.net>
References: <20210624094059.886075998@infradead.org>
 <20210624095148.003928226@infradead.org>
 <20210820232203.nmuc3gelzsazyewk@treble>
 <20210820233440.jjzdw6qjnytonlmv@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820233440.jjzdw6qjnytonlmv@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 04:34:40PM -0700, Josh Poimboeuf wrote:

> WARNING: This patch may shrink your patch set and improve your sanity.

I'll go rebuild me some kernels to see how many __always_inline things I
can drop.

Lets add a few Cc's though.

> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] kbuild: Remove CONFIG_DEBUG_SECTION_MISMATCH
> 
> Modpost's section mismatch detection warns when a non-init function
> references an __init function.  The warning is needed because __init
> memory is freed during boot, so the non-init function might end up
> calling into some random memory.
> 
> CONFIG_DEBUG_SECTION_MISMATCH is intended to root out more of these
> issues by adding the -fno-inline-functions-called-once compiler flag,
> which forces once-called static functions to not be inlined.  As
> described in the option's help description:
> 
>   - Add the option -fno-inline-functions-called-once to gcc commands.
>     When inlining a function annotated with __init in a non-init
>     function, we would lose the section information and thus
>     the analysis would not catch the illegal reference.
>     This option tells gcc to inline less (but it does result in
>     a larger kernel).
> 
> It's true that if an __init function is inlined in a non-init function,
> it's no longer __init.  But that's not actually a problem.
> 
> If an inlined __init function doesn't access any other __init functions
> or data, the inlining is harmless.
> 
> If the inlined __init function does access other __init functions/data,
> __init relocations will be generated for a non-init section, and
> modpost's section mismatch detection will discover it.
> 
> So the option isn't actually useful.  It's not even useful for finding
> issues on other configs, which might have different inlining decisions,
> because with -O2, once-called static functions are always inlined.  And
> anyway, nowadays we have build bots everywhere, which are great at
> finding such edge cases.
> 
> I get the feeling this option has been responsible for dozens of
> "convert inline to __always_inline" patches over the years.  Such
> patches usually complain about the compiler's inlining decisions being
> unpredictable.  Turns out the culprit is this
> CONFIG_DEBUG_SECTION_MISMATCH option, at least for once-called
> functions.
> 
> This option really has no benefits, and only drawbacks, causing needless
> churn.  Remove it.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  Makefile                                      |  5 -----
>  arch/arc/configs/tb10x_defconfig              |  1 -
>  arch/nds32/configs/defconfig                  |  1 -
>  arch/s390/configs/debug_defconfig             |  1 -
>  arch/s390/configs/defconfig                   |  1 -
>  lib/Kconfig.debug                             | 21 -------------------
>  .../selftests/wireguard/qemu/debug.config     |  1 -
>  7 files changed, 31 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index c19d1638da25..195d4f4914e3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -913,11 +913,6 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
>  KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
>  endif
>  
> -# We trigger additional mismatches with less inlining
> -ifdef CONFIG_DEBUG_SECTION_MISMATCH
> -KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
> -endif
> -
>  ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
>  KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
>  LDFLAGS_vmlinux += --gc-sections
> diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
> index a12656ec0072..5acf8cc3e7b0 100644
> --- a/arch/arc/configs/tb10x_defconfig
> +++ b/arch/arc/configs/tb10x_defconfig
> @@ -96,7 +96,6 @@ CONFIG_STRIP_ASM_SYMS=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_HEADERS_INSTALL=y
>  CONFIG_HEADERS_CHECK=y
> -CONFIG_DEBUG_SECTION_MISMATCH=y
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_MEMORY_INIT=y
>  CONFIG_DEBUG_STACKOVERFLOW=y
> diff --git a/arch/nds32/configs/defconfig b/arch/nds32/configs/defconfig
> index f9a89cf00aa6..61b5b83bd20e 100644
> --- a/arch/nds32/configs/defconfig
> +++ b/arch/nds32/configs/defconfig
> @@ -93,7 +93,6 @@ CONFIG_GDB_SCRIPTS=y
>  CONFIG_READABLE_ASM=y
>  CONFIG_HEADERS_INSTALL=y
>  CONFIG_HEADERS_CHECK=y
> -CONFIG_DEBUG_SECTION_MISMATCH=y
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_KERNEL=y
>  CONFIG_PANIC_ON_OOPS=y
> diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
> index b88184019af9..68104f82cc9d 100644
> --- a/arch/s390/configs/debug_defconfig
> +++ b/arch/s390/configs/debug_defconfig
> @@ -782,7 +782,6 @@ CONFIG_DEBUG_INFO=y
>  CONFIG_DEBUG_INFO_DWARF4=y
>  CONFIG_GDB_SCRIPTS=y
>  CONFIG_HEADERS_INSTALL=y
> -CONFIG_DEBUG_SECTION_MISMATCH=y
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_PAGEALLOC=y
>  CONFIG_PAGE_OWNER=y
> diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
> index 1667a3cdcf0a..a5e7eb0276c6 100644
> --- a/arch/s390/configs/defconfig
> +++ b/arch/s390/configs/defconfig
> @@ -767,7 +767,6 @@ CONFIG_DYNAMIC_DEBUG=y
>  CONFIG_DEBUG_INFO=y
>  CONFIG_DEBUG_INFO_DWARF4=y
>  CONFIG_GDB_SCRIPTS=y
> -CONFIG_DEBUG_SECTION_MISMATCH=y
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_WX=y
>  CONFIG_PTDUMP_DEBUGFS=y
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index e5cdf98f50c2..93f9c00783b2 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -381,27 +381,6 @@ config HEADERS_INSTALL
>  	  user-space program samples. It is also needed by some features such
>  	  as uapi header sanity checks.
>  
> -config DEBUG_SECTION_MISMATCH
> -	bool "Enable full Section mismatch analysis"
> -	help
> -	  The section mismatch analysis checks if there are illegal
> -	  references from one section to another section.
> -	  During linktime or runtime, some sections are dropped;
> -	  any use of code/data previously in these sections would
> -	  most likely result in an oops.
> -	  In the code, functions and variables are annotated with
> -	  __init,, etc. (see the full list in include/linux/init.h),
> -	  which results in the code/data being placed in specific sections.
> -	  The section mismatch analysis is always performed after a full
> -	  kernel build, and enabling this option causes the following
> -	  additional step to occur:
> -	  - Add the option -fno-inline-functions-called-once to gcc commands.
> -	    When inlining a function annotated with __init in a non-init
> -	    function, we would lose the section information and thus
> -	    the analysis would not catch the illegal reference.
> -	    This option tells gcc to inline less (but it does result in
> -	    a larger kernel).
> -
>  config SECTION_MISMATCH_WARN_ONLY
>  	bool "Make section mismatch errors non-fatal"
>  	default y
> diff --git a/tools/testing/selftests/wireguard/qemu/debug.config b/tools/testing/selftests/wireguard/qemu/debug.config
> index fe07d97df9fa..83588bb08fde 100644
> --- a/tools/testing/selftests/wireguard/qemu/debug.config
> +++ b/tools/testing/selftests/wireguard/qemu/debug.config
> @@ -57,7 +57,6 @@ CONFIG_USER_STACKTRACE_SUPPORT=y
>  CONFIG_DEBUG_SG=y
>  CONFIG_DEBUG_NOTIFIERS=y
>  CONFIG_X86_DEBUG_FPU=y
> -CONFIG_DEBUG_SECTION_MISMATCH=y
>  CONFIG_DEBUG_PAGEALLOC=y
>  CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
>  CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> -- 
> 2.31.1
> 
