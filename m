Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD467326B63
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 04:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhB0DfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 22:35:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12586 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhB0DfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 22:35:19 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DnXCK5jCNzMZHB;
        Sat, 27 Feb 2021 11:32:29 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Feb 2021 11:34:24 +0800
Subject: Re: [RFC PATCH] USB:XHCI:Modify XHCI driver for USB2.0 controller
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <yisen.zhuang@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <1614327697-1021-1-git-send-email-liulongfang@huawei.com>
 <127e3e5c-f485-64dd-235c-1971d6cd9a4a@linux.intel.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <82be4215-8037-6aab-1d25-92bcca410af4@huawei.com>
Date:   Sat, 27 Feb 2021 11:34:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <127e3e5c-f485-64dd-235c-1971d6cd9a4a@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/26 17:22, Mathias Nyman wrote:
> On 26.2.2021 10.21, Longfang Liu wrote:
>> Our current XHCI hardware controller has been customized to only
>> support USB 2.0 ports. When using the current xhci driver, an xhci
>> controller device and an ehci controller device will be created
>> automatically. We want the driver to create only one ehci controller.
>> After modifying the driver as follows, an error will occur.
>> Is there any other modification method?
> 
> The xhci driver relies on the existence of both a main and a shared hcd.
> One hcd for handing USB 2 (and slower) and the other for USB 3 devices.
> 
> As one example xhci_run(hcd) needs to be called for both hcds, first call
> sets up things, second one calls xhci_start() that makes the controller run.
> 
> It's probably possible to modify the driver to support xHCI hosts with only
> USB 2 ports, but requires a lot more work.
> 
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  drivers/usb/host/xhci-pci.c | 15 ++-------------
>>  1 file changed, 2 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index ef513c2..7296aad 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -364,26 +364,15 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>  	/* USB 2.0 roothub is stored in the PCI device now. */
>>  	hcd = dev_get_drvdata(&dev->dev);
>>  	xhci = hcd_to_xhci(hcd);
>> -	xhci->shared_hcd = usb_create_shared_hcd(&xhci_pci_hc_driver, &dev->dev,
>> -						 pci_name(dev), hcd);
>> -	if (!xhci->shared_hcd) {
>> -		retval = -ENOMEM;
>> -		goto dealloc_usb2_hcd;
>> -	}
>> -
>> +	xhci->shared_hcd = NULL;
>>  	retval = xhci_ext_cap_init(xhci);
>>  	if (retval)
>>  		goto put_usb3_hcd;
>>  
>> -	retval = usb_add_hcd(xhci->shared_hcd, dev->irq,
>> +	retval = usb_add_hcd(xhci->main_hcd, dev->irq,
>>  			IRQF_SHARED);
>>  	if (retval)
>>  		goto put_usb3_hcd;
>> -	/* Roothub already marked as USB 3.0 speed */
>> -
>> -	if (!(xhci->quirks & XHCI_BROKEN_STREAMS) &&
>> -			HCC_MAX_PSA(xhci->hcc_params) >= 4)
>> -		xhci->shared_hcd->can_do_streams = 1;
>>  
>>  	/* USB-2 and USB-3 roothubs initialized, allow runtime pm suspend */
>>  	pm_runtime_put_noidle(&dev->dev);
>>
> 
> Something like the above could of course not be accepted upstream. We can't break existing
> functionality to support one modified xHCI.
> 
> Thanks
> Mathias
> .
> 
Thanks very much.
Longfang Liu

