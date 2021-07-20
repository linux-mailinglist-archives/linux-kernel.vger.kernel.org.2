Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482FD3D00BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 19:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhGTREe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 13:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhGTRCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:02:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6509DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 10:43:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a12so36999544lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8wStzqc4Tz1l9Y/9gFUCppIwYqgT5Wwd17ApfhHJsQ=;
        b=WfTqeEb7cYG/Z/lJ137/dFGBGE5OQO5oWxfQY7DTy0osPDl5YOJzzub83sYaYjUHgs
         gitLQyMAI+IQgz87Z6SPbcvigmrEM0jdm/uqj1/1w+G/zTk51ntwuCEM3xyzAbeZCjdr
         NKV3r+u3qnNcmsgQz10LxVLU4J1ZWdJUuNKis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8wStzqc4Tz1l9Y/9gFUCppIwYqgT5Wwd17ApfhHJsQ=;
        b=Ec09TZ6zT3iib5rdvytWz3Y7er2uIkGsDA1WhuogB3osSrdYtZ4V4tAm/ANt86lOBQ
         EsgKXZ7m4FSTNYArDwBVbF705rkpdrRRwecjHxseo4zhCM0oAXMXJu4Gju9pHe/0tvgH
         cljyvDyv9CsThPjLWPuwkYvoOu2h7U/nx3tv0mfqmEyJerpRa0rGVJ2Ib2O5FR3lQoQO
         blgQto57V6UUhN6rVL3Ovop/wSVVfHE9HZL6wst40ShNrua+Z0qm4QLH14vL3P0GYmvz
         aRjs2EuUHa7yFHSBuotYjiHW6jzJCl+7ukuUHcKtqHJJsfkY2FWlY0Rf08Tf5jZ8JQr7
         +Dig==
X-Gm-Message-State: AOAM530DwnmvWM76GtQmjBxdBbh1Q/HKvBEG4R6Z3IjFx2Q8kutedgcx
        3Zh5ZrEsb6NaM4oWBgzdkHXWxmdTXWGHis4Q
X-Google-Smtp-Source: ABdhPJw39taXRNifHjy8ANU+wWWfMqwIkyOLORPe3Ubs26PIprBYxwV3Az9u7j1Foa8O6xKbTNoH5g==
X-Received: by 2002:a19:7111:: with SMTP id m17mr22441255lfc.137.1626802994812;
        Tue, 20 Jul 2021 10:43:14 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id j17sm1569952lfu.266.2021.07.20.10.43.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 10:43:14 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id s13so15520566lfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 10:43:14 -0700 (PDT)
X-Received: by 2002:a05:6512:2388:: with SMTP id c8mr12367790lfv.201.1626802993767;
 Tue, 20 Jul 2021 10:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210708232522.3118208-1-ndesaulniers@google.com>
 <20210708232522.3118208-3-ndesaulniers@google.com> <CAK7LNARye5Opc0AdXpn+DHB7hTaphoRSCUWxJgXu+sjuNjWUCg@mail.gmail.com>
In-Reply-To: <CAK7LNARye5Opc0AdXpn+DHB7hTaphoRSCUWxJgXu+sjuNjWUCg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Jul 2021 10:42:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGxu4_hgzdYpFuKd95SfnkJbPTWAQ9-fMgmMN1Oxs2xQ@mail.gmail.com>
Message-ID: <CAHk-=wgGxu4_hgzdYpFuKd95SfnkJbPTWAQ9-fMgmMN1Oxs2xQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: infer CROSS_COMPILE from SRCARCH for
 LLVM=1 LLVM_IAS=1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 1:05 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> LLVM=1 is a convenient switch to change all the
> defaults, but yet you can flip each tool individually.

Actually, I'd argue that "LLVM=1" is *not* a convenient switch.
Neither are the individual other command line settings.

When clang was the odd man out, and special, it all made sense.
Changing the path to CC was similar to changing the path to AWK. And
that's obviously why we have what we have.

But clang has become a primary compiler for some kernel communities,
and I think it might be time to just re-visit that entirely.

In particular, I think we should just make it a Kconfig option. I hate
the command flag stuff so much, that my clang tree literally has this
patch in it:

    -CC = $(CROSS_COMPILE)gcc
    +CC = $(CROSS_COMPILE)clang

so that I can just do the same "make -j128" in both my gcc tree and my
clang tree.

But each build tree already has its own .config file, so it would be a
lot more convenient if that was how the compiler was chosen, and then
"make oldconfig" would just DTRT.

We do most of the other heavy lifting in this area in Kconfig anyway,
why not add that compiler choice?

Obviously it would be gated by the tests to see which compilers are
_installed_ (and that they are valid versions), so that it doesn't ask
stupid things ("do you want gcc or clang" when only one of them is
installed and/or viable).

Hmm? So then any "LLVM=1" thing would be about the "make config"
stage, not the actual build stage.

(It has annoyed me for years that if you want to cross-compile, you
first have to do "make ARCH=xyz config" and then remember to do "make
ARCH=xyz" for the build too, but I cross-compile so seldom that I've
never really cared).

Let the flame wars^H^Hpolite discussions ensue..

                        Linus
