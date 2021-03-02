Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AEF32A4A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446468AbhCBKy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241088AbhCBKk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:40:26 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E0DC06121F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 02:39:32 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id d3so6615220uap.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 02:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6r4AOaZqF/J4+5o5s3C3a7TM7mI7cCWrbhUsHuZqOwQ=;
        b=uYWgz5HZmDKSspNGaCfdRY6Fxp6596WGZO4WXNXuQdOKLY+a6GdTBP824esDu591LN
         WvgxdZb5xkGGUK7W9O1w7iUH0LS7pYzYz+nagaWTEug8VqlMRrqIUPTpJSwI8KUiPS1E
         H8yiCa7NFrowm+3LGHVAzq8OkrEIVCEoxwDHMGU4nheE5j54SN/5tl7zUm8iS+TX2jNj
         /o0ZgcWtMLa+qgV8KaTQIirmSsmGee2d5Tgt5DoIgrc+KCooVTx+C6WnRKnTFbGifWNs
         12CHStWRUvZI+8pGt7S9DwKAzYTsOsg9PduQVeuxWKuBIxczAVeFTExO0wU+jeMQ4Puz
         fAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6r4AOaZqF/J4+5o5s3C3a7TM7mI7cCWrbhUsHuZqOwQ=;
        b=qs5pOiDobiYu3QrFeymuESuToPAhQx1O9OTr1K1E8358h83WVGdhnzYuoC7HIhOydB
         otS6jnJWmuu9os5RW7wMyWKHYlZ3BWjuIeXfG4whbQzJe+dV59KY/4+PUq02vF6hz2jM
         PFrCVjoURPd4Ns8QJi/nKQKe81Ce2jeCk1xz4cSY7JRzJEBhN7wkspZ7UfiyJAF/RL6G
         Vdfbxo+f+IPaSTFPjxqd4TpYTBOGLeZTYOWjbNYKdYV+r1IGLbpST15tTjZrbRlKSOgR
         RQBW5t1sujVk9AEPHRP04g5fpJV9d7oIS2d0NSQs8qwUtK6A1ocIyLC9M1exHrEZBetI
         nG1Q==
X-Gm-Message-State: AOAM5333n46EcHTYc0xiV0kBXjzTx5I7nf/VlrYZc27swBt62emvqAv/
        kRV94QOFRgHP0k7XOf5QUNCtsq2FwqzOv5XTf3pLAN5mbNE=
X-Google-Smtp-Source: ABdhPJztcXzXM5ZqgP8ZlRQnPyDftiiHJGFOa7aQnfkPc38todMp/WoR2/CtJkGrNpGBSPvJxvYxYgWXzmAeawEzDzU=
X-Received: by 2002:ab0:c16:: with SMTP id a22mr3399707uak.19.1614681571426;
 Tue, 02 Mar 2021 02:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20210220142935.918554-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20210220142935.918554-1-christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 11:38:54 +0100
Message-ID: <CAPDyKFqscxswNYSSAMi1K+wnF8hWJHFN=o_5v61rWcZYVuF6cg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: uniphier-sd: Fix an error handling path in uniphier_sd_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Doug Anderson <dianders@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Feb 2021 at 15:29, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> A 'uniphier_sd_clk_enable()' call should be balanced by a corresponding
> 'uniphier_sd_clk_disable()' call.
> This is done in the remove function, but not in the error handling path of
> the probe.
>
> Add the missing call.
>
> Fixes: 3fd784f745dd ("mmc: uniphier-sd: add UniPhier SD/eMMC controller driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/uniphier-sd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
> index 2413b6750cec..6f0f05466917 100644
> --- a/drivers/mmc/host/uniphier-sd.c
> +++ b/drivers/mmc/host/uniphier-sd.c
> @@ -635,7 +635,7 @@ static int uniphier_sd_probe(struct platform_device *pdev)
>
>         ret = tmio_mmc_host_probe(host);
>         if (ret)
> -               goto free_host;
> +               goto disable_clk;
>
>         ret = devm_request_irq(dev, irq, tmio_mmc_irq, IRQF_SHARED,
>                                dev_name(dev), host);
> @@ -646,6 +646,8 @@ static int uniphier_sd_probe(struct platform_device *pdev)
>
>  remove_host:
>         tmio_mmc_host_remove(host);
> +disable_clk:
> +       uniphier_sd_clk_disable(host);
>  free_host:
>         tmio_mmc_host_free(host);
>
> --
> 2.27.0
>
