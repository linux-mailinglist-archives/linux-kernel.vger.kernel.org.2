Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37417447D4A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhKHKLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhKHKLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:11:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DFAC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5TP6wWhpgPVEkA3TsjVQnhtqFfZ4XssB8CseC+DQ6CI=; b=cWJR2ikZKkDvMN4ptq85OMr01r
        HXDoOwoLhFG5ixYOULxhc2qQacei1ooewjYQbrPWAcm35wKklRFubD3kG9pr/Jd6tnUZmRlqfLPWT
        47YhcSajQfcp3ZIxrFUVxmCF0rIjWH6c0ZyQEsSzKmJrrvKMGL6Q91iKghxogfWA65wZ+b1KmBakT
        bp6x0zNYRIEcSZ5WNCkpZgezZ6OGaCaJvNgLg8oXopOolQucPTVzt0t5S7z1/JoZ3yNlXJoJurMQU
        QMJ61yFibQKKp6cACwVyDAc50c85LILi9CSjhGwgAaviy+AuiHGzPLZOv9suKShjRkE5lmdZ3Sh+B
        RVdbSS4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk1ZP-00ErcZ-El; Mon, 08 Nov 2021 10:08:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D204230022C;
        Mon,  8 Nov 2021 11:08:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7616C2D38726D; Mon,  8 Nov 2021 11:08:04 +0100 (CET)
Date:   Mon, 8 Nov 2021 11:08:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v6 1/2] static_call: use non-function types to refer to
 the trampolines
Message-ID: <YYj3BMbuP/mkPAIn@hirez.programming.kicks-ass.net>
References: <20211105145917.2828911-1-ardb@kernel.org>
 <20211105145917.2828911-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105145917.2828911-2-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 03:59:16PM +0100, Ard Biesheuvel wrote:
> In order to prevent CFI enabled code from grabbing a jump table entry
> that jumps to the trampoline, rather than the trampoline itself, use an
> incomplete non-function type for the trampoline, and cast it to the
> right type only when invoking it.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Very grudingly:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  include/linux/static_call.h       |  4 ++--
>  include/linux/static_call_types.h | 11 ++++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> index 3e56a9751c06..616607393273 100644
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -151,7 +151,7 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
>  
>  #define static_call_update(name, func)					\
>  ({									\
> -	typeof(&STATIC_CALL_TRAMP(name)) __F = (func);			\
> +	typeof(&STATIC_CALL_TYPE(name)) __F = (func);			\
>  	__static_call_update(&STATIC_CALL_KEY(name),			\
>  			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
>  })
> @@ -306,7 +306,7 @@ static inline void __static_call_nop(void) { }
>  	void *func = READ_ONCE(STATIC_CALL_KEY(name).func);		\
>  	if (!func)							\
>  		func = &__static_call_nop;				\
> -	(typeof(STATIC_CALL_TRAMP(name))*)func;				\
> +	(typeof(&STATIC_CALL_TYPE(name)))func;				\
>  })
>  
>  #define static_call_cond(name)	(void)__static_call_cond(name)
> diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
> index 5a00b8b2cf9f..5e658ef537e4 100644
> --- a/include/linux/static_call_types.h
> +++ b/include/linux/static_call_types.h
> @@ -18,6 +18,9 @@
>  #define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
>  #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
>  
> +#define STATIC_CALL_TYPE_PREFIX		__SCtype__
> +#define STATIC_CALL_TYPE(name)		__PASTE(STATIC_CALL_TYPE_PREFIX, name)
> +
>  /*
>   * Flags in the low bits of static_call_site::key.
>   */
> @@ -36,11 +39,13 @@ struct static_call_site {
>  
>  #define DECLARE_STATIC_CALL(name, func)					\
>  	extern struct static_call_key STATIC_CALL_KEY(name);		\
> -	extern typeof(func) STATIC_CALL_TRAMP(name);
> +	extern struct static_call_tramp STATIC_CALL_TRAMP(name);	\
> +	extern typeof(func) STATIC_CALL_TYPE(name)
>  
>  #ifdef CONFIG_HAVE_STATIC_CALL
>  
> -#define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
> +#define __raw_static_call(name)						\
> +	((typeof(&STATIC_CALL_TYPE(name)))&STATIC_CALL_TRAMP(name))
>  
>  #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
>  
> @@ -96,7 +101,7 @@ struct static_call_key {
>  };
>  
>  #define static_call(name)						\
> -	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
> +	((typeof(&STATIC_CALL_TYPE(name)))(STATIC_CALL_KEY(name).func))
>  
>  #endif /* CONFIG_HAVE_STATIC_CALL */
>  
> -- 
> 2.30.2
> 
