Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E00E35BB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhDLHwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbhDLHww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:52:52 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE2DC06138C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:52:35 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id i2so2652064vka.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJ+eWTN1Q7nm78NrogVg2zBz7YfAz3X1yFeBCHiZpzk=;
        b=u+uP91a3a2c4GTsoSDhAvKYvbriIpEZ2jFQOtBcjzejehhsIdSvmAxYdaqGYz33ZIw
         MAS7AaNqfFaFRWhWFOPV0AIqS8qzbGpPH82YiSht1YSNOPlxfg+GUYVSs0mLcKfFz8cy
         S81gkoQmZiTPOaTB0e4aqSSyE5KVvS6il/4MP0VrMS1qrvGbixf9Suq16SsZ7LmWyfSM
         z/ztNqoTk9iE/x2ubWluk9gvEqkiu5j3oFzG6HKTR8VhC6LptsTiqotKdf9tTyx3ns0b
         xxAe+ncoYiIm4G9j435TNfi8NMOF3dXoSslHBvmJP5cf2JzQdQnHLkFIZJz+L+QyEvfc
         rOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJ+eWTN1Q7nm78NrogVg2zBz7YfAz3X1yFeBCHiZpzk=;
        b=s8dD59vBJj3QQkIeTStofl15qjd/6Ful4wLHntLy8YzaZC+nY3M24kCCUb9pTk2+xI
         JD3HvB3uLxwDf8GpK9FHlrqMiFLK9A8mk9rl6Dmyqtv+2dCoMu/Xd3ciyMj8rliaQBgM
         e3kgnWJX/gLmgiEYHsjH+kVKTbSfRpiMh6nnIKyG2yaKGTvqcgzNuPRgAAjSVLXfcS/F
         rXgnCdAwYvidirMHgNTDdT8aN/IqICcAoht4AqvO1XI6XFc8pH7E6B/Kr7sD8t/rVeLG
         zbJ1OuBjEaq+S5OKYFj7OOdMdPYNG89e9VvnHEnwJNln8rGWsRKLegcv+1c8OhP1IRkV
         dVbg==
X-Gm-Message-State: AOAM530mSjOJMfLpXYfiz+zIIskj/l9dz1xqALwNenvFuM1g8jIe3mJZ
        12csXFXDqt1ceA3r45jZEz7K27XFcpPPLPuuPZTrFw==
X-Google-Smtp-Source: ABdhPJxAM5JJdumQOf3mj8Dh3QL6EsDV0dnoXm5y4BSr9fbSHnIXG7aJnOR7+d9FBW8eW1JViaps98UjbkjUOtEFAgY=
X-Received: by 2002:a1f:8d14:: with SMTP id p20mr406050vkd.6.1618213954214;
 Mon, 12 Apr 2021 00:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210402092432.25069-1-huobean@gmail.com> <20210402092432.25069-2-huobean@gmail.com>
In-Reply-To: <20210402092432.25069-2-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:51:57 +0200
Message-ID: <CAPDyKFr-nNkpgjSojaRAOAEBPD3foi2GTJ=6EcyoEe89HQm61w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mmc: core: Pass down user specified timeout value
 to sanitize
To:     Bean Huo <huobean@gmail.com>
Cc:     "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2021 at 11:24, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> As the density increases, the 4-minute timeout value for
> sanitize is no longer feasible. At the same time, devices
> of different densities have different timeout values, and it is
> difficult to obtain a unified standard timeout value. Therefore,
> it is better to pass down user-specified sanitize timeout value.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c   | 2 +-
>  drivers/mmc/core/mmc_ops.c | 7 +++++--
>  drivers/mmc/core/mmc_ops.h | 2 +-
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index fe5892d30778..8bfd4d95b386 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -539,7 +539,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>
>         if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_SANITIZE_START) &&
>             (cmd.opcode == MMC_SWITCH))
> -               return mmc_sanitize(card);
> +               return mmc_sanitize(card, idata->ic.cmd_timeout_ms);
>
>         mmc_wait_for_req(card->host, &mrq);
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index f413474f0f80..ccca067db993 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -1010,7 +1010,7 @@ int mmc_cmdq_disable(struct mmc_card *card)
>  }
>  EXPORT_SYMBOL_GPL(mmc_cmdq_disable);
>
> -int mmc_sanitize(struct mmc_card *card)
> +int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
>  {
>         struct mmc_host *host = card->host;
>         int err;
> @@ -1020,12 +1020,15 @@ int mmc_sanitize(struct mmc_card *card)
>                 return -EOPNOTSUPP;
>         }
>
> +       if (!timeout_ms)
> +               timeout_ms = MMC_SANITIZE_TIMEOUT_MS;
> +
>         pr_debug("%s: Sanitize in progress...\n", mmc_hostname(host));
>
>         mmc_retune_hold(host);
>
>         err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_SANITIZE_START,
> -                        1, MMC_SANITIZE_TIMEOUT_MS);
> +                        1, timeout_ms);
>         if (err)
>                 pr_err("%s: Sanitize failed err=%d\n", mmc_hostname(host), err);
>
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 632009260e51..1ed0d0375780 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -46,7 +46,7 @@ void mmc_run_bkops(struct mmc_card *card);
>  int mmc_flush_cache(struct mmc_card *card);
>  int mmc_cmdq_enable(struct mmc_card *card);
>  int mmc_cmdq_disable(struct mmc_card *card);
> -int mmc_sanitize(struct mmc_card *card);
> +int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms);
>
>  #endif
>
> --
> 2.25.1
>
