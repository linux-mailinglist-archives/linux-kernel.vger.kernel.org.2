Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEFC34FC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhCaJQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhCaJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:16:05 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA43C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:15:55 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k25so19398430iob.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zzwjjkojBahFkPk5yx+4KLV3mmMczPvY6jdqhG6LqMo=;
        b=O+szBsNMcfZXmAhipiZBpQSU0MGTPHP99mxMxJWTt39iw0+98klUogwZZm5UNSIL32
         Pw5jvXD0cjN0d3xWz/W94US6xRFW1LOOqDORgpCrEUiauRX7zP3/GUm65rXn5h0O/wwE
         slVPcu8ewUx4Kl47JEJFro8f0MoIaonhfcgmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzwjjkojBahFkPk5yx+4KLV3mmMczPvY6jdqhG6LqMo=;
        b=P4AhymT8nCxps1+LBnOjiFLm98pvdCp6TsfsaXXHzTRGDKfLoVFJkGaxxSvL9SRQCQ
         Ts3RN+vakINSr4CBhEFTVQDRJQ5BUwk5PBNfPwXQUQKGUS3DSYSjdzydfi6mKJ4Tp5Vx
         JpSk5oR+tJKndkrPgxFHuIdMTVrpOFJCIiLfQENoZ4Gy4uBmTSRqE0epHaEyfvb/SqCq
         cV2EWiaDy5ex92G44l2wXnIER7WbujdBF8v5InWsFF9q1p8fSh/K+7qxpJz59Ss6r707
         M1tjw5JnA0EDkFs6vH+aOB8b2tELkkUmx2b2fJzOOeSBriaQ5LbhGZGjbMx3aCVtxF4S
         X2Ww==
X-Gm-Message-State: AOAM530egl1WFM6hGSDADw6cXdRKRezXhMPrjWkN2iegI+Mffo+8ZrcA
        kGV3mXlIyQugla2TMQ7n3IFdWMZNbPXIfMLIVpGYDg==
X-Google-Smtp-Source: ABdhPJwjo7tM7F+sIstrfOpUM82LTDQwJZRYMDcMKJTuSLaawUPoVrxDRap9cWz8IYHdEvwwzMDU9O3aqODrAQMCt6o=
X-Received: by 2002:a05:6638:371e:: with SMTP id k30mr2137695jav.4.1617182154622;
 Wed, 31 Mar 2021 02:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210331090659.4169966-1-enric.balletbo@collabora.com>
In-Reply-To: <20210331090659.4169966-1-enric.balletbo@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 31 Mar 2021 17:15:28 +0800
Message-ID: <CAJMQK-jO=yfXDa4t1WzNVmyoQnaBkQP1t1G3HgThWCRAseWk3g@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] arm64: defconfig: Allow mt8173-based boards to
 boot from usb
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
> Enable the option necessary to boot mt8173-based boards to boot from
> usb devices, like its phy and the regulators needed to have proper
> support.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

> This is only a resend rebased on top of mainline to fix some trivial
> conflicts.
>
>  arch/arm64/configs/defconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d612f633b771..7b4be3807b6d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -448,6 +448,7 @@ CONFIG_I2C_GPIO=m
>  CONFIG_I2C_IMX=y
>  CONFIG_I2C_IMX_LPI2C=y
>  CONFIG_I2C_MESON=y
> +CONFIG_I2C_MT65XX=y
>  CONFIG_I2C_MV64XXX=y
>  CONFIG_I2C_OMAP=y
>  CONFIG_I2C_OWL=y
> @@ -594,6 +595,7 @@ CONFIG_MFD_EXYNOS_LPASS=m
>  CONFIG_MFD_HI6421_PMIC=y
>  CONFIG_MFD_HI655X_PMIC=y
>  CONFIG_MFD_MAX77620=y
> +CONFIG_MFD_MT6397=y
>  CONFIG_MFD_SPMI_PMIC=y
>  CONFIG_MFD_RK808=y
>  CONFIG_MFD_SEC_CORE=y
> @@ -611,6 +613,8 @@ CONFIG_REGULATOR_HI655X=y
>  CONFIG_REGULATOR_MAX77620=y
>  CONFIG_REGULATOR_MAX8973=y
>  CONFIG_REGULATOR_MP8859=y
> +CONFIG_REGULATOR_MT6358=y
> +CONFIG_REGULATOR_MT6397=y
>  CONFIG_REGULATOR_PCA9450=y
>  CONFIG_REGULATOR_PF8X00=y
>  CONFIG_REGULATOR_PFUZE100=y
> @@ -787,6 +791,7 @@ CONFIG_USB_RENESAS_USBHS_HCD=m
>  CONFIG_USB_RENESAS_USBHS=m
>  CONFIG_USB_ACM=m
>  CONFIG_USB_STORAGE=y
> +CONFIG_USB_MTU3=y
>  CONFIG_USB_MUSB_HDRC=y
>  CONFIG_USB_MUSB_SUNXI=y
>  CONFIG_USB_DWC3=y
> @@ -988,6 +993,7 @@ CONFIG_OWL_PM_DOMAINS=y
>  CONFIG_RASPBERRYPI_POWER=y
>  CONFIG_FSL_DPAA=y
>  CONFIG_FSL_MC_DPIO=y
> +CONFIG_MTK_PMIC_WRAP=y
>  CONFIG_QCOM_AOSS_QMP=y
>  CONFIG_QCOM_COMMAND_DB=y
>  CONFIG_QCOM_GENI_SE=y
> @@ -1064,6 +1070,7 @@ CONFIG_PHY_HI6220_USB=y
>  CONFIG_PHY_HISTB_COMBPHY=y
>  CONFIG_PHY_HISI_INNO_USB2=y
>  CONFIG_PHY_MVEBU_CP110_COMPHY=y
> +CONFIG_PHY_MTK_TPHY=y
>  CONFIG_PHY_QCOM_QMP=m
>  CONFIG_PHY_QCOM_QUSB2=m
>  CONFIG_PHY_QCOM_USB_HS=y
> --
> 2.30.2
>
