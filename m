Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D8D32A09E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576198AbhCBE0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:26:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13016 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbhCBAwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:52:20 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DqJS20nb5zjV6q;
        Tue,  2 Mar 2021 08:49:38 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Tue, 2 Mar 2021
 08:51:09 +0800
Subject: Re: [PATCH] w1: ds2708 and ds2781 use the new API kobj_to_dev()
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tian Tao <tiantao6@hisilicon.com>
CC:     <zbr@ioremap.net>, <rikard.falkeborn@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <1614603535-24046-1-git-send-email-tiantao6@hisilicon.com>
 <YDzne3KtnGJD1J0E@kroah.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <9be69246-fb8b-27dc-c459-0f9aa25c5c88@huawei.com>
Date:   Tue, 2 Mar 2021 08:51:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YDzne3KtnGJD1J0E@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

在 2021/3/1 21:09, Greg KH 写道:
> On Mon, Mar 01, 2021 at 08:58:55PM +0800, Tian Tao wrote:
>> fix the below warnning:
>> /drivers/w1/slaves/w1_ds2780.c:93:60-61: WARNING opportunity for
>> kobj_to_dev()
> What creates that warning?
This is reported by coccicheck.
>
>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>> ---
>>   drivers/w1/slaves/w1_ds2780.c | 3 ++-
>>   drivers/w1/slaves/w1_ds2781.c | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/w1/slaves/w1_ds2780.c b/drivers/w1/slaves/w1_ds2780.c
>> index c281fe5..3cde1bb 100644
>> --- a/drivers/w1/slaves/w1_ds2780.c
>> +++ b/drivers/w1/slaves/w1_ds2780.c
>> @@ -90,7 +90,8 @@ static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
>>   			     struct bin_attribute *bin_attr, char *buf,
>>   			     loff_t off, size_t count)
>>   {
>> -	struct device *dev = container_of(kobj, struct device, kobj);
>> +	struct device *dev = kobj_to_dev(kobj);
>> +
> Why the extra line here, but not in the other chunk?

This is reported by checkpatch.

tiantao@ubuntu:~/mailline/linux-next$ ./scripts/checkpatch.pl 
drivers/w1/slaves/w1_ds2780.c

WARNING: Missing a blank line after declarations
#94: FILE: drivers/w1/slaves/w1_ds2780.c:94:
+       struct device *dev = kobj_to_dev(kobj);
+       return w1_ds2780_io(dev, buf, off, count, 0);

>
> Consistancy is key :)
>
> Please fix up.
>
> thanks,
>
> greg k-h
> .
>

