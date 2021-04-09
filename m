Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D7235A19B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 16:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhDIPAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:00:02 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59203 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233908AbhDIO7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:59:55 -0400
Received: (qmail 1333912 invoked by uid 1000); 9 Apr 2021 10:59:41 -0400
Date:   Fri, 9 Apr 2021 10:59:41 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        liudongdong3@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kong.kongxinwei@hisilicon.com,
        yisen.zhuang@huawei.com
Subject: Re: [PATCH v4] USB:ehci:fix Kunpeng920 ehci hardware problem
Message-ID: <20210409145941.GA1333284@rowland.harvard.edu>
References: <1617958081-17999-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617958081-17999-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 04:48:01PM +0800, Longfang Liu wrote:
> Kunpeng920's EHCI controller does not have SBRN register.
> Reading the SBRN register when the controller driver is
> initialized will get 0.
> 
> When rebooting the EHCI driver, ehci_shutdown() will be called.
> if the sbrn flag is 0, ehci_shutdown() will return directly.
> The sbrn flag being 0 will cause the EHCI interrupt signal to
> not be turned off after reboot. this interrupt that is not closed
> will cause an exception to the device sharing the interrupt.
> 
> Therefore, the EHCI controller of Kunpeng920 needs to skip
> the read operation of the SBRN register.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> Changes in v4:
> 	- Modify the code implementation.
> 
> Changes in v3:
> 	- Fix some code style issues.
> 	- Update struct name.
> 
> Changes in v2:
> 	- Fix some code style issues.
> 	- Update function name.
> 
>  drivers/usb/host/ehci-pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index 3c3820a..237a346 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -291,6 +291,9 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
>  	if (pdev->vendor == PCI_VENDOR_ID_STMICRO
>  	    && pdev->device == PCI_DEVICE_ID_STMICRO_USB_HOST)
>  		;	/* ConneXT has no sbrn register */
> +	else if (pdev->vendor == PCI_VENDOR_ID_HUAWEI
> +			 && pdev->device == 0xa239)
> +		;	/* HUAWEI Kunpeng920 USB EHCI has no sbrn register */
>  	else
>  		pci_read_config_byte(pdev, 0x60, &ehci->sbrn);
>  
> -- 
> 2.8.1
> 
