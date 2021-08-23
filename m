Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B933F484E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbhHWKKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbhHWKK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:10:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ABAC061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:09:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p38so36916421lfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05AJ+F6GkT8AKoB6zrVwfafs6BSYl8oX/Agcqv8i+MM=;
        b=xruKDw0o9Cc8GwxChKcJa0h4NpB0c+dUfM768lUIRH/VJqqAX5OTCciPqLXAlLUcpe
         y4T4Myh0FVZqLXSyFeoAJWb/qoIxJDukw/1ylKwIvxWvsEDL31OGNyblpS6l3sThV/F0
         bzOLZ+pm/Q2LMeJVxWR1mN/3FB+gUHzpIO/4zKBHzX9AodzpKojmBdNu0F7NYgbjqDoU
         K45VISRoriUHQOyc0OLmmyMm1bPsODImVCpziKEXm77A45RT33Kv2D9BbsHGIwJA/fDS
         uODRbqS+oTUhUpGpMiU6FA/gqbIjWJFDYUe5qnpD7SGRF0Yhn0I390G4g4LROOM/qRWl
         6aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05AJ+F6GkT8AKoB6zrVwfafs6BSYl8oX/Agcqv8i+MM=;
        b=rZl2JAR54oM8umXR0K+y7sC3efZXulTsYmNonRygQ6S3gDDqQl+pj7W2PcdJQN464u
         CT8q2C1oYjx4th1CYkUsazQ3qLjlRVhn29yI4zJweYaDC9FU+wReMnRzb1KMKWly1I0t
         +kVsRSZJsOZzZpkM8kUkd9DGvaINeMHpE8NOtZpv6PoENOAuu9RivoIBPl17NQ/Ei6/X
         l8b/Y7OxjKfEBru/DOpGmbUGHmiQbFkTPr8utsCyrPk+0daWr1eapBONESSUwA4+oAcR
         KI4SEhKmfhoFyBK2vRLfmnklzkfWgbXdWOEJTK/2e46d0zJ+1hSxV97BClCHfxKD4T0x
         g2wg==
X-Gm-Message-State: AOAM530sNdd2q3c22CYi+qrKBOLOtXX9gdaNfHhsY4S8NFSYUucNXowY
        sQQ7HOKr+aoeE6Mri+UXKTqwhYrqVRoxCU+JMT88YA==
X-Google-Smtp-Source: ABdhPJwV27iLXbdaB1RtNauLSUOg77V8YBWzHp7vs/k9WLRKvYJLHBpGZWmKqSB/SdqHqStRFh6K2k55TbQg+UQMFVg=
X-Received: by 2002:ac2:54a4:: with SMTP id w4mr16239680lfk.254.1629713383593;
 Mon, 23 Aug 2021 03:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com> <20210820010403.946838-5-joshdon@google.com>
In-Reply-To: <20210820010403.946838-5-joshdon@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 23 Aug 2021 12:09:32 +0200
Message-ID: <CAKfTPtCmhtPWcFYo+ArNBDGOvmgfLJrNm+QbqGEMsQnpj0TJSA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] sched: adjust sleeper credit for SCHED_IDLE entities
To:     Josh Don <joshdon@google.com>
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

On Fri, 20 Aug 2021 at 03:04, Josh Don <joshdon@google.com> wrote:
>
> Give reduced sleeper credit to SCHED_IDLE entities. As a result, woken
> SCHED_IDLE entities will take longer to preempt normal entities.
>
> The benefit of this change is to make it less likely that a newly woken
> SCHED_IDLE entity will preempt a short-running normal entity before it
> blocks.
>
> We still give a small sleeper credit to SCHED_IDLE entities, so that
> idle<->idle competition retains some fairness.
>
> Example: With HZ=1000, spawned four threads affined to one cpu, one of
> which was set to SCHED_IDLE. Without this patch, wakeup latency for the
> SCHED_IDLE thread was ~1-2ms, with the patch the wakeup latency was
> ~5ms.
>
> Signed-off-by: Josh Don <joshdon@google.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 31f40aa005b9..aa9c046d2aab 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4230,7 +4230,12 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>
>         /* sleeps up to a single latency don't count. */
>         if (!initial) {
> -               unsigned long thresh = sysctl_sched_latency;
> +               unsigned long thresh;
> +
> +               if (se_is_idle(se))
> +                       thresh = sysctl_sched_min_granularity;
> +               else
> +                       thresh = sysctl_sched_latency;
>
>                 /*
>                  * Halve their sleep time's effect, to allow
> --
> 2.33.0.rc2.250.ged5fa647cd-goog
>
