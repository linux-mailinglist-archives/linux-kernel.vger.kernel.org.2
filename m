Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B231E3A882D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhFOSBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhFOSBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:01:12 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53313C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:59:07 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id c8so20058732ybq.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ls/FZA1i/0y96n6QHdzAiBmxirUZEx6+3NzH+PQ+Aaw=;
        b=U1H+3L1jKDU2pifW2reOb84iU75btMNLEwWs9q+whBPWNu8rlLeBBsucbAMvNNeJ0+
         HkAV1K13n4s2n5PFDH8FHSEzQSHx9sn73K4RexbQTYxuBQZ0E0cF2A7FP5KPmlHH4ATh
         bqAlcRYlv+IC1xdjyvmFIsLt+5uqT0f8Mmo8e2tduZM06uvLJyHNgvpwa9FsHwicvN/Q
         w9OmJFZUflFYgrAgcvPUKFKSGsMI8bs0lStCGy7ObuTzksdTJICm+1qUjNRtvHuKOok2
         O2OfRSLECijm20WX1T/eRcEOBVtv5cVsZyZ4nrJBUCKGHO/vNEhiK1A7Fp+4HP4yBxj5
         piFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ls/FZA1i/0y96n6QHdzAiBmxirUZEx6+3NzH+PQ+Aaw=;
        b=iXEuvaa0cyoqL9/0j/OakXcGkJuoXMGgkpdReduNP9/OunIu6DikqcRJDNlioXRdd7
         QtH2ihkWO0LFM5Yub/ay6dIyoGRPT/SIlnX7D5/+vRa3akqRedzOeQAE7nw76pUqPgN2
         ZoF+U1DVkvaB9atj4cB+iInZUjK8RzKMU3ndH+X+iu7nEFvDthLzxhwsRoBxZ7r4hYHK
         aPlYHK0sIfzbG80A5Zyjf07c1/EykUr5nFsVCa6hbSeAKnIRML0YNH+XP9ct2uSbQfpk
         tgG4V6Po8FgEYxddCqy/AHecU5CQxnx/lc8VYYiRfwuKAkqiCkasfuFfCXSAN4PnIDOj
         LmsQ==
X-Gm-Message-State: AOAM5326gxiVES7BSWjXaeeQ44yFr/bg7TQYb8MD0N5gC24hXpg3Rm9R
        V/kq/tWShcyubi8lAZl0wEErJdcMUJcRiStfwb6jMIjqodQ=
X-Google-Smtp-Source: ABdhPJznikc+hT8p2Z4hyRNKDedOWu03+MCpN8vpAUBwd78BW05djeZI6NHBiWvrloT9OXA0ODjbw7Vhwgm1dTHoEek=
X-Received: by 2002:a25:ce8c:: with SMTP id x134mr596863ybe.250.1623779946150;
 Tue, 15 Jun 2021 10:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210608190336.77380-1-hannes@cmpxchg.org> <CAJuCfpHkug8t+yR+dtudANjJgzGs_T4v8_5fEoR0tg7Tw3h3bQ@mail.gmail.com>
 <YMIaiDaDA/lZ+l2j@cmpxchg.org> <CAJuCfpG8giDLgUNTMtEkN6QSoNeDPeQQitgxCaJamgx62Kp21A@mail.gmail.com>
 <YMdqnDMgHSYtt3c2@cmpxchg.org>
In-Reply-To: <YMdqnDMgHSYtt3c2@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 15 Jun 2021 10:58:55 -0700
Message-ID: <CAJuCfpHfxX1ZR1vBwYwTEKTH3VeVw0P33W9R3QO3kt+GnhPzFg@mail.gmail.com>
Subject: Re: [PATCH] psi: fix sampling artifact from pressure file read frequency
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jared Pochtar <jpochtar@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 7:41 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Jun 10, 2021 at 10:33:15AM -0700, Suren Baghdasaryan wrote:
> > On Thu, Jun 10, 2021 at 6:58 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Wed, Jun 09, 2021 at 08:32:51PM -0700, Suren Baghdasaryan wrote:
> > > > On Tue, Jun 8, 2021 at 12:03 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > >
> > > > > Currently, every time a psi pressure file is read, the per-cpu states
> > > > > are collected and aggregated according to the CPU's non-idle time
> > > > > weight. This dynamically changes the sampling period, which means read
> > > > > frequency can introduce variance into the observed results. This is
> > > > > somewhat unexpected for users and can be confusing, when e.g. two
> > > > > nested cgroups with the same workload report different pressure levels
> > > > > just because they have different consumers reading the pressure files.
> > > > >
> > > > > Consider the following two CPU timelines:
> > > > >
> > > > >         CPU0: [ STALL ] [ SLEEP ]
> > > > >         CPU1: [  RUN  ] [  RUN  ]
> > > > >
> > > > > If we sample and aggregate once for the whole period, we get the
> > > > > following total stall time for CPU0:
> > > > >
> > > > >         CPU0 = stall(1) + nonidle(1) / nonidle_total(3) = 0.3
> > > > >
> > > > > But if we sample twice, the total for the period is higher:
> > > > >
> > > > >         CPU0 = stall(1) + nonidle(1) / nonidle_total(2) = 0.5
> > > > >         CPU0 = stall(0) + nonidle(0) / nonidle_total(1) = 0
> > > > >                                                           ---
> > > > >                                                           0.5
> >
> > Could you please clarify that above you are calculating the
> > nonidle/nonidle_total ratio? I understood your description in the text
> > but these calculations seem to claim that:
> >
> > 1+1/3=0.3
> > 1+1/2=0.5
> > 0+0/1=0
> >
> > Clarification would be helpful IMHO.
>
> Oof, my bad, that's a plain typo. The + should be *:
>
> stall(1) * nonidle(1)/nonidle_total(3) = 0.3
>
> vs
>
> stall(1) * nonidle(1)/nonidle_total(2) = 0.5
> stall(0) * nonidle(0)/nonidle_total(1) = 0.0
>
> > Also IIUC the state contributions are:
> > STALL == stall(1) + nonidle(1)
> > SLEEP == stall(0) + nonidle(0)
> > RUN == nonidle(1)
> > Is that correct?
>
> Correct. And nonidle_total is from STALL + RUN + RUN.
>
> > > > > Neither answer is inherently wrong: if the user asks for pressure
> > > > > after half the period, we can't know yet that the CPU will go to sleep
> > > > > right after and its weight would be lower over the combined period.
> > > > >
> > > > > We could normalize the weight averaging to a fixed window regardless
> > > > > of how often stall times themselves are sampled. But that would make
> > > > > reporting less adaptive to sudden changes when the user intentionally
> > > > > uses poll() with short intervals in order to get a higher resolution.
> > > > >
> > > > > For now, simply limit sampling of the pressure file contents to the
> > > > > fixed two-second period already used by the aggregation worker.
> > > >
> > > > Hmm. This is tricky.
> > >
> > > Yes ;)
> > >
> > > > So, userspace-visible effect of this change is that totals will not
> > > > update when the psi file is read unless the psi_period expires.
> > >
> > > That's a visible side effect, but yeah, correct.
> > >
> > > > We used to postpone updating only the averages and now the totals
> > > > will follow suit. Not sure if presenting stale data is better than
> > > > having this dependency on timing of the read. As you noted, the
> > > > value we get is not inherently wrong. But one could argue both ways
> > > > I guess... Having this "quantum" effect when the act of observation
> > > > changes the state of the object is indeed weird, to say the least.
> > >
> > > Yes. Especially *because* we don't update the averages more than once
> > > per 2s window. It gives the impression they would follow steady
> > > sampling, but they're calculated based on total= which is aggregated
> > > on every read.
> > >
> > > Tying the total= updates to the same fixed window presents slightly
> > > less current data, but results in more obvious and intuitive behavior.
> > >
> > > For more current data there is always poll() - which is a better idea
> > > than busy-reading the pressure files for a sub-2s resolution...
> >
> > True, however triggers are rate-limited to one per tracking window
> > (0.5s min), so they have their own limitations.
>
> Right, but if somebody needed *higher* resolution than this, wouldn't
> it make more sense to lift the restrictions on poll() rather than read
> the pressure file several times per second?

Maybe. The current logic is simple: you set up the tracking window
size and you get one trigger once the growth within that window hits
the specified limit with no more triggers in that window. If we want
to support more triggers within one window we would need to reset the
growth after sending the trigger and provide a way to specify the
desired rate-limit (resolution). It's definitely doable but I would
like to see real-life usage before implementing this.

>
> > > > In the paragraph above you say "For now". Do you have an idea that
> > > > could solve the issue with totals being stale while removing this
> > > > dependency on the timing of reads?
> > >
> > > Yeah, it's hinted at in the paragraph before that.
> > >
> > > What we could do is decouple the CPU weight sampling from the stall
> > > time sampling, and use a fixed-window average for the nonidle /
> > > nonidle_total ratio when aggregating. This way, no matter how
> > > frequently you read the stall times, you get the same results.
> > >
> > > However, because the update frequency absent any reads is 2s, that
> > > would be the window size we'd have to use. So while we could present
> > > updated total= on every read, they would still be aggregated based on
> > > a relatively stale CPU load distribution.
> > >
> > > They wouldn't be as current as they might seem - and as current as the
> > > user would assume them to be if they read the file frequently and got
> > > new totals every time. This is even more subtle than the status quo.
> > >
> > > IMO the cleanest interface is simply to be honest and consistent about
> > > the pressure files following a fixed 2s aggregation frequency, and
> > > refer people who need a higher resolution to poll().
> >
> > I would agree, however 2s interval when (memory) pressure rises fast
> > is an eternity. The device can get into OOM state much faster than
> > that. I'm worried that this limitation might render totals useless.
>
> > The change does not pose issues for Android today because we rely on
> > poll() and then we read other stats. However in the ideal world we
> > would use only psi and after receiving the initial trigger we would
> > start reading psi periodically to detect any further spikes. This
> > would require totals to be up-to-date.
>
> I might be missing something, but why manually read the pressure files
> at a high frequency when you get the event? Wouldn't it be possible to
> keep listening for further trigger events from poll() in that case?
>
> Does it all come down to the 500ms window restriction?

Yes, pretty much so. But again, we don't live in an ideal world and
today we have to get some additional metrics, which requires periodic
reads after we receive the initial psi signal.

>
> You're right that this change would make it impossible to use total=
> in the pressure files for manual high-frequency sampling, my question
> is whether that does something that poll() can not, even in theory.

I think you are correct. If we remove rate-limits and psi signal is
all we need to make a kill/no-kill decision then we could rely purely
on psi triggers and would never need high-frequency total= reads.

>
> > These are my thoughts about long-term possible uses but I don't object
> > to this change as a short-term solution. Hopefully nobody uses totals
> > this way today, otherwise they are up for an unpleasant surprise.
>
> Yeah I think that's a valid concern. We shouldn't break such usecases
> if they exist. And it would break them in a non-obvious way. So let's
> table this version of the patch for now.
>
> Another option could be to use a separate aggregator state for avg=
> and total=, such that total= updates stay adaptive to the read
> frequency, but the canned avg= would at least behave more predictably
> for less sophisticated usecases.
>
> The implication would be that manual averaging of total= at sampling
> intervals other than 2s would no longer match up to avg=. But it's
> harder to imagine anybody would rely on that.
>
> What do you think?

That sounds like a good solution to me.
