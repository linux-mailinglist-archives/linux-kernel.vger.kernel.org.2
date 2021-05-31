Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5FE3958D5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 12:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhEaKTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhEaKSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 06:18:50 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C28DC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 03:17:09 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id f11so5781018vst.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 03:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ru/1dgQ0vPtNshZal6qIV36byCdQdei5pfU0MIkHoyY=;
        b=UtYirWiSNztm7JRFtfUkA2Bi9y6QA/JrlPTD33m6LKXzF+ghRad8sQhprC1EQ74ooV
         NKzBTNjh2QBxUXqK7pxIrOospXfy/Z5Ly38gkQwYGb5GpiLyvsPWUIySTmKTK9eIWtNu
         mzc/KOj7FG7+DkeuimbFAWCKLusMARfo86xDAhMuytJWRrtk7ZGPUw8L5GgSwm5NeBa0
         qp1vQ3WraHWgKGIqOHf2yc6ihzr1BtwSxGd9zMWtUeXuiSPOpOPuDr5oNYX2XU1+PQwc
         TZElGXuXajebh7ZYBAckPwb6NvVgoDZEIxiOE27DcfMqF5nQ5XbdqLFqOC3GfTqkc98B
         Bq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ru/1dgQ0vPtNshZal6qIV36byCdQdei5pfU0MIkHoyY=;
        b=fvvzaHGWoHvuHmZXI07XNr3ZWlyaXsMPX9am3SeNJsknDlFzTrYpwzltodUAspal6e
         FvH09ni53zLscYtgauo/1lqLrAIhnIlWcs3RRqZx2GoKbbNWJuOe0+pUYnkrM7gUL/Kk
         fvlzz0wI8ikDrkZAB3BYP+Vyse81+IEpXtolHTz+mXii+xLpm9cl9e5E5icJCpGSMqkm
         IAz5wM2v7jedqVQUJeImi/csX3i5Nw4Rcu8J3Yeer1uCB3ZrbbbVZqHKcrvNEy40pozj
         VBq0Kaoc8P3wJET+UXlcFxdIrf6YIqIiRjoOKFy2g6Qj1WtjeNkLPMSGlyIduBUouKxI
         7gvQ==
X-Gm-Message-State: AOAM5320jfaW2glIuj5cwD0/17Z7fw9bap/tzPtomye5e5ftSf4kfilV
        Qj0GC7l+Hx5QUdrLekEMKEBdXdRwxkl6BjF0FO7u4g==
X-Google-Smtp-Source: ABdhPJx6R16G9BRCLBxjauHicDEvt2bFLGA6WeXhN9Fb5riDpV3jSLdblA8xv3Lf5XpN9Lzs0rQKeBqXfxT/JTH0kyA=
X-Received: by 2002:a05:6102:7c1:: with SMTP id y1mr12940416vsg.34.1622456228772;
 Mon, 31 May 2021 03:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210528112127.71738-1-andriy.shevchenko@linux.intel.com> <20210528112127.71738-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210528112127.71738-2-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 May 2021 12:16:32 +0200
Message-ID: <CAPDyKFr_0w9mK4fWE3YynP0cYZOWuzeHKeVAmrHm068VRnR3bg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: mmc_spi: Imply container_of() to be no-op
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021 at 13:21, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since we don't use structure field layout randomization
> the manual shuffling can affect some macros, in particular
> container_of() against struct of_mmc_spi, which becomes
> a no-op when pdata member is the first one in the structure.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/of_mmc_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index 9d480a05f655..3629550528b6 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -22,8 +22,8 @@
>  MODULE_LICENSE("GPL");
>
>  struct of_mmc_spi {
> -       int detect_irq;
>         struct mmc_spi_platform_data pdata;
> +       int detect_irq;
>  };
>
>  static struct of_mmc_spi *to_of_mmc_spi(struct device *dev)
> --
> 2.30.2
>
