Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C02545CE69
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbhKXUwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbhKXUwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:52:42 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A908C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:49:32 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g14so15977797edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMuc0XaSrOhuRiJX2AcDqo8qanP5IH8SnIJqnzSdiTM=;
        b=KhxM+OrYS66sRu8wbwFLi38a/BLmLfv+rK/Q6tCUn9uxuXb3hel1XpB6GNxSy7dBFZ
         qjjPjL6RB1aQ9njwxuYf9+zRVEnKR4PAKQMs23ec9/QErpVKIPBg3AMoy/12v4OwbCwn
         Hg4tpL8AuhuaRyPVigWqmM3d9tCM1Y1dr6iuzkQytFQRqCmpuwprhlX35leZEIH5B9tI
         GTiQQ1s4F58hOc2N2+1bcFzmIVIaVFpB2zz2AtVh5fyWi3/2YtVsw7VAqLTo2dSTabtE
         /5oVJ7m1KuD3lcrSlIAqJCkNrUm625m9/W1d5uF+zJRiPfb6oVkRf57+MBYAGyN09+NT
         /xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMuc0XaSrOhuRiJX2AcDqo8qanP5IH8SnIJqnzSdiTM=;
        b=bn7eXMraqK3TOWXxvGrdybwy5f0SuoG0NdfVstJNeOKDWo7GW0SI0iJTaCrufiAXCf
         63QhkPhfu2XeK4ssFA/jjfWc+rNzggM5eQgPQizqZLjk5tOTLsMzZUzESs10AhfMfIqH
         dqZxj+8CP5m9kayNyp7R9+0KhHBU3jq7qdNu1kMoJ0Xi9FabhGyD5m8EccB6mz+B/qmn
         IVJ976jo2fb75tNlylm/AIFHYaaxB0pKFQkPSW1Wvlp2MR9seNKEl3HMfu5jTYHqmrI1
         BrQ8v0Sl33SG8Mv9OXLq34JCRYkbdmTDaDkZYNnqvSvMJkrksXKRrPqWGPEr9+6eAoCU
         mMLg==
X-Gm-Message-State: AOAM533ZgemjcDtBFthtVQLTPcbMdjWwsP+k0xZCTC3IVscWPlNpgxK3
        dnrcDH6lkv3OX/4YNt7Qh7uLDQdguybNYByLKvw=
X-Google-Smtp-Source: ABdhPJzwSHdfzprCkyMOVZn4Qqnxxs9DUP/GFlzag5aWnsuOdQkT8ripr0NIzxM7Z5H9zcSJ75wV3zDA+7UwD/4ge5I=
X-Received: by 2002:a17:906:9754:: with SMTP id o20mr18296968ejy.277.1637786971186;
 Wed, 24 Nov 2021 12:49:31 -0800 (PST)
MIME-Version: 1.0
References: <20211124091546.5072-1-21cnbao@gmail.com> <YZ4eWHarf7QDONLB@hirez.programming.kicks-ass.net>
 <CAGsJ_4xpqvhBW0G5UfCjRD8BfR4m4EUv4B_cxoOtYTO5+iRsCQ@mail.gmail.com>
 <CAGsJ_4yHToqZZ9R59jd0391mE0tAzxDFSvhSV24gx9c5JNvO4w@mail.gmail.com>
 <CAGsJ_4zpN98_J2aRHyqz4XvSzP+0ngVu2k=ufn9JQNMwe7zZjw@mail.gmail.com> <YZ5UDuCII/KHUb9h@hirez.programming.kicks-ass.net>
In-Reply-To: <YZ5UDuCII/KHUb9h@hirez.programming.kicks-ass.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 25 Nov 2021 09:49:19 +1300
Message-ID: <CAGsJ_4xP7=LZnX1hSMi=2T_9xUmNCtbpyiFi+Uxs0_cxYX3E-A@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Remove the cost of a redundant
 cpumask_next_wrap in select_idle_cpu
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 4:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 25, 2021 at 01:02:00AM +1300, Barry Song wrote:
> > On Thu, Nov 25, 2021 at 12:57 AM Barry Song <21cnbao@gmail.com> wrote:
>
> > > Let me make it clearer. if nr=5, the original code will  loop 5 times,
> > > but in the 5th loop, it returns directly, so  __select_idle_cpu is
> > > only done 4 times.
> > >
> > > if nr=1, the original code will  loop 1 time, but in the 1st loop,
> > > it returns directly, so  __select_idle_cpu is  done 0 times.
> >
> > this is also why in the first version of patch, i did this:
> >                 span_avg = sd->span_weight * avg_idle;
> >                 if (span_avg > 4*avg_cost)
> > -                       nr = div_u64(span_avg, avg_cost);
> > +                       nr = div_u64(span_avg, avg_cost) - 1;
> >                 else
> > -                       nr = 4;
> > +                       nr = 3;
> >
> > because we are actually scanning 3 times or div_u64(span_avg, avg_cost) - 1
> > times but not 4 times or div_u64(span_avg, avg_cost) times.
>
> It still is confusing, because > 4*span -> nr = avg/span, very much
> implies we want to bottom out at 4.
>
> > this is not confusing at all. the only thing which is confusing is the original
> > code.
>
> But yes, it seems a whole lot of confusion stacked together. Let make it
> sane and say that we do 'nr' iterations, because clearly that was the
> intent :-)

yes. It seems this is much more sensible to do iterations in the
number of nr rather than
nr-1.  we can achieve this goal by two ways:

(1)
        nr--;

        for_each_cpu_wrap(cpu, cpus, target + 1) {
                _select_idle_cpu()....
                if (!nr--)
                                return;
        }

(2)
        for_each_cpu_wrap(cpu, cpus, target + 1) {
                _select_idle_cpu()....
                if (!--nr)
                                return;
        }

it seems the second way is still better as we don't need the "nr--" before
for_each_cpu_wrap() ?

Thanks
Barry
