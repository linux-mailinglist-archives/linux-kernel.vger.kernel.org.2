Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C0E31323F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhBHM0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhBHMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:08:39 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61106C06178C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 04:07:26 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id x13so400953vsl.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 04:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImspA1BSqvczZ+MWUWIRyfcIF1TY4t53ZG9PfWvHtxQ=;
        b=AV4fYeCBmYOLfiveuetMK91m+CKQCbIxlcsrEIPQCA/hUQqSTxDqGXDoCivvhmyGRK
         2rnBAi8pTtT3PmrhPm2jPFeTDjvMztmOBLwjNWKa2/prHJvTNuarzTrO4SRrDNGFODvp
         F1RmtTiaqyIRXXAUJwGfHz6a3shk6EucHp98b84kHpi7mYaIs6O465KaUYg/7oE54dFD
         7d0ioAKO0OJjOzcXb0m+kCzhxhgWB0HOP6xeoSvcXARVfzsw8g0Mk2QOZxjzQs4jVBpF
         By3BMLPSRdeIFtH3LZJ/QpkxVUsUFIaKu2FH7it7M3H/+V76no3eKPTvQlybwOEwqeME
         o0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImspA1BSqvczZ+MWUWIRyfcIF1TY4t53ZG9PfWvHtxQ=;
        b=fNNJDv7N+RpnyEvRo0Ec3ilzy2pn48X/0Wkl36xVW98omKScMiblhOyQcNFTqXjDAi
         4WOXlFtV7QCKZwudvnFNGFUpHPsEG1fItns3ix5Tt9WB4goV2oY2AsZIVj8Msupn4USY
         gTpkHldv1lDVbDvywNDeNkQTeUtT+13KmR6jiveXSA07yZRLY7/Q0BjCHJWQdONSrNPt
         NNmtoL0lVYQUaOyLXhKFVEyU50vetBCmdygKV0S3Hu8qoe63+ggHL1bpwKvOkpCzXELa
         ULBlnDhGWktTOj4aUw5EHwTjsNp39DzsvwulPVvdQpIsx7djcU28269azNDMj0wmJSQ2
         zmwA==
X-Gm-Message-State: AOAM533VQnYdmN2BlVKTCnrOJ6h47Eq7xh0tLaaayRHPgDY6xdYyEftg
        rXYjidMTK5VYw9GGhBDjUo0Vibpsh2rlC0T8h6MmbA==
X-Google-Smtp-Source: ABdhPJy0o73WHE0A3cv9ExV8w5v32lkjGY7HEi9/2UOqKDYqJj6nA6Rkora+iRan9kSlqrYhNslmxOIgTSZMmVFi/CA=
X-Received: by 2002:a67:2c82:: with SMTP id s124mr9892311vss.34.1612786045588;
 Mon, 08 Feb 2021 04:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20210201055507.542-1-zbestahu@gmail.com>
In-Reply-To: <20210201055507.542-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Feb 2021 13:06:49 +0100
Message-ID: <CAPDyKFooNGx7JRdiBv4gkMnKr-Q8u_RrAMOXQxE7tZ6C_DxDRw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Use host instead of card argument to mmc_spi_send_csd()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zhangwen@yulong.com,
        zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 at 06:57, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> Since mmc_send_cxd_data() does not care card if opcode is MMC_SEND_CSD.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc_ops.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index baa6314..265d95e 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -296,7 +296,7 @@ int mmc_set_relative_addr(struct mmc_card *card)
>         return 0;
>  }
>
> -static int mmc_spi_send_csd(struct mmc_card *card, u32 *csd)
> +static int mmc_spi_send_csd(struct mmc_host *host, u32 *csd)
>  {
>         int ret, i;
>         __be32 *csd_tmp;
> @@ -305,7 +305,7 @@ static int mmc_spi_send_csd(struct mmc_card *card, u32 *csd)
>         if (!csd_tmp)
>                 return -ENOMEM;
>
> -       ret = mmc_send_cxd_data(card, card->host, MMC_SEND_CSD, csd_tmp, 16);
> +       ret = mmc_send_cxd_data(NULL, host, MMC_SEND_CSD, csd_tmp, 16);
>         if (ret)
>                 goto err;
>
> @@ -320,7 +320,7 @@ static int mmc_spi_send_csd(struct mmc_card *card, u32 *csd)
>  int mmc_send_csd(struct mmc_card *card, u32 *csd)
>  {
>         if (mmc_host_is_spi(card->host))
> -               return mmc_spi_send_csd(card, csd);
> +               return mmc_spi_send_csd(card->host, csd);
>
>         return mmc_send_cxd_native(card->host, card->rca << 16, csd,
>                                 MMC_SEND_CSD);
> --
> 1.9.1
>
