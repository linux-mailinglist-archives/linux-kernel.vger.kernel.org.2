Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9795B357D3A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhDHHU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:20:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15177 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhDHHUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:20:23 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGCJN74QYzpVX5;
        Thu,  8 Apr 2021 15:17:24 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 15:20:06 +0800
Subject: Re: [PATCH] USB:ehci:fix ehci hardware problem
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <liudongdong3@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kong.kongxinwei@hisilicon.com>, <yisen.zhuang@huawei.com>
References: <1617865425-28782-1-git-send-email-liulongfang@huawei.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <177a1fbd-b6f0-2e67-2e5a-5b05d2015b3a@huawei.com>
Date:   Thu, 8 Apr 2021 15:19:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1617865425-28782-1-git-send-email-liulongfang@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/8 15:03, Longfang Liu wrote:
> When rebooting the EHCI driver, ehci_shutdown() will be called.
> if the sbrn flag is 0, ehci_shutdown() will return directly.
> 
> Our EHCI hardware does not define the SBRN register, which cause
> its value to default to 0. The sbrn flag being 0 will cause the
> EHCI interrupt signal to not be turned off after reboot. An interrupt
> that is not closed will cause an exception to the device sharing
> the interrupt.
> 
> Currently, our hardware has this problem. We hope to solve this
> problem by skipping reading the sbrn register value. On the next
> generation of hardware, we will define this SBRN register in accordance
> with the controller standard.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/usb/host/ehci-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index 3c3820a..5dc6821 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -291,6 +291,8 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
>  	if (pdev->vendor == PCI_VENDOR_ID_STMICRO
>  	    && pdev->device == PCI_DEVICE_ID_STMICRO_USB_HOST)
>  		;	/* ConneXT has no sbrn register */
> +	else if (pdev->vendor == PCI_VENDOR_ID_HUAWEI)
> +		;	/* sbrn register is undefined */
>  	else
>  		pci_read_config_byte(pdev, 0x60, &ehci->sbrn);
>  
> 
Sorry, please ignore this patch, I will resend it.
Thanks.
Longfang.
