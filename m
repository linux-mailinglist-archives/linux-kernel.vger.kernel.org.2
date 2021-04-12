Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FBC35BBF3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbhDLISu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:18:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32852 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbhDLISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:18:47 -0400
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lVrm8-0002Df-4Z
        for linux-kernel@vger.kernel.org; Mon, 12 Apr 2021 08:18:28 +0000
Received: by mail-lf1-f71.google.com with SMTP id 26so4245628lfp.19
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6cn2oRdv5Lr/xBRjd88otZL6Tx1HK5wsUDmmEldJ28=;
        b=QSA2B0yIpZ5hFt1DrKyXwn1R4JmTQsbT8RKXL5KcYNzkqNzKPgYXAqE+1ccY7ES8FV
         kF3mf54iX/4XskTX8/r+AFtF8sPGGy5GNyPZyZ46TzW+IJZOG0TMJP29628FDZwzNyvT
         +f1Yurz56l1U5tXtZZdoe8rlCvlJLCEKS2HU/aF9IV31GdrmPfII2a7x/0kEWBzkcXsH
         mbGDKthtGJDtoWwzUovJZk1X+Og8mY0Rwg1gn1EvWYgvrPVomdUXd6R+g93NzdnIYSo3
         ehAvf49d1SEO+fLjKBQMOaKLcwZ0QpEPh3vGXMyfHPYZQ4fgdQu4Hboi7mRA/6vDVVf/
         HE2Q==
X-Gm-Message-State: AOAM5328TV0yO7Y2yiw54CRI4DnwGD9rszLVXB0yppgRsanW9GrrnIb8
        BxmEJdMIWrTuo/t3DAS2yr8/ImqzyuiW/q9H2zLonJ12CpTHKvrDNTjEJHexdLAN9+n7AFLSEE4
        W9O97f1svikSXtkJveIK74DiZcJiqbGrt4m87dcV8tRI/m/7ZE0a8fu4KUQ==
X-Received: by 2002:a05:6512:ac2:: with SMTP id n2mr4900382lfu.194.1618215507578;
        Mon, 12 Apr 2021 01:18:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwctJkxS2lm45kAjd/Rroz41Jy7K/rew1CnZxhVwsgOB13URqXK6in0B0bYD4OvLR4GYj8e3MfxhS54iSzL6J8=
X-Received: by 2002:a05:6512:ac2:: with SMTP id n2mr4900369lfu.194.1618215507298;
 Mon, 12 Apr 2021 01:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210329052339.20882-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210329052339.20882-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 12 Apr 2021 16:18:16 +0800
Message-ID: <CAAd53p7fBKadTdsWZOe4O8ZuQDS6BCmkuA1ettZC7vxAxNw7Bw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Disable D3cold support on Intel XMM7360
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 1:23 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On some platforms, the root port for Intel XMM7360 WWAN supports D3cold.
> When the root port is put to D3cold by system suspend or runtime
> suspend, attempt to systems resume or runtime resume will freeze the
> laptop for a while, then it automatically shuts down.
>
> The root cause is unclear for now, as the Intel XMM7360 doesn't have a
> driver yet.
>
> So disable D3cold for XMM7360 as a workaround, until proper device
> driver is in place.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212419
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
> v2:
>  - Add comment.
>
>  drivers/pci/quirks.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..c48b0b4a4164 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5612,3 +5612,16 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
>                                PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> +
> +/*
> + * Device [8086:7360]
> + * When it resumes from D3cold, system freeze and shutdown happens.
> + * Currently there's no driver for XMM7360, so add it as a PCI quirk.
> + * https://bugzilla.kernel.org/show_bug.cgi?id=212419
> + */
> +static void pci_fixup_no_d3cold(struct pci_dev *pdev)
> +{
> +       pci_info(pdev, "disable D3cold\n");
> +       pci_d3cold_disable(pdev);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7360, pci_fixup_no_d3cold);
> --
> 2.30.2
>
