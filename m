Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774D93B8E22
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 09:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhGAHX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 03:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbhGAHXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 03:23:55 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34C2C0617A8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 00:21:24 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id p24so7071871ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 00:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ga4/H+zFc4BIvkIZp/GwacqLCotWEZsIhOfh+7jAZ3s=;
        b=IaI97DW3ssIIS+7nQ5kQe8/cemQmh7BCye8Vf2G2Io0KFRMGvpn3hkzbv4E0GNYhAl
         klR2AaOqqU+FUSziNdA/ipLW79CJGazcHBsd80s/iR0+tiLs3yar5ixRAwrCCH7BUFxV
         mwR/rL3iszdTDvZjTJDIrKMoqUgj28IFMpYKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ga4/H+zFc4BIvkIZp/GwacqLCotWEZsIhOfh+7jAZ3s=;
        b=njKvK7l4kPa9pwG1dywd81iE6lT4EkKuT0Y5LYxnToZv/0kZE5ty0KOkKCqq1Fi5Ww
         4w1EOvmUrVAT5OVb8pSlC58g1+pBcjcaWlYnRrBBod4zVTW6hmKWtiuWhpaXZelE2Guq
         SfveS5qH4C6VbtpVLbDqoc9ddmWpeciofM6/LiRy/aCGZa/pWiM9Le1jMa+M5NY4LlKL
         Nl5816DkwA61KpIjmOlCi/JevCYrWqysTQsTFTfukuXmPU4R54bOYnXDpy8vQX+21rWb
         VILsIrz8TM7AQEmEcdQJIyZPFOBGeOHtRx+Lc54n2eT6tpE+p8Dhl9nEFNXCn6LoMaue
         gNTw==
X-Gm-Message-State: AOAM5320GDTYd6gfwL6ELPZqWLKjzYC7ObTV75E7L4n6c7w2LlIh0Y6Z
        1+g4dXfMt/GRf9TR70mTz/xOvnlnBRx0tYfCe7k/8w==
X-Google-Smtp-Source: ABdhPJyxvSNuZmwRYoKy8FDKToeJS7PWq88q64REDzsuI4/M4wTPs/gV+/Jhx06I0DFC/KinbxeFXBAee1LQDg9hUZE=
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr10809961ljp.251.1625124082895;
 Thu, 01 Jul 2021 00:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210701065439.2527790-1-hsinyi@chromium.org>
In-Reply-To: <20210701065439.2527790-1-hsinyi@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 1 Jul 2021 15:21:11 +0800
Message-ID: <CAGXv+5GNkqHOxv9zXoa3yLh5_FXGUARqXd82W00CBTnHS_BFPw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: Fix fallback behavior for bias_set_combo
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        zhiyong.tao@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 2:55 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Some pin doesn't support PUPD register, if it fails and fallbacks with
> bias_set_combo case, it will call mtk_pinconf_bias_set_pupd_r1_r0() to
> modify the PUPD pin again.
>
> Since the general bias set are either PU/PD or PULLSEL/PULLEN, try
> bias_set or bias_set_rev1 for this fallback case.
>
> Fixes: 81bd1579b43e ("pinctrl: mediatek: Fix fallback call path")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> index 5b3b048725cc8..0cdff487836fa 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> @@ -926,9 +926,12 @@ int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
>                         if (err)
>                                 return err;
>                 } else if (hw->soc->bias_set_combo) {
> -                       err = hw->soc->bias_set_combo(hw, desc, pullup, arg);
> -                       if (err)
> -                               return err;
> +                       err = mtk_pinconf_bias_set_rev1(hw, desc, pullup);
> +                       if (err) {
> +                               err = mtk_pinconf_bias_set(hw, desc, pullup);
> +                               if (err)
> +                                       return err;

You don't need to nest this. If mtk_pinconf_bias_set_rev1() succeeds,
err would be 0 and the following if blocks would all be skipped. So:

err = mtk_pinconf_bias_set_rev1();
if (err)
        err = mtk_pinconf_bias_set();
if (err)
        return err;

Moreover, maybe you should rework the test for hw->soc->bias_set_combo,
as it is no longer relevant to the code within the if block?


ChenYu

> +                       }
>                 } else {
>                         return -ENOTSUPP;
>                 }
> --
> 2.32.0.93.g670b81a890-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
