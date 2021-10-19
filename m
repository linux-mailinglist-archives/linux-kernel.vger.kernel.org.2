Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D06A433434
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbhJSLCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbhJSLCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:02:04 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B54C06176A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 03:59:50 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l5so5307487lja.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvpR/+LDc/4vIIRPGMLgKA8FJKUHtg12S0DrPQp+iCA=;
        b=ShER1y/hDIZPAQU1v1YNeGWehRkRxSpc08jn/rG7iGr+0+du6oAPScZBT57yeOVBcE
         MS2Z4Y0smUW0XWeN7JnbpmWjczvKIg8k9cEEcAeO7ZZofw4IiAI0y45+7E7p/1Zq4VuB
         o4S9JXVQSC+D5d/zEfZuN+g0Sia6I2eefLBvrGziO2tiqYSIh38KAHMJfuygRSXF5YIX
         IPyiNxQ6MiCt9OwO1snXJM7HYUyV36ELXQ2xO4GQIQ7YlB02hgVn0hENH8cbHEgWAIBH
         iy6EfpHjbIoun0qCkC7oYwmREc2djmQ5IBjhcVj2J5VBCqV9DX7M/ofj8I9TBorxQ/5N
         2rDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvpR/+LDc/4vIIRPGMLgKA8FJKUHtg12S0DrPQp+iCA=;
        b=TOxmebGWpA9H70rUxRnhUu5ee9OndVIPfAXgqzIuahv/8o7w4Hcrp8wpoZJZcBDltc
         vd0veYEp3vYMrzILzyAsn9WrPduadOQLxRtR7UFDQ04lwhrwclEIaCpq+fpTeVIQsGJj
         43CcJIKM1+bn86mXFJy5dAkmApbe7PW3skJqT3ZBlAGe9w3N9YpJN2NsI2zs32Ktqjk7
         b+fKAPcICEujIyKA3ehGuZLFPEJuHa1HFmPwOt2ivTxDzaEQiPDhqOnTv7kSW8Sl0Ktv
         8YGJA9TpS0eKYwxVcbyyCdDroSTMYom+FyNA22WbhPLyKu4kSnBRJzwTQ9eso+ASsbXO
         L/MQ==
X-Gm-Message-State: AOAM530Bl4lsziHv56cJzhjUttp8CshrNq8JNQ65yk88tceFK8gQnhLG
        q6UFlIQsTdB6zB+m7+OfmfEYCa0GnxzUwouTwnO0YdEuxoU=
X-Google-Smtp-Source: ABdhPJweCp01ZjPFICCqBQ55XvXqdFtPCUZr+w6qvIuEAd0a/tIavRkspbIkoBgN9dnt2TjEcaWQ2UBNJYvKKC1xVcI=
X-Received: by 2002:a2e:b550:: with SMTP id a16mr634976ljn.229.1634641188965;
 Tue, 19 Oct 2021 03:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211017175949.23838-1-rdunlap@infradead.org>
In-Reply-To: <20211017175949.23838-1-rdunlap@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Oct 2021 12:59:12 +0200
Message-ID: <CAPDyKFrhdkp2W6rPorw+0T_dZkcg6TXFcqB2vrWnnfvwdhpKzw@mail.gmail.com>
Subject: Re: [PATCH] mmc: winbond: don't build on M68K
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pierre Ossman <pierre@ossman.eu>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2021 at 19:59, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> The Winbond MMC driver fails to build on ARCH=m68k so prevent
> that build config. Silences these build errors:
>
> ../drivers/mmc/host/wbsd.c: In function 'wbsd_request_end':
> ../drivers/mmc/host/wbsd.c:212:28: error: implicit declaration of function 'claim_dma_lock' [-Werror=implicit-function-declaration]
>   212 |                 dmaflags = claim_dma_lock();
> ../drivers/mmc/host/wbsd.c:215:17: error: implicit declaration of function 'release_dma_lock'; did you mean 'release_task'? [-Werror=implicit-function-declaration]
>   215 |                 release_dma_lock(dmaflags);
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Pierre Ossman <pierre@ossman.eu>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Arnd Bergmann <arnd@arndb.de>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20211015.orig/drivers/mmc/host/Kconfig
> +++ linux-next-20211015/drivers/mmc/host/Kconfig
> @@ -508,7 +508,7 @@ config MMC_OMAP_HS
>
>  config MMC_WBSD
>         tristate "Winbond W83L51xD SD/MMC Card Interface support"
> -       depends on ISA_DMA_API
> +       depends on ISA_DMA_API && !M68K
>         help
>           This selects the Winbond(R) W83L51xD Secure digital and
>           Multimedia card Interface.
