Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6167035FD18
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhDNVT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhDNVTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:19:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13819C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:19:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c2so3416555plz.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=LcOc4JlIYDboURYMkcvr8SNtAziTFL1D41weTgPLTsw=;
        b=VG6MIZyisv7JYepLL9z7oA0Y9Nxg8R0YWSjk8tfVBod5e4RAWtVwiL3M3guGCVha2K
         lCS920xReB/AV6By58fHqFsrJDW08Yq2FQrHo8U9M0TOx37djAijHQSeCqF4EHsLXaX+
         3KWc/Bx2DbJ5fWKiFHYzrvJyFB6nqjUrKOa8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=LcOc4JlIYDboURYMkcvr8SNtAziTFL1D41weTgPLTsw=;
        b=iaP0PckJzms95iU2itEFJGxFgzNnX7geReKaEBj8B3vBiPwONEB6MrUiCEW1qlrnj5
         HzZRrGNJnaOXwhFx3C+vDor4Y9dyK5M0204gWQ46PfANjqNrnxrZW0rzwvd2+GY5i6nT
         gATSUBGk4t3GXd7q5OuAmri2Dw1pWgfRyAcTGNaPmeJabDB0CtiC2rb3gLKw19iKKSxa
         5Cs86yV30ae80e/GS2qUZ/XtPO+0XckSXvioX36lK9mEhaBMlWdfYCvqmxZW1yhKxD/G
         VGW7wklhVsjurK4SG1uDKWoTN2sI4AUmjlHXsln6izbgL+e0gU14KxMF/IOpgRxAYW8J
         akHw==
X-Gm-Message-State: AOAM532kQA9f1KdiuQnDBuSuNgO1x2FzciotJpj0zdzgaOCfJqbEcRxb
        v1RDqQSV2J/1br/Q+S9fU4d7+g==
X-Google-Smtp-Source: ABdhPJxGCQP3KYUFO8ly/GrqLFZX3A5UWMJ3VX3pPVI5/QsxfJ55s9l4d5dNVg23uJhu+r5B26INSg==
X-Received: by 2002:a17:902:d911:b029:ea:cc53:5501 with SMTP id c17-20020a170902d911b02900eacc535501mr213198plz.21.1618435141650;
        Wed, 14 Apr 2021 14:19:01 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:753e:814e:f002:498a])
        by smtp.gmail.com with ESMTPSA id q18sm290934pfj.131.2021.04.14.14.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 14:19:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1618434154-28255-1-git-send-email-khsieh@codeaurora.org>
References: <1618434154-28255-1-git-send-email-khsieh@codeaurora.org>
Subject: Re: [PATCH v2 1/3] drm/msm/dp: check sink_count before update is_connected status
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Date:   Wed, 14 Apr 2021 14:18:59 -0700
Message-ID: <161843513989.46595.8623474483864386727@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-04-14 14:02:34)
> Link status is different from display connected status in the case
> of something like an Apple dongle where the type-c plug can be
> connected, and therefore the link is connected, but no sink is
> connected until an HDMI cable is plugged into the dongle.
> The sink_count of DPCD of dongle will increase to 1 once an HDMI
> cable is plugged into the dongle so that display connected status
> will become true. This checking also apply at pm_resume.
>=20
> Fixes: 94e58e2d06e3 ("drm/msm/dp: reset dp controller only at boot up and=
 pm_resume")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Tested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Can you please thread your emailed patches? I see them all as toplevel
messages in my inbox :(


>  drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 5a39da6..0ba71c7 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -586,10 +586,8 @@ static int dp_connect_pending_timeout(struct dp_disp=
lay_private *dp, u32 data)
>         mutex_lock(&dp->event_mutex);
> =20
>         state =3D dp->hpd_state;
> -       if (state =3D=3D ST_CONNECT_PENDING) {
> -               dp_display_enable(dp, 0);
> +       if (state =3D=3D ST_CONNECT_PENDING)
>                 dp->hpd_state =3D ST_CONNECTED;
> -       }
> =20
>         mutex_unlock(&dp->event_mutex);
> =20
> @@ -669,10 +667,8 @@ static int dp_disconnect_pending_timeout(struct dp_d=
isplay_private *dp, u32 data
>         mutex_lock(&dp->event_mutex);
> =20
>         state =3D  dp->hpd_state;
> -       if (state =3D=3D ST_DISCONNECT_PENDING) {
> -               dp_display_disable(dp, 0);
> +       if (state =3D=3D ST_DISCONNECT_PENDING)
>                 dp->hpd_state =3D ST_DISCONNECTED;
> -       }
> =20
>         mutex_unlock(&dp->event_mutex);
> =20
> @@ -1272,7 +1268,12 @@ static int dp_pm_resume(struct device *dev)
> =20
>         status =3D dp_catalog_link_is_connected(dp->catalog);
> =20
> -       if (status)
> +       /*
> +        * can not declared display is connected unless
> +        * HDMI cable is plugged in and sink_count of
> +        * dongle become 1
> +        */
> +       if (status && dp->link->sink_count)
>                 dp->dp_display.is_connected =3D true;
>         else
>                 dp->dp_display.is_connected =3D false;

With this patch applied things still go wrong for me sometimes. I can
connect the apple dongle and then disconnect the apple dongle, instead
of connect and disconnect the HDMI cable, and sometimes the external
display doesn't come on. I'm still investigating but just wanted to let
you know.
