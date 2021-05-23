Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8CC38D94B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 08:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhEWGfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 02:35:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3657 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhEWGfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 02:35:06 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fnr8R04hvzmWf6;
        Sun, 23 May 2021 14:31:19 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 23 May 2021 14:33:37 +0800
Received: from [10.174.179.215] (10.174.179.215) by
 dggema769-chm.china.huawei.com (10.1.198.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sun, 23 May 2021 14:33:37 +0800
Subject: Re: [PATCH -next] USB: gadget: f_fs: Use ERR_CAST instead of
 ERR_PTR(PTR_ERR(...))
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210519023032.19812-1-yuehaibing@huawei.com>
 <YKeeHDy/VAhuoG6B@kroah.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <91b40f9e-9de2-0d16-7eb1-50e5a91fb077@huawei.com>
Date:   Sun, 23 May 2021 14:33:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YKeeHDy/VAhuoG6B@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/21 19:48, Greg KH wrote:
> On Wed, May 19, 2021 at 10:30:32AM +0800, YueHaibing wrote:
>> A coccicheck run provided information like the following.
>>
>> ./drivers/usb/gadget/function/f_fs.c:3832:9-16:
>>  WARNING: ERR_CAST can be used with data
>>
>> Use ERR_CAST to fix this.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/usb/gadget/function/f_fs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
>> index bf109191659a..61110ff52f49 100644
>> --- a/drivers/usb/gadget/function/f_fs.c
>> +++ b/drivers/usb/gadget/function/f_fs.c
>> @@ -3829,7 +3829,7 @@ static char *ffs_prepare_buffer(const char __user *buf, size_t len)
>>  
>>  	data = memdup_user(buf, len);
>>  	if (IS_ERR(data))
>> -		return ERR_PTR(PTR_ERR(data));
>> +		return ERR_CAST(data);
> 
> This should just be:
> 		return PTR_ERR(data);
> right?

ffs_prepare_buffer() should return an ERR_PTR() encoded error code on failure,

maybe there just do:

		return data;

> 
> No need for 2 casts to happen here.
> 
> thanks,
> 
> greg k-h
> .
> 
