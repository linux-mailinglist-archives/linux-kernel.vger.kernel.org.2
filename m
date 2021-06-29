Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE1C3B74E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhF2PML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhF2PMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:12:07 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953CAC061767
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:09:40 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id x37so4037957uac.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuyBMZGhtBgcRJwd1A74SaR7qMVubxg4OKYSD7bf0Rg=;
        b=TGHWWV8kcyBivyZX88cWdYDh6ISxpSSnB+a3I2IZObT877GfF5myGHJDavSsywsD/+
         HRNudBk1MUSh5BxtRJ1ScnfRqOaOuhXBHdXG62OzrMB44GRE6P1JiknjAtVrJ4pZdj/i
         U5pXLro/rLS+ZY7yTlGCYle3qxXqCC9tPc4MXrPuipukj2QsFk68V37sCwZSf2hn+0J1
         aKCbqF+sjF004LTaqivSO4eR3lo+h9VcydpASTFhp0b+bOVi84Wsx33m1aSAIudIK1xx
         2rBMCcA0SsSfBjmlNB2BC67QUKQpheGAtnghLDKEJdOOrsg/Qq9BeURftGLO1HzvYeTT
         eBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuyBMZGhtBgcRJwd1A74SaR7qMVubxg4OKYSD7bf0Rg=;
        b=KtXZ7HmTLiYVZUD0McsCFT2s3kCFrIbUd/7ZnT0AheSkjW7ddTgKLTc107DBbW/jQt
         J+Qde9LatWGv6vvVF3M/WydRe51ZMG95VRNNpC3jWoO+O8fTObeukGb0qHfhwyQtA/au
         niGslI6v4DNe7OEY0iXOPCH31dH8p3L9zj34EkIlLP1Bcij1hhrWjoUNBFlrNafW6wxG
         H4TWJxxmeLW7J/x5hblZDPWV6X1DZK0mh/bv8JK8kF1iGDeKLaJLjyf4fSXPdOH7RO5e
         qRx69jaZh0rqQPJ5KWguafiNqf/qj6Om57NzzMb55VHOYxRmAtewAr2pZM82BjUPCH51
         nMeA==
X-Gm-Message-State: AOAM533TQWaKN2yV0pYEcpsMxUm/Za4N7wFgwb2x+zwwuytc4ZzUH1pa
        D0sQMaT7+jPqoAX65CshfxRNYGVEWrL6JD/U4tRJEg==
X-Google-Smtp-Source: ABdhPJzVIVyqLzXURZxn0TF1D1Ma0QIbM2IQTwNlaEsIhbBauCsjME4JZOq/bDRZJCt6zyyzOdYNbQVJX7NZ4PfyH7M=
X-Received: by 2002:ab0:484b:: with SMTP id c11mr27684290uad.100.1624979377958;
 Tue, 29 Jun 2021 08:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <1623726033-16073-1-git-send-email-wenbin.mei@mediatek.com> <1623726033-16073-2-git-send-email-wenbin.mei@mediatek.com>
In-Reply-To: <1623726033-16073-2-git-send-email-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Jun 2021 17:09:01 +0200
Message-ID: <CAPDyKFrqeYbxDyrcicS=DQLntF8PfNm9E4tZf7KgvzRJmciLog@mail.gmail.com>
Subject: Re: [PATCH v1] dt-bindings: mmc: change compatiable string for MT8195
 mmc host IP
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 at 05:01, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> MT8195 mmc host IP is compatible with MT8183, and currently it shows:
> properties:
>   compatible:
>     oneOf:
> ...
>       - items:
>          - const: mediatek,mt8192-mmc
>          - const: mediatek,mt8195-mmc
>          - const: mediatek,mt8183-mmc
> which means the compatible string in the device tree would be:
>         compatible = "mediatek,mt8192-mmc", "mediatek,mt8195-mmc",
>                      "mediatek,mt8183-mmc";
> The bindings is wrong and that isn't the result we want.
> instead we want:
> properties:
>   compatible:
>     oneOf:
> ...
>       - items:
>          - const: mediatek,mt8192-mmc
>          - const: mediatek,mt8183-mmc
>       - items:
>          - const: mediatek,mt8195-mmc
>          - const: mediatek,mt8183-mmc
> which would give us:
>         compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
> and
>         compatible = "mediatek,mt8195-mmc", "mediatek,mt8183-mmc";
>
> Fixes: eb9cb7227e5c (dt-bindings: mmc: Add compatible for Mediatek MT8195)
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 8648d48..adaba90 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -31,6 +31,8 @@ properties:
>            - const: mediatek,mt2701-mmc
>        - items:
>            - const: mediatek,mt8192-mmc
> +          - const: mediatek,mt8183-mmc
> +      - items:
>            - const: mediatek,mt8195-mmc
>            - const: mediatek,mt8183-mmc
>
> --
> 1.9.1
>
