Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9ED446A1F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhKEUw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhKEUwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:52:23 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F283C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:49:43 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e144so12157103iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNiSOY3Ex2kKhYTAI345g/wYTliLswlFSNFOE/JFxUQ=;
        b=MENF/AIiOuREajqRtDDqrgQlsyhpEjqOb/pon3tRfk3CFVTv2GFQ3zI2vcKlgz91PO
         WV3YSeYDvnBONNN7YCC8mPyNQrf4htW6TIDX/iojmhApTcDix7Dnismyo7IZy+Wpvszk
         vFouOed3KfvXCXHfhdsL1IexhB2dtFoXtazvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNiSOY3Ex2kKhYTAI345g/wYTliLswlFSNFOE/JFxUQ=;
        b=LFR4VuYKWbCd2YlJr3xS3b9xHxF2ULoNGHLCB3iMAf4KxWViwuv+RCzfPI5pp1qt+u
         7iu2ah35RiZrDuGxFgtzTZ0I96y8jyJ/061za9nZsyyKLxzrLlU4s1OByeRY1NM9i0Ef
         GlH+7xu9G94ogIsuouUiLGLuVDClOiUH78D1RIwlw382Wa72yngugs5weIAmKN4uuPq8
         jmRp+VSuC6Qeibu8hg4PqhyMlu+uDga/1o8/EBxMPdl+OamPseuX480AzIqSlTHWcTKR
         cG/miuaxGJgGVuWUQy1xn3z0kVb/CO4u68+GBLy6KbOjENno3Jr8LjjzlJuNxficsZN2
         H8DQ==
X-Gm-Message-State: AOAM530S3799ywgM1chlPoKyM4TEFwnkSLtka7Wy2wjVx6g0T5GjO1rg
        XYQV2oiMefzfTHIaDVCTapD+EjMvWnNO0Q==
X-Google-Smtp-Source: ABdhPJxEiiXZpYcaVo7l2Z/fyp7GyX4OGMb/co5AXLkA+YlPqAIcjOC4uReju6Fqy2j+esN6iYr5Hw==
X-Received: by 2002:a05:6602:1d0:: with SMTP id w16mr1206973iot.140.1636145382825;
        Fri, 05 Nov 2021 13:49:42 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id x10sm5380907ilv.72.2021.11.05.13.49.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 13:49:42 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id v65so12142484ioe.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:49:42 -0700 (PDT)
X-Received: by 2002:a5d:9753:: with SMTP id c19mr1196799ioo.136.1636145381818;
 Fri, 05 Nov 2021 13:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211103210402.623099-1-robdclark@gmail.com> <20211103210402.623099-2-robdclark@gmail.com>
In-Reply-To: <20211103210402.623099-2-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 Nov 2021 13:49:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WBkGMXPvuLaQ0n2V3UgAQajvYg=dPwZNx-TnpXMV1bvw@mail.gmail.com>
Message-ID: <CAD=FV=WBkGMXPvuLaQ0n2V3UgAQajvYg=dPwZNx-TnpXMV1bvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm/gpu: Respect PM QoS constraints
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 3, 2021 at 1:59 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 31 +++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> index b24e5475cafb..427c55002f4d 100644
> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> @@ -158,6 +158,33 @@ void msm_devfreq_suspend(struct msm_gpu *gpu)
>         devfreq_suspend_device(gpu->devfreq.devfreq);
>  }
>
> +static void set_target(struct msm_gpu *gpu, unsigned long freq)
> +{
> +       struct msm_gpu_devfreq *df = &gpu->devfreq;
> +       unsigned long min_freq, max_freq;
> +       u32 flags = 0;
> +
> +       /*
> +        * When setting the target freq internally, we need to apply PM QoS
> +        * constraints (such as cooling):
> +        */
> +       min_freq = dev_pm_qos_read_value(df->devfreq->dev.parent,
> +                                        DEV_PM_QOS_MIN_FREQUENCY);

Chatted with Rob offline about this, but to document on the lists for
those playing at home: the above function isn't exported to modules,
so this will fail with "allmodconfig".

In general this isn't the right approach here. I believe that the
right approach is to boost with freq_qos_update_request() and then
kick off a timer to stop boosting after a fixed period of time.


-Doug
