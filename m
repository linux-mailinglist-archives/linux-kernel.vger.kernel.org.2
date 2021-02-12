Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D70731A0D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhBLOmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhBLOmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:42:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D917B64E7A;
        Fri, 12 Feb 2021 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613140897;
        bh=w41GzsJk0Vogbh4l71xjGxLnYcjpT88j2ABTUyR0CPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CMJycKMceiGxoVjgh66jMjcZGvF/VK0b5CQPBqftuYsiYWCVToXNfbG4tzSjxa45T
         820jRA1mpFm2F6XQLAZQ+YNjN6CR48/YM7qEYXZ0zA73VLCLS2hEldmADLAo9crSCo
         Fypz0aHib4ZJ1dUeK1BX1iMHA/DamncbRbNsxEXOtfZmnDvQVacS93v6JcaA6IoBma
         FDvCISxq9JB0n+ZCz3Df3KFhH4X6lLv2hhMCJPDDKi40FfdnnV/v0Ijx5b0gGGLDOr
         z+JbUd2J5mE1STVwthrR/nDJwnlk7bW6X4M6vCDnvM5YcIykZZXFwX61UYSleHHj9E
         YXt6C3hKpaq2Q==
Received: by mail-wm1-f48.google.com with SMTP id y134so1232790wmd.3;
        Fri, 12 Feb 2021 06:41:36 -0800 (PST)
X-Gm-Message-State: AOAM533uVMTtzbFkdCSykAAzdXPbfMnhuc2DU93pSQXrsogqeF/sI2IH
        BR8NiEAzPyMbGFUXKumsduLJ93qlg7273a84jQ==
X-Google-Smtp-Source: ABdhPJzdFy4n8dWcKUYHoVq6+dVbyp7JXRlajzvwa8pvXT90zRWzOYhLksxIrD/3To51pG8WvOViuzKeUWRQtAPU1Qc=
X-Received: by 2002:a1c:5f82:: with SMTP id t124mr2937914wmb.55.1613140895464;
 Fri, 12 Feb 2021 06:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com> <20210201070016.41721-4-chunfeng.yun@mediatek.com>
In-Reply-To: <20210201070016.41721-4-chunfeng.yun@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 12 Feb 2021 22:41:24 +0800
X-Gmail-Original-Message-ID: <CAAOTY__G=+8q=8WiRsh4Qvfk5GQz3D4iFTBecWXGq7hX_7_m_g@mail.gmail.com>
Message-ID: <CAAOTY__G=+8q=8WiRsh4Qvfk5GQz3D4iFTBecWXGq7hX_7_m_g@mail.gmail.com>
Subject: Re: [PATCH next v3 04/16] dt-bindings: phy: mediatek: hdmi-phy:
 modify compatible items
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chunfeng:

Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2021=E5=B9=B42=E6=9C=881=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:00=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> mt7623-hdmi-tx is compatible to mt2701-hdmi-tx, and the compatible
> "mediatek,mt7623-hdmi-tx" is not supported in driver, in fact uses
> "mediatek,mt2701-hdmi-tx" instead on MT7623, so changes the
> compatible items to make dependence clear.

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3: modify commit message
> v2: no changes
> ---
>  .../devicetree/bindings/phy/mediatek,hdmi-phy.yaml    | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml=
 b/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
> index 4752517a1446..0d94950b84ca 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
> @@ -21,10 +21,13 @@ properties:
>      pattern: "^hdmi-phy@[0-9a-f]+$"
>
>    compatible:
> -    enum:
> -      - mediatek,mt2701-hdmi-phy
> -      - mediatek,mt7623-hdmi-phy
> -      - mediatek,mt8173-hdmi-phy
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt7623-hdmi-phy
> +          - const: mediatek,mt2701-hdmi-phy
> +      - const: mediatek,mt2701-hdmi-phy
> +      - const: mediatek,mt8173-hdmi-phy
>
>    reg:
>      maxItems: 1
> --
> 2.18.0
