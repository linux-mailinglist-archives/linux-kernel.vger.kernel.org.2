Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B543A692F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhFNOov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:44:51 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:37829 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhFNOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:44:50 -0400
Received: by mail-qk1-f175.google.com with SMTP id c5so1383154qka.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sNiSUhmuo6PUli3dytUxvfq21Zm6/lkb+kn6HsNIbC0=;
        b=JNVTS1hKDRXaAVe9J9evET8zCGt6qlqMnrEICeJPguMoSf4nmVdLJvXp1T71WE+hUV
         D6UrJ/F1eL73a10r0/I+1llZ/DrpPZCvX9IWKpMTUDz0MhDrWSeaDmZy3oJ5YZ3pE+BL
         tnUIGj/X/729s5HLydkLrS0LSdKgj1hT4rVrbpiES0tIVeI6KoJMOJiKtJ/tnRtAEhnx
         pInFo8g9pQMj6eB4aBWyWzrZdgbmFHvnf5DA89oNFB0jGBXidLbl32pXioBoVIJmkHDe
         yLPkTSZ1Eta+VNASjHuGjB5A4e/FCTzow8A8V/OpM0WMMx94lZx53TFXYpDCjjdjbZgO
         RhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sNiSUhmuo6PUli3dytUxvfq21Zm6/lkb+kn6HsNIbC0=;
        b=Ba8hIk5/XVSTthS7RuUdfJRo577Z5jjR2I69nqZqWvX+lZPlIUM0s3Sby42sdocUw2
         CTuphg8f+d1iHRRyaq5GGp1nPSOJoG1mKQ92650Qe9WwosXdpoKmd7KuZpbqcmLHhrfc
         enoRMrQ8g89ZWX4ce5kBGvMphhbbsZ2He+mRfw0rMFm5e2xmJl5HqTCMyBdtIg0wVRhe
         MVNFTG86v3sG3iUYbuGm2UDyIUKsEESUYx/+rOrhZpYRIXLg5BP9dzpAlkQ/JKvIfhko
         CxKYHJTuMS2o4OgtvL/vL0hCliurMB6MARAPTH1AYY6tvMYpv+0qMpDLK2DYT/S0G1Cd
         sg7A==
X-Gm-Message-State: AOAM533CXJ76IGPRylyBf31SQyX9uf/DiiFvz3I7daVLkKbJhxNE5Cs+
        SLUckqYwJNUqCWk8IjkubZXG0g==
X-Google-Smtp-Source: ABdhPJxeliyij6q3b2jMgsYMEQDyQtOwa0F/aSr0pJ5FBycij9y2XGSnP4WHMI8T1yxzWq3iqC7LDA==
X-Received: by 2002:a05:620a:d45:: with SMTP id o5mr16395987qkl.319.1623681694162;
        Mon, 14 Jun 2021 07:41:34 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id o12sm10123665qki.44.2021.06.14.07.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 07:41:32 -0700 (PDT)
Date:   Mon, 14 Jun 2021 10:41:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jared Pochtar <jpochtar@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH] psi: fix sampling artifact from pressure file read
 frequency
Message-ID: <YMdqnDMgHSYtt3c2@cmpxchg.org>
References: <20210608190336.77380-1-hannes@cmpxchg.org>
 <CAJuCfpHkug8t+yR+dtudANjJgzGs_T4v8_5fEoR0tg7Tw3h3bQ@mail.gmail.com>
 <YMIaiDaDA/lZ+l2j@cmpxchg.org>
 <CAJuCfpG8giDLgUNTMtEkN6QSoNeDPeQQitgxCaJamgx62Kp21A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG8giDLgUNTMtEkN6QSoNeDPeQQitgxCaJamgx62Kp21A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 10:33:15AM -0700, Suren Baghdasaryan wrote:
> On Thu, Jun 10, 2021 at 6:58 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Jun 09, 2021 at 08:32:51PM -0700, Suren Baghdasaryan wrote:
> > > On Tue, Jun 8, 2021 at 12:03 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > Currently, every time a psi pressure file is read, the per-cpu states
> > > > are collected and aggregated according to the CPU's non-idle time
> > > > weight. This dynamically changes the sampling period, which means read
> > > > frequency can introduce variance into the observed results. This is
> > > > somewhat unexpected for users and can be confusing, when e.g. two
> > > > nested cgroups with the same workload report different pressure levels
> > > > just because they have different consumers reading the pressure files.
> > > >
> > > > Consider the following two CPU timelines:
> > > >
> > > >         CPU0: [ STALL ] [ SLEEP ]
> > > >         CPU1: [  RUN  ] [  RUN  ]
> > > >
> > > > If we sample and aggregate once for the whole period, we get the
> > > > following total stall time for CPU0:
> > > >
> > > >         CPU0 = stall(1) + nonidle(1) / nonidle_total(3) = 0.3
> > > >
> > > > But if we sample twice, the total for the period is higher:
> > > >
> > > >         CPU0 = stall(1) + nonidle(1) / nonidle_total(2) = 0.5
> > > >         CPU0 = stall(0) + nonidle(0) / nonidle_total(1) = 0
> > > >                                                           ---
> > > >                                                           0.5
> 
> Could you please clarify that above you are calculating the
> nonidle/nonidle_total ratio? I understood your description in the text
> but these calculations seem to claim that:
> 
> 1+1/3=0.3
> 1+1/2=0.5
> 0+0/1=0
> 
> Clarification would be helpful IMHO.

Oof, my bad, that's a plain typo. The + should be *:

stall(1) * nonidle(1)/nonidle_total(3) = 0.3

vs

stall(1) * nonidle(1)/nonidle_total(2) = 0.5
stall(0) * nonidle(0)/nonidle_total(1) = 0.0

> Also IIUC the state contributions are:
> STALL == stall(1) + nonidle(1)
> SLEEP == stall(0) + nonidle(0)
> RUN == nonidle(1)
> Is that correct?

Correct. And nonidle_total is from STALL + RUN + RUN.

> > > > Neither answer is inherently wrong: if the user asks for pressure
> > > > after half the period, we can't know yet that the CPU will go to sleep
> > > > right after and its weight would be lower over the combined period.
> > > >
> > > > We could normalize the weight averaging to a fixed window regardless
> > > > of how often stall times themselves are sampled. But that would make
> > > > reporting less adaptive to sudden changes when the user intentionally
> > > > uses poll() with short intervals in order to get a higher resolution.
> > > >
> > > > For now, simply limit sampling of the pressure file contents to the
> > > > fixed two-second period already used by the aggregation worker.
> > >
> > > Hmm. This is tricky.
> >
> > Yes ;)
> >
> > > So, userspace-visible effect of this change is that totals will not
> > > update when the psi file is read unless the psi_period expires.
> >
> > That's a visible side effect, but yeah, correct.
> >
> > > We used to postpone updating only the averages and now the totals
> > > will follow suit. Not sure if presenting stale data is better than
> > > having this dependency on timing of the read. As you noted, the
> > > value we get is not inherently wrong. But one could argue both ways
> > > I guess... Having this "quantum" effect when the act of observation
> > > changes the state of the object is indeed weird, to say the least.
> >
> > Yes. Especially *because* we don't update the averages more than once
> > per 2s window. It gives the impression they would follow steady
> > sampling, but they're calculated based on total= which is aggregated
> > on every read.
> >
> > Tying the total= updates to the same fixed window presents slightly
> > less current data, but results in more obvious and intuitive behavior.
> >
> > For more current data there is always poll() - which is a better idea
> > than busy-reading the pressure files for a sub-2s resolution...
> 
> True, however triggers are rate-limited to one per tracking window
> (0.5s min), so they have their own limitations.

Right, but if somebody needed *higher* resolution than this, wouldn't
it make more sense to lift the restrictions on poll() rather than read
the pressure file several times per second?

> > > In the paragraph above you say "For now". Do you have an idea that
> > > could solve the issue with totals being stale while removing this
> > > dependency on the timing of reads?
> >
> > Yeah, it's hinted at in the paragraph before that.
> >
> > What we could do is decouple the CPU weight sampling from the stall
> > time sampling, and use a fixed-window average for the nonidle /
> > nonidle_total ratio when aggregating. This way, no matter how
> > frequently you read the stall times, you get the same results.
> >
> > However, because the update frequency absent any reads is 2s, that
> > would be the window size we'd have to use. So while we could present
> > updated total= on every read, they would still be aggregated based on
> > a relatively stale CPU load distribution.
> >
> > They wouldn't be as current as they might seem - and as current as the
> > user would assume them to be if they read the file frequently and got
> > new totals every time. This is even more subtle than the status quo.
> >
> > IMO the cleanest interface is simply to be honest and consistent about
> > the pressure files following a fixed 2s aggregation frequency, and
> > refer people who need a higher resolution to poll().
> 
> I would agree, however 2s interval when (memory) pressure rises fast
> is an eternity. The device can get into OOM state much faster than
> that. I'm worried that this limitation might render totals useless.

> The change does not pose issues for Android today because we rely on
> poll() and then we read other stats. However in the ideal world we
> would use only psi and after receiving the initial trigger we would
> start reading psi periodically to detect any further spikes. This
> would require totals to be up-to-date.

I might be missing something, but why manually read the pressure files
at a high frequency when you get the event? Wouldn't it be possible to
keep listening for further trigger events from poll() in that case?

Does it all come down to the 500ms window restriction?

You're right that this change would make it impossible to use total=
in the pressure files for manual high-frequency sampling, my question
is whether that does something that poll() can not, even in theory.

> These are my thoughts about long-term possible uses but I don't object
> to this change as a short-term solution. Hopefully nobody uses totals
> this way today, otherwise they are up for an unpleasant surprise.

Yeah I think that's a valid concern. We shouldn't break such usecases
if they exist. And it would break them in a non-obvious way. So let's
table this version of the patch for now.

Another option could be to use a separate aggregator state for avg=
and total=, such that total= updates stay adaptive to the read
frequency, but the canned avg= would at least behave more predictably
for less sophisticated usecases.

The implication would be that manual averaging of total= at sampling
intervals other than 2s would no longer match up to avg=. But it's
harder to imagine anybody would rely on that.

What do you think?
