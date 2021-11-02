Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C220544393E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhKBXDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231237AbhKBXDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:03:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BDD9610FC;
        Tue,  2 Nov 2021 23:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635894075;
        bh=7za+8VmhH4SxMCrBIhExSwc/wQW3n+Vvx3HN8L5btUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qQbivG04eHT15U/V2m2PwaBBPFbE5pVw7WjSuXzqoMurMg2XPb6lgmin/IW7TEMsF
         piloRynOMg45zxgMmUVwKr6HBfB8OoVgMiKxtWbiCXxlWu5zSyggyK9OYIPgJC/U5i
         cqUgwErSBcNc+57oqIrzktTKjuA7Qz32UrWCpfgl5IxOHejMdwJD+U/x/S9ArCBQ/y
         SVp3XProKhSZF//j1UGCVzvPzyWJiC+eOqCXEZ1aWYFJU8jKRc3l55R8ZS+5FSVlHh
         HeszrbniuIOzqB9VFhNzyVG8ZWSe1Kqos54ryk6MM/yCRDfOeM/jRRQ/nKldCQOuIF
         HawWfv0R39FqQ==
Received: by mail-ed1-f53.google.com with SMTP id w1so2706720edd.10;
        Tue, 02 Nov 2021 16:01:15 -0700 (PDT)
X-Gm-Message-State: AOAM532yv8RmUR4Cos0QegikI/+l3wjfZLOpHAmpRgTrmiGWL2TfSLt/
        46zFe5DpDZAoXtBqabJouo9boXUF5LYr2ptw3g==
X-Google-Smtp-Source: ABdhPJyxcbs6CeDuocmUunjumDamTIqOyunUODX58iyrgJqIgEl0epR4GlZ5r5q83N+6egY+pDHL/wbGbLb5XYffH4A=
X-Received: by 2002:a50:f18c:: with SMTP id x12mr36623804edl.357.1635894073762;
 Tue, 02 Nov 2021 16:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211026155911.17651-1-jason-jh.lin@mediatek.com> <20211026155911.17651-7-jason-jh.lin@mediatek.com>
In-Reply-To: <20211026155911.17651-7-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 3 Nov 2021 07:01:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9TQei1sP4D4eFsS+dPvisonaNtUu-JEmmhff53y1pwkw@mail.gmail.com>
Message-ID: <CAAOTY_9TQei1sP4D4eFsS+dPvisonaNtUu-JEmmhff53y1pwkw@mail.gmail.com>
Subject: Re: [PATCH v12 06/16] dt-bindings: display: mediatek: add mt8195 SoC
 binding for vdosys0
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fei Shao <fshao@chromium.org>,
        Moudy Ho <moudy.ho@mediatek.com>, roy-cw.yeh@mediatek.com,
        Fabien Parent <fparent@baylibre.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com,
        DTML <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=88=
26=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:59=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add mt8195 SoC binding to AAL, CCORR, COLOR, DITHER, GAMMA, MERGE,
> MUTEX, OVL and RDMA yaml schema for vdosys0.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml   | 1 +
>  .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml | 5 +++++
>  .../devicetree/bindings/display/mediatek/mediatek,color.yaml | 1 +
>  .../bindings/display/mediatek/mediatek,dither.yaml           | 1 +
>  .../devicetree/bindings/display/mediatek/mediatek,gamma.yaml | 1 +
>  .../devicetree/bindings/display/mediatek/mediatek,merge.yaml | 2 ++
>  .../devicetree/bindings/display/mediatek/mediatek,mutex.yaml | 5 +++--
>  .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml   | 5 +++++
>  .../devicetree/bindings/display/mediatek/mediatek,rdma.yaml  | 2 ++
>  9 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.=
yaml
> index 92a350ab9722..311bbf05a967 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yam=
l
> @@ -28,6 +28,7 @@ properties:
>                - mediatek,mt2712-disp-aal
>                - mediatek,mt8183-disp-aal
>                - mediatek,mt8192-disp-aal
> +              - mediatek,mt8195-disp-aal
>            - enum:
>                - mediatek,mt8173-disp-aal
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,cc=
orr.yaml
> index 7840e12d4caf..60752ce45d49 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.y=
aml
> @@ -25,6 +25,11 @@ properties:
>            - const: mediatek,mt8183-disp-ccorr
>        - items:
>            - const: mediatek,mt8192-disp-ccorr
> +      - items:
> +          - enum:
> +              - mediatek,mt8195-disp-ccorr
> +          - enum:
> +              - mediatek,mt8192-disp-ccorr
>
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,co=
lor.yaml
> index 7a249ba8584c..f6636869909c 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.y=
aml
> @@ -38,6 +38,7 @@ properties:
>            - enum:
>                - mediatek,mt8183-disp-color
>                - mediatek,mt8192-disp-color
> +              - mediatek,mt8195-disp-color
>            - enum:
>                - mediatek,mt8173-disp-color
>    reg:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,d=
ither.yaml
> index 316374315962..d4fa75bb19a3 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.=
yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.=
yaml
> @@ -27,6 +27,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8192-disp-dither
> +              - mediatek,mt8195-disp-dither
>            - enum:
>                - mediatek,mt8183-disp-dither
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ga=
mma.yaml
> index 1c53ce20a71e..8ce612b016ab 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.y=
aml
> @@ -28,6 +28,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8192-disp-gamma
> +              - mediatek,mt8195-disp-gamma
>            - enum:
>                - mediatek,mt8183-disp-gamma
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,me=
rge.yaml
> index 614721bdbf73..28be8ffeb429 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> @@ -23,6 +23,8 @@ properties:
>      oneOf:
>        - items:
>            - const: mediatek,mt8173-disp-merge
> +      - items:
> +          - const: mediatek,mt8195-disp-merge
>
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
mutex.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mu=
tex.yaml
> index 90f11e12a55e..6eca525eced0 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.y=
aml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/display/mediatek/mediatek,mutex.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
> -title: Mediatek display mutex
> +title: Mediatek mutex
>
>  maintainers:
>    - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> @@ -36,7 +36,8 @@ properties:
>            - const: mediatek,mt8183-disp-mutex
>        - items:
>            - const: mediatek,mt8192-disp-mutex
> -
> +      - items:
> +          - const: mediatek,mt8195-disp-mutex
>    reg:
>      maxItems: 1
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.=
yaml
> index 50552428150f..a6dbbd65166e 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yam=
l
> @@ -35,6 +35,11 @@ properties:
>                - mediatek,mt2712-disp-ovl
>            - enum:
>                - mediatek,mt2701-disp-ovl
> +      - items:
> +          - enum:
> +              - mediatek,mt8195-disp-ovl
> +          - enum:
> +              - mediatek,mt8183-disp-ovl
>
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdm=
a.yaml
> index 8393a25a3781..0dcde0749078 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.ya=
ml
> @@ -29,6 +29,8 @@ properties:
>            - const: mediatek,mt8173-disp-rdma
>        - items:
>            - const: mediatek,mt8183-disp-rdma
> +      - items:
> +          - const: mediatek,mt8195-disp-rdma
>        - items:
>            - enum:
>                - mediatek,mt7623-disp-rdma
> --
> 2.18.0
>
