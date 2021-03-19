Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585ED34214E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCSPyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCSPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:53:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B91C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:53:44 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v186so3961246pgv.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9e3JvlVImVqovnPE5o8T2aAk9m+EOrR0HqRpW5NiBo=;
        b=vb+NnwFLp3brgZEgYGmuei6Z77uEhzOwdKxFI+PxtoSMuUA/vDs2i7dluCb9hOjL4h
         0v3wSe/bOKViqmXVjcUEa2swJl0MdWk5DSbq0BThoQBCZFVQk6Fc3ysvij/IXZO7/8Xh
         XyqMqzXdAz9Luuzov63lSHAiV5E+R+kScBU43CCh6ASys7aDZYSTtZhFej/wZWB/0v/I
         zvbJsOnZNwWkHffOX4TM8JhKC0T5LxGSc+wT+p5V4/ugsHzYy87E1DMOJer+/5t69bvb
         fPNHN48IU4hnBzjx9uf0hUDorQPe5ZE+8M7S4Vo/bx7YtksKQ2j9MhP7u2C9PEaJMlXE
         5/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9e3JvlVImVqovnPE5o8T2aAk9m+EOrR0HqRpW5NiBo=;
        b=kEvoWQZpCQU0nKOfL+8oTwJNgLlI9eDGdJg9wKdrxpNwXqWWTKdFLD9o5VAITMfAMk
         fANmJGldy67LKG9CMrmIL35Q6vRHBYjVeOrK85/8ohZySbGWnbZ/uYoi+3L3Y6wDqp0g
         ChUuepqARV/u5iWHci/QzSan04/OC6kjqiit4dFQ9ymxdFmMtMEBTwGShFlfmMA3Suw2
         FkGDZ2bS2ECw+lKy17iQ6bKEmjdx1gI/RGAkifhUsdzPCZyya+2knD+u6X63iWeazTcW
         hVr28entwg8UJ2Op4f5K169q3PWAFn2pyqyeLfbvI07DZjXNZtA8rtu89VhYnOmlwk6m
         sseA==
X-Gm-Message-State: AOAM531ueJmVtO1eZKOea9A+T8Zn+ReTric9brjsu5P0n/iPldNJlACQ
        CJrOZ0+e595MTAu+ZVCrCCQr9kHU2kLvMZGVx+VUxrK/my06AIY4
X-Google-Smtp-Source: ABdhPJzXZOjanMlGVi/fCuO0+YZk/KVHvw5XGQK/9qGjL7GsnwaNBiM1MEUhdEiOxgZeMQhrIwA8irhlhzKXdOaxFYw=
X-Received: by 2002:a05:6a00:b54:b029:207:2a04:7b05 with SMTP id
 p20-20020a056a000b54b02902072a047b05mr9864816pfo.12.1616169223661; Fri, 19
 Mar 2021 08:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210312085203.13556-1-jee.heng.sia@intel.com>
In-Reply-To: <20210312085203.13556-1-jee.heng.sia@intel.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 19 Mar 2021 16:53:32 +0100
Message-ID: <CAG3jFyuvTadeP-CLZ77k32vQvYVjrEakcXXr5U22Zgom=H34kg@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: adv7511: Support I2S IEC958 encoded PCM format
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

Thanks for the patch, it looks good to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 12 Mar 2021 at 10:09, Sia Jee Heng <jee.heng.sia@intel.com> wrote:
>
> Support IEC958 encoded PCM format for ADV7511 so that ADV7511 HDMI
> audio driver can accept the IEC958 data from the I2S input.
>
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
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
> base-commit: de066e116306baf3a6a62691ac63cfc0b1dabddb
> --
> 2.18.0
>
