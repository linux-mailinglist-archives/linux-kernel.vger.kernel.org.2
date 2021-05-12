Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECBE37BBC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhELLaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhELLaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:30:08 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E64BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:29:01 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id y2so30224659ybq.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYW19CtIYX5b303IOQcUpayuvfixsQxy2ywXap3Gdw8=;
        b=Wj0OwZiHkM6iRX5HATAPY4QjiL19CWgBhNUCmTbESC8KXGVWxuOQ4faOLt9qDhMruz
         ryQu0gae6t1zldbjD7Avs4M7FFVelazppGMwNove7SVFlkI7zQbAviqGnxdOqRi10zZQ
         h3pZ3s04LdoMze7oFWPOIr/YD0AvFTgw4+JiREWY9XuIAtae62ZFO2QU8iEinc86GgYS
         gc4pfVGhcDxegiHbqaZMI0P5lAWdfQbwuIvYDz5cG3nD7mDnI6xMks8ajyorINLak/80
         UzGKR5PPnbSHZRcHux+8Dwqo6vM9+jG65cpt6vCaOVKkkXWCfu4Isny2qWnIbbnOHAl3
         ly/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYW19CtIYX5b303IOQcUpayuvfixsQxy2ywXap3Gdw8=;
        b=mdT+cXcJqKhCdkbftY+bEE0HIEg2XP1vcdhcYfmOoGfH2kI2XRSFAVba5CO/RTegel
         fp5gtAI1Lya5rx06sFo37TOYARW7LJ0d2D+hqibe6ST6GiWT0NIxWleVvqZY3H4jIeie
         2s+I99CdxCieYYsCf7QAx4RDgAmRjZy+jxsW3niwoJW6i03cTCz8zaGQJwn5UWl4N6yG
         km3anHyw3bqZYgHjJVYNvUAM5J2p6mGOzSOEgIX6xbj16c3Aezxk9aFQIVsnJhqBIXt/
         XMYoA2hPyI8XEitjLye8VXKDeWHdHjeTtQFrJ8yhRujzKnwDbFOSzu0wbLsou0A7aokr
         BWDw==
X-Gm-Message-State: AOAM532iWxVPqGSK04e/htnugCfUGJK2HMY/LB+9bSAmqvSxelWdz7id
        zmTbDy7tOk2WvQNpMgDKAJA1QuBx9FbzyBUozoWXEVhL3iU=
X-Google-Smtp-Source: ABdhPJwWtMZXoSwSYR+0ZdiTaVOc7tWGTRp9rkRLD3gw7rnAptbJhgCV5tVck4DFUGDCsMQj112BK3NUqSifyozJc/Y=
X-Received: by 2002:a25:cb96:: with SMTP id b144mr41691498ybg.312.1620818940410;
 Wed, 12 May 2021 04:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <1620789467-15227-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1620789467-15227-1-git-send-email-zou_wei@huawei.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 12 May 2021 13:28:49 +0200
Message-ID: <CAMpxmJX2dt1=_yW14df5tpEiRN0_LAgLdamNx+3d==CRxM6s8w@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: cadence: Add missing MODULE_DEVICE_TABLE
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 5:01 AM Zou Wei <zou_wei@huawei.com> wrote:
>
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/gpio/gpio-cadence.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-cadence.c b/drivers/gpio/gpio-cadence.c
> index a4d3239..4ab3fcd 100644
> --- a/drivers/gpio/gpio-cadence.c
> +++ b/drivers/gpio/gpio-cadence.c
> @@ -278,6 +278,7 @@ static const struct of_device_id cdns_of_ids[] = {
>         { .compatible = "cdns,gpio-r1p02" },
>         { /* sentinel */ },
>  };
> +MODULE_DEVICE_TABLE(of, cdns_of_ids);
>
>  static struct platform_driver cdns_gpio_driver = {
>         .driver = {
> --
> 2.6.2
>

The tag should be just regular [PATCH] as this driver has been
upstream for a long time.

Applied for fixes, thanks!

Bartosz
