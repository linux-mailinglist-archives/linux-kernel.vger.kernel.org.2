Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BB3347D36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhCXQCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbhCXQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:01:41 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD697C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:01:40 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id k27so5582167vki.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrfhCwkvhJEe1YjR/PZGEefYmTNqHgD+9tU80o9WXqk=;
        b=lRFJ1gwnJONfswU8ayDv9bfkTUV47ZA6hGBh4eUQCU2vBGYB/eOISBLA4Ok7hDWmdD
         0HmZEmOMyofWLCUyiwDaG8Fb+/ds0boyWaeg8/MulrDYM1XSGi845YeTrXnE7pYzUzks
         3l8VlQz+fAUvd30QXNiXr7gg9kycciRBufpMLnUXs5vRXk6m4Q8aM7Q2ZzQuJx0xDB4K
         JoB0I/RUA6mVef0rEFo8tcCZMhFiAAXfKiyuZegXJxEt8YjQ88dURJmOTEcrKiTJWRlO
         iYxGOUYgKR7yOuyyqh+OsocenYInezCzFNjZsg6Gg0UiKPjG146l4YAF8Bsm5jEEfr+2
         Ng/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrfhCwkvhJEe1YjR/PZGEefYmTNqHgD+9tU80o9WXqk=;
        b=iACXzaRBEEXG6/yoy55LJJE5e9J11QPB17kacPs5i3DCfaW8LePSenEKn90glu8jKq
         Oj7JxWNpzI4JM1SvZTnqJRAR2CToGz9Sez4tObbiDLWWye2bBH9YUD5Ya6g8vopzgxkq
         gufQbR73QyN9oTEoHyJRziB8dc9upsapT2BDkTanh+ZGRkZYa7c/P9EdougvQmANSO2U
         M0wAL7IADeA5tjIO4HRtVM3tGzk62++6wt0Yd4P/Ra+yUEUA/VZFHGdPuHg+YTk0A3rB
         pPPNHFNk0soqoMasO45f8ZMLaRSKW61J07MgNTsW/Eb/wO5YxZUwPvNCVB0a0toQBzbg
         2ZPA==
X-Gm-Message-State: AOAM533RoZVj89ArVAT4PG/ctPFWD2XV2/ZDDr46Qvn0duqUojpKs3Tq
        2jaF2Kusgeaml8vqgevJuWZQ9HDOYzIHNq3OP5WMtQ==
X-Google-Smtp-Source: ABdhPJxBqKoPg9sDxI1jFZWpgx8IkGoD1SjAmG5/5yH5w8c5XgqO+Z3k9G+jKl2iOGBDYyKYgKS1yRhupJoTCPO0zuc=
X-Received: by 2002:a05:6122:54:: with SMTP id q20mr2299766vkn.3.1616601698907;
 Wed, 24 Mar 2021 09:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210322170711.1855115-1-arnd@kernel.org> <20210322153214.25d869b1@gandalf.local.home>
 <YFkCZuOwe37d2bV+@hirez.programming.kicks-ass.net> <CAK8P3a2sz4emewH_HA+nsf0e5tP6qtAxhBOFucmzW4OPDJASdQ@mail.gmail.com>
 <20210322172921.56350a69@gandalf.local.home> <YFmdJlESrCh4iC9A@hirez.programming.kicks-ass.net>
 <0f4679d6-44a4-d045-f249-a9cffb126fd4@rasmusvillemoes.dk>
In-Reply-To: <0f4679d6-44a4-d045-f249-a9cffb126fd4@rasmusvillemoes.dk>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 24 Mar 2021 09:01:27 -0700
Message-ID: <CABCJKuf1-GWda9_BiBO=nNP_drh3a8471G+LEqPzdVrLBhVqZQ@mail.gmail.com>
Subject: Re: [PATCH] static_call: fix function type mismatch
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 5:46 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 23/03/2021 08.47, Peter Zijlstra wrote:
> > On Mon, Mar 22, 2021 at 05:29:21PM -0400, Steven Rostedt wrote:
> >> On Mon, 22 Mar 2021 22:18:17 +0100
> >> Arnd Bergmann <arnd@kernel.org> wrote:
> >>
> >>> I think the code works correctly on all architectures we support because
> >>> both 'int' and 'long' are returned in a register with any unused bits cleared.
> >>> It is however undefined behavior in C because 'int' and 'long' are not
> >>> compatible types, and the calling conventions don't have to allow this.
> >>
> >> Static calls (and so do tracepoints) currently rely on these kind of
> >> "undefined behavior" in C. This isn't the only UB that it relies on.
> >
> > Right, most of the kernel lives in UB. That's what we have -fwrapv
> > -fno-strict-aliassing and lots of other bits for, to 'fix' the stupid C
> > standard.
> >
> > This is one more of them, so just ignore the warning and make it go
> > away:
> >
> >  -Wno-cast-function-type
> >
> > seems to be the magic knob.
> >
>
> That can be done for now, but I think something has to be done if CFI is
> to become a thing.
>
> Sami, what happens if you try to boot a
> CONFIG_CFI_CLANG+CONFIG_PREEMPT_DYNAMIC kernel?

Seems to boot just fine. CFI instrumentation is only for
compiler-generated indirect calls. Casting functions to different
types is fine as long as you don't end up calling them using an
incorrect pointer type.

Sami
