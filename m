Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DEE37251A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 06:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhEDEbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 00:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhEDEbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 00:31:40 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F3EC061574
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 21:30:45 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so7114611otf.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 21:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=uW8f+s6xq4qAcq3HteqNyRrQN93bF04v9vZ/QplP8pc=;
        b=n07xEkrQlpcNFHZtxrsbxZDJwL4UA2XXfU57czlJaBZdhz5dhG2P0aX3piaOhtfaYk
         mZxQDWRyM2Q0bBkDd/Sf5YcxIjE3igvPrYlfaQW0PbFon2KVErZwDxLzOcJX8R6hlWnp
         hvflSpdfnmEV0kTYIFbtFLVmseavbB/WvPUTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=uW8f+s6xq4qAcq3HteqNyRrQN93bF04v9vZ/QplP8pc=;
        b=pKYKpoRayZc2fTDB2I0CwbfBcVR5oOp+CwUDP5EYmlrNM7Dvl23wXh0ME8GSnOm5OC
         3yIzs2jo/mrqV37bFGatsE4VsEr+9eHAtDwIolmQOzpYZN+jGGAcq77ui/SdZmoXqyFB
         h1/T8G4aopHX9E0QyNl69fFsVEYBqfq66ZRdkbLAhkQB43reYZyDsrHVZKe3NheF1GJV
         ZnHlpA6ChQN5OsMmX8Dc1zvO0qYfv/f7jbodLVXAGDQGy2PVrC7FFVGhaWkwW2vMyHhl
         urC94FtWnxlBBXd5Oq/cHzlrRzc0KdBq48LieLlJYK9VNtev2TADubis/J6VR5YfFUj0
         L1hg==
X-Gm-Message-State: AOAM533FmHPM7bKx5Cujyxc9RgbIN/w4DnbiYbnm+kJBjJBjHjRZtbsZ
        5jEFXuHbQchuWv3bjHp3wVQjlkNkK7GQ1UL/grCAew==
X-Google-Smtp-Source: ABdhPJwq6mdnfPJ4VcbDYA3afNLoRfzA/g9YDHhjK7Sh6BJt5OqOsgrHpb7zBzgoWlk7yUMrL73oVH49hU1RgHE5DN0=
X-Received: by 2002:a9d:222a:: with SMTP id o39mr16982065ota.246.1620102644899;
 Mon, 03 May 2021 21:30:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 May 2021 21:30:44 -0700
MIME-Version: 1.0
In-Reply-To: <1619048258-8717-2-git-send-email-khsieh@codeaurora.org>
References: <1619048258-8717-1-git-send-email-khsieh@codeaurora.org> <1619048258-8717-2-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 3 May 2021 21:30:44 -0700
Message-ID: <CAE-0n53_CMed87hPgBFjN_dmRrPkfG3ZBjHCni2+2kxp_QfFpw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] drm/msm/dp: check sink_count before update
 is_connected status
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-04-21 16:37:35)
> Link status is different from display connected status in the case
> of something like an Apple dongle where the type-c plug can be
> connected, and therefore the link is connected, but no sink is
> connected until an HDMI cable is plugged into the dongle.
> The sink_count of DPCD of dongle will increase to 1 once an HDMI
> cable is plugged into the dongle so that display connected status
> will become true. This checking also apply at pm_resume.
>
> Changes in v4:
> -- none
>
> Fixes: 94e58e2d06e3 ("drm/msm/dp: reset dp controller only at boot up and pm_resume")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Tested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 5a39da6..0ba71c7 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -586,10 +586,8 @@ static int dp_connect_pending_timeout(struct dp_display_private *dp, u32 data)
>         mutex_lock(&dp->event_mutex);
>
>         state = dp->hpd_state;
> -       if (state == ST_CONNECT_PENDING) {
> -               dp_display_enable(dp, 0);
> +       if (state == ST_CONNECT_PENDING)
>                 dp->hpd_state = ST_CONNECTED;
> -       }

This part has been there since commit 8ede2ecc3e5e ("drm/msm/dp: Add DP
compliance tests on Snapdragon Chipsets") so we should add that tag here
too, like

Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on
Snapdragon Chipsets")

It would also be nice if this hunk was explained. It doesn't make sense
to me that a timeout would enable the display so maybe that can be
called out in the commit text about why we remove the call here.
