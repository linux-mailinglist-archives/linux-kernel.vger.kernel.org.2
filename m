Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EC33A2D96
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhFJOAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhFJOAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:00:52 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE135C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 06:58:39 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i68so23810186qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 06:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qbWXLgylg1lCqYHMLSK3fde/7z8bs1MrbZWTWcmNHtA=;
        b=ybTyd277v1HAHoj3lzgpzg884bHkAU8Mx/AM9qqUT6Tv84dimmMfLaHGHVLo5EDmv4
         8Qg8HivOINUoFhHCgQ8Q5TaswMrbkPnOyfsb0frwfATbRsSDNKHKQZwbjNeL9jBQUrao
         L+untWLtc30b9aEMhbMFhIqNYXuu9JI5/0NHCKTDIiPudQvjISP/HHsGWm/zH4yhJyJ9
         aX04zCmtaRhNBpAUVygPwHROWaV4lGjMCfD33fWkiNNUl0kMEjbu6Q4FEltW4yhQSAN2
         lmAZ+CciEzzKv9jC8ixEt65TGsCsbWYzkOaVUZ9I4cP26b2QriYoTR4uVYGIEdhLE0rn
         8XpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qbWXLgylg1lCqYHMLSK3fde/7z8bs1MrbZWTWcmNHtA=;
        b=CzMMKsdPtFsfHb+VKUOlI2c+qhEld2XYMhcxwyykMuOa4MIJ+Xal7DmyHSQ8aGkXxR
         bCUNU5/oqAB3VkKG/wFt0vZZJnePF4BNf7srxFFr7S8pHrLpOkQO6S5rNg94iwjuTWuE
         vRa68yhoMZeTniUFVhTr16D/RQWn0mAqFUONP/JWu0jAC3+Kbza5zfJ9MyyiKwiMEjfF
         5fc2kpdy5cq5lhyFC4VNjx6kvZaeFOqhRwcMfLEqQ8ybJq0oXyCnS4ZlN8dnPzWlL2MD
         2FlJzSz5DhxzbOTl85B5/O0hSzZb/3PDA3g56wnmOP6dnAJ0MRJmpdD84CynhU6Jxovp
         Ox5A==
X-Gm-Message-State: AOAM531yKIQPZ9IUy9PuZsXbb/pRFkDD+Wxiizkv7N/+qpcX65I9YTz+
        EmNdhbT8BQIgPoL2ZXNR92lEQw==
X-Google-Smtp-Source: ABdhPJwLeaSO+cbGHDFgIrr/v1x2Zi+WZ+QN+xXfxfAF7DDOrCBUTEsQLzrRzK6YfBidsqmteEKtDw==
X-Received: by 2002:a37:a793:: with SMTP id q141mr4713888qke.107.1623333515840;
        Thu, 10 Jun 2021 06:58:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2165])
        by smtp.gmail.com with ESMTPSA id y20sm2187531qtv.64.2021.06.10.06.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 06:58:35 -0700 (PDT)
Date:   Thu, 10 Jun 2021 09:58:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jared Pochtar <jpochtar@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH] psi: fix sampling artifact from pressure file read
 frequency
Message-ID: <YMIaiDaDA/lZ+l2j@cmpxchg.org>
References: <20210608190336.77380-1-hannes@cmpxchg.org>
 <CAJuCfpHkug8t+yR+dtudANjJgzGs_T4v8_5fEoR0tg7Tw3h3bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHkug8t+yR+dtudANjJgzGs_T4v8_5fEoR0tg7Tw3h3bQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 08:32:51PM -0700, Suren Baghdasaryan wrote:
> On Tue, Jun 8, 2021 at 12:03 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Currently, every time a psi pressure file is read, the per-cpu states
> > are collected and aggregated according to the CPU's non-idle time
> > weight. This dynamically changes the sampling period, which means read
> > frequency can introduce variance into the observed results. This is
> > somewhat unexpected for users and can be confusing, when e.g. two
> > nested cgroups with the same workload report different pressure levels
> > just because they have different consumers reading the pressure files.
> >
> > Consider the following two CPU timelines:
> >
> >         CPU0: [ STALL ] [ SLEEP ]
> >         CPU1: [  RUN  ] [  RUN  ]
> >
> > If we sample and aggregate once for the whole period, we get the
> > following total stall time for CPU0:
> >
> >         CPU0 = stall(1) + nonidle(1) / nonidle_total(3) = 0.3
> >
> > But if we sample twice, the total for the period is higher:
> >
> >         CPU0 = stall(1) + nonidle(1) / nonidle_total(2) = 0.5
> >         CPU0 = stall(0) + nonidle(0) / nonidle_total(1) = 0
> >                                                           ---
> >                                                           0.5
> >
> > Neither answer is inherently wrong: if the user asks for pressure
> > after half the period, we can't know yet that the CPU will go to sleep
> > right after and its weight would be lower over the combined period.
> >
> > We could normalize the weight averaging to a fixed window regardless
> > of how often stall times themselves are sampled. But that would make
> > reporting less adaptive to sudden changes when the user intentionally
> > uses poll() with short intervals in order to get a higher resolution.
> >
> > For now, simply limit sampling of the pressure file contents to the
> > fixed two-second period already used by the aggregation worker.
> 
> Hmm. This is tricky.

Yes ;)

> So, userspace-visible effect of this change is that totals will not
> update when the psi file is read unless the psi_period expires.

That's a visible side effect, but yeah, correct.

> We used to postpone updating only the averages and now the totals
> will follow suit. Not sure if presenting stale data is better than
> having this dependency on timing of the read. As you noted, the
> value we get is not inherently wrong. But one could argue both ways
> I guess... Having this "quantum" effect when the act of observation
> changes the state of the object is indeed weird, to say the least.

Yes. Especially *because* we don't update the averages more than once
per 2s window. It gives the impression they would follow steady
sampling, but they're calculated based on total= which is aggregated
on every read.

Tying the total= updates to the same fixed window presents slightly
less current data, but results in more obvious and intuitive behavior.

For more current data there is always poll() - which is a better idea
than busy-reading the pressure files for a sub-2s resolution...

> In the paragraph above you say "For now". Do you have an idea that
> could solve the issue with totals being stale while removing this
> dependency on the timing of reads?

Yeah, it's hinted at in the paragraph before that.

What we could do is decouple the CPU weight sampling from the stall
time sampling, and use a fixed-window average for the nonidle /
nonidle_total ratio when aggregating. This way, no matter how
frequently you read the stall times, you get the same results.

However, because the update frequency absent any reads is 2s, that
would be the window size we'd have to use. So while we could present
updated total= on every read, they would still be aggregated based on
a relatively stale CPU load distribution.

They wouldn't be as current as they might seem - and as current as the
user would assume them to be if they read the file frequently and got
new totals every time. This is even more subtle than the status quo.

IMO the cleanest interface is simply to be honest and consistent about
the pressure files following a fixed 2s aggregation frequency, and
refer people who need a higher resolution to poll().
