Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD393C39C4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 03:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhGKBYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 21:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhGKBYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 21:24:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7155F6128B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 01:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625966516;
        bh=QhKIvsISN8hyL/+WZ9H4vzKMikWnonQ+QXSUoi2Lhuk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RR3JaOiFJePPWksG5U+Zyu0yWD9nxB08n8GeHdUngBmGLviYB3A8vVr44lR7JzzE2
         a7tSA3NLmAVboXmx3VGXz9cwAzFfbpzP38PqPzgSzSj4LHp+bW3EyXdRFNLCW8Dy2b
         oq/ALjaB70Hz3AfL46EqNBVPhiW8OMDcWJAqeHHBAYI9Y7qip2L3p7Ew1qQtA6iqQZ
         bPCUhEGEX6z+oIKVXDON7m0e5CiVug7zda5YWAJWcfLbuL8LwBpShOcWsVVZHDJf+J
         ZoZId1KqZ6QVyfE3nl6QWMl+3qSdswyGS3ivoBG27m/icpYwpCFn+jJIi3Zuf+sqho
         sLAshVw33zQoA==
Received: by mail-ej1-f46.google.com with SMTP id hc16so25067662ejc.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 18:21:56 -0700 (PDT)
X-Gm-Message-State: AOAM531fiO0KG+YsmMIzCAlYEc0dI5AV7FiYEhfgondjgZ0prwQZXDih
        BTXUiCHVa7dOYx+fDFIU5n3S+R1hVtXNwaRyWg==
X-Google-Smtp-Source: ABdhPJy89g97s6wTbgS+qttKFO6l2FwtdlkzBAGJwuMC27WthxsMpFpER+vqI3hYjY0vWhFLELnUOPXxck/pAyiT85Y=
X-Received: by 2002:a17:906:4745:: with SMTP id j5mr25862247ejs.75.1625966515074;
 Sat, 10 Jul 2021 18:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210710113819.5170-1-jason-jh.lin@mediatek.com> <20210710113819.5170-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20210710113819.5170-2-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 11 Jul 2021 09:21:44 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-FS_wWgyo7gZu_qPxqhNOQsp+q172Y=d=dttEi_LVT9Q@mail.gmail.com>
Message-ID: <CAAOTY_-FS_wWgyo7gZu_qPxqhNOQsp+q172Y=d=dttEi_LVT9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: mediatek: add definition for mt8195 display
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        fshao@google.com, Nancy Lin <nancy.lin@mediatek.com>,
        singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=881=
0=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=887:38=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add definition for mt8195 display.
>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,disp.txt          | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp=
.txt
> index fbb59c9ddda6..de6226d4bca3 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> @@ -37,6 +37,7 @@ Required properties (all function blocks):
>         "mediatek,<chip>-disp-aal"              - adaptive ambient light =
controller
>         "mediatek,<chip>-disp-gamma"            - gamma correction
>         "mediatek,<chip>-disp-merge"            - merge streams from two =
RDMA sources
> +       "mediatek,<chip>-disp-dsc"              - DSC controller, see med=
iatek,dsc.yaml

You add dsc binding document in yaml format, so I would like you to
change this binding document to yaml format.

Regards,
Chun-Kuang.

>         "mediatek,<chip>-disp-postmask"         - control round corner fo=
r display frame
>         "mediatek,<chip>-disp-split"            - split stream to two enc=
oders
>         "mediatek,<chip>-disp-ufoe"             - data compression engine
> @@ -44,7 +45,7 @@ Required properties (all function blocks):
>         "mediatek,<chip>-dpi"                   - DPI controller, see med=
iatek,dpi.txt
>         "mediatek,<chip>-disp-mutex"            - display mutex
>         "mediatek,<chip>-disp-od"               - overdrive
> -  the supported chips are mt2701, mt7623, mt2712, mt8167, mt8173, mt8183=
 and mt8192.
> +  the supported chips are mt2701, mt7623, mt2712, mt8167, mt8173, mt8183=
, mt8192 and mt8195.
>  - reg: Physical base address and length of the function block register s=
pace
>  - interrupts: The interrupt signal from the function block (required, ex=
cept for
>    merge and split function blocks).
> @@ -60,7 +61,7 @@ Required properties (DMA function blocks):
>         "mediatek,<chip>-disp-ovl"
>         "mediatek,<chip>-disp-rdma"
>         "mediatek,<chip>-disp-wdma"
> -  the supported chips are mt2701, mt8167 and mt8173.
> +  the supported chips are mt2701, mt8167, mt8173 and mt8195.
>  - larb: Should contain a phandle pointing to the local arbiter device as=
 defined
>    in Documentation/devicetree/bindings/memory-controllers/mediatek,smi-l=
arb.yaml
>  - iommus: Should point to the respective IOMMU block with master port as
> @@ -217,3 +218,7 @@ od@14023000 {
>         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM>;
>         clocks =3D <&mmsys CLK_MM_DISP_OD>;
>  };
> +
> +dsc0: disp_dsc_wrap@1c009000 {
> +       /* See mediatek,dsc.yaml for details */
> +};
> --
> 2.18.0
>
