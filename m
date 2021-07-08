Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933A63BF654
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 09:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhGHHh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 03:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhGHHh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 03:37:26 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27476C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 00:34:44 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id j65so605624oih.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 00:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=oAvMp+Ra1hGRaw0is8fIIs3Aux+5CC2LcgaoBBqSCPs=;
        b=bTXwCHKV7sHOm1Z7kkZ8GWVgoqOb4OtNM+ev5IT9t0vJ20NZSagGBxfaqD+XRlP+64
         4qBk2HriPIlZmnxv2kzGONNKYXGRxAupwfuAsb/AviXZ0w/jsNMyMTvO52BjsONPJc19
         Mm4bsNwHamNxyT8Mdku1KpQnSfFb/VhGEYGr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=oAvMp+Ra1hGRaw0is8fIIs3Aux+5CC2LcgaoBBqSCPs=;
        b=Fv8AZT76RtjifiAad9jaf+jfc9SAoWMtZ3WxhzxphtZZVajG0mpkcxdrEsVX8wXQpT
         eRCVn5jIMvOEIJ3XOygFrhzii18of8oNng/VezDHCa0zTTpfPgasXtNdTYTYytBA9km2
         /MblYJ6NewaXEYonDRsik/GW7e/jA153EeaDQriroTSYjnVBbwMi0jB21RHFZz0g/2b0
         xrQtFPeZVvP7AD5YqK8Uhh7+Qx9d7cbd6Hr4SEbvBz9VDOJAHadPLgFzXp6/PBkkN7ax
         D+4iX4DJWLwhW/AOTjGeQHt5TB3o79OmVBmHmuegcQg3xkclkzvp/sGdwAjTtb5JgzEV
         g+HA==
X-Gm-Message-State: AOAM531gYpPz2fCV30C1OUprz6MF5fzZ4vS/IAco/sslU3jS1r96sbPX
        YDDd3M+Ve/TQw60qQDgzz3n8w5EDOhcTw7lZ2xm34A==
X-Google-Smtp-Source: ABdhPJxwpT6g2vtdmGi//wdPVjt2NQptFRmwbqjDsqzx3VBRFaxDJ3FHoWrljvZiKGOo3CIhCFJPJQcaguvqdTp1bRY=
X-Received: by 2002:aca:d941:: with SMTP id q62mr2639352oig.166.1625729683241;
 Thu, 08 Jul 2021 00:34:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Jul 2021 07:34:42 +0000
MIME-Version: 1.0
In-Reply-To: <1625592020-22658-4-git-send-email-khsieh@codeaurora.org>
References: <1625592020-22658-1-git-send-email-khsieh@codeaurora.org> <1625592020-22658-4-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 8 Jul 2021 07:34:42 +0000
Message-ID: <CAE-0n53JxLuQZBUMLOuH_Bm7zQ7Vite2OhjTB_xO=s_KAGarXw@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/msm/dp: reset aux controller after
 dp_aux_cmd_fifo_tx() failed.
To:     Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-07-06 10:20:16)
> Aux hardware calibration sequence requires resetting the aux controller
> in order for the new setting to take effect. However resetting the AUX
> controller will also clear HPD interrupt status which may accidentally
> cause pending unplug interrupt to get lost. Therefore reset aux
> controller only when link is in connection state when dp_aux_cmd_fifo_tx()
> fail. This fixes Link Layer CTS cases 4.2.1.1 and 4.2.1.2.
>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_aux.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index 4a3293b..eb40d84 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -353,6 +353,9 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
>                         if (!(aux->retry_cnt % MAX_AUX_RETRIES))
>                                 dp_catalog_aux_update_cfg(aux->catalog);
>                 }
> +               /* reset aux if link is in connected state */
> +               if (dp_catalog_link_is_connected(aux->catalog))

How do we avoid resetting aux when hpd is unplugged and then plugged
back in during an aux transfer?

> +                       dp_catalog_aux_reset(aux->catalog);
>         } else {
>                 aux->retry_cnt = 0;
>                 switch (aux->aux_error_num) {
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
