Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D641D39B034
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 04:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFDCL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 22:11:28 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4299 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhFDCL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 22:11:27 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fx5gW1Bstz1BH0P;
        Fri,  4 Jun 2021 10:04:55 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 10:09:40 +0800
Received: from [10.174.178.95] (10.174.178.95) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 10:09:39 +0800
Subject: Re: [PATCH -next] usb: isp1760: Fix meaningless check in
 isp1763_run()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <rui.silva@linaro.org>
References: <20210601100311.70200-1-tongtiangen@huawei.com>
 <YLjAweuyJXzDn9pe@kroah.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   tongtiangen <tongtiangen@huawei.com>
Message-ID: <bb426fd3-ec56-ec95-0c6a-092627d547b6@huawei.com>
Date:   Fri, 4 Jun 2021 10:09:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YLjAweuyJXzDn9pe@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.95]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/3 19:45, Greg Kroah-Hartman wrote:
> On Tue, Jun 01, 2021 at 06:03:11PM +0800, Tong Tiangen wrote:
>> There's a meaningless check in isp1763_run. According to the
>> similar implement in isp1760_run, the proper check should remove
>> retval = 0;
>>
>> Fixes: 60d789f3bfbb ("usb: isp1760: add support for isp1763")
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> ---
>>   drivers/usb/isp1760/isp1760-hcd.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
>> index 016a54ea76f4..27168b4a4ef2 100644
>> --- a/drivers/usb/isp1760/isp1760-hcd.c
>> +++ b/drivers/usb/isp1760/isp1760-hcd.c
>> @@ -1648,7 +1648,6 @@ static int isp1763_run(struct usb_hcd *hcd)
>>   	down_write(&ehci_cf_port_reset_rwsem);
>>   	retval = isp1760_hcd_set_and_wait(hcd, FLAG_CF, 250 * 1000);
>>   	up_write(&ehci_cf_port_reset_rwsem);
>> -	retval = 0;
>>   	if (retval)
>>   		return retval;
>>   
>> -- 
>> 2.18.0.huawei.25
>>
> Did you test this change to verify that the driver still works properly?
> You are now checking something that never was checked before...
>
> thanks,
>
> greg k-h
> .
Sorry,  this fix was not send to Rui.
 From the point of view of code logic, there should be a problem here. I 
don't have the actual hardware to verify whether it works properly. Rui 
may know if the patch affects the original workflow.

thanks
.
>

