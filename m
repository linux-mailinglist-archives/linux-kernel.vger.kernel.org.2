Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443A43A3224
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 19:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhFJRf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 13:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJRfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:35:25 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7595DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 10:33:28 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id q21so419581ybg.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQZgtqHoFvDQtzOsjzjM4bsuujWHXpNW50VFqnyNmV0=;
        b=OQ9h7Uov2pZyfkdCMdJyyyJyJ4Ew+XV5HyoLqBb7CJeaBagiswEGDL9+jK5GObnt36
         DYPqjU0hV9c/1GfB0trpw6o/l0iXx+1ED3j+LV1nmMbnsZHyq3icn9LRs/hgHFxocM5S
         HpgiqujzZ7l+byYcpVqb7D5Tk6vAQl0qH+iaLDDKJkvyqk5Tzorn9y0CACADGdwxD0bF
         G6hiXr0utXCkleK3pf+joeM2hoa+QqteSimaUrr8IsAbRMpT6QNsqmY1gs6Qsso6+p2e
         j3hlyWGZEGBPqfGc+tx0qTnMrnlmEHP4Q8yy+d5ySs5SVwDZ3uNIeYo372IOIi47P2OX
         XMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQZgtqHoFvDQtzOsjzjM4bsuujWHXpNW50VFqnyNmV0=;
        b=uGPEw5dXjBhaLewjL9Lq8F+pYmijO9Po8kqACUxDJFg09tX/N6UgmzS6dfPLFAZ358
         T9364hnqvSEqGpEN+sH7JWcJMLqaKDNUFRf57EEY4H1vRSj45vey0+YFvdiKq8l9ECt0
         btmjpZTHUTP+exZ0RYIxhMjHJJIgIpuF32tpoNLC6tr/oGqXVNl6O5lIb/aIRtgw0CEN
         nJV0+ESK++ha1h+zFhfWNnsJ0Y6XpVWt8nwHtglI6vz6gJD9tVWIVhUzpDLiLhuMAGdX
         hNqDhFB1h1KBxOQssQMn2HmWDE0AIfD4mdc0pqUz/ZjgdUQqw1hbbsfJUo78GLLxg3Ni
         J22A==
X-Gm-Message-State: AOAM530Uv1u+uc+cBmgrg5ZtdOs5Qc88tEgIQ7JZNUTqPFEYw5ApDZji
        r9lJUdSuWEfr8eKWqR7nipdts+290qfdafg/qD30VA==
X-Google-Smtp-Source: ABdhPJwiRSqTvaKo25YkZpPnoxdXk4byGk0iq2E+dCalNYZ+br6FHVKKZXQV53U/8NTS248ZUYOqhkVzsLHRxLUeZbs=
X-Received: by 2002:a25:ade3:: with SMTP id d35mr9429844ybe.190.1623346406759;
 Thu, 10 Jun 2021 10:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210608190336.77380-1-hannes@cmpxchg.org> <CAJuCfpHkug8t+yR+dtudANjJgzGs_T4v8_5fEoR0tg7Tw3h3bQ@mail.gmail.com>
 <YMIaiDaDA/lZ+l2j@cmpxchg.org>
In-Reply-To: <YMIaiDaDA/lZ+l2j@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 10 Jun 2021 10:33:15 -0700
Message-ID: <CAJuCfpG8giDLgUNTMtEkN6QSoNeDPeQQitgxCaJamgx62Kp21A@mail.gmail.com>
Subject: Re: [PATCH] psi: fix sampling artifact from pressure file read frequency
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jared Pochtar <jpochtar@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 6:58 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Jun 09, 2021 at 08:32:51PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Jun 8, 2021 at 12:03 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > Currently, every time a psi pressure file is read, the per-cpu states
> > > are collected and aggregated according to the CPU's non-idle time
> > > weight. This dynamically changes the sampling period, which means read
> > > frequency can introduce variance into the observed results. This is
> > > somewhat unexpected for users and can be confusing, when e.g. two
> > > nested cgroups with the same workload report different pressure levels
> > > just because they have different consumers reading the pressure files.
> > >
> > > Consider the following two CPU timelines:
> > >
> > >         CPU0: [ STALL ] [ SLEEP ]
> > >         CPU1: [  RUN  ] [  RUN  ]
> > >
> > > If we sample and aggregate once for the whole period, we get the
> > > following total stall time for CPU0:
> > >
> > >         CPU0 = stall(1) + nonidle(1) / nonidle_total(3) = 0.3
> > >
> > > But if we sample twice, the total for the period is higher:
> > >
> > >         CPU0 = stall(1) + nonidle(1) / nonidle_total(2) = 0.5
> > >         CPU0 = stall(0) + nonidle(0) / nonidle_total(1) = 0
> > >                                                           ---
> > >                                                           0.5

Could you please clarify that above you are calculating the
nonidle/nonidle_total ratio? I understood your description in the text
but these calculations seem to claim that:

1+1/3=0.3
1+1/2=0.5
0+0/1=0

Clarification would be helpful IMHO.

Also IIUC the state contributions are:
STALL == stall(1) + nonidle(1)
SLEEP == stall(0) + nonidle(0)
RUN == nonidle(1)
Is that correct?

> > >
> > > Neither answer is inherently wrong: if the user asks for pressure
> > > after half the period, we can't know yet that the CPU will go to sleep
> > > right after and its weight would be lower over the combined period.
> > >
> > > We could normalize the weight averaging to a fixed window regardless
> > > of how often stall times themselves are sampled. But that would make
> > > reporting less adaptive to sudden changes when the user intentionally
> > > uses poll() with short intervals in order to get a higher resolution.
> > >
> > > For now, simply limit sampling of the pressure file contents to the
> > > fixed two-second period already used by the aggregation worker.
> >
> > Hmm. This is tricky.
>
> Yes ;)
>
> > So, userspace-visible effect of this change is that totals will not
> > update when the psi file is read unless the psi_period expires.
>
> That's a visible side effect, but yeah, correct.
>
> > We used to postpone updating only the averages and now the totals
> > will follow suit. Not sure if presenting stale data is better than
> > having this dependency on timing of the read. As you noted, the
> > value we get is not inherently wrong. But one could argue both ways
> > I guess... Having this "quantum" effect when the act of observation
> > changes the state of the object is indeed weird, to say the least.
>
> Yes. Especially *because* we don't update the averages more than once
> per 2s window. It gives the impression they would follow steady
> sampling, but they're calculated based on total= which is aggregated
> on every read.
>
> Tying the total= updates to the same fixed window presents slightly
> less current data, but results in more obvious and intuitive behavior.
>
> For more current data there is always poll() - which is a better idea
> than busy-reading the pressure files for a sub-2s resolution...

True, however triggers are rate-limited to one per tracking window
(0.5s min), so they have their own limitations.

>
> > In the paragraph above you say "For now". Do you have an idea that
> > could solve the issue with totals being stale while removing this
> > dependency on the timing of reads?
>
> Yeah, it's hinted at in the paragraph before that.
>
> What we could do is decouple the CPU weight sampling from the stall
> time sampling, and use a fixed-window average for the nonidle /
> nonidle_total ratio when aggregating. This way, no matter how
> frequently you read the stall times, you get the same results.
>
> However, because the update frequency absent any reads is 2s, that
> would be the window size we'd have to use. So while we could present
> updated total= on every read, they would still be aggregated based on
> a relatively stale CPU load distribution.
>
> They wouldn't be as current as they might seem - and as current as the
> user would assume them to be if they read the file frequently and got
> new totals every time. This is even more subtle than the status quo.
>
> IMO the cleanest interface is simply to be honest and consistent about
> the pressure files following a fixed 2s aggregation frequency, and
> refer people who need a higher resolution to poll().

I would agree, however 2s interval when (memory) pressure rises fast
is an eternity. The device can get into OOM state much faster than
that. I'm worried that this limitation might render totals useless.
The change does not pose issues for Android today because we rely on
poll() and then we read other stats. However in the ideal world we
would use only psi and after receiving the initial trigger we would
start reading psi periodically to detect any further spikes. This
would require totals to be up-to-date.
These are my thoughts about long-term possible uses but I don't object
to this change as a short-term solution. Hopefully nobody uses totals
this way today, otherwise they are up for an unpleasant surprise.
