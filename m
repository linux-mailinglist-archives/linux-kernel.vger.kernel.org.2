Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873293475E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhCXKV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhCXKVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:21:33 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51DCC0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:21:32 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id h34so7667176uah.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XayKDtDXvEdZGrqBW/sK+ORClel9QKflJZq6BfD6cBg=;
        b=kAjKT4pTY2Ero8J9KCorkvqiLZ95Qx/0dVfmPKOxxlyA28iZj7mOHrCbUj26zrZMF7
         9MFjrZrumcd+zNxom+Xr+WxAKVlSlcTL9dcTm+Ia3T6UXTREj+SIH1HHUuF9P2usm5kU
         MHN8woxvLBXA+2XsVIorN8IZYTpNzgIy+sXUgou+chLUk25PCEtQdVUDgGmh/LzwCV5O
         tEGOiLA/UgFK41ZbNNgil2dWurbbrplt3KnxfUrv4xhYiPUVJ5o99IwJLDclj22IUF+t
         cWLPiewLbOEWT+V2B3zt0zRaSQgkm6euDgR5639QxP//ULeTUWt3cdrrsLNPE6GWxbAy
         bcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XayKDtDXvEdZGrqBW/sK+ORClel9QKflJZq6BfD6cBg=;
        b=HtbrpjgIc3X8YD1j+mwV4J4MWsLk/mNmTUsLThk/sLG6tjVaz7GLoLK5wSc6j0OcsH
         hnaJjZFkLvMgyZl8OsTxg7CwODUhKEjt0k1oROoY7QcaNrzOWGXxnKMv/pC0nVp+fxvc
         W+hG3wHfSdU6dNqpZKkNMokGyujqG9XqhasLgWzc5D/tf8B0cXNMlrVMKMM7DkjmYOvc
         UpkaP5s0oz75Q+iZ9BglAqe07fp4WZk5B/zg8mxOVGroLHkChzYQqelpjZ8TrupgcXgy
         aqczxOs2+34S506vwjKOKVgo6dIzYeAS64noGyeIyywO8uAe3bzzrfn4Me46qkJNTk6+
         DO6A==
X-Gm-Message-State: AOAM530Pyt6uX9c8N24VJpn8FGcNQ/CKUJSK0yL55JKW3TRYX0KLji+c
        ZzpZGqvn1sJjwClr9J0Q7KF8HXk3qTJQZf/4zjIxlQ==
X-Google-Smtp-Source: ABdhPJwk9yHrwv+ZZuTWISnejtACKpGQ13OwcJr6v4U57ofjuB/FM3rDMW4Ipolc5KG3Z/RmNvjkyNEvYW9C7Yaew3Q=
X-Received: by 2002:ab0:7a68:: with SMTP id c8mr982878uat.104.1616581292200;
 Wed, 24 Mar 2021 03:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210324154703.69f97fde@xhacker.debian>
In-Reply-To: <20210324154703.69f97fde@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Mar 2021 11:20:55 +0100
Message-ID: <CAPDyKFrxJvDgNQ4V33YzhCf_7i0owffAKHxUZN0y8AuC6pA4Gw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: set MMC_CAP_WAIT_WHILE_BUSY
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 at 08:47, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> The host supports HW busy detection of the device busy signaling over
> dat0 line. Set MMC_CAP_wAIT_WHILE_BUSY host capability.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 06873686d5e9..b6ceb1b92b3f 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -393,6 +393,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>                         goto err_clk;
>         }
>
> +       host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> +
>         err = sdhci_add_host(host);
>         if (err)
>                 goto err_clk;
> --
> 2.31.0
>
