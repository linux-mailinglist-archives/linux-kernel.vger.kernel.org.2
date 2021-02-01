Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E630A5EC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhBAKz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhBAKxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:53:52 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E012C061574
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:53:12 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id o186so8833647vso.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tj9+wUASKdA988AwjUcir+sNKYOXGh+DtOltXAPwD5c=;
        b=aXdwaxpjRxNrPrq30arSHWwsOaUD+Gs3g10PPEAi7s+Eb/z0CjrS+H+I0zBpQMZau5
         iGMUT+ZOqWpkL8i9sGNcW/OmKqlXCOLe6yh7xd8QalAUcrl3CcIFTS/ZnT+iw3OXe7RI
         ix4wzus4ntv43NkKn85xPWFKM9snBKAzmUk5QBcPHmMXWo8yb2inBXncd5tEuUp5m0DS
         rePAqucaLrPgs1LTR2NFwH04HsvbVeYlEQCNWWq76Z/t9kfhwZYkLE83N8TftQgEGPeG
         Wxmbk49pR1fNPuN/KxiB3utA1v+p0dCwMnTNyTXf/aAKUHpqetSi/ZaG5dl6ybvRTT/d
         mhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tj9+wUASKdA988AwjUcir+sNKYOXGh+DtOltXAPwD5c=;
        b=WoUvwWwYZhYAmBLzvLZkV312RznFoQFIg9XF9X7RuEipA1kNGDpJTFcybszWkFdvQ6
         CcRF4OktelJFs61xl8S9wqFKqOO3dus9ii57MijM8Gaa7K1sqBN17YrKkr5osGP88nhE
         hzLWi1e5X48aqtuQiuvOLSAKL95eQdLpjx2rxFDN/m78E+z+xaQ+GzfbIj8WV9bIbuAM
         bGFhqJ3WQF7Og92d5bvcy1ZftAwDTLSyeGKeT1/gCIDkNylvx2NkXYel0J5FMJzqLYgW
         mu2YJaw7G+wW2MOis8BZkM5EvmQZEyvt5m1bguxy/M5E8vNcdLAyNEY12wzclY/y25u7
         Z3KA==
X-Gm-Message-State: AOAM531NCYcTqsUjN+ZC/xdGrbuYIzo1PIwgkfy8LoBlBn1A14xidJjO
        FtcU8EEhXC46enpwJgcL39KPcCdnPpa8K7QM9ciTfQ==
X-Google-Smtp-Source: ABdhPJzfgAWfe9KDdADgCat7+QVp73bUlUd8wAj/QDujNIzNOe+wtUW4jFYZRog/xQ1FUMxdv82lvrygS9pwlwIzfdQ=
X-Received: by 2002:a67:ec4a:: with SMTP id z10mr4286650vso.19.1612176791680;
 Mon, 01 Feb 2021 02:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk> <20201208061839.21163-7-chris.ruehl@gtsys.com.hk>
In-Reply-To: <20201208061839.21163-7-chris.ruehl@gtsys.com.hk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Feb 2021 11:52:35 +0100
Message-ID: <CAPDyKFoVGiB0VMv2y-YHEE8F72Y7vO6561e0vQXH5hc7yayOKg@mail.gmail.com>
Subject: Re: [PATCH 6/6] mmc: core: with mmc-hs400-1_8(2)v not add
 MMC_CAP2_HS200* to host->caps2
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jack <jack.lo@gtsys.com.hk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 at 07:19, Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
>
> When set mmc-hs400-1_8(2)v in dts, hs200 capabilities are not checked
> in the mmc logic. Thus cleanup and remove MMC_CAP2_HS200_1_8V_SDR /
> MMC_CAP2_HS200_1_2V_SDR from host->caps2.

I had another look at this - and I am struggling to get a grip of the
problem you are trying to solve, sorry. Please try to clarify things
through more descriptive commit messages.

*Plain* HS400 mode does seem to require HS200 mode, because tuning
needs to happen in HS200 mode. HS400 mode with enhanced strobe being
supported, doesn't need HS200 to be supported as tuning isn't done in
HS200 mode.

In your case, the controller supports HS400 mode in (1.8V or 1.2V)
with enhanced strobe, but not HS200 mode, correct?

Then because of the code that runs the initialization for the eMMC
card, we end up switching to HS200 mode prior enabling HS400 ES mode,
which causes problems in the driver/controller for your case, correct?

>
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  drivers/mmc/core/host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 96b2ca1f1b06..46fde60a2372 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -295,9 +295,9 @@ int mmc_of_parse(struct mmc_host *host)
>         if (device_property_read_bool(dev, "mmc-hs200-1_2v"))
>                 host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
>         if (device_property_read_bool(dev, "mmc-hs400-1_8v"))
> -               host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
> +               host->caps2 |= MMC_CAP2_HS400_1_8V;
>         if (device_property_read_bool(dev, "mmc-hs400-1_2v"))
> -               host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
> +               host->caps2 |= MMC_CAP2_HS400_1_2V;
>         if (device_property_read_bool(dev, "mmc-hs400-enhanced-strobe"))
>                 host->caps2 |= MMC_CAP2_HS400_ES;
>         if (device_property_read_bool(dev, "no-sdio"))
> --
> 2.20.1
>

Kind regards
Uffe
