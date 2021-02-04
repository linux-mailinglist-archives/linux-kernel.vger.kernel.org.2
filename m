Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285F530F550
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbhBDOpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:45:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236864AbhBDOks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:40:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F63864F42;
        Thu,  4 Feb 2021 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612449607;
        bh=kVmYv5gZTHyQL2Dwt36m5YgYZwdwCLXW0K16gp0A8dI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R0UVXkzfMSGNn8Euh4XgcA5i6TZxQnNla+PdmdIsE9MmvHDsZW2/6y35WIaSQG2KT
         OCWRg0CH5HPLJPUSOToS2lVJasC/i0bPsSZTmFOWdVA4Wg+e51i6oKeSgwjK2qDo8M
         Txb2YBCzlebie9R6OMIITRK1tbGQIF/UHcndqjsY=
Date:   Thu, 4 Feb 2021 15:40:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Minas Harutyunyan <hminas@synopsys.com>
Subject: Re: [PATCH v2 2/6] usb: dwc2: pci: Drop the empty quirk function
Message-ID: <YBwHRcyjmvPhajGX@kroah.com>
References: <20210204141711.53775-1-heikki.krogerus@linux.intel.com>
 <20210204141711.53775-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204141711.53775-3-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 05:17:07PM +0300, Heikki Krogerus wrote:
> The function dwc2_pci_quirks() does nothing. Removing.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Minas Harutyunyan <hminas@synopsys.com>
> ---
>  drivers/usb/dwc2/pci.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/pci.c b/drivers/usb/dwc2/pci.c
> index 7afc10872f1f0..0000151e3ca96 100644
> --- a/drivers/usb/dwc2/pci.c
> +++ b/drivers/usb/dwc2/pci.c
> @@ -63,20 +63,6 @@ struct dwc2_pci_glue {
>  	struct platform_device *phy;
>  };
>  
> -static int dwc2_pci_quirks(struct pci_dev *pdev, struct platform_device *dwc2)
> -{
> -	if (pdev->vendor == PCI_VENDOR_ID_SYNOPSYS &&
> -	    pdev->device == PCI_PRODUCT_ID_HAPS_HSOTG) {
> -		struct property_entry properties[] = {
> -			{ },
> -		};
> -
> -		return platform_device_add_properties(dwc2, properties);
> -	}
> -
> -	return 0;
> -}
> -
>  /**
>   * dwc2_pci_probe() - Provides the cleanup entry points for the DWC_otg PCI
>   * driver
> @@ -143,10 +129,6 @@ static int dwc2_pci_probe(struct pci_dev *pci,
>  
>  	dwc2->dev.parent = dev;
>  
> -	ret = dwc2_pci_quirks(pci, dwc2);
> -	if (ret)
> -		goto err;
> -
>  	glue = devm_kzalloc(dev, sizeof(*glue), GFP_KERNEL);
>  	if (!glue) {
>  		ret = -ENOMEM;

This is crazy.  I'll go apply this right now :)

thanks,

greg k-h
