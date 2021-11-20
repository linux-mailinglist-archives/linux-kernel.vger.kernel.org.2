Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DE9457A1A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 01:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhKTAZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 19:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhKTAZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 19:25:00 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990BDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 16:21:57 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id z18so14947451iof.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 16:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8zLquZzs24iQjQC4Eaf2dLTzvdVr5K8bViakf/mMOaI=;
        b=kv1u5ZYg776ndeEU+ERi/P4xWfao/xyifsnXNd6vd0PjjQj6YfGBG054WD5AXigBWg
         GofqDX1eF4snfQCNUDkT9oY1Il66VX9FHDiH1xQHNoQXF4s3kaveMXx+i1Kb6crl5kOB
         /EaOXTPzgjEUns83ux1D0Dt9A3I00EvK6vg30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8zLquZzs24iQjQC4Eaf2dLTzvdVr5K8bViakf/mMOaI=;
        b=t4LyTQ99Ic6dhqeWheMc6ZYKHI8fkwTkXLYqLa3ghJtw8tOaPTNRUOKa3ShWSKT/Mv
         ZYhDhNL5oV0jM3T1rBccdTbY5RZU0712g5ENQCL4YQYLcJZlrZVUd+afRPKEHJXubYKY
         WNWb/HaY4a6GPH6uyvjtUApTMiHjGEICiNyUrM7RJ4K5ceppdJKyj4LPSyDzaPBGUHU4
         PGHP03h64W9DDowWFcjv5k9jS2HRg2s2HQIgZqgKIYqKa8MCQkdv+57xaR2QIAtzkiWw
         BsJx+hYZYqxc3/Q+27nbdQD92A+CbJp2sCcZ8Za9j6JKz7uSfq51LKWvUs71OCwFeU7a
         MM8g==
X-Gm-Message-State: AOAM533AlzqfXEDHtVmGPvyopk6sw5uBtiRRf8OH6MRStQlhKhUiI+Gd
        dBqC4krdSEucuhBweuYSdmgya870BRMYTg==
X-Google-Smtp-Source: ABdhPJy11HC76f40vo+OJCs1ZypCDoPFEThtRG9/62jFRWhiBPbVxkNI7XtLlQEKq+celrpCvRFNPw==
X-Received: by 2002:a6b:d10d:: with SMTP id l13mr8439389iob.216.1637367716816;
        Fri, 19 Nov 2021 16:21:56 -0800 (PST)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id k13sm963066ilo.40.2021.11.19.16.21.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 16:21:56 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id l8so11884385ilv.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 16:21:56 -0800 (PST)
X-Received: by 2002:a05:6e02:18ce:: with SMTP id s14mr7289654ilu.142.1637367715969;
 Fri, 19 Nov 2021 16:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20211119225157.984706-1-robdclark@gmail.com> <20211119225157.984706-2-robdclark@gmail.com>
In-Reply-To: <20211119225157.984706-2-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 19 Nov 2021 16:21:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UraStftJyUDHp5=iKoh4tnCQiTgBZJBNF3-q=HDZUPZw@mail.gmail.com>
Message-ID: <CAD=FV=UraStftJyUDHp5=iKoh4tnCQiTgBZJBNF3-q=HDZUPZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm/gpu: Respect PM QoS constraints
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 19, 2021 at 2:47 PM Rob Clark <robdclark@gmail.com> wrote:
>
> +void msm_devfreq_boost(struct msm_gpu *gpu, unsigned factor)
> +{
> +       struct msm_gpu_devfreq *df = &gpu->devfreq;
> +       unsigned long freq;
> +
> +       freq = get_freq(gpu);
> +       freq *= factor;
> +       freq /= HZ_PER_KHZ;

Should it do the divide first? I don't know for sure, but it feels
like GPU frequency could conceivably be near-ish the u32 overflow? (~4
GHz). Better to be safe and do the / 1000 first?


> @@ -201,26 +217,14 @@ static void msm_devfreq_idle_work(struct kthread_work *work)
>         struct msm_gpu_devfreq *df = container_of(work,
>                         struct msm_gpu_devfreq, idle_work.work);
>         struct msm_gpu *gpu = container_of(df, struct msm_gpu, devfreq);
> -       unsigned long idle_freq, target_freq = 0;
>
>         if (!df->devfreq)
>                 return;

Why does the msm_devfreq_idle_work() need a check for "!df->devfreq"
but the boost work doesn't? Maybe you don't need it anymore now that
you're not reaching into the mutex? ...or maybe the boost work does
need it?

...and if "df->devfreq" is NULL then doesn't it mean that
msm_hrtimer_work_init() was never called? That seems bad...


-Doug
