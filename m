Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B594D3A5E93
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 10:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhFNIvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 04:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhFNIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 04:51:19 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7BBC061574;
        Mon, 14 Jun 2021 01:49:17 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id j17-20020a0568200231b029024900620310so2470515oob.7;
        Mon, 14 Jun 2021 01:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhc5KrH7nB+vP5Okxryb0H1oOssNZwvGPDnO0KweY9U=;
        b=MorrzZBJZZfI2Eoa3wtobeR693l2V/0WBRrC4FXETifIrlWqp0THVdgdgBVc3DHKd2
         IzdersvWZpPPDTS9SyASCal2DLh7gbZpWWBdJPqfrdH6eZm3YNrgxCSAdYUzLtRbmdRG
         bHmVStMu8LKY5fwx1+1AcvFq8UNadbc5dUOlWbXhByxJYCzFFScqBHc0Z5zde9tofCKV
         YQjeNzCWGZO98W0Ap8QO4YZE+Akxxbn0ZqiDThU7CUKMA4lvXjuG/QbWanJGRE45jLIa
         5ZDYXDYW6WnrUeJeWeZCoR1SOur+fLpse5SipfEz5l66j62z415wDWOeBO1nlGcvvK8A
         KBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhc5KrH7nB+vP5Okxryb0H1oOssNZwvGPDnO0KweY9U=;
        b=rzApEInQs1CkJzsTo1+zxzgPwrvT3V1MOwNBJpdbMEJXT9sEx/auEvX6bbqdjLREGv
         DT6wenJN5d12JUypU6voIOAVyf89sgBOKAVw1x2iynUflU6NmvpCi0Ka85k8hQuyVP16
         pHuiM4Ml/joJBzGg+JlwMih7v/qRUIhVKDbVJbU6VMEBzX0hEjB2+tWAookSF6wjEVER
         wwnBwWbrkuCqbEzio7NMWZdLvQx6HQS6KiAtTIV0uCkcMvEpN9VuQAW2tOhU/tfUitVF
         MKSeCGKC9fKUFZkjGxMhIoU+D+CaMCnIMG0LkZd5J/94GHRTHVL9dxcUe/oam0ksCzvb
         0GRg==
X-Gm-Message-State: AOAM5309y8LVWN2mxc6hArSicn0NlJeCWexByNSnCnX+EVjs4mX8RpzM
        11TguEYhGSBVDLCksjmpM4EHQzNtosSGEbcHU3hmA3uyWVs=
X-Google-Smtp-Source: ABdhPJx48Q8vH/+qZq1gYLRoTJmGsY/tY/M9GXb80XM1Od6Tsq56xgD13o0XCiqSabUrsw9hJ5S4dhbfk37gYIB7Lo0=
X-Received: by 2002:a4a:9bcb:: with SMTP id b11mr12139019ook.44.1623660556399;
 Mon, 14 Jun 2021 01:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <e0d146b034576c755cb98018159fa30f8dba2101.1623476278.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <e0d146b034576c755cb98018159fa30f8dba2101.1623476278.git.christophe.jaillet@wanadoo.fr>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 14 Jun 2021 11:48:49 +0300
Message-ID: <CAFCwf109JLqs+Qb5MUDEjG6EXK09JmH+bJjDXvLhNXOrr2aF3A@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Fix an error handling path in 'hl_pci_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 8:42 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If an error occurs after a 'pci_enable_pcie_error_reporting()' call, it
> must be undone by a corresponding 'pci_disable_pcie_error_reporting()'
> call, as already done in the remove function.
>
> Fixes: 2e5eda4681f9 ("habanalabs: PCIe Advanced Error Reporting support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/misc/habanalabs/common/habanalabs_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
> index 64d1530db985..d15b912a347b 100644
> --- a/drivers/misc/habanalabs/common/habanalabs_drv.c
> +++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
> @@ -464,6 +464,7 @@ static int hl_pci_probe(struct pci_dev *pdev,
>         return 0;
>
>  disable_device:
> +       pci_disable_pcie_error_reporting(pdev);
>         pci_set_drvdata(pdev, NULL);
>         destroy_hdev(hdev);
>
> --
> 2.30.2
>

Thanks for catching it.
This patch is:
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>

Applied to -next.
Oded
