Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8206133FC16
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 01:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhCRAG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 20:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhCRAGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:06:44 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F943C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 17:06:43 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 130so327131qkh.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 17:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xnnnpd2csmTZ0lK2n7cLmK6b42cUVgaKFGkxOmUg7Vo=;
        b=J9sGEwgRnAT1eVln6y/b3oPEwiWWUasu9IJXEcghKp3qlfU8XLyqUm+Xkw0WyJIC5H
         XdwqmUx+ny9U4qqSt0HWMmnmocZwrFk/+XhwcqZILYKBsgrwbtpB4jbRigXsRwZTuiZW
         pHhiRrwzpO+9p93zRonA5LSCBOufk5xGtXCHb7h6MZCg/Ce6tBdWrYnavHdETpBU+mXY
         AAeV+JcI+OA66FvSn3LujLO6IEXPvxJHlizkfX16K6DHxKWVFcaGHNn4fg4Cy4WiGv/V
         GSOrN+3N/aBBtJOdx2vXT6LGqgKD6FFvaVxHNETxF+/CdRU7xsng7pQX38UvnD7HdMxa
         iFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xnnnpd2csmTZ0lK2n7cLmK6b42cUVgaKFGkxOmUg7Vo=;
        b=AHKJFkow61PYGhASO04Uky5Ey+PwgI9XhER6EK6+wmtvyNm/+1QWGbJW0EKbTuVo/3
         bu/2CCpd00fU8n1a+Qvpy78ilLMLYlolaWg8x9xIAWDGQxPFMGMnPbLeyPZFyYHWVs+k
         dIkhVVq3Vh6M4CXvuTJEiHFOxATVJPmypf5QivKsauMQbydoKbJ/wUObv9NtinzIQaQ1
         L5XQE4//KW+8r9cg/ffAtEoyvBUHhJFKTvZ/dj383RITOoO0X/SysCKy7poTMq42qkO6
         Ks45r/qeNiWjeri71hmIpcJsA7bYMz6VWNBWM+5RKp9OrBEfa/Mv28fqRlECkiyIPyIf
         fPLg==
X-Gm-Message-State: AOAM531gTwD7F18OgGu0LHq6EtzA5FKMzucXhCf3DzyXt76cMmyJ/Far
        lf7NQoBSXLy/aZVYog9LNi2mKzHfECyvhlFfCMcmlg==
X-Google-Smtp-Source: ABdhPJz7keNgboG0A5QU6NVwQhRdr3IXK5N/8Lw9uhEOO1HnJqHWVdhKlgKFZVtTJnHfrNfBQXCMqDPWktT6EPO6q4I=
X-Received: by 2002:a37:a643:: with SMTP id p64mr1862917qke.276.1616026002308;
 Wed, 17 Mar 2021 17:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210317045949.1584952-1-joshdon@google.com> <20210317082550.GA3881262@gmail.com>
In-Reply-To: <20210317082550.GA3881262@gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 17 Mar 2021 17:06:31 -0700
Message-ID: <CABk29NvGx6KQa_+RU-6xmL6mUeBrqZjH1twOw93SCVD-NZkbMQ@mail.gmail.com>
Subject: Re: [PATCH] sched: Warn on long periods of pending need_resched
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 1:25 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> * Josh Don <joshdon@google.com> wrote:
>
> > If resched_latency_warn_ms is set to the default value, only one warning
> > will be produced per boot.
>
> Looks like a value hack, should probably be a separate flag,
> defaulting to warn-once.

Agreed, done.

> > This warning only exists under CONFIG_SCHED_DEBUG. If it goes off, it is
> > likely that there is a missing cond_resched() somewhere.
>
> CONFIG_SCHED_DEBUG is default-y, so most distros have it enabled.

To avoid log spam for people who don't care, I was considering having
the feature default disabled. Perhaps a better alternative is to only
show a single line warning and not print the full backtrace by
default. Does the latter sound good to you?

> > +#ifdef CONFIG_KASAN
> > +#define RESCHED_DEFAULT_WARN_LATENCY_MS 101
> > +#define RESCHED_BOOT_QUIET_SEC 600
> > +#else
> > +#define RESCHED_DEFAULT_WARN_LATENCY_MS 51
> > +#define RESCHED_BOOT_QUIET_SEC 300
> >  #endif
> > +int sysctl_resched_latency_warn_ms = RESCHED_DEFAULT_WARN_LATENCY_MS;
> > +#endif /* CONFIG_SCHED_DEBUG */
>
> I'd really just make this a single value - say 100 or 200 msecs.

Replacing these both with a single value (the more conservative
default of 100ms and 600s).

> > +static inline void resched_latency_warn(int cpu, u64 latency)
> > +{
> > +     static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
> > +
> > +     WARN(__ratelimit(&latency_check_ratelimit),
> > +          "CPU %d: need_resched set for > %llu ns (%d ticks) "
> > +          "without schedule\n",
> > +          cpu, latency, cpu_rq(cpu)->ticks_without_resched);
> > +}
>
> Could you please put the 'sched:' prefix into scheduler warnings.
> Let's have a bit of a namespace structure in new warnings.

Sounds good, done.
