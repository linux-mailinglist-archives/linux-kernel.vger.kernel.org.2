Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A473B6947
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbhF1Ts3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236432AbhF1Ts1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:48:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA4B061CA1;
        Mon, 28 Jun 2021 19:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624909562;
        bh=GIsAOsOlZwmkiVWrdlHO/oPzADy/yO9yVmM1KN/GG3g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jwf8DgqEM/Z/H3zx4e7zaIlwO9qfoBmyRLwzRXltJ9ttwzg6s9G9TE10Hp0MieXBU
         Rd96lYRUjfOA4U1pjDRHO/VDh+UbQQ1JNHdO+T04yMghZQfTwmFwTkSjN4AQ2H2Whp
         8PusfVCYM2htMrYc/r7EOOjFRkGh+2C8hb1pMWx7vYZyZ076hX/evA0GaqGCr9UDGJ
         mCcPpKYWCOH/TKDuH4mTfOjCwlfmIY9VR7CHztvYnKZydiP6bIzwPPT1HeHPei6ApF
         Sy9mzIs9kwk215+3FkHYbFWPBEvQ4E1821+1TJCnwwhHhX1LfOFc6oPvZs/uqjhEgt
         wD4vb0JWvyPTw==
Subject: Re: [PATCH v2] kallsyms: strip LTO suffixes from static functions
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Fangrui Song <maskray@google.com>, "KE . LI" <like1@oppo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210622201822.ayavok3d2fw3u2pl@google.com>
 <20210628190509.2486992-1-ndesaulniers@google.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <a970613b-014f-be76-e342-4a51e792b56d@kernel.org>
Date:   Mon, 28 Jun 2021 12:45:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628190509.2486992-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/2021 12:05 PM, 'Nick Desaulniers' via Clang Built Linux wrote:
> Similar to:
> commit 8b8e6b5d3b01 ("kallsyms: strip ThinLTO hashes from static
> functions")
> 
> It's very common for compilers to modify the symbol name for static
> functions as part of optimizing transformations. That makes hooking
> static functions (that weren't inlined or DCE'd) with kprobes difficult.
> 
> LLVM has yet another name mangling scheme used by thin LTO.  Strip off
> these suffixes so that we can continue to hook such static functions.
> 
> Reported-by: KE.LI(Lieke) <like1@oppo.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes v1 -> v2:
> * Both mangling schemes can occur for thinLTO + CFI, this new scheme can
>    also occur for thinLTO without CFI. Split cleanup_symbol_name() into
>    two function calls.
> * Drop KE.LI's tested by tag.
> * Do not carry Fangrui's Reviewed by tag.
> * Drop the inline keyword; it is meaningless.
> 
>   kernel/kallsyms.c | 33 +++++++++++++++++++++++++++++----
>   1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 4067564ec59f..fbce4a1ec700 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -171,14 +171,30 @@ static unsigned long kallsyms_sym_address(int idx)
>   	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
>   }
>   
> -#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
> +#ifdef CONFIG_LTO_CLANG_THIN
> +/*
> + * LLVM appends a suffix for local variables that must be promoted to global
> + * scope as part of thin LTO. foo() becomes foo.llvm.974640843467629774. This
> + * can break hooking of static functions with kprobes.
> + */
> +static bool cleanup_symbol_name_thinlto(char *s)
> +{
> +	char *res;
> +
> +	res = strstr(s, ".llvm.");
> +	if (res)
> +		*res = '\0';
> +
> +	return res != NULL;
> +}
> +#ifdef CONFIG_CFI_CLANG
>   /*
>    * LLVM appends a hash to static function names when ThinLTO and CFI are
>    * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
>    * This causes confusion and potentially breaks user space tools, so we
>    * strip the suffix from expanded symbol names.
>    */
> -static inline bool cleanup_symbol_name(char *s)
> +static bool cleanup_symbol_name_thinlto_cfi(char *s)
>   {
>   	char *res;
>   
> @@ -189,8 +205,17 @@ static inline bool cleanup_symbol_name(char *s)
>   	return res != NULL;
>   }
>   #else
> -static inline bool cleanup_symbol_name(char *s) { return false; }
> -#endif
> +static bool cleanup_symbol_name_thinlto_cfi(char *s) { return false; }
> +#endif /* CONFIG_CFI_CLANG */
> +#else
> +static bool cleanup_symbol_name_thinlto(char *s) { return false; }
> +#endif /* CONFIG_LTO_CLANG_THIN */
> +
> +static bool cleanup_symbol_name(char *s)
> +{
> +	return cleanup_symbol_name_thinlto(s) &&
> +		cleanup_symbol_name_thinlto_cfi(s);

Won't this be a build error when CONFIG_LTO_CLANG_THIN=n and 
CONFIG_CFI_CLANG=n because cleanup_symbol_name_thinlto_cfi() will not be 
defined? Should the cleanup_symbol_name_thinlto_cfi() stub be in the 
last else block?

Cheers,
Nathan

> +}
>   
>   /* Lookup the address for this symbol. Returns 0 if not found. */
>   unsigned long kallsyms_lookup_name(const char *name)
> 
