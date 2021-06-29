Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C02C3B6CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 05:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhF2DOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 23:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhF2DOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 23:14:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E81C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 20:11:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p24so13734659ljj.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 20:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVL0iF2pyJzy3SJuU/VLYWxcuduJVIFdS9GgZ5fO+Ds=;
        b=jA3IAodVre+DN+Je+GX2+VFbuYJbIoEbgIn6M9NYNuVSH7Vv15Zg9W7Scr4I3XCAZJ
         pguI/FSibh7s+49Ddn+JVFwxmPrHWorCbgLR8Soweq4d+iX8mpD9WA0DxdbULFLKLIaG
         Ntc9YpwWMSRSv4bIUlaNY/V35O+3sjGi2Bdv3za8rPRXLz9aC2bNG6DMZhY1hNjAojWO
         rCe2P5rjDvi78Ng1DR9diZMRTjufAiNOV01eC+r1huDxYS+Vo8P2QTh61WN9iTlFAzOf
         D3Wnja7xHisJFlvIFJMT4fOM8UVayGeX2jXruVXgBYdmgIBtJ50RiOR9vh2k6i5AC3ng
         VCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVL0iF2pyJzy3SJuU/VLYWxcuduJVIFdS9GgZ5fO+Ds=;
        b=sXow6XcBdjx2pYM5z+RIc5+oAUTkWgCbV3HMmfKEtdMSw79Cvnvs+Ye3uhVKu+rqY1
         ShS+XSWQ5IaAb6y8blFSTRqfzuYo6E4HWZivw2OMc48WrDw+MJnzyLHodVmkA1sbqoHx
         TH4+mwaCUSJgh9SVTrgoH8VrKRTIPiL0Ci8KU3NbYw6dSYR2CjalWHXeieqyqFqERWUf
         sFh5URzyz7w1GBw//kCVb8iYnZOLhpDsMF25q4n2IhhPvhqnR50lcaseklBD/v58QcZx
         lPqV6+f/t/sF2KBh/+u20lGTS9DoMtVm/ZH5mW8hP27TY1zVbhGgmsWHxeb9nrNsZ0r9
         WnYg==
X-Gm-Message-State: AOAM531/Xytc9JkZiQcmLnEL+OfvcLkfp8GAB5PjzUWOrSXCVjZB4nVa
        D8CYzj8M6xBx/eNaeDC0j1h3WmXEe+tHVNQ3uGDLS/OLZvJbnw==
X-Google-Smtp-Source: ABdhPJwRqaxMSZF4CH7G4nwvw70Qea5Ax9KdrIUcGerJDLXQ1bKsSNOn8UN0nL9+7AmT0ke1aWQVXDHl6XcQVJwgwfU=
X-Received: by 2002:a2e:5352:: with SMTP id t18mr1852718ljd.420.1624936293141;
 Mon, 28 Jun 2021 20:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210618072349.503-1-xuewen.yan94@gmail.com>
In-Reply-To: <20210618072349.503-1-xuewen.yan94@gmail.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 29 Jun 2021 11:11:17 +0800
Message-ID: <CAB8ipk9BNe0uAZNAb7x4UHPrDt=ukmwcqujZB=bOZGnX0vWt2w@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Fix getting unreasonable ucalmp_max when rq
 is idle
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Qais, Quentin

Hi Dietmar,

The patch has been around for a long time, and I think it makes sense for EAS.
Do you have any suggestions or comments?

Thanks!
xuewen

On Fri, Jun 18, 2021 at 3:24 PM Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>
> From: Xuewen Yan <xuewen.yan@unisoc.com>
>
> Now in uclamp_rq_util_with(), when the task != NULL, the uclamp_max as following:
> uc_rq_max = rq->uclamp[UCLAMP_MAX].value;
> uc_eff_max = uclamp_eff_value(p, UCLAMP_MAX);
> uclamp_max = max{uc_rq_max, uc_eff_max};
>
> Consider the following scenario:
> (1)the rq is idle, the uc_rq_max is last task's UCLAMP_MAX;
> (2)the p's uc_eff_max < uc_rq_max.
>
> The result is the uclamp_max = uc_rq_max instead of uc_eff_max, it is unreasonable.
>
> The scenario often happens in find_energy_efficient_cpu(), when the task has smaller UCLAMP_MAX.
>
> Inserts whether the rq is idle in the uclamp_rq_util_with().
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/sched.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a189bec13729..0feef6af89f2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2550,7 +2550,10 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>
>         if (p) {
>                 min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
> -               max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
> +               if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> +                       max_util = uclamp_eff_value(p, UCLAMP_MAX);
> +               else
> +                       max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
>         }
>
>         /*
> --
> 2.25.1
>
