Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637CF37A558
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhEKK6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhEKK6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:58:43 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED08C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:57:37 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id l4so3121273vsa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/JdLJLNNgKYNFulcjt0TiB1eWs9RFWu6AjeVzq+IhY=;
        b=eM6z8sgQMbnfc8M2ZVTYjjBiUUk1eTbMv7OZBLvUXLup5nTEBZ/lE3EVCC76gnnOje
         cx2Q1WuLVBKw5OTs/7bhAqpbm0LfNtVkA9Ioi1/UMWNxBegNGeMepqoDfJsCDLZO7IbR
         AhM/S4RoBUIy/g/4hhS9fClf37bQ+bDos2sxiZ0q0emPwyqO5RE87l0axhIn6RR+dAlR
         DZTg2sFbxPpELEPwPSW05imK1ayMvzKLtnIoyu3b4zRV09BYrleo0fwHFkgDWsiNWtZ0
         ZzyHff6bj/aMLzR1yvXfHLr3YL6tEIrYP84Br2HRUaFcIbFAfmOELuOfe01RZxK+FAUQ
         pKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/JdLJLNNgKYNFulcjt0TiB1eWs9RFWu6AjeVzq+IhY=;
        b=Jm/nthNAZntRAeWb4UfMGeH4yCgMOwsipkBFntPdC1RWmJ/6vrIYfDr4rk3WSK53yS
         zGgVfwhgSP4/ZKypOoz5COTKRLd06p/DiUqYi2rmtUSaOcAbISKBobDfG3oMkA8BZRut
         Ledb3l9yG2jTcbrXz09w/aPPiTTiKYwBO+foLw5CdpYF+1VTku+q2/vHpYAiIc4KBKKu
         5QaYw2V67ORSaYFvnerwYI8ePoMWbIA62tkl9APHmvB4rK2s9hj1JclTnnV9RVZQFCWZ
         mDvulBkJcKdajcjXFJ+BZYKCcQzw4TMjCbMLxtw7u5nAbMCzu66wImotsqf188Zu2gSC
         lFEg==
X-Gm-Message-State: AOAM531b2ERoZpcXgk8nAP6ZvCjHxVospXvMM/g9U4Ib3sKcSuUbnoG/
        /ymWRzT/0VjXRw4VahG2N1fnNrJu6o80eodcK1ZK0SiDyvvZvQ==
X-Google-Smtp-Source: ABdhPJwL3XK2p31fbYeyFsdX2H7pS3bEKTH5nbN54hzhC7nodz955JOTyuC0jGGpqCkbQzKqhcZIiNIjzmWEtxyghYA=
X-Received: by 2002:a67:64c5:: with SMTP id y188mr23398674vsb.19.1620730656739;
 Tue, 11 May 2021 03:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210511061835.5559-1-benchuanggli@gmail.com>
In-Reply-To: <20210511061835.5559-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:59 +0200
Message-ID: <CAPDyKForv+be28L0QC0n1=FB4MEJzT0+OvAEB_7n1h0ejiTfkg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Fine tune GL9763E L1 entry delay
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmVuaXVzQ2hlblvpmbPlu7rlro9d?= 
        <renius.chen@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        seanhy.chen@genesyslogic.com.tw,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        totti.yan@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 at 08:15, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> Fine tune the value to 21us in order to improve read/write performance.
>
> Signed-off-by: Ben Chuang <benchuanggli@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 592d79082f58..73e01c3480a3 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -94,7 +94,7 @@
>
>  #define PCIE_GLI_9763E_CFG2      0x8A4
>  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> -#define   GLI_9763E_CFG2_L1DLY_MID 0x50
> +#define   GLI_9763E_CFG2_L1DLY_MID 0x54
>
>  #define PCIE_GLI_9763E_MMC_CTRL  0x960
>  #define   GLI_9763E_HS400_SLOW     BIT(3)
> @@ -842,7 +842,7 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
>         value &= ~GLI_9763E_CFG2_L1DLY;
> -       /* set ASPM L1 entry delay to 20us */
> +       /* set ASPM L1 entry delay to 21us */
>         value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
>
> --
> 2.31.1
>
