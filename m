Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E82342003
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhCSOqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhCSOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:45:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3CCC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:45:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h20so3061395plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TDOGGWm21psnrXGlHEe6HvlgMdBE2hycDbnwOwrR0qU=;
        b=UlA8BUn9E5sUqHuUQiDVI3TjSNEzIgglN6StA4KCyVdX76E7TgzijdMXlwYNtcOU0U
         oK0YUt9NaUKh9OYWeJPjOkj4C5gutCsoHgMAvOd4Co8G5QdGHna9dHm7ddeuPGYGq/UU
         Si3mf/vcqt4SyjTxw+ErupnhAHbv7gJlYCmf1cF8qg82nbjZAt3Z/IIoFUghJvvgtcHU
         +FleiDUKLNV1+6e/kdi2/1LZ5WlwKchV5dNwMhB4LJ5WQEEREoixVpYSoLkG/fUbcn/z
         iqEMWMaGTVyjVI457AtXUukS3iu0mLK0n5p3e4aIfbfoRaFuJj8XAwJkM4jRv0vRhq69
         yzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDOGGWm21psnrXGlHEe6HvlgMdBE2hycDbnwOwrR0qU=;
        b=EjUfla4NfsJHwcna2VLdkbwPn4OiUwRlfQ94qdmBUGCdUOi2INTht0BpIjRE3p342b
         kfHjXzzTYYOtZnrbYWuDrz2bB24rPgAJCyOQc0IBr67KfIvQ/wiB+B8p3kvjijzaD0/F
         853n1pr2UwjhCG8cegY/Ten9BvcHltkizjtEwUO+rBl7O8zSAC08N680A1ODNCHpWxg1
         jHJq9Boudv/MX2x81eeyeZLWPMJDc9MJr/Yi+lTYZUl1k5B6SaV4NvHDcU/6P0HZn1kc
         aErGPLOFpYBKiu+JY0sr949p5ZwOLTGcNtk6bhjar6vvxrbq0b4BXjiuUXmYDgxAfra6
         zPww==
X-Gm-Message-State: AOAM533v7j19T/LY8CWdX1/xKvNdJ5g+m09lFQPOR5NpWd0kInk6+Vd2
        cHrr5JEGXCB4x9O9fcscHKBgApkSy8h7rmrKO7Hx8g==
X-Google-Smtp-Source: ABdhPJxweZfNiCPg9C7NrDu3mAB+yl61lfkYpCt6KNMgXUL5b8ziQQV9oK2kr7DsR12MgPe9uLa2ifDL7vrvhQ8WUh4=
X-Received: by 2002:a17:902:e752:b029:e6:822c:355c with SMTP id
 p18-20020a170902e752b02900e6822c355cmr14735796plf.69.1616165156604; Fri, 19
 Mar 2021 07:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com> <20210219215326.2227596-14-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-14-lyude@redhat.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 19 Mar 2021 15:45:45 +0100
Message-ID: <CAG3jFyuJ=_Ab_LXNANs7VQAkgB16KC47zmibK1fXUKGvrGNUEw@mail.gmail.com>
Subject: Re: [PATCH 13/30] drm/bridge/analogix/dp_core: Unregister DP AUX
 channel on error in analogix_dp_probe()
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joe Perches <joe@perches.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lyude,

Thanks for the patch, it looks good to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 19 Feb 2021 at 22:58, Lyude Paul <lyude@redhat.com> wrote:
>
> Just another drive-by fix I noticed while going through the tree to cleanup
> DP aux adapter registration - make sure we unregister the DP AUX dev if
> analogix_dp_probe() fails.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index aa1bb86293fd..f115233b1cb9 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1782,6 +1782,7 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
>
>  err_disable_pm_runtime:
>         pm_runtime_disable(dp->dev);
> +       drm_dp_aux_unregister(&dp->aux);
>
>         return ret;
>  }
> --
> 2.29.2
>
