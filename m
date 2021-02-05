Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574EC31040A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 05:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhBEE2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 23:28:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44412 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhBEE2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 23:28:07 -0500
Received: from mail-lj1-f200.google.com ([209.85.208.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l7siK-0004eQ-KW
        for linux-kernel@vger.kernel.org; Fri, 05 Feb 2021 04:27:24 +0000
Received: by mail-lj1-f200.google.com with SMTP id c1so4859984ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 20:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n5C7ID7G2UvKjWjufV22Fa1Sv36FB+FI8SSi249Wd+I=;
        b=BkcWW4vECXptNnavtiTyJitrsWfdHOd6NNjqMlpmpT8kJ/b3Z3BNL7aoBlXhxuXK8Y
         ALfmDokaH4DPwZ1+921tzbGg1Iu38935AvfocCVpBxhsuaCp7mfCglswF7MK4Ul04DYB
         j9OGNoXRcfqRwC3xqk+VZmRODaG+gZQMqe/f2Z2Y6LkDQri2hesL9W1j0e/cd+GiwQp2
         cHTUbmMPLgtAhzNurC04cc9GijLVmKbP9l4ZtDWxHfwkAVe95aVSCrrM86xiFRHeJzcL
         OK5MCdnU0wGTHGG5wyVcG9tnRkLZRpqefy+6sbFALDHtgJumKrEnw9RVQKD6A1zqFY4B
         nENA==
X-Gm-Message-State: AOAM5327X1zo3H4P4SY71HM6yAgRZ0zyAX+8kiHSDMShvLHYLzlzgkr8
        8iFEJy0ZPe/y9llg6J/CB+gN1m1jCKpKwyZ885svaKu5lxJUnHZvjp9c66rYZ4DbDXZQ5ktksE7
        42e5BheZPhkUFxYXkTN1jFK4FYiI8qCk4V/K7u5I1gyZHn3PKrMYZDvSLYQ==
X-Received: by 2002:a2e:9bd8:: with SMTP id w24mr1575822ljj.126.1612499244016;
        Thu, 04 Feb 2021 20:27:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAROX3NBDY8t05hB5Oona3HjOfSSl1ABIXZQWhVcZMuwiFce13KCzBfaZfdYvJTVkPKnqJVQAGzuS8MpNZ+Pg=
X-Received: by 2002:a2e:9bd8:: with SMTP id w24mr1575796ljj.126.1612499243414;
 Thu, 04 Feb 2021 20:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20210204051850.64857-1-aaron.ma@canonical.com>
In-Reply-To: <20210204051850.64857-1-aaron.ma@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 5 Feb 2021 12:27:12 +0800
Message-ID: <CAAd53p4euFiw7pfDnD2H8oMVeeTqQ_c+wOFDLM2xPccn5MewiA@mail.gmail.com>
Subject: Re: [PATCH] xhci-pci: Set AMD Renoir USB controller to D3 when shutdown
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>, lee.jones@linaro.org,
        peter.chen@nxp.com, USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 1:20 PM Aaron Ma <aaron.ma@canonical.com> wrote:
>
> On AMD Renoir/Cezanne platforms, when set "Always on USB" to "On" in BIOS,
> USB controller will consume more power than 0.03w.
>
> Set it to D3cold when shutdown, S5 power consumption will be 0.03w lower.
> The USB can charge other devices as before.
> USB controller works fine after power on and reboot.

Can you please test the following patch, which should address the root cause:
https://lore.kernel.org/linux-acpi/20201201213019.1558738-1-furquan@google.com/

It also helps another AMD laptop on S5:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1912935

We don't need to put bandage on drivers one by one once the patch with
alternative approach is in upstream.

Kai-Heng

>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/usb/host/xhci-pci.c | 8 ++++++++
>  drivers/usb/host/xhci.h     | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 84da8406d5b4..a31be1ba927f 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -62,6 +62,7 @@
>  #define PCI_DEVICE_ID_AMD_PROMONTORYA_3                        0x43ba
>  #define PCI_DEVICE_ID_AMD_PROMONTORYA_2                        0x43bb
>  #define PCI_DEVICE_ID_AMD_PROMONTORYA_1                        0x43bc
> +#define PCI_DEVICE_ID_AMD_RENOIR_USB31                 0x1639
>  #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI                        0x1042
>  #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI               0x1142
>  #define PCI_DEVICE_ID_ASMEDIA_1142_XHCI                        0x1242
> @@ -171,6 +172,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>         if (pdev->vendor == PCI_VENDOR_ID_AMD)
>                 xhci->quirks |= XHCI_TRUST_TX_LENGTH;
>
> +       if (pdev->vendor == PCI_VENDOR_ID_AMD &&
> +               pdev->device == PCI_DEVICE_ID_AMD_RENOIR_USB31)
> +               xhci->quirks |= XHCI_SHUTDOWN_D3COLD;
> +
>         if ((pdev->vendor == PCI_VENDOR_ID_AMD) &&
>                 ((pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4) ||
>                 (pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_3) ||
> @@ -594,6 +599,9 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
>         /* Yet another workaround for spurious wakeups at shutdown with HSW */
>         if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
>                 pci_set_power_state(pdev, PCI_D3hot);
> +
> +       if (xhci->quirks & XHCI_SHUTDOWN_D3COLD)
> +               pci_set_power_state(pdev, PCI_D3cold);
>  }
>  #endif /* CONFIG_PM */
>
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 25e57bc9c3cc..0684193da4bd 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1883,6 +1883,7 @@ struct xhci_hcd {
>  #define XHCI_SKIP_PHY_INIT     BIT_ULL(37)
>  #define XHCI_DISABLE_SPARSE    BIT_ULL(38)
>  #define XHCI_SG_TRB_CACHE_SIZE_QUIRK   BIT_ULL(39)
> +#define XHCI_SHUTDOWN_D3COLD   BIT_ULL(40)
>
>         unsigned int            num_active_eps;
>         unsigned int            limit_active_eps;
> --
> 2.30.0
>
