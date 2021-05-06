Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FD737540B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhEFMso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhEFMsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:48:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB198C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 05:47:44 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a36so6861770ljq.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tIRE8QgoHIdYOF8GPHvxQ+HvdFDXSfw9r/pCQC6+ol0=;
        b=DSf1wjC3qLWw0y4zWaZrNJYe88iiGWkjjk3VJpK0Iay6DXEa5pw1qOFrmx1mU2GcL0
         UsGPrxnLxynv039A8OneG3YWNrG7BWmasP2KgdZ5cSsjKjFjfIfsrf/rqEDHMQ33q7fv
         iwFvbWjsQ6v3DWRu3Nu6G+fFyOGhi8GvyZTjITF9kYeME79eRy3wFf41l05j5pv/AXlV
         703jQsYtsL4I2bR67Kjz+zI8LBEbs66wxXYv91qShfAhJOBVChXTTfvvhVkSjgi0nuHu
         XSP0rQZAUwIN78lAUAWV8/Zc3Jrf+Ir9QJW/HtzCjrDiCZvE16jWVC6jV55/tQP2m6l2
         Q9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIRE8QgoHIdYOF8GPHvxQ+HvdFDXSfw9r/pCQC6+ol0=;
        b=JvQtGP8cF3bEJMq9Vxt9LT18c2mGanXO3Lj42sm56eCErm0rb3FRgk4j65twTF55Jg
         fiUUxKnOeoTCI4kIBwX7huuXIE2yvmHtZon0IzWoJl9wYXuJGDPSspR53e6QseNDz4sd
         hXYZmNeSZV6sL1WmpkJuBdYM4VpJFiB6YVsCxrqmedKsa0niS+eudaBx5BzmGqVO6rya
         WTfvPUcGRBWfDOCcOiRyQBOIuLQbmrmPlFYM0e2x0ElItfKp0af37Uvf1IUOfynHbEuu
         0Sl2MH6+bzRQJGvc0U/3YxPtN2qqBD2jUA/vWPFszpS/vx+70xJ1m6lfb6LJ2mSLPZWy
         KLEQ==
X-Gm-Message-State: AOAM530waLfHkzFhr7aICK0o8Ubja/inHg3maR3FrQPsruXlOESkw5qt
        B2SnB0N/tXpoZAIIzOI+iKj5otrSe5UPCByuFDg=
X-Google-Smtp-Source: ABdhPJxMrAhSFUQZ6f4f8PdOR4GLRquFN0haRUuA5Qm5JmvUPJDwnd9MQq94Qa24TiA5dSegrn9TFK1dNFEh5D4mMds=
X-Received: by 2002:a2e:7306:: with SMTP id o6mr3173444ljc.420.1620305263193;
 Thu, 06 May 2021 05:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210506110936.8797-1-xuewen.yan94@gmail.com> <20210506122823.GA8671@ubiquitous>
In-Reply-To: <20210506122823.GA8671@ubiquitous>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Thu, 6 May 2021 20:46:08 +0800
Message-ID: <CAB8ipk-uL4Z1SY5sxhZ8dTtdvg8AzLtPS6QNEQFxuKCDdeBZxQ@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: Add UTIL_AVG_UNCHANGED flag for last_enqueued_diff
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
On Thu, May 6, 2021 at 8:28 PM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> On Thu, May 06, 2021 at 07:09:36PM +0800, Xuewen Yan wrote:
> > From: Xuewen Yan <xuewen.yan@unisoc.com>
> >
> > The UTIL_AVG_UNCHANGED flag had been cleared when the task util changed.
> > And the enqueued is equal to task_util with the flag, so it is better
> > to add the UTIL_AVG_UNCHANGED flag for last_enqueued_diff.
> >
> > Fixes: b89997aa88f0b sched/pelt: Fix task util_est update filtering
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e5e457fa9dc8..94d77b4fa601 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3996,7 +3996,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> >       if (ue.enqueued & UTIL_AVG_UNCHANGED)
> >               return;
> >
> > -     last_enqueued_diff = ue.enqueued;
> > +     last_enqueued_diff = (ue.enqueued | UTIL_AVG_UNCHANGED);
> >
> >       /*
> >        * Reset EWMA on utilization increases, the moving average is used only
> > --
> > 2.29.0
> >
>
> Hi,
>
> We do indeed for the diff use the flag for the value updated and no flag for the
> value before the update. However, last_enqueued_diff is only used for the margin
> check which is an heuristic and is not an accurate value (~1%) and as we know
The last_enqueued_diff is compared with the UTIL_EST_MARGIN which is
"1024/100 = 10",
and The LSB may cause ~10% error.
> we already loose the LSB in util_est, I'm not sure this is really necessary.
I'm also not very sure, maybe the calculation will be more rigorous
with the flag?
>
> --
> Vincent
>
