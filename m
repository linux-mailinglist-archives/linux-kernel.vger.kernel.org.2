Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1416135B7F6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 03:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbhDLBPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 21:15:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15661 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbhDLBPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 21:15:17 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FJW135L2yzpXH7;
        Mon, 12 Apr 2021 09:12:07 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 09:14:52 +0800
Subject: Re: [PATCH v2] USB:ohci:fix ohci interruption problem
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <liudongdong3@huawei.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kong.kongxinwei@hisilicon.com>,
        <yisen.zhuang@huawei.com>
References: <1617954422-36617-1-git-send-email-liulongfang@huawei.com>
 <20210409150744.GB1333284@rowland.harvard.edu>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <ced54f8a-bc17-c3a6-80b8-1664647527e7@huawei.com>
Date:   Mon, 12 Apr 2021 09:14:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210409150744.GB1333284@rowland.harvard.edu>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/9 23:07, Alan Stern wrote:
> On Fri, Apr 09, 2021 at 03:47:02PM +0800, Longfang Liu wrote:
>> The operating method of the system entering S4 sleep mode:
>> echo reboot > /sys/power/disk
>> echo disk > /sys/power/state
>>
>> When OHCI enters the S4 sleep state, check the log and find that
>> the USB sleep process will call check_root_hub_suspend() and
>> ohci_bus_suspend() instead ohci_suspend() and ohci_bus_suspend(),
>> which will cause the OHCI interrupt to not be closed.
>>
>> At this time, if just one device interrupt is reported. the
>> driver will not process and close this device interrupt. It will cause
>> the entire system to be stuck during sleep, causing the device to
>> fail to respond.
>>
>> When the abnormal interruption reaches 100,000 times, the system will
>> forcibly close the interruption and make the device unusable.
>>
>> Because the root cause of the problem is that ohci_suspend is not
>> called to perform normal interrupt shutdown operations when the system
>> enters S4 sleep mode.
>>
>> Therefore, our solution is to specify freeze interface in this mode to
>> perform normal suspend_common() operations, and call ohci_suspend()
>> after check_root_hub_suspend() is executed through the suspend_common()
>> operation.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>
>> Changes in V2:
>> 	- Modify comment and patch version information.
> 
> Please, instead of sending the same incorrect patch over and over again, 
> spend some time figuring out what is really going wrong.  I have already 
> explained why this patch is not the right thing to do.
> 
> You have to determine why the poweroff callback in hcd-pci.c (which 
> points to hcd_pci_suspend) isn't getting called.  That's the real 
> explanation for your problem.
> 
> Alan Stern
> 

Ok! I need to analyze the PCI device sleep and wake process to see
why it will not be called.
Thanks,
Longfang.
>> Changes in V1:
>> 	- Call suspend_common by adding the hcd_pci_freeze function turn off
>> 	the interrupt instead of adding a shutdown operation in ohci_bus_suspend
>> 	to turn off the interrupt.
>>
>>  drivers/usb/core/hcd-pci.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
>> index 1547aa6..c5844a3 100644
>> --- a/drivers/usb/core/hcd-pci.c
>> +++ b/drivers/usb/core/hcd-pci.c
>> @@ -509,6 +509,11 @@ static int resume_common(struct device *dev, int event)
>>  
>>  #ifdef	CONFIG_PM_SLEEP
>>  
>> +static int hcd_pci_freeze(struct device *dev)
>> +{
>> +	return suspend_common(dev, device_may_wakeup(dev));
>> +}
>> +
>>  static int hcd_pci_suspend(struct device *dev)
>>  {
>>  	return suspend_common(dev, device_may_wakeup(dev));
>> @@ -605,7 +610,7 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
>>  	.suspend_noirq	= hcd_pci_suspend_noirq,
>>  	.resume_noirq	= hcd_pci_resume_noirq,
>>  	.resume		= hcd_pci_resume,
>> -	.freeze		= check_root_hub_suspended,
>> +	.freeze		= hcd_pci_freeze,
>>  	.freeze_noirq	= check_root_hub_suspended,
>>  	.thaw_noirq	= NULL,
>>  	.thaw		= NULL,
>> -- 
>> 2.8.1
>>
> .
> 
