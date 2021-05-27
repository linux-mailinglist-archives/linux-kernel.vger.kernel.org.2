Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4873928EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhE0HyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhE0Hxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:53:55 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD76C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 00:52:22 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e10so4274730ybb.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 00:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxZRqzKFWb1Y87fPfbykTjlJa58FgkaWsZdn9yxxAF0=;
        b=ohKnheeO9lw20HQ8vQ8NSMuPFW2XnralAUzb48mwpRFmdwLE1K2D4EqQEwiE73KzsV
         6BTbQlhXn4wJgjHxP0kNe71rBXGwNtZcxEh4zA9tuscSY5bWAcds/JCsnznhpo1ykApK
         iVpE130RYrNv9hqu0dOflNkZ6P/UyVNRUqBqxKZuUuyAEV37UYZDhPmlObH3A6qiJHJE
         u/72MFH+G0WtEgbp1Dg503GHQqnYnbT2phhjr2mvHgsQOMD00h9FQqfKNQiUEhT7fgVU
         NOtPw0NCxQ1UQ6tEZriSbq//8P5wxxHBQvwYudCQ6JZlM9NkNfKgrydjE0InzohGEggS
         9WQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxZRqzKFWb1Y87fPfbykTjlJa58FgkaWsZdn9yxxAF0=;
        b=ZatnRE0ZknAJEGgpPLs8z6+fQtSvJGKi5fJP0CzsJBcqlsW29JyClfHorh/3Wq8c3o
         LiIyCfOnm9y0oXK4QBmVwXlVVfc8U0c1RiD15Ssld3LNhWwvO7yMvYMlXVQx5NEVxe7n
         V8+MNqR5+AYRNp6Tj/0ByQ4M1B6/xYCHOsuCx2vjms4wfhSBEwuntAltjP7N6lUky2ZW
         bPw8loMcIsVy1TbFxD4AYEiq/ja23FNqpb2TEvRK9x3iqJdf8aoKr/ZnRbQkZTnijAX8
         zi10s23OHlPkLMQR0PXQ7lMDRoUP09+VzvKZVeA3a4Yo+gallnziwxESdjnX0Mk/i7Kj
         GtTQ==
X-Gm-Message-State: AOAM532+G/aAUM3gwli+Yd0/V8fBk1shjgU9r1d8db4oOtWRh6Ry3Ni9
        p3EyMNsF6QAxSdyMzmR2igX5rbD44jHCOlS+uN+vkQ==
X-Google-Smtp-Source: ABdhPJzDKzkaBFFlIiYOU0ceXYoE/rWCPdBuXjV6bFmUfbcErknheYcx8XQvj3zkVSPHFDYlXM4aOKDH3Y6t2oztK14=
X-Received: by 2002:a25:6990:: with SMTP id e138mr3012583ybc.0.1622101941734;
 Thu, 27 May 2021 00:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210525165539.25330-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20210525165539.25330-1-srinivas.kandagatla@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 27 May 2021 09:52:11 +0200
Message-ID: <CAMpxmJXipNXMP1qvnPGhzDaBoP1of6XQVO70HGhH6Y9U1JFGUw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] gpio: wcd934x: Fix shift-out-of-bounds error
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, john.stultz@linaro.org,
        amit.pundir@linaro.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 6:55 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> bit-mask for pins 0 to 4 is BIT(0) to BIT(4) however we ended up with BIT(n - 1)
> which is not right, and this was caught by below usban check
>
> UBSAN: shift-out-of-bounds in drivers/gpio/gpio-wcd934x.c:34:14
>
> Fixes: 59c324683400 ("gpio: wcd934x: Add support to wcd934x gpio controller")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> changes since v1:
>         - removed unnecessary dump stack from log
>
>  drivers/gpio/gpio-wcd934x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
> index 1cbce5990855..97e6caedf1f3 100644
> --- a/drivers/gpio/gpio-wcd934x.c
> +++ b/drivers/gpio/gpio-wcd934x.c
> @@ -7,7 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/of_device.h>
>
> -#define WCD_PIN_MASK(p) BIT(p - 1)
> +#define WCD_PIN_MASK(p) BIT(p)
>  #define WCD_REG_DIR_CTL_OFFSET 0x42
>  #define WCD_REG_VAL_CTL_OFFSET 0x43
>  #define WCD934X_NPINS          5
> --
> 2.21.0
>

Applied, thanks!

Bart
