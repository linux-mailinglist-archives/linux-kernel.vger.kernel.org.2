Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0773F4FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhHWRlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhHWRlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:41:12 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05CBC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:40:29 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i8so35632267ybt.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tg+gMiZppcg/miaZRd7SQo5vvbFPzzQYgyARNlwL+fs=;
        b=BvkQXvWLuF9rtvj03T1szkEg7VIAr77xKJrK0XfMggjkZ2WauaSTewIvd1ZsC3jzdb
         ONRkDxVgWIIRYmLFo/qHchfgT2guuWVVkegUXMNcLl7nmW6ILqgY7mrGBPoahyOVW/hS
         c/u+U6g9kcZuoFiBC9K5XHCl86rE7RziMvFb/oJiKI7ynif97ruW3FJ7Y7VXtFYlyRJi
         +WTrhgFnr8Dt1Sp5kQORdAphG6MLUMujObUx60cFvay5VyDkGGDoJw2tcSlIE7vcom5u
         DmRM8GY5MGoLatfM1mIMbLgAkyIv1dDskW19jErtROlBz4BR594HUh9+TSLtqDhLScMm
         oPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tg+gMiZppcg/miaZRd7SQo5vvbFPzzQYgyARNlwL+fs=;
        b=AvmMuHuFO65qY9TD97IQP/jw45yqKjV9R50GOILeaUJcOVQ9L7uROy+nYltPz7ktrX
         iYBu8dfVNYlm3KYsy3fVOKlAvEBQdnJCTAsnXTPOjrrY0ntVJmEYJAGpnQNpGU/m7Ylk
         BOOiTcBRYW5m8yFzUX4QcLj7YEsPOhnSGjQOTOBazwORmdNoqzOZ2j7il/8pLaBch/4B
         cyj9+XyFrnUL11KOAH7+2ZOgMksL5DYD4vxHNycOd2JIdyzGefdf/yB8hvbkWfMcefTe
         lQHdIzhixCMoTZ0L4JZb3hRg+unvw4unpQNgTl0XlcTFpzTsNAs5irnkOI8iai3fee22
         GdYQ==
X-Gm-Message-State: AOAM530aQUoybXtavdxLWYHZAwcifcR20gCyjqZWk+r++l2ZWO6j+PVm
        wxoBrNoaqpqXx880s9P2NNT54sGtuC4TXDbwJZRaMw==
X-Google-Smtp-Source: ABdhPJy6P+lNKnUyRQB1g78zhUeRoBAr2ERyd7psF4azuiMjorAMpI/sQYSe2S2Aal59EB1ztaXm6NrrKGRb1fsDQbU=
X-Received: by 2002:a25:2155:: with SMTP id h82mr44910506ybh.177.1629740428956;
 Mon, 23 Aug 2021 10:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com> <20210820010403.946838-4-joshdon@google.com>
 <CAKfTPtC_uEqP8y9j-Njk2mHJXEqo02PHhM9koAtUTfYbc+KQEA@mail.gmail.com>
In-Reply-To: <CAKfTPtC_uEqP8y9j-Njk2mHJXEqo02PHhM9koAtUTfYbc+KQEA@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 23 Aug 2021 10:40:18 -0700
Message-ID: <CABk29NvEW+aa3ysMOK2J24OHpWpjiAVqjfQ6+T_49V9Dp8T4Hg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] sched: reduce sched slice for SCHED_IDLE entities
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 3:08 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 20 Aug 2021 at 03:04, Josh Don <joshdon@google.com> wrote:
> >
> > @@ -684,12 +696,13 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >         for_each_sched_entity(se) {
> >                 struct load_weight *load;
> >                 struct load_weight lw;
> > +               struct cfs_rq *qcfs_rq;
> >
> > -               cfs_rq = cfs_rq_of(se);
> > -               load = &cfs_rq->load;
> > +               qcfs_rq = cfs_rq_of(se);
> > +               load = &qcfs_rq->load;
> >
> >                 if (unlikely(!se->on_rq)) {
> > -                       lw = cfs_rq->load;
> > +                       lw = qcfs_rq->load;
> >
> >                         update_load_add(&lw, se->load.weight);
> >                         load = &lw;
> > @@ -697,8 +710,14 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >                 slice = __calc_delta(slice, se->load.weight, load);
> >         }
> >
> > -       if (sched_feat(BASE_SLICE))
> > -               slice = max(slice, (u64)sysctl_sched_min_granularity);
> > +       if (sched_feat(BASE_SLICE)) {
> > +               if (se_is_idle(init_se) && !sched_idle_cfs_rq(cfs_rq))
>
> Like for place_entity, we should probably not dynamically switch
> between the 2 values below depending on the presence or not of non
> sched idle tasks and always use sysctl_sched_idle_min_granularity

My reasoning here is that sched_slice is something we reasonably
expect to change as tasks enqueue/dequeue, and unlike place_entity()
it does not create fairness issues by messing with vruntime.
Additionally, it would be preferable to use the larger min granularity
on a cpu running only idle tasks.
