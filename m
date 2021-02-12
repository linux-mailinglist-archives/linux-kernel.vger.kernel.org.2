Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1B031A0CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhBLOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:41:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhBLOld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:41:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7573A64E6C;
        Fri, 12 Feb 2021 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613140852;
        bh=lNmf+KonFuMPi+dCFqb4apHvIFyN63ZqhEuNvuAJZJU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=td5au61zw+FH83RNa8thtPObsVAI3458852CvKpchSTdCb59iljNK91+7ECh7e/jg
         brNylOPY9rhazfPz5HfUtkgLYLr+4iD2qjjm85S23sSu8QamwRhRy9hqw4j596QHsk
         GQBnjoYAelq9h2WyRYvO4c+4rMyGmJCOF283ctuNGrnn0i9f+4NkcLMTyvABsZ8O9j
         wOkBodRWHRpTeGzaFOsm9BO80z7Xj9CTt2FwudCt3JpWieXsBsjobjBhCw8IgSkdw9
         rgBHPvGWerc0LdUgYLHZEelv5aPoesfeKzX1KF7I/7Y1Dtr7cblt5zr7Iv+fMooY2c
         z381YVLqhw/4w==
Received: by mail-wr1-f51.google.com with SMTP id t15so5897605wrx.13;
        Fri, 12 Feb 2021 06:40:52 -0800 (PST)
X-Gm-Message-State: AOAM531xkT/y9DUZLilfwPQ+62PC8vXdJoKqnKhT5u7NhRCrbbxO9C0W
        Xqbp01xHHghI0uStpS9UvBTpjxgCST1ed1v6Fg==
X-Google-Smtp-Source: ABdhPJwlgv4RWqsDiLaeTsG54Sh0GpBHZUBUqDQ3pj4i+G7BzdkEZweyl6jsXPlPJ0Trb4kAvI8JnfP3v+LhWsbBKNY=
X-Received: by 2002:a5d:6783:: with SMTP id v3mr3814242wru.394.1613140851043;
 Fri, 12 Feb 2021 06:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com> <20210201070016.41721-3-chunfeng.yun@mediatek.com>
In-Reply-To: <20210201070016.41721-3-chunfeng.yun@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 12 Feb 2021 22:40:39 +0800
X-Gmail-Original-Message-ID: <CAAOTY__QS8USVB3ZZ_a9t8VvOEZvnLCpdVxPtwgG0m9__p+fMQ@mail.gmail.com>
Message-ID: <CAAOTY__QS8USVB3ZZ_a9t8VvOEZvnLCpdVxPtwgG0m9__p+fMQ@mail.gmail.com>
Subject: Re: [PATCH next v3 03/16] dt-bindings: phy: mediatek: dsi-phy: modify
 compatible dependence
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
> mt7623-mipi-tx is compatible to mt2701-mipi-tx, and use
> "mediatek,mt2701-mipi-tx" instead on MT7623, so modify
> the compatible items to make dependence clear.

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3: modify commit message suggested by CK
> v2: separate two patches suggested by CK
> ---
>  .../devicetree/bindings/phy/mediatek,dsi-phy.yaml   | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml =
b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> index 71d4acea1f66..6e4d795f9b02 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> @@ -19,11 +19,14 @@ properties:
>      pattern: "^dsi-phy@[0-9a-f]+$"
>
>    compatible:
> -    enum:
> -      - mediatek,mt2701-mipi-tx
> -      - mediatek,mt7623-mipi-tx
> -      - mediatek,mt8173-mipi-tx
> -      - mediatek,mt8183-mipi-tx
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt7623-mipi-tx
> +          - const: mediatek,mt2701-mipi-tx
> +      - const: mediatek,mt2701-mipi-tx
> +      - const: mediatek,mt8173-mipi-tx
> +      - const: mediatek,mt8183-mipi-tx
>
>    reg:
>      maxItems: 1
> --
> 2.18.0
