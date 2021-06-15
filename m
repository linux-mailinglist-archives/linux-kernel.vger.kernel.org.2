Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB4D3A8C86
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhFOXck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhFOXch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:32:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C0A961356;
        Tue, 15 Jun 2021 23:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623799832;
        bh=EhsENLIeeDjKwTAN8zz7rBUT0tnSjzg/HSQK5HpPxEw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eU2fOUQo43Ho6rhJgc0WFrfRqjp3ph7sH6Yth2MReQPshU0dxXLFDUMzoF7d4W/dF
         o4PCdLs8R5DD/cWn0oD+y2R+S3EXokKfwTMcL2N3YGaeJYMj0eGegjEUi5mAF9COgu
         +q0cPeeUaRsBunJeqBQcfeESYC+42eRQyCytoiGkD8gRVN+md69pzn1WblfX8o0MoP
         /wmV7rtkVL+wpoHZ0Psp7HEFGUGW7e4TMt9MHidQ4wiv5w1iCzkQ/q+qt0sdbOJgLT
         iLJ0uosB4LaAZv/CUqtgTx0p/ydf/Bkm/GXlGmTUBZQMZH4IqBPIJLq8Cil1GmKKyf
         jDZwerpPDGCnw==
Received: by mail-ed1-f47.google.com with SMTP id s15so126163edt.13;
        Tue, 15 Jun 2021 16:30:32 -0700 (PDT)
X-Gm-Message-State: AOAM533b87+si5Bu73Pdl1Lsx53EmMYegUz5rQkGms2eCYGVfAo+vmI7
        mB/Hmw4Px0o/ofs3y/Jv/TMffMXdi3a3tn53/g==
X-Google-Smtp-Source: ABdhPJytJV5zNcgsmxY08WCj69qHXAC6m3v5c40a+y+FwBpdmI8H+LqghQfdUkMNHXhWjJXAV5v9T29CSZriZ8UegwI=
X-Received: by 2002:aa7:db16:: with SMTP id t22mr666261eds.49.1623799830833;
 Tue, 15 Jun 2021 16:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210615173233.26682-1-tinghan.shen@mediatek.com> <20210615173233.26682-22-tinghan.shen@mediatek.com>
In-Reply-To: <20210615173233.26682-22-tinghan.shen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 16 Jun 2021 07:30:19 +0800
X-Gmail-Original-Message-ID: <CAAOTY__cE+wz3hjOobWNDNjie29NsDQiytP=mocbLJxuOF2+4Q@mail.gmail.com>
Message-ID: <CAAOTY__cE+wz3hjOobWNDNjie29NsDQiytP=mocbLJxuOF2+4Q@mail.gmail.com>
Subject: Re: [PATCH 22/27] arm64: dts: mt8195: add edp nodes
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>, wenst@google.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tinghan:

Tinghan Shen <tinghan.shen@mediatek.com> =E6=96=BC 2021=E5=B9=B46=E6=9C=881=
6=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:35=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> From: Jitao Shi <jitao.shi@mediatek.com>
>
> add edp nodes for mt8195
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 59 +++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8195.dtsi
> index 256818c4c0bf..d7d2c2a8f461 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -23,6 +23,8 @@
>
>         aliases {
>                 dpi1 =3D &disp_dpi1;
> +               dp-intf0 =3D &dp_intf0;
> +               dp-intf1 =3D &dp_intf1;
>         };
>
>         clocks {
> @@ -1155,6 +1157,29 @@
>                         status =3D "disabled";
>                 };
>
> +               disp_pwm0: disp_pwm0@1100e000 {
> +                       compatible =3D "mediatek,mt8183-disp-pwm";

You should use

compatible =3D "mediatek,mt8195-disp-pwm", "mediatek,mt8183-disp-pwm";

and add definition of "mediatek,mt8195-disp-pwm" in binding document.

> +                       reg =3D <0 0x1100e000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 203 IRQ_TYPE_LEVEL_LOW 0>=
;
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S0>;
> +                       #pwm-cells =3D <2>;
> +                       clocks =3D <&topckgen CLK_TOP_DISP_PWM0_SEL>,
> +                                       <&infracfg_ao CLK_INFRA_AO_DISP_P=
WM>;
> +                       clock-names =3D "main", "mm";
> +                       status =3D "disabled";
> +               };
> +
> +               disp_pwm1: disp_pwm1@1100f000 {
> +                       compatible =3D "mediatek,mt8183-disp-pwm";

Ditto.

> +                       reg =3D <0 0x1100f000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 793 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       #pwm-cells =3D <2>;
> +                       clocks =3D <&topckgen CLK_TOP_DISP_PWM1_SEL>,
> +                               <&infracfg_ao CLK_INFRA_AO_DISP_PWM1>;
> +                       clock-names =3D "main", "mm";
> +                       status =3D "disabled";
> +               };
> +
>                 spi1: spi@11010000 {
>                         compatible =3D "mediatek,mt8195-spi",
>                                      "mediatek,mt6765-spi";
> @@ -2397,6 +2422,30 @@
>                         status =3D "disabled";
>                 };
>
> +               dp_intf1: dp_intf1@1c113000 {
> +                       compatible =3D "mediatek,mt8195-dp-intf";

Where is the definition of this compatible?

> +                       reg =3D <0 0x1c113000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 513 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S1>;
> +                       clocks =3D <&vdosys1 CLK_VDO1_DP_INTF0_MM>,
> +                                <&vdosys1 CLK_VDO1_DPINTF>,
> +                                <&topckgen CLK_TOP_DP_SEL>,
> +                                <&topckgen CLK_TOP_TVDPLL2_D2>,
> +                                <&topckgen CLK_TOP_TVDPLL2_D4>,
> +                                <&topckgen CLK_TOP_TVDPLL2_D8>,
> +                                <&topckgen CLK_TOP_TVDPLL2_D16>,
> +                                <&topckgen CLK_TOP_TVDPLL2>;
> +                       clock-names =3D "hf_fmm_ck",
> +                                     "hf_fdp_ck",
> +                                     "MUX_DP",
> +                                     "TVDPLL_D2",
> +                                     "TVDPLL_D4",
> +                                     "TVDPLL_D8",
> +                                     "TVDPLL_D16",
> +                                     "DPI_CK";
> +                       status =3D "disabled";
> +               };
> +
>                 hdmi0: hdmi@1c300000 {
>                         compatible =3D "mediatek,mt8195-hdmi";
>                         reg =3D <0 0x1c300000 0 0x1000>;
> @@ -2421,11 +2470,19 @@
>
>                 edp_tx: edp_tx@1c500000 {
>                         status =3D "disabled";
> -                       compatible =3D "mediatek,mt8195-dp_tx";
> +                       compatible =3D "mediatek,mt8195-edp_tx";
>                         reg =3D <0 0x1c500000 0 0x8000>;
>                         power-domains =3D <&spm MT8195_POWER_DOMAIN_EPD_T=
X>;
>                         interrupts =3D <GIC_SPI 676 IRQ_TYPE_LEVEL_HIGH 0=
>;
>                 };
> +
> +               dp_tx: dp_tx@1c600000 {
> +                       compatible =3D "mediatek,mt8195-dp_tx";

Ditto.

Regards,
Chun-Kuang.

> +                       reg =3D <0 0x1c600000 0 0x8000>;
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_DP_TX=
>;
> +                       interrupts =3D <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       status =3D "disabled";
> +               };
>         };
>
>         hdmiddc0: ddc_i2c {
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
