Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2FA3FC3FA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbhHaHy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 03:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbhHaHy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 03:54:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B50C061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 00:54:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bq28so36655232lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 00:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4z1Q7XZLrwMagEwf7DhKHY7l4vBFTh7bbew95Rfghc=;
        b=LGhfjvXydY9NR23oENrvhn3uS3FsBDQF5xv94TOHFCy8S4Laq0hXFnjqygFk/9MYrq
         xrXsA5/UygBoKt2NEyejI+2P0P8aB6rKV1kfJLekLODhlhGqjVT/ifPUPOVFzQvx2syd
         ohR9cedskRFxWtgveTf0Wp1JXBzuSjD9PooTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4z1Q7XZLrwMagEwf7DhKHY7l4vBFTh7bbew95Rfghc=;
        b=JTSylbj+6WT4IKjk47v2cMgMk8KucF2WwfP6U4ys7By2guLde3ZKQYDYGxHqJFI19T
         IdKEFb6KePY0wPmZRapv22oYW+498r0TIZmBcXdzJBCnu/gbzzhyhkYF9j8/qsOKpMgt
         JQBuwjBzRF9hLYfA8NHaQiAYofvcSqAbXW8AZnyh1geVOFKtPXs6nFUaZ9pe8JXG2kll
         6CwVgrwPzj7vPWF1Zp9iCzYG8PzM64uRqvFUYR71qsPVxBCfnDJTNdn9Voiicrj7OGpO
         D4Mbr8SSIvMLRGIteEte7Y3MkrD4bVdUszGqKcGhA9dGObHOrEyx170Taz4huqvVx661
         iGng==
X-Gm-Message-State: AOAM531EYzOrdkFjubwpzo+5PE3QiVMMBwD+igOXVAZzzVMo9+t43OBZ
        mL16GtteZeyg4/p6PCVJUbjIAdtYx9OXy59UEkVy/Q==
X-Google-Smtp-Source: ABdhPJyI7Qitp2hXCfbD58wQEyaZGTWIKb2i10Sjy5PjIUW1idrtrJ719jxZJe2gtyY1vQEubKsItHY2MUnG2NvMnZg=
X-Received: by 2002:a05:6512:22c8:: with SMTP id g8mr21387849lfu.342.1630396439123;
 Tue, 31 Aug 2021 00:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210830003603.31864-1-zhiyong.tao@mediatek.com> <20210830003603.31864-4-zhiyong.tao@mediatek.com>
In-Reply-To: <20210830003603.31864-4-zhiyong.tao@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 31 Aug 2021 15:53:48 +0800
Message-ID: <CAGXv+5Gx74SxdB_-V3SZB1sQ3=bpUkbkkaHxAyFg9m+7k+HVkw@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] pinctrl: mediatek: mt8195: Add pm_ops
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

On Mon, Aug 30, 2021 at 8:37 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> Setting this up will configure wake from suspend properly,
> and wake only for the interrupts that are setup in wake_mask,
> not all interrupts.

This sounds like a fix. Please add a Fixes tag for this patch. This makes
tracking things easier.

So,

Fixes: 6cf5e9ef362a ("pinctrl: add pinctrl driver on mt8195")
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Also this patch is unrelated to the rest. You should send it separately.
This would also help the maintainer merge it directly.

> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mt8195.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8195.c b/drivers/pinctrl/mediatek/pinctrl-mt8195.c
> index a7500e18bb1d..892e79703f98 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8195.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8195.c
> @@ -839,6 +839,7 @@ static struct platform_driver mt8195_pinctrl_driver = {
>         .driver = {
>                 .name = "mt8195-pinctrl",
>                 .of_match_table = mt8195_pinctrl_of_match,
> +               .pm = &mtk_paris_pinctrl_pm_ops,
>         },
>         .probe = mt8195_pinctrl_probe,
>  };
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
