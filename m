Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4AA397528
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhFAONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbhFAONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:13:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF6BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 07:11:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q1so22043127lfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T908x8cZzZ3DYq+TZIGy77hBG4C4i0blq3DVfN+x8fQ=;
        b=RinfGBRJPtALaXeBxqE+Wq0ulbbnpOAs4rsN+O6SS3ba9wq2BRgWVV9eLE+UjduBcf
         b3T8CxdaEi3+uSRWFaP6UyF98Y2VSpUqJ5R/Cg4MmyS9rSKzG1jaOyFEUMewL6DkG5Dx
         IQlGX4n57XfJizgLTCc33Bb7Yna++N4ZYm4p0wSo6lu7YbtvgoGQrSuevI/Ma4awC5Ub
         LCbhOue2Ss8wCo3GoqzyZamotYFcogg9Hu5Kr3GQRqu28sIl2+EU3fj4wbBO3F5pNYdm
         GUPPAmFqK9w20T3WdA8n4n9c0ZahvhtiTAGarA3peTte6BvRJf5BlF5ao486MjiP7fsK
         e9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T908x8cZzZ3DYq+TZIGy77hBG4C4i0blq3DVfN+x8fQ=;
        b=dy1UKTTQZmGkVF6/V1isrnlPAXEwJydb2NsxD05Y/MzrRcsrFwoHsUylCDJsjobJg6
         QiY9en1QIE/VTw8PMnqDBLLcFMqTGxmcAjTOS4JS/CLcoM1ZjZ1uAeuuZzmDAZImQseg
         kJGI+yIuQyw6ja4idCGE7Ao5fssaNnWdxZm8SMI/vhL8xWV5hfrJl69ONAO4mvS8ct3v
         /d0X1L2wqOmWDYCWWnOanzNo2bGcZTuEKQ04EwIf8JzXjOiRUEnp9PpbjLK6irBjtwTa
         mBOaNwpswZvgngADdqvqXDTF3DtqVk0ABckSCrOVZYSmIQUL9OLfyWrphn9V33wqgnU9
         jBsA==
X-Gm-Message-State: AOAM532M2Fx5wxssji0pMcqZsshsTcjaNN/QaoQO0JZX5M3PUvAGCAaP
        3D492b8qc36n6Tz46mrHcv2WbFSGx2bh9URN0+X/vg==
X-Google-Smtp-Source: ABdhPJww2zxujaN1d3GbDRmU6aiDVQYTz94T5FW1Sxl+Q3Uqh31UIC/A69U0g8uQzJpjbe9kZVF0+k/ChePOaP3n9n4=
X-Received: by 2002:a05:6512:3483:: with SMTP id v3mr5508265lfr.154.1622556698999;
 Tue, 01 Jun 2021 07:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210601083616.804229-1-dietmar.eggemann@arm.com>
In-Reply-To: <20210601083616.804229-1-dietmar.eggemann@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 1 Jun 2021 16:11:28 +0200
Message-ID: <CAKfTPtDTxOA48R80cBqs+PXUc5jXg1VsYmyYt8Y=zy4N-wztFg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Return early from update_tg_cfs_load() if
 delta == 0
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 at 10:36, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> In case the _avg delta is 0 there is no need to update se's _avg
> (level n) nor cfs_rq's _avg (level n-1). These values stay the same.
>
> Since cfs_rq's _avg isn't changed, i.e. no load is propagated down,
> cfs_rq's _sum should stay the same as well.
>
> So bail out after se's _sum has been updated.
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>
> This patch is against current tip/sched/urgent, commit f268c3737eca
> ("tick/nohz: Only check for RCU deferred wakeup on user/guest entry
> when needed").
> It needs commit 7c7ad626d9a0 ("sched/fair: Keep load_avg and load_sum
> synced").
>
>  kernel/sched/fair.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e7c8277e3d54..ce8e0e10e5d4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3548,9 +3548,12 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
>         load_sum = (s64)se_weight(se) * runnable_sum;
>         load_avg = div_s64(load_sum, divider);
>
> +       se->avg.load_sum = runnable_sum;
> +
>         delta = load_avg - se->avg.load_avg;
> +       if (!delta)
> +               return;
>
> -       se->avg.load_sum = runnable_sum;
>         se->avg.load_avg = load_avg;
>
>         add_positive(&cfs_rq->avg.load_avg, delta);
> --
> 2.25.1
>
