Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8AF43904D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhJYH2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhJYH2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:28:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913E9C061348
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 00:25:44 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c4so3407997plg.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 00:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wtx3qihrIhTOJ+C6AsnIjmV2Mxy5WU7CVLra4DLJMIU=;
        b=SjtwAcZ111/9GfjHA7ZkyHv2w773LM/YZHqqUS/bGrIrzMA+XIKivomnk9A1wVEk9M
         OSucbPplKmvWuBeB2Qh2CeGtfzF1Q7uJAWWTlrxt/4dzyBZolxsqKDBBCHRYHd2BjfDl
         mfaINnm753vYlTxhqIzckqhY6TkM0/FiGJ340/mQRjO1PO2SERl/hx/POMz+D8T5Xcm6
         dH21QkqVQCEDSBeaRWu/wetpD9A56Yo4UQs21ja+3DwmStrBXAer0r67B7lZdSrPZvxc
         jVH+Pfo6SS44ldzR0VYnZAmKcWdLJ95R2J34wvjWwxAtsJ6jNAAOAII/5U9Bs66glUeq
         fA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wtx3qihrIhTOJ+C6AsnIjmV2Mxy5WU7CVLra4DLJMIU=;
        b=1ZBY3MgkcVv+g1veu7ANzWVwT+NK0FCfUjWtgxJOfJTTpG+cpFmJDFWiXDDKHJa4h+
         xbszsv3J20XWKbs/3dBQQuDj3VVoZl6MT/SAQdKopDYZMjpxT2lFWM8FtuSxNO9mrB+0
         pkmaOJIsofiyuB1qeGZlbvNtD+9kymqrZWxi3v7ufHBNnQClTUsALyYV5THFEg4MO3kH
         cCUrgm/u8UsrYGbTHwDOhmIABuuHCgCzrvCvO1xgN4OUqSOpPOGnDOr6ZCGI35GB96jf
         mDz3hhSnV3GmMV2Ubjg3d0wwbecGVXPNd7Cq/G+Sedc6WuaCVS0zEdsRHCVmXdm90hpJ
         4Sow==
X-Gm-Message-State: AOAM53317U4cUuIF39ulSTuHEkjbG1V5vHN5du5lzKgnvTyVCS18Dsd/
        XzgZwlY/Ee+a5QOD5WXik7j4YU+0Ole555ctxs+S1Q==
X-Google-Smtp-Source: ABdhPJyKTKplfDDnV3PjRPtFdzkFW1EAzN1X/edHD63E9GVanr9o4eqaGuujOVjnID4qRvUvNDVSMhej5+PxstWoN3Y=
X-Received: by 2002:a17:902:c242:b0:140:4513:393 with SMTP id
 2-20020a170902c24200b0014045130393mr7540901plg.24.1635146743517; Mon, 25 Oct
 2021 00:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211025034420.28996-1-julianbraha@gmail.com>
In-Reply-To: <20211025034420.28996-1-julianbraha@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 25 Oct 2021 09:25:33 +0200
Message-ID: <CAG3jFys=NBFKvdMPtMe_VogEMoZYJFqB6NOuCQTe9=Upn+idGw@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: fix unmet dependency on DRM_KMS_HELPER for DRM_PANEL_BRIDGE
To:     Julian Braha <julianbraha@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julian,

Thank you for catching this.

On Mon, 25 Oct 2021 at 05:44, Julian Braha <julianbraha@gmail.com> wrote:
>
> When DRM_CHIPONE_ICN6211 is selected, and DRM_KMS_HELPER is not selected,
> Kbuild gives the following warning:
>
> WARNING: unmet direct dependencies detected for DRM_PANEL_BRIDGE
>   Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && DRM_KMS_HELPER [=n]
>   Selected by [y]:
>   - DRM_CHIPONE_ICN6211 [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_BRIDGE [=y] && OF [=y]
>
> This is because DRM_CHIPONE_ICN6211 selects DRM_PANEL_BRIDGE
> without depending on or selecting DRM_KMS_HELPER,
> despite DRM_PANEL_BRIDGE depending on DRM_KMS_HELPER.
>
> This unmet dependency bug was detected by Kismet,
> a static analysis tool for Kconfig.
> Please advise if this is not the appropriate solution.

Could you add a Fixes tag to this commit.

ce517f18944e - drm: bridge: Add Chipone ICN6211 MIPI-DSI to RGB bridge

With that, resubmit with my r-b.
Reviewed-by: Robert Foss <robert.foss@linaro.org>

>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 431b6e12a81f..a630cb8fd1c8 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -30,6 +30,7 @@ config DRM_CDNS_DSI
>  config DRM_CHIPONE_ICN6211
>         tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
>         depends on OF
> +  select DRM_KMS_HELPER
>         select DRM_MIPI_DSI
>         select DRM_PANEL_BRIDGE
>         help
> --
> 2.30.2
>
