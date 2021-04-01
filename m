Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7423522E1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhDAWtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhDAWtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:49:01 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23148C061788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 15:49:01 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id r12so2005446vsj.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 15:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CuQ+fCWT1rB0+aM1K1k9N1tiDK8VwSM2eHjqwE/nxl4=;
        b=NgEFUiTAnq7fFFmR24/kSiMIspDQaRD7nNmLUnNyKOeW+G7lpmB+ONc5P+2KgMxBYI
         /ZX3auaZZMpq+VpOTviFa1VUNFiAc2DjCwrO4KcfwEyDgqEoyZW7UBlVPP4ubw4GjUzv
         BL18fLWz1/rsIafumpOMnTAD24pdNJHlV+SluJpL3Ve6gZDzFMUdRq5ov3ZJ61MoORy3
         GO7ZjIhQv6xkN1wD/FeI46rPxqEcGtXRkmez1C5hmU/SQHlK1Wn6JRsEZXSM8VhKy6r9
         glg0xX6ZrJm57eqjA/FUUt2xj7qmDxXIhgdXt9lHSIAwsr5dboaC1UFNjwiAkm9/Cn7Q
         vlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuQ+fCWT1rB0+aM1K1k9N1tiDK8VwSM2eHjqwE/nxl4=;
        b=OJnMzaPI7SnxriCaauiXnTH3aYvSGdaxxtku6On7L1AIkU6qS6YhElMuxAtAKoCD6h
         s8R7WZAhlmwx4mg2zFZBl18IcphiEmCuJ1h4m3gOnVhiLQsRx+ZYIcRrMb0BM5UqFivV
         N1LXRMh4rP9sse/MJUbRET1PJlITyea/F77ypRiR4fLr7IT4C2FZuKyWllgJYYmTkVHG
         lPWFqTCkuRnwxUf5Q11aC0bV5JBsb71pYLU8OujczMAuBwfwOJU4MRCqcWOYZUtKKEyU
         rtdoXxCZUhcLAzh/MqxETz4QzYTJaKyxITddeDI/t/2IyxendT0fvrNxtODgHwWoDBRW
         30kw==
X-Gm-Message-State: AOAM530tz+v1kboIZFkJ3x30nysQ1wLy1vhImRq5/nUMlo9hg1zfihwA
        YGK44WOOSDoF00PKpor9BzUaLALlADrMDWO+UaJM2Q==
X-Google-Smtp-Source: ABdhPJwill4W10z/Ga/+bumBJjZA3QHLAb8FZsvb3UhGM9uwOTbbQbgn4xGXcBQ+inOX2S61q3PNdujrjRQ0yX/e+6I=
X-Received: by 2002:a67:6942:: with SMTP id e63mr7698810vsc.48.1617317340138;
 Thu, 01 Apr 2021 15:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210401132853.105448-1-huobean@gmail.com> <20210401132853.105448-2-huobean@gmail.com>
In-Reply-To: <20210401132853.105448-2-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Apr 2021 00:48:23 +0200
Message-ID: <CAPDyKFryYbahsR4PzFg3JAtSDZr-=cB0+XpgVQ2YJgZgiy9OXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: core: Let sanitize timeout readable/writable
 via sysfs
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

On Thu, 1 Apr 2021 at 15:29, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> As the density increases, the 4-minute timeout value for
> sanitize is no longer feasible. At the same time, devices
> of different densities have different timeout values, and it is
> difficult to obtain a unified standard timeout value. Therefore,
> it is better to let the user explicitly change  sanitize timeout
> value according to the eMMC density on the board.

This makes sense. The current timeout in the mmc core isn't good
enough. However, I think there is a better option than inventing a
sysfs node to allow userspace to specify the timeout.

First, we have the card quirks that the mmc core uses to allow us to
modify a common behaviour (in this case timeouts values for sanitize
operations). This can be used to enforce a specific timeout for the
eMMC card. I think this should take precedence over anything else.

Second, the ioctl command allows you to specify a specific command
timeout in the struct mmc_ioc_cmd (.cmd_timeout_ms). If this is
specified from user space we could forward it to mmc_santize() and use
that rather than the default MMC_SANITIZE_TIMEOUT_MS.

Would this satisfy your needs?

Kind regards
Uffe

>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/mmc/core/mmc.c     | 34 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/mmc_ops.c |  3 +--
>  include/linux/mmc/card.h   |  1 +
>  3 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 8741271d3971..3885cc1780ac 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -28,6 +28,7 @@
>
>  #define DEFAULT_CMD6_TIMEOUT_MS        500
>  #define MIN_CACHE_EN_TIMEOUT_MS 1600
> +#define MMC_SANITIZE_TIMEOUT_MS        (240 * 1000) /* 240s */
>
>  static const unsigned int tran_exp[] = {
>         10000,          100000,         1000000,        10000000,
> @@ -835,6 +836,37 @@ static ssize_t mmc_dsr_show(struct device *dev,
>
>  static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
>
> +static ssize_t sanitize_timeout_ms_show(struct device *dev,
> +                                       struct device_attribute *attr,
> +                                       char *buf)
> +{
> +       struct mmc_card *card = mmc_dev_to_card(dev);
> +
> +       return sysfs_emit(buf, "%d\n", card->sanitize_timeout_ms);
> +}
> +
> +static ssize_t sanitize_timeout_ms_store(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        const char *buf, size_t len)
> +{
> +       struct mmc_card *card = mmc_dev_to_card(dev);
> +       unsigned int new;
> +       int ret;
> +
> +       ret = kstrtouint(buf, 0, &new);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (new == 0)
> +               return -EINVAL;
> +
> +       card->sanitize_timeout_ms = new;
> +
> +       return len;
> +}
> +static DEVICE_ATTR_RW(sanitize_timeout_ms);
> +
> +
>  static struct attribute *mmc_std_attrs[] = {
>         &dev_attr_cid.attr,
>         &dev_attr_csd.attr,
> @@ -861,6 +893,7 @@ static struct attribute *mmc_std_attrs[] = {
>         &dev_attr_rca.attr,
>         &dev_attr_dsr.attr,
>         &dev_attr_cmdq_en.attr,
> +       &dev_attr_sanitize_timeout_ms.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(mmc_std);
> @@ -1623,6 +1656,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                 card->ocr = ocr;
>                 card->type = MMC_TYPE_MMC;
>                 card->rca = 1;
> +               card->sanitize_timeout_ms = MMC_SANITIZE_TIMEOUT_MS;
>                 memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
>         }
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index f413474f0f80..40a4f9e22d30 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -21,7 +21,6 @@
>
>  #define MMC_BKOPS_TIMEOUT_MS           (120 * 1000) /* 120s */
>  #define MMC_CACHE_FLUSH_TIMEOUT_MS     (30 * 1000) /* 30s */
> -#define MMC_SANITIZE_TIMEOUT_MS                (240 * 1000) /* 240s */
>
>  static const u8 tuning_blk_pattern_4bit[] = {
>         0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
> @@ -1025,7 +1024,7 @@ int mmc_sanitize(struct mmc_card *card)
>         mmc_retune_hold(host);
>
>         err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_SANITIZE_START,
> -                        1, MMC_SANITIZE_TIMEOUT_MS);
> +                        1, card->sanitize_timeout_ms);
>         if (err)
>                 pr_err("%s: Sanitize failed err=%d\n", mmc_hostname(host), err);
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index f9ad35dd6012..9db0dcd9661e 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -273,6 +273,7 @@ struct mmc_card {
>
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>
> +       unsigned int            sanitize_timeout_ms;
>         unsigned int            erase_size;     /* erase size in sectors */
>         unsigned int            erase_shift;    /* if erase unit is power 2 */
>         unsigned int            pref_erase;     /* in sectors */
> --
> 2.25.1
>
