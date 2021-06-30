Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A045A3B8A97
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 00:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhF3Wv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 18:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhF3WvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 18:51:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F23746144B;
        Wed, 30 Jun 2021 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625093335;
        bh=K5tqVnA5H8pJjO/PErp+ucNJUcozi2NUBIMqh7jU9cg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ff0mncC0JZQqsxNHNmEAQ391wV4s4XXHPtCqgygDCXq6MtkEmYk5aqfAGBX/WwxMh
         wyRe44IuixO2+cwRv7idWkhfbXcdONQOV9QASQfYKUroKnwoKqGVWzcKq9/9DdKQji
         /mv5L95v85w+DItOsSdI/oqWj4937RuBEf+UORRPp6mEEAPjc+q5xUVf1meRR3gpFB
         QlSUxCFj9pxRZ1sjPishkDebNZmFNJ5h3de7WMa+WisBiGQK+m31yTLGilcl9xw/RZ
         6YMerLOmKTJjP53koTfuPkjVW4eIEVrAlTa/EgV/ERV+r/HZ2axbeAAZRlRKupLRvT
         4K+6eioQL+qqA==
Received: by mail-ej1-f48.google.com with SMTP id hc16so6929848ejc.12;
        Wed, 30 Jun 2021 15:48:54 -0700 (PDT)
X-Gm-Message-State: AOAM533YzyK62KXo4tTn5cUQaaM4cWdzrZmhdtZJmoSjaKfxox6/Vcb/
        EBCIHUvHyEBpAQ/B6CbWqTZsYmlmPctimmGeqA==
X-Google-Smtp-Source: ABdhPJzv+vxWlKKUY48KvGgu+sCcmFtxKd8ufDpE3mMFjf3babtLW/Uip0aRn9nBtqlbe5jpH6U/4LTeK9Al6Qe1vJo=
X-Received: by 2002:a17:906:680f:: with SMTP id k15mr36868137ejr.75.1625093333492;
 Wed, 30 Jun 2021 15:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210630144646.868702-1-enric.balletbo@collabora.com> <20210630164623.3.I7bd7d9a8da5e2894711b700a1127e6902a2b2f1d@changeid>
In-Reply-To: <20210630164623.3.I7bd7d9a8da5e2894711b700a1127e6902a2b2f1d@changeid>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 1 Jul 2021 06:48:42 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-VAvKCkBj1q4euWFcmbnNUJfXpG9rh9vua80yrok-y9w@mail.gmail.com>
Message-ID: <CAAOTY_-VAvKCkBj1q4euWFcmbnNUJfXpG9rh9vua80yrok-y9w@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: mt8173: Add the mmsys reset bit to reset
 the dsi0
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI, Enric:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2021=E5=B9=
=B46=E6=9C=8830=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:47=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> Reset the DSI hardware is needed to prevent different settings between
> the bootloader and the kernel.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi  | 2 ++
>  include/dt-bindings/reset/mt8173-resets.h | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8173.dtsi
> index e5596fe01a1d..36c3998eb7f1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -1036,6 +1036,7 @@ mmsys: syscon@14000000 {
>                         assigned-clocks =3D <&topckgen CLK_TOP_MM_SEL>;
>                         assigned-clock-rates =3D <400000000>;
>                         #clock-cells =3D <1>;
> +                       #reset-cells =3D <1>;
>                         mboxes =3D <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
>                                  <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
>                         mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX=
 0 0x1000>;
> @@ -1262,6 +1263,7 @@ dsi0: dsi@1401b000 {
>                                  <&mmsys CLK_MM_DSI0_DIGITAL>,
>                                  <&mipi_tx0>;
>                         clock-names =3D "engine", "digital", "hs";
> +                       resets =3D <&mmsys MT8173_MMSYS_SW0_RST_B_DISP_DS=
I0>;

Add this in binding document. It would be good if the binding document
is in yaml format.

Regards,
Chun-Kuang.

>                         phys =3D <&mipi_tx0>;
>                         phy-names =3D "dphy";
>                         status =3D "disabled";
> diff --git a/include/dt-bindings/reset/mt8173-resets.h b/include/dt-bindi=
ngs/reset/mt8173-resets.h
> index ba8636eda5ae..6a60c7cecc4c 100644
> --- a/include/dt-bindings/reset/mt8173-resets.h
> +++ b/include/dt-bindings/reset/mt8173-resets.h
> @@ -27,6 +27,8 @@
>  #define MT8173_INFRA_GCE_FAXI_RST       40
>  #define MT8173_INFRA_MMIOMMURST         47
>
> +/* MMSYS resets */
> +#define MT8173_MMSYS_SW0_RST_B_DISP_DSI0       25
>
>  /*  PERICFG resets */
>  #define MT8173_PERI_UART0_SW_RST        0
> --
> 2.30.2
>
