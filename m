Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C6B40742D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 02:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbhIKASS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 20:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhIKARy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 20:17:54 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDB5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 17:16:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id l10so7415576lfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 17:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nnxC0+uXgJWjMMOwzYEprAl8DpqU7SitvBfJvqXtAvA=;
        b=YKR5oBCZODSdIMSuJo9to3OJaDHwi04ayCLOqMoBUmbViJjERcAXyJJTrtmrE5YDki
         wISXApUrzytIbqr8U291ZReOnIVGsE0ub1UMpVCiP8CF0Dlso8Sr65erwIdVQkX1VCDz
         phSZtge746Vz86B4Uvv6BPViBE6Jou8UOa3NsWWqlllXijuQO5yQrmQmw0uKWZyNja1p
         qZkATojLiYONI/D0MIGkCujiZLIbc8eu7AwXX1VW/4LlSRGfEKNPLMU44fbYc5VRfMZ7
         1DdoGStpHeR359PFxGEqayNMXKK4VpIklDRf8B5w2bDcfNHaxvNeOX1QMGmF7dcvGMa+
         6giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nnxC0+uXgJWjMMOwzYEprAl8DpqU7SitvBfJvqXtAvA=;
        b=mgugnIEhRYPfJ1yYxpEVU2c5Gv4ZsWu/o+dIFBol9nhVpFu+CSqCFsrBO7J30YsJqa
         ICRXEhinLfYMeQ44nylDc+x6/0VCWpIVGtapJ/ykO46krRL5a2b8HXSMkkwtq2dvNxI7
         BEqHK5i+Sut5fVd1/pbRDlD8ZZMwwAhquojE7cmIxd7PLdWIq1PPfyvDG/koIkXQkSdQ
         0doMyGKfC31PwpIfrwNT5pxrT5zyLy9U2EJZxd49Z3nN7r6IuQ4jsIQsRHLxoXh0SzsB
         mia41rtHVNVTDsXNBy+QYJr1YmPJAmEzyMw5jCPTES2awA14hc1U/GC8KjW3/j1vJykt
         VN+A==
X-Gm-Message-State: AOAM530qMMhF8ToSL2XTOYHa0TzB5CH5QmS2nq13MItHnajt0YzYX28H
        6+OgFyY1X0slNiF6cCg5TevXNuTSdkXppMHsyJrDsAg+p9fK4w==
X-Google-Smtp-Source: ABdhPJzBX9yhpclacNqWINCliCUD++/3F+Bmc8o81PP6am+7gtNUXPyOJj+aJHqLwp0aAyWL7TLgSiU2iEOIQ5xR+iM=
X-Received: by 2002:a05:6512:139c:: with SMTP id p28mr151762lfa.523.1631319400634;
 Fri, 10 Sep 2021 17:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-2-ndesaulniers@google.com> <cb42c578-d037-3297-d0c2-ab107b7a838f@kernel.org>
In-Reply-To: <cb42c578-d037-3297-d0c2-ab107b7a838f@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Sep 2021 17:16:29 -0700
Message-ID: <CAKwvOd=m1bUZwyV53k2+d+M6rOL04A0WPhH_wOUFU-ZK1BOWFg@mail.gmail.com>
Subject: Re: [PATCH 01/10] Documentation: raise minimum supported version of
 GCC to 5.1
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 4:56 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On 9/10/2021 4:40 PM, Nick Desaulniers wrote:
> > commit fad7cd3310db ("nbd: add the check to prevent overflow in
> > __nbd_ioctl()")
> >
> > raised an issue from the fallback helpers added in
> >
> > commit f0907827a8a9 ("compiler.h: enable builtin overflow checkers and add fallback code")
> >
> > Specifically, the helpers for checking whether the results of a
> > multiplication overflowed (__unsigned_mul_overflow,
> > __signed_add_overflow) use the division operator when
> > !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW. This is problematic for 64b
> > operands on 32b hosts.
>
> "hosts" -> "targets" or "architectures"?

Yes, will revise to "targets."

>
> It might be worth putting the error that Stephen found here?

Doh! Yes, in v2, I'll include the following additional context:
```
The following error is observed when building for 32b powerpc:
> ERROR: modpost: "__divdi3" [drivers/block/nbd.ko] undefined!

As Stephen Rothwell notes:
> The added check_mul_overflow() call is being passed 64 bit values.
> COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW is not set for this build (see
> include/linux/overflow.h).
```


>
> > Also, because the macro is type agnostic, it is very difficult to write
> > a similarly type generic macro that dispatches to one of:
> > * div64_s64
> > * div64_u64
> > * div_s64
> > * div_u64
> >
> > Raising the minimum supported versions allows us to remove all of the
> > fallback helpers for !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW, instead
> > dispatching the compiler builtins.
> >
> > arm64 has already raised the minimum supported GCC version to 5.1, do
> > this for all targets now. See the link below for the previous
> > discussion.
> >
> > Link: https://lore.kernel.org/all/20210909182525.372ee687@canb.auug.org.au/
> > Link: https://lore.kernel.org/lkml/CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com/
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1438
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> >   Documentation/process/changes.rst | 2 +-
> >   scripts/min-tool-version.sh       | 8 +-------
> >   2 files changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> > index d3a8557b66a1..e35ab74a0f80 100644
> > --- a/Documentation/process/changes.rst
> > +++ b/Documentation/process/changes.rst
> > @@ -29,7 +29,7 @@ you probably needn't concern yourself with pcmciautils.
> >   ====================== ===============  ========================================
> >           Program        Minimal version       Command to check the version
> >   ====================== ===============  ========================================
> > -GNU C                  4.9              gcc --version
> > +GNU C                  5.1              gcc --version
> >   Clang/LLVM (optional)  10.0.1           clang --version
> >   GNU make               3.81             make --version
> >   binutils               2.23             ld -v
> > diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> > index 319f92104f56..4edc708baa63 100755
> > --- a/scripts/min-tool-version.sh
> > +++ b/scripts/min-tool-version.sh
> > @@ -17,13 +17,7 @@ binutils)
> >       echo 2.23.0
> >       ;;
> >   gcc)
> > -     # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63293
> > -     # https://lore.kernel.org/r/20210107111841.GN1551@shell.armlinux.org.uk
> > -     if [ "$SRCARCH" = arm64 ]; then
> > -             echo 5.1.0
> > -     else
> > -             echo 4.9.0
> > -     fi
> > +     echo 5.1.0
> >       ;;
> >   icc)
> >       # temporary
> >



-- 
Thanks,
~Nick Desaulniers
