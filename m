Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28F63B9486
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 18:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhGAQMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 12:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhGAQMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 12:12:08 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA37CC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 09:09:36 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id s129so11712678ybf.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzi1kcVee3nZI004Eqmdf8y65g93K4CPvU+WDS5oQ0o=;
        b=UbI4NvvhXAKF6UJlUQJnCnIZTrPzaWdjQcU6NH0GrVU6eIit+YEfiMywDOAfxqk9o9
         tAUXpeb60OkDSx9bD6lOX62A/UBZAJD8ptJRlCml6KoBg4ua6O6q9JCyDDSeZAj+QAkc
         WrJ5xeq2NOCp7aRcUS+yoclphDIkKOJdP8slkfbniGOfPxYm2Q/Jjjtv4olDqfLSSyxZ
         Dg7d03u2ogyibOVT+ShLOuJkKEI+IxOjT8XjAxolKK3GwvR6JtkTLTQBfj7oACQa/1cF
         C9yD3GteMdLWIIqy6hn/UTSwQ4n+A0f+lkYgWr+9bF5kE11px+0WS5EtvAqbmPm5iY/O
         0TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzi1kcVee3nZI004Eqmdf8y65g93K4CPvU+WDS5oQ0o=;
        b=eNqRqIPrU26jsyCa1FwYwefa/Isa/GHrgQ38bVGKsWeB/Mcuz+E2kfMQzjRMoQh4KJ
         kmXDK9fBldQB/uq7s6ZH34HRd43nSzjzL8PQ1F4EVMVTV69TgB8vOfO9PgxqYkfkVNXW
         zRxi/GnxFfZPeeARKIdp+joBHAcW8MJeDSt6p3e3HG8ktOoDICkxM0DFwudIcKx48KML
         sruyspJ+ivRc+ROi0gKfM9i7woVLu9bT1XxL5iyAr4uuAVLnd4eJ+R8zo7EwAd7a4h2u
         JvKpSkNUeBk3Am/M7ZoNpCmYejBOIe1Pr6WtEfhya0q0GU4f7jFOzoPeIrzed8DosAjt
         2Dow==
X-Gm-Message-State: AOAM532wXe8FRrlrNNuBjUUMMp2zyUtgIIUGLsTyH2DagNVdW3GFymid
        jPCgqlpuTomhUdzZVeoFCRhQwgVBEnDukbrxYH67kg==
X-Google-Smtp-Source: ABdhPJw73TwvlM3X+UsxZTrZkl7Yi035kGpgDESa4lssYP9pUQ2usK2Q7Aza4S0poCiOx0NH2LqRyPpMJYSPU/Q/uYs=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr668800ybc.136.1625155775937;
 Thu, 01 Jul 2021 09:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210630205151.137001-1-surenb@google.com> <YN2DsLlE+WtxK6K9@hirez.programming.kicks-ass.net>
In-Reply-To: <YN2DsLlE+WtxK6K9@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Jul 2021 09:09:25 -0700
Message-ID: <CAJuCfpF=Ty4ruiKQQweVoF6Ojx8P8LxvUBxp1TmMFo2W1xNWfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] psi: stop relying on timer_pending for poll_work rescheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        matthias.bgg@gmail.com, Minchan Kim <minchan@google.com>,
        Tim Murray <timmurray@google.com>,
        YT Chang <yt.chang@mediatek.com>,
        =?UTF-8?B?V2VuanUgWHUgKOiuuOaWh+S4vik=?= <wenju.xu@mediatek.com>,
        =?UTF-8?B?Sm9uYXRoYW4gSk1DaGVuICjpmbPlrrbmmI4p?= 
        <jonathan.jmchen@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-team <kernel-team@android.com>,
        SH Chen <show-hong.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 1:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jun 30, 2021 at 01:51:51PM -0700, Suren Baghdasaryan wrote:
> > +     /* cmpxchg should be called even when !force to set poll_scheduled */
> > +     if (atomic_cmpxchg(&group->poll_scheduled, 0, 1) && !force)
> >               return;
>
> Why is that a cmpxchg() ?

We want to set poll_scheduled and proceed with rescheduling the timer
unless it's already scheduled, so cmpxchg helps us to make that
decision atomically. Or did I misunderstand your question?

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
