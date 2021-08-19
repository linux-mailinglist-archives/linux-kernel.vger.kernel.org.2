Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C733F1C19
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbhHSPAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhHSPAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:00:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 015DC61159;
        Thu, 19 Aug 2021 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629385215;
        bh=aZJbgY0dYPtD/UwLcyqp1tm6QeXuUNB0SoluXhrFRYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i+LSnZtTwtysJWxuhDZw3d9mLByOTctc0IRpFBGeMV7AilsjX/uqIzbZrgmQOIx+U
         gaIWmHFCQlH1MC43SlpZWLb3HkXHKzaaWnXKfQg1N8dShgxkPh7zWGpt8Jejyj+LmA
         KHSKzowAvj3cCdsGBEh9CTt7dtUpNTLBtB4ZhiuyUQJI0R0K1zHuO1i9/psY/lB3E1
         dgDVjIiyRro/+mx37cVURd1a/FX1cYAimTn0h1icl42RDTo+dZU9IAMuw9nQ7UkgC8
         2sX96i2LEGgE7pSlfQUxpdjJWNX7GTNtCgS8LHlIm58w2p5cAwmTJBI7+uN1QdBYkV
         UHBbHudIoU0cw==
Received: by mail-ed1-f47.google.com with SMTP id dj8so9338986edb.2;
        Thu, 19 Aug 2021 08:00:14 -0700 (PDT)
X-Gm-Message-State: AOAM532P2ZHAGdfDo2T5LXasfs29nqpen6j1DjPvXePPPUrFTXGf3VWo
        p18WyQRDg76Mgn7eYqcdUqfhnqgaR3m+5/N6oA==
X-Google-Smtp-Source: ABdhPJywGAFcZyeFfHGvm2H/Zdii8mlwORsTkptePeQu2y+i3nkMQ+zjBa4vUPMxNQYtZNzH4FvakVszXQcwdaXQiUE=
X-Received: by 2002:a05:6402:b64:: with SMTP id cb4mr16678817edb.49.1629385213446;
 Thu, 19 Aug 2021 08:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210819022327.13040-1-jason-jh.lin@mediatek.com> <20210819022327.13040-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20210819022327.13040-2-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 19 Aug 2021 23:00:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9Yug-9S4uBkNLTJH+TU8dHCeOjLuwXdNMJ+R89qJyJ9Q@mail.gmail.com>
Message-ID: <CAAOTY_9Yug-9S4uBkNLTJH+TU8dHCeOjLuwXdNMJ+R89qJyJ9Q@mail.gmail.com>
Subject: Re: [PATCH v8 01/13] dt-bindings: arm: mediatek: mmsys: add mt8195
 SoC binding
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>, fshao@chromium.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B48=E6=9C=881=
9=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:23=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> 1. There are 2 mmsys, namely vdosys0 and vdosys1 in mt8195.
>    Each of them is bound to a display pipeline, so add their
>    definition in mtk-mmsys documentation with 2 compatibles.
>
> 2. Add description for power-domain property.
>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
> this patch is base on [1][2]
>
> [1] dt-bindings: arm: mediatek: mmsys: convert to YAML format
> - https://patchwork.kernel.org/project/linux-mediatek/patch/2021051916184=
7.3747352-1-fparent@baylibre.com/
> [2] dt-bindings: arm: mediatek: mmsys: add MT8365 SoC binding
> - https://patchwork.kernel.org/project/linux-mediatek/patch/2021051916184=
7.3747352-2-fparent@baylibre.com/
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml  | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsy=
s.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 2d4ff0ce387b..68cb330d7595 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -30,6 +30,8 @@ properties:
>                - mediatek,mt8173-mmsys
>                - mediatek,mt8183-mmsys
>                - mediatek,mt8365-mmsys
> +              - mediatek,mt8195-vdosys0
> +              - mediatek,mt8195-vdosys1
>            - const: syscon
>        - items:
>            - const: mediatek,mt7623-mmsys
> @@ -39,6 +41,12 @@ properties:
>    reg:
>      maxItems: 1
>
> +  power-domains:
> +    description:
> +      A phandle and PM domain specifier as defined by bindings
> +      of the power controller specified by phandle. See
> +      Documentation/devicetree/bindings/power/power-domain.yaml for deta=
ils.
> +

This patch is about mt8195, but mt8173 mmsys also has power domain. So
move this part to another patch.

Regards,
Chun-Kuang.


>    "#clock-cells":
>      const: 1
>
> --
> 2.18.0
>
