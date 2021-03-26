Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D101F34A4B8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhCZJlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhCZJl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:41:28 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C775AC0613AA;
        Fri, 26 Mar 2021 02:41:28 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id p2-20020a4aa8420000b02901bc7a7148c4so1155616oom.11;
        Fri, 26 Mar 2021 02:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2y+lCH0Vs6pyPQeq2bGx9F/tNaWiQ7TVbCtQl3Cu+oM=;
        b=muBx9zICBCg6dm3W4RgszzK5iERFpCnGJm6lNtrBAfKmL7RFejhESwlS05sDSKK/Kw
         Dtamzlxewrw3cIFoEQrGHQPq8c6hY6icmufXuxZ/fN/OkX8Ei0WMG6aSJKNHix+KCuVQ
         Pnni61Ovh4jDsySszrPy3xNriEfuj+iqvMvK2Ry600tVN8RiamQdgidjlAQvwdrHsuRI
         lnSsvcwMAbouh7gNfAoIM7r3PNAbox9K9kEYAQfo8WbeUd7csF7VvUviTJPrj5Xryw9u
         V9BIdhLp4zqy7serZfXaPQah/RKbVJDECNLMEANTui/ttVDwZO0sVaxxcugUrzn4pgVt
         ZAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2y+lCH0Vs6pyPQeq2bGx9F/tNaWiQ7TVbCtQl3Cu+oM=;
        b=sJxfMfEWQOt37Xq6KBTqaPY3uKPFvqz5/CoTOy6qEFm5htn82hehgCzhECJLn+qs88
         e5hMNxTZqQ9F2eo7WBQK0CDEdlHXkdYIs4h5/wpZQpfUC4DWSZ9aEf7LpqPJ4pkM8oFh
         kDDTcn6vJe0CMj6MFEQMBiPkNJDq6NOv52Z4z1R2LgBLVmIqnbfyK9UCCl0CFrVx9o3u
         v95GqtcznhGrURGKZ/rjDYLm12Q+UuwNTy804sELT7J7p42Ae11PCrNuKopsU8OdS7uG
         S1flBdrZjEfQVbHd2bF5Xm9xEcdL8k+gs+ZRFFMkrnpOdMrww6OPZfbqcAyJLSTei4Qe
         dU8A==
X-Gm-Message-State: AOAM532EAImwWGIAl1yujZe/XR9q/0uumylmgJ7R2d4fwJB4RXwf9E0h
        AKyoLD6qqQyYwmS/mLVN7ehzN1J0dojJfSSkAVU=
X-Google-Smtp-Source: ABdhPJwquUJ1qtonkHAnnJwykvLpp6ObSIvVLd7Rm3IiefenhyBYSBoARcO70lQdHSF8v5anxB3Un178MZe50H68vG0=
X-Received: by 2002:a05:6820:255:: with SMTP id b21mr10695602ooe.0.1616751688136;
 Fri, 26 Mar 2021 02:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210326091547.12375-1-zhangqing@rock-chips.com> <20210326091547.12375-5-zhangqing@rock-chips.com>
In-Reply-To: <20210326091547.12375-5-zhangqing@rock-chips.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 26 Mar 2021 10:41:16 +0100
Message-ID: <CAFqH_51V6J0tJzpzszEHSOvXx-88XuCpGGHKeyq8vT1pFT924A@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] arm64: dts: rockchip: Fix power-controller node
 names for px30
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
mar=C3=A7 2021 a les 10:17:
>
> Use more generic names (as recommended in the device tree specification
> or the binding documentation)
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/rockchip/px30.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts=
/rockchip/px30.dtsi
> index c45b0cfcae09..fb3a863e0caf 100644
> --- a/arch/arm64/boot/dts/rockchip/px30.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
> @@ -247,20 +247,20 @@
>                         #size-cells =3D <0>;
>
>                         /* These power domains are grouped by VD_LOGIC */
> -                       pd_usb@PX30_PD_USB {
> +                       power-domain@PX30_PD_USB {
>                                 reg =3D <PX30_PD_USB>;
>                                 clocks =3D <&cru HCLK_HOST>,
>                                          <&cru HCLK_OTG>,
>                                          <&cru SCLK_OTG_ADP>;
>                                 pm_qos =3D <&qos_usb_host>, <&qos_usb_otg=
>;
>                         };
> -                       pd_sdcard@PX30_PD_SDCARD {
> +                       power-domain@PX30_PD_SDCARD {
>                                 reg =3D <PX30_PD_SDCARD>;
>                                 clocks =3D <&cru HCLK_SDMMC>,
>                                          <&cru SCLK_SDMMC>;
>                                 pm_qos =3D <&qos_sdmmc>;
>                         };
> -                       pd_gmac@PX30_PD_GMAC {
> +                       power-domain@PX30_PD_GMAC {
>                                 reg =3D <PX30_PD_GMAC>;
>                                 clocks =3D <&cru ACLK_GMAC>,
>                                          <&cru PCLK_GMAC>,
> @@ -268,7 +268,7 @@
>                                          <&cru SCLK_GMAC_RX_TX>;
>                                 pm_qos =3D <&qos_gmac>;
>                         };
> -                       pd_mmc_nand@PX30_PD_MMC_NAND {
> +                       power-domain@PX30_PD_MMC_NAND {
>                                 reg =3D <PX30_PD_MMC_NAND>;
>                                 clocks =3D  <&cru HCLK_NANDC>,
>                                           <&cru HCLK_EMMC>,
> @@ -281,14 +281,14 @@
>                                 pm_qos =3D <&qos_emmc>, <&qos_nand>,
>                                          <&qos_sdio>, <&qos_sfc>;
>                         };
> -                       pd_vpu@PX30_PD_VPU {
> +                       power-domain@PX30_PD_VPU {
>                                 reg =3D <PX30_PD_VPU>;
>                                 clocks =3D <&cru ACLK_VPU>,
>                                          <&cru HCLK_VPU>,
>                                          <&cru SCLK_CORE_VPU>;
>                                 pm_qos =3D <&qos_vpu>, <&qos_vpu_r128>;
>                         };
> -                       pd_vo@PX30_PD_VO {
> +                       power-domain@PX30_PD_VO {
>                                 reg =3D <PX30_PD_VO>;
>                                 clocks =3D <&cru ACLK_RGA>,
>                                          <&cru ACLK_VOPB>,
> @@ -304,7 +304,7 @@
>                                 pm_qos =3D <&qos_rga_rd>, <&qos_rga_wr>,
>                                          <&qos_vop_m0>, <&qos_vop_m1>;
>                         };
> -                       pd_vi@PX30_PD_VI {
> +                       power-domain@PX30_PD_VI {
>                                 reg =3D <PX30_PD_VI>;
>                                 clocks =3D <&cru ACLK_CIF>,
>                                          <&cru ACLK_ISP>,
> @@ -315,7 +315,7 @@
>                                          <&qos_isp_wr>, <&qos_isp_m1>,
>                                          <&qos_vip>;
>                         };
> -                       pd_gpu@PX30_PD_GPU {
> +                       power-domain@PX30_PD_GPU {
>                                 reg =3D <PX30_PD_GPU>;
>                                 clocks =3D <&cru SCLK_GPU>;
>                                 pm_qos =3D <&qos_gpu>;
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
