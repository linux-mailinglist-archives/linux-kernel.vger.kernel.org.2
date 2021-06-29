Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03FC3B79DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 23:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhF2VaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 17:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhF2VaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 17:30:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF93C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:27:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q18so872118lfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yth+6c7mlS+KmL6mK732GO1mfX1AaY5yXfvDuoiPScw=;
        b=AIQutnUtMRaicBG5+j3Irv2QBgm8Qo0QoAkowUt6bhpD8l4Vsc+8YVsOahkMsPm3Ck
         Uzai2ArkxYZp2tGrOCiad7XiVt+w560Klu1P05WtBlZArQwXYzOGPik/OiOq8+trNYWk
         aRw653cw/k43JjiC1d3SfJsRJS+aKCNhGBhmhAF5TY+jTHoSatqrTJHdFZsx0kuks7MZ
         3aBZZ4sf98BJg7+kvQddXgIHValMxxi9TwdkFNNF37YUV6ok1h9xNjvXa8uanNEITQ6l
         Q/95syRAhCj+NGvTinood6FBUhm2OTZW5VN6iRb+9Gf9p4w8leKwUlA4d4Dzi3Sl29sw
         lXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yth+6c7mlS+KmL6mK732GO1mfX1AaY5yXfvDuoiPScw=;
        b=I995sYy+KgjmIXX3zI1ZJwYCYFCukZZFISFMt9sqZAy/L7vUO52O5p3iu8FHrQi6Ud
         IzVgmiidXbfWLx+rpRFqkixUmJiQx1SCbew5yOCsVhR30+cfOVnbz/fnGioi3tHAblEV
         Y3a2lMcgI5vxkelSzPOHLEdUZK8elenmzopg3XQywkxUFiiHsG+zlonDbOU5MtgkjW/y
         wsC7cZXdnuuOuPRgq/OHygkBQDx0uirGXYWlQsnrsLiqt7U3LDohvYa+DncduzoeamIS
         pm87NnaVjIhIhQsxEARJO6vnwvLbMYunh0OAEKziHNIzA468E7C8IL23qmobczy06Ff7
         cTiw==
X-Gm-Message-State: AOAM531G7FNnxBdgTjdKpKGyc0vcRPaXyxOGhXXFSEuFPDN9pOctZG/t
        8f3YvLZQMjsqPVefx8RU51wg3J9Lkh2mPs94Op04Xw==
X-Google-Smtp-Source: ABdhPJwBgRzdqEH7ihI0lgehK4iB1Sow1+dbEd+SsI/FXm7mOZm4aiQGA18hoO+ct6OpSq/Qk0kzD4c3kSACGfjDdmw=
X-Received: by 2002:a05:6512:3884:: with SMTP id n4mr24664312lft.547.1625002066332;
 Tue, 29 Jun 2021 14:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <202106281231.E99B92BB13@keescook> <CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com>
 <202106291311.20AB10D04@keescook> <CAHk-=wg8M2DyA=bWtnGsAOVqYU-AusxYcpXubUO2htb6qPU9dg@mail.gmail.com>
In-Reply-To: <CAHk-=wg8M2DyA=bWtnGsAOVqYU-AusxYcpXubUO2htb6qPU9dg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Jun 2021 14:27:34 -0700
Message-ID: <CAKwvOdkcKU4K9LWTymmzi_c0wKPTQjWEbNu04WOd6D-EcnWDSg@mail.gmail.com>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 2:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jun 29, 2021 at 1:44 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > And it causes the kernel to be bigger and run slower.
> >
> > Right -- that's expected. It's not designed to be the final kernel
> > someone uses. :)
>
> Well, from what I've seen, you actually want to run real loads in
> production environments for PGO to actually be anything but a bogus
> "performance benchmarks only" kind of thing.
>
> Of course, "performance benchmarks only" is very traditional, and
> we've seen that used over and over in the past in this industry. That
> doesn't make it _right_, though.

The current major use case is ensuring that production kernels have
been "trained" with specific workloads in mind.

> And if you actually want to have it usable in production environments,
> you really should strive to run code as closely as possible to a
> production kernel too.

You could do both.  There is a line of research internally using
multiple training rounds ("CSPGO").

> You'd want to run something that you can sample over time, and in
> production, not something that you have to build a special kernels for
> that then gets used for a benchmark run, but can't be kept in
> production because it performs so much worse.
>
> Real proper profiles will tell you what *really* matters - and if you
> don't have enough samples to give you good information, then that
> particular code clearly is not important enough to waste PGO on.
>
> This is not all that dissimilar to using gprof information for
> traditional - manual - optimizations.
>
> Sure, instrumented gprof output is better than nothing, but it is
> *hugely* worse than actual proper sampled profiles that actually show
> what matters for performance (as opposed to what runs a lot - the two
> are not necessarily all that closely correlated, with cache misses
> being a thing).
>
> And I really hate how pretty much all of the PGO support seems to be
> just about this inferior method of getting the data.

Right now we're having trouble with hardware performance counters on
non-intel chips; I don't think we have working LBR equivalents on AMD
until zen3, and our ETM based samples on ARM are hung up on a few last
minute issues requiring new hardware (from multiple different chipset
vendors).

It would be good to have some form profile based optimizations that
aren't architecture or microarchitecture dependent.
-- 
Thanks,
~Nick Desaulniers
