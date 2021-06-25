Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2383B41BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhFYKgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhFYKgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:36:46 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EB2C061760
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:34:26 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id m9so3896533ybp.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmRoCA65RV/48lXb3m2W6DafsVGVfuNgmtDKbzVBlOA=;
        b=FWC1UozMFhPqEhM/hP+0y5unvamFh2uadP93DvbTr2PyYZf/kVCF3ETNEZqEX8zTMB
         oIl80SOor1haIN3P9b/UQkx6fTTs7v9lnF4gvBhpRK85zzD3U5OIIveCV2JUx6UmCBui
         A1Up9ynYHTTM5KXy+cP1HKCUiRRKFBCqEGhbFWeC92EqwNghmAfdP7ts0TEv6SqjDdJo
         U5bglVx+8fc04q13Nez+t2G0Q/sRLHE6d2SpVr9qgTb4dpV/fj5BAQ0EHKpbA2mwnU8z
         hWAMZbljrgeZOURPYcC0dwnU5PS8MhIwF/OMMt3tvZGAgg2swVIxSbdKPoxqwhFis+Ps
         pABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmRoCA65RV/48lXb3m2W6DafsVGVfuNgmtDKbzVBlOA=;
        b=bzDbsh2DVP7HG5vatyKynriz3LS1YkqFvGMTslm4oPaSo/vi/LODuCWfcHQ6Prdhn6
         4RKUYgbPEKxgOhheIm4REX/F6UjN7rERTEfLx5zlSZ+iHZlhzsZUaE7Eb3mOJqrh2qH/
         Og+lPrExvm16iYYiZkdjwVSOp5hoJJQakkc70O1R53a8jP1fgF8GrcKwBCTBZ2S9U5E8
         4geCB1605/s5nEJg3H1Gq2IItVVijIuuySWlu5WYhPC9igxAT1XRRwu5UvhShic3coHv
         KvdQ0G0sKlsnF2RbmTiE5OmSpWZR6uPEIxUaas2+5mQuCpuoYF9uh8Mk78GgCLvjKy9O
         rBww==
X-Gm-Message-State: AOAM533YZh08feJ1bacPbPsOmQg1ObbKODprkl3QAMwSTKejBx9Lc1Rw
        AO8UW1chf9XPuvzHczFT4hhhyK2lomhzgkyimz7DuA==
X-Google-Smtp-Source: ABdhPJxbFIO0pNolVnUaaWoQ6RTnzn35uYITFDDGruDFy0XC7E5sj/9OtjT5EajI6aCgtMbCf8DtfpJd/Ny8AINHHfQ=
X-Received: by 2002:a25:738e:: with SMTP id o136mr11354409ybc.469.1624617265375;
 Fri, 25 Jun 2021 03:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210624101517.15167-1-wjc@cdjrlc.com>
In-Reply-To: <20210624101517.15167-1-wjc@cdjrlc.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 25 Jun 2021 12:34:14 +0200
Message-ID: <CAMpxmJUsnAYbAyY8OaO6fm27Sj+itxge4PqBdefUBXv5WK7Tqw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: mxs: Prefer unsigned int to bare use of unsigned
To:     Jinchao Wang <wjc@cdjrlc.com>
Cc:     "andy.shevchenko" <andy.shevchenko@gmail.com>,
        shawnguo <shawnguo@kernel.org>,
        "s.hauer" <s.hauer@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 12:15 PM Jinchao Wang <wjc@cdjrlc.com> wrote:
>
> Fix checkpatch warnings:
>     WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>
> Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>
> ---
> - changes for v2:
> - Use full prefix
>
> ---
>  drivers/gpio/gpio-mxs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
> index 524b668eb1ac..31a336b86ff2 100644
> --- a/drivers/gpio/gpio-mxs.c
> +++ b/drivers/gpio/gpio-mxs.c
> @@ -229,14 +229,14 @@ static int mxs_gpio_init_gc(struct mxs_gpio_port *port, int irq_base)
>         return rv;
>  }
>
> -static int mxs_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
> +static int mxs_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
>  {
>         struct mxs_gpio_port *port = gpiochip_get_data(gc);
>
>         return irq_find_mapping(port->domain, offset);
>  }
>
> -static int mxs_gpio_get_direction(struct gpio_chip *gc, unsigned offset)
> +static int mxs_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
>  {
>         struct mxs_gpio_port *port = gpiochip_get_data(gc);
>         u32 mask = 1 << offset;
> --
> 2.31.1
>

Applied, thanks!

Bartosz
