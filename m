Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFB435E9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 01:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346069AbhDMXis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 19:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbhDMXiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 19:38:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E262961220;
        Tue, 13 Apr 2021 23:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618357105;
        bh=i/SPq4DqaHJFgtAIJjeY4ErFuPgoVxrSMsgumddGdOI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p/ZkOYkP5byOWa0qOE2JGfTFVH4PM71iq5H5DAGzh3a/Y86liNh2DTfR8OzjueNDq
         z3ZWn5liyA3bOxSjxEHvNW1zI8oSxHSfSLNV2fiLUS42jmWFp463oIJDoqAh2ivZxv
         z9WTnWahgYPlhgMfCY5SMvZcsvLgXD4LY1cpavmTMLZRHwK1m6nUNvvVjIx/DgNTAG
         g//TbWfruhbfeo8Y0QVzGnORKzorJSXS0DOJt41LmuCgelTaZY6mD2qyXonqkdfu7Y
         Xq6CxiwVSSUK0VEBHip4UA6y9XuCFEbKO1rfb+g9lyVerw7aaRGOr0HGHbDGz8qbRu
         DU2bE5voEV6Xg==
Received: by mail-ej1-f47.google.com with SMTP id mh2so7010851ejb.8;
        Tue, 13 Apr 2021 16:38:25 -0700 (PDT)
X-Gm-Message-State: AOAM530JAbJK2Dw42tKXmW8I2E1Fi1t4t7uHSY+0QyTTe9u5XSjTLkY5
        IgDHArosbaMJdAHrZL65mpccqRNNIcCBrhS/cw==
X-Google-Smtp-Source: ABdhPJzpH5eOS77fuaMMC1TeLT9DWDR87PI5sxoQLhq7SEPIPoVBozS6J7PZv1i/qiEEVXTWa8fAM544xi4x8RQkXWM=
X-Received: by 2002:a17:906:b01:: with SMTP id u1mr8479963ejg.310.1618357104520;
 Tue, 13 Apr 2021 16:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <1618226325-31927-1-git-send-email-yongqiang.niu@mediatek.com> <1618226325-31927-4-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1618226325-31927-4-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 14 Apr 2021 07:38:13 +0800
X-Gmail-Original-Message-ID: <CAAOTY__zcdjA-tu4kNtWjy=37_HZV1U2fS6=k4OBAbjfNwC9Ow@mail.gmail.com>
Message-ID: <CAAOTY__zcdjA-tu4kNtWjy=37_HZV1U2fS6=k4OBAbjfNwC9Ow@mail.gmail.com>
Subject: Re: [PATCH v2, 3/5] Revert "dt-bindings: mailbox: mtk-gce: fix
 incorrect mbox-cells value"
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B44=E6=9C=
=8812=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:19=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This reverts commit f83b03fc727ab56a77e68713d6e40299698f3c9f.
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Docu=
mentation/devicetree/bindings/mailbox/mtk-gce.txt
> index 7771eca..cf48cd8 100644
> --- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> @@ -47,7 +47,7 @@ Example:
>                 interrupts =3D <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
>                 clocks =3D <&infracfg CLK_INFRA_GCE>;
>                 clock-names =3D "gce";
> -               #mbox-cells =3D <2>;
> +               #mbox-cells =3D <3>;

I think we should not change the binding just to fix software bug.
I think there are many temporary solution to fix drm bug. If drm bug
is caused by cursor plane, you could temporarily let drm not support
cursor plane to fix it (in [1], do not return DRM_PLANE_TYPE_CURSOR).
But I would like you to find out the correct solution rather than a
temporary solution because this bug is not so urgent. (For me, bug of
build fail, boot fail, black screen is urgent).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/gpu/drm/mediatek/mtk_drm_crtc.c?h=3Dv5.12-rc7#n699

Regards,
Chun-Kuang.

>         };
>
>  Example for a client device:
> --
> 1.8.1.1.dirty
>
