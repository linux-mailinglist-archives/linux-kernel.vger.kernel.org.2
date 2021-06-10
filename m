Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059513A24C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFJGwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:52:50 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:35609 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJGwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:52:47 -0400
Received: by mail-lf1-f51.google.com with SMTP id i10so1450467lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=67pgjCx8vmxJvqmbawagxHeBDG9F0WOXi380k50exuo=;
        b=po0rea81p6koLdoj90+BpTqr297m34vqZiDHl35MFKN5HmBo/cINMskvg8Rj1AiXCD
         P/mX6NsU8ilK5hyP7AW2r0V1bwvN2iVAetVFInJHL3ulhputAR1fbbnR8g/j+kgSLQRN
         iXciNRcfQNWXmevrvU/V5C2Ds7I+9bLqYeVGkHSoUKiLnS7CZ/zFob00D4OF3VknComV
         +qQqQK4kXsp5qjvVU5KnImu/nnQ+tNK8McFDo2o+UIVNatGM0GWVemlGxwcDZQAGmctV
         Yi8SxUDNO9ks7NLikMTm/51IqsXk6A361yvzd5VwX3BuQ5o0Bb4YtgNKJRMi3H4g+gpU
         x25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=67pgjCx8vmxJvqmbawagxHeBDG9F0WOXi380k50exuo=;
        b=OR+KsFU+Z+sJ9/i0Azm7XmweXMdcUWi6KA+WxWVleyAO5+tn48VUymtlI4sQkeG4SF
         jcw2AQMTDkTdmjy0YVcvMx7dT4WFY1XF7qEoUfMdvm3lk/waFIoyYeHDwVaeTGHaWsZM
         Wu6OTK7xCFN+32taMu/I30cP0HtOuvcU1tkJwamjpYPXFwKn5Y1P3GwvTvuEA7id61E9
         cnN909+D27CexYO81x1NxpQPE6Z76C6cm8LpetaISb8zx3lGzvztkuQA+WuhqVftKu+5
         +lY2XVxsMWzoejLM73TVnKiF+6+I1782vj1nR1HFaYzEj9D5o4LVqocUDLoCjiDMMfvL
         mK5A==
X-Gm-Message-State: AOAM530PW0lfkam5WbM8EErGy0s6aXQO3NilC9+AO5CG65i7vYOHEinJ
        rV9R5xZtwjbinWfOI9kcRWPWbB3aQ4RoSf/4ZBcRQg==
X-Google-Smtp-Source: ABdhPJz6FaRyzkyT5JROY4fDMVlcASzRb2xRU5K+8ShUxTZ08+8Qwr8pCgPa1FkXe3u+pAUYQeCllBc3ABd61aq8ik8=
X-Received: by 2002:a05:6512:3b84:: with SMTP id g4mr969823lfv.277.1623307791024;
 Wed, 09 Jun 2021 23:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210604102314.697749-1-odin@uged.al> <YL+dTtsCtZjMeZWn@blackbook>
In-Reply-To: <YL+dTtsCtZjMeZWn@blackbook>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Jun 2021 08:49:39 +0200
Message-ID: <CAKfTPtBEZZo9fHDxe7viLyZmCe=4NTLLtBFyWM_UuJ1nmqxGvA@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: Correctly insert cfs_rq's to list on unthrottle
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 at 18:39, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello.
>
> On Fri, Jun 04, 2021 at 12:23:14PM +0200, Odin Ugedal <odin@uged.al> wrot=
e:
>
> > @@ -4719,8 +4738,8 @@ static int tg_unthrottle_up(struct task_group *tg=
, void *data)
> >               cfs_rq->throttled_clock_task_time +=3D rq_clock_task(rq) =
-
> >                                            cfs_rq->throttled_clock_task=
;
> >
> > -             /* Add cfs_rq with already running entity in the list */
> > -             if (cfs_rq->nr_running >=3D 1)
> > +             /* Add cfs_rq with load or one or more already running en=
tities to the list */
> > +             if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
> >                       list_add_leaf_cfs_rq(cfs_rq);
> >       }
>
> Can there be a decayed cfs_rq with positive nr_running?
> I.e. can the condition be simplified to just the decayed check?

Yes, nothing prevent a task with a null load to be enqueued on a
throttle cfs as an example

>
> (I'm looking at account_entity_enqueue() but I don't know if an entity's
> weight can be zero in some singular cases.)
>
> Thanks,
> Michal
