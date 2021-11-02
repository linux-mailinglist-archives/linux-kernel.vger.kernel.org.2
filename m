Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED914438CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhKBW5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhKBW5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:57:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7648561105;
        Tue,  2 Nov 2021 22:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635893667;
        bh=vZAm7ovxBi6d/ZH+uziWTG6NBTualBYKsCvLvL3Gx7g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=opY/abwJOWe66VHhwlVSS287YA1M9yULIi5wQIYoJ96jO4hPky0vB6vi6tafilMD7
         rFkhmoLtQ0JjoO8LGuoGLus6tF2fIduGVRZrrxl51/4nWYnKX6dKCQmBd2uSI9wlMD
         UO1XahuUVS5GKl3M0Aq9gJC4BEv6fCqD0q/CztW5e7meAcaEELHE3R2JXtckUw0jPy
         z9VAQruKylB+jiZA16OORnFfBMF6rFzu7wr/0EvG1Cg0KZUTyId6/tOrFKoGJf1Uai
         AP8H78hxGwQ6Ru8B4/CqaU93n8Gf4J+XTNIO9nFkSdgPnmTW9hS6RjiTF0OsrhHByR
         HNvU7DC6mlsLg==
Received: by mail-ed1-f45.google.com with SMTP id z20so2592137edc.13;
        Tue, 02 Nov 2021 15:54:27 -0700 (PDT)
X-Gm-Message-State: AOAM530YFzKW8liIBqYhqi1MWaZoZkmyk8Kfl2QuOBbC127wjqbZrplX
        1xxztsa92j/GRSWWDUnADlqIYlY2PRj2/U0L9Q==
X-Google-Smtp-Source: ABdhPJwvOPkHrOahXa3xj/c9OSX7wBr+wcK0xwNgYPaLagkYmgf2JQOlOc1GXKmuNsno2PWPju9ZZUGHXtyfOv39J7g=
X-Received: by 2002:a17:907:2ce1:: with SMTP id hz1mr49090047ejc.241.1635893665770;
 Tue, 02 Nov 2021 15:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211026155911.17651-1-jason-jh.lin@mediatek.com> <20211026155911.17651-6-jason-jh.lin@mediatek.com>
In-Reply-To: <20211026155911.17651-6-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 3 Nov 2021 06:54:14 +0800
X-Gmail-Original-Message-ID: <CAAOTY__cyFB6VyKFUZsy+-9+Nz7QTR4QiGUXQApOdiFXQESi4g@mail.gmail.com>
Message-ID: <CAAOTY__cyFB6VyKFUZsy+-9+Nz7QTR4QiGUXQApOdiFXQESi4g@mail.gmail.com>
Subject: Re: [PATCH v12 05/16] dt-bindings: display: mediatek: merge: add
 additional prop for mt8195
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
> add MERGE additional properties description for mt8195:
> 1. async clock
> 2. fifo setting enable
> 3. reset controller

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  .../display/mediatek/mediatek,merge.yaml      | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,me=
rge.yaml
> index 75beeb207ceb..614721bdbf73 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> @@ -36,8 +36,28 @@ properties:
>        Documentation/devicetree/bindings/power/power-domain.yaml for deta=
ils.
>
>    clocks:
> +    maxItems: 2
>      items:
>        - description: MERGE Clock
> +      - description: MERGE Async Clock
> +          Controlling the synchronous process between MERGE and other di=
splay
> +          function blocks cross clock domain.
> +
> +  clock-names:
> +    maxItems: 2
> +    items:
> +      - const: merge
> +      - const: merge_async
> +
> +  mediatek,merge-fifo-en:
> +    description:
> +      The setting of merge fifo is mainly provided for the display laten=
cy
> +      buffer to ensure that the back-end panel display data will not be
> +      underrun, a little more data is needed in the fifo.
> +      According to the merge fifo settings, when the water level is dete=
cted
> +      to be insufficient, it will trigger RDMA sending ultra and preulra
> +      command to SMI to speed up the data rate.
> +    type: boolean
>
>    mediatek,gce-client-reg:
>      description:
> @@ -50,6 +70,11 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      maxItems: 1
>
> +  resets:
> +    description: reset controller
> +      See Documentation/devicetree/bindings/reset/reset.txt for details.
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -67,3 +92,16 @@ examples:
>          power-domains =3D <&spm MT8173_POWER_DOMAIN_MM>;
>          clocks =3D <&mmsys CLK_MM_DISP_MERGE>;
>      };
> +
> +    merge5: disp_vpp_merge5@1c110000 {
> +        compatible =3D "mediatek,mt8195-disp-merge";
> +        reg =3D <0 0x1c110000 0 0x1000>;
> +        interrupts =3D <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH 0>;
> +        clocks =3D <&vdosys1 CLK_VDO1_VPP_MERGE4>,
> +                 <&vdosys1 CLK_VDO1_MERGE4_DL_ASYNC>;
> +        clock-names =3D "merge","merge_async";
> +        power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> +        mediatek,gce-client-reg =3D <&gce1 SUBSYS_1c11XXXX 0x0000 0x1000=
>;
> +        mediatek,merge-fifo-en =3D <1>;
> +        resets =3D <&vdosys1 MT8195_VDOSYS1_SW0_RST_B_MERGE4_DL_ASYNC>;
> +    };
> --
> 2.18.0
>
