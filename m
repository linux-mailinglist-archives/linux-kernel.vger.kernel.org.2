Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C0145396B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 19:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbhKPSeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 13:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbhKPSeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 13:34:06 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993FCC061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 10:31:09 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id s14so89568ilv.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 10:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1EViyUHQdSut6g+RY4rG3RX+9KMNh10G4tRFHz9NG9E=;
        b=BPlylCR84zbphWWF7YUzdn4WkJmgNf/MrOQz/jFWkfQ9bdYeyGwjDpcFolSsS3egOe
         8X/fCkqeL2w5C4MYsBNhuj/7w/970bRxMisig2Bd3UUXBUHNRAA7a6/Ow3S4dkSEsswr
         dk630OUIqnhLds9oSGFMgYz8tM0D4JR8gRkKLuaMISRSh282560nfqfSSf6Muiaa3EKK
         de6oUD6qfQdBZYk+S/n4AeYIfoVt+xAbPphoDbukYetQD/dnNeGcMi15nTm4BXgaTbyu
         H8/e/qZ/n6+EudcD8Jox7vFxLYdohLimBZYEa9C2tVX0dMEmOgpUzTpTkFGYvdt0YmJ2
         XGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1EViyUHQdSut6g+RY4rG3RX+9KMNh10G4tRFHz9NG9E=;
        b=ztc1DuAFHSiH2cQ2UHO4Yufk5IxIji5OuDxGS3gtsaBXXWysYWfuMOQo4Gh2lEZFCU
         aV9G9DiatMq03Fr6a8wL6z4jDQ50fvWEaNfREQKA0NijpXE4m0XsKcUlp4WTRKwrEEa+
         wRG6csY0Wl93HWPOQM0tSgpSKkGLj1p2ZO5ZBBJKsF5NN1h6nyi/jtZR86uupCKX/U+y
         KyeqQFwE63sYt1IO983/7HYIoEjAh25QZLQdKvYkBsRbFELNXKYeVr5TGzddYjuGBLqu
         suoYcczwOJU5hwB0sI0qvFX5fN1Se4aLTeC89szyrftjOv0L220jank5hFnTOcZ7I2ng
         ltMQ==
X-Gm-Message-State: AOAM530jPRzOke7HLjUJtkBPF6vkffxuR/oaY/LR3gdtub+zrs3tsPS5
        uI5YKqin37Z7NZRXP8E0ImPoletPmOq6wB64kES7hA==
X-Google-Smtp-Source: ABdhPJzOKDJ98X1OJQtFLiL6PuZPZvNI9s+5gIkGORkhTGagdy3QHFC93lEmQFbr1bq8pi3PmWdmQK2SEkSuhCUfKaE=
X-Received: by 2002:a05:6e02:1445:: with SMTP id p5mr5940397ilo.105.1637087469025;
 Tue, 16 Nov 2021 10:31:09 -0800 (PST)
MIME-Version: 1.0
References: <20211116155545.473311-1-robdclark@gmail.com>
In-Reply-To: <20211116155545.473311-1-robdclark@gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Wed, 17 Nov 2021 00:00:33 +0530
Message-ID: <CAMi1Hd0qzu1t6QeZCNgSoTrScZL0_XQnZUPkQ5y7D+oV49GREw@mail.gmail.com>
Subject: Re: [PATCH] drm/scheduler: fix drm_sched_job_add_implicit_dependencies
 harder
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 at 21:21, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> drm_sched_job_add_dependency() could drop the last ref, so we need to do
> the dma_fence_get() first.
>

It fixed the splats I saw on RB5 (sm8250 | A650). Thanks.

Tested-by: Amit Pundir <amit.pundir@linaro.org>

> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Fixes: 9c2ba265352a drm/scheduler: ("use new iterator in drm_sched_job_ad=
d_implicit_dependencies v2")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> Applies on top of "drm/scheduler: fix drm_sched_job_add_implicit_dependen=
cies"
> but I don't think that has a stable commit sha yet.
>
>  drivers/gpu/drm/scheduler/sched_main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 94fe51b3caa2..f91fb31ab7a7 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -704,12 +704,13 @@ int drm_sched_job_add_implicit_dependencies(struct =
drm_sched_job *job,
>         int ret;
>
>         dma_resv_for_each_fence(&cursor, obj->resv, write, fence) {
> -               ret =3D drm_sched_job_add_dependency(job, fence);
> -               if (ret)
> -                       return ret;
> -
>                 /* Make sure to grab an additional ref on the added fence=
 */
>                 dma_fence_get(fence);
> +               ret =3D drm_sched_job_add_dependency(job, fence);
> +               if (ret) {
> +                       dma_fence_put(fence);
> +                       return ret;
> +               }
>         }
>         return 0;
>  }
> --
> 2.33.1
>
