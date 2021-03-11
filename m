Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA513371B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhCKLuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhCKLtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:49:43 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0AEC061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:49:42 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id 97so507497uav.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXqg8vgL3gnu/IDGJ8BFXqaOeLb5eaolcYdE67ipBbM=;
        b=ZqM+6G+f/TXtH5dXXDax6oiHd3LF2JqvfGtwN7T1sctJhWpCiG5lI+vXqJSmDxORI/
         DMO6WOUZ2u0zvvk7CiAmNFAh7lIk3tQuZ6sQMPBjaF93S6sMpEL7wZWqUMuMt+MoZBrb
         xi5YWbdefl2EqWu3ypFz+SaVhPrkEMDWNom1EFWxEGs7m0LC+DAwFngH70PWTKacis+L
         AbNzNRCCbogg/Ei7uL3MfsySyBBDn9HlDY9e5U1suoackSsyBPSYweHrLU4U3AH9/cmh
         Ko/4eYAlVqO7J0WXwFFkvfmppaRdA8EvtsgVKqKE0gEWGeLY5qOEWzg9iMtXi4y6JbJ+
         uhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXqg8vgL3gnu/IDGJ8BFXqaOeLb5eaolcYdE67ipBbM=;
        b=IpfNurCdUm3BYRVt1MgiVwK3tM3BEzNO9o78B7lSyq/Z4pRsd75S7DQe5+T7mISSQL
         187jJKNCa9k5L1wgAjBFgQMv0w1L8mjtrptG18Es0KSEdFcE3YoSFxDv59w4hhIm9eZc
         +xcLW33ZHTghTSZ9QyS9YXc/W+/fUp7aWf8Dg8UIFnexU67jrZOMO1GeSZBrDZN5m35d
         r7mUtLwxU91ESlzsHJbAx51kVWRuEITV1sPdoPyv3f4KseudTvWB5VcIHQuyhC8pSe4z
         AG8vmU4BJ16/9rE00JTUAi25WuSqyfztNkQwi1xFC+lOEb7DUNJL7Hv4kCUomqf1rRry
         KQNg==
X-Gm-Message-State: AOAM533Zq5WnT8Am/19UGL17lUFX1s2+MAPPD7niizGNNcGIWmLAm4sk
        +tyYruDP/+9oXRx40dtcfsJdDe4s3nXhXTK4Yk9DKy5UdPaciQ==
X-Google-Smtp-Source: ABdhPJwRCEITIrXY4A7xuxCWdT5/HWX0F5raWsn79lSa3I6wONdV/YVQtrSk0arALTCLzXvkvByWZIGBEPiEQ3eq+kg=
X-Received: by 2002:ab0:6f0e:: with SMTP id r14mr3251737uah.15.1615463382129;
 Thu, 11 Mar 2021 03:49:42 -0800 (PST)
MIME-Version: 1.0
References: <20210311181432.6385cd2b@xhacker.debian>
In-Reply-To: <20210311181432.6385cd2b@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Mar 2021 12:49:05 +0100
Message-ID: <CAPDyKFon6knyavDHO_PujQeVwgzE6pcK13zuS9xwHfzbfwd1NQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Avoid comma separated statements
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 at 11:14, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> Use semicolons.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 9552708846ca..62799c1d9c0c 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -958,7 +958,7 @@ static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
>                 slot->host->mmc->caps2 |= MMC_CAP2_CQE;
>
>         if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
> -               slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES,
> +               slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
>                 slot->host->mmc_host_ops.hs400_enhanced_strobe =
>                                                 intel_hs400_enhanced_strobe;
>                 slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
> --
> 2.30.2
>
