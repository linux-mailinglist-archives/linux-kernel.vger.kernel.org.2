Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F54C3D685F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 23:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhGZUVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 16:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhGZUVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:21:30 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376B7C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:01:58 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t14so12589598oiw.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=qmP+nvFdiGyxe0rj0aQYB75xMol5kzYi2IuKWY30b+E=;
        b=HcCfoB6PsDvFiCdKkUBvoH+mjMQf2ALTf9fhKLE/VjZ40hTKVuYuqbLnGBDUxHfxAT
         RHM5WJnd2hxeq1PTA0sGFMwF/UaO8yBbNY4WMZ7M4XFoki+iBfoUq6vM1TyoEawMx/bW
         eI0cTwTUN6xfERJ60Y4fIMo5CzpKfr9eewgqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=qmP+nvFdiGyxe0rj0aQYB75xMol5kzYi2IuKWY30b+E=;
        b=RL9biz+XizrxpDjMEKS94YJqQH26D9PyZ26RnX03vNBWVUal2y4vqE38fwcYFlRpOg
         wkwt/nFOYzwWM/MpnqKf1xMAJeDJUnU4HXnFCdUBpvmpV6AN+OIVTH9K9VtmsuQb2EF6
         XJaGkGGJcsnzVu/VWmpsgPrnBUTT8sg9gLRUtAb1LrN+c0q4BlPgN4oUIpLgF1JSyqpx
         hK9QwHCclVBGAYVUU6rjtE37WO/dxD748rGjN0M2gncZ583quqf0LyCVQDzMnZORMdGW
         sz2gWNGlm96esFnNsYAu4Sd3btNlaOjkhgTlPD82kThMYvZTyb2rwbAJIA5OXkxZzMLn
         6U4w==
X-Gm-Message-State: AOAM5304XTN/CUr3t716OWiAPZOsHE7lJH1EjUX9Fb5Paob+0yy6eo5z
        eaxT7avKcLYJyDn6YxgQR7dndXdZrZZwU07mCRgAjg==
X-Google-Smtp-Source: ABdhPJy+zOV5H5QT2ONLq6/MZa4bLjvvPnTfl/f+51Qfcb8grTupNAQqi5h8GLKoIRhK4zyX3pBhEOFnFHlKvFHlnMU=
X-Received: by 2002:aca:afd7:: with SMTP id y206mr139164oie.1.1627333317558;
 Mon, 26 Jul 2021 14:01:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Jul 2021 17:01:57 -0400
MIME-Version: 1.0
In-Reply-To: <1627059339-12142-1-git-send-email-khsieh@codeaurora.org>
References: <1627059339-12142-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 26 Jul 2021 17:01:57 -0400
Message-ID: <CAE-0n51HF8E7x71Ru4EXoyYePoBNcrngwUE6H7b=tpgXuHdxHQ@mail.gmail.com>
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

Can this be dp_display instead of g_dp_display?

> +                               dp->dp_display.is_connected);
> +
> +
>         mutex_unlock(&dp->event_mutex);
>
>         return 0;
