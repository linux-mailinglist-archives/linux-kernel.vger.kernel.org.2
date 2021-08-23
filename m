Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836893F4F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhHWRaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhHWRas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:30:48 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21436C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:30:05 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id x140so1257370ybe.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uoiTwtytui/FJ2TGPLyBq32QZhYO+XcWNyEuhRLGPF0=;
        b=tHl92LPnnyvg6NPzbusts/Zntk95o41DRtCGxo9qBxGsUsuq0rP+pdVd+aSeKtSEbI
         vZJLicHrdOeExwr0DwvrQcGIGhAZYEcoLao0NcVjN5FiIZpdOw1M0Ri4G58S5E3wehaI
         gGMrWdozzCICmlUrIuFft1GF9mYLkxmROuqq1r24oSwk25N3mCf7s0W7HmLUa+6hDp/u
         IFPU+sFHwisBPfo49v+Aa+Vnap+awgDd2sUkGFhKs67PH6uNg05tU4zzeRuEWZH9HFvT
         WTFkOcouZG6cb+QQeCsBC+4uxmr2Mtur6YI609poEdXc5qfRk966k6kB2ejFDhmo5uxb
         L0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uoiTwtytui/FJ2TGPLyBq32QZhYO+XcWNyEuhRLGPF0=;
        b=Fa7o7AIF1QUluJ8ZH4zP5MNeA5hatrDkBerKrudse5sRNKgyMr11kKXA5uiGVRl7F5
         Ue6+XyFfkL629WVBzJLIIOLyJ/YlC39576Rq/YeS3DKDK372JpOjHVKNXSiYSF1Pu6Cd
         1jaDR9vxBUiDmE96sglEHKuTmMx4NDEFsuy1RuD8WgqZhzRTlFvO8d97Ix84pCeWHDib
         Fv+B8Scvzdc68IdAj+BQJigxJ90Bn1xWPWjM+VdUaqTvssxmlLNpqYrFvdwAyDIyYWB5
         47p297GCqyk4cqBQSTIN7M53PJvoHghzHqFXWs0aYgJ21M0RzGFabCdx3A9DN9MdQM9m
         EeXQ==
X-Gm-Message-State: AOAM532KRSYz2IkQCFiVNd/nRcV7fJF2NhzgUiey/LL2YrJzFqt/GlsD
        733yJ2ary3qGQMaW1AIDUtI9eoSbA8xTN2JytDY3mg==
X-Google-Smtp-Source: ABdhPJzJ4pvm36jJpBjRmsbw9gQMHOgYZpWO3KtAfNOYOf2gH0ieMLOZV3wpPHsseIKiKbsD4erQ74rN+P17gmi6MkA=
X-Received: by 2002:a25:1506:: with SMTP id 6mr44253225ybv.153.1629739803889;
 Mon, 23 Aug 2021 10:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com> <20210820010403.946838-2-joshdon@google.com>
 <YR9qRta78uYXSva6@geo.homenetwork>
In-Reply-To: <YR9qRta78uYXSva6@geo.homenetwork>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 23 Aug 2021 10:29:53 -0700
Message-ID: <CABk29NvH6_JoLydcrJf+yiaasGUbNEjzKdPjZxnWdrAFboJdsg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] sched: cgroup SCHED_IDLE support
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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

Hi Tao,

On Fri, Aug 20, 2021 at 1:38 AM Tao Zhou <tao.zhou@linux.dev> wrote:
[snip]
> >  #ifdef CONFIG_SMP
> >  extern void set_task_rq_fair(struct sched_entity *se,
> >                            struct cfs_rq *prev, struct cfs_rq *next);
> > @@ -601,6 +606,9 @@ struct cfs_rq {
> >       struct list_head        leaf_cfs_rq_list;
> >       struct task_group       *tg;    /* group that "owns" this runqueue */
> >
> > +     /* Locally cached copy of our task_group's idle value */
> > +     int                     idle;
> > +
> >  #ifdef CONFIG_CFS_BANDWIDTH
> >       int                     runtime_enabled;
> >       s64                     runtime_remaining;
> > --
> > 2.33.0.rc2.250.ged5fa647cd-goog
> >
>
> Cfs_rq and tg define @idle with int type.
> In sched_group_set_idle(..., long idle), @idle is long type.
> Use int instead.
>
> But, you filter idle value:
>
>     if (idle < 0 || idle > 1)
>         return -EINVAL;
>
> So, no effect here.. Just @idle can use 4 bytes.
>
>
>
> Thanks,
> Tao

The use of 'long'  there is because the input from the cgroup
interface is a 64 bit value.

- Josh
