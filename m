Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E716640BE69
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbhIODq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhIODq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:46:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B9F26108F;
        Wed, 15 Sep 2021 03:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631677540;
        bh=fcKJT4RQ2NWXn1tWEahtcJTu2maR6TNE633Y37N45I4=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=uVeA6QWK4eIX9nJzAvSaE49VnnmAlFLs0J+HLMKTiX3E62P+Msb8rVSj9aRMZj5UG
         FWy050L3jS56dZ8g1pXol6mN40zyIzYa5Q17irVNpT4fBACTsJjxy7xpUPnlo17wR0
         B3jaRgvopcBv2P+7UhXCE95TP/N+OhC16XNH7aCy4e0sZFnskjnPqC9+tMKji6j0NO
         0XPG5Xfn5R7nIoqtOeWK3pqIzWKGEnmDUo1R98dnAP0PBQ3tKN9+OVKQej+soBU+jM
         9zHc2pdwD7mvbdRXzoTVJRmYyDAuDsyvrkNmNdl4QbHeNOuT8q94jBzgr2oEu8rI0A
         a5tNo2d2bl++A==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: linux: build failure: error: "__has_attribute" is not defined
From:   Nathan Chancellor <nathan@kernel.org>
In-Reply-To: <CAHk-=wiiJ47YP7Q4AJC=YSfJdY-HK-8Bh7W=+hrZRqdM2UrAFg@mail.gmail.com>
Date:   Tue, 14 Sep 2021 20:45:39 -0700
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <91B93D4D-BEC8-4ACD-B71F-27C54D8B1B78@kernel.org>
References: <c1b1a299-c60d-28a4-07ab-1ecd211d6da9@i-love.sakura.ne.jp>
 <3bf6f4f4-9c96-6e0c-951d-5509175dddfe@kernel.org>
 <bb40c26c-dd0f-f7c2-59b7-d6ad361a0cdb@i-love.sakura.ne.jp>
 <CAHk-=wiiJ47YP7Q4AJC=YSfJdY-HK-8Bh7W=+hrZRqdM2UrAFg@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sep 14, 2021, at 7:59 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
> Now, the _second_ bug was then that when Nathan fixed the tooling
> header file in commit d0ee23f9d78b ("tools: compiler-gcc.h: Guard
> error attribute use with __has_attribute"), he did it the wrong way.
>=20
> The gcc docs are fairly clear about how to test for __has_attibute =
correctly:
>=20
>    https://gcc.gnu.org/onlinedocs/cpp/_005f_005fhas_005fattribute.html
>=20
> and a host build environment should probably have used
>=20
>  #if defined __has_attribute
>  #  if __has_attribute (error)
>  ...
>=20
> and not used any version checks at all.

Ugh, yes, I had assumed that the host compiler would always equal the
compiler used for the kernel because I am so used to clang so I figured
the 'defined(__has_attribute)' was redundant but that obviously is not
true, especially when cross compiling.

> Of course, I'm not convinced it should do that __compiletime_error()
> at all, and again, I think it would be better to remove the complexity
> rather than anything else.
>=20
> Anybody want to tackle those issues in
>=20
>   tools/include/linux/overflow.h
>   tools/include/linux/compiler-gcc.h
>=20
> and try to simplify the code?

I made the tools/include/linux/compiler-gcc.h situation worse so I am
more than happy to try to resolve it.

__compiletime_error() is ultimately used within BUILD_BUG_ON(), which
does appear to be used a couple places within the tools/ directory so I
am not sure it should be eliminated; doing so would cause BUILD_BUG_ON()
failures to be a lot more cryptic (although it is entirely possible
those are not at all common so who cares). I could be entirely wrong
though if I am misreading the code, there are a few different
BUILD_BUG_ON() defines...

If it cannot be eliminated, we could either add back the
GCC_VERSION >=3D 40300 check (because there does not appear to be a
minimum host version of GCC) along with my fix or we could just do the
'defined(__has_attribute)' and leave GCC 4.3 to 5.1 behind. I do not
have a strong opinion.

Cheers,
Nathan=
