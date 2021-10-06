Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90123423570
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 03:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbhJFB3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 21:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhJFB3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 21:29:07 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8685FC061749;
        Tue,  5 Oct 2021 18:27:15 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l13so1005599qtv.3;
        Tue, 05 Oct 2021 18:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5V/CYpZDaox8A4m9HczsKoqQ1wtwSA/29fW/9YWuUg=;
        b=ckdJ1ofQolakb9qYLOXHqOqdztVHWt7OPkn5cdwwXmel359jJcqZjM5QS2fP3IQWc9
         mzNzz6vXC5HJHEt62VeDnV2joYMh7KNS7oB0lCnSzS+DrCR/OojyFMQdi3v357pl20su
         wZ4xIyCFjQjoM1HpZ80aRqkhfDZBO5kIdrswE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5V/CYpZDaox8A4m9HczsKoqQ1wtwSA/29fW/9YWuUg=;
        b=oGNyhbJ60m3kiDrHan/6c+DDlkT7LaZ0rngJ7gw7djtOoTjDBvSPN4jvWoB1D85tX6
         0DhB1eItHvgfFRtjUw9O1G91mgxVY+SHmkGijWHGnpGeXMkKYtc83OZvldmxOuQ+XXnQ
         jCpJ3CGBEpLWfxmMhJvbPBdXJhhkkAR4PYSwB/LuJRiLkmDX0W3gKo3QwjpE00t1F8Rn
         WogkOJoteXBdMQ4auqOjEusf4RjcExH1CIX308Pqq71aECjy2G5Qunq6/tADv7vN81GW
         OS+cH0xxGTZ+G1IUHHAtGWvVks922cMh9rEtaOen+6dIhxofoQ2Ue3dHXlKLSQGzuzCM
         PA3w==
X-Gm-Message-State: AOAM5319mCXZDsQ3RpwNsfAMHCPm0hfl12F8TsQV5pwjQyL9LHJhk/k4
        +QrtMDd7Azqn9zthWWGepzV308wWOmgsxHnPqAA=
X-Google-Smtp-Source: ABdhPJzT1l9b+M36cXq5gGZEJbZS03Kabud0GqWeHScKREcFXttNa38KaP4Cr1WMWpPTL8ttV2cmwm4KjdbM2pdUGQM=
X-Received: by 2002:a05:622a:45:: with SMTP id y5mr23214853qtw.145.1633483634594;
 Tue, 05 Oct 2021 18:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210910073619.26095-1-neal_liu@aspeedtech.com>
In-Reply-To: <20210910073619.26095-1-neal_liu@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 6 Oct 2021 01:27:02 +0000
Message-ID: <CACPK8Xf40cfnFFeeAzkdXk6ikbfBhWOOt6U8Oq3iCaxe5v5=_w@mail.gmail.com>
Subject: Re: [PATCH v4] usb: ehci: handshake CMD_RUN instead of STS_HALT
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Tao Ren <rentao.bupt@gmail.com>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Bruce Mitchell <Bruce.Mitchell@ibm.com>,
        Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, 10 Sept 2021 at 07:38, Neal Liu <neal_liu@aspeedtech.com> wrote:
>
> For Aspeed, HCHalted status depends on not only Run/Stop but also
> ASS/PSS status.
> Handshake CMD_RUN on startup instead.
>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
> Tested-by: Tao Ren <rentao.bupt@gmail.com>

Has this one gone in? If not, here's some tags:

Reviewed-by: Joel Stanley <joel@jms.id.au>

It also needs to go to stable:

Cc: stable@vger.kernel.org
Fixes: 280a9045bb18 ("ehci: fix EHCI host controller initialization sequence")

Cheers,

Joel

> ---
>  drivers/usb/host/ehci-hcd.c      | 11 ++++++++++-
>  drivers/usb/host/ehci-platform.c |  6 ++++++
>  drivers/usb/host/ehci.h          |  1 +
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> ---
> Fix STS_HALT handshake failure for Aspeed 2500/2600 platform.
>
> Change since v3:
> - Add more description.
>
> Change since v2:
> - Use my "real" name for both the Signed-off-by: line and the From: line.
>
> Change since v1:
> - Handshake CMD_RUN status on startup instead of easily skip it.
> ---
>
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 6bdc6d6bf74d..55f92d25336b 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -634,7 +634,16 @@ static int ehci_run (struct usb_hcd *hcd)
>         /* Wait until HC become operational */
>         ehci_readl(ehci, &ehci->regs->command); /* unblock posted writes */
>         msleep(5);
> -       rc = ehci_handshake(ehci, &ehci->regs->status, STS_HALT, 0, 100 * 1000);
> +
> +       /* For Aspeed, STS_HALT also depends on ASS/PSS status.
> +        * Check CMD_RUN instead.
> +        */
> +       if (ehci->is_aspeed)
> +               rc = ehci_handshake(ehci, &ehci->regs->command, CMD_RUN,
> +                                   1, 100 * 1000);
> +       else
> +               rc = ehci_handshake(ehci, &ehci->regs->status, STS_HALT,
> +                                   0, 100 * 1000);
>
>         up_write(&ehci_cf_port_reset_rwsem);
>
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index c70f2d0b4aaf..c3dc906274d9 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -297,6 +297,12 @@ static int ehci_platform_probe(struct platform_device *dev)
>                                           "has-transaction-translator"))
>                         hcd->has_tt = 1;
>
> +               if (of_device_is_compatible(dev->dev.of_node,
> +                                           "aspeed,ast2500-ehci") ||
> +                   of_device_is_compatible(dev->dev.of_node,
> +                                           "aspeed,ast2600-ehci"))
> +                       ehci->is_aspeed = 1;
> +
>                 if (soc_device_match(quirk_poll_match))
>                         priv->quirk_poll = true;
>
> diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> index 80bb823aa9fe..fdd073cc053b 100644
> --- a/drivers/usb/host/ehci.h
> +++ b/drivers/usb/host/ehci.h
> @@ -219,6 +219,7 @@ struct ehci_hcd {                   /* one per controller */
>         unsigned                need_oc_pp_cycle:1; /* MPC834X port power */
>         unsigned                imx28_write_fix:1; /* For Freescale i.MX28 */
>         unsigned                spurious_oc:1;
> +       unsigned                is_aspeed:1;
>
>         /* required for usb32 quirk */
>         #define OHCI_CTRL_HCFS          (3 << 6)
> --
> 2.25.1
>
