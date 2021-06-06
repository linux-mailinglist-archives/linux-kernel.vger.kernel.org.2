Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849A839D083
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 20:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhFFSus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 14:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhFFSum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 14:50:42 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B14C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 11:48:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w15so18886974ljo.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJCua1TpemFOI3glAj3fgLbjj5CxdDpoZVGdK1bpooE=;
        b=eQFMVtzND83RNvBKe4gAJD9EpVFbNqfEo6XBgSpWhwW0OiuPD/lGFputn9h6YanwSf
         ohx5NvMs8hu1wCWtc40QJv5O8HrmCChBxr1RnmVvLasDZe1r9HwPa/xSxXQQPQwSwk+2
         CLsnEdpEEjSfN0HlTs+pdvfGZCV/grDccJwew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJCua1TpemFOI3glAj3fgLbjj5CxdDpoZVGdK1bpooE=;
        b=TZh47XdXQOI9uM6iLqvoaAZy2OyoS2ipB2rlMATG3oC+hMvILbr9nuRCktFOaBw3Pb
         yQwlK2MKG2cl7N2su6eX2VH1HzmqkhK9go7JjVckcyd+61eZTaltgmRf2Rr9J/b+mzVI
         l1QnbL0RGATJwtQTxaB8YLnk2ObME1FVIVOcO4KHHuhXOVlexZ5qpy3O7kIBcjnfNpLU
         mvHqahcyvRpB6bsKGUPtkbdndt/5BulYjbTYShtCy0R4s7WH0tyIn7fHGN4b9nMZioHO
         j+GaG5/d0o5iyk1nPQK7193HhXvBQ4M5tM0bldIUagBWZVbdRBC+LBXmwkwaGcw3CC75
         FzAw==
X-Gm-Message-State: AOAM530o8A69N8IEWPlX9fJbRxWedaxGrhjTR5M+AbCgiJcsnBZCh2f/
        33RJbaGXBShWzeVqIbGXAOxx6qLbDKTPG4ZaZwY=
X-Google-Smtp-Source: ABdhPJwdhH8ZdjZczp8yCod+qXaWymzxs+GxWnNCzupNPFu7FW5WL4YdCKZQP5bwr5lKEjsFUzGKkw==
X-Received: by 2002:a2e:878b:: with SMTP id n11mr9666192lji.225.1623005330801;
        Sun, 06 Jun 2021 11:48:50 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c125sm1218806lfd.199.2021.06.06.11.48.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 11:48:49 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id a2so22314467lfc.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 11:48:48 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr9503593lfl.253.1623005328455;
 Sun, 06 Jun 2021 11:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com> <20210606184021.GY18427@gate.crashing.org>
In-Reply-To: <20210606184021.GY18427@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 11:48:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
Message-ID: <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 11:43 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> You truly should have written a branch in tthe asm if you truly wanted
> a branch instruction.

That's exactly what I don't want to do, and what the original patch by
PeterZ did.

Why?

Because then we need to write that stupid pointless branch for every
single architecture.

And to work well, it needs "asm goto", which is so recent that a lot
of compilers don't support it (thank God for clang dragging gcc
kicking and screaming to implement it at all - I'd asked for it over a
decade ago).

So you get bad code generation in a lot of cases, which entirely
obviates the _point_ of this all - which is that we can avoid an
expensive operation (a memory barrier) by just doing clever code
generation.

So if we can't get the clever code generation, it's all pretty much
moot, imnsho.

A working barrier "just fixes it".

I suspect the best we can do is to just work around the gcc badness
with that __COUNTER__ trick of mine. The lack of a reliable comment
character is the biggest issue with that trick.

                 Linus
