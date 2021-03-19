Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5134B341F24
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCSONe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhCSONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:13:20 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEB5C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:13:20 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id d82so2127672vkd.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxm+/pPcm1XVG4+mY+cSz5OGxQEii57vbnoHpCbdW98=;
        b=oJ3/MhJce5u9An6ttjIoHlmAsPixMOYiHetFbmJFYfotGoZdr9fskv4V4RimusY92P
         4V1keHZZwZ2TGJ1xHxYKlHLCZqNcVw5dXVfyGKVdGy3EvaIj9RV5yuDURurnCKpki4Xg
         TcpON6cB+yzQnTUN89jR+g5p+9P9tvABzK58Lcnc8BQFxhXwiJp+WPzDlxnvvKbebVvu
         lbk06ohMWGQfZZxyjuqjUowAArE+iFx7r1AsZJWuoto6k/RxK/e0eY1nh+ykuD5GiVne
         X6zlnINyPqpUxzO2H5DTIWXUM6l0BeXRk3HuDaIe+HrjceZg6TlYWxaOlwtxua8TZeTR
         5s0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxm+/pPcm1XVG4+mY+cSz5OGxQEii57vbnoHpCbdW98=;
        b=Ft7arUMVuuXtQaJNpo1zmr0jUA5TjSAt7ZxkoDgPvsGYLCuFCD/fdRrIJSmupk5N8G
         B5DRe4GGauk8q0XZg3HmrXJHSqDfBsxQ2HYgqhVUM6OlPC+u8sCEG5EV2AS1miod735b
         2taFe9kp7v5lQOb6nlfCjHCOYGJ9GRI+qMwsfEjZ5MmtvhTRtxSyT63SJRK2RKegyGu3
         1lkI3X5q/CbtLgz+cGRuJKrsRL/U52NawQmNFO2jMvAampUltlVNZ7Saan6J7uB8zX4I
         fVUeTW2y4AhYlqGp/vz8wuY+UCvrD1OYYqHYwdrgQ60FMrUdrGU0vudT/qt9ZUGy4NCr
         bSOw==
X-Gm-Message-State: AOAM531PpcdekXNthk7OS2sW4fV/XzPtqVlesRz3uD1aNDT/6luLLppg
        N8SpcSHfTfJHtoWZ3oalwYzAUckEHjQsN7FOE25w7A==
X-Google-Smtp-Source: ABdhPJx2+SzVQl8imKo0EQ3B+5dXnijhV7xS6mcteSNG7VLsSVEp39ebWCZcfEIb2iQ9RP8ErpC2Xasvz+xL8WNGjiY=
X-Received: by 2002:a1f:5504:: with SMTP id j4mr2765495vkb.7.1616163199593;
 Fri, 19 Mar 2021 07:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210319121357.255176-1-huobean@gmail.com> <20210319121357.255176-2-huobean@gmail.com>
In-Reply-To: <20210319121357.255176-2-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 15:12:42 +0100
Message-ID: <CAPDyKFp4Y-MS_tsNpCS9M8pqm2RoTmMG7=4MYyxZ7ZsnVKKeQw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: cavium: Use '"%s...", __func__' to print
 function name
To:     Bean Huo <huobean@gmail.com>
Cc:     rric@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 at 13:14, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Use preferred way '"%s...", __func__' to print function name.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
> index 4bb8f2800a2b..95a41983c6c0 100644
> --- a/drivers/mmc/host/cavium.c
> +++ b/drivers/mmc/host/cavium.c
> @@ -656,8 +656,7 @@ static void cvm_mmc_dma_request(struct mmc_host *mmc,
>
>         if (!mrq->data || !mrq->data->sg || !mrq->data->sg_len ||
>             !mrq->stop || mrq->stop->opcode != MMC_STOP_TRANSMISSION) {
> -               dev_err(&mmc->card->dev,
> -                       "Error: cmv_mmc_dma_request no data\n");
> +               dev_err(&mmc->card->dev, "Error: %s no data\n", __func__);
>                 goto error;
>         }
>
> --
> 2.25.1
>
