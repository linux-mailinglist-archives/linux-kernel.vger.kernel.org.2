Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097D13A8C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhFOXZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231463AbhFOXZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:25:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74ABA6137D;
        Tue, 15 Jun 2021 23:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623799407;
        bh=8KaQxhUKyVIdleVI/MbJP9taXr9qf9QVrVaGV1lkISU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rQPJyyATzcYV/t8Ib0KRkwaOAtw1rbUTcyV1R52Fp0+Ubce5kGEgLD0ZnUwzcfhLL
         DFnDygfcraHYjsc/VY4RLg0/4wKzNdypPXdY7K2LxM42ZwrIHxU4Evdxh8QoLNGs1B
         olurORMqeSKk+BkufGX72W4ZMmubC257MazV/9ZF2UCCYAVXAn9JBQzT9RugcUjvwi
         tlY2y33xgzMZ6+He8vf4zisYnyd+XeTBrZZSajKOYfDI09N01+n2u/0W+2FWl6fHTR
         JIfiT9oX+EQtkWzaAQNZ/5IFFUqjc8xo5h+zA5MCFcqK/xVyzKMTKzwIKrCqa1c5Ax
         y5LMi6r7mUEJQ==
Received: by mail-ej1-f46.google.com with SMTP id l1so498881ejb.6;
        Tue, 15 Jun 2021 16:23:27 -0700 (PDT)
X-Gm-Message-State: AOAM531FfVB0RYum+h9h40rNgaQ8EDOf6Zym15//CkKUYI4cQRx7GB3s
        SRpdgT80T6DuoFDWUfc575wCQf4l+T0CpwOW/Q==
X-Google-Smtp-Source: ABdhPJwCY8zt1AkuPa9thT9oKOQeINHPR57mvEy+hPqwsX6YRXRQMX/bxwMAQRP2+p5YaAGP46x1JpBNjPLpL/v8Eb4=
X-Received: by 2002:a17:907:9620:: with SMTP id gb32mr1989537ejc.127.1623799406003;
 Tue, 15 Jun 2021 16:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210615173233.26682-1-tinghan.shen@mediatek.com> <20210615173233.26682-25-tinghan.shen@mediatek.com>
In-Reply-To: <20210615173233.26682-25-tinghan.shen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 16 Jun 2021 07:23:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9KtJCUKAvqP_AN+iLs3Zi7pg428=8MvxhiZXbt8DFfPg@mail.gmail.com>
Message-ID: <CAAOTY_9KtJCUKAvqP_AN+iLs3Zi7pg428=8MvxhiZXbt8DFfPg@mail.gmail.com>
Subject: Re: [PATCH 25/27] arm64: dts: mt8195: add vdosys1 support for MT8195
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
        Nancy Lin <nancy.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tinghan:

Tinghan Shen <tinghan.shen@mediatek.com> =E6=96=BC 2021=E5=B9=B46=E6=9C=881=
6=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:39=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> From: Nancy Lin <nancy.lin@mediatek.com>
>
> add vdosys1 support for MT8195
>
> Signed-off-by: Nancy Lin <nancy.lin@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 178 +++++++++++++++++++++--
>  1 file changed, 169 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8195.dtsi
> index e273833a49f8..a98609989905 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -26,6 +26,7 @@
>                 dpi1 =3D &disp_dpi1;
>                 dp-intf0 =3D &dp_intf0;
>                 dp-intf1 =3D &dp_intf1;
> +               merge5 =3D &merge5;
>         };
>
>         clocks {
> @@ -2241,22 +2242,27 @@
>
>                 vdosys_config@1c01a000 {
>                         compatible =3D "mediatek,mt8195-vdosys";
> -                       reg =3D <0 0x1c01a000 0 0x1000>;
> -                       reg-names =3D "vdosys0_config";
> +                       reg =3D <0 0x1c01a000 0 0x1000>,<0 0x1c100000 0 0=
x1000>;
> +                       reg-names =3D "vdosys0_config","vdosys1_config";
>                         iommus =3D <&iommu_vdo M4U_PORT_L0_DISP_RDMA0>;
>                         power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S0>;
> -                       mboxes =3D <&gce1 0 0 CMDQ_THR_PRIO_4>;
> +                       mboxes =3D <&gce1 0 0 CMDQ_THR_PRIO_4>,
> +                                <&gce1 1 0 CMDQ_THR_PRIO_4>;
>                 };
>
>                 mutex: disp_mutex0@1c016000 {
>                         compatible =3D "mediatek,mt8195-disp-mutex";
> -                       reg =3D <0 0x1c016000 0 0x1000>;
> -                       reg-names =3D "vdo0_mutex";
> -                       clocks =3D <&vdosys0 CLK_VDO0_DISP_MUTEX0>;
> +                       reg =3D <0 0x1c016000 0 0x1000>,
> +                             <0 0x1c101000 0 0x1000>;
> +                       reg-names =3D "vdo0_mutex","vdo1_mutex";
> +                       clocks =3D <&vdosys0 CLK_VDO0_DISP_MUTEX0>,
> +                                <&vdosys1 CLK_VDO1_DISP_MUTEX>;
>                         power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S0>;
> -                       clock-names =3D "vdo0_mutex";
> -                       interrupts =3D <GIC_SPI 658 IRQ_TYPE_LEVEL_HIGH 0=
>;
> -                       mediatek,gce-events =3D <CMDQ_EVENT_VDO0_DISP_STR=
EAM_DONE_0>;
> +                       clock-names =3D "vdo0_mutex","sub_mutex";
> +                       interrupts =3D <GIC_SPI 658 IRQ_TYPE_LEVEL_HIGH 0=
>,
> +                                    <GIC_SPI 494 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       mediatek,gce-events =3D <CMDQ_EVENT_VDO0_DISP_STR=
EAM_DONE_0>,
> +                                              <CMDQ_EVENT_VDO1_STREAM_DO=
NE_ENG_0>;
>                 };
>
>                 ovl0: disp_ovl@1c000000 {
> @@ -2446,6 +2452,92 @@
>                         power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S1>;
>                 };
>
> +               disp_pseudo_ovl0@1c104000 {
> +                       compatible =3D "mediatek,mt8195-disp-pseudo-ovl";

Where is the definition of this compatible?

> +                       reg =3D <0 0x1c104000 0 0x1000>,
> +                             <0 0x1c105000 0 0x1000>,
> +                             <0 0x1c106000 0 0x1000>,
> +                             <0 0x1c107000 0 0x1000>,
> +                             <0 0x1c108000 0 0x1000>,
> +                             <0 0x1c109000 0 0x1000>,
> +                             <0 0x1c10A000 0 0x1000>,
> +                             <0 0x1c10B000 0 0x1000>,
> +                             <0 0x1c10C000 0 0x1000>,
> +                             <0 0x1c10D000 0 0x1000>,
> +                             <0 0x1c10E000 0 0x1000>,
> +                             <0 0x1c10F000 0 0x1000>,
> +                             <0 0x1c100000 0 0x1000>;
> +                       reg-names =3D "vdo1_mdp_rdma0","vdo1_mdp_rdma1","=
vdo1_mdp_rdma2",
> +                                   "vdo1_mdp_rdma3","vdo1_mdp_rdma4",
> +                                   "vdo1_mdp_rdma5","vdo1_mdp_rdma6",
> +                                   "vdo1_mdp_rdma7","vdo1_merge0",
> +                                   "vdo1_merge1","vdo1_merge2","vdo1_mer=
ge3","top";
> +                       mediatek,gce-client-reg =3D <&gce1 SUBSYS_1c10XXX=
X 0x4000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c10XXXX =
0x5000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c10XXXX =
0x6000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c10XXXX =
0x7000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c10XXXX =
0x8000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c10XXXX =
0x9000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c10XXXX =
0xA000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c10XXXX =
0xB000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c10XXXX =
0xC000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c10XXXX =
0xD000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c10XXXX =
0xE000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c10XXXX =
0xF000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c10XXXX =
0x0000 0x1000>;
> +                       clocks =3D <&vdosys1 CLK_VDO1_MDP_RDMA0>,
> +                                <&vdosys1 CLK_VDO1_MDP_RDMA1>,
> +                                <&vdosys1 CLK_VDO1_MDP_RDMA2>,
> +                                <&vdosys1 CLK_VDO1_MDP_RDMA3>,
> +                                <&vdosys1 CLK_VDO1_MDP_RDMA4>,
> +                                <&vdosys1 CLK_VDO1_MDP_RDMA5>,
> +                                <&vdosys1 CLK_VDO1_MDP_RDMA6>,
> +                                <&vdosys1 CLK_VDO1_MDP_RDMA7>,
> +                                <&vdosys1 CLK_VDO1_VPP_MERGE0>,
> +                                <&vdosys1 CLK_VDO1_VPP_MERGE1>,
> +                                <&vdosys1 CLK_VDO1_VPP_MERGE2>,
> +                                <&vdosys1 CLK_VDO1_VPP_MERGE3>,
> +                                <&vdosys1 CLK_VDO1_MERGE0_DL_ASYNC>,
> +                                <&vdosys1 CLK_VDO1_MERGE1_DL_ASYNC>,
> +                                <&vdosys1 CLK_VDO1_MERGE2_DL_ASYNC>,
> +                                <&vdosys1 CLK_VDO1_MERGE3_DL_ASYNC>;
> +                       clock-names =3D "vdo1_mdp_rdma0","vdo1_mdp_rdma1"=
,
> +                                     "vdo1_mdp_rdma2","vdo1_mdp_rdma3",
> +                                     "vdo1_mdp_rdma4","vdo1_mdp_rdma5",
> +                                     "vdo1_mdp_rdma6","vdo1_mdp_rdma7",
> +                                     "vdo1_merge0","vdo1_merge1",
> +                                     "vdo1_merge2","vdo1_merge3",
> +                                     "vdo1_merge0_async","vdo1_merge1_as=
ync",
> +                                     "vdo1_merge2_async","vdo1_merge3_as=
ync";
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S1>;
> +                       mediatek,larb =3D <&larb2>;
> +                       mediatek,smi-id =3D <0>;
> +                       iommus =3D <&iommu_vdo M4U_PORT_L2_MDP_RDMA0>;
> +                       interrupts =3D <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH 0=
>, /*rdma0*/
> +                                    <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH 0>,=
 /*rdma1*/
> +                                    <GIC_SPI 497 IRQ_TYPE_LEVEL_HIGH 0>,=
 /*rdma2*/
> +                                    <GIC_SPI 498 IRQ_TYPE_LEVEL_HIGH 0>,=
 /*rdma3*/
> +                                    <GIC_SPI 499 IRQ_TYPE_LEVEL_HIGH 0>,=
 /*rdma4*/
> +                                    <GIC_SPI 500 IRQ_TYPE_LEVEL_HIGH 0>,=
 /*rdma5*/
> +                                    <GIC_SPI 501 IRQ_TYPE_LEVEL_HIGH 0>,=
 /*rdma6*/
> +                                    <GIC_SPI 502 IRQ_TYPE_LEVEL_HIGH 0>,=
 /*rdma7*/
> +                                    <GIC_SPI 503 IRQ_TYPE_LEVEL_HIGH 0>,=
 /*merge0*/
> +                                    <GIC_SPI 504 IRQ_TYPE_LEVEL_HIGH 0>,=
 /*merge1*/
> +                                    <GIC_SPI 505 IRQ_TYPE_LEVEL_HIGH 0>,=
 /*merge2*/
> +                                    <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH 0>;=
 /*merge3*/
> +               };
> +
> +               merge5: disp_vpp_merge5@1c110000 {
> +                       compatible =3D "mediatek,mt8195-disp-merge";

Ditto.

> +                       reg =3D <0 0x1c110000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       clocks =3D <&vdosys1 CLK_VDO1_VPP_MERGE4>,
> +                                <&vdosys1 CLK_VDO1_MERGE4_DL_ASYNC>;
> +                       clock-names =3D "merge5","merge5_async";
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S1>;
> +                       mediatek,gce-client-reg =3D <&gce1 SUBSYS_1c11XXX=
X 0x0000 0x1000>;
> +               };
> +
>                 disp_dpi1: disp_dpi1@1c112000 {
>                         compatible =3D "mediatek,mt8195-dpi";
>                         reg =3D <0 0x1c112000 0 0x1000>;
> @@ -2478,6 +2570,54 @@
>                         status =3D "disabled";
>                 };
>
> +               disp_ethdr@1c114000 {
> +                       compatible =3D "mediatek,mt8195-disp-ethdr";

Ditto.

> +                       reg =3D <0 0x1c114000 0 0x1000>,
> +                             <0 0x1c115000 0 0x1000>,
> +                             <0 0x1c117000 0 0x1000>,
> +                             <0 0x1c119000 0 0x1000>,
> +                             <0 0x1c11A000 0 0x1000>,
> +                             <0 0x1c11B000 0 0x1000>,
> +                             <0 0x1c11C000 0 0x1000>,
> +                             <0 0x1c100000 0 0x1000>;
> +                       reg-names =3D "hdr_disp_mixer","hdr_vdo_fe0","hdr=
_vdo_fe1",
> +                                   "hdr_gfx_fe0","hdr_gfx_fe1","hdr_vdo_=
be",
> +                                   "hdr_adl_ds","top";
> +                       mediatek,gce-client-reg =3D <&gce1 SUBSYS_1c11XXX=
X 0x4000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c11XXXX =
0x5000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c11XXXX =
0x7000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c11XXXX =
0x9000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c11XXXX =
0xA000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c11XXXX =
0xB000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c11XXXX =
0xC000 0x1000>,
> +                                                 <&gce1 SUBSYS_1c10XXXX =
0x0000 0x1000>;
> +                       clocks =3D <&vdosys1 CLK_VDO1_DISP_MIXER>,
> +                                <&vdosys1 CLK_VDO1_HDR_VDO_FE0>,
> +                                <&vdosys1 CLK_VDO1_HDR_VDO_FE1>,
> +                                <&vdosys1 CLK_VDO1_HDR_GFX_FE0>,
> +                                <&vdosys1 CLK_VDO1_HDR_GFX_FE1>,
> +                                <&vdosys1 CLK_VDO1_HDR_VDO_BE>,
> +                                <&vdosys1 CLK_VDO1_26M_SLOW>,
> +                                <&vdosys1 CLK_VDO1_HDR_VDO_FE0_DL_ASYNC>=
,
> +                                <&vdosys1 CLK_VDO1_HDR_VDO_FE1_DL_ASYNC>=
,
> +                                <&vdosys1 CLK_VDO1_HDR_GFX_FE0_DL_ASYNC>=
,
> +                                <&vdosys1 CLK_VDO1_HDR_GFX_FE1_DL_ASYNC>=
,
> +                                <&vdosys1 CLK_VDO1_HDR_VDO_BE_DL_ASYNC>,
> +                                <&topckgen CLK_TOP_ETHDR_SEL>;
> +                       clock-names =3D "hdr_disp_mixer","hdr_vdo_fe0","h=
dr_vdo_fe1",
> +                                     "hdr_gfx_fe0","hdr_gfx_fe1","hdr_vd=
o_be",
> +                                     "hdr_adl_ds","hdr_vdo_fe0_async",
> +                                     "hdr_vdo_fe1_async","hdr_gfx_fe0_as=
ync",
> +                                     "hdr_gfx_fe1_async","hdr_vdo_be_asy=
nc",
> +                                     "ethdr_top";
> +                       power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S1>;
> +                       mediatek,larb =3D <&larb3>;
> +                       mediatek,smi-id =3D <1>;
> +                       iommus =3D <&iommu_vpp M4U_PORT_L3_HDR_DS>,
> +                                <&iommu_vpp M4U_PORT_L3_HDR_ADL>;
> +                       interrupts =3D <GIC_SPI 517 IRQ_TYPE_LEVEL_HIGH 0=
>; /*disp mixer*/
> +               };
> +
>                 hdmi0: hdmi@1c300000 {
>                         compatible =3D "mediatek,mt8195-hdmi";
>                         reg =3D <0 0x1c300000 0 0x1000>;
> @@ -2517,6 +2657,26 @@
>                 };
>         };
>
> +       disp_pseudo_ovl_l2 {
> +               compatible =3D "mediatek,mt8195-pseudo-ovl-larb";

Ditto.

> +               mediatek,larb-id =3D <2>;
> +               power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> +               iommus =3D <&iommu_vdo M4U_PORT_L2_MDP_RDMA0>,
> +                        <&iommu_vdo M4U_PORT_L2_MDP_RDMA2>,
> +                        <&iommu_vdo M4U_PORT_L2_MDP_RDMA4>,
> +                        <&iommu_vdo M4U_PORT_L2_MDP_RDMA6>;
> +       };
> +
> +       disp_pseudo_ovl_l3 {
> +               compatible =3D "mediatek,mt8195-pseudo-ovl-larb";

Ditto.

Regards,
Chun-Kuang.

> +               mediatek,larb-id =3D <3>;
> +               power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> +               iommus =3D <&iommu_vpp M4U_PORT_L3_MDP_RDMA1>,
> +                        <&iommu_vpp M4U_PORT_L3_MDP_RDMA3>,
> +                        <&iommu_vpp M4U_PORT_L3_MDP_RDMA5>,
> +                        <&iommu_vpp M4U_PORT_L3_MDP_RDMA7>;
> +       };
> +
>         hdmiddc0: ddc_i2c {
>                 compatible =3D "mediatek,mt8195-hdmi-ddc";
>                 clocks =3D <&clk26m>;
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
