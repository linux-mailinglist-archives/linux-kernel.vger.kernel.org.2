Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26F338CC38
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbhEUReV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233220AbhEUReT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:34:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8166B611AD;
        Fri, 21 May 2021 17:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621618376;
        bh=vE9z1/gR4km7YRN6OoWPExYDHukNHQL46kKLJXMBM6g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=trcQTNil6rYL18WGMg/3X5Mc9187u9mMsxQoleo8RVmBhwvYTiG0aLQ5hSUyVKhQ7
         rSm6MCATjhvx9bvN+r5ef4qb8NKTF5C0tWy9QU9nuUHPfsczg6u098CEtSqSj4Vm9x
         iMebfbo/5L4/q21SDg/TXPNqc9ozFEFqGAOnRqA5IwUxgUY9RJlsnoVqshPhZ8skmx
         0QSPy+O+J/u6f5pOvAGBDf7bSz6YBK9ujFujRlAuUvZoWhdlddMFgoNvw4Mz+335xn
         l8GC6U+SJ3LTgkyz/KW/3t0Y3e47O/lUbFxodgtRMXryeF5XDa77cqZnUkLtOrPQwG
         boeWzGd0/na/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4384D5C0164; Fri, 21 May 2021 10:32:55 -0700 (PDT)
Date:   Fri, 21 May 2021 10:32:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        akpm@linux-foundation.org, masahiroy@kernel.org, joe@perches.com,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] init: verify that function is initcall_t at compile-time
Message-ID: <20210521173255.GZ4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210521072610.2880286-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521072610.2880286-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 09:26:10AM +0200, Marco Elver wrote:
> In the spirit of making it hard to misuse an interface, add a
> compile-time assertion in the CONFIG_HAVE_ARCH_PREL32_RELOCATIONS case
> to verify the initcall function matches initcall_t, because the inline
> asm bypasses any type-checking the compiler would otherwise do. This
> will help developers catch incorrect API use in all configurations.
> 
> A recent example of this is:
> https://lkml.kernel.org/r/20210514140015.2944744-1-arnd@kernel.org
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/init.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 045ad1650ed1..d82b4b2e1d25 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -242,7 +242,8 @@ extern bool initcall_debug;
>  	asm(".section	\"" __sec "\", \"a\"		\n"	\
>  	    __stringify(__name) ":			\n"	\
>  	    ".long	" __stringify(__stub) " - .	\n"	\
> -	    ".previous					\n");
> +	    ".previous					\n");	\
> +	static_assert(__same_type(initcall_t, &fn));
>  #else
>  #define ____define_initcall(fn, __unused, __name, __sec)	\
>  	static initcall_t __name __used 			\
> -- 
> 2.31.1.818.g46aad6cb9e-goog
> 
