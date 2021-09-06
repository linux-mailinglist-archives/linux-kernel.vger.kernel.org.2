Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE9401F70
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243799AbhIFSNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbhIFSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:12:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C80C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:11:54 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y6so12560472lje.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/XxjtcwY9C34CiufMPdWiPHxUpCQ41YPVeJpbHXsEo=;
        b=aXJR99ishZmS0NLJzcIl7b22JdllM6L1T9ntyP9veJPfscOLnpuTWz0n9AT48yIZiJ
         cVL0co87uk5nLMDWONfpkQhA7k4EPdq6AwMECAK1GkKY92gZiYCIT+KPe1uPLPTT7xaf
         jzNOTdupwh3hyL1FNCDe1F/OJ5xpmpgQ5eAzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/XxjtcwY9C34CiufMPdWiPHxUpCQ41YPVeJpbHXsEo=;
        b=cFXmaL3sdwcPkXf6Dis4Yf907fpVdp8t++R/TIe4hH6dtXEA6fDpQKnFe867hyzXFX
         NlfpRF6uo3QuM8CyNUxnBaAKgsDRiMBKit+u7bAsR3fyIduELhDLzyEnXKK/5xU0A4Fo
         /0dSCyZ+3XlJ1FAhwmsuglskIUhm8dRTjfqWU8Fzg1jvYGS6quuIFodOhLW1F5O6rlZy
         BAOgUYunjDuTEHnIeSPFaV+VGLn/7qSNYwEc/Q7zdRfwh82Y8sbvMxWOiyRswMWQeEIX
         Ai8H6l0PtZH9ir8f7pf+Eao4Q3woPvFc0coX43rGtv+63m1iE4P+Hk7tMAPpD12Nxt+m
         /BiQ==
X-Gm-Message-State: AOAM533yy7RdRdywW/XKsN0+SO5hUMeRRClDsEQe0KAMbiNT+Y1Ri+k6
        yszScTb6or8LPQJbxbNsqg+bIz1cINyszs49Tys=
X-Google-Smtp-Source: ABdhPJyE613wRqFhYL4zMpjn/6vxz3AlRyi/JjEDhAZQothynkx4TaSqigMOUO4eUSbEXMmJv0ODlg==
X-Received: by 2002:a05:651c:110f:: with SMTP id d15mr11422036ljo.99.1630951912607;
        Mon, 06 Sep 2021 11:11:52 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id i5sm796044ljg.53.2021.09.06.11.11.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 11:11:51 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id p15so12575494ljn.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:11:51 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr11265751ljg.31.1630951911139;
 Mon, 06 Sep 2021 11:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgoX0pVqNMMOcrhq=nuOfoZB_3qihyHB3y1S8qo=MDs6w@mail.gmail.com>
 <3b461878-a4a0-2f84-e177-9daf8fe285e7@kernel.org> <878s0c4vng.fsf@oldenburg.str.redhat.com>
 <20210904131911.GP1583@gate.crashing.org> <871r644bd2.fsf@oldenburg.str.redhat.com>
 <CAHk-=wi+XKYN+3u=_fm=ExqpEaHdER0XuKxVauHYVCPKpKR97Q@mail.gmail.com>
 <20210904191531.GS1583@gate.crashing.org> <CAHk-=wjc1rxah3xt8mKN=aCxQigjy3-hEf4xh_Y-r=MXAKVrag@mail.gmail.com>
 <20210906154642.GV1583@gate.crashing.org> <CAHk-=wj=WpWO_V86cZH99LgZGBbvdDb4wR26ce5van0hJqjzLA@mail.gmail.com>
 <20210906172701.GX1583@gate.crashing.org>
In-Reply-To: <20210906172701.GX1583@gate.crashing.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Mon, 6 Sep 2021 11:11:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0MBVfA89WLWnCiSnJ2a=hSAoSxfG-jyf7JJeBDPK3ew@mail.gmail.com>
Message-ID: <CAHk-=wh0MBVfA89WLWnCiSnJ2a=hSAoSxfG-jyf7JJeBDPK3ew@mail.gmail.com>
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

On Mon, Sep 6, 2021 at 10:30 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> But this whole thread is about removing uses of <stdarg.h>, and
> eventually removing the
>   -nostdinc -isystem $(shell $(CC) -print-file-name=include)

Yes.

But your argument against it was based on that past argument of it
being compiler-specific, in ways that are not true any more.

Happily, it clearly is the case that compilers have standardized their
internal implementation of this in ways that means that we actually
_could_ do this for <stdarg.h>.

Exactly the way we do it for pretty much every other header file.

IOW, <stdarg.h> is no longer the special thing it used to be.

We use the compiler intrinsics without the C library header files for
everything else, so doing so for <stdarg.h> seems to actually be a
clarification and improvement.

             Linus
