Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3C13E4730
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhHIOGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234105AbhHIOGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:06:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F157F61075;
        Mon,  9 Aug 2021 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628517974;
        bh=KK7jjN23raVktev4HSd9TJQBS5GWAZQ4yGJxFG4+9Iw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gapdlvZdDjM7nAfH4De8Tp/fNVqYGRPOQEEDAY22tpQ28YQ4Eq25cjIIjIYJrFIIA
         WamRLl1S+d5Aa8qWLS99G+z8dOw6HF6CQr9QYeAvG6DfVqJa6PJXFvZOQsm/DkSGrT
         tbWkn5d7HcrbV7kFOjsKNzrVp+i585sPACJwPR6+I6DCZOg4Rk2YFJo/WglPyJZ7n/
         qoJkv+OhhUr1xOlRl7pcDyF0eETDB4ffepz6EAo/IGgeVWwJyXVyp9DigqrF8nUKMz
         Es2UKL0Tspm5pOLOHra4Yb34pPy+QIGnKPadslbyGqJ3FtoJC/jUe0RfLpJ7LuuwrB
         PemyGUyWCi41g==
Received: by mail-ed1-f48.google.com with SMTP id y7so24761185eda.5;
        Mon, 09 Aug 2021 07:06:13 -0700 (PDT)
X-Gm-Message-State: AOAM5312pWHNC0lt0yjOiY4h4DhOakl+di/4TNCw1/YRYAZb77PdZajc
        gI1yyfnN09HXWyEEcYhdOEDmk/2SeOK4FsN1Ow==
X-Google-Smtp-Source: ABdhPJy8JViocynBWXM9L3xsiyYJiSRcSybIkGik7L3z/aNO5GB4LmezUH2JyaLyyG+6uSQVvQ4XXt4q4R0gt+0l8RM=
X-Received: by 2002:a05:6402:718:: with SMTP id w24mr29623490edx.49.1628517972496;
 Mon, 09 Aug 2021 07:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201023133130.194140-1-fparent@baylibre.com> <20201023133130.194140-3-fparent@baylibre.com>
In-Reply-To: <20201023133130.194140-3-fparent@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 9 Aug 2021 22:06:01 +0800
X-Gmail-Original-Message-ID: <CAAOTY__-E19JJiw=0X=Kdm9afWSTCeoYFKJAVJObrikfhV=BVA@mail.gmail.com>
Message-ID: <CAAOTY__-E19JJiw=0X=Kdm9afWSTCeoYFKJAVJObrikfhV=BVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: display: mediatek: dsi: add
 documentation for MT8167 SoC
To:     Fabien Parent <fparent@baylibre.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fabien:

Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8823=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:31=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Add binding documentation for the MT8167 SoC.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>
> Changelog:
>
> V2: removed part that added a new clock
>
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt     | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.t=
xt
> index f06f24d405a5..6a10de812158 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> @@ -7,7 +7,7 @@ channel output.
>
>  Required properties:
>  - compatible: "mediatek,<chip>-dsi"
> -- the supported chips are mt2701, mt7623, mt8173 and mt8183.
> +- the supported chips are mt2701, mt7623, mt8167, mt8173 and mt8183.
>  - reg: Physical base address and length of the controller's registers
>  - interrupts: The interrupt signal from the function block.
>  - clocks: device clocks
> @@ -26,7 +26,7 @@ The MIPI TX configuration module controls the MIPI D-PH=
Y.
>
>  Required properties:
>  - compatible: "mediatek,<chip>-mipi-tx"
> -- the supported chips are mt2701, 7623, mt8173 and mt8183.
> +- the supported chips are mt2701, 7623, mt8167, mt8173 and mt8183.
>  - reg: Physical base address and length of the controller's registers
>  - clocks: PLL reference clock
>  - clock-output-names: name of the output clock line to the DSI encoder
> --
> 2.28.0
>
