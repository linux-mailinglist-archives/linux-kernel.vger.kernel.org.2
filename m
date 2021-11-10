Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5A544C429
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhKJPTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbhKJPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:19:29 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E5BC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:16:41 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id be32so5753357oib.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhJM/MLfTV/z8SAypDrnIhxhC1SIB1hGJ/onS/dmr7c=;
        b=UXx5qFQSpDSas+KYcgzvzVRUTV2zv6TB9J/xZToRx+zlV2QWoSMGY/6NSprCwy/bin
         SansktddX4FuncJFHojBZpxvscdAHgwq+KlMLCScNoGS6mNJSdlG8FqLdS6RL6xU+h+D
         Iti+gYgW7Z/0rGDkZdxj0ncpRbtoR3TVahrOre1SVjMej7qK3bZSH2OcusaAmmQ9LaeM
         QsibTTXZj5OOSr1X0Y8CT8m1RgXKbUEk0mNSrG3gWgOsO6lNZDcJ2l3PVVOCC3zv+L/9
         0KdGr86gdK6YIEmqUw4jqP8mcQzM4Vcy2eLVOo0GBnb2zFmBt7WpVQh/PUt6mMBLb/XO
         DF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhJM/MLfTV/z8SAypDrnIhxhC1SIB1hGJ/onS/dmr7c=;
        b=yZBcnFxYb0Bc9jfL0nOX1ZbBORwlWxe0jJ1iP1uivVxEBZKEXUwtw5mjl6ncBzg8Jr
         GnoLgrLTwbKOY8lcUw+aOi+Cm6/X8TIEYcGKHHMlRce6Z+mr/GNLJiV5Y4xRYL4gpu5I
         rkueQSB1Ik0yUiwJPo/1Ad0tqZhmp6gHGDVpodjroT91Z7ZfzM34mByf49o3JO9Foabd
         k7VBULNDEyMK99MkQBupvyb3ldjUWiMBKyBc/kKtIYecfH4JSY1p67OSd4Y1KPgPTZmu
         T6SlaJ3vzkCoKrGkQFEkif1x0eDgokh/n9VOc0kBZbjJl/V8G5KvIpp5wEELy1t5lFXV
         IfIg==
X-Gm-Message-State: AOAM533hhjqEm2n8Nqw3Lug6VYsjRtN/eWoLvJICwLDpdOq0J0uqcUQi
        lMemxCjD9D2t7inCIa/7RLjz6eE8i7W6oLegJrcycw==
X-Google-Smtp-Source: ABdhPJxCSzztq5srD80k9jBcOJ7KCw9KMcEOyhV0yaaCpoz1iuF0M5cigDbQ3H7FhcbiRK5KJFeLa1DW1ELE093f20s=
X-Received: by 2002:a05:6808:1903:: with SMTP id bf3mr2331029oib.7.1636557400865;
 Wed, 10 Nov 2021 07:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20211109151057.3489223-1-valentin.schneider@arm.com>
 <20211110011738.GD288354@lothringen> <beec14cee84de7a4bedd7a63c2acdf150a82bc09.camel@gmx.de>
 <87h7cks16n.mognet@arm.com> <87bl2srrvq.mognet@arm.com> <CANpmjNN7mW=7jjkXDPHV6=SbjAMYq=vFRDi+6aGFCdPFm1LZ-A@mail.gmail.com>
In-Reply-To: <CANpmjNN7mW=7jjkXDPHV6=SbjAMYq=vFRDi+6aGFCdPFm1LZ-A@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 10 Nov 2021 16:16:29 +0100
Message-ID: <CANpmjNNyqcQ-brSJnXw7URxdcfywABrsZUSuwmYpPKqE_drEpQ@mail.gmail.com>
Subject: Re: [PATCH] sched: Split preemption model selection between DYNAMIC & !DYNAMIC
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 at 16:03, Marco Elver <elver@google.com> wrote:
[...]
> And the kcsan_test.c change can be reverted, I think it's broken
> either way now, because it wants the dynamic state (the test still
> works in most configs, so fixing this isn't super urgent). Similarly
> for kernel/trace/trace.c, which appears mainly cosmetic. So I'd defer
> changing these until there are real helpers to get the true preemption
> behaviour of the running system.

I just realised that in both these cases the original version is less
broken than the below, because the non-suffixed CONFIG_PREEMPT*
variables now denote the dynamic default. So if someone doesn't use
'preempt=' at boot, the original code will actually do the right
thing.

> > diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> > index dc55fd5a36fc..845b17cf7811 100644
> > --- a/kernel/kcsan/kcsan_test.c
> > +++ b/kernel/kcsan/kcsan_test.c
> > @@ -1005,13 +1005,13 @@ static const void *nthreads_gen_params(const void *prev, char *desc)
> >         else
> >                 nthreads *= 2;
> >
> > -       if (!IS_ENABLED(CONFIG_PREEMPT) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
> > +       if (!IS_ENABLED(CONFIG_PREEMPTION) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
> >                 /*
> >                  * Without any preemption, keep 2 CPUs free for other tasks, one
> >                  * of which is the main test case function checking for
> >                  * completion or failure.
> >                  */
> > -               const long min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE) ? 2 : 0;
> > +               const long min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE_BUILD) ? 2 : 0;
> >                 const long min_required_cpus = 2 + min_unused_cpus;
> >
> >                 if (num_online_cpus() < min_required_cpus) {
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 7896d30d90f7..3b3226ffbafa 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -4271,11 +4271,11 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
> >                    entries,
> >                    total,
> >                    buf->cpu,
> > -#if defined(CONFIG_PREEMPT_NONE)
> > +#if defined(CONFIG_PREEMPT_NONE_BUILD)
> >                    "server",
> > -#elif defined(CONFIG_PREEMPT_VOLUNTARY)
> > +#elif defined(CONFIG_PREEMPT_VOLUNTARY_BUILD)
> >                    "desktop",
> > -#elif defined(CONFIG_PREEMPT)
> > +#elif defined(CONFIG_PREEMPT_BUILD)
> >                    "preempt",
> >  #elif defined(CONFIG_PREEMPT_RT)
> >                    "preempt_rt",
