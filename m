Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8B730F2F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbhBDMMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbhBDMMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:12:38 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272D9C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:11:58 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id j12so1987800pfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Wshvps9uSwR4KrMERILO+uhM70XPunvXNSvQiLlduc=;
        b=U5tKttEe6xX2g1VC7QFy33Ij2koZAHLIbxXNcQk0Vq9+rpAPr0zbGR7tR7Ckz9nVJn
         FPlN1o7eSyTN9mohqKjo6Oc5rYcAHzzZAy2Ju6xVX40rYmSgr+ugUCKySdaozJ20fZ/B
         AHDUaixxzi/f0yuXABZD6cWj+PrkjMetFPPJqWR2OanzNgwehP2yEUks4ssBBfTcbJ1z
         sNqNlGMb0x6vv6tx0v6ICBBnucY90HY6/ii348RJe+DfSv3OWqepYiZT/DIV8C4salrZ
         Zqc7xVsVyaoKFUz3d0HCzOXIOa2VUFl4NRwi/QOmcpshHtk/dubCFjJh4R48l7MkucoH
         027A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Wshvps9uSwR4KrMERILO+uhM70XPunvXNSvQiLlduc=;
        b=RVi1qFg6Ta/clhdGto0XAsMXeObdJrLGaqDTWaiaQTS2hFg4pAQUQLw2mM0m9NLlLZ
         JbrDzlnu51tu8xQ7391MntgJstiFZhvj5eeoaDyDcc/l5UQK80SFhJgTiwVPxYALqCpy
         RDk6M3tMwoA3lMLabUVcM3rYQD1KeKXWLN0AX2B/uB389SDelDaeh2z+7Zl6FPY3XNYN
         8vnTx6AIya7UqzUOty8HT34dZ0NriZoAmRDIWH/MKTkLZ2WR5xL48h8+JTH9iEKbu6dc
         2brE3Vk90yNyzU+d1RQCOeM0wtaaDLUDO64htRobvodq1oYAX9JAUnv+I4UxVoZl6J9x
         Ygjg==
X-Gm-Message-State: AOAM531XyKrq4RYGfENqqeA7thbYQhtBv8mUPP74aiff9IHI97Fp34z4
        OSk4MPAYvDzg5m4DhKC4EALofEJf5TFPHUfMAK9INQ==
X-Google-Smtp-Source: ABdhPJw0UqbwzAWR67aHT0BoVn8ualOS7C4pld0U7grb54rGyX9abNSYQ5+Eq7hMBn4c1O10k4gDlDfveeeUyrNn1q0=
X-Received: by 2002:a63:f953:: with SMTP id q19mr8581621pgk.120.1612440717662;
 Thu, 04 Feb 2021 04:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20210202115707.14410-1-bernard@vivo.com>
In-Reply-To: <20210202115707.14410-1-bernard@vivo.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 4 Feb 2021 13:11:46 +0100
Message-ID: <CAG3jFyvfccea-5cDJ5QruTFSCobYogRQgUTTnn--6s2uFQX0NA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge/analogix: remove redundant when devm_kzalloc failed
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joe Perches <joe@perches.com>, dri-devel@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bernard,

Thanks for the patch.

With the below fixed, feel free to add my r-b.
Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Tue, 2 Feb 2021 at 13:09, Bernard Zhao <bernard@vivo.com> wrote:
>
> Line 1590 DRM_ERROR is redundant because devm_kzalloc() already
> prints an error.

The line number will not be so helpful for reading this commit message
in the future, so remove it and maybe just refer to DRM_ERROR being
removed.

>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index aa1bb86293fd..8f6258eb9960 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1586,10 +1586,8 @@ static int analogix_dp_create_bridge(struct drm_device *drm_dev,
>         int ret;
>
>         bridge = devm_kzalloc(drm_dev->dev, sizeof(*bridge), GFP_KERNEL);
> -       if (!bridge) {
> -               DRM_ERROR("failed to allocate for drm bridge\n");
> +       if (!bridge)
>                 return -ENOMEM;
> -       }
>
>         dp->bridge = bridge;
>
> --
> 2.29.0
>
