Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C193D393D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhGWKd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbhGWKdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:33:25 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D38C061575;
        Fri, 23 Jul 2021 04:13:59 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 13-20020a4ae1ad0000b029024b19a4d98eso299403ooy.5;
        Fri, 23 Jul 2021 04:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Nwk9qPAQEz7a/8yg7VWdxwdIwFtkYHBh+612HjXFR8=;
        b=ed8KUGsfCqWAQcQfBhF88Y9OVbMf4kku9i0iSmPQyK4UKJA8IW5SwF4EiYlGu5gvXZ
         9zOtQB+o4iAK73tSfN3TlCHiB0dOF9wOXyxpoQ3Hk3aw/Iwif3d9xeq0OWQ06Mo0P9Vk
         5d//f/EJQcO/kNZCkh/zg9Z6DEE9RnSunxT6W/jy9Fa9XF/EaGVTWFs1uda5bTvuHhhm
         pCjHFdJfBbdSyBt2DY/Cv5PKRLsF6cHoKCJe7/sxvC7sZlEHwS016uiJb36x3RQoTKc5
         lL1D5HjuBEmQXMoBhVXoTfAg09+M0tKn2jLDax6QxhSO7OiFYp7fSUwUFTJAKhCi3dc2
         R8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Nwk9qPAQEz7a/8yg7VWdxwdIwFtkYHBh+612HjXFR8=;
        b=PF1/VJJVsBPEUJ6kacyHebTrufyppYTAlUCcn7exvZezFEKNdP4DXmKtkYOQXQOY4o
         fXbXAbpHWOBI+dcru3bDzKIK4UFfS/XqfMKbwLt1/iL3nHQ0Dv5QAS76xbkc45ZquNXt
         ekSiwkshk0Vjk0ugqa8uwwIczIq4q9E051DTZ5eZ9WCCR6AZ29MsK8mBEf/VULDAiBcH
         YEWKA1LQH9fwSFQlGv3C+ztwLHWGINOXAKvKjYGSgryi+pvlbZSZfkRK40vNZp4uZluW
         7yjdD9evD3PbOesvepAuSLQKJvUcSfAQ167O8OZ7i0g9Zbdj01noSCPO6x3i2/1cvOK1
         trPg==
X-Gm-Message-State: AOAM532e1UcED3HgpUYAJfVh2bh5o5ZqyqrvFECcMMpVZrbAj1E8Vmi+
        PImLjwGhlXxk7PnBa/7S+uQGuHddGQVFz/C5G9U=
X-Google-Smtp-Source: ABdhPJzNCCp8fTtO0kzSFLOUM+lawDoT2CfKUL3Rr/JKyIfNM4DwmUjfKyJ5eSEbSZzASHckgWxaWjAwJmhGfdvT0m0=
X-Received: by 2002:a05:6820:444:: with SMTP id p4mr2336576oou.75.1627038838422;
 Fri, 23 Jul 2021 04:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210722092624.14401-1-jason-jh.lin@mediatek.com> <20210722092624.14401-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20210722092624.14401-2-jason-jh.lin@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 23 Jul 2021 13:13:46 +0200
Message-ID: <CAFqH_51qKkxMit5fkSh_AyeNAYwKnoPe09nwJLKaKez26+HUew@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: arm: mediatek: mmsys: add mt8195 SoC binding
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Jitao shi <jitao.shi@mediatek.com>, fshao@chromium.org,
        David Airlie <airlied@linux.ie>, singo.chang@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Fabien Parent <fparent@baylibre.com>,
        "Nancy.Lin" <nancy.lin@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Thank you for your patch.

Missatge de jason-jh.lin <jason-jh.lin@mediatek.com> del dia dj., 22
de jul. 2021 a les 11:26:
>
> There are 2 display hardware path in mt8195, namely vdosys0 and
> vdosys1, so add their definition in mtk-mmsys documentation.
>

Just having 2 display hardware paths is not a reason to have two
compatibles, isn't the IP block the same? Why do you need to introduce
the two compatibles?

Thanks,
  Enric

> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
> this patch is base on [1][2]
>
> [1] dt-bindings: arm: mediatek: mmsys: convert to YAML format
> - https://patchwork.kernel.org/project/linux-mediatek/patch/20210519161847.3747352-1-fparent@baylibre.com/
> [2] dt-bindings: arm: mediatek: mmsys: add MT8365 SoC binding
> - https://patchwork.kernel.org/project/linux-mediatek/patch/20210519161847.3747352-2-fparent@baylibre.com/
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 2d4ff0ce387b..0789a9614f12 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -30,6 +30,8 @@ properties:
>                - mediatek,mt8173-mmsys
>                - mediatek,mt8183-mmsys
>                - mediatek,mt8365-mmsys
> +              - mediatek,mt8195-vdosys0
> +              - mediatek,mt8195-vdosys1
>            - const: syscon
>        - items:
>            - const: mediatek,mt7623-mmsys
> --
> 2.18.0
>
