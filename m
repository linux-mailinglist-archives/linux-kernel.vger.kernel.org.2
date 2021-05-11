Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C38E37A53B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhEKK6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhEKK6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:58:01 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86D7C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:56:55 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id l4so3120560vsa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krrXoOQowFRAS4ha9BPKaEPs6gzq6K83uwGtNzWwAQg=;
        b=ACnL0dHkwLYgVRLIqXXl9waYOfpeGuw6bxFeIn0GshIdwkCzuuDbsUDkcHVa3iHWbD
         9dMFrYAOSH6caHfutfFKebSEauklzP02eMHhavj642e3BUN6RzyQTAZ06ZzHxH5bsX/p
         AO5X5sJBRZ75Y6HyMrXazCTDY3X8Nox9vnaFXMT0SZHfvuzMeEWhpEYw7g2kBWdv4XU/
         nbbCd5oy+j72M7FLpX1+PnQNZ7OqXnEicQbzxRRjqlV6NUFQB9dhBwOAfq+FiITsBFwL
         oyH4FpASr2Y92pOiXm8TsNiZY9xTSYUEJA7Xi575WTf8k0e/kRc+UgzvshXpjUIh+wTi
         FX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krrXoOQowFRAS4ha9BPKaEPs6gzq6K83uwGtNzWwAQg=;
        b=EFiUli1BPU5uL4jInWzcRJOOB8+6eb4l9SWgnMBS6Tu540bmWl/MRLwMpofVbTddiq
         OaNDKSqtxEhrU/xJVOjzDNOj5Kq9CMjD/mn81e4rAZE+rByxzYJWXgvgMHoXU/sLm1wf
         yQ1G8FGXZI6poen/oFxAhlZ+3Q0xERE+25afF87LIUOLHgmbcxMgxMY5Yr9cLd80AHeL
         eWKNfiB6tkK2eKI4iiFXSoAfcmNngBP4+UUhhkQVc7SBTK7ECz2PN/h99FVjbJsaxS9V
         zh4TcimbFAsx779ZsnFn+262YVbs88WFzDn9Ip3Cs7yd8PqNcIYxbDtdhBGpx7BkFGwv
         UC5Q==
X-Gm-Message-State: AOAM530HXwqanOy5lER1BzT6Qp4JomVf4lMGCYYPZwLg+GuVIsgOOEeA
        eM10LzuDSR/LROK9QG0mQC+DuPbB/Bn4tKRDZ3BP4A==
X-Google-Smtp-Source: ABdhPJxzT/keb4NOKXYCQGmWjolAOxpB1deXwetWTWdB7OlQ0knG8WgebyOQPjN1sx3avf7QixyvXZE1TGni0Xt+ppw=
X-Received: by 2002:a67:f60e:: with SMTP id k14mr25253513vso.48.1620730614934;
 Tue, 11 May 2021 03:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210426175559.3110575-1-narmstrong@baylibre.com> <20210426175559.3110575-2-narmstrong@baylibre.com>
In-Reply-To: <20210426175559.3110575-2-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:17 +0200
Message-ID: <CAPDyKFrZY0vdQrFfAGCRW2MM25WY1rivwiPv8u3aHsfwNPbe-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: meson-gx: also check SD_IO_RW_EXTENDED for
 scatterlist size alignment
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021 at 19:56, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The brcmfmac driver can generate a scatterlist from a skb with each packets
> not aligned to the block size. This is not supported by the Amlogic Descriptor
> dma engine where each descriptor must match a multiple of the block size.
>
> The sg list is valid, since the sum of the sg buffers is a multiple of the
> block size, but we must discard those when in SD_IO_RW_EXTENDED mode since
> SDIO block mode can be used under the hood even with data->blocks == 1.
>
> Those transfers are very rare, thus can be replaced by a bounce buffer
> without real performance loss.
>
> Fixes: 7412dee9f1fd ("mmc: meson-gx: replace WARN_ONCE with dev_warn_once about scatterlist size alignment in block mode")
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 1c61f0f24c09..016a6106151a 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -236,7 +236,8 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>         if (host->dram_access_quirk)
>                 return;
>
> -       if (data->blocks > 1) {
> +       /* SD_IO_RW_EXTENDED (CMD53) can also use block mode under the hood */
> +       if (data->blocks > 1 || mrq->cmd->opcode == SD_IO_RW_EXTENDED) {
>                 /*
>                  * In block mode DMA descriptor format, "length" field indicates
>                  * number of blocks and there is no way to pass DMA size that
> --
> 2.25.1
>
