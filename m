Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F8B39F77C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhFHNS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhFHNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:18:54 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4528C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 06:17:01 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id w28so11583441uae.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tO3BohwnkUKnYIuONkUA0L73DP8nymMxh+DI7cdhd4w=;
        b=jMly9y0B/5qY0PR8RSddHqssiLIzHRTUAldUlCQQXlTwxHzxbXAEg0kxUaWtHKX+CH
         hUGuCTUIU5E8EXPZJefrrrEmI35XCFPNbkFZmuR8yJwC2hMXFfuq5XOk2bSbu40lRmi1
         TmnLRH9FtGL6QDNz4dVrVOKcgjSu6B/Va4gQrKGuEM+VOeJqmjmL0PwfvCKIR3WOCoL/
         hYn77PUX0xAfXLGrhlUj1DKOAJFUJlQPjuMAwqTj6DrgANK+k8TMWGWmiKCXehiiPDM3
         z+5u9kzzS6pECCG9zAgo/dvij0jNBbOdpJBQE0lb78qDygAee15OUFirubMn/ufI22K+
         Ugug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tO3BohwnkUKnYIuONkUA0L73DP8nymMxh+DI7cdhd4w=;
        b=U8cvVfxDuUJgIqc95nAUP3zZTMrygcPryZgdbCHTTS/0q7kQ8GgyjgmAvx9joiqql7
         4UJahNuwtvno+ZuDTyFJ6GjBwgCpk5WgTK/yZgvqOEx2Xj+sJhFwS0BQ0nuXzh8ACYuq
         a/SGPzF0lApV41jgaRZobpzoTVBafO0ZnaIW1cqQofGSmEnTbR2HygK6HLHdpHBF/ohD
         N64lRmJhJgpTMPLMPn6BZ983jgqz0rK0t3ay5/zZkwks2x/QSdIGWk+8txpCB6SRr0o+
         jHTZyUWjcEN7Xb69kUx7/gme3HuFzGuKdn1OyVKocSmZIQT4EzOwj++LNiJ+CHfUqBRM
         y64Q==
X-Gm-Message-State: AOAM531/BjXKm1F1P7Rqu7SSs0oosct7e7EQqm9UoMiYgQsmyyAKPuz6
        +ilHQE1Ad4kUjCAPvSfTuCN6+PJ7DGr0cJaf/2PuRA==
X-Google-Smtp-Source: ABdhPJxpMbI86j1ktkn7vwGdS6ghdFwZJ7dwIbr0IxePCkJHK9etSF1AgQY3m9fL2SZjr5Ui6IAsBEGWj3JiPCPA17Q=
X-Received: by 2002:ab0:7c5b:: with SMTP id d27mr12469684uaw.15.1623158221026;
 Tue, 08 Jun 2021 06:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <ee8af5d631f5331139ffea714539030d97352e93.1622811525.git.geert+renesas@glider.be>
In-Reply-To: <ee8af5d631f5331139ffea714539030d97352e93.1622811525.git.geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 15:16:23 +0200
Message-ID: <CAPDyKFo8U0SAuocTTznASBNMEzxm3HHbjfdG6E3dkHWjOR9kqw@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: Fix HS400 on R-Car M3-W+
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Takeshi Saito <takeshi.saito.xv@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 at 14:59, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> R-Car M3-W ES3.0 is marketed as R-Car M3-W+ (R8A77961), and has its own
> compatible value "renesas,r8a77961".
>
> Hence using soc_device_match() with soc_id = "r8a7796" and revision =
> "ES3.*" does not actually match running on an R-Car M3-W+ SoC.
>
> Fix this by matching with soc_id = "r8a77961" instead.
>
> Fixes: a38c078fea0b1393 ("mmc: renesas_sdhi: Avoid bad TAP in HS400")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Boot-tested on Salvator-XS with R-Car M3-W+ ES3.0.
> No difference seen in eMMC/SHHC detection:
>
>     mmc0: new HS400 MMC card at address 0001
>     mmcblk0: mmc0:0001 BGSD4R 29.1 GiB
>     mmcblk0boot0: mmc0:0001 BGSD4R 31.9 MiB
>     mmcblk0boot1: mmc0:0001 BGSD4R 31.9 MiB
>     mmcblk0rpmb: mmc0:0001 BGSD4R 4.00 MiB, chardev (247:0)
>      mmcblk0: p1
>     mmc1: new ultra high speed SDR104 SDHC card at address aaaa
>     mmcblk1: mmc1:aaaa SL16G 14.8 GiB
>      mmcblk1: p1
>     mmc2: new ultra high speed SDR104 SDHC card at address aaaa
>     mmcblk2: mmc2:aaaa SL32G 29.7 GiB
>      mmcblk2: p1
> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 635bf31a67359f10..b719eda6b8619453 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -939,7 +939,7 @@ static const struct soc_device_attribute sdhi_quirks_match[]  = {
>         { .soc_id = "r8a7795", .revision = "ES3.*", .data = &sdhi_quirks_bad_taps2367 },
>         { .soc_id = "r8a7796", .revision = "ES1.[012]", .data = &sdhi_quirks_4tap_nohs400 },
>         { .soc_id = "r8a7796", .revision = "ES1.*", .data = &sdhi_quirks_r8a7796_es13 },
> -       { .soc_id = "r8a7796", .revision = "ES3.*", .data = &sdhi_quirks_bad_taps1357 },
> +       { .soc_id = "r8a77961", .data = &sdhi_quirks_bad_taps1357 },
>         { .soc_id = "r8a77965", .data = &sdhi_quirks_r8a77965 },
>         { .soc_id = "r8a77980", .data = &sdhi_quirks_nohs400 },
>         { .soc_id = "r8a77990", .data = &sdhi_quirks_r8a77990 },
> --
> 2.25.1
>
