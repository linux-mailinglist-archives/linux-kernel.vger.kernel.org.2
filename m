Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764893BA47C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 21:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhGBT4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 15:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhGBT4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 15:56:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D3C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 12:53:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n14so20059324lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3T9fm0vrNyqUd7WUhq5udhwWx96T+TaxmLZI67T09A=;
        b=Hv4c9Le+OO8WuDQYAsyiqnLUGNM0geOunN7jroG8X4A16Fz6zX4YbcEB4Nojz6L1CQ
         w7q/JWhaGTJrnybf+cxyLT1rT94yIldMWj5tE1sbkbZ3slpJIAJAtDO0VipVqMxTUmSo
         rM/tp4bIhfFNpAMB0AieqRM219IEsl/l72iAQE333n6XamxOl0W4fuHzQVQIBVaSCUkd
         ckKOWju35krmUfHRpJMazcUiKlOU6nC1ofZkth5/UZocxLU42v7HfFtAiY/yGDnPbw6K
         K2p9xQpj5kK/0ABr/dZQ6ko+P1swVnsYFPbuiEY6Euj+6XBfo+hDH5BxotoUeSNoi4uk
         WGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3T9fm0vrNyqUd7WUhq5udhwWx96T+TaxmLZI67T09A=;
        b=F4idXbhmviE01MDxlPpH9kY3H4nhV8hsntHghUjMMp7MdGaL7KORfNcygkAy5XxE4d
         dBGb9uFhVTiCgIMgIcuOlv9iDGDKx3B/Eh27Q8ZBOovC4rCu0ATwIkbP7+5GWCTt/hat
         3Aw6Mw8mc8/GWYzjFlphF1I4cmObcdBmaQanrvHlRtECqzXlNeIymih39WYX5jkqKWZu
         xiD4gYLcX0OnEbPQa63rKHxWUsNaoB6KGBCo4h1/DPSuEsjRi9tuk57DT9rK2fdBbWhg
         cE78XklPC8f2ygkX4fOoWMtW7XeiVAIRMWpGYBRBU7JfoNXxmF5MalyySk6+nDc48Nnl
         IBZQ==
X-Gm-Message-State: AOAM532Re4a35K6ZhrgleVce/bozzUg2BN0RzwZMW7Wv69xC7bCIOlzy
        QhL7kPW1U/+aBjfH6bf7gZAq9r4cmz1q7IkCPfLWQA==
X-Google-Smtp-Source: ABdhPJzhzpi/7OUbLYnpDh/SzWqT8LHZJnpkDZ9CcefRg5vHQfKATGKP5/rfLnEJtaBK4Po6MChbormpkXGyK7yMAmE=
X-Received: by 2002:a05:6512:ad2:: with SMTP id n18mr900187lfu.543.1625255623049;
 Fri, 02 Jul 2021 12:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <202106281231.E99B92BB13@keescook> <CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com>
 <202106291311.20AB10D04@keescook> <CAHk-=wg8M2DyA=bWtnGsAOVqYU-AusxYcpXubUO2htb6qPU9dg@mail.gmail.com>
 <CAGG=3QXrOnN3-3r-VGDpmikKRpaK_p5hM_qHGprDDMuFNKuifA@mail.gmail.com>
 <YN8NGLPQ4Cqanc48@hirez.programming.kicks-ass.net> <CAKwvOd=-qdp6xcuVb-fSni6X-0UuJ6GM5+TJdWSkAfvNmqfZ+w@mail.gmail.com>
 <YN9ho7yDFStVw8g3@hirez.programming.kicks-ass.net>
In-Reply-To: <YN9ho7yDFStVw8g3@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 2 Jul 2021 12:53:31 -0700
Message-ID: <CAKwvOdk663=pjf-1gSwqUYz479nStosM1bmO0O3dmP2-FPpLaw@mail.gmail.com>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Bill Wendling <morbo@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
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
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 11:58 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 02, 2021 at 10:26:40AM -0700, Nick Desaulniers wrote:
> > On Fri, Jul 2, 2021 at 5:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > I've asked this before; *what* is missing from LBR samples that's
> > > reponsible for the performance gap?
> >
> > Are we able to collect LBR samples from __init code?  I can imagine
> > trying to launch perf from init/pid 1, but I suspect at that point
> > it's way too late.
> >
> > Increasingly, boot times of hosts (and virtualized guests) are
> > becoming important to us, both in the datacenters and on mobile.
>
> For a guest, possibly, I've no idea how any of that virt crud works.

Oh, another issue we've hit with LBR internally as well is the ability
to access them in virtualized guests.

It looks like support for those did land upstream a few years ago
though, so I'm not sure whether it's a question of us not having
backported/cherry-picked those internally (I'm not on the team
responsible for our datacenter kernels) or if there's some sysadmin
related restrictions where we block access to these MSRs for guests.

Either way, I had an intern last year (2 years ago, perhaps? how long
has this pandemic been...) looking into profiling LLVM, and we hit the
restriction where interns were only given access to VMs in the cloud,
and yet in these VMs could not access LBR.  "Guess we'll find
something else for you to work on then."

More of our developers are moving to cloud based VMs, where they have
access to larger build resources.  Perhaps we just need to work with
our sysadmins to get whatever capability is necessary, at least in
some limited capacity.

Opening a perf report is painful.  For a profile of a kernel build, we
get ~5GB of profile data with LBR, which takes a while to open (is
perf report single threaded?).  This is much better than via dwarf
based call graphs, at which point the data becomes exceedingly painful
to work with.  So LBR is a welcome improvement, when we have access to
it.
-- 
Thanks,
~Nick Desaulniers
