Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A134045C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245155AbhIIGuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhIIGuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:50:18 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79630C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 23:49:05 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id z18so1839043ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 23:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jvq1SkY9pwAOIMxBMn33QFKV8XgkS5RSkAbHTT9NPnc=;
        b=zPNHmflQ+KK2aPPISKabIT/z6km+R2RESiZoHSRncKMphQza4olqur7NjrJcjL3ZRK
         B2uuEfASpvnJ5rKUNVZJjMBCwV+308aCaadXEP+5Lkm6THswPSwZCd+Z3A3J9Ge+Nwaw
         75uWRwxsd/XcCJ4C4xBzlfENUl4yaPmpN7gkty+vqkXaE5Y6llo18zVGWtbSS+lm2HZ4
         z48TFZEaqQLTEJMNCEmy74PYNzjdFfZQHpYX2bhLkef9uTbXDvDPldtcy/Lxy1cQ8Sft
         VNFJUHdYpazBlpcewEaGh/4/m1wJDdPv16hdD40aC9lR1my3J75jLxymT4aun03Uhz2K
         oGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jvq1SkY9pwAOIMxBMn33QFKV8XgkS5RSkAbHTT9NPnc=;
        b=f3M7ncZNAoqdclZ0hhdb3/lF1osEXIDUtpE0yDcGBFhSlUD/iCvFslkW61TAikicYm
         xHzWglkMOlU7AQjGUVu/h4HVA+X9wVbYTE3NqmZyCmNWGqMRQX3FRCjhLoprxLQcHEEb
         p1vunADEDpgn5fyBRibJICxnvdkNO42NyDWGiIXN6Pw49BRti6I1GGwxmvJXIRA8sNtG
         Lfic6fiaWb4SIL4VnL7YRdpxivCQaTD1kmIf0GEdIUon4dWZFusNlZvlhL31uUFZu91Y
         D9hhqmfnESC6j+jqoBXe+i/H/MDzlpNsfM238sU++6FxhfKr2N/ypfmjmBEmYfrf3fId
         LuUg==
X-Gm-Message-State: AOAM531Muri0QaZbjcMezjDWe9jvyBIKP2yRzmeQVfd8T//p6aw/AGIj
        uPVvB+bdOF0VzgMm7MRQdcwQBPpWAtAxfCbWz186NA==
X-Google-Smtp-Source: ABdhPJyJeMCHtdgCgrGmaCI+oCzAqtrmiQWfiPufs6oN0VW2hb96eJpM42vewETfOKt6pl1t0Vc5dWG7wcbxyZEKFxM=
X-Received: by 2002:a25:1c09:: with SMTP id c9mr1960098ybc.350.1631170144556;
 Wed, 08 Sep 2021 23:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210908203946.1261798-1-daniel.m.jordan@oracle.com>
In-Reply-To: <20210908203946.1261798-1-daniel.m.jordan@oracle.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Sep 2021 08:48:53 +0200
Message-ID: <CAKfTPtArYGHgEaa3GEMeJWzk_n4BDk1SanjrDU_-3fn=okrDEg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix se_is_idle() for !FAIR_GROUP_SCHED
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Don <joshdon@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sept 2021 at 22:40, Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
>
> se_is_idle() unconditionally returns 0 for !FAIR_GROUP_SCHED.
>
> Check whether the task is SCHED_IDLE instead so buddies aren't set for
> such tasks, as was the behavior before 304000390f88.
>
> Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff69f245b939..8b22665bc18e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -497,7 +497,7 @@ static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
>
>  static int se_is_idle(struct sched_entity *se)
>  {
> -       return 0;
> +       return task_has_idle_policy(task_of(se));
>  }
>
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>
> base-commit: ac08b1c68d1b1ed3cebb218fc3ea2c07484eb07d
> --
> 2.32.0
>
