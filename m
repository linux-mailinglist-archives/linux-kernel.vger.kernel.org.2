Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B162B349327
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhCYNek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:34:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14876 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhCYNeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:34:11 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F5mH66m12z9t1D;
        Thu, 25 Mar 2021 21:32:02 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 21:33:53 +0800
Subject: Re: [RFC PATCH] USB:XHCI:Adjust the log level of hub
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <mathias.nyman@intel.com>, <stern@rowland.harvard.edu>,
        <linux-usb@vger.kernel.org>, <yisen.zhuang@huawei.com>,
        <tanxiaofei@huawei.com>, <liudongdong3@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <1616666652-37920-1-git-send-email-liulongfang@huawei.com>
 <YFxmaEtKclXXpBfy@kroah.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <d2fc6d09-c8e7-436f-3e0d-b2cfa9c75b9f@huawei.com>
Date:   Thu, 25 Mar 2021 21:33:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YFxmaEtKclXXpBfy@kroah.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/25 18:31, Greg KH wrote:
> On Thu, Mar 25, 2021 at 06:04:12PM +0800, Longfang Liu wrote:
>> When the number of ports of the hub is not between 1 and Maxports,
>> it will only exit the registration of the hub on the current controller,
>> but it will not affect the function of the controller itself. Its other
>> hubs can operate normally, so the log level here can be changed from
>> error to information.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  drivers/usb/core/hub.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index b1e14be..70294ad 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -1409,13 +1409,11 @@ static int hub_configure(struct usb_hub *hub,
>>  		maxchild = min_t(unsigned, maxchild, USB_SS_MAXPORTS);
>>  
>>  	if (hub->descriptor->bNbrPorts > maxchild) {
>> -		message = "hub has too many ports!";
>> -		ret = -ENODEV;
>> -		goto fail;
>> +		dev_info(hub_dev, "hub has too many ports!\n");
> 
> Is this an error?  If so, report it as such, not as "information".
> 
>> +		return -ENODEV;
>>  	} else if (hub->descriptor->bNbrPorts == 0) {
>> -		message = "hub doesn't have any ports!";
>> -		ret = -ENODEV;
>> -		goto fail;
>> +		dev_info(hub_dev, "hub doesn't have any ports!\n");
> 
> Same here.
> 
> What problem are you trying to solve here?
> 
> What hub do you have that has no ports, or too many, that you think
> should still be able to work properly?
> 
> thanks,
> 
> greg k-h
> .
>On our test platform, the xhci usb3 hub has no port.
when initializing the usb3 hub, an error will be reported
because the port is 0, but in fact it will not affect
the use of usb2, and the usb2 hub is working normally.
thanks, therefore, in order to reduce the severity of the log,
we hope to lower the level of this log.
Longfang
thanks.
