Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF983814C5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 02:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhEOA5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 20:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhEOA5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 20:57:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6411B6135C;
        Sat, 15 May 2021 00:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621040150;
        bh=EI4xLhzrOMh6Itqyez82lmxWaI98QNTA+23VqjpcLmw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vE1zjluaPWy4WN3cRyhehvyD8XsxOBotjrMu9hOuU5YWM9bJD61B5pqQoA01wHlwY
         v5tgj9ejYg7wakXvPSRvWx5pIE3CM+Pg0ZsNuy95K087j33YjXsPAn8qz6CsnBkX2i
         HPyT8vxTi+OP8lLnCSJufqVmXLa/Zxfj7wPdwqDrtzA+dXTmGkqbw5R9nYXWrB4xra
         vkId8Ss3o2CT/p5H9fbEyE/Rm2wIcZWjWn6NkxiZ90yIpXZOBDvN9vXnKQyRmQ4M2T
         pB6uBuAqLkR9jsjeJ+YtR2YY8kInl0VfYFqJkGzOnXkIY+oCvxsHFsn2fOwVXxwck8
         SJ2lSolYGTXyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 231B25C02A5; Fri, 14 May 2021 17:55:50 -0700 (PDT)
Date:   Fri, 14 May 2021 17:55:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
Message-ID: <20210515005550.GQ975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210514140015.2944744-1-arnd@kernel.org>
 <0ad11966-b286-395e-e9ca-e278de6ef872@kernel.org>
 <20210514193657.GM975577@paulmck-ThinkPad-P17-Gen-1>
 <534d9b03-6fb2-627a-399d-36e7127e19ff@kernel.org>
 <20210514201808.GO975577@paulmck-ThinkPad-P17-Gen-1>
 <CAK8P3a3O=DPgsXZpBxz+cPEHAzGaW+64GBDM4BMzAZQ+5w6Dow@mail.gmail.com>
 <YJ8BS9fs5qrtQIzg@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ8BS9fs5qrtQIzg@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 01:01:31AM +0200, Marco Elver wrote:
> On Fri, May 14, 2021 at 11:16PM +0200, Arnd Bergmann wrote:
> > On Fri, May 14, 2021 at 10:18 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > On Fri, May 14, 2021 at 01:11:05PM -0700, Nathan Chancellor wrote:
> > 
> > > > You can see my response to Marco here:
> > > >
> > > > https://lore.kernel.org/r/ad7fa126-f371-5a24-1d80-27fe8f655b05@kernel.org/
> > > >
> > > > Maybe some improved wording might look like
> > > >
> > > > clang with CONFIG_LTO_CLANG points out that an initcall function should
> > > > return an 'int' due to the changes made to the initcall macros in commit
> > > > 3578ad11f3fb ("init: lto: fix PREL32 relocations"):
> > >
> > > OK, so the naive reading was correct, thank you!
> > >
> > > > ...
> > > >
> > > > Arnd, do you have any objections?
> > >
> > > In the meantime, here is what I have.  Please let me know of any needed
> > > updates.
> > >
> > 
> > Looks good to me, thanks for the improvements!
> 
> FWIW, this prompted me to see if I can convince the compiler to complain
> in all configs. The below is what I came up with and will send once the
> fix here has landed. Need to check a few other config+arch combinations
> (allyesconfig with gcc on x86_64 is good).

Cool!

If I have not sent the pull request for Arnd's fix by Wednesday, please
remind me.

							Thanx, Paul

> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> >From 96c1c4e9902e96485268909d5ea8f91b9595e187 Mon Sep 17 00:00:00 2001
> From: Marco Elver <elver@google.com>
> Date: Fri, 14 May 2021 21:08:50 +0200
> Subject: [PATCH] init: verify that function is initcall_t at compile-time
> 
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
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Joe Perches <joe@perches.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
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
> 2.31.1.751.gd2f1c929bd-goog
> 
