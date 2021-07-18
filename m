Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AD33CCB8E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 01:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhGRXZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 19:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:32890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231846AbhGRXZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 19:25:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7A7061166;
        Sun, 18 Jul 2021 23:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626650576;
        bh=+cIz9IsxTWX0flU1vqzo73L/SPqQutS6FLX3yWrvH3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=byKOgNCkjolptKZ8o4CD5FZBcRQ66Zn6YY6qX6/BlieuaheftSXku3KUimj07pzTB
         SLqyZ4X/+BGySRyq/eQfKJ4SqH5zlC23/VZQJQ3fVM7Jwv9imG53OIhZeTn0ubpFNc
         1utIgSgZ2Xf+yaSC5uCFz2t2K96DR5cvDP/nBWkp6cx8zVEm/00vl47M7j5d4wnDR3
         vOExrMrFKqfnKtqOStC9N/6uQ9dYPIBLOLssRuX+YJaYXH2yXlLnpj+773iajx0gNd
         dlYIqv2R8RXkiVtzueGVwC7MJZS2G+iX4Jt0b5KZcimPGnV/CsxFUeFa3XvWVaVLdb
         Jtt5mFre8vCmg==
Received: by mail-ed1-f52.google.com with SMTP id v1so21243941edt.6;
        Sun, 18 Jul 2021 16:22:56 -0700 (PDT)
X-Gm-Message-State: AOAM532X6lIBOVR7MNbP2LFUhWcSkG5q3TihJ85cbmulF2YoDcb7Ip8N
        fUyCS8KUYplvsRspm+pIHPc/1IrhF+jSUID3UA==
X-Google-Smtp-Source: ABdhPJyLbPQ/bSD5SySNlFUyRdfpkbfYqeHvj8he8EYh2p/ltsGUUyHfnDaoFoD6KhiI5AJDHucNK93+SxE1G7YueM4=
X-Received: by 2002:aa7:d353:: with SMTP id m19mr31865120edr.162.1626650575251;
 Sun, 18 Jul 2021 16:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210717090408.28283-1-nancy.lin@mediatek.com> <20210717090408.28283-2-nancy.lin@mediatek.com>
In-Reply-To: <20210717090408.28283-2-nancy.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 19 Jul 2021 07:22:43 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9h9wHNKfd0X3pbdEs6nfHm2cwQJrh3isAi0_etf9JD5w@mail.gmail.com>
Message-ID: <CAAOTY_9h9wHNKfd0X3pbdEs6nfHm2cwQJrh3isAi0_etf9JD5w@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] dt-bindings: mediatek: add pseudo-ovl definition
 for mt8195
To:     "Nancy.Lin" <nancy.lin@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        singo.chang@mediatek.com,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nancy:

Nancy.Lin <nancy.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=885:04=E5=AF=AB=E9=81=93=EF=BC=9A
>
> 1. Add pseudo-ovl definition file for mt8195 display.
> 2. Add mediatek,pseudo-ovl.yaml to decribe pseudo-ovl module in details.
>
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> ---
>  .../display/mediatek/mediatek,disp.yaml       |   5 +
>  .../display/mediatek/mediatek,pseudo-ovl.yaml | 105 ++++++++++++++++++
>  2 files changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,pseudo-ovl.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
disp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dis=
p.yaml
> index aac1796e3f6b..bb6d28572b48 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.ya=
ml
> @@ -230,6 +230,11 @@ properties:
>        - items:
>            - const: mediatek,mt8173-disp-od
>
> +      # PSEUDO-OVL: see Documentation/devicetree/bindings/display/mediat=
ek/mediatek,pseudo-ovl.yaml
> +      # for details.
> +      - items:
> +          - const: mediatek,mt8195-disp-pseudo-ovl
> +
>    reg:
>      description: Physical base address and length of the function block =
register space.
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
pseudo-ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediat=
ek,pseudo-ovl.yaml
> new file mode 100644
> index 000000000000..9059d96ce70e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,pseudo-=
ovl.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,pseudo-ovl.=
yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: mediatek pseudo ovl Device Tree Bindings
> +
> +maintainers:
> +  - CK Hu <ck.hu@mediatek.com>
> +  - Nancy.Lin <nancy.lin@mediatek.com>
> +
> +description: |
> +  The Mediatek pseudo ovl function block is composed of eight RDMA and
> +  four MERGE devices. It's encapsulated as an overlay device, which supp=
orts
> +  4 layers.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      # pseudo ovl controller
> +      - items:
> +          - const: mediatek,mt8195-disp-pseudo-ovl
> +      # RDMA: read DMA
> +      - items:
> +          - const: mediatek,mt8195-vdo1-rdma
> +      # MERGE: merge streams from two RDMA sources
> +      - items:
> +          - const: mediatek,mt8195-vdo1-merge
> +  reg:
> +    maxItems: 1
> +  interrupts:
> +    maxItems: 1
> +  iommus:
> +    description: The compatible property is DMA function blocks.
> +      Should point to the respective IOMMU block with master port as arg=
ument,
> +      see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml fo=
r
> +      details.
> +    maxItems: 1
> +  clocks:
> +    maxItems: 2
> +  clock-names:
> +    maxItems: 2
> +  power-domains:
> +    maxItems: 1
> +  mediatek,gce-client-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: The register of display function block to be set by gce=
.
> +      There are 4 arguments in this property, gce node, subsys id, offse=
t and
> +      register size. The subsys id is defined in the gce header of each =
chips
> +      include/include/dt-bindings/gce/<chip>-gce.h, mapping to the regis=
ter of
> +      display function block.
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const:
> +              - mediatek,mt8195-vdo1-merge
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: merge clock
> +            - description: merge async clock
> +        clock-names:
> +          items:
> +            - const: merge
> +            - const: merge_async
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    vdo1_rdma@1c104000 {
> +            compatible =3D "mediatek,mt8195-vdo1-rdma",
> +                         "mediatek,mt8195-disp-pseudo-ovl";

Do not create pseudo or virtual device, so just leave the
"mediatek,mt8195-vdo1-rdma".

Regards,
Chun-Kuang.

> +            reg =3D <0 0x1c104000 0 0x1000>;
> +            interrupts =3D <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH 0>;
> +            clocks =3D <&vdosys1 CLK_VDO1_MDP_RDMA0>;
> +            power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> +            iommus =3D <&iommu_vdo M4U_PORT_L2_MDP_RDMA0>;
> +            mediatek,gce-client-reg =3D <&gce1 SUBSYS_1c10XXXX 0x4000 0x=
1000>;
> +    };
> +
> +    disp_vpp_merge@1c10c000 {
> +            compatible =3D "mediatek,mt8195-vdo1-merge";
> +            reg =3D <0 0x1c10c000 0 0x1000>;
> +            interrupts =3D <GIC_SPI 503 IRQ_TYPE_LEVEL_HIGH 0>;
> +            clocks =3D <&vdosys1 CLK_VDO1_VPP_MERGE0>,
> +                     <&vdosys1 CLK_VDO1_MERGE0_DL_ASYNC>;
> +            clock-names =3D "merge","merge_async";
> +            power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> +            mediatek,gce-client-reg =3D <&gce1 SUBSYS_1c10XXXX 0xc000 0x=
1000>;
> +    };
> +
> +...
> --
> 2.18.0
>
