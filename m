Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9F5314498
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhBIAJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:09:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhBIAJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:09:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6DEF64EB8;
        Tue,  9 Feb 2021 00:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612829337;
        bh=BIx3eGSYs9bP+3OswyB3XhNzfUFRBY2kgxghItTuskE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=opBunexJL58nGbpC8oGnOZvEL9CH7dTCEutJETDFyqqk8OqRVYhu33yw1KZEUz5cX
         KhDYoY2040yNEc0HU9kiCkCl6pD7nbK+Y1eZEEVcKgb247l/JesoZILG9qOD83FPOR
         ZYXEQyfsA/lX1sS09fsOniXXt/ksqBH/3QJQxosF45ncce1mgg3FcdoDvBHS5ZB/J/
         f6QCfLr+ywhCiwahmEA1elvZKxNlt/DD4CDe5Km9BcBXLyoEykuY+/nlWKjeY+60NM
         U8KcjKlY9oOb2C6noew90FZvJffP2yv2esgMZInXOcUiZeVoJ7LjGMBlHwYjmBU7Tg
         jCrOFvl3PHVXA==
Received: by mail-ej1-f47.google.com with SMTP id l25so11250273eja.9;
        Mon, 08 Feb 2021 16:08:56 -0800 (PST)
X-Gm-Message-State: AOAM533aV8O2DGe6gvhnjOJTO/ItGcs1UAVjlGvgscVXzFGl/7xMuCLR
        iRstwjMV8lI6jO/433pGBVsWOL7ujFxuOMQ8UQ==
X-Google-Smtp-Source: ABdhPJzpLqbujyvxL39zTOTeUscDS/tYzRbxuOzriw8VhEGNKVWX8nbXtvNGzdKFO2JaeBLgzu8Et0m/dH+2P6MVock=
X-Received: by 2002:a17:906:708f:: with SMTP id b15mr19813910ejk.267.1612829335422;
 Mon, 08 Feb 2021 16:08:55 -0800 (PST)
MIME-Version: 1.0
References: <20210208014221.196584-1-jitao.shi@mediatek.com> <20210208014221.196584-4-jitao.shi@mediatek.com>
In-Reply-To: <20210208014221.196584-4-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 9 Feb 2021 08:08:44 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-WZRUgSBNTe2-Xu1+pkK2RAEScacYZTcHkSUuqXDU5Mg@mail.gmail.com>
Message-ID: <CAAOTY_-WZRUgSBNTe2-Xu1+pkK2RAEScacYZTcHkSUuqXDU5Mg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: mediatek,dpi: add mt8192 to mediatek,dpi
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        CK Hu <ck.hu@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>, stonea168@163.com,
        huijuan.xie@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, shuijing.li@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2021=E5=B9=B42=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=889:42=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add compatible "mediatek,mt8192-dpi" for the mt8192 dpi.
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml       | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.=
yaml
> index 6cdb734c91a9..2f566f19e6e0 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> @@ -22,6 +22,7 @@ properties:
>        - mediatek,mt7623-dpi
>        - mediatek,mt8173-dpi
>        - mediatek,mt8183-dpi
> +      - mediatek,mt8192-dpi
>
>    reg:
>      maxItems: 1
> --
> 2.25.1
