Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E093C3B8AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 01:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbhF3XZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 19:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237700AbhF3XYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 19:24:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1AFB614A7;
        Wed, 30 Jun 2021 23:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625095317;
        bh=tHL+XCD2rEOEbdKWrPLa/uYf1Uf/oPwC9ZVcqe4TrdY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YYa33W2Vyt7lkUX04pP+nNvic6v7cT5Uo2pb8NL2unCfUn5oPA/NrwOat3zyM2oWw
         XZOBlVwFU5f7qTuKjro6Ydm0353Yl3l4nm7E6JOCwHH7guKZGu452c1+gtBEt86+78
         g74Ec9OJJgxr/x60pq/DSyBTZF0PrFgVfyfdyexnk4JbsqrxCGN/RFnZVxPfbMWLY5
         mB/j4p19WV4CL2tQwj9jnRV9SFBViabowIpoDOZgLuYPZQIUBwL875vIaZ0DC3vhBO
         vhinhbDPhM0Jg2P7VENluWFuXEQf4oNmc1QrJ1sowwO+iEUn62bWHGWbR6KDmhex23
         lEQDuP7XWt4Qg==
Received: by mail-ej1-f48.google.com with SMTP id bg14so7080536ejb.9;
        Wed, 30 Jun 2021 16:21:57 -0700 (PDT)
X-Gm-Message-State: AOAM532nBqL1SqjjLB52LDa+YwqB1VGBVhyFcy2gKvDjdkOWjP5/mdmr
        IEPx7dyCynp5UqJYETdKVCcVIXHLh4Sd4hEY8w==
X-Google-Smtp-Source: ABdhPJzPLyaPSWeFoM4shqoF7CpJjg3MvYR1+Z7xCorPSgqpeK6NZ7q6OI8QkU2saaQqmqcU0ei0B2umtiEAoJkXeD4=
X-Received: by 2002:a17:907:7287:: with SMTP id dt7mr4200475ejc.127.1625095316280;
 Wed, 30 Jun 2021 16:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210630051418.14044-1-jason-jh.lin@mediatek.com> <20210630051418.14044-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20210630051418.14044-4-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 1 Jul 2021 07:21:45 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9B1L=1=LzdC_1_czFgc4smH0hTk0B=XCquH08KAjx_nA@mail.gmail.com>
Message-ID: <CAAOTY_9B1L=1=LzdC_1_czFgc4smH0hTk0B=XCquH08KAjx_nA@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] arm64: dts: mt8195: add gce node
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com, Nancy Lin <nancy.lin@mediatek.com>,
        singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B46=E6=9C=883=
0=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=881:18=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> add gce node on dts file.
>
> Change-Id: I805455cb7c645cb5a24ce1c87fe891a807069123
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
> This patch is based on [1]
> [1] Add Mediatek SoC MT8195 and evaluation board dts and Makefile
>     - https://patchwork.kernel.org/project/linux-mediatek/patch/202106010=
75350.31515-2-seiya.wang@mediatek.com/
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8195.dtsi
> index c146a91c6272..38054196eea4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -6,6 +6,7 @@
>
>  /dts-v1/;
>  #include <dt-bindings/clock/mt8195-clk.h>
> +#include <dt-bindings/gce/mt8195-gce.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/power/mt8195-power.h>
> @@ -717,6 +718,26 @@
>                         #clock-cells =3D <1>;
>                 };
>
> +               gce0: mdp_mailbox@10320000 {
> +                       compatible =3D "mediatek,mt8195-gce";
> +                       reg =3D <0 0x10320000 0 0x4000>;
> +                       interrupts =3D <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       #mbox-cells =3D <3>;
> +                       clocks =3D <&infracfg_ao CLK_INFRA_AO_GCE>,
> +                                <&infracfg_ao CLK_INFRA_AO_GCE2>;
> +                       clock-names =3D "gce", "gce1";
> +               };
> +
> +               gce1: disp_mailbox@10330000 {
> +                       compatible =3D "mediatek,mt8195-gce";
> +                       reg =3D <0 0x10330000 0 0x4000>;
> +                       interrupts =3D <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       #mbox-cells =3D <3>;
> +                       clocks =3D <&infracfg_ao CLK_INFRA_AO_GCE>,
> +                                <&infracfg_ao CLK_INFRA_AO_GCE2>;
> +                       clock-names =3D "gce", "gce1";

I think each gce could be broken into two function block, the core
function block and event processing block.
Each block has independent clock source and "gce" is for core function
block and "gce1" is for event processing block, is it?
If so, the core function of gce0 and gce1 has common clock source
(<&infracfg_ao CLK_INFRA_AO_GCE>), right?

Regards,
Chun-Kuang.

> +               };
> +
>                 uart0: serial@11001100 {
>                         compatible =3D "mediatek,mt8195-uart", "mediatek,=
mt6577-uart";
>                         reg =3D <0 0x11001100 0 0x100>;
> --
> 2.18.0
>
