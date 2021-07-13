Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7348B3C6B16
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhGMHUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhGMHUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:20:51 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357BAC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 00:18:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r20so28446454ljd.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 00:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/rXhAg8/mS9EW+OBkg4YZ134yjPtz+YcrIsxDtxXHw=;
        b=gdFmIqRJGerDFfRedrGfJCYZTiEOVZPen6UFik8USN7wSEnDhX8+z7XGhUv1Xe1UET
         E60fQrM+rX8DuBoVnFZ+G3Kjv2Ny2c1X0zx9mmRF4HZnwKIPPcavSze3deQaq8cs/zzi
         E1JxLrPpNqdXrdD9/4sn9ONH67XXUg9JnnlSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/rXhAg8/mS9EW+OBkg4YZ134yjPtz+YcrIsxDtxXHw=;
        b=HElTZgmGL5w1jis5I2ZJrT0Yh2q0kebLNl78E2KzW/uOdsdf/qGD0Kv0jQntcH8ZZ9
         94daxPQhCkoD65pCEb1NweoeslUwsIsmJ5tWkhPreC7iGGDp8fVYnVjJlBqRxoENVwja
         pqRb3P3tBj9EfXi2wx4EQFnmGIilCmFCMssWWxDBjkNndR5k7fr+7SDkojBs1bu0PXL8
         LojeZUA+XEZWQDuJ+VAZcW6M0+D+7dnNRjjaYXdvmanhsflDI5/5rPwCIG0cYYy6ZqLz
         TJ7GT8unSODQulUPFrrTqgqnHcGrZFLiFxjadsy64Ppi+dEwEZhH/KNo3G/XM0KCue3e
         ldGA==
X-Gm-Message-State: AOAM532ef8IrFe+aAawt8z0rlpAOFrnobtnl0B+LFRkHgKaJzqfsNdhS
        63HGYqcANdhQwN9BVB4Gq8oi9mjpoaoIHGVjME/0PQ==
X-Google-Smtp-Source: ABdhPJwvNEV51r8aYwOBO8oRSgDCsy56hMQEygkoe/TYR9OaSobFtYzNx+irktn74bxJOc20Xg0McmWpytNswEZxIRA=
X-Received: by 2002:a2e:5c42:: with SMTP id q63mr2849499ljb.23.1626160680315;
 Tue, 13 Jul 2021 00:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210710081722.1828-1-zhiyong.tao@mediatek.com> <20210710081722.1828-2-zhiyong.tao@mediatek.com>
In-Reply-To: <20210710081722.1828-2-zhiyong.tao@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 13 Jul 2021 15:17:49 +0800
Message-ID: <CAGXv+5GXg0RuOQkh4vaRmcLpehZiXnEUXBvEaObiatAa1sXvaA@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: pinctrl: mt8195: add rsel define
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, mark.rutland@arm.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        hui.liu@mediatek.com, Eddie Huang <eddie.huang@mediatek.com>,
        light.hsieh@mediatek.com, biao.huang@mediatek.com,
        hongzhou.yang@mediatek.com, sean.wang@mediatek.com,
        seiya.wang@mediatek.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 10, 2021 at 4:17 PM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> This patch adds rsel define for mt8195.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  include/dt-bindings/pinctrl/mt65xx.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/dt-bindings/pinctrl/mt65xx.h b/include/dt-bindings/pinctrl/mt65xx.h
> index 7e16e58fe1f7..f5934abcd1bd 100644
> --- a/include/dt-bindings/pinctrl/mt65xx.h
> +++ b/include/dt-bindings/pinctrl/mt65xx.h
> @@ -16,6 +16,15 @@
>  #define MTK_PUPD_SET_R1R0_10 102
>  #define MTK_PUPD_SET_R1R0_11 103
>
> +#define MTK_PULL_SET_RSEL_000  200
> +#define MTK_PULL_SET_RSEL_001  201
> +#define MTK_PULL_SET_RSEL_010  202
> +#define MTK_PULL_SET_RSEL_011  203
> +#define MTK_PULL_SET_RSEL_100  204
> +#define MTK_PULL_SET_RSEL_101  205
> +#define MTK_PULL_SET_RSEL_110  206
> +#define MTK_PULL_SET_RSEL_111  207
> +

Instead of all the obscure macros and the new custom "rsel" property,
which BTW is not in the bindings, can't we just list the actual bias
resistance of each setting? We could also migrate away from R1R0.

Then we can specify the setting with the standard bias-pull-up/down
properties [1].

Also, please ask internally if Mediatek could relicense all the header
files that Mediatek has contributed under include/dt-bindings/pinctrl/ [2]
to GPL-2.0 and BSD dual license. These files are part of the DT bindings
and we really want them to be dual licensed as well, and not just the
YAML files.


Regards
ChenYu


[1] https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml#L37
[2] Note that a few files were contributed by other people

>  #define MTK_DRIVE_2mA  2
>  #define MTK_DRIVE_4mA  4
>  #define MTK_DRIVE_6mA  6
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
