Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE6A36BFC8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhD0HJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhD0HJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:09:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444D8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 00:08:58 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h36so37973610lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 00:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpc/mBuS+58PyAmOv9kCzsRuB8j7qrM2+7/Q0mTJQQk=;
        b=ngoEmbTManf3zVhTwMI8I6Gkla36OxA/odDw5fyjWoP0JgIiSo5ojV/J6R7tnKFZTI
         8DQaWeLJCg9kfxNF8n4aBZorix8SilKPIEQ4NE62X96dg0Htm70INl03sAKWikjPS7gc
         tk2Nqp6Pqb8m5HGGM8+k013flJxXT7Gj85QT8o0+9dQXVCJffDO3aK0j3B532DMrcDUp
         yLRqI4Yd34f1PfV+UXtwQchteFLFUHZG8y4ReHzAfUqK0VQaUUkqbfTaXZVXxuSb889f
         E2bSgvaHlPBIi/T4t8rbREZ58K8WpRYDwPTRZvOmv03Qn/L9KbZ83Y6C3WELF1K3vHDZ
         DAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpc/mBuS+58PyAmOv9kCzsRuB8j7qrM2+7/Q0mTJQQk=;
        b=PX8an0IqVd+qbx1TWmqj7rRVYSjLhJWsf0KUAr7vTBbmQD2Idn4qfqNUz95FHBthCs
         ZVuox5W79BxGRXLELCgY25aiVE8ewMJNLKwg8Oii9YlvupIs+ehd5L3+ZMZbf2gsQHwN
         eHkR/24ftAz91I/OqFazDUbAPMIeSoVOKVjR8IjLXOx71vf8fxZylsaCA1U+svAfCGDI
         AwZc6LfzxJqhEsuE9w0BISu3nYRLLBzeesXgbpbTLoMjWtBIPw/oESe0Y6b8zEW+NqgJ
         Oopo+NYqQjgB9GN/I88PF9snaqbALAmrStq1AQf3fzdzMUcIOFu1uQQz3NskADxe1rgo
         Fftw==
X-Gm-Message-State: AOAM530sn1LV7zvM53VrUmEIMQq+K5ZC5zEGB0fuSjMW9lGs8NlbpPTL
        oGwjYB7bQtwpzSdbb0sPp5V88+zHm8GEn2aArTz4WadWXDk=
X-Google-Smtp-Source: ABdhPJw1WpdUy7iy2oFs+++itZlsi6v3Lw101UuIXsLp/xZz0mZ2QdPKMeiWFqcDkUkaLqLi29wO18G9xKqwTjUHsus=
X-Received: by 2002:ac2:560b:: with SMTP id v11mr15548986lfd.254.1619507335977;
 Tue, 27 Apr 2021 00:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <1619456652-19143-1-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1619456652-19143-1-git-send-email-ego@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 27 Apr 2021 09:08:44 +0200
Message-ID: <CAKfTPtDqcQPdSzLRzteF6F6Q9G6qO43LrMKRJTQBrMkfQMCamg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix unsetting of "has_idle_cores" flag
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021 at 19:04, Gautham R. Shenoy <ego@linux.vnet.ibm.com> wrote:
>
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> In commit 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()"), in
> select_idle_cpu(), we check if an idle core is present in the LLC of the
> target CPU via the flag "has_idle_cores". We look for the idle core in
> select_idle_cores(). If select_idle_cores() isn't able to find an idle
> core/CPU, we need to unset the has_idle_cores flag in the LLC of the
> target to prevent other CPUs from going down this route.
>
> However, the current code is unsetting it in the LLC of the current CPU
> instead of the target CPU. This patch fixes this issue.
>
> Fixes: Commit 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb..5fb5020 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6171,7 +6171,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>         }
>
>         if (smt)
> -               set_idle_cores(this, false);
> +               set_idle_cores(target, false);
>
>         if (sched_feat(SIS_PROP) && !smt) {
>                 time = cpu_clock(this) - time;
> --
> 1.9.4
>
