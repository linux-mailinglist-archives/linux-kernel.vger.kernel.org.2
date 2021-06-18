Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901903ACD1B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhFROKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhFROKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:10:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AD8E613E2;
        Fri, 18 Jun 2021 14:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624025272;
        bh=q/EDRsPbyVWw5nHi1pYUbYz0y1rXX8Okh97nJe5Pe5s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d9j253wkESIMW45qp/ovM+NBE8sm+EXTmrbeWa10xcjBaqjSMjf1LyuvEM45fy6FT
         3eVpFHXzk5JF/TgOETVLLoKy36ywpeXC/x1CQTL1aXsmc7pRsIgEIbh2kiQvyWEM0i
         uHK+JUSzq4glrSEEQxK0qHCrG4ekb79dp8iJ7MesvceUly84s8nIAXJyIl84ZZtmPA
         GqNZX3f6tJbGFw07JeXWpX6f0m/xCY/Pnu99+a0qPhtevC0g1eDIQvY0bW0f4kpj61
         2BdPeByG17CzChFIiBur/VPnN5nYb9KrgQmddiJMwHjehyIKaKo+bS0wip/o6pR8Ls
         VqMmutnkpqxVg==
Received: by mail-ed1-f44.google.com with SMTP id t7so8815047edd.5;
        Fri, 18 Jun 2021 07:07:52 -0700 (PDT)
X-Gm-Message-State: AOAM531yfeLSHSYPAvFehzPS/q3agqqWAm61/kyFwNSjRKWZyqswJxbG
        1kZQ0zyDP6QfbA1HYwulgcOGjqTbWTtmgyPF6w==
X-Google-Smtp-Source: ABdhPJwKlMD/iaZlnx1AtcRmiX+8KHoKp9K/i1zV+cOE9TBxS9hQPHWvWDu2gJFH+ufOe7b8ejNQgcY0Cmei387eDz8=
X-Received: by 2002:aa7:c0da:: with SMTP id j26mr5031487edp.38.1624025270893;
 Fri, 18 Jun 2021 07:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210615173233.26682-1-tinghan.shen@mediatek.com> <20210615173233.26682-23-tinghan.shen@mediatek.com>
In-Reply-To: <20210615173233.26682-23-tinghan.shen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 18 Jun 2021 22:07:40 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9Q63NGmOxjbBz0AEUdMUoVbTpbn8ZXkawauP_bNr2oYw@mail.gmail.com>
Message-ID: <CAAOTY_9Q63NGmOxjbBz0AEUdMUoVbTpbn8ZXkawauP_bNr2oYw@mail.gmail.com>
Subject: Re: [PATCH 23/27] arm64: dts: mt8195: add gce node
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
6=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:35=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> From: Jason-JH Lin <jason-jh.lin@mediatek.com>
>
> add gce node on dts file.
>
> Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8195.dtsi
> index d7d2c2a8f461..51edb8ee35a8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -7,6 +7,7 @@
>  /dts-v1/;
>
>  #include <dt-bindings/clock/mt8195-clk.h>
> +#include <dt-bindings/gce/mt8195-gce.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/memory/mt8195-memory-port.h>
> @@ -1075,6 +1076,26 @@
>                         #clock-cells =3D <1>;
>                 };
>
> +               gce0: mdp_mailbox@10320000 {
> +                       compatible =3D "mediatek,mt8195-gce";

Where is the definition of this compatible?

> +                       reg =3D <0 0x10320000 0 0x4000>;
> +                       interrupts =3D <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       #mbox-cells =3D <3>;
> +                       clocks =3D <&infracfg_ao CLK_INFRA_AO_GCE>,
> +                                <&infracfg_ao CLK_INFRA_AO_GCE2>;
> +                       clock-names =3D "gce0", "gce1";

According to the binding document [1], clock-names should be "gce".

[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/mailbox/mt=
k-gce.txt

Regards,
Chun-Kuang.

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
> +                       clock-names =3D "gce0", "gce1";
> +               };
> +
>                 uart0: serial@11001100 {
>                         compatible =3D "mediatek,mt8195-uart", "mediatek,=
mt6577-uart";
>                         reg =3D <0 0x11001100 0 0x100>;
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
