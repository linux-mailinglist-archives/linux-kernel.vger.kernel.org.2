Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA953BA0AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhGBMtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhGBMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:49:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F73C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 05:46:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id hr1so12537301ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9Ygf5x7uiOG9bCFzCQj8dmpy7ftJ6zlaTjCUCyvuWI=;
        b=Xkh+xgvWJNg3rs9aU1QIxdqlP7Qlu2eqBL0oaeTo3OG58Ncbm6Gp8Urn8SjvIsvSQM
         wFO/WsLjGXApllsxXG61JcSWN+IGeCMIGEEOBA5FxGYek88RnNdww6AvExbD5YkGYwuT
         lbhWGkCtUmILyQhgBPtDrGdxYEmtT6fKHuMenJ20IKE2g3IvprjKgz4BObJQngx+vvDC
         1CRdOqwZP+1WNLAnn0Eh3TJpzbvWiR6gAaQWHq48v5UgjrCTyDO+r2Kr7+0J3z4pBlLp
         wBPA+qUzsaerhCA11tVOQqAr9JEAyBeb/Jtt1+h3U1DUs5fu01UYEOPKZu5+8e3WF509
         f4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9Ygf5x7uiOG9bCFzCQj8dmpy7ftJ6zlaTjCUCyvuWI=;
        b=p3KID59NG64ipoj/Wf/4t0rmkcTKw7KpiNF+Ddu9NDj/wz6u8zGQlnrL7NsqG1fwb6
         2Ok9yHCp6T2JL9wdN2ARBZdS5DVPxijMdawc7Dh09aNnGl1487qJbHXoPE7HZULnfIU6
         kMIYJVlMu/69WHNRD2aRLLJBmxzE4VAFBu9V7xiH1Fxey0BjOuuh25SfPYQobMfnCv46
         iq/X+saQ+J22sJD4oaZzGQ8XaM9FV7UBA5XBtEOuqzS6WqSyXLzu1VLFRMz6RZnudSLQ
         SQR+hoO7a5Jazy+CsuSKxx2eE0rC4huAqA0HRjsVJgBdhd5wLsZ7SLaej4HT66F2EKdv
         0P8A==
X-Gm-Message-State: AOAM532mahl2aohBGFCpm4hE+faSpsm6QR1TGyDPRs2NfsR1q9xKjyZJ
        ImFUNVgXUdsmdfDwbCbxozxCzvhWN+k/F2O7YNof
X-Google-Smtp-Source: ABdhPJwyH2JiEckTHAvfgM3J+sdE0oNN1VXCZl46sNxymMPsPxZ4o9q4N9qIIE62BLBEMPI+ByqIc8+hdwWKWTdFang=
X-Received: by 2002:a17:907:72ce:: with SMTP id du14mr3731820ejc.529.1625230017449;
 Fri, 02 Jul 2021 05:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <202106281231.E99B92BB13@keescook> <CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com>
 <202106291311.20AB10D04@keescook> <CAHk-=wg8M2DyA=bWtnGsAOVqYU-AusxYcpXubUO2htb6qPU9dg@mail.gmail.com>
In-Reply-To: <CAHk-=wg8M2DyA=bWtnGsAOVqYU-AusxYcpXubUO2htb6qPU9dg@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 2 Jul 2021 05:46:46 -0700
Message-ID: <CAGG=3QXrOnN3-3r-VGDpmikKRpaK_p5hM_qHGprDDMuFNKuifA@mail.gmail.com>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
The reason we use PGO in this way is because we _cannot_ release a
kernel into production that hasn't had PGO applied to it. The
performance of a non-PGO'ed kernel is a non-starter for rollout. We
try our best to replicate this environment for the benchmarks, which
is the only sane way to do this. I can't imagine that we're the only
ones who run up against this chicken-and-egg problem.

For why we don't use sampling, PGO gives a better performance boost
from an instrumented kernel rather than a sampled profile. I'll work
on getting statistics to show this.

-bw

> Of course, "performance benchmarks only" is very traditional, and
> we've seen that used over and over in the past in this industry. That
> doesn't make it _right_, though.
>
> And if you actually want to have it usable in production environments,
> you really should strive to run code as closely as possible to a
> production kernel too.
>
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
>
>                 Linus
