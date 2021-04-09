Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B69359807
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhDIIhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:37:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16499 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhDIIhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:37:39 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGrz14M7xzPpcL;
        Fri,  9 Apr 2021 16:34:37 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 16:37:16 +0800
Subject: Re: [PATCH v4] USB:ehci:fix Kunpeng920 ehci hardware problem
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <liudongdong3@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kong.kongxinwei@hisilicon.com>, <yisen.zhuang@huawei.com>
References: <1617957098-8375-1-git-send-email-liulongfang@huawei.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <83e50a56-d168-1a4c-a393-92f2aff8bcfd@huawei.com>
Date:   Fri, 9 Apr 2021 16:37:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1617957098-8375-1-git-send-email-liulongfang@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/9 16:31, Longfang Liu wrote:
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
> 
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
Sorry.
There is a problem with the format, I need to resend
Thanks.
Longfang.
> +		;	/* HUAWEI Kunpeng920 USB EHCI has no sbrn register */
>  	else
>  		pci_read_config_byte(pdev, 0x60, &ehci->sbrn);
>  
> 
