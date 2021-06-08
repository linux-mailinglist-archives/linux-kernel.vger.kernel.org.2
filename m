Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9000E39F776
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhFHNSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhFHNSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:18:38 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87469C061789
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 06:16:35 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id 68so11541123uao.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 06:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=606SEYScY/4Dm3TG2zXGyFR6Ly8KOu4QIRdQzAVRtJ4=;
        b=Omj0OjhvQ++d98yJSdmaXOk1bHCbynHCXQlXQa4ETkUydcSD2yCZsQqwxh76dHd2EN
         NaWVtW1fj9h0vehRKFR5saruc/HSNNc/MPrxxWz/VBlEh3plbcCVVi7mLPc/cdtEMjy+
         E4WWkbPCIAG0+XNmMsGsEqTYJ8c3wLylpNI+N/iJb/Z5KHrVybXjVzqToRgJn3smF09b
         2HequXh1rPYIH1tSjlB9dVMVGB4wH39RIvNrK6DiaQSouBto3Qh+jBRfLayJKOyekeb8
         78E7x9hrCKxO4h4PJFuDyza3nuNy5exKSLnx8qPGVe4Glpd/4Qj0oQJR4JX72hBb4/lu
         rxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=606SEYScY/4Dm3TG2zXGyFR6Ly8KOu4QIRdQzAVRtJ4=;
        b=MUq7pZRiu7hgZBcG7Ezlj4i/zly4GU2jNjdQsppfXEZs2rExKDCRHEo5wjigsGZkZY
         fcZAcEXdNv3vw7MDjbIsgz3xVD/6y2vHHGtp+dBCxRF1Qu2febbJi9G8YWekwE/RYDFL
         IXZFIkhxg6Wu58pe+El9SjVc5ys7e7osPygf9vA++J6FQWLr0C/jVvqyXN1wEpIzH9H1
         g7eyevXRkUmSSP7quesrW7f9/YV6ProPMvGEltD+k3q4Y54pxlsEkzT+/auojICe1Lf/
         u7HDJxnnSpLrzHTjyXZBnWcwFE5JCUQUD1ICewrUiObU+Rb3bkvQm4CvcrHvFM96aKAo
         i7Ag==
X-Gm-Message-State: AOAM531n6xUq3z8UGmrIaYLcn3EBYgfEx9FkSDKCSAIV7OFmatYPxrj9
        cD42OW32YLyrHj8xR8eQW1Z/nPBfCBr/uLVlvxB4bQ==
X-Google-Smtp-Source: ABdhPJz5aZwPNxnntAA8aRpvQS8xefc61/tur00rKpE7jf8yvD/K9Pq7D2dgwSTb802UwSLtR5tTYL3kwFEXhrF2Jjk=
X-Received: by 2002:ab0:484b:: with SMTP id c11mr3216292uad.100.1623158194715;
 Tue, 08 Jun 2021 06:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210607013020.85885-1-andrew@aj.id.au>
In-Reply-To: <20210607013020.85885-1-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 15:15:57 +0200
Message-ID: <CAPDyKFrqKW9VwEga0bzY+H9Br57RbfXBnxJFP_-rWcfpic-0hA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-aspeed: Turn down a phase correction warning
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Lee <steven_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021 at 03:30, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The card timing and the bus frequency are not changed atomically with
> respect to calls to the set_clock() callback in the driver. The result
> is the driver sees a transient state where there's a mismatch between
> the two and thus the inputs to the phase correction calculation
> formula are garbage.
>
> Switch from dev_warn() to dev_dbg() to avoid noise in the normal case,
> though the change does make bad configurations less likely to be
> noticed.
>
> Reported-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index d001c51074a0..e4665a438ec5 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -150,7 +150,7 @@ static int aspeed_sdhci_phase_to_tap(struct device *dev, unsigned long rate_hz,
>
>         tap = div_u64(phase_period_ps, prop_delay_ps);
>         if (tap > ASPEED_SDHCI_NR_TAPS) {
> -               dev_warn(dev,
> +               dev_dbg(dev,
>                          "Requested out of range phase tap %d for %d degrees of phase compensation at %luHz, clamping to tap %d\n",
>                          tap, phase_deg, rate_hz, ASPEED_SDHCI_NR_TAPS);
>                 tap = ASPEED_SDHCI_NR_TAPS;
> --
> 2.30.2
>
