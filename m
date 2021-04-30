Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7691B36FDC1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhD3P2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhD3P23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:28:29 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7F8C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 08:27:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a36so70445078ljq.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mh9VQ4lqbG7PU0zxXU61/zkGzqt9dmCvOlEJ8ZziR28=;
        b=ea9RAHoe2Ux5JNof44BAAmQ+7CdlNsH0U5oQ6DbQ5dFbl/jcRANVrFEG/Ble+DepZA
         nTASlF5DqX4NkNDhpruSeSdq61WKLCxlcmCc7027/SKbtctl9I1uhm/J3QSkk6Kytw97
         D1FyoITx0h4kdaGYISpk1AzXFEw2hB/zuc57U4phXp0zD3S8ZXz4rpaDCc3S7y4bNfak
         8ltgHlNCY2giMpyfV6Q5zBXHujWTEvxOjHqC28Wgf6fozeWcCmof6WOjjgiuGnkjwofR
         tnpj1TcRdiYLtAVMUZPSncupK432OP0wGyY+QTiaMElNgt3DGhseznl3ndNiRJj6SKI/
         PfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mh9VQ4lqbG7PU0zxXU61/zkGzqt9dmCvOlEJ8ZziR28=;
        b=eOgwt5kIIz0RXCqN6j1fTkm5mtWVuU6IqNym0hhpl5VOmPKEK8/qGhHyQil84PB9Qo
         0MwX7OcYEj+bzFFvjivOHmmxpt+u6hVZW6sJAlB+9xOKAyEDtguWCCyHW9EeO4QgVdfi
         Xc4woA46oXRKVCzeUFQJIT7LMRM2SYYnHxto/b5PdMc3DP6ziz4Y0CFmggMgEFO4/rAK
         0E9YUwEnBFVGXdJZlyq0ZYtCiE2XFZoYN1O9RWp9+BdtEZrCevMOQDC/Qwre/aoneppV
         mdBpInzCiVJrevW7c3rFdrx/xy+Zh0oQ01yRONGPIQoXOTgGIc6382yOh0RfV4YKLXKX
         Hg1Q==
X-Gm-Message-State: AOAM531no3MShL+PLRNqXhuFmGbQpr4Td07viF0vPByH76B4O/V6Yzqz
        R7P6vUDTKdDZdEEmcsj/wergAf5LXN/r4W4OSVhX0Q==
X-Google-Smtp-Source: ABdhPJzP/6ULxEPud3dZTDR/T+limAF1K4IjfJ/SqxG3YtIz2/mXboaRnyHyUpfHqu/zxuAKcPyXizaNPsWgzLKWTPs=
X-Received: by 2002:a2e:8794:: with SMTP id n20mr4031314lji.401.1619796459418;
 Fri, 30 Apr 2021 08:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210430151412.160913-1-qperret@google.com>
In-Reply-To: <20210430151412.160913-1-qperret@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 30 Apr 2021 17:27:27 +0200
Message-ID: <CAKfTPtCxVc+KSOJW0a3xK1mGc-qWH0v3wmAuqeB467t+wza78g@mail.gmail.com>
Subject: Re: [PATCH v3] sched: Fix out-of-bound access in uclamp
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

On Fri, 30 Apr 2021 at 17:14, Quentin Perret <qperret@google.com> wrote:
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
> Clamp the bucket id to fix the issue.
>
> Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
> Suggested-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> Changes in v3:
>  - Keep rounding div to improve fairness (Vincent)
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 98191218d891..c12ec648423e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -928,7 +928,7 @@ DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
>
>  static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
>  {
> -       return clamp_value / UCLAMP_BUCKET_DELTA;
> +       return min_t(unsigned int, clamp_value / UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS - 1);
>  }
>
>  static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
> --
> 2.31.1.527.g47e6f16901-goog
>
