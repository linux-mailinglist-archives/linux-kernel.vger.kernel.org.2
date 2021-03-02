Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21C132A4A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576112AbhCBKyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349607AbhCBKmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:42:53 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE320C0611BE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 02:39:57 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id o186so10360999vso.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 02:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6yK7zojmd2caTqKaDe5ClSdgsBzC7JBS/wNNBBcaZxA=;
        b=IoLMpKuxBiqHyBwq9YqDrdCjt+NDVivAfb1Ktdc+FLKrEY6Yg/vUuJAFhUHXj0ixK6
         YxACozNO2/U6fV16rJIE9zn89NANeI9753x9o2jzuQy9ZGV+e1IqHWY79+mGAwy+BOVX
         EWH/9rmDnGNfIvesHhF/2tynS011oHtx7XMt7cmIgyJkkJ2tDOi8pQvQ+rDdTUBzE3y9
         aqJcY/ItTcmj755unV7uMc+EyzbGtlAokvn4eft0mxOkaWAW+y/oC6N9XMknTiuek6Wt
         LMqW/eYTpzZw3WRhm6VgNWkTxwtsytThVMWEP2kxwBKAF5CLU8RJ36Ez4hK6V9quGAGR
         zHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6yK7zojmd2caTqKaDe5ClSdgsBzC7JBS/wNNBBcaZxA=;
        b=Ixh3lXuM4KmsbFaPjq7t9q1CvhDWG81HR/OJHIi/44Pd9LavGj6AuP7eJO4msknXTp
         cEr1cH1zi4OGTZ6duH0TNrA/FC/p+zANW6DZKhkopoyMGQkjcaZCytQk9gImQDw2pDmp
         QlDq6okMWioPkLPiDJxRXFXQP0/OAxjtwbAntrCUz8Mbk9wXU5TE5C05zmAzpdHhKUrp
         h4Tf/FG7rgG8IbEBIHf+1mIhFrnQ1OCGl6RqrYHeSd6jtAt1GPvHe7t6M5F07+RegY7m
         QW2WJxxdIWaOqBVYp53HzDL0u3ft38dJTUtgxSrNIRxZMLdjXSFDgZ7LN8+VeUhmzZOw
         /UmA==
X-Gm-Message-State: AOAM533aARqMKSdmV8yQicUsPzAMLxsXu02SsMfMo/fJ1LAd2uVkMXho
        jd9HiLspUxGThDs5te0X46yHT8hDIZzQ+rej1JJ3z2U9q5c=
X-Google-Smtp-Source: ABdhPJzteFnm34/rnE8GfsHicqY6EuLlD/nABaelsO0moyaBgSjS4nricgbLbBWqmMgK/N4kWtfzf+XWYC5ysbajh10=
X-Received: by 2002:a67:f98a:: with SMTP id b10mr1465857vsq.19.1614681597024;
 Tue, 02 Mar 2021 02:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20210225111307.62975-1-reniuschengl@gmail.com>
In-Reply-To: <20210225111307.62975-1-reniuschengl@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 11:39:19 +0100
Message-ID: <CAPDyKFqBdYf4A6xEiPUu4qKSmNYMfC9WnxfTrjc5zgRdcre5cw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Enable short circuit protection
 mechanism of GL9755
To:     Renius Chen <reniuschengl@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 at 12:13, Renius Chen <reniuschengl@gmail.com> wrote:
>
> Short circuit protection mechanism of GL9755 is disabled by HW default
> setting. Enable short circuit protection to prevent GL9755 from being
> damaged by short circuit or over current.
>
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 5606bdc08a96..7ba0fd601696 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -123,6 +123,9 @@
>  #define PCI_GLI_9755_PLLSSC        0x68
>  #define   PCI_GLI_9755_PLLSSC_PPM    GENMASK(15, 0)
>
> +#define PCI_GLI_9755_SerDes  0x70
> +#define PCI_GLI_9755_SCP_DIS   BIT(19)
> +
>  #define GLI_MAX_TUNING_LOOP 40
>
>  /* Genesys Logic chipset */
> @@ -547,6 +550,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>         value &= ~PCI_GLI_9755_DMACLK;
>         pci_write_config_dword(pdev, PCI_GLI_9755_PECONF, value);
>
> +       /* enable short circuit protection */
> +       pci_read_config_dword(pdev, PCI_GLI_9755_SerDes, &value);
> +       value &= ~PCI_GLI_9755_SCP_DIS;
> +       pci_write_config_dword(pdev, PCI_GLI_9755_SerDes, value);
> +
>         gl9755_wt_off(pdev);
>  }
>
> --
> 2.27.0
>
