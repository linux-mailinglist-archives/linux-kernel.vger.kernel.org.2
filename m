Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C50233FC28
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 01:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCRARw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 20:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhCRARt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:17:49 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9F4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 17:17:49 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y2so419213qtw.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 17:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBWp64Pug/SrgiIyadWuZwnOsiwL1P6TZRSFM00kaTE=;
        b=IIqq6Eoj+LnGC7XeDnJA2LmQcviLVkZMtifQwLfmDot9ahXHP36PaGWUF7TjDY03Kc
         CgLSKDVnRGfD2QD1G+Nr0Ytv3ywTh3OkyHJjNtkRqgVhyv+we+Fw00hJ1T5SNf7bwCGf
         VdDFtMk+sITBGsRFfRFHeWThbRqSa6TGuRndAK9twANKLboIlc5el7Wg/rqlqUyA/RIp
         HJpOvztH5oI8kn0X+pqy8c/jqavu/Oqc8I3CHtT7/oNd1b2ayXGM4tSOCN7AfgeCt6sW
         x+zNRXN3ACaNJ00Rcic+TJobm40DIc/TTTsKAHwWTiPX0RcMDB3X+01RkybEOEOyg9PU
         Adzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBWp64Pug/SrgiIyadWuZwnOsiwL1P6TZRSFM00kaTE=;
        b=W/NItVtqvX50Talc0h31+IIXyr9HvtD7Pe/CK84v89MuonfrCAjWniKNeUrNwoqs5b
         mHbAq+Jwdcrq8Pa0DoHwJdejNU/GNaI9D0bgN1vKArlLhpwsZgxLZMWJ+VMIgeEs41lR
         YzwJg3MtTglcUHvUKIDUFBtOf/zSXTo5wUSj2yOAEinsIcH5FpcABk7ipGeyCOoAJti7
         zVKW1owSeOnK7AIVisF89/QT5wjjPgdAc5xJUoexm208XkbRGWV6zkJAnh6ndf31WI3r
         2LAYQaiOSP4YxjF0Rz6OASaCgKnkx8r2Q2VMGpxrBTOeO/BY7NcB1JnJIq0QNHjx0s5+
         921Q==
X-Gm-Message-State: AOAM533BV9IXu5f8KRL0ozpMCyEduBJsCj6i8ybFPb0zwCrv5YdOlS1n
        TELsOMRasA4RiRAzKXI2Xtoew23qNyDh2ihm4TZDSQ==
X-Google-Smtp-Source: ABdhPJx0spgied9F00Q5lkECPAZWv345xymxG9XfK1q1w/CRjgQhQ3Xc/nTCSQS1+d1cZdKWm4aFSqhy2jaIazOr1ag=
X-Received: by 2002:a05:622a:114:: with SMTP id u20mr1443275qtw.317.1616026668446;
 Wed, 17 Mar 2021 17:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210317045949.1584952-1-joshdon@google.com> <20210317083141.GB3881262@gmail.com>
In-Reply-To: <20210317083141.GB3881262@gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 17 Mar 2021 17:17:37 -0700
Message-ID: <CABk29Nu8iYDzY+GHa+z7oJyGF_0JKdF9+-zBbiL7C2hgSfHqMg@mail.gmail.com>
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

On Wed, Mar 17, 2021 at 1:31 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Josh Don <joshdon@google.com> wrote:
>
> > +static inline u64 resched_latency_check(struct rq *rq)
> > +{
> > +     int latency_warn_ms = READ_ONCE(sysctl_resched_latency_warn_ms);
> > +     bool warn_only_once = (latency_warn_ms == RESCHED_DEFAULT_WARN_LATENCY_MS);
> > +     u64 need_resched_latency, now = rq_clock(rq);
> > +     static bool warned_once;
> > +
> > +     if (warn_only_once && warned_once)
> > +             return 0;
> > +
> > +     if (!need_resched() || latency_warn_ms < 2)
> > +             return 0;
> > +
> > +     /* Disable this warning for the first few mins after boot */
> > +     if (now < RESCHED_BOOT_QUIET_SEC * NSEC_PER_SEC)
> > +             return 0;
> > +
> > +     if (!rq->last_seen_need_resched_ns) {
> > +             rq->last_seen_need_resched_ns = now;
> > +             rq->ticks_without_resched = 0;
> > +             return 0;
> > +     }
> > +
> > +     rq->ticks_without_resched++;
>
> So AFAICS this will only really do something useful on full-nohz
> kernels with sufficiently long scheduler ticks, right?

Not quite sure what you mean; it is actually the inverse? Since we
rely on the tick to detect the resched latency, on nohz-full we won't
have detection on cpus running a single thread. The ideal scenario is
!nohz-full and tick interval << warn_ms.

> On other kernels the scheduler tick interrupt, when it returns to
> user-space, will trigger a reschedule if it sees a need_resched.

True for the case where we return to userspace, but we could instead
be executing in a non-preemptible region of the kernel. This is where
we've seen/fixed kernel bugs.

Best,
Josh
