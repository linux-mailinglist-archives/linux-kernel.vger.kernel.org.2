Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F067414DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 18:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhIVQPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 12:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236580AbhIVQOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:14:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9460F611EE;
        Wed, 22 Sep 2021 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632327205;
        bh=k2Pj+TuZexZ6ukjV1H0j47mTKTEdHbsKE38t9ELGnwg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ss/t7YRtW4/pQQEQUBPntkIYXMZJu1oNsMVRHoU7WVsfEvF/Bin3so4Jur818nglt
         spUunv61xYEGWmqSfbZWff9/3nAjsjTGzjnjHtwyqpoztZPDdwTygO2P0a/76J8sMw
         eQyvGTIcefsJE1QATzbNab7J7wJc2GOi6FP9ClcuKbM05KTAoof7OJ3onnCnUKjTGW
         Zuc5BnTzCNN7ftVuY8R7khqroCJuET4/xQAdylFoeWEPHdqJwPKG218b2HoUPkSPZy
         bkZBDyX00TXR8EqIjjwsi+TUo9AmHHyP2UK/zmP994TvDvXpuIhaVv3fdfj/vzcVHt
         2ZoLgB7FPewWQ==
Received: by mail-ed1-f53.google.com with SMTP id co2so11763130edb.8;
        Wed, 22 Sep 2021 09:13:25 -0700 (PDT)
X-Gm-Message-State: AOAM5305SFOT80OnLPmEZ48qQZFZ6zLtWBbLJXt5nXAaHxgZoyYMRWEl
        rHgGxKTKmZXp59NnAlrgsfKQLwWSNbuJeeKKtw==
X-Google-Smtp-Source: ABdhPJz0EFOiG8RAy7xNyqTHM9kZtLsTE6kn0uXnl1IvG1FgKwEubeYEUB8kZr/WOB+y08WZzwtJ8r8/AvNNj4hXTTI=
X-Received: by 2002:a17:907:995a:: with SMTP id kl26mr454695ejc.6.1632327204098;
 Wed, 22 Sep 2021 09:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210907083723.7725-1-granquet@baylibre.com> <20210907083723.7725-4-granquet@baylibre.com>
In-Reply-To: <20210907083723.7725-4-granquet@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 23 Sep 2021 00:13:13 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8FC-sP0PP0Fv6G-2cwUDp6mDLx_3JmmSc144NSCyULXw@mail.gmail.com>
Message-ID: <CAAOTY_8FC-sP0PP0Fv6G-2cwUDp6mDLx_3JmmSc144NSCyULXw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: phy: Add binding for Mediatek MT8195
 HDMI PHY
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Guillaume:

Guillaume Ranquet <granquet@baylibre.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=88=
7=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:39=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add bindings to describe Mediatek MT8195 HDMI PHY

Move this patch before the driver patch which reference this patch.

>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  .../phy/mediatek,mtk8195-hdmi-phy.yaml        | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mtk819=
5-hdmi-phy.yaml

I think this file should be merged into mediatek,hdmi-phy.yaml [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml?h=3Dv5.15-rc2

Regards,
Chun-Kuang.

>
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-=
phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.=
yaml
> new file mode 100644
> index 000000000000..f03bd3af7fd8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.yam=
l
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2020 MediaTek
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/mediatek,hdmi-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek High Definition Multimedia Interface (HDMI) PHY binding =
for mt8195
> +
> +maintainers:
> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +  - Chunfeng Yun <chunfeng.yun@mediatek.com>
> +
> +description: |
> +  The HDMI PHY serializes the HDMI encoder's three channel 10-bit parall=
el
> +  output and drives the HDMI pads.
> +
> +properties:
> +  $nodename:
> +    pattern: "^hdmi-phy@[0-9a-f]+$"
> +
> +  compatible:
> +    - const: mediatek,mt8195-hdmi-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PLL reference clock
> +
> +  clock-names:
> +    items:
> +      - const: hdmi_xtal_sel
> +
> +  clock-output-names:
> +    items:
> +      - const: hdmi_txpll
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  "#clock-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - clock-output-names
> +  - "#phy-cells"
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    hdmi_phy: hdmi-phy@11d5f000 {
> +        compatible =3D "mediatek,mt8195-hdmi-phy";
> +        reg =3D <0 0x11d5f000 0 0x100>;
> +        clocks =3D <&topckgen CLK_TOP_HDMI_XTAL>;
> +        clock-names =3D "hdmi_xtal_sel";
> +        clock-output-names =3D "hdmi_txpll";
> +        #clock-cells =3D <0>;
> +        #phy-cells =3D <0>;
> +    };
> +
> +...
> --
> 2.31.1
>
