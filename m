Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B082C35BB61
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbhDLHxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbhDLHxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:53:03 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F636C06138C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:52:46 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id v23so3930999uaq.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvYyxcmuuy8Mf4iqwtPOnrJd7sqJQhBveqGwzWHM2us=;
        b=FskClHSpA1eGLUsuHiI6LnX7OEUf5wbqlhBkpSTyjUtn2HF2pPy0ceC0FUErKI/+RV
         HINipnQVhtE+TQ6Na2NrF0f/E0lzROKZbnfbtd91ADo+Li02q983L7r3yg4zEmm88bpU
         4yMpVKJgyMTxilsbcuWmJ5C4Sv4jPcjeSt+aURZ0QjhlpNbPeAcSSPj4YbQgH/iEQHYX
         4h0ORwLA/i+D5pGuVONA+TBrQN/PENvN4Jymw2QbjrO5ICWPN3Vanpkhu0Ejs96T9JeH
         thCDj6mDZQNq1Je01noeFz0/3Hb5VU7zB1rdZCfV7Bhy+B17GSlAL+Sn/3qMytAhbvmT
         Jcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvYyxcmuuy8Mf4iqwtPOnrJd7sqJQhBveqGwzWHM2us=;
        b=HcvPkDg7P9o3AJlml++V+5hwLzbtq33/qj7FR6nDVjI+2/oKRwRjnSgtyOUh89wuyT
         PQYFPm131maetQ6rFx9H0s1aaazzBQz4VxCOjxj1J0ZXVDLOQLyZdPgvYTyvfYKwUSiN
         BwcbegQ6MfLe01yN6Rie+MHi7raufLfShETQ+8wysMHC/9Ns82JgR45yCCEqRyj5wkoB
         6/0pxY5TQeOybpQKbJGJKb9hhjhX5tafWPQYx7p7l/73+eYvtaRLtRY/LiQraOzT/NfE
         qQObjKZD8ybSFuK7/wWddotw59gg7N0JazD1TyamJ491x4kMZl7kxkob+gXxCa6Zs0y1
         4kQg==
X-Gm-Message-State: AOAM5322zqs28yYszv1pczk3oLOtBJjhJS+9jLzbTsb7APG2djhpnyAU
        K7VKrwrXW2zxBY4X0GqdIfRgr1PQQTBnUzsSF9OGwg==
X-Google-Smtp-Source: ABdhPJwW4qYtEXTrHqKhePMsRPedaDesFJKTnGzbIJPUkx7LvObMealB+0hKv+r9exLnX9Nt3enrWUR0CLAyCxdAEWM=
X-Received: by 2002:ab0:6f0e:: with SMTP id r14mr18905449uah.15.1618213965308;
 Mon, 12 Apr 2021 00:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210407093816.8863-1-benchuanggli@gmail.com>
In-Reply-To: <20210407093816.8863-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:52:08 +0200
Message-ID: <CAPDyKFo=tPG77RbEUuyN18qLikr9u5cM0wY__pRko5t=Oh2wvA@mail.gmail.com>
Subject: Re: [RESEND, PATCH] mmc: sdhci-pci-gli: Improve GL9763E L1 entry
 delay to increase battery life
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmVuaXVzQ2hlblvpmbPlu7rlro9d?= 
        <Renius.Chen@genesyslogic.com.tw>, SeanHY.Chen@genesyslogic.com.tw,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 at 11:35, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> For GL9763E, although there is the best performance at the maximum delay.
> Change the value to 20us in order to have better power consumption.
> This change may reduce the maximum performance by 10%.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 4a0f69b97a78..3b0a049d4124 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -90,7 +90,7 @@
>
>  #define PCIE_GLI_9763E_CFG2      0x8A4
>  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> -#define   GLI_9763E_CFG2_L1DLY_MAX 0x3FF
> +#define   GLI_9763E_CFG2_L1DLY_MID 0x50
>
>  #define PCIE_GLI_9763E_MMC_CTRL  0x960
>  #define   GLI_9763E_HS400_SLOW     BIT(3)
> @@ -802,8 +802,8 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
>         value &= ~GLI_9763E_CFG2_L1DLY;
> -       /* set ASPM L1 entry delay to 260us */
> -       value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MAX);
> +       /* set ASPM L1 entry delay to 20us */
> +       value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
>
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, &value);
> --
> 2.30.0
>
