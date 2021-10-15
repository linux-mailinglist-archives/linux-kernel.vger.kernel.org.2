Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A042F806
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241257AbhJOQXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241253AbhJOQXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:23:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C699611CE;
        Fri, 15 Oct 2021 16:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634314885;
        bh=z0VMHYGv4k9YfLpE9FUSGVn3TrO3Twply7c7zgpVmYM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J6WxXOGI05KDKCcMlAcj6PkNDAZRgenVWkTidMhwoD3JNTz/4l51EERh5Ql1ZSJpj
         BbHXZvif3Y2gIy8npj+nEwwpC4iH9jXA+7X6nBWvHtWo3FA5Re2BU3Gw+OHqxb4Ihu
         MjbChxxUI5SnJkj8X4h78uz8Lan/JnmbKUTSNM65fO6nU8rNG1Vmeu/QJoYZQgVcMb
         CexyF34RQoOQiSJuK+q00/JxapoJ3X9lV7FBcS/BSlxwEHkvP94K0v/4b4Gj5lX88F
         siBr2i5g4cd21v++Pfceo+bb/ofBufDtCzga5cQiXB7M1Eb29Rm1529svUV4SJ0X3H
         wr9CZNQCkOeaQ==
Received: by mail-ed1-f47.google.com with SMTP id ec8so40344501edb.6;
        Fri, 15 Oct 2021 09:21:25 -0700 (PDT)
X-Gm-Message-State: AOAM530R9OC/qoLzLGu22XuvXZD4XODSuZx6Jfx8Od2zje/a34LjvOgJ
        aHSzIS4uL/SZ8wBMwu/Qk/9Yugu2gYLtzi2dcQ==
X-Google-Smtp-Source: ABdhPJx6achLWZwzx6ovEoDXmzSv+wCsdnSRUuajZYLhkxDFusi9eOjTSSXm7nZir+rTOgxfNjDkLV4a3hqmrLpqCmU=
X-Received: by 2002:a50:ef10:: with SMTP id m16mr15859060eds.224.1634314883576;
 Fri, 15 Oct 2021 09:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211004062140.29803-1-nancy.lin@mediatek.com> <20211004062140.29803-3-nancy.lin@mediatek.com>
In-Reply-To: <20211004062140.29803-3-nancy.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 16 Oct 2021 00:21:12 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-3KBXyBvMW8zC1fukkDFGczcP6t+CjRbvGh6uQtOSnTA@mail.gmail.com>
Message-ID: <CAAOTY_-3KBXyBvMW8zC1fukkDFGczcP6t+CjRbvGh6uQtOSnTA@mail.gmail.com>
Subject: Re: [PATCH v6 02/16] dt-bindings: mediatek: add vdosys1 MERGE
 property for mt8195
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

Nancy.Lin <nancy.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=884=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=882:21=E5=AF=AB=E9=81=93=EF=BC=9A
>
> MT8195 vdosys1 merge1 to merge4 have HW mute function.
> Add MERGE additional mute property description.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,merge.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,me=
rge.yaml
> index 6007e00679a8..d7d0eda813d1 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> @@ -54,6 +54,10 @@ properties:
>        command to SMI to speed up the data rate.
>      type: boolean
>
> +  mediatek,merge-mute:
> +    description: Support mute function. Mute the content of merge output=
.
> +    type: boolean
> +
>    mediatek,gce-client-reg:
>      description:
>        The register of client driver can be configured by gce with 4 argu=
ments
> --
> 2.18.0
>
