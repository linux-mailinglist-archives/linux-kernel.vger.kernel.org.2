Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99F142DDB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhJNPOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbhJNPNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:13:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DB9C02B775
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ueZtdAThR7VQ7jebI58tUryh7pa65ZnfSjE48EgKiy4=; b=nMLxSLd50z4fGg+iJk7Ev+BYQn
        QslXFEFGwQbH06TtmGf/2+isY8resYnyeoEje0+Ln6UK8y/THzkX5r6Hz8tLvWGNy/YE0sivzm2mr
        iQu+Vn2OD8CvqXv3PdsO6dokQh2NtekcO3bGpNAWg7usqhNIKsOMv7hSgAc9TpRzALz2ppBuOw06h
        zvIctif9lt9ac9ipEiaeKttBHsgCs2VmWY6nf22NIXgh21r6qV/htGGUOrIFNTQGs7hWPEuONcHsQ
        +NiztRhAv7+Jt6rPuf9XDsyn4Y1V5TGPzPa+c/q3Jvmpl0u6mu4AmYyYRAnxiq2weUA3Rcn6NJJS/
        iuT8jRFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb2ES-008Pa2-NP; Thu, 14 Oct 2021 15:01:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA6CA30030B;
        Thu, 14 Oct 2021 17:01:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9633A2CF42A2E; Thu, 14 Oct 2021 17:01:20 +0200 (CEST)
Date:   Thu, 14 Oct 2021 17:01:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] compiler_types: mark __compiletime_assert failure as
 __noreturn
Message-ID: <YWhGQLHnA9BIVBpr@hirez.programming.kicks-ass.net>
References: <20211014132331.GA4811@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014132331.GA4811@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 03:23:31PM +0200, Miguel Ojeda wrote:
> `__compiletime_assert` declares a fake `extern` function
> which appears (to the compiler) to be called when the test fails.
> 
> Therefore, compilers may emit possibly-uninitialized warnings
> in some cases, even if it will be an error anyway (for compilers
> supporting the `error` attribute, e.g. GCC and Clang >= 14)
> or a link failure (for those that do not, e.g. Clang < 14).
> 
> Annotating the fake function as `__noreturn` gives them
> the information they need to avoid the warning,
> e.g. see https://godbolt.org/z/x1v69jjYY.
> 
> Link: https://lore.kernel.org/llvm/202110100514.3h9CI4s0-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  include/linux/compiler_types.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index b6ff83a714ca..ca1a66b8cd2f 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -298,7 +298,13 @@ struct ftrace_likely_data {
>  #ifdef __OPTIMIZE__
>  # define __compiletime_assert(condition, msg, prefix, suffix)		\
>  	do {								\
> -		extern void prefix ## suffix(void) __compiletime_error(msg); \
> +		/*							\
> +		 * __noreturn is needed to give the compiler enough	\
> +		 * information to avoid certain possibly-uninitialized	\
> +		 * warnings (regardless of the build failing).		\
> +		 */							\
> +		__noreturn extern void prefix ## suffix(void)		\
> +			__compiletime_error(msg);			\
>  		if (!(condition))					\
>  			prefix ## suffix();				\
>  	} while (0)

Should we not convert this to _Static_assert, now that all supported
compilers are of recent enough vintage to support that?
