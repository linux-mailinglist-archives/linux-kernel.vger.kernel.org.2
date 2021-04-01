Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC83350CC1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 04:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbhDACln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 22:41:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15421 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhDAClN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:41:13 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F9nSw3l7pzjX2b;
        Thu,  1 Apr 2021 10:39:28 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 10:41:07 +0800
Subject: Re: [PATCH -next] staging: greybus: camera: Switch to
 memdup_user_nul()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>
References: <20210331095201.2173793-1-yangyingliang@huawei.com>
 <20210331102414.GL2065@kadam>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <74cc6ea7-7b03-dea1-ba02-0ad41df29ced@huawei.com>
Date:   Thu, 1 Apr 2021 10:41:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210331102414.GL2065@kadam>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/3/31 18:24, Dan Carpenter wrote:
> On Wed, Mar 31, 2021 at 05:52:01PM +0800, Yang Yingliang wrote:
>> Use memdup_user_nul() helper instead of open-coding to
>> simplify the code.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/staging/greybus/camera.c | 10 ++--------
>>   1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
>> index b570e13394ac..0f005facffbc 100644
>> --- a/drivers/staging/greybus/camera.c
>> +++ b/drivers/staging/greybus/camera.c
>> @@ -1120,16 +1120,10 @@ static ssize_t gb_camera_debugfs_write(struct file *file,
>>   	if (len > 1024)
>>   		return -EINVAL;
>>   
>> -	kbuf = kmalloc(len + 1, GFP_KERNEL);
>> -	if (!kbuf)
>> +	kbuf = memdup_user_nul(buf, len);
>> +	if (IS_ERR(kbuf))
>>   		return -ENOMEM;
> return PTR_ERR(kbuf);
>
>>   
>> -	if (copy_from_user(kbuf, buf, len)) {
>> -		ret = -EFAULT;
>> -		goto done;
>> -	}
>> -
>> -	kbuf[len] = '\0';
>>   
>     ^^^^^^^^
> Please delete this blank line so there aren't two blank lines in a row.

I will change it and send a v2.

Thanks,

Yang

>
>>   	ret = op->execute(gcam, kbuf, len);
> regards,
> dan carpenter
>
> .
