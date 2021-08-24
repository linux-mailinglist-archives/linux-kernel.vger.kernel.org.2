Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB43F59BD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhHXIRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhHXIRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:17:19 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DA4C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:16:35 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id x10-20020a056830408a00b004f26cead745so43799848ott.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3UqCHlK8sVSZU+TDBrb1G3FeKL/d8pZgFNmp6Irgs4=;
        b=nLdrinS2o9MMyh/tZir9Es20DVqsoUeZ4rCzviM/Cp/R9HsN4ZVlio6kstoO3CFisb
         4zZ78eTVPZrKs1ScaE8HewV5taPcmDMM6lMxOj1Ukw4eWJy4nDPw6I5FnhCC2LY6u6Y6
         fTnm1564FNJp4jHGVX4d1EPYbo2QTmnr2DjC3yFyPZShe0tGlgVg4QMwM/0P/KUtljs2
         QOY/ShDlfIRPQyhZ0d3YIq+MqRE8mikKAVDcSRDM2pW6WKEcwsBqccdn58wr2Uhy9cna
         jUFFTe+9XvS+FhJZeqgJyKDWszpdFbSA81mkoPRS3yJ2p8A1/wEgLT2Lhrj+6eUh75+S
         vA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3UqCHlK8sVSZU+TDBrb1G3FeKL/d8pZgFNmp6Irgs4=;
        b=N9nJGKa76n9Bj4XokFlnyOT3aQCJJcE3PlOnORmzUFtTHW5hARaUFHWFjl2AzorKo/
         3zYDpmK0LO7c9Jxy87XgaPlQqkboJFsQQ2OShy3T85Y28U4oHXG8vYrlq0+GD5HgMqXy
         n19T1Fe7qCF/xR8BZlY5coEhKkx4AO2s7lvvV8/AaT0iFaMJmvHGPRbf2xwd7mz4sgf8
         Q/Bi2V5V0A9XI0S9MDOO101QtgGir0dn8lHNHG1ogSpwRYTOQduiRlfsnh7zWpZU5mu3
         yxVBq1UnlM6kLQ3WU4mh0ii7zO5aJFlni5yruDwIyf2ACY9etVHIieaacgt6AUSDbyyV
         A7wQ==
X-Gm-Message-State: AOAM530IWoNFbCdFHo2RZH8YvK3B6YQJFfXFR9mLW+1LoyWpa+NSP/Os
        3GHWwAWlZ/2Qmh7DOOpOhNgM78dWHDyK8F3UGCs=
X-Google-Smtp-Source: ABdhPJy+5XxknKAQRbz5NJ3mGjBjPPwq7pOb1ya0lTDOpGS5UcWotXxGFSsqt64e0+43Eplz1rPxAwJzPWne4BL4sF8=
X-Received: by 2002:a05:6830:20d0:: with SMTP id z16mr30588553otq.330.1629792995143;
 Tue, 24 Aug 2021 01:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com> <20210820010403.946838-5-joshdon@google.com>
In-Reply-To: <20210820010403.946838-5-joshdon@google.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Tue, 24 Aug 2021 16:16:24 +0800
Message-ID: <CAPJCdBnz7AzAWyD5Sqc4TLy3By1k4PAex8kpaWrcJb=YPwVC8w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] sched: adjust sleeper credit for SCHED_IDLE entities
To:     Josh Don <joshdon@google.com>
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

Hi,

On Fri, 20 Aug 2021 at 09:06, Josh Don <joshdon@google.com> wrote:
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
Tried to push a similar patch before, but failed. :)
https://lkml.org/lkml/2020/8/20/1773
Please pick my Reviewed-by if you don't mind,
Reviewed-by: Jiang Biao <benbjiang@tencent.com>

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
