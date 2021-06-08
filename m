Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D3639EB8F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 03:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFHBlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 21:41:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3459 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFHBlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:41:50 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FzXsL5qBLz6wx0;
        Tue,  8 Jun 2021 09:36:54 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 09:39:53 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 09:39:52 +0800
From:   "yekai(A)" <yekai13@huawei.com>
Subject: Re: [PATCH] uacce: add print information if not enable sva
To:     Greg KH <gregkh@linuxfoundation.org>
References: <1622792769-28017-1-git-send-email-yekai13@huawei.com>
 <YLnbgcJmQZChx1WV@kroah.com>
CC:     <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>
Message-ID: <3f1590c4-b9f1-18f5-370a-57d9707f38a0@huawei.com>
Date:   Tue, 8 Jun 2021 09:39:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YLnbgcJmQZChx1WV@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/4 15:51, Greg KH wrote:
> On Fri, Jun 04, 2021 at 03:46:09PM +0800, Kai Ye wrote:
>> Add print information necessary if user not enable sva.
>>
>> Signed-off-by: Kai Ye <yekai13@huawei.com>
>> ---
>>  drivers/misc/uacce/uacce.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
>> index bae18ef0..fe38af8 100644
>> --- a/drivers/misc/uacce/uacce.c
>> +++ b/drivers/misc/uacce/uacce.c
>> @@ -387,15 +387,22 @@ static void uacce_release(struct device *dev)
>>
>>  static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
>>  {
>> +	int ret;
>> +
>>  	if (!(flags & UACCE_DEV_SVA))
>>  		return flags;
>>
>>  	flags &= ~UACCE_DEV_SVA;
>>
>> -	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF))
>> +	ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF);
>> +	if (ret) {
>> +		dev_err(parent, "failed to enable IOPF feature! ret = %d\n", ret);
>
> Why is this needed?  Has this ever happened in real life such that the
> log message is now required?
>
>
>
>>  		return flags;
>> +	}
>>
>> -	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)) {
>> +	ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
>> +	if (ret) {
>> +		dev_err(parent, "failed to enable SVA feature! ret = %d\n", ret);
>
> Same here, does this happen in real systems?
>
> thanks,
>
> greg k-h
> .
>
In a other debug version, the SVA feature failed to be enabled, and no 
related information was printed. we don't know the cause of the problem. 
Finally, Although, it's not the problem here. but we find that the sva 
enable function doesn't have debug information. Therefore, it is 
inconvenient to locate the fault.
so i think the log message is required.

thanks

Kai
