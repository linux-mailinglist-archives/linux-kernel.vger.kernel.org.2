Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D58390759
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhEYRUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhEYRU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:20:27 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615B3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:18:57 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id w9so16398491qvi.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0/3xC3kqe2mkaFTrJiNvLz+tg/CIiWw7gj3Uibgai0=;
        b=DpjOp44+hv54UbamXcHi1Io81NdpsllsShqbdEANlnxV2HneW79ilmjfE9yTMA53Hu
         wolCkRzSYN1FXKlYvS/GsjlpUvZBXmD+npc04UzVZWEKkhpPMTylp+QQ8UWyRwfhXswA
         EjvbEyffn6nxJdiISSxLjelVb8nzUklNcRRlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0/3xC3kqe2mkaFTrJiNvLz+tg/CIiWw7gj3Uibgai0=;
        b=f7GOz5ZxSqHCo9h4f/L20woxua6bLBGWTpYXeMoEk9sUdGUlwGRMqfPvNMkdnL81n+
         rUtRwU+TY9m2lyatRl5F9kzxVAVex4M3qU0LC8WQl7FJeFXyeTIwxwNo1fxSuxjuKO/l
         y1hKMYleG1iMsCYwY3TFusW4YH8fcAft+gSO0o5tp+ZO1aYV8dLcrnG7qloQiDWIXKl/
         hkYvtBCj5nUT0zp8hu+r6RBEGHn1i68IGqHnPeQ0yQs2dUeenKpVqDDxFgk7Ls+/MF02
         TLAOr5fqupoU3LHPJJXipWwGk6o16bT2XX9ppwTAw+JeL5cjS0r/T8dGsO8LY/xjxHMU
         rS5A==
X-Gm-Message-State: AOAM531NfCHqyEyrJxdYdM5OTTdAeXk4CC3J0HpXCg3Ie9guTlof04lQ
        6psp/CyXsveIH69pF0pqVYUs+MhwT0tYGw==
X-Google-Smtp-Source: ABdhPJxBc9Moh56zRmwbEukxQiTcL3UgCk9aeCp/2B8ZPrk127HuLi8PPsvc11CQO98go3YePTMDUA==
X-Received: by 2002:ad4:4a01:: with SMTP id m1mr38307705qvz.6.1621963136445;
        Tue, 25 May 2021 10:18:56 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id c5sm5807622qtg.88.2021.05.25.10.18.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 10:18:55 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id z38so14494277ybh.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:18:55 -0700 (PDT)
X-Received: by 2002:a05:6902:1023:: with SMTP id x3mr42866654ybt.79.1621963134688;
 Tue, 25 May 2021 10:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <1621927831-29471-1-git-send-email-rajeevny@codeaurora.org> <1621927831-29471-3-git-send-email-rajeevny@codeaurora.org>
In-Reply-To: <1621927831-29471-3-git-send-email-rajeevny@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 May 2021 10:18:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WBLUqR1BqC_LO87s+4Cf5mEq=ODG_TDdm=YPYJvf7NyA@mail.gmail.com>
Message-ID: <CAD=FV=WBLUqR1BqC_LO87s+4Cf5mEq=ODG_TDdm=YPYJvf7NyA@mail.gmail.com>
Subject: Re: [v4 2/4] drm/panel-simple: Support for delays between GPIO & regulator
To:     Rajeev Nandan <rajeevny@codeaurora.org>
Cc:     y@qualcomm.com, dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@gmail.com>, Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>, mkrishn@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 25, 2021 at 12:31 AM Rajeev Nandan <rajeevny@codeaurora.org> wrote:
>
> Some panels datasheets may specify a delay between the enable GPIO and
> the regulator. Support this in panel-simple.
>
> Signed-off-by: Rajeev Nandan <rajeevny@codeaurora.org>
> ---
>
> Changes in v4:
> - New
>
>  drivers/gpu/drm/panel/panel-simple.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index f9e4e60..caed71b 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -134,6 +134,22 @@ struct panel_desc {
>                 unsigned int prepare_to_enable;
>
>                 /**
> +                * @delay.power_to_enable: Time for the power to enable the display on.
> +                *
> +                * The time (in milliseconds) that it takes for the panel to
> +                * turn the display on.

Maybe a slightly better description:

The time (in milliseconds) to wait after powering up the display
before asserting its enable pin.


> +                */
> +               unsigned int power_to_enable;
> +
> +               /**
> +                * @delay.disable_to_power_off: Time for the disable to power the display off.
> +                *
> +                * The time (in milliseconds) that it takes for the panel to
> +                * turn the display off.

Maybe a slightly better description:

The time (in milliseconds) to wait after disabling the display before
deasserting its enable pin.


> +                */
> +               unsigned int disable_to_power_off;
> +
> +               /**
>                  * @delay.enable: Time for the panel to display a valid frame.
>                  *
>                  * The time (in milliseconds) that it takes for the panel to
> @@ -367,6 +383,10 @@ static int panel_simple_suspend(struct device *dev)
>         struct panel_simple *p = dev_get_drvdata(dev);
>
>         gpiod_set_value_cansleep(p->enable_gpio, 0);
> +
> +       if (p->desc->delay.disable_to_power_off)
> +               msleep(p->desc->delay.disable_to_power_off);
> +

I wonder if it's worth a warning if
"p->desc->delay.disable_to_power_off" is non-zero and p->enable_gpio
is NULL? I guess in theory it'd also be nice to confirm that p->supply
wasn't a dummy regulator, but that's slightly harder.


>         regulator_disable(p->supply);
>         p->unprepared_time = ktime_get();
>
> @@ -427,6 +447,9 @@ static int panel_simple_prepare_once(struct panel_simple *p)
>                 return err;
>         }
>
> +       if (p->desc->delay.power_to_enable)
> +               msleep(p->desc->delay.power_to_enable);
> +

Similar to above: I wonder if it's worth a warning if
"p->desc->delay.power_to_enable" is non-zero and p->enable_gpio is
NULL?

-Doug
