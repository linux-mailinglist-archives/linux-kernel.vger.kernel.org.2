Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E7E3617AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 04:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbhDPCoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 22:44:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17363 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbhDPCoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 22:44:07 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FM0ph74jJzlWp0;
        Fri, 16 Apr 2021 10:41:48 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 16 Apr 2021 10:43:34 +0800
Subject: Re: [RFC PATCH] USB:XHCI:skip hub registration
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <mathias.nyman@intel.com>, <stern@rowland.harvard.edu>,
        <liudongdong3@huawei.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kong.kongxinwei@hisilicon.com>,
        <yisen.zhuang@huawei.com>
References: <1618489358-42283-1-git-send-email-liulongfang@huawei.com>
 <YHgy0jqLE0WAxA+2@kroah.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <973a4759-4464-e59e-f84b-15672503e290@huawei.com>
Date:   Fri, 16 Apr 2021 10:43:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YHgy0jqLE0WAxA+2@kroah.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/15 20:34, Greg KH wrote:
> On Thu, Apr 15, 2021 at 08:22:38PM +0800, Longfang Liu wrote:
>> When the number of ports on the USB hub is 0, skip the registration
>> operation of the USB hub.
> 
> That's crazy.  Why not fix the hardware?  How has this hub passed the
> USB certification process?
> 
>> The current Kunpeng930's XHCI hardware controller is defective. The number
>> of ports on its USB3.0 bus controller is 0, and the number of ports on
>> the USB2.0 bus controller is 1.
>>
>> In order to solve this problem that the USB3.0 controller does not have
>> a port which causes the registration of the hub to fail, this patch passes
>> the defect information by adding flags in the quirks of xhci and usb_hcd,
>> and finally skips the registration process of the hub directly according
>> to the results of these flags when the hub is initialized.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  drivers/usb/core/hub.c      | 6 ++++++
>>  drivers/usb/host/xhci-pci.c | 4 ++++
>>  drivers/usb/host/xhci.c     | 5 +++++
>>  drivers/usb/host/xhci.h     | 1 +
>>  include/linux/usb/hcd.h     | 1 +
>>  5 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index b1e14be..2d6869d 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -1769,9 +1769,15 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
>>  	struct usb_host_interface *desc;
>>  	struct usb_device *hdev;
>>  	struct usb_hub *hub;
>> +	struct usb_hcd *hcd;
>>  
>>  	desc = intf->cur_altsetting;
>>  	hdev = interface_to_usbdev(intf);
>> +	hcd = bus_to_hcd(hdev->bus);
>> +	if (hcd->usb3_no_port) {
>> +		dev_warn(&intf->dev, "USB hub has no port\n");
>> +		return -ENODEV;
>> +	}
>>  
>>  	/*
>>  	 * Set default autosuspend delay as 0 to speedup bus suspend,
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index ef513c2..63b89a4 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -281,6 +281,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>>  	if (xhci->quirks & XHCI_RESET_ON_RESUME)
>>  		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
>>  				"QUIRK: Resetting on resume");
>> +
>> +	if (pdev->vendor == PCI_VENDOR_ID_HUAWEI &&
>> +	    pdev->device == 0xa23c)
>> +		xhci->quirks |= XHCI_USB3_NOPORT;
> 
> Can't we just detect this normally that there are no ports for this
> device?  Why is the device lying about how many ports it has such that
> we have to "override" this?
> 

The hub driver will check the port number in prob(). If there is no port,
the driver will report an error log. But we hope this defective device
does not print error log.

> And again, why not fix this broken hardware?
> 
> thanks,
> 
> greg k-h
> .
> The current generation of hardware can no longer be modified,
this problem will be solved in the next generation of hardware.
Thanks,
Longfang.
