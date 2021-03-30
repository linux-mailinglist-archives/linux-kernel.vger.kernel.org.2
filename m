Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE11D34E5AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhC3Kpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhC3KpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:45:14 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A6AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:45:13 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id v23so4884592uaq.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KA1n+JDKnSeg05rDwCgfj3wTUCCEx1+ImjZuwoLRDgY=;
        b=lqUF3G4msKNfNioFzkAXbXB/9SAof6IGX3RHcUtvUDyiOczBnzb74KMfGN73L0n+xl
         +Se0QtBcMXYJsRztsfF7UOrqpJcXMix3jUmxYGXYBwMvUjxhAosMPd0YaWls14J+9ANl
         GaK5tcXcd5mIypluCcqcK4PQy1ft21EGdDt7j5z7/IP3zhrd4qIVi8d1BhF5HblUYoZV
         MjXT4fuSXdkkda9Ww+nJ9klfpNfIQKXQgtk/swh/XaQP/z4febyDjOF4Ac1+InpHBsAQ
         bI5cCyFV0IdLGZLKKRLNSjKljsWzLSnkaLORsyASIJ86v2v/KoEQDfoAEVIh14IXUoiT
         60GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KA1n+JDKnSeg05rDwCgfj3wTUCCEx1+ImjZuwoLRDgY=;
        b=NuUT+SYqfZbW4Ugz+NNZRU5sdRTOs0cFY7rURuG47ZjtRLwyIoWRaDOmrup7j4MfP/
         8o/5g+h335VIYM97NxBPfR3y4r4ZPYZ/VEL1DqtanufMqZGuBneQ8lzIgvN/ZeG9ZrdA
         z7qH0QFYRFrRJmM1nassE84uRuUxYBD8o66a+AUT0UDR8pHru/3AIL5I/Ta756BND7PD
         Uy79GFXIZCsTqritEc95XXcv0oZQYJ3tF3IMMOkDmpzjyv8jk6nPIYAnYjO5xi6QK8Kp
         pWaf720fMw0kn8fUIb020kbbbFm8dzbCWC865Xb7Io/VR1t7VT+abA7ylSMQe3A5jTi7
         baig==
X-Gm-Message-State: AOAM531jDImJtT2epPmsQhzViWzuF3NXeJUnoLF/mAOB4VJNlNeRqxw5
        YCNgpJE3JPDyU0qokB2AUAwn70UXgeW8BKPqveLc7Q==
X-Google-Smtp-Source: ABdhPJyOR+5TV2pxTV236HAkY2P9NZKgB08njxIqK1Qk0yQRhxuPkc+j+UWrnhJN6Tf+QS2H0FpObL5nq6gOoxKOZXE=
X-Received: by 2002:a9f:2843:: with SMTP id c61mr16130295uac.129.1617101112887;
 Tue, 30 Mar 2021 03:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210325192834.42955-1-alcooperx@gmail.com>
In-Reply-To: <20210325192834.42955-1-alcooperx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Mar 2021 12:44:36 +0200
Message-ID: <CAPDyKFpNB6-=35FqM=74Obv1KEDJg-XC9kgegQbCA0Q+rKT4_g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Remove CQE quirk
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 at 20:28, Al Cooper <alcooperx@gmail.com> wrote:
>
> Remove the CQHCI_QUIRK_SHORT_TXFR_DESC_SZ quirk because the
> latest chips have this fixed and earlier chips have other
> CQE problems that prevent the feature from being enabled.
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index f9780c65ebe9..f24623aac2db 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -199,7 +199,6 @@ static int sdhci_brcmstb_add_host(struct sdhci_host *host,
>         if (dma64) {
>                 dev_dbg(mmc_dev(host->mmc), "Using 64 bit DMA\n");
>                 cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> -               cq_host->quirks |= CQHCI_QUIRK_SHORT_TXFR_DESC_SZ;
>         }
>
>         ret = cqhci_init(cq_host, host->mmc, dma64);
>
> base-commit: e138138003eb3b3d06cc91cf2e8c5dec77e2a31e
> --
> 2.17.1
>
