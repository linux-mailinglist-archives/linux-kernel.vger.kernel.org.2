Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4040D3CC3A0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 15:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhGQNmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 09:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhGQNm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 09:42:29 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A10FC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 06:39:32 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l11so2866705ljq.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wMysod/FxYgvZzqmI+wGDhxKEpokYzXYS9Z8NQkl9ME=;
        b=dx3rzI7bTiu4T3bOQldfOy1OsFPlkh8bBfCb9jy5V8APCP58TFHseMNd9H/okgmswf
         hUKephRuwDpjGCW1EMdvDYrqArAsrkr0iOBqiPc/BNwsAcr63DSlQ8/fMJJKhjWoZTvJ
         VeTfrx1L3pkh4TvaF7hs8xXw2oxYnqrN+/WH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMysod/FxYgvZzqmI+wGDhxKEpokYzXYS9Z8NQkl9ME=;
        b=On/IWQeycBB4laphermKcpNvBgkLL3+AK34pBgsO8nbSbq3lnBapfJmeFpNKaX9T62
         vvuZkCb6fTx2E4DuiR6IuDzQiANfUC6eNol62qYLfvAf/V7Nb/fRypdGiNX3QiB06p/5
         NVpia9hJ8oZ9l5TV37gBImaBtcRlL4b8+EUDIN9xHWSK+CgkWLUm9Mx3EFWDeB6VlJvw
         2K8H1JZnyIkW7c/1j8k1s//nQNB0n18HAwC5h5kjPXn1B0LL3aTBz8pyLFBkDkayLHpK
         HdVDsclFUmH0CdY7OoO8qDjeewLx/lXNk45d9+0nbL+lxrIwKAvoA/wuTgQ45+68WXbG
         bzEQ==
X-Gm-Message-State: AOAM530uksAvPsrkYP+t8XOjsGiiGIVU0KyZC3r2p6pKXOBdsDH/WxjU
        Yhh++hcuJKr2HB3OtF4lGqsqTgvMcyl79cY5gnZvAQ==
X-Google-Smtp-Source: ABdhPJwrBJIk83MDhG8twlHGK2D602TuoBySGjD8NgUQYkCsFRJjpLsnWZmn20MwEw5AyXgT+h/L6Y637xngf2CDgJM=
X-Received: by 2002:a2e:a90e:: with SMTP id j14mr8861414ljq.250.1626529170617;
 Sat, 17 Jul 2021 06:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210712060912.995381202@linuxfoundation.org> <20210712060916.499546891@linuxfoundation.org>
In-Reply-To: <20210712060916.499546891@linuxfoundation.org>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Sat, 17 Jul 2021 08:39:19 -0500
Message-ID: <CAFxkdApAJ2i_Bg6Ghd38Tw9Lz5s6FTKP=3-+pSWM-cDT427i2g@mail.gmail.com>
Subject: Re: [PATCH 5.13 024/800] usb: renesas-xhci: Fix handling of unknown
 ROM state
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Moritz Fischer <mdf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 2:31 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Moritz Fischer <mdf@kernel.org>
>
> commit d143825baf15f204dac60acdf95e428182aa3374 upstream.
>
> The ROM load sometimes seems to return an unknown status
> (RENESAS_ROM_STATUS_NO_RESULT) instead of success / fail.
>
> If the ROM load indeed failed this leads to failures when trying to
> communicate with the controller later on.
>
> Attempt to load firmware using RAM load in those cases.
>
> Fixes: 2478be82de44 ("usb: renesas-xhci: Add ROM loader for uPD720201")
> Cc: stable@vger.kernel.org
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Tested-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Link: https://lore.kernel.org/r/20210615153758.253572-1-mdf@kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>

After sending out 5.12.17 for testing, we had a user complain that all
of their USB devices disappeared with the error:

Jul 15 23:18:53 kernel: xhci_hcd 0000:04:00.0: Direct firmware load
for renesas_usb_fw.mem failed with error -2
Jul 15 23:18:53 kernel: xhci_hcd 0000:04:00.0: request_firmware failed: -2
Jul 15 23:18:53 kernel: xhci_hcd: probe of 0000:04:00.0 failed with error -2

After first assuming that something was missing in the backport to
5.12, I had the user try 5.13.2, and then 5.14-rc1. Both of those
failed in the same way, so it is not working in the current Linus tree
either.  Reverting this patch fixed the issue.

Justin

> ---
>  drivers/usb/host/xhci-pci-renesas.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> --- a/drivers/usb/host/xhci-pci-renesas.c
> +++ b/drivers/usb/host/xhci-pci-renesas.c
> @@ -207,7 +207,8 @@ static int renesas_check_rom_state(struc
>                         return 0;
>
>                 case RENESAS_ROM_STATUS_NO_RESULT: /* No result yet */
> -                       return 0;
> +                       dev_dbg(&pdev->dev, "Unknown ROM status ...\n");
> +                       break;
>
>                 case RENESAS_ROM_STATUS_ERROR: /* Error State */
>                 default: /* All other states are marked as "Reserved states" */
> @@ -224,13 +225,12 @@ static int renesas_fw_check_running(stru
>         u8 fw_state;
>         int err;
>
> -       /* Check if device has ROM and loaded, if so skip everything */
> -       err = renesas_check_rom(pdev);
> -       if (err) { /* we have rom */
> -               err = renesas_check_rom_state(pdev);
> -               if (!err)
> -                       return err;
> -       }
> +       /*
> +        * Only if device has ROM and loaded FW we can skip loading and
> +        * return success. Otherwise (even unknown state), attempt to load FW.
> +        */
> +       if (renesas_check_rom(pdev) && !renesas_check_rom_state(pdev))
> +               return 0;
>
>         /*
>          * Test if the device is actually needing the firmware. As most
>
>
