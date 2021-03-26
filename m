Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812EF34A4B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCZJld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhCZJlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:41:22 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4D9C0613AA;
        Fri, 26 Mar 2021 02:40:58 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so4657942ote.6;
        Fri, 26 Mar 2021 02:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VtlzHKzBVeNqbjFIBZ7d1B3hwS0lt1PMIHi606exDHo=;
        b=rAsR1aUp0QcXulOslOe1WtWLDN9EeG6hCmfpHUFxGKem4z6CR9z3VFmtZEvIB+NETR
         9UGyzGGmeKOjO4JumNht9ZngNUa46q5vaRUtMvGDrfBtNtg/k3XDsAXndZJL/qJHsMrB
         AlkJrHLZMwlJ6Qcy3SZflem+0VPU9sys8U42I3rt6dDpuFd6hxq5Na+FHFl4VFyxIf47
         eu8o3kYaY3Jaxsmsy3v7AvjMj98Msl7kL0zRqijbbgQ335pxNUX50HdcagK8IedDMsic
         zThdBVAJrhgw12vne2mOFdiQSuzeEbCUonhUS8HRIDtQqF9NMW+GrtmRrPXNA1P8TG8S
         HPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VtlzHKzBVeNqbjFIBZ7d1B3hwS0lt1PMIHi606exDHo=;
        b=P6XjRMzJ6KF+7CgsBa+h32Doca/ZwiMu2tZSyzJn3xJcNAEVC0GxDcnVWWDHGuZ2wn
         f24XMj0iVqVnRpsYDFIBeUL4rVpkB3VWfwLb6DqSBHOM/paGbGaJowujoBHI8egtX1j5
         aHNP7VvyZF0b/S0awYuNE0lfMqUfCOSRY0nXQeJ/fPJ85oVwbtFRlRommdbu4LL4KvAa
         /XhAqJOzOtqQEg+PFE1bBcPJVgarStESB7jeNyeiMr7Yg4KzLW+aTfLMS1z9Rdlo6bRI
         ONqalZZRCn9Cen8vrf81+b0Yn60+yu/j9l1Xi5yMrGez76d2pA9wl8RbtnircdbRGWa+
         CXxA==
X-Gm-Message-State: AOAM530+Wp1rG5X4UWCZR7hbv7VIsdsx5tOLk2BBZ4N81sg3Rz+bsvR/
        G3rTeMKVvIUgZUwrDmjli7UbwmAuZSBTDvOXg3c=
X-Google-Smtp-Source: ABdhPJzfKOeCzNFxHmkTASVWR4jO+siUZM9pXCP7so2wGLQ9nBEETk2W1w2Z1yL3fP59vWHEcGt01AKLzYtb5QFKIVU=
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr11295028oto.281.1616751658347;
 Fri, 26 Mar 2021 02:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210326091547.12375-1-zhangqing@rock-chips.com> <20210326091547.12375-4-zhangqing@rock-chips.com>
In-Reply-To: <20210326091547.12375-4-zhangqing@rock-chips.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 26 Mar 2021 10:40:46 +0100
Message-ID: <CAFqH_503DyLAd5XUxdTiZrDbdTRFt=rjoQy5-bSH-4DiKrdd8w@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] arm: dts: rockchip: Fix power-controller node
 names for rk3288
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, cl@rock-chips.com,
        huangtao@rock-chips.com, kever.yang@rock-chips.com,
        tony.xie@rock-chips.com, finley.xiao@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missatge de Elaine Zhang <zhangqing@rock-chips.com> del dia dv., 26 de
mar=C3=A7 2021 a les 10:16:
>
> Use more generic names (as recommended in the device tree specification
> or the binding documentation)
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm/boot/dts/rk3288.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dts=
i
> index ea7416c31f9b..6f4d7929e351 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -769,7 +769,7 @@
>                          *      *_HDMI          HDMI
>                          *      *_MIPI_*        MIPI
>                          */
> -                       pd_vio@RK3288_PD_VIO {
> +                       power-domain@RK3288_PD_VIO {
>                                 reg =3D <RK3288_PD_VIO>;
>                                 clocks =3D <&cru ACLK_IEP>,
>                                          <&cru ACLK_ISP>,
> @@ -811,7 +811,7 @@
>                          * Note: The following 3 are HEVC(H.265) clocks,
>                          * and on the ACLK_HEVC_NIU (NOC).
>                          */
> -                       pd_hevc@RK3288_PD_HEVC {
> +                       power-domain@RK3288_PD_HEVC {
>                                 reg =3D <RK3288_PD_HEVC>;
>                                 clocks =3D <&cru ACLK_HEVC>,
>                                          <&cru SCLK_HEVC_CABAC>,
> @@ -825,7 +825,7 @@
>                          * (video endecoder & decoder) clocks that on the
>                          * ACLK_VCODEC_NIU and HCLK_VCODEC_NIU (NOC).
>                          */
> -                       pd_video@RK3288_PD_VIDEO {
> +                       power-domain@RK3288_PD_VIDEO {
>                                 reg =3D <RK3288_PD_VIDEO>;
>                                 clocks =3D <&cru ACLK_VCODEC>,
>                                          <&cru HCLK_VCODEC>;
> @@ -836,7 +836,7 @@
>                          * Note: ACLK_GPU is the GPU clock,
>                          * and on the ACLK_GPU_NIU (NOC).
>                          */
> -                       pd_gpu@RK3288_PD_GPU {
> +                       power-domain@RK3288_PD_GPU {
>                                 reg =3D <RK3288_PD_GPU>;
>                                 clocks =3D <&cru ACLK_GPU>;
>                                 pm_qos =3D <&qos_gpu_r>,
> --
> 2.17.1
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
