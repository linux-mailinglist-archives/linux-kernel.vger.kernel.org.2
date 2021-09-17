Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31A640FD84
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhIQQHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhIQQHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:07:14 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECADC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:05:52 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 73so13885817qki.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WCt0pxhXH4/JIuMdox6p05mTuWyc2xVcN9WjNMj4aKs=;
        b=ZRteYCqIThVqHN5W8RnGpHNj5aIj0eWp6/HQ0RntfO96xzBPjh/i/RCB0Mw1l0Ug73
         m5KIF7d3ICnMWPkwI3L7e7LLhcxLzKX7S9tiQbRBjmd/D2ijcc+uv8Ws1owaPb+bWrTQ
         l0TPxNI5GEwD2Wg7R8qQlFYTW/ibxQ1DAl79xRfCdc3ZdwLel3Sy6JOvUgNkOxhbQ+cQ
         CxKgv7hhpxP/O5LNAgecnkz6MVPK8p8pD+sgOJcOtRJSWKaSFpsXMiPW2LCWYiDcvLZ2
         +J7rHh3iOMmW0EpC2E5uEyAdae7ekKqjO80B9MlNvc4R3XcMSIrGWO7dH9IqLDYHdPaK
         0hZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WCt0pxhXH4/JIuMdox6p05mTuWyc2xVcN9WjNMj4aKs=;
        b=KiN7m02CuBKd00ZVdIX+FMAkaDXmASQM5wsv9Uj15rBvFr7fDBUDh/OjGFmdxtlIbJ
         7WwznpCNlNW8p8JrtoyeVTRcsCUF2g7VYtmPtYAnOxl6VRtFWPDZnQkBHbigLMNFnCri
         rsSo831iL604fSgW6lPJZDpCqMfeFPTn3NjRaof3cgHUoERhAEL/OIziFLuPPvdgiSn8
         oqf/Az75Hn8NprpiI4JA24uumbistJ6d+G0EXnYAUn//h6ZXZGT45vqXdjJBh83x7H0w
         emkZw5KU/oRZ0lSyFKbWAlwu53OuU/NfrHYQ8mx6oPPkqv+AHIEl1V/fBgdVfAnEIyNW
         avwA==
X-Gm-Message-State: AOAM533FIspZ+RCUJu4EIMdHfSKTyhuXrT8d0aHh4nEfXqpwEJN0PP/y
        eH32AnVM8y6F2jQR3dLDV9LlShsqK8KPfslpcwWgdw==
X-Google-Smtp-Source: ABdhPJwnZpCU/BxhvtHH+5ZN0MJBgH+hOYPH5YTmYRvQtLddY4pUdUc2ZccXHopHqxVuX+bE2HhkG9J39/M2V6JZ4K4=
X-Received: by 2002:a25:d9c8:: with SMTP id q191mr15053330ybg.61.1631894751097;
 Fri, 17 Sep 2021 09:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210917153037.11176-1-mkoutny@suse.com>
In-Reply-To: <20210917153037.11176-1-mkoutny@suse.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 17 Sep 2021 18:05:40 +0200
Message-ID: <CAKfTPtBU88dioVFesjYxKWwQ0O7KcqY4tR7P=2mTO8v-a_GadQ@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: Add ancestors of unthrottled undecayed cfs_rq
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>, Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sept 2021 at 17:32, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Since commit a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to
> list on unthrottle") we add cfs_rqs with no runnable tasks but not fully
> decayed into the load (leaf) list. We may ignore adding some ancestors
> and therefore breaking tmp_alone_branch invariant. This broke LTP test
> cfs_bandwidth01 and it was partially fixed in commit fdaba61ef8a2
> ("sched/fair: Ensure that the CFS parent is added after unthrottling").
>
> I noticed the named test still fails even with the fix (but with low
> probability, 1 in ~1000 executions of the test). The reason is when
> bailing out of unthrottle_cfs_rq early, we may miss adding ancestors of
> the unthrottled cfs_rq, thus, not joining tmp_alone_branch properly.
>
> Fix this by adding ancestors if we notice the unthrottled cfs_rq was
> added to the load list.
>
> Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on un=
throttle")
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>
> Changes since v2 [1]:
> - jump to completion for loop, don't duplicate it
> - singled out of the series (to handle a fix separately from the rest)
>
> [1] https://lore.kernel.org/r/20210819175034.4577-2-mkoutny@suse.com/
>
>  kernel/sched/fair.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff69f245b939..f6a05d9b5443 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4936,8 +4936,12 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>         /* update hierarchical throttle state */
>         walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)r=
q);
>
> -       if (!cfs_rq->load.weight)
> +       /* Nothing to run but something to decay (on_list)? Complete the =
branch */
> +       if (!cfs_rq->load.weight) {
> +               if (cfs_rq->on_list)
> +                       goto unthrottle_throttle;
>                 return;
> +       }
>
>         task_delta =3D cfs_rq->h_nr_running;
>         idle_task_delta =3D cfs_rq->idle_h_nr_running;
> --
> 2.32.0
>
