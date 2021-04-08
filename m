Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC735841A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhDHNE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:04:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16412 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHNEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:04:54 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGLz11g8yzkjgH;
        Thu,  8 Apr 2021 21:02:53 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 21:04:18 +0800
Subject: Re: [PATCH 1/2] USB:ehci:Add a whitelist for EHCI controllers
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <mathias.nyman@intel.com>, <stern@rowland.harvard.edu>,
        <liudongdong3@huawei.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kong.kongxinwei@hisilicon.com>,
        <yisen.zhuang@huawei.com>
References: <1617873073-37371-1-git-send-email-liulongfang@huawei.com>
 <1617873073-37371-2-git-send-email-liulongfang@huawei.com>
 <YG7LO2DJMThbeJ5W@kroah.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <13446834-afc5-e713-d232-36c771059712@huawei.com>
Date:   Thu, 8 Apr 2021 21:04:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YG7LO2DJMThbeJ5W@kroah.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/8 17:22, Greg KH Wrote:
> On Thu, Apr 08, 2021 at 05:11:12PM +0800, Longfang Liu wrote:
>> Some types of EHCI controllers do not have SBRN registers.
>> By comparing the white list, the operation of reading the SBRN
>> registers is skipped.
>>
>> Subsequent EHCI controller types without SBRN registers can be
>> directly added to the white list.
>>
>> The current patch does not affect the drive function.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  drivers/usb/host/ehci-pci.c | 27 +++++++++++++++++++++++----
>>  1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
>> index 3c3820a..6a30afa 100644
>> --- a/drivers/usb/host/ehci-pci.c
>> +++ b/drivers/usb/host/ehci-pci.c
>> @@ -47,6 +47,28 @@ static inline bool is_bypassed_id(struct pci_dev *pdev)
>>  	return !!pci_match_id(bypass_pci_id_table, pdev);
>>  }
>>  
>> +static const struct usb_nosbrn_whitelist_entry {
>> +	unsigned short vendor;
>> +	unsigned short device;
> 
> u16 here please.
> 
>> +} usb_nosbrn_whitelist[] = {
>> +	/* STMICRO ConneXT has no sbrn register */
>> +	{PCI_VENDOR_ID_STMICRO, PCI_DEVICE_ID_STMICRO_USB_HOST},
>> +	{}
> 
> trailing , please.
> 

Is it necessary to add "," at the end here?

>> +};
>> +
>> +static bool usb_nosbrn_whitelist_check(struct pci_dev *pdev)
>> +{
>> +	const struct usb_nosbrn_whitelist_entry *entry;
>> +
>> +	for (entry = usb_nosbrn_whitelist; entry->vendor; entry++) {
>> +		if (pdev->vendor == entry->vendor &&
>> +		    pdev->device == entry->device)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>  /*
>>   * 0x84 is the offset of in/out threshold register,
>>   * and it is the same offset as the register of 'hostpc'.
>> @@ -288,10 +310,7 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
>>  	}
>>  
>>  	/* Serial Bus Release Number is at PCI 0x60 offset */
>> -	if (pdev->vendor == PCI_VENDOR_ID_STMICRO
>> -	    && pdev->device == PCI_DEVICE_ID_STMICRO_USB_HOST)
>> -		;	/* ConneXT has no sbrn register */
>> -	else
>> +	if (!usb_nosbrn_whitelist_check(pdev))
> 
> Doing this as a "negative" is hard to understand.  Should this just be:
> 	forbid_sbrn_read()
> or something like that?
> 
> The term "whitelist" is not a good thing to use as it does not really
> explain anything here.
> 
> thanks,
> 
> greg k-h
> .
> 
Thanks
Longfang.
