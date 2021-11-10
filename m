Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8000344BB7D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 06:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhKJF5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 00:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhKJF5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 00:57:37 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66BCC061767
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 21:54:49 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b40so3238931lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 21:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TgZ5k8tAe/+pJDD+RCLvpCMRygApskgp5M5BH1MTJeA=;
        b=VgjjGGPKec52KZ2HHoQk88GnQ0q5PYMG5hs02d7pEMoAoX3iW2t5j2CZmkkspTtZM8
         Adw+v8DRlHu2yzeOUMgmFCyCD4P2J0XUB5YqQkhoG26vf3+lfgkfT8FXcFTAQp79Lmee
         jV1RYmz6nHUWKjoOxNLcb5/wVkN1ZU47X8Rss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TgZ5k8tAe/+pJDD+RCLvpCMRygApskgp5M5BH1MTJeA=;
        b=U9W9a7TBbXdjTBgFt7G+wLkAw3aIOkXQRzdukwapAxb1lPZU2ejt8eVnxiV7SI3cnL
         Yy5/yivV81UYU7kyiynM8qUQFtn2XLhsFe8pNm1WFgCbfswOOq0D2DWN5UzVUwvob6RD
         ig/Ybl2IiayXaJZui4CkdYu4Sb8gGpeWzfQjLbdKvvaGmUrYttCkg8t6wJ6eM5TWP8Sl
         nlb+JxVE6nSDjePXlPWAJnPCagzCOKV/qwWl4/qIy7VCvpPlwSvvwRq/yGGkR6wJBOwu
         NOryvF1vwp5kJk64trsG1wipFSycPZbVXGHxsMopANZ3xq7W+UxMnCvgDNyg6192kDTF
         v9LQ==
X-Gm-Message-State: AOAM530X6wYGB4Dk92rYZv2ojuo87q6KK9yvdaARWme49zm/MIG7+r8I
        2S1w3Y2RPHVEeW9RAb0Qxa182RYueqIZ4k3rcupSbA==
X-Google-Smtp-Source: ABdhPJxj2FKRewwrDxr1vDAwxEiLp8eMAeSoq4KW0LmVCVSj17K2eiqMz1j+pgJjsehYBcIRooitI8dgNQhyaqz87FA=
X-Received: by 2002:a05:6512:2506:: with SMTP id be6mr6901429lfb.597.1636523688194;
 Tue, 09 Nov 2021 21:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20211110021411.31761-1-zhiyong.tao@mediatek.com> <20211110021411.31761-2-zhiyong.tao@mediatek.com>
In-Reply-To: <20211110021411.31761-2-zhiyong.tao@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 10 Nov 2021 13:54:37 +0800
Message-ID: <CAGXv+5Entn5QnCODgbUSdDFSds4z+_QJ6cD39yEoLndms+rY7Q@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: mediatek: fix global-out-of-bounds issue
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org, mark.rutland@arm.com,
        matthias.bgg@gmail.com, sean.wang@kernel.org,
        srv_heupstream@mediatek.com, hui.liu@mediatek.com,
        light.hsieh@mediatek.com, sean.wang@mediatek.com,
        seiya.wang@mediatek.com, rex-bc.chen@mediatek.com,
        guodong.liu@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        Guodong Liu <guodong.liu@mediatek.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 10:14 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> From: Guodong Liu <guodong.liu@mediatek.corp-partner.google.com>
>
> When eint virtual eint number is greater than gpio number,
> it maybe produce 'desc[eint_n]' size globle-out-of-bounds issue.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.corp-partner.google.com>

The order of Signed-off-by is still reversed though. The author comes first,
then comes everyone who subsequently handled the patch.

Once fixed,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Also, for single patches, you don't really need to have a cover letter.
Any info you would convey through the cover letter, such as changelogs,
additional context, or whose tree you would like it merged through, can
be put after the triple-dash ...

> ---

here. Text put here won't get included in the commit log.

>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> index 45ebdeba985a..12163d3c4bcb 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> @@ -285,8 +285,12 @@ static int mtk_xt_get_gpio_n(void *data, unsigned long eint_n,
>         desc = (const struct mtk_pin_desc *)hw->soc->pins;
>         *gpio_chip = &hw->chip;
>
> -       /* Be greedy to guess first gpio_n is equal to eint_n */
> -       if (desc[eint_n].eint.eint_n == eint_n)
> +       /*
> +        * Be greedy to guess first gpio_n is equal to eint_n.
> +        * Only eint virtual eint number is greater than gpio number.
> +        */
> +       if (hw->soc->npins > eint_n &&
> +           desc[eint_n].eint.eint_n == eint_n)
>                 *gpio_n = eint_n;
>         else
>                 *gpio_n = mtk_xt_find_eint_num(hw, eint_n);
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
