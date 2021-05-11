Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0AD37B051
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 22:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhEKUv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 16:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhEKUvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 16:51:53 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032B8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 13:50:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id i5so11873613pgm.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8D2YP0VWQtVIqmK8vpJ8Ty/EggLMSFB+zMrWQFuUve0=;
        b=oEdQSWyJw78yuxYX8C60AcmqlF3e3R3Ru0Qs4R2YeDmRItwsvEWL+pjcBe9fIlzFX2
         jCPnmH7+djm7C6Ksm/ka1aRITIV73yiQNFgLFVsokeqrbDoeOaIwQnhHDe1IcW+UzU84
         F49hZQybDLEef560Vtx8qrqfae4m+ly60tL3gkZRRfoDx9vHQeb54ff+1QvQJcvIGzP0
         TcZtlCtL5EzTkXRB0HK4iwdyGeO9bB6R6sYR73ekSigcslSS9bWd1W9/+AsN84t1re41
         YyDcDiiAOnB32yxdRviuRZc7GuxfAq8SwbNZI5neAQXn/HGoNkJMvfFWr2bJF6C46iea
         gP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8D2YP0VWQtVIqmK8vpJ8Ty/EggLMSFB+zMrWQFuUve0=;
        b=tLR3Vw+gUR1ScFoEknGsNiaq4WnJHCtDAXJr1CW2HSLQF/mgpGP70gzhE2+tPekt3f
         rdGg7F0E+J+AmJpB/oNms1GfVSXzyeT9nxaEY/kOADc5whZT4tG+fmmTviKLxIYJ3lgP
         Tfs1ivqY4BIXIxaSuHOvruPTJGNXOXQinP4GIGALikKzt8ETNPVl4eXDEIGggvLYuCGv
         GbW3WbC6i5FrqVGq/3/+fIJiJgGfN+u0+DGXqW2Fa8SUeWI1fAyA0i7pn3m1So713oA8
         Kx4qCE7D5kefSN872I2iKX96PdD6o38eqJ2ynVpBRXqBSykBnxP7/4HoWAYy3ZOLpWxL
         Shqw==
X-Gm-Message-State: AOAM531GqLFi63wjTVRM6JSJLjatqnYCnW5CD5/j7ExsI8ojDkXut3AT
        nwBvEDPag4r5ss39waVohN+K9Lixl8l49lixzD5Mzg==
X-Google-Smtp-Source: ABdhPJyiwRs7eXwx2v1c+NfO3xFR7LzHb4B2R9cp/VR4S5DCkfe/DReu5VpGCC7JlPVDEc2xg6k3WLePeD8w9ChSx5Q=
X-Received: by 2002:a63:4e01:: with SMTP id c1mr19206289pgb.265.1620766245583;
 Tue, 11 May 2021 13:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210511193601.2584324-1-adrien.grassein@gmail.com> <20210511193601.2584324-5-adrien.grassein@gmail.com>
In-Reply-To: <20210511193601.2584324-5-adrien.grassein@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 11 May 2021 22:50:34 +0200
Message-ID: <CAG3jFyt+t0+ep7_eaWmoEC-M31W62qE0qbtE_G9Sonor=SLrdg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64: defconfig: Enable LT8912B DRM bridge driver
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Adrien,

On Tue, 11 May 2021 at 21:36, Adrien Grassein <adrien.grassein@gmail.com> wrote:
>
> This driver is used by the Nitrogen8 SBC.
>
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 08c6f769df9a..45db77d1a657 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -701,6 +701,7 @@ CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
>  CONFIG_DRM_PANEL_SITRONIX_ST7703=m
>  CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
>  CONFIG_DRM_DISPLAY_CONNECTOR=m
> +CONFIG_DRM_LONTIUM_LT8912B=m
>  CONFIG_DRM_NWL_MIPI_DSI=m
>  CONFIG_DRM_LONTIUM_LT9611=m
>  CONFIG_DRM_PARADE_PS8640=m

Reviewed-by: Robert Foss <robert.foss@linaro.org>
