Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E23B32938F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 22:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbhCAV00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 16:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbhCARQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:16:47 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7642EC06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:15:57 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id r23so20356459ljh.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vfA0JJVUwjAoVTynDDOGpb5xwJq3miSmMP9XTq3nF0=;
        b=QUngnvuZ1juQC+JZqd3bfrz/6eGvwq8dFa9G3cpk4LNVtVZ/50qtZExt8jlX2vYPju
         j7zmp+XCKr86InJMeROfKPvT5u2RR26rFxcN3lZ7rT7EOrDu7XJ+x4ZrX0ng2FUIioO8
         YFuMDgBiVEeauoJbNAV7y+2420DLmuJLFJK0xaHcsr3ckapgC1msyiMTUv4ZPG7NVonp
         /G0cAA7kJp3iZwxOh/qC3juvtyOp1dx7uipR/zOy94RsQm5rLXO51oVX1Om0bsntnaZM
         ECrsSCePPEx/kbsz4FtC4W1jmZpzrY3nu1Hn1vaE4055R0YFyqt0YqxmdvAaMWipunzb
         ipOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vfA0JJVUwjAoVTynDDOGpb5xwJq3miSmMP9XTq3nF0=;
        b=nXBYsDicPvpaOtvWitvC1ouWhVN2UUDNqc301eDgwDWYW1P8bWrryFJuQX6f+GuyUm
         w6WVsNXkfQu9K6mJc+1qZc7154QIyYi+ikXfc0ELNn+Xsjzh8rybHK+pSKeA9dno/3oP
         IZCa/+zRrCt1hKIz+TtpOhKRTWhWK4+8IjjJCxsIKa/9d0m4jTk0h8PG3t2H1mYnGyxR
         6u+MiqMwHveR93exwymo5haIfvOQIXh+KmwxcmxM3DM53ZlQFJKAmgDg7DJD6lS0hN6g
         DAUYOxRDWkLX2jl+9mslXoxabuxU/7xmmR+887SLjHQBcoTYiTxgAGCDjgAOH0zzxWSs
         DhtA==
X-Gm-Message-State: AOAM530emwqq3kCt/jMtlqZG0slG3lKSATUEJ4TvMn2GrotFIgwQLcof
        Ui8HMcb4jwOtCQCt4quZ2TjLUHeu+59e8wd3H4MMfg==
X-Google-Smtp-Source: ABdhPJw+ulsZ4e65mNoQ3u4P9w+nmNzhzYyTKZwphBBWrWSyEHlf41GeR6R1QobhkIVVtK/HP3dLPjnIBFW80yJIlt0=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr7363439ljj.116.1614618955690;
 Mon, 01 Mar 2021 09:15:55 -0800 (PST)
MIME-Version: 1.0
References: <20210226140109.3477093-1-arnd@kernel.org>
In-Reply-To: <20210226140109.3477093-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Mar 2021 09:15:44 -0800
Message-ID: <CAKwvOd=kWY8ki-j-VZ7X4anypeuW5=4w2FPD=f39vK-zrAaWjQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] spi: rockchip: avoid objtool warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Pratyush Yadav <p.yadav@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jon Lin <jon.lin@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-spi@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 6:01 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Building this file with clang leads to a an unreachable code path
> causing a warning from objtool:
>
> drivers/spi/spi-rockchip.o: warning: objtool: rockchip_spi_transfer_one()+0x2e0: sibling call from callable instruction with modified stack frame
>
> Change the unreachable() into an error return that can be
> handled if it ever happens, rather than silently crashing
> the kernel.
>
> Fixes: 65498c6ae241 ("spi: rockchip: support 4bit words")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the v2!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> v2: use 'return' instead of 'BUG()'
> ---
>  drivers/spi/spi-rockchip.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 936ef54e0903..0d75080da648 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -476,7 +476,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
>         return 1;
>  }
>
> -static void rockchip_spi_config(struct rockchip_spi *rs,
> +static int rockchip_spi_config(struct rockchip_spi *rs,
>                 struct spi_device *spi, struct spi_transfer *xfer,
>                 bool use_dma, bool slave_mode)
>  {
> @@ -521,7 +521,9 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
>                  * ctlr->bits_per_word_mask, so this shouldn't
>                  * happen
>                  */
> -               unreachable();
> +               dev_err(rs->dev, "unknown bits per word: %d\n",
> +                       xfer->bits_per_word);
> +               return -EINVAL;
>         }
>
>         if (use_dma) {
> @@ -554,6 +556,8 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
>          */
>         writel_relaxed(2 * DIV_ROUND_UP(rs->freq, 2 * xfer->speed_hz),
>                         rs->regs + ROCKCHIP_SPI_BAUDR);
> +
> +       return 0;
>  }
>
>  static size_t rockchip_spi_max_transfer_size(struct spi_device *spi)
> @@ -577,6 +581,7 @@ static int rockchip_spi_transfer_one(
>                 struct spi_transfer *xfer)
>  {
>         struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
> +       int ret;
>         bool use_dma;
>
>         WARN_ON(readl_relaxed(rs->regs + ROCKCHIP_SPI_SSIENR) &&
> @@ -596,7 +601,9 @@ static int rockchip_spi_transfer_one(
>
>         use_dma = ctlr->can_dma ? ctlr->can_dma(ctlr, spi, xfer) : false;
>
> -       rockchip_spi_config(rs, spi, xfer, use_dma, ctlr->slave);
> +       ret = rockchip_spi_config(rs, spi, xfer, use_dma, ctlr->slave);
> +       if (ret)
> +               return ret;
>
>         if (use_dma)
>                 return rockchip_spi_prepare_dma(rs, ctlr, xfer);
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
