Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53371412D17
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352731AbhIUCys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239642AbhIUCaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:30:03 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD104C0470B5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:06:20 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id cf2so12035834qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7tqFjTUIXiBvPf6FAx8yLkqgiBHfgu/uf4F9JFl7j8g=;
        b=erwejbOYNIXzuXsHHdUD+xyNQzWUMv6q3K0hBcDZmgJNMYVGr4khmR319qaa/yfXoe
         XnARs8/pHWG44eW6MVowTnznWJLp2hO6K2nZPAvDOSJCNMNMDAOapAwEzL/fjsrKw/gS
         DlJEeMGumo9WCA55YabFsSo+2oOeHXpGMs5flRl21evsrEQ6quI40H6Y9LGV0NGjOPUm
         UDOdaAZ4TfASdTf/iOK129tDeEm9R7GSTUaWgpOzyNMh7b+075/H0ox0AyAex+IOKC6e
         t2qPhutziXkW7qhzFqJXgFwh9EjGTTO2t7FdErK8peZivOQodoJ/4s4TU+naQJfxsOxY
         Ovtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7tqFjTUIXiBvPf6FAx8yLkqgiBHfgu/uf4F9JFl7j8g=;
        b=afh3UHYSrGFS/lF5CaeJ1DCVMLX++yvn+1KPrmlONSShKTyyMkQng9RNiPU3bSZoKl
         nwCUH6YHkMD1zeGfuZr7AYTBxzYylY18vqZULPwYx9ry8VcI221IXIRAP0zxD2igGncd
         1JML3wE9HhLHu2u8MDw1tRspmJIeGKv4o8yOM/zG9rmZNUlWWf9i3yjviGpdxA43oiQs
         mU6hkvjLoIawUCGulAwPwrpKpJ5IZGWEmecsAkZHfk+5l+pWWaMlmBeGg0SUpSxo261k
         LJuFG6DHc7wJyuJ2rLS3qMZMqX8cQESEhje7Q6zoMaPcyK2PRCZKpoMj4IO3WIcIzpqg
         UEdA==
X-Gm-Message-State: AOAM531/dBjMLLMswIGrCAJFfKjCpMI7KBcjXRALdWnxyTYu+OsEq4Jg
        JItLoRhm3XV3fFxHKgeX8aNMH4OACNxlC0ooJi2uLA==
X-Google-Smtp-Source: ABdhPJz0U3VYkUDqV523iuNPXNtGW/njcAsC8pizY1mnsoYA8XVz/Z1MXMyc8P+XOhDs5o+OVr2VR/4uGYlgSOHkndw=
X-Received: by 2002:a05:6214:1492:: with SMTP id bn18mr24329662qvb.44.1632168379939;
 Mon, 20 Sep 2021 13:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210917153037.11176-1-mkoutny@suse.com>
In-Reply-To: <20210917153037.11176-1-mkoutny@suse.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Mon, 20 Sep 2021 21:06:09 +0100
Message-ID: <CAFpoUr3fVLxdxyu4SrR5qKZm0LmZY=UKnjU7Ww7f_zOh0OYnNA@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: Add ancestors of unthrottled undecayed cfs_rq
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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

fre. 17. sep. 2021 kl. 16:32 skrev Michal Koutn=C3=BD <mkoutny@suse.com>:
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

Thanks for catching this!

Reviewed-by: Odin Ugedal <odin@uged.al>

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
