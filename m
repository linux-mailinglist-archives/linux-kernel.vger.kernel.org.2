Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1F041A302
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbhI0Wd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbhI0Wdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:33:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD89C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:32:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so84139029lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKu0IEoODoUZIet78XIQ7gITGkb6gFdWyb3HNpoDiRY=;
        b=kpXgGEYkOKaDhkkfgBp7BBAINU+UWy4oa9d0ezLNX1RdkCrN5HQFAcEpIxYdSqaY8E
         4l+zTnannSueZmhgY3UnxmyNBaFabr0j0X2ntWtPMkfvb+VutnzecmJmXqGu0zexnRjx
         uXmSVxOUQjEHQO/mqp5FlkjS8NjpvBTAl593Q0gzCq2cbHArqKK4E9y1M1argn71WiC6
         JO2B/CXOEM7xbpGpU2P6VwrNk9BJEt5K2j4oOUF4X6Fs+MOeYgZqgEt/5NsJ1CkTTM1F
         cahMn+4wLj+ys0ZhlokvVekdhkb6slO+PCWGpOm9BNz6ndkrwQIpfKjbP7x8xOfI6lVD
         bkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKu0IEoODoUZIet78XIQ7gITGkb6gFdWyb3HNpoDiRY=;
        b=NT4MbB62RHtCZGvQ6t3Ny2D2R5qrCjOXUY5sNrv1q2A8AoNTv47qNXNCX5ihuXPJMl
         3iUAboMPABXWD1gVtjbVV8PRTtFKoXnhbHW8VIKI+yNxpnpqtPfCav3L84JGbMP+2Ce5
         18k99IXd+uYnWNyLKUwIPbzOV4SMZuUHqG6W+L7oskxctvWGt3KbQW7S1PrywDMQz9p6
         7Q9m7pLs8NYStpnAZMPemNtU5wPmmHvBKcZ46AeUc9PiOAD1IuZsvyaZtp/duFsE4B6Z
         0P2RjKu3Tdupb7vKCYM6wCqWbbXNQIgoMejQ9K8YfJcPLu2pGZ+tHg0NHlDXjy8ql6ns
         IwQg==
X-Gm-Message-State: AOAM531PSr2ReiIxbU9edGSrBDzuydKROoI/m1N2kuwFEbCZ6+9rVmPp
        QxAP7KZ/eSqUEWIm64XKtHhfJRlP9i8fJ5+RR5NNUw==
X-Google-Smtp-Source: ABdhPJzhJkeB4zE1uCuw+O9on0VZVgtLXjw2moy+UGvPzQgeEJy+bQMNoHXRMUWjpXTYDrUF0YGvWaKZ2x6KDD8fqxo=
X-Received: by 2002:a05:6512:2397:: with SMTP id c23mr2162094lfv.358.1632781934165;
 Mon, 27 Sep 2021 15:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210917172727.26834-1-huobean@gmail.com> <20210917172727.26834-2-huobean@gmail.com>
In-Reply-To: <20210917172727.26834-2-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Sep 2021 00:31:38 +0200
Message-ID: <CAPDyKFo+vVE_nH7b6HoZA==psx1+BiL8GqKCFXScRQKcnu+-OA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: sdhci: Return true only when timeout exceeds
 capacity of the HW timer
To:     Bean Huo <huobean@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sept 2021 at 19:27, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Clean up sdhci_calc_timeout() a bit,  and let it set too_big to be true only
> when the timeout value required by the eMMC device exceeds the capability of
> the host hardware timer.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for next (deferring patch2), thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7ae398f8d4d3..357b365bf0ec 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -930,7 +930,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
>         struct mmc_data *data;
>         unsigned target_timeout, current_timeout;
>
> -       *too_big = true;
> +       *too_big = false;
>
>         /*
>          * If the host controller provides us with an incorrect timeout
> @@ -941,7 +941,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
>         if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
>                 return host->max_timeout_count;
>
> -       /* Unspecified command, asume max */
> +       /* Unspecified command, assume max */
>         if (cmd == NULL)
>                 return host->max_timeout_count;
>
> @@ -968,17 +968,14 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
>         while (current_timeout < target_timeout) {
>                 count++;
>                 current_timeout <<= 1;
> -               if (count > host->max_timeout_count)
> +               if (count > host->max_timeout_count) {
> +                       if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
> +                               DBG("Too large timeout 0x%x requested for CMD%d!\n",
> +                                   count, cmd->opcode);
> +                       count = host->max_timeout_count;
> +                       *too_big = true;
>                         break;
> -       }
> -
> -       if (count > host->max_timeout_count) {
> -               if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
> -                       DBG("Too large timeout 0x%x requested for CMD%d!\n",
> -                           count, cmd->opcode);
> -               count = host->max_timeout_count;
> -       } else {
> -               *too_big = false;
> +               }
>         }
>
>         return count;
> --
> 2.25.1
>
