Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57A1381CFD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 07:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhEPFSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 01:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhEPFSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 01:18:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 198C860FE8;
        Sun, 16 May 2021 05:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621142239;
        bh=K0m4rI5MpjlYlSpNgLWEiwDYKro7dUd8PwLi0yCNmGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8j0z3qd5ekIjKkY0fFgIJIL7wMqehrSYhp93dUWp00ZpS1CaAUla8FVhWT4DSFP5
         eyMFDTJC5A/umNbFXaNFTwOIe+yC2yH4EMiyaIBn9ERmQ0rvgP64BOHlwUw0jjQ4/m
         mLWHGdxKecr3gj7kxsVfCqKgUeRb+rsfpMekHOlXOx0/mnqXRlPBZjLmKN9VrGJ43/
         MjeObMVtzPMHiHcPaacs75uMiwCUZhd/LMWmdA69NVYXmzUhEkcr3yWn+DTamDjUrs
         6H1Q4UyeeMT48scL9RPEDsMnuxZqPv3uUVdZ65AhQR6NGBiETNAqcB9nQhQ3Wub8Ys
         i/Th9GMJrlSDQ==
Date:   Sat, 15 May 2021 22:17:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
Message-ID: <YKCq2pfZI3TKSm0E@archlinux-ax161>
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

Hi Marco,

On Sat, May 15, 2021 at 01:01:31AM +0200, Marco Elver wrote:
> FWIW, this prompted me to see if I can convince the compiler to complain
> in all configs. The below is what I came up with and will send once the
> fix here has landed. Need to check a few other config+arch combinations
> (allyesconfig with gcc on x86_64 is good).
> 
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

Hi Marco,

I verified that I see an error without Arnd's patch with all supported
KCSAN compilers when I apply this patch.

clang-11: https://builds.tuxbuild.com/1sYcyUZoCS7hFS3qZMZsJgsA5bp/build.log
clang-12: https://builds.tuxbuild.com/1sYcyRDtvvkaQQbGX435X8FUb6o/build.log
clang-13: https://builds.tuxbuild.com/1sYcyPubVREo7Dl05zCKRRNh6RB/build.log

gcc-11 had to be done locally as TuxSuite appears not to support gcc-11
so no nifty link:

In file included from /home/nathan/cbl/src/korg-linux/include/asm-generic/atomic-instrumented.h:20,
                 from /home/nathan/cbl/src/korg-linux/include/linux/atomic.h:82,
                 from /home/nathan/cbl/src/korg-linux/kernel/kcsan/debugfs.c:10:
/home/nathan/cbl/src/korg-linux/include/linux/build_bug.h:78:41: error: static assertion failed: "__same_type(initcall_t, &kcsan_debugfs_init)"
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                         ^~~~~~~~~~~~~~
/home/nathan/cbl/src/korg-linux/include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
   77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
      |                                  ^~~~~~~~~~~~~~~
/home/nathan/cbl/src/korg-linux/include/linux/init.h:246:9: note: in expansion of macro 'static_assert'
  246 |         static_assert(__same_type(initcall_t, &fn));
      |         ^~~~~~~~~~~~~
/home/nathan/cbl/src/korg-linux/include/linux/init.h:254:9: note: in expansion of macro '____define_initcall'
  254 |         ____define_initcall(fn,                                 \
      |         ^~~~~~~~~~~~~~~~~~~
/home/nathan/cbl/src/korg-linux/include/linux/init.h:260:9: note: in expansion of macro '__unique_initcall'
  260 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
      |         ^~~~~~~~~~~~~~~~~
/home/nathan/cbl/src/korg-linux/include/linux/init.h:262:35: note: in expansion of macro '___define_initcall'
  262 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
      |                                   ^~~~~~~~~~~~~~~~~~
/home/nathan/cbl/src/korg-linux/include/linux/init.h:293:41: note: in expansion of macro '__define_initcall'
  293 | #define late_initcall(fn)               __define_initcall(fn, 7)
      |                                         ^~~~~~~~~~~~~~~~~
/home/nathan/cbl/src/korg-linux/kernel/kcsan/debugfs.c:274:1: note: in expansion of macro 'late_initcall'
  274 | late_initcall(kcsan_debugfs_init);
      | ^~~~~~~~~~~~~
make[3]: *** [/home/nathan/cbl/src/korg-linux/scripts/Makefile.build:273: kernel/kcsan/debugfs.o] Error 1

I did a series of builds against next-20210514 with gcc 8 through 10 and
clang 11 through 13 targeting arm, arm64, i386, powerpc, s390, and
x86_64 defconfig and allmodconfig with no errors with this patch on top
of Arnd's. Repo and TuxSuite configuration below in case anyone cares :)

https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git/log/?h=tuxsuite/initcall-static-assert
https://gist.github.com/nathanchance/eb71e1c2287561a0de79ef28c3c521384

When you formally send it, please feel free to add:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan

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
