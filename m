Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483F932C498
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446374AbhCDAPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353534AbhCDAE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:04:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCAE564F40;
        Wed,  3 Mar 2021 23:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614815502;
        bh=4yS5iyJsfhsmr+JcD2q/iH0huGBVo0X7ndYyoZeb90s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wcwfy2oLdCegFM+NSj5hIFVc7IO8f2MbMGQGKYiV4XONi62oteEtvl+UFt7TgUooX
         xiruDUU4P/IxGiiuoopVydls3hf2BifOFr2bt8yvypmBGYvhHvLEn6m6Ktj44nFMRj
         7ZOo6u6VD2EG9ooX02rLJ3SYXMg7kraYH/js/b7pXTTCo4o4Q8l5NPm7DhpBExYjrN
         IyFDCuHCiNN3XddxFZxvFnaBHSFfJyOjNp6dYsuCwvMxp3zL8ky0CqyQAa5uqaF/ls
         ST/IYm6MOPIVvf4xZ9X8MfzmxAy6Y0APTx5JZhlHvEuFTk+wD8xY8ix3gm1zdHZEsT
         gR9zYjPEVUKgQ==
Received: by mail-ej1-f52.google.com with SMTP id hs11so45783049ejc.1;
        Wed, 03 Mar 2021 15:51:41 -0800 (PST)
X-Gm-Message-State: AOAM530Zr9Z+Pb8gehO52d9gfzM1armEbh0yO0Ca2acbmJ379XmihWdw
        TzeAvUDvE2H78312cNB92m8OhujwmxHLpy2k+g==
X-Google-Smtp-Source: ABdhPJxjTF125VBav37vNTxcoNrEEtc96QdczKSVNaMWeC6x43SJnAkfM2Ubk2nF5FkmmMzIcHZNXpwWfscGCx+RprI=
X-Received: by 2002:a17:906:a106:: with SMTP id t6mr1209918ejy.63.1614815500452;
 Wed, 03 Mar 2021 15:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20210223215057.125708-1-robh@kernel.org>
In-Reply-To: <20210223215057.125708-1-robh@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 4 Mar 2021 07:51:29 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-x2RTU9c0=ibRdiO8-o8F0GU0DNa5UDSeKsmboSJfHDw@mail.gmail.com>
Message-ID: <CAAOTY_-x2RTU9c0=ibRdiO8-o8F0GU0DNa5UDSeKsmboSJfHDw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: mediatek,dpi: Convert to use graph schema
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob:

Rob Herring <robh@kernel.org> =E6=96=BC 2021=E5=B9=B42=E6=9C=8824=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Update the mediatek,dpi binding to use the graph schema. Missed
> this one from the mass conversion since it's not part of drm-misc.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: CK Hu <ck.hu@mediatek.com>
> Cc: Jitao shi <jitao.shi@mediatek.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.yaml       | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.=
yaml
> index 6cdb734c91a9..eb84b53cabb1 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> @@ -50,15 +50,10 @@ properties:
>        - const: sleep
>
>    port:
> -    type: object
> +    $ref: /schemas/graph.yaml#/properties/port
>      description:
> -      Output port node with endpoint definitions as described in
> -      Documentation/devicetree/bindings/graph.txt. This port should be c=
onnected
> -      to the input port of an attached HDMI or LVDS encoder chip.
> -
> -    properties:
> -      endpoint:
> -        type: object
> +      Output port node. This port should be connected to the input port =
of an
> +      attached HDMI or LVDS encoder chip.
>
>  required:
>    - compatible
> --
> 2.27.0
>
