Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27182360545
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhDOJIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbhDOJID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:08:03 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325D7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:07:40 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id u200so2439186vku.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjVJwjzWYr1/sR0XamTsvtpkvMNA+5snLIJZWYxDhFI=;
        b=UyrLPEOZuT1ziKU+PyL1rJHq7rNyJg+UeOgK0vbNVbHgo9TdDnHuc+z5wtHB5da8cA
         G+eyDGuYo4jyss1OzbjpexQ1IRvennZUdBbRenPx4Yah7ic1Za0jpMLgARxClGCfccbQ
         la+cauI00P0pXwi8nnpjnuobj6IVxaU5KLorR9GLgmrM87RNMG2TxXIjwxkorvE0BAmE
         zH8TnvhSXF640s8pNdpUhEMJsqERIBzh+keXwLTULu70N1bYEdBNjeHg/tDr7EJnIIzm
         a8VZIsXsEW+0idHwtn7r+QltlRl5lNlAGJB11tkdsNyIqC5UkivcIK1+5f3qWV9Lxje1
         nUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjVJwjzWYr1/sR0XamTsvtpkvMNA+5snLIJZWYxDhFI=;
        b=J9effKIyt48T+1xmeO85T1Fa6/KSNEEcMuQvUm7tmTObE4Bf8vGokSHPrF1IAzzaFW
         2rL0L//lndC4pDI98sOzSKSAyMxrWD3gl386/heWz7E+w5jGFanMSCl6Tz7pnAeQe4gS
         E5Y02cMRZ1tTRy/VwrPoDq/KNuWDeX3VqRbmGqlc+WZI906egV50HmeZaW/YrWOxVp8F
         QYcNug3qjimzsu8mQOEvoqcjLwI3ZIK8TOZKPWkYNaFzA7X0bVSG04im5/ZdsbdDA2kd
         T0rqwV3NOPhw2fBiarMSC0fhC+pth4zmqmKmqVelO81l+cPAWbZmCTS4lLIMnmM158PN
         xncQ==
X-Gm-Message-State: AOAM5301QFWTzCX0lv69mWzJeJZkqlvGSSgfUKoh9FYj0x+83gTzlWzr
        VOUUQ+DLWjVi1IFCFnDfFJdKTTRz6rKgA1eiT3PGlg==
X-Google-Smtp-Source: ABdhPJy/tFAI7hIwRCSFL3zc12707ikZU7bG/40bLAl8ttRArxQYWSFbL/u1pKeyKIZ0A2iQgJwfGHELnGwKLccsYO8=
X-Received: by 2002:a1f:2c58:: with SMTP id s85mr999684vks.15.1618477659418;
 Thu, 15 Apr 2021 02:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210414100010.3877669-1-narmstrong@baylibre.com>
In-Reply-To: <20210414100010.3877669-1-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 11:07:03 +0200
Message-ID: <CAPDyKFpNLu3R+7ODZaC7yWMYbSOujswgLTkN97FQNg5zhwSxgw@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: remove useless warning about scatterlist
 size alignment in block mode
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Lebed <lebed.dmitry@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 at 12:00, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Since commit e085b51c74cc ("mmc: meson-gx: check for scatterlist size alignment in block mode"),
> support for SDIO SD_IO_RW_EXTENDED transferts are properly filtered but some driver
> like brcmfmac still gives a block sg buffer size not aligned with SDIO block,
> triggerring a warning even if the transfer works in degraded mode.
>
> This should be ultimately fixed in brcmfmac, but since it's only a performance issue
> the warning should be removed.
>
> Fixes: e085b51c74cc ("mmc: meson-gx: check for scatterlist size alignment in block mode")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index eb6c02bc4a02..6bc151045843 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -246,11 +246,8 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>                  * size, otherwise chain mode could not be used.
>                  */
>                 for_each_sg(data->sg, sg, data->sg_len, i) {
> -                       if (sg->length % data->blksz) {
> -                               WARN_ONCE(1, "unaligned sg len %u blksize %u\n",
> -                                         sg->length, data->blksz);

Rather than removing this warning, perhaps an option could be to use
dev_warn_once() instead?

> +                       if (sg->length % data->blksz)
>                                 return;
> -                       }
>                 }
>         }
>

Kind regards
Uffe
