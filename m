Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F64F34A4C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhCZJml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhCZJmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:42:21 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F981C0613AA;
        Fri, 26 Mar 2021 02:42:21 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso4624564ott.13;
        Fri, 26 Mar 2021 02:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ISnIxxZGPH2fmdCzXOS225MJa1eOPQxxHvjF0Ltvtzw=;
        b=cZ2+8TbfOQVPhZNbRGeM5Bfn0tcmSayXAhROI/+HzPy3MAGQvIcUH9gUB+cQ8iD+X9
         UStOeoPmq77LIqCxDe2oqdy4CMyZLr/A6cAEHl4xiyy/iNym11DR/rIWrcwTH0NAVYUC
         0pC0fVxP5KJLIy4Ia0aAFgtm5HQkFJYHnNPJbiqkl8wy7UuOXtfx6RIV+Dbt6+gI3kdR
         q1UPo6P9oEd4RiqAb52zAAnrwWk0tFf05VlxGWKh5DsKE4TakDp1ViL+Y0i88wq85LVQ
         DubPOXcBpEh7JCVY9LuD8o6aYQQHQoqTbT+Mh9qxvGxHyhZ1zQowR7VfQmQB8+O22cz6
         DCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ISnIxxZGPH2fmdCzXOS225MJa1eOPQxxHvjF0Ltvtzw=;
        b=nHJlUSC6fG/rV3i/PFiFgbxMAQLzd97i6XtUhcBd8PhOKtBqC9xezxBe+8CQOb3a03
         aJ0hR7O/dQJdQ9CoeTq6tEtXF0Rx6yLyzledOjurbO/ivvi6bhawyNmPPwsYmhtrijCl
         0JK96ITCcFpHz6wnchITALlY8hAXMU5MihAIRhjo3qijSB3LnNEDa+J5GHagYYWCcRi0
         kjzZQRLMPo9zOtYc6/XBwfrojGmdycgXRhFncBi+72qDUxhPEwsCPP4E+PGGWh05aDnV
         ACJ7d3ZOKODAeBWYolSK5L22uZTWOGFZsMM4Q2x0UvhCyQgEJFRqMkE8lWXNUh/R+69j
         VWGg==
X-Gm-Message-State: AOAM533ARgQo+d3jA9l55VzcPZDGyG6LNc6oLf5fIBn4er/fafS0UFux
        5xZe/Gk0jfRaGtZ7Cpds6bpzZoLtWxEuhTjc3S0=
X-Google-Smtp-Source: ABdhPJx/Z5l80IEc8JhwiDQ9bZ2JWj1MwThGz8CRMbrg0MVp0Tmm9jpUZxyrS6hPv3OM5jbQ1unZd473TMcDNNQKJcE=
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr11299971oto.281.1616751740814;
 Fri, 26 Mar 2021 02:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210326091547.12375-1-zhangqing@rock-chips.com> <20210326091726.12531-1-zhangqing@rock-chips.com>
In-Reply-To: <20210326091726.12531-1-zhangqing@rock-chips.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 26 Mar 2021 10:42:07 +0100
Message-ID: <CAFqH_51sGjbyVLoPxTRby50uvWinX=2TVX3hK8KB_t71F-RyjA@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] arm64: dts: rockchip: Fix power-controller node
 names for rk3399
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
mar=C3=A7 2021 a les 10:18:
>
> Use more generic names (as recommended in the device tree specification
> or the binding documentation)
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 40 ++++++++++++------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3399.dtsi
> index edbbf35fe19e..142f5593d48b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -971,26 +971,26 @@
>                         #size-cells =3D <0>;
>
>                         /* These power domains are grouped by VD_CENTER *=
/
> -                       pd_iep@RK3399_PD_IEP {
> +                       power-domain@RK3399_PD_IEP {
>                                 reg =3D <RK3399_PD_IEP>;
>                                 clocks =3D <&cru ACLK_IEP>,
>                                          <&cru HCLK_IEP>;
>                                 pm_qos =3D <&qos_iep>;
>                         };
> -                       pd_rga@RK3399_PD_RGA {
> +                       power-domain@RK3399_PD_RGA {
>                                 reg =3D <RK3399_PD_RGA>;
>                                 clocks =3D <&cru ACLK_RGA>,
>                                          <&cru HCLK_RGA>;
>                                 pm_qos =3D <&qos_rga_r>,
>                                          <&qos_rga_w>;
>                         };
> -                       pd_vcodec@RK3399_PD_VCODEC {
> +                       power-domain@RK3399_PD_VCODEC {
>                                 reg =3D <RK3399_PD_VCODEC>;
>                                 clocks =3D <&cru ACLK_VCODEC>,
>                                          <&cru HCLK_VCODEC>;
>                                 pm_qos =3D <&qos_video_m0>;
>                         };
> -                       pd_vdu@RK3399_PD_VDU {
> +                       power-domain@RK3399_PD_VDU {
>                                 reg =3D <RK3399_PD_VDU>;
>                                 clocks =3D <&cru ACLK_VDU>,
>                                          <&cru HCLK_VDU>;
> @@ -999,94 +999,94 @@
>                         };
>
>                         /* These power domains are grouped by VD_GPU */
> -                       pd_gpu@RK3399_PD_GPU {
> +                       power-domain@RK3399_PD_GPU {
>                                 reg =3D <RK3399_PD_GPU>;
>                                 clocks =3D <&cru ACLK_GPU>;
>                                 pm_qos =3D <&qos_gpu>;
>                         };
>
>                         /* These power domains are grouped by VD_LOGIC */
> -                       pd_edp@RK3399_PD_EDP {
> +                       power-domain@RK3399_PD_EDP {
>                                 reg =3D <RK3399_PD_EDP>;
>                                 clocks =3D <&cru PCLK_EDP_CTRL>;
>                         };
> -                       pd_emmc@RK3399_PD_EMMC {
> +                       power-domain@RK3399_PD_EMMC {
>                                 reg =3D <RK3399_PD_EMMC>;
>                                 clocks =3D <&cru ACLK_EMMC>;
>                                 pm_qos =3D <&qos_emmc>;
>                         };
> -                       pd_gmac@RK3399_PD_GMAC {
> +                       power-domain@RK3399_PD_GMAC {
>                                 reg =3D <RK3399_PD_GMAC>;
>                                 clocks =3D <&cru ACLK_GMAC>,
>                                          <&cru PCLK_GMAC>;
>                                 pm_qos =3D <&qos_gmac>;
>                         };
> -                       pd_sd@RK3399_PD_SD {
> +                       power-domain@RK3399_PD_SD {
>                                 reg =3D <RK3399_PD_SD>;
>                                 clocks =3D <&cru HCLK_SDMMC>,
>                                          <&cru SCLK_SDMMC>;
>                                 pm_qos =3D <&qos_sd>;
>                         };
> -                       pd_sdioaudio@RK3399_PD_SDIOAUDIO {
> +                       power-domain@RK3399_PD_SDIOAUDIO {
>                                 reg =3D <RK3399_PD_SDIOAUDIO>;
>                                 clocks =3D <&cru HCLK_SDIO>;
>                                 pm_qos =3D <&qos_sdioaudio>;
>                         };
> -                       pd_tcpc0@RK3399_PD_TCPD0 {
> +                       power-domain@RK3399_PD_TCPD0 {
>                                 reg =3D <RK3399_PD_TCPD0>;
>                                 clocks =3D <&cru SCLK_UPHY0_TCPDCORE>,
>                                          <&cru SCLK_UPHY0_TCPDPHY_REF>;
>                         };
> -                       pd_tcpc1@RK3399_PD_TCPD1 {
> +                       power-domain@RK3399_PD_TCPD1 {
>                                 reg =3D <RK3399_PD_TCPD1>;
>                                 clocks =3D <&cru SCLK_UPHY1_TCPDCORE>,
>                                          <&cru SCLK_UPHY1_TCPDPHY_REF>;
>                         };
> -                       pd_usb3@RK3399_PD_USB3 {
> +                       power-domain@RK3399_PD_USB3 {
>                                 reg =3D <RK3399_PD_USB3>;
>                                 clocks =3D <&cru ACLK_USB3>;
>                                 pm_qos =3D <&qos_usb_otg0>,
>                                          <&qos_usb_otg1>;
>                         };
> -                       pd_vio@RK3399_PD_VIO {
> +                       power-domain@RK3399_PD_VIO {
>                                 reg =3D <RK3399_PD_VIO>;
>                                 #address-cells =3D <1>;
>                                 #size-cells =3D <0>;
>
> -                               pd_hdcp@RK3399_PD_HDCP {
> +                               power-domain@RK3399_PD_HDCP {
>                                         reg =3D <RK3399_PD_HDCP>;
>                                         clocks =3D <&cru ACLK_HDCP>,
>                                                  <&cru HCLK_HDCP>,
>                                                  <&cru PCLK_HDCP>;
>                                         pm_qos =3D <&qos_hdcp>;
>                                 };
> -                               pd_isp0@RK3399_PD_ISP0 {
> +                               power-domain@RK3399_PD_ISP0 {
>                                         reg =3D <RK3399_PD_ISP0>;
>                                         clocks =3D <&cru ACLK_ISP0>,
>                                                  <&cru HCLK_ISP0>;
>                                         pm_qos =3D <&qos_isp0_m0>,
>                                                  <&qos_isp0_m1>;
>                                 };
> -                               pd_isp1@RK3399_PD_ISP1 {
> +                               power-domain@RK3399_PD_ISP1 {
>                                         reg =3D <RK3399_PD_ISP1>;
>                                         clocks =3D <&cru ACLK_ISP1>,
>                                                  <&cru HCLK_ISP1>;
>                                         pm_qos =3D <&qos_isp1_m0>,
>                                                  <&qos_isp1_m1>;
>                                 };
> -                               pd_vo@RK3399_PD_VO {
> +                               power-domain@RK3399_PD_VO {
>                                         reg =3D <RK3399_PD_VO>;
>                                         #address-cells =3D <1>;
>                                         #size-cells =3D <0>;
>
> -                                       pd_vopb@RK3399_PD_VOPB {
> +                                       power-domain@RK3399_PD_VOPB {
>                                                 reg =3D <RK3399_PD_VOPB>;
>                                                 clocks =3D <&cru ACLK_VOP=
0>,
>                                                          <&cru HCLK_VOP0>=
;
>                                                 pm_qos =3D <&qos_vop_big_=
r>,
>                                                          <&qos_vop_big_w>=
;
>                                         };
> -                                       pd_vopl@RK3399_PD_VOPL {
> +                                       power-domain@RK3399_PD_VOPL {
>                                                 reg =3D <RK3399_PD_VOPL>;
>                                                 clocks =3D <&cru ACLK_VOP=
1>,
>                                                          <&cru HCLK_VOP1>=
;
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
