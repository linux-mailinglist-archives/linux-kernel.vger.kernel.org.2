Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8473D697B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 00:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhGZVpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 17:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbhGZVpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 17:45:49 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59738C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 15:26:16 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 21so12792713oin.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=xSput0mTBokah6l9L7iDEvqfAkDOlqRBcOYWvnWkg8w=;
        b=LfwtnFUQXnxD511/yo8ZxT7kqVeQ5iq8HSIl5m20gkTW6T0Qkdl6/YKYSfh6Wg+jJ6
         BVHEyEqVeaKC3wAxxgnAvLe5smnz+HzTy3YReyXEx5tFaLqXnSBKEfdVNnXdD8cqo04P
         CRJIj4l0Hvrlxs+2DmNC+Wff1vR7xeJGqcAA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=xSput0mTBokah6l9L7iDEvqfAkDOlqRBcOYWvnWkg8w=;
        b=ZvAMi/UwzBX/epNddenv9q1B9CcIhsaLsam2L4wxvQkNpiczdyMCvz4fs2HIxLl09m
         hKafcCYKz8dREF2E6PdN8UNLV22DbJ4XP7C5EGFCfZ5DDM11xrcMO3mNTKsmbGoLNJ+3
         KC5OQGA5dnQCr7BK5jJAJiFoxtexe2KgsIAKGPfO/OfnRDaLWh2UNpW2VMv51giR6DE+
         RijZ/CH2k+VH1dRX3GRacUqO/fLLCaCToig7AQVb93Tfw8AsjUpUf3igWcyx3R/sHSdm
         Cl48nkkQSeeiO0u5fdWsSvSpZccOPaE2S/pJH4nHk1cXnoon/Ho/4lx1QbM0PqHi2N9u
         reGQ==
X-Gm-Message-State: AOAM531HWGtRRjrhpVOv6cIO75kdOflG7wrtr5RZPHTABoJcW0NsdLkJ
        fk9WV1DpAEcm/uhoWTho+qGzE2wL7TNwwsvJB5y4Lg==
X-Google-Smtp-Source: ABdhPJxAPKNqUePhUnMW58bIZi6hbUqGSsjTwese7bc2NMQxiVuWSTHpmEV0RaR2jSgi+QJ8pzhBS+gPZyxSMbVyqtk=
X-Received: by 2002:aca:4dc6:: with SMTP id a189mr917454oib.166.1627338375634;
 Mon, 26 Jul 2021 15:26:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Jul 2021 18:26:15 -0400
MIME-Version: 1.0
In-Reply-To: <1627059339-12142-1-git-send-email-khsieh@codeaurora.org>
References: <1627059339-12142-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 26 Jul 2021 18:26:15 -0400
Message-ID: <CAE-0n50TV8j24x02VqVd0c6+zEr5Q++GN5xq_urQW3PiJ16QHQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: signal audio plugged change at dp_pm_resume
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-07-23 09:55:39)
> There is a scenario that dp cable is unplugged from DUT during system
> suspended  will cause audio option state does not match real connection
> state. Fix this problem by Signaling audio plugged change with realtime
> connection status at dp_pm_resume() so that audio option will be in
> correct state after system resumed.
>
> Changes in V2:
> -- correct Fixes tag commit id.
>
> Fixes: f591dbb5fb8c ("drm/msm/dp: power off DP phy at suspend")
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 4 ++++
>  1 file changed, 4 insertions(+)

I noticed that with or without this patch I still have a problem with an
apple dongle where if I leave the dongle connected but unplug the HDMI
cable during suspend the audio device is still there when I resume. The
display looks to be connected in that case too, according to modetest. I
don't know if you want to roll that into this patch or make another
follow-up patch to fix it, but it seems like the sink count isn't
updated on resume? Did commit f591dbb5fb8c break a bunch of logic in
here because now the link is powered down properly and so sink_count
isn't updated properly?

>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 78c5301..2b660e9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1339,6 +1339,10 @@ static int dp_pm_resume(struct device *dev)
>         else
>                 dp->dp_display.is_connected = false;
>
> +       dp_display_handle_plugged_change(g_dp_display,
> +                               dp->dp_display.is_connected);
> +
> +

There's also a double newline here that we should probably remove.

>         mutex_unlock(&dp->event_mutex);
>
>         return 0;
