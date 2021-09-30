Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC0041D8AA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 13:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350451AbhI3L1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 07:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350431AbhI3L1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 07:27:12 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84493C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:25:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b20so24022277lfv.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ke+BZ+t9vF4CFbEDSnpC2W+EYJHQEFl6kKpmD6g3eV4=;
        b=oyKPw1V9o9B7Wi1y655+90c7jwR37EqU3ZowZR3HqqKiu5GuCjyIx8VArNgqFZ1SQj
         DXQLvA08h4KAOJp66yetZPTyJmgByquxJkKHb/+4CsVhx8hws1w7klbIN8HFEgIZmVjE
         Wx+B2ECH9XBVpj2odxok8g1842irYIik4LsfT+ABocLh1T8Fk2PO+8ytakEtisN8bssG
         OB59Tgl07rr8yzbHxkloCbnVTrd+2TkQLNEXbz6g3gPQuUd1gXca3CLO2ZFC/gdGsu7/
         rW3vNF+b26ggrUz6o/P0gf9d5XWVCHYOWc+tKqx+utl8do32t1VtrL2aoplkkuYXijgS
         8V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ke+BZ+t9vF4CFbEDSnpC2W+EYJHQEFl6kKpmD6g3eV4=;
        b=42MM54NzrB/otfqXVrtzxQ+F8Msn5V7pU8GUYN65Y94oDbfmgC+GHsl/o/LR/UbmiH
         YOGW9ubUwgobo++zQ3wpHrqOfofVEkPpmYt+p1zSXeiDKiKORx6RAxSuQsHwqanVUmE+
         fEMlHrh94yolBkl+Yg9irKCXXUNDgG7pJ5v6/BTw1CIXe7bwAQv5ceVOwQoY7ilTC5Pr
         3a31CYvZQSnCwcOmBdk/K5FNCr1+DEqKx9xAsR1pBFrUjc5xLm3dU6kvv2HLQp6TQQ2a
         TEmhwaG7gA81mOTIkgscicKHgBgxvT7Cxbxn9fWEmWIEwjXIf0ewP2vJ+riRDLv4zLdk
         wYNA==
X-Gm-Message-State: AOAM533UcIwbbjdP8jNSt6wAC8FP4THNt0HKo+YtCgk3uw1RKpUCR2t6
        oteWrOMKIjv6BA1IiMv8puYEmp+AH4nCF+Vwgqm3PohRtH8=
X-Google-Smtp-Source: ABdhPJxPxKxrGrD/Gw8CRTBdOkQyaLCrwNtl/ZXD361kWQl5ZgdQbzfUJ0tW5GADs8knmpWWQeEwUNwRT/VMoI9aVAM=
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr5427673lfb.71.1633001127934;
 Thu, 30 Sep 2021 04:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210929111757.52625-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210929111757.52625-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Sep 2021 13:24:51 +0200
Message-ID: <CAPDyKFrRC4Q4v+rZVVEaj3zdYdMGoO=WnLAocHnaJWk96zxmtg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: slot-gpio: Refactor mmc_gpio_alloc()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sept 2021 at 13:17, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Refactor mmc_gpio_alloc() to drop unneeded indentation level
> and double condition. This increases readability of the code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/slot-gpio.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 05e907451df9..e365d328f43c 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -39,24 +39,24 @@ static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
>
>  int mmc_gpio_alloc(struct mmc_host *host)
>  {
> -       struct mmc_gpio *ctx = devm_kzalloc(host->parent,
> -                                           sizeof(*ctx), GFP_KERNEL);
> -
> -       if (ctx) {
> -               ctx->cd_debounce_delay_ms = 200;
> -               ctx->cd_label = devm_kasprintf(host->parent, GFP_KERNEL,
> -                               "%s cd", dev_name(host->parent));
> -               if (!ctx->cd_label)
> -                       return -ENOMEM;
> -               ctx->ro_label = devm_kasprintf(host->parent, GFP_KERNEL,
> -                               "%s ro", dev_name(host->parent));
> -               if (!ctx->ro_label)
> -                       return -ENOMEM;
> -               host->slot.handler_priv = ctx;
> -               host->slot.cd_irq = -EINVAL;
> -       }
> +       const char *devname = dev_name(host->parent);
> +       struct mmc_gpio *ctx;
> +
> +       ctx = devm_kzalloc(host->parent, sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       ctx->cd_debounce_delay_ms = 200;
> +       ctx->cd_label = devm_kasprintf(host->parent, GFP_KERNEL, "%s cd", devname);
> +       if (!ctx->cd_label)
> +               return -ENOMEM;
> +       ctx->ro_label = devm_kasprintf(host->parent, GFP_KERNEL, "%s ro", devname);
> +       if (!ctx->ro_label)
> +               return -ENOMEM;
> +       host->slot.handler_priv = ctx;
> +       host->slot.cd_irq = -EINVAL;
>
> -       return ctx ? 0 : -ENOMEM;
> +       return 0;
>  }
>
>  int mmc_gpio_get_ro(struct mmc_host *host)
> --
> 2.33.0
>
