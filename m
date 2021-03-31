Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9070434FC6D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbhCaJQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbhCaJQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:16:09 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5190EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:16:09 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r193so19374153ior.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTMPs2SgYmJwp4UhdhuuT2INlWhxFLMPnLXPbu2mNao=;
        b=d+yAUQ1MQhncfG9xmpzYJoc7BbjeHST/9O/D4kawpu93JxeNCFWcO6IA1qIdjNN5tg
         PXtBrqjR4fpOi3U1ixkgBceAo3bf0yZHKz1XRXH2psHkcKh0t9nz0KstibxuQeXctg9f
         7cEnoB9UyGpWSEoLDgHgiZXfv64nhba9sAADM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTMPs2SgYmJwp4UhdhuuT2INlWhxFLMPnLXPbu2mNao=;
        b=Eqlor1fLPnfvwVMBiOK6cnKbv4e8zT/T9JMGmHYTwHZxUYeDe8qzYE4dOpaXexXi/e
         /xW2JsI/0j+MmJjw+LjMAbMjsOnMOj1Cvlkfusf0iWkwcEMv2vxo6DrnF6RYxWs6mj9R
         A+HdqSbFEl/8eAWWOEaOO1ySN4MDN5ZeSzNZj/7KZkS4Sj634RckloFWfyaeoc3rmChp
         lCua0GdeBNYrfF/leoEMBNdFVcYfQ7HponHilj3r1cX1KIntfgUryUkEpbGdrxHmASXh
         BRYmLgD9pXxD3R65o+I7XtlhYE94jdnJ/26emD3XS4GD1EGtIhs45Jn4GkVbbDGMIAL2
         gd2g==
X-Gm-Message-State: AOAM530fBNqrMzi0mEYclhtUp2N5FByLDWeflerHvpXU3yH7wZgIMERv
        5ICG2eXoUSFnR7PNXUNtYjZKCgt3Hhlxld2Bd0pZYg==
X-Google-Smtp-Source: ABdhPJyUcOCXlKhc8WLb+slH96RHwWHk8tbEKRlfVJXCa7ZxGet90BJLoDrbJaK9d11NA9fRzfijIMD0uLRQm+5uDRE=
X-Received: by 2002:a05:6638:238c:: with SMTP id q12mr2190200jat.114.1617182168349;
 Wed, 31 Mar 2021 02:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210331090659.4169966-1-enric.balletbo@collabora.com> <20210331090659.4169966-2-enric.balletbo@collabora.com>
In-Reply-To: <20210331090659.4169966-2-enric.balletbo@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 31 Mar 2021 17:15:42 +0800
Message-ID: <CAJMQK-ibWYhsEU3reUPjXZ5fRFzzircQfa35BjqZJ-vSn8ZJMQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] arm64: defconfig: Enable options to support
 panel display for Mediatek Chromebooks
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>, Nishanth Menon <nm@ti.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 5:07 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> There are some Mediatek based Chromebooks supported in the kernel. Enable the
> required config options to have the panel display working on both devices.
> This was tested on the ACER Chromebook R13 (MT8173) and the Lenovo
> Ideapad Duet (MT8183), but should also enable display support for similar
> devices.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

> This is only a resend rebased on top of mainline to fix some trivial
> conflicts.
>
>  arch/arm64/configs/defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7b4be3807b6d..f2dc42c9b932 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -686,6 +686,7 @@ CONFIG_DRM_MSM=m
>  CONFIG_DRM_TEGRA=m
>  CONFIG_DRM_PANEL_LVDS=m
>  CONFIG_DRM_PANEL_SIMPLE=m
> +CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
>  CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
>  CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
>  CONFIG_DRM_PANEL_SITRONIX_ST7703=m
> @@ -693,6 +694,7 @@ CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
>  CONFIG_DRM_DISPLAY_CONNECTOR=m
>  CONFIG_DRM_NWL_MIPI_DSI=m
>  CONFIG_DRM_LONTIUM_LT9611=m
> +CONFIG_DRM_PARADE_PS8640=m
>  CONFIG_DRM_SII902X=m
>  CONFIG_DRM_SIMPLE_BRIDGE=m
>  CONFIG_DRM_THINE_THC63LVD1024=m
> @@ -707,6 +709,8 @@ CONFIG_DRM_VC4=m
>  CONFIG_DRM_ETNAVIV=m
>  CONFIG_DRM_HISI_HIBMC=m
>  CONFIG_DRM_HISI_KIRIN=m
> +CONFIG_DRM_MEDIATEK=m
> +CONFIG_DRM_MEDIATEK_HDMI=m
>  CONFIG_DRM_MXSFB=m
>  CONFIG_DRM_MESON=m
>  CONFIG_DRM_PL111=m
> @@ -979,6 +983,7 @@ CONFIG_ROCKCHIP_IOMMU=y
>  CONFIG_TEGRA_IOMMU_SMMU=y
>  CONFIG_ARM_SMMU=y
>  CONFIG_ARM_SMMU_V3=y
> +CONFIG_MTK_IOMMU=y
>  CONFIG_QCOM_IOMMU=y
>  CONFIG_REMOTEPROC=y
>  CONFIG_QCOM_Q6V5_MSS=m
> @@ -1051,6 +1056,8 @@ CONFIG_PWM_BCM2835=m
>  CONFIG_PWM_CROS_EC=m
>  CONFIG_PWM_IMX27=m
>  CONFIG_PWM_MESON=m
> +CONFIG_PWM_MTK_DISP=m
> +CONFIG_PWM_MEDIATEK=m
>  CONFIG_PWM_RCAR=m
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_PWM_SAMSUNG=y
> @@ -1095,6 +1102,7 @@ CONFIG_QCOM_L3_PMU=y
>  CONFIG_NVMEM_IMX_OCOTP=y
>  CONFIG_NVMEM_IMX_OCOTP_SCU=y
>  CONFIG_QCOM_QFPROM=y
> +CONFIG_MTK_EFUSE=y
>  CONFIG_ROCKCHIP_EFUSE=y
>  CONFIG_NVMEM_SUNXI_SID=y
>  CONFIG_UNIPHIER_EFUSE=y
> --
> 2.30.2
>
