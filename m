Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FF7351197
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhDAJMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:12:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15568 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbhDAJL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:11:57 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9y7L4Ktzz17PWQ;
        Thu,  1 Apr 2021 17:09:50 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 17:11:54 +0800
Subject: Re: [PATCH -next v2] staging: greybus: camera: Switch to
 memdup_user_nul()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>
References: <20210401031752.2861248-1-yangyingliang@huawei.com>
 <20210401074332.GO2065@kadam>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <92731704-8d18-77c5-7d8c-0a38f32321e4@huawei.com>
Date:   Thu, 1 Apr 2021 17:11:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210401074332.GO2065@kadam>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/4/1 15:43, Dan Carpenter wrote:
> On Thu, Apr 01, 2021 at 11:17:52AM +0800, Yang Yingliang wrote:
>> Use memdup_user_nul() helper instead of open-coding to
>> simplify the code.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/staging/greybus/camera.c | 13 +++----------
>>   1 file changed, 3 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
>> index b570e13394ac..2ecdc1bc5092 100644
>> --- a/drivers/staging/greybus/camera.c
>> +++ b/drivers/staging/greybus/camera.c
>> @@ -1120,16 +1120,9 @@ static ssize_t gb_camera_debugfs_write(struct file *file,
>>   	if (len > 1024)
>>   		return -EINVAL;
>>   
>> -	kbuf = kmalloc(len + 1, GFP_KERNEL);
>> -	if (!kbuf)
>> -		return -ENOMEM;
>> -
>> -	if (copy_from_user(kbuf, buf, len)) {
>> -		ret = -EFAULT;
>> -		goto done;
>> -	}
>> -
>> -	kbuf[len] = '\0';
>> +	kbuf = memdup_user_nul(buf, len);
>> +	if (IS_ERR(kbuf))
>> +		return PTR_ERR(kbuf);;
>                                      ^^
> There is an extra semi-colon here.  Checkpatch actually catches this
> sort of typo.

I will remove it, and send a v3 later.

Thanks,

Yang

>
> regards,
> dan carpenter
>
> .
