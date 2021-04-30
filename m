Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1E536F6AC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhD3HsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhD3Hqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:46:36 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70DFC061358
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2so16037960lft.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WIHsT+EEtPEiVcMVedRfFHxcoHWyf6S8OoRa/JfsUrA=;
        b=IlyryYZIQwyspnfLzmLvUW65IfTGc3mvUirA78RwjqYEzBThJR+1MH1an/Oq/f5eIC
         JYf8hlsnx37y4vOGtI+GLPvgUqSMSfxyAMQ/i0V0pk0mHvy+FVszSyAixUkWVsc1IegS
         +n8YpSmhJA9leZ/KwoTm6b5jPsVOJn8NH67cJIxvylkQ9k4rTxsPYlT9KkmqObNQjsIM
         xS29Wg7KJWb2MwEnZnRIcXFbAlGyR/2+o5iI2Fle92O4AR4cDOed4MDlUJbOI/H6dXYX
         ktJophRM71WcGW1y2dtX/bS9Vb9ey/uGTOOmWKcMLo7vBYqOWZ+za5/YodxSJguGg4RD
         3ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WIHsT+EEtPEiVcMVedRfFHxcoHWyf6S8OoRa/JfsUrA=;
        b=PoSH5LK3NB62P+SU+IQf7TNCWPfR1lNCn/n5Q5MCmSs540pFxxkXdhDc92jZpSkZI7
         wtmWrptFdBAuobLGDmWmWBG+ZZZLAfgoY1eND/j+zrJGbpGCQxksp1o9edliauSKrUIX
         KY54WZEyfJUIHQ1fZh7JS5UaoW7g6YqYzq6hk9pimNoX+40zVPwyz5vm1pt7XfY7T3DL
         Dr2AfxhnhVwNBJzeTtbhNIVEE0NzrblpBj0jclW504fauEcHnyvOjO/IFeMvH5ECfJeS
         R2Fojzy+L/H9Dp09c0b229SPskY01lwJlbT/W5MxjM+ynDuikaOawE4vMRW4s7/SQtHA
         qHQg==
X-Gm-Message-State: AOAM533Qx3B1W+KtVjX0G9bzEaH7Fej70IjHWlzHYopEuqUTt182N9yS
        EyEA9Tq5ZUX0H1X+STaoRaRagqYfnH3Aic9UDTRPh4lE4yUc4w==
X-Google-Smtp-Source: ABdhPJwxyKcNSI/GEJ5XsFtf6BEnU46pmTNNuvenU8kdnELMnqx32EeK/LkABMjPORmzbGWZYT7aca6+ih1FH8FJNNg=
X-Received: by 2002:ac2:5f6a:: with SMTP id c10mr2613050lfc.286.1619768743253;
 Fri, 30 Apr 2021 00:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210429152656.4118460-1-qperret@google.com>
In-Reply-To: <20210429152656.4118460-1-qperret@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 30 Apr 2021 09:45:32 +0200
Message-ID: <CAKfTPtAfgVnMYkY_M+SDmNQDb_EsxSctQw-fkt2WJhczZakOjQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Fix out-of-bound access in uclamp
To:     Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 at 17:27, Quentin Perret <qperret@google.com> wrote:
>
> Util-clamp places tasks in different buckets based on their clamp values
> for performance reasons. However, the size of buckets is currently
> computed using a rounding division, which can lead to an off-by-one
> error in some configurations.
>
> For instance, with 20 buckets, the bucket size will be 1024/20=51. A
> task with a clamp of 1024 will be mapped to bucket id 1024/51=20. Sadly,
> correct indexes are in range [0,19], hence leading to an out of bound
> memory access.
>
> Fix the math to compute the bucket size.
>
> Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
> Suggested-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Quentin Perret <qperret@google.com>
>
> ---
>
> Changes in v2:
>  - replaced the DIV_ROUND_UP(a,b) with a/b+1 (Dietmar)

Doesn't this create unfairness between buckets ?

If we take your example above of 20 buckets, delta is now 52. Then we
expect the last bucket to get the range [972-1024] but values lower
than 988 will go in the idx 18. And the more bucket you will have, the
worse it will be

Your problem comes from the fact that we use 1025 values instead of
1024. Wouldn't it be easier to have a special condition for
SCHED_CAPACITY_SCALE value

>
> This was found thanks to the SCHED_WARN_ON() in uclamp_rq_dec_id() which
> indicated a broken state while running with 20 buckets on Android.
>
> Big thanks to Qais for the help with this one.
> ---
>  kernel/sched/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 98191218d891..c5fb230dc604 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -920,8 +920,7 @@ static struct uclamp_se uclamp_default[UCLAMP_CNT];
>   */
>  DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
>
> -/* Integer rounded range for each bucket */
> -#define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
> +#define UCLAMP_BUCKET_DELTA (SCHED_CAPACITY_SCALE / UCLAMP_BUCKETS + 1)
>
>  #define for_each_clamp_id(clamp_id) \
>         for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
