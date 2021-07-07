Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A253BEEC1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhGGShF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230481AbhGGShF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:37:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 115D961CCE;
        Wed,  7 Jul 2021 18:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625682864;
        bh=nyc7yMokQlmMv1mq9Bp2N+VPsvgWfTlOdurggJxiwlU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sM0sNH3fv4GBtDOfKrh0OIByTQwVgFLHZzfmrFUJosMK8bi04aELXq5Vpk+cNHKe+
         Sv2lJ+6tGT8+sydwWLCJ+AzyCtzyu12CpGdnqL0NJUTFKez9Yqkk/W57smaJOFRiHX
         YFw17w0q8/sFOyjqTxEug3DjPYgaTzMJlyVdpmC5+o7J7Ekq/J/bwy6rzSouNtiDfg
         XjKqD2iy1gN9mIlANST4gqSd/lPolDPyUj+Vw24KF5O8+Hf0oW9/aVUkbuFNhY9a+X
         eb0LG62+8kLpHsK1FFdhprEBlRxM3O3Vq3bgCo9ip7OGJrq2TXw2YZe8QQ3+SgGqxk
         C8aP4ym9f/Bqw==
Subject: Re: [PATCH v4] kallsyms: strip LTO suffixes from static functions
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Fangrui Song <maskray@google.com>, "KE . LI" <like1@oppo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <08a2e179-3f5f-639e-946f-54cd07ae12fa@kernel.org>
 <20210707181814.365496-1-ndesaulniers@google.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <1fd40e80-283f-62e9-a0fa-84ad68047a23@kernel.org>
Date:   Wed, 7 Jul 2021 11:34:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707181814.365496-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/2021 11:18 AM, Nick Desaulniers wrote:
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
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Code looks fine, small comment about a comment below.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Changes v3 -> v4:
> * Convert this function to use IS_ENABLED rather than provide multiple
>    definitions based on preprocessor checks.
> * Add Nathan's suggested-by.
> 
> Changes v2 -> v3:
> * Un-nest preprocessor checks, as per Nathan.
> 
> Changes v1 -> v2:
> * Both mangling schemes can occur for thinLTO + CFI, this new scheme can
>    also occur for thinLTO without CFI. Split cleanup_symbol_name() into
>    two function calls.
> * Drop KE.LI's tested by tag.
> * Do not carry Fangrui's Reviewed by tag.
> * Drop the inline keyword; it is meaningless.
> 
>   kernel/kallsyms.c | 43 ++++++++++++++++++++++++++++++-------------
>   1 file changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 4067564ec59f..a10dab216f4f 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -171,26 +171,43 @@ static unsigned long kallsyms_sym_address(int idx)
>   	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
>   }
>   
> -#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
> -/*
> - * LLVM appends a hash to static function names when ThinLTO and CFI are
> - * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
> - * This causes confusion and potentially breaks user space tools, so we
> - * strip the suffix from expanded symbol names.
> - */
> -static inline bool cleanup_symbol_name(char *s)
> +static bool cleanup_symbol_name(char *s)
>   {
>   	char *res;
>   
> +	/*
> +	 * LLVM appends a suffix for local variables that must be promoted to

This says local variables but the example uses a function? Is that correct?

> +	 * global scope as part of ThinLTO. foo() becomes
> +	 * foo.llvm.974640843467629774. This can break hooking of static
> +	 * functions with kprobes.
> +	 */
> +	if (!IS_ENABLED(CONFIG_LTO_CLANG_THIN))
> +		return false;
> +
> +	res = strstr(s, ".llvm.");
> +	if (res) {
> +		*res = '\0';
> +		return true;
> +	}
> +
> +	/*
> +	 * LLVM appends a hash to static function names when ThinLTO and CFI
> +	 * are both enabled, i.e. foo() becomes
> +	 * foo$707af9a22804d33c81801f27dcfe489b. This causes confusion and
> +	 * potentially breaks user space tools, so we strip the suffix from
> +	 * expanded symbol names.
> +	 */
> +	if (!IS_ENABLED(CONFIG_CFI_CLANG))
> +		return false;
> +
>   	res = strrchr(s, '$');
> -	if (res)
> +	if (res) {
>   		*res = '\0';
> +		return true;
> +	}
>   
> -	return res != NULL;
> +	return false;
>   }
> -#else
> -static inline bool cleanup_symbol_name(char *s) { return false; }
> -#endif
>   
>   /* Lookup the address for this symbol. Returns 0 if not found. */
>   unsigned long kallsyms_lookup_name(const char *name)
> 
