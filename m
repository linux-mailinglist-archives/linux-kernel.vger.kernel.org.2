Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBF03CE6CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 19:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352808AbhGSQPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 12:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245160AbhGSPKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:10:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D082C00666B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:05:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t3so24509563edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MoJ3qq8q/idAx9bOHrmP9SfK/Oa7YrxiYtYS0zrlTPA=;
        b=iOTXZJ0SWidcccQuoZ4bVKQDMqg3fXBDavx11MQN5HK+++UR5O6S1dDw0SkusBMttg
         fhU39zT/5EGLkRsQx+AN0zmPQoJl8TH02jn0+Omk77NJMPoVvs/njS1Liwp5an8LehJ7
         7IgI25/UnFsPNbChj1KboOmwFl3fZSgj6Ave4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoJ3qq8q/idAx9bOHrmP9SfK/Oa7YrxiYtYS0zrlTPA=;
        b=agqFL7n33a52fNevfayMR9DFu26l/4JIU0rEZjND7oXPvduwTJ+JW8SsSdvoPDlGb7
         e4zZYGC6tu5H9NWvjoA9Q2n515yi1WeTn3RmCJM1EzQa3AKAyG4YEQRV00zF99Cexo96
         hI0mLlwQ0lk7iQakn9s77Z0Avc64Q6C3Cvw/fMgwN6y9nRI9Qm702/9oYVGZIgq8P62x
         nOzMau+scjVGRXfXY3LQSA97bSJyAj521xAUY/FKKgbIwYeHecQNYoL5M5EnkltgN1fl
         QFgTObqYK1KCaIiso/ExDWXjP2rxt1bO5hmhPeqXdZG2N7A1u5XoIeU0/96feaY62GUa
         MCbA==
X-Gm-Message-State: AOAM530VaTLwJjNYccfZi/vFA4B8XsXCmL1/oISlZA9jJ8xpErwwvk8g
        y/MzEK4HgNB2A7+CzPLOeBj0JXciag76uSVAtU+nEQ==
X-Google-Smtp-Source: ABdhPJzkHgzAzX6mqgNxzQLAsuAOEUo/GiGdoITemQq27T/JV0/C1gLGJbRqYpBUH7roxgVhmPjMEDvPrsctV8AIUOY=
X-Received: by 2002:a05:6402:c13:: with SMTP id co19mr34941490edb.64.1626708846512;
 Mon, 19 Jul 2021 08:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210712060912.995381202@linuxfoundation.org> <20210712060916.499546891@linuxfoundation.org>
 <CAFxkdApAJ2i_Bg6Ghd38Tw9Lz5s6FTKP=3-+pSWM-cDT427i2g@mail.gmail.com> <YPNavEl340mxcNVd@epycbox.lan>
In-Reply-To: <YPNavEl340mxcNVd@epycbox.lan>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 19 Jul 2021 10:33:55 -0500
Message-ID: <CAFxkdApGaw30O2HEkTA8r6g4_dLZEbykVjnnDnfTiX=3hVQwvw@mail.gmail.com>
Subject: Re: [PATCH 5.13 024/800] usb: renesas-xhci: Fix handling of unknown
 ROM state
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 5:33 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> Justin,
>
> On Sat, Jul 17, 2021 at 08:39:19AM -0500, Justin Forbes wrote:
> > On Mon, Jul 12, 2021 at 2:31 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > From: Moritz Fischer <mdf@kernel.org>
> > >
> > > commit d143825baf15f204dac60acdf95e428182aa3374 upstream.
> > >
> > > The ROM load sometimes seems to return an unknown status
> > > (RENESAS_ROM_STATUS_NO_RESULT) instead of success / fail.
> > >
> > > If the ROM load indeed failed this leads to failures when trying to
> > > communicate with the controller later on.
> > >
> > > Attempt to load firmware using RAM load in those cases.
> > >
> > > Fixes: 2478be82de44 ("usb: renesas-xhci: Add ROM loader for uPD720201")
> > > Cc: stable@vger.kernel.org
> > > Cc: Mathias Nyman <mathias.nyman@intel.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Vinod Koul <vkoul@kernel.org>
> > > Tested-by: Vinod Koul <vkoul@kernel.org>
> > > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > Link: https://lore.kernel.org/r/20210615153758.253572-1-mdf@kernel.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> >
> > After sending out 5.12.17 for testing, we had a user complain that all
> > of their USB devices disappeared with the error:
> >
> > Jul 15 23:18:53 kernel: xhci_hcd 0000:04:00.0: Direct firmware load
> > for renesas_usb_fw.mem failed with error -2
> > Jul 15 23:18:53 kernel: xhci_hcd 0000:04:00.0: request_firmware failed: -2
> > Jul 15 23:18:53 kernel: xhci_hcd: probe of 0000:04:00.0 failed with error -2
>
> This looks like it fails finding the actual firmware file (ENOENT). Any
> chance you could give this a whirl on top of the original patch?
>

Sure. test kernel building now, will let you know when the user reports back.

Justin

> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 18c2bbddf080..cde8f6f1ec5d 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -379,7 +379,11 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>         driver_data = (struct xhci_driver_data *)id->driver_data;
>         if (driver_data && driver_data->quirks & XHCI_RENESAS_FW_QUIRK) {
>                 retval = renesas_xhci_check_request_fw(dev, id);
> -               if (retval)
> +               /*
> +                * If firmware wasn't found there's still a chance this might work without
> +                * loading firmware on some systems, so let's try at least.
> +                */
> +               if (retval && retval != -ENOENT)
>                         return retval;
>         }
>
>
> Thanks,
> Moritz
