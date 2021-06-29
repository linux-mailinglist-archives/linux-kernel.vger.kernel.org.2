Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7838A3B79A5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 23:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhF2VGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 17:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhF2VGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 17:06:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A39C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:04:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t17so889916lfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z68yuR9mPAdIwSsk7cMq6l77qF3ZIgmICtFInZAkh5I=;
        b=RuY0ceOgFta6WZfbpQ8G9cL+EF4PbBv629mlcYZzU/Dp1Z1g9TnJ7RwTJ13nqGz3NM
         MRd0W1oQ4MO6QpLEJwq2mc8DR+icGe897TXGp0Tyugj73YLzaGutO97Yi/xazHb4k5+/
         J5qiMSS86C4th5oiPx9wJFzMHmQir4EQIhNp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z68yuR9mPAdIwSsk7cMq6l77qF3ZIgmICtFInZAkh5I=;
        b=Qu0iiRETLDgHHL5xht7gT4Ma+WvYNdeud+tc/ZeC1KcLYGNw05BlgBIeyx3kCjHSR5
         TJeUlRFuWwxc4Xz8HyS5qUiGC/L6BOo4JY1UAv/knRb2iALyh3J2VT9gVBX+FlvTovfd
         pk3rvLqF1pTpOm+f10y9bc2rZL8kRP6te0A1stES2ljZfOeQQqop5raJk/ca/maTQdrC
         3osWKLDEfnD1LMmvWY6WlGRnYeMpYK7qTcKh1DzOVKnTDuXCT4q2flipI8SEiCHocYcb
         /3ci6r73i0zI4UHkyXv2cg8ccwFmymb1dFEXjCvAggCHzmO63a6E2IXQ94cEFHlCQwL7
         dtWg==
X-Gm-Message-State: AOAM533CHFFL79P8GPhx8NFKSXpbuH3pJB4orm+xhG6DigaxnQZ5L8yK
        QMLJfSRHSaAu6wPJXyfL+TiVfj9pbDd4Cy65cGM=
X-Google-Smtp-Source: ABdhPJwx8KGJwY7CFqlrwpfbkZcnHUuagDbyanfkLznePBpWd/uxZrE64ErnQ3vgLL5Ms19NaBhlYQ==
X-Received: by 2002:ac2:4d19:: with SMTP id r25mr24559005lfi.150.1625000645856;
        Tue, 29 Jun 2021 14:04:05 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id m9sm1884681lfb.30.2021.06.29.14.04.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 14:04:05 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id q16so792824lfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:04:05 -0700 (PDT)
X-Received: by 2002:a05:6512:557:: with SMTP id h23mr24898653lfl.253.1625000644827;
 Tue, 29 Jun 2021 14:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <202106281231.E99B92BB13@keescook> <CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com>
 <202106291311.20AB10D04@keescook>
In-Reply-To: <202106291311.20AB10D04@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Jun 2021 14:03:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8M2DyA=bWtnGsAOVqYU-AusxYcpXubUO2htb6qPU9dg@mail.gmail.com>
Message-ID: <CAHk-=wg8M2DyA=bWtnGsAOVqYU-AusxYcpXubUO2htb6qPU9dg@mail.gmail.com>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill Wendling <morbo@google.com>,
        Bill Wendling <wcw@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 1:44 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > And it causes the kernel to be bigger and run slower.
>
> Right -- that's expected. It's not designed to be the final kernel
> someone uses. :)

Well, from what I've seen, you actually want to run real loads in
production environments for PGO to actually be anything but a bogus
"performance benchmarks only" kind of thing.

Of course, "performance benchmarks only" is very traditional, and
we've seen that used over and over in the past in this industry. That
doesn't make it _right_, though.

And if you actually want to have it usable in production environments,
you really should strive to run code as closely as possible to a
production kernel too.

You'd want to run something that you can sample over time, and in
production, not something that you have to build a special kernels for
that then gets used for a benchmark run, but can't be kept in
production because it performs so much worse.

Real proper profiles will tell you what *really* matters - and if you
don't have enough samples to give you good information, then that
particular code clearly is not important enough to waste PGO on.

This is not all that dissimilar to using gprof information for
traditional - manual - optimizations.

Sure, instrumented gprof output is better than nothing, but it is
*hugely* worse than actual proper sampled profiles that actually show
what matters for performance (as opposed to what runs a lot - the two
are not necessarily all that closely correlated, with cache misses
being a thing).

And I really hate how pretty much all of the PGO support seems to be
just about this inferior method of getting the data.

                Linus
