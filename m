Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0A53A8C49
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhFOXQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhFOXQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:16:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3ED36137D;
        Tue, 15 Jun 2021 23:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623798864;
        bh=fHZtWrarsnH1NG9vOVFLLDZo2mVyvlintqGnbzRbg2c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XOqBFcDOZZZELWHZLPOLVAolVXVdM+GUUCmbh5xM+eyINgiorFkmf5Fq4uEgkoGrk
         HWtEVtAKTUrKF4w8phabp6DHVkq4TtgwK81JUMv40Ndp+Ou7L4Qn7QiKU/Z/kzyyq6
         SqCym6Sgz1ogie48kGOeTd40wJW8tiu7HlNyGeKbgQn08vXcBe3LfXqrZWuaZuUBEp
         G3qlRtnRVlEXtWSxEtY5S51tGPGoiuA3vAnGSGBXUY5tR7B+r4SEOuFAil1SORoTxq
         geym+XmOjCgtShFxFCtIOwQoInOZyG4vi2GqY6SJpQf31+JAf13XB8yeVl34R5KNX0
         AFvwu9x+f6TZw==
Received: by mail-ej1-f43.google.com with SMTP id gt18so427480ejc.11;
        Tue, 15 Jun 2021 16:14:24 -0700 (PDT)
X-Gm-Message-State: AOAM530lZCaHLF+2a2ciCmJOtRyphKMCfT+u6VyPZ0fmjMTuWNRR8yhC
        aFuJAtKI9RZint55gXM1fD7jb5O+WxUtgt/xnw==
X-Google-Smtp-Source: ABdhPJw3/gDFI5x2HFueMq3B9VYK1sY3WMe+9Pcj94vrZkWqoggoPGqEb4VUSE4jvvly4f7LQT4RV7ETSQlA+GtPq1E=
X-Received: by 2002:a17:907:9620:: with SMTP id gb32mr1957537ejc.127.1623798863315;
 Tue, 15 Jun 2021 16:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210615173233.26682-1-tinghan.shen@mediatek.com> <20210615173233.26682-16-tinghan.shen@mediatek.com>
In-Reply-To: <20210615173233.26682-16-tinghan.shen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 16 Jun 2021 07:14:12 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9M7bpvYM1bmZjkari=3f1uxAjOzs_UFhv10JTR0X4orw@mail.gmail.com>
Message-ID: <CAAOTY_9M7bpvYM1bmZjkari=3f1uxAjOzs_UFhv10JTR0X4orw@mail.gmail.com>
Subject: Re: [PATCH 16/27] arm64: dts: mt8195: add display node
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
        Jason-JH Lin <jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tinghan:

Tinghan Shen <tinghan.shen@mediatek.com> =E6=96=BC 2021=E5=B9=B46=E6=9C=881=
6=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:37=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> From: Jason-JH Lin <jason-jh.lin@mediatek.com>
>
> add display node.
>
> Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 76 ++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8195.dtsi
> index 856b0e938009..f362288ad828 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1911,6 +1911,82 @@
>                         #clock-cells =3D <1>;
>                 };
>
> +               vdosys_config@1c01a000 {
> +                       compatible =3D "mediatek,mt8195-vdosys";

Where is the definition of this compatible?

> +                       reg =3D <0 0x1c01a000 0 0x1000>;
> +                       reg-names =3D "vdosys0_config";
> +                       iommus =3D <&iommu_vdo M4U_PORT_L0_DISP_RDMA0>;
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S0>;
> +               };
> +
> +               mutex: disp_mutex0@1c016000 {
> +                       compatible =3D "mediatek,mt8195-disp-mutex";

Ditto.

> +                       reg =3D <0 0x1c016000 0 0x1000>;
> +                       reg-names =3D "vdo0_mutex";
> +                       clocks =3D <&vdosys0 CLK_VDO0_DISP_MUTEX0>;
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S0>;
> +                       clock-names =3D "vdo0_mutex";
> +                       interrupts =3D <GIC_SPI 658 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +               };
> +
> +               ovl0: disp_ovl@1c000000 {
> +                       compatible =3D "mediatek,mt8195-disp-ovl";

Ditto.

> +                       reg =3D <0 0x1c000000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       clocks =3D <&vdosys0 CLK_VDO0_DISP_OVL0>;
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S0>;
> +                       iommus =3D <&iommu_vdo M4U_PORT_L0_DISP_OVL0_RDMA=
0>;
> +               };
> +
> +               rdma0: disp_rdma@1c002000 {
> +                       compatible =3D "mediatek,mt8195-disp-rdma";

Ditto.

> +                       reg =3D <0 0x1c002000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 638 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       clocks =3D <&vdosys0 CLK_VDO0_DISP_RDMA0>;
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S0>;
> +                       iommus =3D <&iommu_vdo M4U_PORT_L0_DISP_RDMA0>;
> +               };
> +
> +               color0: disp_color@1c003000 {
> +                       compatible =3D "mediatek,mt8195-disp-color";

Ditto.

> +                       reg =3D <0 0x1c003000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       clocks =3D <&vdosys0 CLK_VDO0_DISP_COLOR0>;
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S0>;
> +               };
> +
> +               ccorr0: disp_ccorr@1c004000 {
> +                       compatible =3D "mediatek,mt8195-disp-ccorr";

Ditto.

> +                       reg =3D <0 0x1c004000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       clocks =3D <&vdosys0 CLK_VDO0_DISP_CCORR0>;
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S0>;
> +               };
> +
> +               aal0: disp_aal@1c005000 {
> +                       compatible =3D "mediatek,mt8195-disp-aal";

Ditto.

> +                       reg =3D <0 0x1c005000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       clocks =3D <&vdosys0 CLK_VDO0_DISP_AAL0>;
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S0>;
> +               };
> +
> +               gamma0: disp_gamma@1c006000 {
> +                       compatible =3D "mediatek,mt8195-disp-gamma";

Ditto.

> +                       reg =3D <0 0x1c006000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       clocks =3D <&vdosys0 CLK_VDO0_DISP_GAMMA0>;
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S0>;
> +               };
> +
> +               dither0: disp_dither@1c007000 {
> +                       compatible =3D "mediatek,mt8195-disp-dither";

Ditto.

> +                       reg =3D <0 0x1c007000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       clocks =3D <&vdosys0 CLK_VDO0_DISP_DITHER0>;
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S0>;
> +               };
> +
>                 smi_common0: smi@1c01b000 {
>                         compatible =3D "mediatek,mt8195-smi-common";

Ditto.

Regards,
Chun-Kuang.

>                         mediatek,common-id =3D <0>;
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
