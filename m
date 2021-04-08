Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DB2357F07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhDHJWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:22:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhDHJWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:22:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AACB361166;
        Thu,  8 Apr 2021 09:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617873726;
        bh=Ldyy5p8qNIJW45yhEXFnxF+Ibo1nV8mgcf3vOVeJ8Io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZ+wDG5V1dUmoTX/eISyd+EqMNqmrYpq+lxlFTWpFMZYS6s1Zds0c8Oj81iIqC7ML
         cjF+Ya2xo6Pd0/74cXzJZRgosuB5ToTtGerN9Ik1tvXeH7VFBnYV8OHnnm/cnvCqMJ
         AzKjVAR8wqd1urDCnR1BB4x+62iIDE84bBVU1tbI=
Date:   Thu, 8 Apr 2021 11:22:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        liudongdong3@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kong.kongxinwei@hisilicon.com,
        yisen.zhuang@huawei.com
Subject: Re: [PATCH 1/2] USB:ehci:Add a whitelist for EHCI controllers
Message-ID: <YG7LO2DJMThbeJ5W@kroah.com>
References: <1617873073-37371-1-git-send-email-liulongfang@huawei.com>
 <1617873073-37371-2-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617873073-37371-2-git-send-email-liulongfang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 05:11:12PM +0800, Longfang Liu wrote:
> Some types of EHCI controllers do not have SBRN registers.
> By comparing the white list, the operation of reading the SBRN
> registers is skipped.
> 
> Subsequent EHCI controller types without SBRN registers can be
> directly added to the white list.
> 
> The current patch does not affect the drive function.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/usb/host/ehci-pci.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index 3c3820a..6a30afa 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -47,6 +47,28 @@ static inline bool is_bypassed_id(struct pci_dev *pdev)
>  	return !!pci_match_id(bypass_pci_id_table, pdev);
>  }
>  
> +static const struct usb_nosbrn_whitelist_entry {
> +	unsigned short vendor;
> +	unsigned short device;

u16 here please.

> +} usb_nosbrn_whitelist[] = {
> +	/* STMICRO ConneXT has no sbrn register */
> +	{PCI_VENDOR_ID_STMICRO, PCI_DEVICE_ID_STMICRO_USB_HOST},
> +	{}

trailing , please.

> +};
> +
> +static bool usb_nosbrn_whitelist_check(struct pci_dev *pdev)
> +{
> +	const struct usb_nosbrn_whitelist_entry *entry;
> +
> +	for (entry = usb_nosbrn_whitelist; entry->vendor; entry++) {
> +		if (pdev->vendor == entry->vendor &&
> +		    pdev->device == entry->device)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * 0x84 is the offset of in/out threshold register,
>   * and it is the same offset as the register of 'hostpc'.
> @@ -288,10 +310,7 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
>  	}
>  
>  	/* Serial Bus Release Number is at PCI 0x60 offset */
> -	if (pdev->vendor == PCI_VENDOR_ID_STMICRO
> -	    && pdev->device == PCI_DEVICE_ID_STMICRO_USB_HOST)
> -		;	/* ConneXT has no sbrn register */
> -	else
> +	if (!usb_nosbrn_whitelist_check(pdev))

Doing this as a "negative" is hard to understand.  Should this just be:
	forbid_sbrn_read()
or something like that?

The term "whitelist" is not a good thing to use as it does not really
explain anything here.

thanks,

greg k-h
