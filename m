Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAC3368EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbhDWIeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhDWIeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:34:22 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2DCC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:33:44 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id p2so19268144pgh.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPP0dRgPfG6zQIMdWqCkBDehDsZiZdXDI5NgAH85Nqs=;
        b=HY8/qndk5bgQgsED9BAcRMLKI1nSjL/D2dc++lw6cLUyVE1vKQtQOKJSkqjyYpLMen
         HrJtLLy0P7ogIZqdchvzc60HOuBnRLdcRSaVAi3IYqAknoW+/pK/djaYEOYzXJ0ps9Aw
         kDHC0LF/mPnyKVV8U6bFij0c51UMXFsii8RYoNwWJp60eYPTBElwO1aBcpBb3j+NmxbV
         QU9WenoLZVQRotjTLFjdQWh+iUj+aolJxPfnmrmAqVpZVB5u3BqYzUH8boj/OXBACw53
         We+9M+KwDIrL7yv5tevpprwfCJpqVFQYmrFc/6Sr8GCUfglT6LFoqPRLPYDs7lmmyz/t
         29qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPP0dRgPfG6zQIMdWqCkBDehDsZiZdXDI5NgAH85Nqs=;
        b=oBJbJ+DBy7NfH1A0CL5YcoDyAamKIgBM7Am4uPgBIYLgc1/zO7EXbIXhEsYx2UKoyY
         LTquL6vY4qMARVLywJGxUCCbQwHs/O3MceWkEN6HRR6QA82fUBKBssjbbWaMoXkF2EfC
         29qZs7og3GV2OKZMN/hfbeOlFzF0TZP4+n92hco8yhT7wGXbSQO9mozhDuJ87BRQrwV0
         loO7QcFnJGfAbeTICuzYU1h1C1V4AsVqJv9DNNWHGOOcBuaI/sP15QATRG9c7hNGsMAT
         kgvII+EzRhH/sQqQq64+69gJ7ThqiNCzSXD8jkBg+M7Q0SLn5VIAWm7xd4cnvPu2xzG/
         e1WA==
X-Gm-Message-State: AOAM530mroGMCszmGAhQTeI1QamQn7wP/RilQ/idFLst4+Y0+1huzSL3
        WnCem6auFKfwCTQ4pFXno1gdPoZWWfgDNxsVChoguw==
X-Google-Smtp-Source: ABdhPJxaiiAj0rO1om5p99kZATGkc+WzZV3B+EC/6dlnMwASzl0N+Q58LGX5yoSnQ9BHBz01nxUJrsgmNj19R4p1Ao8=
X-Received: by 2002:a63:91c9:: with SMTP id l192mr2724655pge.339.1619166823869;
 Fri, 23 Apr 2021 01:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210422064015.15285-1-jee.heng.sia@intel.com>
In-Reply-To: <20210422064015.15285-1-jee.heng.sia@intel.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 23 Apr 2021 10:33:32 +0200
Message-ID: <CAG3jFysq1w9Di1YAQMS7v37Wdog1TCBYHfycRyF1Rr67U0HjyA@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm: bridge: adv7511: Support I2S IEC958 encoded
 PCM format
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Andrzej Hajda <a.hajda@samsung.com>,
        pierre-louis.bossart@linux.intel.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sia,

Thanks for the reminder!

I've merged this patch to drm-misc-next.

https://cgit.freedesktop.org/drm/drm-misc/log/

On Thu, 22 Apr 2021 at 08:57, Sia Jee Heng <jee.heng.sia@intel.com> wrote:
>
> Support IEC958 encoded PCM format for ADV7511 so that ADV7511 HDMI
> audio driver can accept the IEC958 data from the I2S input.
>
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511.h       | 1 +
>  drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 6 ++++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> index a9bb734366ae..05e3abb5a0c9 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> @@ -191,6 +191,7 @@
>  #define ADV7511_I2S_FORMAT_I2S                 0
>  #define ADV7511_I2S_FORMAT_RIGHT_J             1
>  #define ADV7511_I2S_FORMAT_LEFT_J              2
> +#define ADV7511_I2S_IEC958_DIRECT              3
>
>  #define ADV7511_PACKET(p, x)       ((p) * 0x20 + (x))
>  #define ADV7511_PACKET_SDP(x)      ADV7511_PACKET(0, x)
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> index 45838bd08d37..61f4a38e7d2b 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> @@ -101,6 +101,10 @@ static int adv7511_hdmi_hw_params(struct device *dev, void *data,
>         case 20:
>                 len = ADV7511_I2S_SAMPLE_LEN_20;
>                 break;
> +       case 32:
> +               if (fmt->bit_fmt != SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE)
> +                       return -EINVAL;
> +               fallthrough;
>         case 24:
>                 len = ADV7511_I2S_SAMPLE_LEN_24;
>                 break;
> @@ -112,6 +116,8 @@ static int adv7511_hdmi_hw_params(struct device *dev, void *data,
>         case HDMI_I2S:
>                 audio_source = ADV7511_AUDIO_SOURCE_I2S;
>                 i2s_format = ADV7511_I2S_FORMAT_I2S;
> +               if (fmt->bit_fmt == SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE)
> +                       i2s_format = ADV7511_I2S_IEC958_DIRECT;
>                 break;
>         case HDMI_RIGHT_J:
>                 audio_source = ADV7511_AUDIO_SOURCE_I2S;
>
> base-commit: e488b1023a4a4eab15b905871cf8e81f00336ed7
> --
> 2.18.0
>
