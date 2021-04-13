Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18C335D5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245357AbhDMD2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245028AbhDMD2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:28:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2616C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:28:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c2so12961plz.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=5tAqdlQ65Xiy+ghk0KtAk1i63l3pg3LrUb/XYFsIE98=;
        b=Nfix/WkJaJUAKI5kzwmzy6o8D/QWeDAJW9sMJF9vWnsyFpc8m2qPM5EWSmJNQdir1S
         XN8xWkassirzbxD2RBEQoRrFuHo4mAz3CBSFijL8jhg5IrBQ5eF2KzC9jtgBBokqEmzk
         YrumnjWs5OcgFJ5XcS0JMgbFuzR1kCjtwpSTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=5tAqdlQ65Xiy+ghk0KtAk1i63l3pg3LrUb/XYFsIE98=;
        b=Up0jTng0ekRYjMN+JuOazXoB/baseBlBPIX5TpJGDeB0ZnDWXo2tkzQxHRKeU0W+JA
         J5iRMBONsz26psdYtWFV7WJytRO+/KQ925KPlpwOgIHAl12GcDHI+NtsnXdULn/3xXz7
         uZhP7AvKA134Xp902Af8GTcsvb7a4PY6AGFKCmlQrno5bYzWUkD0+WR6DM+AmWTyvbR5
         5+8aevGViwTXYMSbwKsRQOBjKzSHHDHNpsYkphh0pb4Uktrxe4xBuywIAg3HmQiMFjtj
         nBspPZCPjSn2PwKwemy61+YPNAVkMqKO6Jd8pNpAJtIfXsxcHUsKyQvUTGPgVx4E5CdE
         6yQw==
X-Gm-Message-State: AOAM531kntxRTL9OaE433zy072IWRqbf9KIDG2sPue19XITvzCYCDmmX
        d6bDBLs33IswZ7rIo3bV6crKnueu+CfHyA==
X-Google-Smtp-Source: ABdhPJwA98EjR7+OT0INNOhv3xQakqX0UmgvB9kA2eTAH8O7BGt3i6R1pqXCVGJZFOjEtvyKvmJNkQ==
X-Received: by 2002:a17:90b:b03:: with SMTP id bf3mr2544178pjb.223.1618284509395;
        Mon, 12 Apr 2021 20:28:29 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:1d18:a339:7993:e548])
        by smtp.gmail.com with ESMTPSA id ir3sm685864pjb.42.2021.04.12.20.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 20:28:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1618246971-28754-1-git-send-email-khsieh@codeaurora.org>
References: <1618246971-28754-1-git-send-email-khsieh@codeaurora.org>
Subject: Re: [PATCH 1/2] drm/msm/dp: check sink_count before update is_connected status
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Date:   Mon, 12 Apr 2021 20:28:26 -0700
Message-ID: <161828450691.3764895.11632559645161458427@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-04-12 10:02:51)
> At pm_resume check link sisnk_count before update is_connected status

s/sisnk_count/sink_count/

> base on HPD real time link status. Also print out error message only
> when either EV_CONNECT_PENDING_TIMEOUT or EV_DISCONNECT_PENDING_TIMEOUT
> happen.

Can you add "why"? I think the why is something like "link status is
different from display connected status in the case of something like an
Apple dongle where the type-c plug can be connected, and therefore the
link is connected, but no sink is connected until an HDMI cable is
plugged into the dongle". This still doesn't explain why it's important
to check at resume time though.

>=20
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Any Fixes tag?

>  drivers/gpu/drm/msm/dp/dp_display.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 5a39da6..4992a049 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -587,7 +587,7 @@ static int dp_connect_pending_timeout(struct dp_displ=
ay_private *dp, u32 data)
> =20
>         state =3D dp->hpd_state;
>         if (state =3D=3D ST_CONNECT_PENDING) {
> -               dp_display_enable(dp, 0);
> +               DRM_ERROR("EV_CONNECT_PENDING_TIMEOUT error\n");

Can we get rid of these messages?

>                 dp->hpd_state =3D ST_CONNECTED;
>         }
> =20
> @@ -670,7 +670,7 @@ static int dp_disconnect_pending_timeout(struct dp_di=
splay_private *dp, u32 data
> =20
>         state =3D  dp->hpd_state;
>         if (state =3D=3D ST_DISCONNECT_PENDING) {
> -               dp_display_disable(dp, 0);
> +               DRM_ERROR("EV_DISCONNECT_PENDING_TIMEOUT error\n");

And this one? If it happens it will just sit in the logs when probably
the user can't do anything about it. Timeouts are just a fact of life.

>                 dp->hpd_state =3D ST_DISCONNECTED;
>         }
> =20
> @@ -1272,7 +1272,7 @@ static int dp_pm_resume(struct device *dev)
> =20
>         status =3D dp_catalog_link_is_connected(dp->catalog);
> =20
> -       if (status)
> +       if (status && dp->link->sink_count)

Can we add a comment above this if? Otherwise it doesn't make much
sense why sink_count is important.

	/*
	 * Only consider the display as connected, and send a connected
	 * notification to userspace in
	 * dp_display_send_hpd_notification(), if there's actually a
	 * sink connected. Otherwise, the link could be up/connected or=20
	 * in the process of being established, but there isn't actually
	 * anything to display to on the other side yet.
	 */

>                 dp->dp_display.is_connected =3D true;
>         else
>                 dp->dp_display.is_connected =3D false;
