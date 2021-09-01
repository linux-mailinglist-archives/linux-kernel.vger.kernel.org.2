Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9043FD264
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 06:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbhIAEgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 00:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhIAEgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 00:36:52 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF585C061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 21:35:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j4so3643251lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 21:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lhspy1Lcz1PiiBOGE+v1mcRdMh4tYchPF+3AL6Zubvk=;
        b=J93QWDCZT6uuBqffhguCrmmulYwP0uLkMtoO28ijrPVTOU+0AhmYQRXxSmEtUWr6Jr
         9MgdRl+11hjg+mUW4dhUv4dTavhx30vBmZgVeQG4qdf3fxJpANvQHaUHm6NaRqE78sho
         qw8ZTRLNXUYvPIxw8vQ8fB6SKwgd5fACA+XHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lhspy1Lcz1PiiBOGE+v1mcRdMh4tYchPF+3AL6Zubvk=;
        b=YX1gWGhRlonDvnCbg8Z1jHbizeYQHPUtv65q0D3FTvDP1LJvhDBs2MIXO23deTWmTC
         EK4c28jjkOMbvkhY9sUcljHpMJDt8X5lje1jUEZFFUhxlFt9xNOOLyZurLrI2SgSd84w
         nj3hGLmIe3sXaV450Ecch8sr9EbcaqyNRWF+DkRl0ULMlUwV2fkUr40aFdToYkwY6GlE
         5gHDTFu9QG+ghVEd4WI3aYtDn3nfcuB8v1NcPWkA5sUjLC97GcYzGNymzcwX8XqrHLJ2
         Bj/3Nja2R4+wiyvsVIeBdtwHh4tTKgj3Zebc4nCpad7xwUPrJaqQzhPV2Laj/47fE0Gs
         SP7Q==
X-Gm-Message-State: AOAM531qSXx5paWJz8ASUJ7TqoTSh76+D5nMe3nCIfEKGaNVmSZX1U6e
        pa/fX47H5fWOtVot0RZAr/VCis9dkTSllm8TT+D1nw==
X-Google-Smtp-Source: ABdhPJwE4jWrVsnG8qdYIOadYpldVmY+nJaGWsWtd2ijWGWx7vBq3pDPcJJ8hJSsKuUwLelkLoQY0/YgYsZN8Cvigzk=
X-Received: by 2002:a19:6455:: with SMTP id b21mr24188573lfj.656.1630470954146;
 Tue, 31 Aug 2021 21:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210830003603.31864-1-zhiyong.tao@mediatek.com> <20210830003603.31864-2-zhiyong.tao@mediatek.com>
In-Reply-To: <20210830003603.31864-2-zhiyong.tao@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 1 Sep 2021 12:35:43 +0800
Message-ID: <CAGXv+5HeNj2Ly-T1bWMvnYXv6nP-Q1kv+D9QEd+5u4xfNVibOg@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] dt-bindings: pinctrl: mt8195: add rsel define
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        hui.liu@mediatek.com, Eddie Huang <eddie.huang@mediatek.com>,
        Light Hsieh <light.hsieh@mediatek.com>,
        Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 8:36 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
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

Could you keep the spacing between constants tighter, or have no spacing
at all? Like having MTK_PULL_SET_RSEL_000 defined as 104 and so on. This
would reduce the chance of new macro values colliding with actual resistor
values set in the datasheets, plus a contiguous space would be easy to
rule as macros.

ChenYu

>  #define MTK_DRIVE_2mA  2
>  #define MTK_DRIVE_4mA  4
>  #define MTK_DRIVE_6mA  6
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
