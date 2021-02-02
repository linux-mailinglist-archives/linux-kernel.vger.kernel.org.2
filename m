Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F4630CCCD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbhBBUIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:08:15 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:41772 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbhBBUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:07:07 -0500
Received: by mail-oi1-f169.google.com with SMTP id m13so24101150oig.8;
        Tue, 02 Feb 2021 12:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGSgR7HX5MpWtk9Gx4pMHLjGwCDbovTLjejcIrh3eUA=;
        b=FddIxRwR+FLLLbKKMOWZZ/bramvab63BxkWRLjinemRj7CnzNpDcWiupO83LhVPN7k
         H2WRP12T484W7ZLx/4V7DyUvBBMjB78xFnLIqOguVo9w77S+cFuosu0NXKUkOnCkDy5V
         fzDXCCi7m1EwIIh82IgxiwwLK1CH79I0bknrnVgAJXR137UlN4fmB974s2sm/7e91Rid
         OxomzXh6Zjjqfp8X+BNMhpg+kRFbV+qbJT3vEq6us3uFOcat12s/52cmO2Ahpcc6tE9H
         Kfm3dlskl56mq7LfQvbx6IeKmcNR6PKJGZ4frVQGXBntkBAqX5An/7ey/KrRZF/MxOYZ
         zUMg==
X-Gm-Message-State: AOAM531T3iqkSoB2UY8ZvW0DVXSD2awO/qVJ3RFuEPY1s8ZVfEwqaeJ1
        zWxk5o7NnDTWUPqbjPgfjckDNlnAoJAJ8X0aptc=
X-Google-Smtp-Source: ABdhPJwuTZ8MY7pmmtLJaXmDINL+fqP4hRrBNjxv/PFnAoHLtDWRWcS9L6f7quZ/44lBXHdLnmVMs35SMq6Yfe1Xr+g=
X-Received: by 2002:a54:4e88:: with SMTP id c8mr3877007oiy.148.1612296386531;
 Tue, 02 Feb 2021 12:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20210202192016.49028-1-swboyd@chromium.org>
In-Reply-To: <20210202192016.49028-1-swboyd@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Feb 2021 21:06:15 +0100
Message-ID: <CAMuHMdWKr5q1OrwJ5DEnFvqYYXJqXhH_isKQnJozf5tu=ZVViA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: da7218: Drop CONFIG_OF ifdef
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Feb 2, 2021 at 8:20 PM Stephen Boyd <swboyd@chromium.org> wrote:
> This reverts commit a06cd8cf97a3 ("ASoC: da7218: skip of_device_id table
> when !CONFIG_OF") because we want to make of_match_device() stop using
> of_match_ptr() internally, confusing compilers and causing ifdef
> pollution.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Thanks for your patch!

> ---
>
> Changes from v1:
>  * Dropped of_match_ptr() in driver too
>
>  sound/soc/codecs/da7218.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
> index 2bfafbe9e3dc..83cace9d0139 100644
> --- a/sound/soc/codecs/da7218.c
> +++ b/sound/soc/codecs/da7218.c
> @@ -2278,14 +2278,12 @@ static irqreturn_t da7218_irq_thread(int irq, void *data)
>   * DT
>   */
>
> -#ifdef CONFIG_OF
>  static const struct of_device_id da7218_of_match[] = {
>         { .compatible = "dlg,da7217", .data = (void *) DA7217_DEV_ID },
>         { .compatible = "dlg,da7218", .data = (void *) DA7218_DEV_ID },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, da7218_of_match);
> -#endif
>
>  static inline int da7218_of_get_id(struct device *dev)
>  {
> @@ -3311,7 +3309,7 @@ MODULE_DEVICE_TABLE(i2c, da7218_i2c_id);
>  static struct i2c_driver da7218_i2c_driver = {
>         .driver = {
>                 .name = "da7218",
> -               .of_match_table = of_match_ptr(da7218_of_match),
> +               .of_match_table = da7218_of_match,

This does mean the compiler can no longer optimize the table away
in the CONFIG_OF=n case. Is that intentional?

>         },
>         .probe          = da7218_i2c_probe,
>         .id_table       = da7218_i2c_id,
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
