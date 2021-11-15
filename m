Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE3644FCDC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 03:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbhKOCLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 21:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbhKOCLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 21:11:10 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380A7C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 18:08:15 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g14so64791874edz.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 18:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UvrJWIznJS4VyR1Yj5O3vPS/1gMvDOExIbGNjdFADoo=;
        b=UJGHZxlj9YJbpiPTyqZ5/dKpQtr5UBHfZNqsufQJLqn7gOlYZTlfvu+iaOTlcf0p5d
         o37pQRzSI52YwjYX4ibruf+fLW91M+6PZmtH/pO2YeVbVKlF3cPJXsAC1cksmM3+M6CU
         Ga1CACEVifBqisLmcsjfAHeUlY+/Hbn19Pqh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvrJWIznJS4VyR1Yj5O3vPS/1gMvDOExIbGNjdFADoo=;
        b=6JB66O0WuoTpx27dlfgJXA58Lyd2VtgMWdIiOEG4gkL4VClqSkOaeczfi/TEaG6A95
         mtlecT1amLAMXaHkakuro6+tHsl7YeBhkla+ESxcFjQCuLjFAvI5SLfN5/D6ONizd3Qr
         hC74TtTh/n0xft2ff2G1ZuqtDKrCMu5J0JuO5aMJxW9UCohw1MgfBTPSBR9Uv8PG2JxL
         kntCBPd4anrigDYMli9+tuJrNsq3v533JO8b215n9k2rfI/2RBLIdxkLsgxDvjw5RdUl
         fAab4wAAvuZRFuI7iuqZqa/NlOTSpVjNJs66sXBSU/K/tKpCdDtp91ahs/zGyaDevNGK
         BOxg==
X-Gm-Message-State: AOAM530iCFIsEyz/J2vQ1dmidX3F1IZSgch8//k47Bk59J9OExpLxU7s
        Fs5y3hhqbfQJiRfDT1ftvm1PwpcIS78o3NuV
X-Google-Smtp-Source: ABdhPJxIwFqPy1ocROEjVkAIXVk90cX8MtDnYqLxs82cuqCl52Syw/eoGFT49LMYUmfSQEODoSAzdg==
X-Received: by 2002:a17:906:6549:: with SMTP id u9mr45626341ejn.514.1636942093472;
        Sun, 14 Nov 2021 18:08:13 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id sg17sm5589695ejc.72.2021.11.14.18.08.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 18:08:13 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id z1-20020a05600c220100b00337f97d2464so138067wml.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 18:08:13 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr52818640wmq.8.1636942092763;
 Sun, 14 Nov 2021 18:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20211115011313.GA43897@embeddedor>
In-Reply-To: <20211115011313.GA43897@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Nov 2021 18:07:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whaJCEwqKbekSNjziY4RMTKzkRkkrOM4MEZQEo0j3HT=Q@mail.gmail.com>
Message-ID: <CAHk-=whaJCEwqKbekSNjziY4RMTKzkRkkrOM4MEZQEo0j3HT=Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fix -Wimplicit-fallthrough=5 error for GCC 5.x
 and 6.x
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 5:08 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> -Wimplicit-fallthrough=5 was under cc-option because it was only
> available in GCC 7.x and newer so the build is now broken for GCC 5.x
> and 6.x:

Annoying. And I obviously never saw it because I don't carry ancient
compiler versions.

That said:

> -       default "-Wimplicit-fallthrough=5" if CC_IS_GCC
> +       default "-Wimplicit-fallthrough=5" if $(cc-option,-Wimplicit-fallthrough=5)

I think it would be better to keep the CC_IS_GCC part of the test, for
the simple reason that the clang "make config" is already very slow.

I'm not sure why, but it's annoyingly noticeable, and I've complained
about clang performance before in this area (and the likely cause is
the default build for clang being this horribly inefficient shared
library setup, so it spends ages just doing dynamic linking)

Whenever I do "make oldconfig" with a clang build, and my machine is
under any reasonable load (typically because I'm also doing another
build in another terminal at the same time), it takes several seconds.

Doing the same thing with gcc is noticeably much faster.

In fact, it doesn't even need to be a very loaded machine, this is
basically an empty "re-do config" with gcc vs clang (basically same
config, except obviously for compiler-induced config differences):

  gcc$ time make oldconfig
  real 0m0.929s

  clang$ time make oldconfig
  real 0m1.917s

Two seconds may not seem like a lot, but when the machine is under my
usual build load, that almost 2s easily becomes a "do I need to go for
coffee" delay, since I'm just waiting for the config to finish before
I start the build (since I may end up having to answer questions).

And yeah, it's sad how much faster gcc is.

There was a time when the clang people were proud of their
compile-time performance. Pepperidge farm remembers.

Anyway, I'd prefer to not ask for the clang build to do even more
work, since we know it will fail that '=5' case.

             Linus
