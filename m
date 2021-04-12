Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6837835BB1D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbhDLHpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhDLHpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:45:11 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37314C06138C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:44:54 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id g4so6168405vsq.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rux4LnTGd+o0ZDkm2rK5JaA4uc/5P3BY5Hh01flfgVc=;
        b=XN7GE3HPB/zIHqp9TleM31A6+vpyl/Dg/vnZN6HK2s+9PkKLajabN2lpRqdsOBJXsz
         QaR0mofVP0quxYWicwDOSCuESVHgMoOfxAiDiFaKe5FqFMADNv4pCrmsp4XJmetNOmj6
         1L+VboBeRrm6W4gJWarEfmu79SWrXFaRjhL3tWXwhb+HGLQ20UqwAuw5p9Qoh94Obs42
         obZKjde53LJDy2unGq/WGI+CniTW9lrTDO46MLQj/yZ6WWDFs21c4U61RDyph2d0TaOt
         At+JXTc68JZfmYSxlNHn6U1l3pjjLIgvvv1kS7G2iOF5iaYem5h2ZFm/FOFB2jzsq6Fx
         N9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rux4LnTGd+o0ZDkm2rK5JaA4uc/5P3BY5Hh01flfgVc=;
        b=MoVPC+Xb86t8swvolWvvPe5rMVoxl4WG7GieIWKjU0GsHIFO9+cpyV8g9fQPXaFSb8
         yB7htyFOBUhKdHpUFA8NdcEPFWWy4vQVfrFyrgIBmUtTee+ZWlBOQKxhTuSW4RHs9P3g
         a1MEicdUGBBOzC4UnwXp0PkZbdYJxQjFV00FG/frElxhUjNZjFkwt+RjA778z5+1OBKi
         t0/AnfozxL1u+ynIQwleJzMUwKICSbz7fGBxf3nEYKSdSy44Fzu668ofldoFiQb6F0uY
         HjZMMr3x51G2JIsgDXMu69LkeS2wm0ihzZ//9oITakMHr8O3lCi50Mtjmg10L/FU8lPn
         2I6Q==
X-Gm-Message-State: AOAM532UO+bwJHDsnFCkwuGHwUA44yd+7pxlJvAqTysg16kLTsqtGq9a
        lcVJeASxj/tZs00vacEUUtPIpme9xhHNo2TFqZExew==
X-Google-Smtp-Source: ABdhPJz0HNH8WN3/vlJYhiWeOmnVuF1SVVIi/Mn4Q0PBGv4sP7ZUhhvE4Vz3Vm656OYqrfJ858yqMvbog0eLDFBwt9g=
X-Received: by 2002:a67:6942:: with SMTP id e63mr19255741vsc.48.1618213493418;
 Mon, 12 Apr 2021 00:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210408175951.22450-1-scott.branden@broadcom.com>
In-Reply-To: <20210408175951.22450-1-scott.branden@broadcom.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:44:17 +0200
Message-ID: <CAPDyKFrBMGjCFCwgaJ1D5f+VJSenp369MDP7KS_PY9JaPYA0Hg@mail.gmail.com>
Subject: Re: [PATCH] mmc: add quirk to disable eMMC cache for Micron eMMC v5.0 cards
To:     Scott Branden <scott.branden@broadcom.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Bean Huo, Luca Porzio

On Thu, 8 Apr 2021 at 19:59, Scott Branden <scott.branden@broadcom.com> wrote:
>
> From: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
>
> In certain rare combination of operations, Micron eMMC v5.0 cards
> may experience data errors if internal cache is enabled.
> This may lead to eMMC related data errors.
> Introduce a quirk to disable cache on these eMMC cards.

Can you please elaborate on this, what combinations of operations are
you referring to - and what kind of data errors?

I have also looped in some of the Micron guys, to let them chim in.

>
> Signed-off-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Kind regards
Uffe

> ---
>  drivers/mmc/core/card.h   | 5 +++++
>  drivers/mmc/core/mmc.c    | 4 ++--
>  drivers/mmc/core/quirks.h | 8 ++++++++
>  include/linux/mmc/card.h  | 1 +
>  4 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 7bd392d55cfa..22cea63ac359 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -222,4 +222,9 @@ static inline int mmc_card_broken_hpi(const struct mmc_card *c)
>         return c->quirks & MMC_QUIRK_BROKEN_HPI;
>  }
>
> +static inline int mmc_card_broken_cache(const struct mmc_card *c)
> +{
> +       return c->quirks & MMC_QUIRK_BROKEN_CACHE;
> +}
> +
>  #endif
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 8741271d3971..cd83b7f0e59c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1820,12 +1820,12 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>          * sudden power failure tests. Let's extend the timeout to a minimum of
>          * DEFAULT_CACHE_EN_TIMEOUT_MS and do it for all cards.
>          */
> -       if (card->ext_csd.cache_size > 0) {
> +       if (!mmc_card_broken_cache(card) && card->ext_csd.cache_size > 0) {
>                 unsigned int timeout_ms = MIN_CACHE_EN_TIMEOUT_MS;
>
>                 timeout_ms = max(card->ext_csd.generic_cmd6_time, timeout_ms);
>                 err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -                               EXT_CSD_CACHE_CTRL, 1, timeout_ms);
> +                                EXT_CSD_CACHE_CTRL, 1, timeout_ms);
>                 if (err && err != -EBADMSG)
>                         goto free_card;
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index d68e6e513a4f..23972d87c82a 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -116,6 +116,14 @@ static const struct mmc_fixup __maybe_unused mmc_ext_csd_fixups[] = {
>         MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_NUMONYX,
>                               0x014e, add_quirk, MMC_QUIRK_BROKEN_HPI, 6),
>
> +       /*
> +        * In certain rare combination of operations, Micron eMMC v5.0 cards
> +        * may experience data errors if internal cache is enabled.
> +        * Disabling cache for these cards eliminates the issue.
> +        */
> +       MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_MICRON,
> +                             0x014e, add_quirk, MMC_QUIRK_BROKEN_CACHE, 7),
> +
>         END_FIXUP
>  };
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index f9ad35dd6012..22f256a4e54e 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -270,6 +270,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_IRQ_POLLING   (1<<11) /* Polling SDIO_CCCR_INTx could create a fake interrupt */
>  #define MMC_QUIRK_TRIM_BROKEN  (1<<12)         /* Skip trim */
>  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
> +#define MMC_QUIRK_BROKEN_CACHE (1<<14)         /* Disable broken cache */
>
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>
> --
> 2.17.1
>
