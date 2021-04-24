Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E7C369FE2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 08:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhDXG4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 02:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233122AbhDXGtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 02:49:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B04F961482;
        Sat, 24 Apr 2021 06:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619246905;
        bh=iDFkMz9wTw259TartRiubkvfsE8bQ88Y8Y/a1w04IbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aX7gfFQjMmFffHJKkzQzRLd8+QeBJq6xjsQZV110DFI1+SaEy8CNBOIQsxtxVUtxH
         9w8pN9Om/9FW2r+F/BeLZzgY8RyczijKerFryPXRzCnxjm2t3fsZdeQBddTuL6iJa8
         Ii99QflHKNeL0O9P8UC0wUvQcSLdvzylA8uNAxm4=
Date:   Sat, 24 Apr 2021 08:48:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     firas ashkar <firas.ashkar@savoirfairelinux.com>
Cc:     mst@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: uio: uio_pci_generic: add missing memory mappings
Message-ID: <YIO/MgBS15Gme0Nu@kroah.com>
References: <b9598838a77c156a88b2847f43c3a276c340de04.camel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9598838a77c156a88b2847f43c3a276c340de04.camel@savoirfairelinux.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 12:10:29PM -0400, firas ashkar wrote:
> Hi,
> pls find attached a trivial but necessary patch, this change is based on [drivers/uio/uio_pdrv_genirq.c], 
> the patch was tested on following hardware: MiniPCIE AltaData ARNIC-429 module on imx8qm-apalis-ixora-v1.2
> 
> -- 
> Firas Ashkar
> Developpeur Système Embarqué
> 
> savoirfairelinux.com  | Montréal, Québec
> 
> Tél.: +1 514 276 5468 ext. 118
> --------------------------------------
> 
> >From 0c83bbc8bbf6c45efc52f6d30b8302a5d9075198 Mon Sep 17 00:00:00 2001
> From: Firas Ashkar <firas.ashkar@savoirfairelinux.com>
> Date: Fri, 23 Apr 2021 10:38:28 -0400
> Subject: [PATCH 1/1] uio: uio_pci_generic: add memory mappings
> 
> import memory resources from underlaying pci device, thus allowing
> userspace applications to memory map those resources.
> ---
>  drivers/uio/uio_pci_generic.c | 52 +++++++++++++++++++++++++++++------
>  1 file changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/uio/uio_pci_generic.c
> b/drivers/uio/uio_pci_generic.c
> index c7d681fef198..809eca95b5bb 100644
> --- a/drivers/uio/uio_pci_generic.c
> +++ b/drivers/uio/uio_pci_generic.c
> @@ -24,9 +24,9 @@
>  #include <linux/slab.h>
>  #include <linux/uio_driver.h>
>  
> -#define DRIVER_VERSION	"0.01.0"
> -#define DRIVER_AUTHOR	"Michael S. Tsirkin <mst@redhat.com>"
> -#define DRIVER_DESC	"Generic UIO driver for PCI 2.3 devices"
> +#define DRIVER_VERSION "0.01.0"
> +#define DRIVER_AUTHOR "Michael S. Tsirkin <mst@redhat.com>"
> +#define DRIVER_DESC "Generic UIO driver for PCI 2.3 devices"
>  
>  struct uio_pci_generic_dev {
>  	struct uio_info info;
> @@ -56,7 +56,8 @@ static int release(struct uio_info *info, struct
> inode *inode)
>  }
>  
>  /* Interrupt handler. Read/modify/write the command register to
> disable
> - * the interrupt. */
> + * the interrupt.
> + */
>  static irqreturn_t irqhandler(int irq, struct uio_info *info)
>  {
>  	struct uio_pci_generic_dev *gdev =
> to_uio_pci_generic_dev(info);
> @@ -68,11 +69,12 @@ static irqreturn_t irqhandler(int irq, struct
> uio_info *info)
>  	return IRQ_HANDLED;
>  }
>  
> -static int probe(struct pci_dev *pdev,
> -			   const struct pci_device_id *id)
> +static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct uio_pci_generic_dev *gdev;
> +	struct uio_mem *uiomem;
>  	int err;
> +	int i;
>  
>  	err = pcim_enable_device(pdev);
>  	if (err) {
> @@ -84,7 +86,8 @@ static int probe(struct pci_dev *pdev,
>  	if (pdev->irq && !pci_intx_mask_supported(pdev))
>  		return -ENOMEM;
>  
> -	gdev = devm_kzalloc(&pdev->dev, sizeof(struct
> uio_pci_generic_dev), GFP_KERNEL);
> +	gdev = devm_kzalloc(&pdev->dev, sizeof(struct
> uio_pci_generic_dev),
> +			    GFP_KERNEL);
>  	if (!gdev)
>  		return -ENOMEM;
>  
> @@ -97,8 +100,39 @@ static int probe(struct pci_dev *pdev,
>  		gdev->info.irq_flags = IRQF_SHARED;
>  		gdev->info.handler = irqhandler;
>  	} else {
> -		dev_warn(&pdev->dev, "No IRQ assigned to device: "
> -			 "no support for interrupts?\n");
> +		dev_warn(
> +			&pdev->dev,
> +			"No IRQ assigned to device: no support for
> interrupts?\n");
> +	}
> +
> +	uiomem = &gdev->info.mem[0];
> +	for (i = 0; i < MAX_UIO_MAPS; ++i) {
> +		struct resource *r = &pdev->resource[i];
> +
> +		if (r->flags != (IORESOURCE_SIZEALIGN |
> IORESOURCE_MEM))
> +			continue;
> +
> +		if (uiomem >= &gdev->info.mem[MAX_UIO_MAPS]) {
> +			dev_warn(
> +				&pdev->dev,
> +				"device has more than " __stringify(
> +					MAX_UIO_MAPS) " I/O memory
> resources.\n");
> +			break;
> +		}
> +
> +		uiomem->memtype = UIO_MEM_PHYS;
> +		uiomem->addr = r->start & PAGE_MASK;
> +		uiomem->offs = r->start & ~PAGE_MASK;
> +		uiomem->size =
> +			(uiomem->offs + resource_size(r) + PAGE_SIZE -
> 1) &
> +			PAGE_MASK;
> +		uiomem->name = r->name;
> +		++uiomem;
> +	}
> +
> +	while (uiomem < &gdev->info.mem[MAX_UIO_MAPS]) {
> +		uiomem->size = 0;
> +		++uiomem;
>  	}
>  
>  	return devm_uio_register_device(&pdev->dev, &gdev->info);
> -- 
> 2.25.1
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
