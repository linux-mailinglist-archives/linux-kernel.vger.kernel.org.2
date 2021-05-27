Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8A23936B8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbhE0T4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235525AbhE0T4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:56:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29C6D613BF;
        Thu, 27 May 2021 19:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622145302;
        bh=DYk1gHGHzUdlE6c5Ocmv2Y8Ryo1lqmC7kz+d5nu94X0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ai3g7nGLUd0nmQ3edhHawuCPZ5me9MKghUGoM4jPwOsihhYRmvs92v1NKX9NNPtPd
         YZuCu1CU+M9Uie9aZo1u8JBtCFfVjgWSj4UQ5dT5zT+JZr3iKFeAcDpvRu3CctuQ9W
         nH75pAes4uVUoVndYSyxJGtShzUDkLD2jK3q2utlrcZKuiDc8k9ULQMd/UDElU4oo1
         EPUufzFF//zd6g4WHG3m6DVF1KmLDWza5orIG1v93pRd6fEMGXYp8Jp9lL3ycHU4jM
         8EBsqnNqLS+fSNbHGr/cshWwlP0Dbqp/11GF6YE2XN8Kl+RuSL8eLzuy4/1yrd/aWx
         sdNSbMJMCdUIw==
Subject: Re: [PATCH v3] kcov: add __no_sanitize_coverage to fix noinstr for
 all architectures
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        ojeda@kernel.org, keescook@chromium.org, peterz@infradead.org,
        will@kernel.org, nivedita@alum.mit.edu,
        luc.vanoostenryck@gmail.com, masahiroy@kernel.org,
        samitolvanen@google.com, arnd@arndb.de,
        clang-built-linux@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>, kasan-dev@googlegroups.com
References: <20210527194448.3470080-1-elver@google.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <be3971b1-cf26-36c7-0f9c-d79c656ec855@kernel.org>
Date:   Thu, 27 May 2021 12:55:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210527194448.3470080-1-elver@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/2021 12:44 PM, Marco Elver wrote:
> Until now no compiler supported an attribute to disable coverage
> instrumentation as used by KCOV.
> 
> To work around this limitation on x86, noinstr functions have their
> coverage instrumentation turned into nops by objtool. However, this
> solution doesn't scale automatically to other architectures, such as
> arm64, which are migrating to use the generic entry code.
> 
> Clang [1] and GCC [2] have added support for the attribute recently.
> [1] https://github.com/llvm/llvm-project/commit/280333021e9550d80f5c1152a34e33e81df1e178
> [2] https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=cec4d4a6782c9bd8d071839c50a239c49caca689
> The changes will appear in Clang 13 and GCC 12.
> 
> Add __no_sanitize_coverage for both compilers, and add it to noinstr.
> 
> Note: In the Clang case, __has_feature(coverage_sanitizer) is only true
> if the feature is enabled, and therefore we do not require an additional
> defined(CONFIG_KCOV) (like in the GCC case where __has_attribute(..) is
> always true) to avoid adding redundant attributes to functions if KCOV
> is off. That being said, compilers that support the attribute will not
> generate errors/warnings if the attribute is redundantly used; however,
> where possible let's avoid it as it reduces preprocessed code size and
> associated compile-time overheads.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> v3:
> * Add comment explaining __has_feature() in Clang.
> * Add Miguel's Reviewed-by.
> 
> v2:
> * Implement __has_feature(coverage_sanitizer) in Clang
>    (https://reviews.llvm.org/D103159) and use instead of version check.
> * Add Peter's Ack.
> ---
>   include/linux/compiler-clang.h | 17 +++++++++++++++++
>   include/linux/compiler-gcc.h   |  6 ++++++
>   include/linux/compiler_types.h |  2 +-
>   3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index adbe76b203e2..49b0ac8b6fd3 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -13,6 +13,12 @@
>   /* all clang versions usable with the kernel support KASAN ABI version 5 */
>   #define KASAN_ABI_VERSION 5
>   
> +/*
> + * Note: Checking __has_feature(*_sanitizer) is only true if the feature is
> + * enabled. Therefore it is not required to additionally check defined(CONFIG_*)
> + * to avoid adding redundant attributes in other configurations.
> + */
> +
>   #if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
>   /* Emulate GCC's __SANITIZE_ADDRESS__ flag */
>   #define __SANITIZE_ADDRESS__
> @@ -45,6 +51,17 @@
>   #define __no_sanitize_undefined
>   #endif
>   
> +/*
> + * Support for __has_feature(coverage_sanitizer) was added in Clang 13 together
> + * with no_sanitize("coverage"). Prior versions of Clang support coverage
> + * instrumentation, but cannot be queried for support by the preprocessor.
> + */
> +#if __has_feature(coverage_sanitizer)
> +#define __no_sanitize_coverage __attribute__((no_sanitize("coverage")))
> +#else
> +#define __no_sanitize_coverage
> +#endif
> +
>   /*
>    * Not all versions of clang implement the type-generic versions
>    * of the builtin overflow checkers. Fortunately, clang implements
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 5d97ef738a57..cb9217fc60af 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -122,6 +122,12 @@
>   #define __no_sanitize_undefined
>   #endif
>   
> +#if defined(CONFIG_KCOV) && __has_attribute(__no_sanitize_coverage__)
> +#define __no_sanitize_coverage __attribute__((no_sanitize_coverage))
> +#else
> +#define __no_sanitize_coverage
> +#endif
> +
>   #if GCC_VERSION >= 50100
>   #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>   #endif
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index d29bda7f6ebd..cc2bee7f0977 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -210,7 +210,7 @@ struct ftrace_likely_data {
>   /* Section for code which can't be instrumented at all */
>   #define noinstr								\
>   	noinline notrace __attribute((__section__(".noinstr.text")))	\
> -	__no_kcsan __no_sanitize_address
> +	__no_kcsan __no_sanitize_address __no_sanitize_coverage
>   
>   #endif /* __KERNEL__ */
>   
> 

