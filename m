Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3B4400CDB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 21:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhIDUAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 16:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhIDUAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 16:00:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993C1C0613C1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 12:59:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so5252120lfu.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 12:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJYg48y01Ixecv219BnfLeDPB5wbBC3ssZt6PfPcF54=;
        b=KbVKhyqGoTFA9+zvg9VyF1GK8M2l3z5EQv1RyW4PNlggVQQx/3hGyV9qhYUJcjiXE6
         ldRXmnMnFC39k8SWW6iJn/73m4GacJAiONs8EAQ8qrTaVb/4o8e0QiL3JRkFfgcoY7eU
         jdfrz7quMmpAM5dB0E6H19QJ3K5eI+9VVohSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJYg48y01Ixecv219BnfLeDPB5wbBC3ssZt6PfPcF54=;
        b=c9AhZNJ209PRW0hNTcLCLStTn9jXQg9P36DTjzkrOpOy4j7R21BEgIUJPf/FUocoMM
         dBQB2s1yDKi05n8bnSiDHyHthkMhd7/SZv/m5GWOfJjKWev9F3KECtua6i2/dJ0MWU4C
         el9cC+dCEiUZqmEsYsf58EA8j6cy8OFg9QJlEYO8GoawMvhv2dCSs3V0hXPREtqBIAUd
         X2wQR8bDqhqYggEGNzeuDyH84C0NN306NyJfp4/J8xkjHstH0ZiV/Npe+2jOtIdz5p0N
         fX/c7kcjq008fYT0TVTG4BMXeGsLo6+Im0Gu/iMVTuS9sORwT+js28ETZRjHpbY3yEM3
         StGA==
X-Gm-Message-State: AOAM530hrjz8wBXKp2P3F2SNUjKPSZnStpS0AZQkZlL4zcFw0ImgpzZM
        A0ddgfaxzmzbXVIK2ZBF5Dt5AN7pi6JCkuRL
X-Google-Smtp-Source: ABdhPJzi7e2jrhrQAytxk2jsLFjrn5/mXScbW0t1HJgteC6NInJpeJst7lxARRa98lJ3CqhlSGfdpg==
X-Received: by 2002:a05:6512:a85:: with SMTP id m5mr3997674lfu.610.1630785547856;
        Sat, 04 Sep 2021 12:59:07 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 3sm346262ljq.136.2021.09.04.12.59.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 12:59:07 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id m28so5249561lfj.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 12:59:06 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr3993613lfv.655.1630785546572;
 Sat, 04 Sep 2021 12:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQ0Q6CdXaD-dVGj_e3O3JYs_crpejWKpXHYQJYxyk-1VQ@mail.gmail.com>
 <CAHk-=wgoX0pVqNMMOcrhq=nuOfoZB_3qihyHB3y1S8qo=MDs6w@mail.gmail.com>
 <3b461878-a4a0-2f84-e177-9daf8fe285e7@kernel.org> <878s0c4vng.fsf@oldenburg.str.redhat.com>
 <20210904131911.GP1583@gate.crashing.org> <871r644bd2.fsf@oldenburg.str.redhat.com>
 <CAHk-=wi+XKYN+3u=_fm=ExqpEaHdER0XuKxVauHYVCPKpKR97Q@mail.gmail.com> <20210904191531.GS1583@gate.crashing.org>
In-Reply-To: <20210904191531.GS1583@gate.crashing.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Sat, 4 Sep 2021 12:58:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjc1rxah3xt8mKN=aCxQigjy3-hEf4xh_Y-r=MXAKVrag@mail.gmail.com>
Message-ID: <CAHk-=wjc1rxah3xt8mKN=aCxQigjy3-hEf4xh_Y-r=MXAKVrag@mail.gmail.com>
Subject: Re: [GIT PULL v2] Kbuild updates for v5.15-rc1
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        llvm@lists.linux.dev, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 4, 2021 at 12:18 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> And the C standard requires you to use these headers to use some
> features of the C language

That's really the point here: we don't care AT ALL.

The C standard headers are simply not relevant for the kernel. Never
have been, never will be.

We care about the low-level compiler infrastructure, not the standard C headers.

Those standards are designed for - and try to cater to - a completely
different audience.

We do atomics, and we do not care at all about the mis-designed C++
standard atomics.

We do our own type system, and again, we don't care at all about the C
"official" type system and odd name rules that change from one version
to the other.

That has always been the case.

We generally *cannot* use the system header files, because they bring
in things that the kernel simply cannot handle.

That's entirely obvious for things like <stdio.h>, but it's actually
true even for other things.

> You also need <stdint.h> and <stddef.h>.

No, you really don't.

We avoid those intentionally, and always have. Because the system
header files have never been a good match.

Now, <stdarg.h> is actually special for the kernel, exactly because
unlike other header files, that one really ended up being something
that historically wasn't exposed in any other way and wasn't doable
sanely inside the kernel.

But it does look like gcc and clang have both ended up exposing the
interfaces the same way, using the __buildin_xyz model to just wrap
the standard names in a namespace-clean way.

That really wasn't historically true. Back in the bad old days of
varargs etc, you literally had "va_list" be a "char *" and the
accessor functions were magic macros that updated things by hand by
the size of the arguments etc...

So <stdarg.h> is historically very very special, and tied to compiler
implementation details.

In ways that a lot of other "standard C header files" very much are
*not* - many of those are about the types that the system provides.

And in fact often the kernel is the *source* and definition of parts of them.

             Linus
