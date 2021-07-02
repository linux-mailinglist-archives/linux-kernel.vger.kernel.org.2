Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BC23B9C15
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 07:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhGBF64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 01:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhGBF6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 01:58:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E897861422;
        Fri,  2 Jul 2021 05:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625205377;
        bh=ltAHgBZoatLxhD2aNZF8zgZVvOBEz+0vM8QBekKkXe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZguxkjoqco9nMVyQmBs64qKQnbTfHmbNU86Df9OM/b/rt/h5VBZgV8SM+likgTyq
         hDODWdhqXmnFWPD/GjnyNjU+cdzJ07/tu4O/w5ZgjEPG6eXY2E7Ho170GYAiFuA2HI
         EmfedpJ///gLhWkg0oo09TkFxU7kXhzvAZV65hVc=
Date:   Fri, 2 Jul 2021 07:56:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Greg Thelen <gthelen@google.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: avoid renesas_usb_fw.mem when it's unusable
Message-ID: <YN6qf51XfkHFsDx/@kroah.com>
References: <20210702054754.2056918-1-gthelen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702054754.2056918-1-gthelen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 10:47:54PM -0700, Greg Thelen wrote:
> Commit a66d21d7dba8 ("usb: xhci: Add support for Renesas controller with
> memory") added renesas_usb_fw.mem firmware reference to xhci-pci.  Thus
> modinfo indicates xhci-pci.ko has "firmware: renesas_usb_fw.mem".  But
> the firmware is only actually used with CONFIG_USB_XHCI_PCI_RENESAS.  An
> unusable firmware reference can trigger safety checkers which look for
> drivers with unmet firmware dependencies.
> 
> Avoid referring to renesas_usb_fw.mem in circumstances when it cannot be
> loaded (when CONFIG_USB_XHCI_PCI_RENESAS isn't set).
> 
> Signed-off-by: Greg Thelen <gthelen@google.com>
> ---
>  drivers/usb/host/xhci-pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 18c2bbddf080..cb148da7a789 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -618,8 +618,10 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
>  /*-------------------------------------------------------------------------*/
>  
>  static const struct xhci_driver_data reneses_data = {
> +#if IS_ENABLED(CONFIG_USB_XHCI_PCI_RENESAS)

If this is not enabled, why is the whole structure needed?

>  	.quirks  = XHCI_RENESAS_FW_QUIRK,
>  	.firmware = "renesas_usb_fw.mem",
> +#endif
>  };
>  
>  /* PCI driver selection metadata; PCI hotplugging uses this */
> @@ -636,7 +638,13 @@ static const struct pci_device_id pci_ids[] = {
>  	{ /* end: all zeroes */ }
>  };
>  MODULE_DEVICE_TABLE(pci, pci_ids);
> +/*
> + * Without CONFIG_USB_XHCI_PCI_RENESAS renesas_xhci_check_request_fw() won't
> + * load firmware, so don't encumber the xhci-pci driver with it.
> + */
> +#if IS_ENABLED(CONFIG_USB_XHCI_PCI_RENESAS)
>  MODULE_FIRMWARE("renesas_usb_fw.mem");
> +#endif

Why not just have this one chunk, why is the first chunk needed?

And a blank line please before your comment?

And can you add a Fixes: line to the changelog text when you resend?

thanks,

greg k-h
