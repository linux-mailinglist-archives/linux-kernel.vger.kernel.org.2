Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E20A3D56AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhGZIvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhGZIvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:51:50 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23251C061757;
        Mon, 26 Jul 2021 02:32:18 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t128so10207270oig.1;
        Mon, 26 Jul 2021 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TvB2lU3cpIiYxB3yUvnpi686GY8PdgzLtSomY5oaEog=;
        b=cI8CEovvUbYc4RTo/50NJmMV+CsWTMEGKA2jXDrWifgQtrm1C034WUzFAh59x/KWzF
         XVvMZwU8i6pcw2sEQ2haz8972spAgFHvwQ7ccCLOQq2qKpvt2r7qPwbMbFuWT+t+AMwz
         ZSgld8ytrnY+GWNJy7HUPPs0h/sgXc3Dl7KJHVAYM0hPWrjTgWPJN82BXXozDEqa4fer
         kqCo6Xy+5MNLnvcBpihc+31Jo3gF9DY8U9RjX7uVGMETeZpAn/rILAA+L/cNUfkIB3e6
         NVtU91VCF/a/ORP58S/3IrDKNRGhy+6R09dBM2ophufne8uoZ6UkzV6Du4Stu3QO3AdN
         Fxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvB2lU3cpIiYxB3yUvnpi686GY8PdgzLtSomY5oaEog=;
        b=F1SplcSKH/BoK7Jtci9/AZ9R2lEC0JzfgLwpT6S+Blv4ORI9LAwX65lgwbMZBJhe+s
         4X1z++SNhTOJvHJL2kNk7pWC0Z4U1tCy+mYOExWCqSrHmxV8VeFz/RsKzG9KKwF22gYJ
         xPk6pnAo1U6jX4ueLmvhZLTt26LSKRzosSczHZAdg6CzdSBtesVTDt14kqw2vvqvy1ab
         Tn8ECMWJomLsUCxkayEpmGXR+0X9QCWnm05BZwVjxKdHbdM7uy3upcP7c0w9egnAFIRq
         l6jKPjLYp9i2X/03aXEAqDxzLuA0GkXkHgPUAx0Wk2Skyrnrbt4hnL32vqIVpdbd8y7H
         dOGw==
X-Gm-Message-State: AOAM530BwUiXAx0hZacsyFBgOSejNRDcp2yWH16haPtMdpY6qkiAKoc7
        H3GNEl8TX2vXEGdF7Iyr8bfWHyaAg3kDMWsIRTg=
X-Google-Smtp-Source: ABdhPJxPbsQMG7e++KYhaErKSQEC0RsF92zrY6kaJhfP72TiFAKnUN1wA6vD9nUlwwCYUS14lzoHWQg/3ZmrduoI81Q=
X-Received: by 2002:aca:c0c3:: with SMTP id q186mr4872462oif.39.1627291937488;
 Mon, 26 Jul 2021 02:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210726050831.1917982-1-hsinyi@chromium.org>
In-Reply-To: <20210726050831.1917982-1-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 26 Jul 2021 11:32:05 +0200
Message-ID: <CAFqH_53zJp7ejwXn3qqiVPnoTy6W3WonvvDxsZDCjmaQA57h6A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8183: kukui: Use aliases to mmc nodes
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for the patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dl., 26 de jul.
2021 a les 7:08:
>
> Use aliases to mmc nodes so the partition name for eMMC and SD card will
> be consistent across boots.
>

This definitely helps with my "troubles" flashing the kernel to the
correct place" so

> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Btw, I think that a similar patch should be send for Elm, could you
take care of it?

Thanks,
  Enric

> ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index ae549d55a94fc..ed499e17b6570 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -13,6 +13,8 @@
>  / {
>         aliases {
>                 serial0 = &uart0;
> +                mmc0 = &mmc0;
> +                mmc1 = &mmc1;
>         };
>
>         chosen {
> --
> 2.32.0.432.gabb21c7263-goog
>
