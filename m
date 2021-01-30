Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2CC3095A7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 14:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhA3N6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 08:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhA3N6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 08:58:43 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7191DC061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 05:58:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u14so9343873wmq.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 05:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBKUG7e5aqeOZGFoYP7ajq6QVA6ioUHiy3uBhfAtdJI=;
        b=qX3AdBndzdu1u93uXZHXtrPIfIN38cJ+h8iH3Ect4Br9Oav1roudJMSFJxpEin65gr
         2Pnpl+IkFFWxL+Z0FLYe9cYB73qoe7OkQ0YTvoJKlCpSt34J0cy4kxO+fWXoGLzf5Izp
         uxkNv8tlpqGAN+PIBDgt6GwGnnQyHgit9SksDxvLq0FJ2R6cop2SpO9JSyEKXcNa6NPf
         9IceVOjaoSMp6kBGTgQFsnuppn2YBuoyLClQVtA8uCLOosrcFXIJvguPBU6Kz+LMxGM+
         NDRVq+lEgO1MWWfpkeQ1WO6Ibt7flfDzHEoVJ1AXFm5+eDZ0p3tqytxXqG/ppt284hmt
         wp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBKUG7e5aqeOZGFoYP7ajq6QVA6ioUHiy3uBhfAtdJI=;
        b=jMT3nDYikTfvuq9zJ9SkX3f/VWy4xS1ZY/97uBy8FZa2CfDJoacguTXFHmAJz/g8V3
         CxuRdoCpqLAToAyj2ip7YEBaYyUumEKRJFa/Q3XDWRV2mG3fKalIb+THCeOrxjmwdE+K
         wsORNtsEdRohwuMLXxj8K54GE8+TprM/QDqSDyYz5ZQ0gjd12b1m8tigKzXL7dOxxjbl
         O9Tu+cYCeZsl6IXQVazCUwqYGR8/O1p3O/enxqXalSrYk74b3oERvKmdaWUfJ3O3T1Cc
         qsXpBwf229feYqMXVGRoP/xRWcC+Ia5//asBMFoYdn3N9Kl3KrKE+bzLW7WGdtgx0mRy
         LyWQ==
X-Gm-Message-State: AOAM531MHHqsq5JU/L2VoVlLNfbvdYy0NafqJV3DrcFnSRp2FjxdOR+F
        oW4mbYk1EMccLhwQV9LANZmjCHHOIIe3cP88I7A=
X-Google-Smtp-Source: ABdhPJyML1M/wSU4weQkHbgAQC9ptneKF82KsSJzpVsQQWhfvqo2M3tiSMcT7VAudVuKVQbcufB5LABLkNqdYYtNCRg=
X-Received: by 2002:a1c:f001:: with SMTP id a1mr7961185wmb.21.1612015081209;
 Sat, 30 Jan 2021 05:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20210127194047.21462-1-christianshewitt@gmail.com>
In-Reply-To: <20210127194047.21462-1-christianshewitt@gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sat, 30 Jan 2021 21:57:50 +0800
Message-ID: <CAKGbVbtaDHmukvfF=sfSmWHVdAYoF6-i4RTzsPQ6zfsjHcGNCw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/lima: add governor data with pre-defined thresholds
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gets minor improvement on glmark2 (160->162).

Seems there's no way for user to change this value, do we?
Or there's work pending to expose it to sysfs?

Regards,
Qiang

On Thu, Jan 28, 2021 at 3:40 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> This patch adapts the panfrost pre-defined thresholds change [0] to the
> lima driver to improve real-world performance. The upthreshold value has
> been set to ramp GPU frequency to max freq faster (compared to panfrost)
> to compensate for the lower overall performance of utgard devices.
>
> [0] https://patchwork.kernel.org/project/dri-devel/patch/20210121170445.19761-1-lukasz.luba@arm.com/
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
> Change since v1: increased upthreshold from 20 to 30, with a soft
> dependency on Lukasz delayed timer patch [0]
>
> [0] https://lore.kernel.org/lkml/20210127105121.20345-1-lukasz.luba@arm.com/
>
>  drivers/gpu/drm/lima/lima_devfreq.c | 10 +++++++++-
>  drivers/gpu/drm/lima/lima_devfreq.h |  2 ++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
> index 5686ad4aaf7c..c9854315a0b5 100644
> --- a/drivers/gpu/drm/lima/lima_devfreq.c
> +++ b/drivers/gpu/drm/lima/lima_devfreq.c
> @@ -163,8 +163,16 @@ int lima_devfreq_init(struct lima_device *ldev)
>         lima_devfreq_profile.initial_freq = cur_freq;
>         dev_pm_opp_put(opp);
>
> +       /*
> +        * Setup default thresholds for the simple_ondemand governor.
> +        * The values are chosen based on experiments.
> +        */
> +       ldevfreq->gov_data.upthreshold = 30;
> +       ldevfreq->gov_data.downdifferential = 5;
> +
>         devfreq = devm_devfreq_add_device(dev, &lima_devfreq_profile,
> -                                         DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
> +                                         DEVFREQ_GOV_SIMPLE_ONDEMAND,
> +                                         &ldevfreq->gov_data);
>         if (IS_ERR(devfreq)) {
>                 dev_err(dev, "Couldn't initialize GPU devfreq\n");
>                 ret = PTR_ERR(devfreq);
> diff --git a/drivers/gpu/drm/lima/lima_devfreq.h b/drivers/gpu/drm/lima/lima_devfreq.h
> index 2d9b3008ce77..b0c7c736e81a 100644
> --- a/drivers/gpu/drm/lima/lima_devfreq.h
> +++ b/drivers/gpu/drm/lima/lima_devfreq.h
> @@ -4,6 +4,7 @@
>  #ifndef __LIMA_DEVFREQ_H__
>  #define __LIMA_DEVFREQ_H__
>
> +#include <linux/devfreq.h>
>  #include <linux/spinlock.h>
>  #include <linux/ktime.h>
>
> @@ -18,6 +19,7 @@ struct lima_devfreq {
>         struct opp_table *clkname_opp_table;
>         struct opp_table *regulators_opp_table;
>         struct thermal_cooling_device *cooling;
> +       struct devfreq_simple_ondemand_data gov_data;
>
>         ktime_t busy_time;
>         ktime_t idle_time;
> --
> 2.17.1
>
