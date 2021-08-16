Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBC43ED86F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhHPOCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhHPOAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:00:23 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0718C0612A8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:59:36 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id v26so3880418vsa.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrII97R9ADzSkpz5bm6tsH8fcBbWSF/zk08tsiVqE3g=;
        b=qsJ8Ou9oVBxPwrXLQY0RRC7ivFXF3gnatanqcUcKV8RSdE/kQnZ65vI9NxlvZFyUKT
         YALl4pBaf0W3xBC2bWl+M95bVlfBMIW7DUzBn6kiI5JksNr5tXYSuKzMdwlf8j0BCoPo
         fgW/J7ym0NzCOYeFrbBXSFGvNkhw44DQ3JkJisPshO8hE5iIMS4oVi02KZZYHOPrnPOI
         dIwis+hIE8IIY60q7LJaYR6tCBm3sE/YRh2mv5fYXocF17GD2hkotspKGQIwGcxnVZ+B
         6JAkzB1+joJoHVAIjIxK5FTuEEKoTN6fdYMr0GOo9iNuRTY7oZfUlUWIzpwGbh4H5uli
         oyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrII97R9ADzSkpz5bm6tsH8fcBbWSF/zk08tsiVqE3g=;
        b=RMUc78eKyOzw4WyvNrMeKmZxiaSqv/easCODDbfX7CLRzdphNnnXBe7QMF1VIF3O8x
         MtxwRMvVWvymGpo7bHBkqzLghlMFswkTpJIeN6zEqJt1MXA1almMnuIGwYzX+tcRe/sD
         zDuhunG3DB68o6KsOKRk6GD1D7F6rwpDynthfkm5D3kCYU8CPbuf9ze5zR4fL0MLHoCn
         /3lBJ3yfXEOM5qvEuVUxoBYNm+Op0cLhrPbBaSDaXdxG4O2bJLhDQ1AXJK0eyXr0IU6p
         f1E5oaOhR3PWoYVlZcgb9bZIhfiO1CIuKsm/OqLwi2D4KQ1mlvoF9LzmqIAwqI24h5oS
         Rp0w==
X-Gm-Message-State: AOAM531dh7kF4c2+T/J/ulyDBJpt7v3B/Ov+t6F4I7mROY52JcxM9FJV
        rMi6Oi5C6XZ/P+0MoM550D6r1v8p1wacJ8ml7YugNA==
X-Google-Smtp-Source: ABdhPJwokJtd5yc9yJUou2gAS8aHmlXPKBVY+W8VtEDj9mdLwmXmFeHQYZSmwY2vonD7cu7RrYdco4+ENtJDgoZ43mM=
X-Received: by 2002:a67:7949:: with SMTP id u70mr1602635vsc.55.1629122376058;
 Mon, 16 Aug 2021 06:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <2fef280d8409ab0100c26c6ac7050227defd098d.1627818365.git.tommyhebb@gmail.com>
In-Reply-To: <2fef280d8409ab0100c26c6ac7050227defd098d.1627818365.git.tommyhebb@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Aug 2021 15:58:58 +0200
Message-ID: <CAPDyKFr7QAsDbE8TrZtTcUL1hKAw2_dMZRU5QngzT3VwUTktfg@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: fix long reads when clock is prescaled
To:     Thomas Hebb <tommyhebb@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ricky Wu <ricky_wu@realtek.com>,
        Rui Feng <rui_feng@realsil.com.cn>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2021 at 13:46, Thomas Hebb <tommyhebb@gmail.com> wrote:
>
> For unexplained reasons, the prescaler register for this device needs to
> be cleared (set to 1) while performing a data read or else the command
> will hang. This does not appear to affect the real clock rate sent out
> on the bus, so I assume it's purely to work around a hardware bug.
>
> During normal operation, the prescaler is already set to 1, so nothing
> needs to be done. However, in "initial mode" (which is used for sub-MHz
> clock speeds, like the core sets while enumerating cards), it's set to
> 128 and so we need to reset it during data reads. We currently fail to
> do this for long reads.
>
> This has no functional affect on the driver's operation currently
> written, as the MMC core always sets a clock above 1MHz before
> attempting any long reads. However, the core could conceivably set any
> clock speed at any time and the driver should still work, so I think
> this fix is worthwhile.
>
> I personally encountered this issue while performing data recovery on an
> external chip. My connections had poor signal integrity, so I modified
> the core code to reduce the clock speed. Without this change, I saw the
> card enumerate but was unable to actually read any data.
>
> Writes don't seem to work in the situation described above even with
> this change (and even if the workaround is extended to encompass data
> write commands). I was not able to find a way to get them working.
>
> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 36 ++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 4ca937415734..58cfaffa3c2d 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -542,9 +542,22 @@ static int sd_write_long_data(struct realtek_pci_sdmmc *host,
>         return 0;
>  }
>
> +static inline void sd_enable_initial_mode(struct realtek_pci_sdmmc *host)
> +{
> +       rtsx_pci_write_register(host->pcr, SD_CFG1,
> +                       SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_128);
> +}
> +
> +static inline void sd_disable_initial_mode(struct realtek_pci_sdmmc *host)
> +{
> +       rtsx_pci_write_register(host->pcr, SD_CFG1,
> +                       SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_0);
> +}
> +
>  static int sd_rw_multi(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
>  {
>         struct mmc_data *data = mrq->data;
> +       int err;
>
>         if (host->sg_count < 0) {
>                 data->error = host->sg_count;
> @@ -553,22 +566,19 @@ static int sd_rw_multi(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
>                 return data->error;
>         }
>
> -       if (data->flags & MMC_DATA_READ)
> -               return sd_read_long_data(host, mrq);
> +       if (data->flags & MMC_DATA_READ) {
> +               if (host->initial_mode)
> +                       sd_disable_initial_mode(host);
>
> -       return sd_write_long_data(host, mrq);
> -}
> +               err = sd_read_long_data(host, mrq);
>
> -static inline void sd_enable_initial_mode(struct realtek_pci_sdmmc *host)
> -{
> -       rtsx_pci_write_register(host->pcr, SD_CFG1,
> -                       SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_128);
> -}
> +               if (host->initial_mode)
> +                       sd_enable_initial_mode(host);
>
> -static inline void sd_disable_initial_mode(struct realtek_pci_sdmmc *host)
> -{
> -       rtsx_pci_write_register(host->pcr, SD_CFG1,
> -                       SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_0);
> +               return err;
> +       }
> +
> +       return sd_write_long_data(host, mrq);
>  }
>
>  static void sd_normal_rw(struct realtek_pci_sdmmc *host,
> --
> 2.32.0
>
