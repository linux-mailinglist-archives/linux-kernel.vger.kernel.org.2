Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D6432A49F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446451AbhCBKyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347453AbhCBKk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:40:26 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB590C061222
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 02:39:36 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id o186so10360560vso.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 02:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9y/OLbMdtDESdX9cxpVBPkgzPGOeodSxawca/q+mpKk=;
        b=lF7i96mD7IhEXlug+vEnfPbJSPNTmN975tD3fkSobYZjokRjMZLrk7stkm6jNfWpw2
         9gSJ8D/tzPavPFvpWknhwzjiN+v7in2gbRvy50dxYRvBI0iTIOTmWVGy/XT2Reg1kzGx
         xFf/Dglm+AZjuA2xp2bfwu+VrynvHw2e6nGoxSuQJ6MY4m/SrEOKsRCmcsnKwXrPG9Qs
         +X14rJ6nPzVwAu3FyEu2E4RaAzVQ80Vu+pT2v31xTxuzPnoNtqnkM13xAh9Qnb6p5sec
         xWsApc6FW3Qa3efI0r8tSTZw/QSQH8JQy2z2o4qENU6ECC/9Kw0cWK0IMYe/NM0BnlTH
         0JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9y/OLbMdtDESdX9cxpVBPkgzPGOeodSxawca/q+mpKk=;
        b=PggkIfSwQbMNZ4FVBRvQBoVpr6jxk4IRTmFqyXYI07l0ZV2ob6UiZO8jPMvdiGpgdw
         h689aJmKUd4jqWr/Cc9/zHP0F9spbAuID2VvuWI2+uQCuN2QNIns06YU4huztp8AnQDB
         TWKaDFkSuzsc16bIntjx8RQjmeGi7ww/QO4H/EzSePMlb0zYG5CD48AjBTivuNYDKxE/
         cIOqgPC3zdJEyOWpbQBnWLeyd7vtAZARVUMY/qqBcrWGlwP/+jMYm82EM13fa84p9Cnu
         v3/nXIgA6ksamXYkjV9X/FVLHNgqhrx/7x8fE3eV0Mbiu5nxnTOcYe9l3qXfvdzmCZ1b
         HOEg==
X-Gm-Message-State: AOAM530bxoC4v9zS+Jyn0JtyCELExysymKVeGsjSp6nm9hbaGVaOKWqa
        5nTHgMqgqwyq54AVlMnxuQCniSHAUsUm9X7vz4LGog==
X-Google-Smtp-Source: ABdhPJwX80Q9SU3s5pG9sH20LwYNls+0ukRvdY+lJRo0x+xCw/4R/wLkzDCaJrl8uxcmAJ4SIsXJfn/wHbxIkF1eJ/E=
X-Received: by 2002:a67:ec7:: with SMTP id 190mr1803896vso.42.1614681576170;
 Tue, 02 Mar 2021 02:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20210220142953.918608-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20210220142953.918608-1-christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 11:38:59 +0100
Message-ID: <CAPDyKFozVZ9PR1JeQ6F8Ua-YcdpK-rS9TLDe6BW71avpiF5f4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: uniphier-sd: Fix a resource leak in the remove function
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
> A 'tmio_mmc_host_free()' call is missing in the remove function, in order
> to balance a 'tmio_mmc_host_alloc()' call in the probe.
> This is done in the error handling path of the probe, but not in the remove
> function.
>
> Add the missing call.
>
> Fixes: 3fd784f745dd ("mmc: uniphier-sd: add UniPhier SD/eMMC controller driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/uniphier-sd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
> index 6f0f05466917..ccbf9885a52b 100644
> --- a/drivers/mmc/host/uniphier-sd.c
> +++ b/drivers/mmc/host/uniphier-sd.c
> @@ -660,6 +660,7 @@ static int uniphier_sd_remove(struct platform_device *pdev)
>
>         tmio_mmc_host_remove(host);
>         uniphier_sd_clk_disable(host);
> +       tmio_mmc_host_free(host);
>
>         return 0;
>  }
> --
> 2.27.0
>
