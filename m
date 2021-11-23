Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646F4459E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhKWImC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbhKWImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:42:00 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AF1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 00:38:53 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b40so89269534lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 00:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=up18eYzdnxXTWHNsUXwqxGU2gp1D+ydyOMfB0ArTlEY=;
        b=pTmfW9qVA6LN/IRPzq9Ul5ZwBghS2pihuKVYwfvO/7HtMpfb7k1j3wgiFZNlFTAS1g
         dompAHyCWAHxAqEz5bpjYzGSNWFXuljU7Cj4CPYZ73rwgloqI5EixAjDwe9Mc1PVYYhw
         1RUmzSbq1gmhZLAofXuOil/wg9QRVBPqBY8djt8YUffTbhhBL1ZoZQXkHvUxs/16bU/m
         8mdPcSAPsJwTwjfiwlfQ25aVwcp3IrJRqxHTiYx7Lyls8RBeVo3q0NRo2yAynvmw9qVo
         ftEIpiRj2DovBqu/fSQte3nDbmtLDDfrvgj8JbLXkIiPjFhPGLeHvGTTp8XNTib0U1up
         +NpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=up18eYzdnxXTWHNsUXwqxGU2gp1D+ydyOMfB0ArTlEY=;
        b=11sm024yincIU1D/zaQVPFrDBtVhNUOpkzf8CgI3I2nA6niAf01bND3i/Ak5mVdwnn
         SGDZ0z+ox+pq/yr49eojkWeF09fjCZBJWpJRo7cSEXpAQgun90yrtZ9FpPAdnqm2MEFD
         2apML4fpLxZs79G3uYk5IH2S4OBGi8KP180Dzr//qAsOkjpNx6JuKYcPR49p2oX9LwsL
         x9NCIuRK0SvPVplpUUls68LxFd7gLLyBecdDPY9T8xdpb6HdUeKl1jbenVK9v/uwPNJU
         DeYCVBeP9EJa7klvRcSfOnwM7vUz0vjHI4AjwuysDCrEBk/+wStd/DjvzAfq0rsZD1KG
         h2/w==
X-Gm-Message-State: AOAM531ldrPsY4usIHB82KMvPNpMbUFQssvA4s+8r5Ol2vUt4cdExC79
        e+wzxLo8BowmX0RPSvAJt0Ntmjqy5ElnBqSIttiFIQ==
X-Google-Smtp-Source: ABdhPJxIxmSMHCjlYeU6LVXG4Trde1FIMJGgq1zyORo3IIUkeMlFQ7iCiSdqTlROiaRl4NFEs0kwD5S5MOvYZY8lpx0=
X-Received: by 2002:a05:6512:2618:: with SMTP id bt24mr2991911lfb.46.1637656731451;
 Tue, 23 Nov 2021 00:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20211118141411.2623521-1-vincent.donnefort@arm.com> <20211118141411.2623521-2-vincent.donnefort@arm.com>
In-Reply-To: <20211118141411.2623521-2-vincent.donnefort@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 23 Nov 2021 09:38:40 +0100
Message-ID: <CAKfTPtBTVQg+vrCWw++Gn+NBfOCJy3PcsthhNLEHNo+Yr5Bw_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched/fair: Fix task_fits_capacity() capacity type
To:     Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Valentin.Schneider@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 at 15:15, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> capacity is an unsigned long value, compared with a task utilization which
> is unsigned long as well. There's no need for an intermediate implicit
> long cast.
>
> Fixes: 3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8fde6e10e24b..26a88975f68a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4070,7 +4070,8 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>         trace_sched_util_est_se_tp(&p->se);
>  }
>
> -static inline int task_fits_capacity(struct task_struct *p, long capacity)
> +static inline int task_fits_capacity(struct task_struct *p,
> +                                    unsigned long capacity)
>  {
>         return fits_capacity(uclamp_task_util(p), capacity);
>  }
> --
> 2.25.1
>
