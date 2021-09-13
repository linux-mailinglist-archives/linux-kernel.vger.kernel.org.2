Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD8B408A28
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbhIML2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:32858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239554AbhIML2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:28:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB2EE61029
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631532440;
        bh=uD5JrF5cwBUDTHT6rVA5L1wuGh6cdIuU3aXlgc/iPTk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h6ULYhleE0OIE6wWppWhpgLAJcft/Pe7r/5CMUcMXy5GVNjdw0EndM23kNaAMaM1P
         e/egVdQFrwK8nXUBShusB3GVxqZddLDm5SRUmoPstbZ5B96K2GSyT3bJ6sG9i1bBUR
         cjD2nUQ1EtZjxoTYeqFx13Os5wuZa3b7N4nrTndKO1LHNkLWIRtJkPHCA0E+byqFMA
         FtsBxE0eWXUVyknK4bY38TovKpBH81Vd0L+fewAB4tZYwz5OFOh4/4h23ozf9psOuO
         M8aQF+fowGIs6ffkSlYG8XKkVOUw8W5rywBC256G9U8WF1ElSvU7XL1nXnx8VBddh0
         OnpyJ4dQ5sIUw==
Received: by mail-wm1-f50.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so6684821wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:27:20 -0700 (PDT)
X-Gm-Message-State: AOAM5339Zw1bhCGjzyITXZi0fUWG75RkDZvhGdyXKWk/KVCgeoztA7DA
        qlK07cXfIlwFxxnEVv46rcO7XItEVk9KmHEQWaI=
X-Google-Smtp-Source: ABdhPJwnVaM0ciRlJg3u04qytFRVTRJ+L3ppjmfO6ESdlzpNveJrmnGBbao0FQjHcisvTmRg9Rx9hPhT4MD9IOd55R8=
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr10597036wmp.173.1631532439408;
 Mon, 13 Sep 2021 04:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210910234047.1019925-1-ndesaulniers@google.com>
In-Reply-To: <20210910234047.1019925-1-ndesaulniers@google.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 13 Sep 2021 13:27:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3kD4vd6Xiq_L1YKQPd41=pNbXoA59fuZK3dTtShezoKg@mail.gmail.com>
Message-ID: <CAK8P3a3kD4vd6Xiq_L1YKQPd41=pNbXoA59fuZK3dTtShezoKg@mail.gmail.com>
Subject: Re: [PATCH 00/10] raise minimum GCC version to 5.1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 1:41 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> commit fad7cd3310db ("nbd: add the check to prevent overflow in
> __nbd_ioctl()")
>
> raised an issue from the fallback helpers added in
>
> commit f0907827a8a9 ("compiler.h: enable builtin overflow checkers and add fallback code")
>
> Specifically, the helpers for checking whether the results of a
> multiplication overflowed (__unsigned_mul_overflow,
> __signed_add_overflow) use the division operator when
> !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW. This is problematic for 64b
> operands on 32b hosts.
>
> Also, because the macro is type agnostic, it is very difficult to write
> a similarly type generic macro that dispatches to one of:
> * div64_s64
> * div64_u64
> * div_s64
> * div_u64
>
> Raising the minimum supported versions allows us to remove all of the
> fallback helpers for !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW, instead
> dispatching the compiler builtins.
>
> arm64 has already raised the minimum supported GCC version to 5.1, do
> this for all targets now. See the link below for the previous
> discussion.
>
> Additional patches cleaning up a few obsolete version checks.

Agreed, I think this is a good time for removing gcc-4.9 support, with
the tradeoff between the number of remaining users of that compiler and
the number of problems that are solved in gcc-5.1.

After this, I think we can also change the --std=gnu89 to --std=gnu11,
as an additional benefit.

According to distrowatch, this will lose support for the distro gcc version
of Debian 8 (Jessie), Ubuntu 15.04, and older Android AOSP (new versions
use clang to build kernels, old versions also need older kernels).
I think that is acceptable.

For reference, the following distro releases use

Centos 8: gcc-8.3
Debian 9: gcc-6.3
RHEL 8: gcc-8.4
Slackware-14.2: gcc-5.3
SLES15: gcc-10.2
Ubuntu 16.04: gcc-5.3

Most older releases of these already don't support building current kernels.
I expect the number of users of Ubuntu 16.04 and Slackware-14.2 that
want to build their own mainline kernels instead of running what was
provided by the distro to be really low.

The other case that always gets brought up are embedded users that
want to use an ancient user space that is only validated with an old gcc,
but need a new kernel without revalidating user space. The only answer
for those is to use two different compilers.

       Arnd
