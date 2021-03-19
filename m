Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54B8341F23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCSONd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhCSONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:13:14 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B2DC061762
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:13:14 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id s136so2130997vks.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kT7+B2/flieu5ujbkJnPLuQBBNLwKu9lAXheORirHr4=;
        b=U1yMXLigO4H7ah1+jp3sxNQNipWk46ztH98A3rCkQbklXq8Bq3Vs49yDHfqi9yrx5T
         03+sjIWHWjiKuEjfuGvYnjmw1ZBoAjXhzB688boq5L93ygDzDJkDh/TsjT4vo9ZUEGQT
         ZOACxRfEVcNH+O1z+OSCIQJ3waQbv0/wcsvv9Xq3IiHyMB5JW00ni0CL+W5tS05HYnxd
         DMcQeAaCArs5mqu1sgmxhE76BN6zq6aDUR9O2jPGwLgFFfWtuS4bO5eXWKH5/tYjPC3F
         198SNZ6lXRMWfqlp6lKO35cN/CZqkOYit5Rc3naNI3qdCJQjsk82bJcFgX76nHR/yzCI
         pf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kT7+B2/flieu5ujbkJnPLuQBBNLwKu9lAXheORirHr4=;
        b=r13EnLLkpqx0kiPwt5kCGIv+q2mvC98fdTJMJtLELu3NxXCRuaz7ZOKS3X+vdiD/NL
         HKz1lmCclaoXOrp+4/hWwgEv+H6yXa5zW9o990lnFI+CEQ176cdO1O7Cy2Uf0lcEjrpb
         XGXRo5oq/O7lpZ9VW7sZShYi0W8ZQU2SaZPrUbhqa0P4yj+3uK4LwLZfY4MaPM0XKYKs
         flCHRSFEHFncLFAsg6G0HdOLsUPlfTKKQubVWbAdrz3vOgCBzNUGP5KKH8TYoOlIWg4e
         peiyQzI3GxF/uhbsfYhwqiolBMW2jHLQLc2eTcuuBZXPfJkMPdPJ8swZpHoFma4ydZAj
         SIAw==
X-Gm-Message-State: AOAM532skUyVuEfCWipEBN9jxOfiUvM3iCvPk+D0euJItHLOZB0nOMpT
        XwUNvycRteesMO1bomiuFPyyzkLcyaCD5Wqx53Mbq70GpbeSog==
X-Google-Smtp-Source: ABdhPJyrCbfKFwzf3QvB/HbP0vNpYxFsspYHELQ6mbVNuzXPsE5ygCViGVapYNlX1ysNdx57pfIQk/9Uhjv0wFXLckU=
X-Received: by 2002:a1f:b408:: with SMTP id d8mr2905520vkf.8.1616163193433;
 Fri, 19 Mar 2021 07:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210319023427.16711-1-seiya.wang@mediatek.com> <20210319023427.16711-6-seiya.wang@mediatek.com>
In-Reply-To: <20210319023427.16711-6-seiya.wang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 15:12:36 +0100
Message-ID: <CAPDyKFqWdJdF__c_=aqV_bjBNwh+-YY5xMy0_SWK9WJaOafawQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] dt-bindings: mmc: Add compatible for Mediatek MT8195
To:     Seiya Wang <seiya.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 at 03:36, Seiya Wang <seiya.wang@mediatek.com> wrote:
>
> This commit adds dt-binding documentation of mmc for Mediatek MT8195 SoC
> Platform.
>
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 01630b0ecea7..8648d48dbbfd 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -31,6 +31,7 @@ properties:
>            - const: mediatek,mt2701-mmc
>        - items:
>            - const: mediatek,mt8192-mmc
> +          - const: mediatek,mt8195-mmc
>            - const: mediatek,mt8183-mmc
>
>    clocks:
> --
> 2.14.1
>
