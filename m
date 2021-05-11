Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE1037A0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhEKHYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:24:17 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2358 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhEKHYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:24:16 -0400
Received: from dggemx753-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FfTnt0NQFz60Yw;
        Tue, 11 May 2021 15:19:46 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 11 May 2021 15:23:06 +0800
Subject: Re: [PATCH] f2fs: set file as cold when file defragmentation
To:     <daejun7.park@samsung.com>, Jaegeuk Kim <jaegeuk@kernel.org>
CC:     "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
References: <fc7f1b2b-60ea-eb12-3195-7b3ad0b3adc2@huawei.com>
 <20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
 <3a0ab201-9546-d523-abc7-79df5f637f14@huawei.com>
 <YJN0nTgadoq8vDaG@google.com>
 <bd0fa15b-01c3-9f70-3eb8-ec2b54a0ee8f@huawei.com>
 <YJlHmP/ej8/IsHL3@google.com>
 <6e95edca-4802-7650-4771-5389067935dc@huawei.com>
 <YJoRcIpW1g/OgHZn@google.com>
 <CGME20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p1>
 <20210511064156epcms2p1351480bea36733f2e00022bd295e829e@epcms2p1>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <771a05fe-e26f-d635-5f8d-5be72f82345f@huawei.com>
Date:   Tue, 11 May 2021 15:23:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210511064156epcms2p1351480bea36733f2e00022bd295e829e@epcms2p1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggemx704-chm.china.huawei.com (10.1.199.51) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/11 14:41, Daejun Park wrote:
>> On 2021/5/11 13:09, Jaegeuk Kim wrote:
>>> On 05/11, Chao Yu wrote:
>>>> On 2021/5/10 22:47, Jaegeuk Kim wrote:
>>>>> On 05/06, Chao Yu wrote:
>>>>>> On 2021/5/6 12:46, Jaegeuk Kim wrote:
>>>>>>> On 05/06, Chao Yu wrote:
>>>>>>>> On 2021/4/29 14:20, Daejun Park wrote:
>>>>>>>>> In file defragmentation by ioctl, all data blocks in the file are
>>>>>>>>> re-written out-of-place. File defragmentation implies user will not update
>>>>>>>>> and mostly read the file. So before the defragmentation, we set file
>>>>>>>>> temperature as cold for better block allocation.
>>>>>>>>
>>>>>>>> I don't think all fragmented files are cold, e.g. db file.
>>>>>>>
>>>>>>> I have a bit different opinion. I think one example would be users want to
>>>>>>> defragment a file, when the they want to get higher read bandwidth for
>>>>>>
>>>>>> Multimedia file was already defined as cold file now via default extension
>>>>>> list?
>>>>>
>>>>> I just gave an example. And default is default.
>>>>>
>>>>>>
>>>>>>> usually multimedia files. That's likely to be cold files. Moreover, I don't
>>>>>>> think they want to defragment db files which will be fragmented soon?
>>>>>>
>>>>>> I guess like db files have less update but more access?
>>>>>
>>>>> I think both, and we set it as hot.
>>>>
>>>> Then hot and cold bit will set to the same db file after defragmentation?
>>>
>>> Do you set cold bit to db files? I mean, generally db is not cold, but hot.
>>
>> I never set cold bit to db files, I mean if we defragment db file which
>> has less update and more access, db file may have bot hot and cold bit.
>>
>> To Daejun, may I ask that is Samsung planning to use this defragment ioctl
>> in products? what's the user scenario?
> 
> It is just my idea for defragmentation, not Samsung.

Alright,

> I think the user will call the defrag ioctl for the files that have been updated.

Sadly, I don't see there is any user of this defragment interface since it was
been introduced... so I really don't know the real use scenario of this interface
now.

> 
> On the other hand, I think FS should be able to support defrag file even
> when in-place update is applied. What do you think?

bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
{
	if (f2fs_is_pinned_file(inode))
		return true;

	/* if this is cold file, we should overwrite to avoid fragmentation */
	if (file_is_cold(inode))
		return true;

If cold bit was set, later rewrite in defragment interface can only trigger
IPU due to above IPU policy check, so after this interface, file is still
fragmented... what's the difference compared to just setting cold bit via
setxattr?

And if user know that he will trigger less update and more read in the file,
why not just calling setxattr("system.advise", cold_bit) to set the file as
cold before it becomes fragmented, e.g. at the time of file creation?

Thanks,

> 
> Thanks,
> Daejun
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> We have separated interface (via f2fs_xattr_advise_handler, e.g. setfattr -n
>>>>>>>> "system.advise" -v value) to indicate this file is a hot/cold file, so my
>>>>>>>> suggestion is after file defragmentation, if you think this file is cold, and
>>>>>>>> use setxattr() to set it as cold.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
>>>>>>>>> ---
>>>>>>>>>       fs/f2fs/file.c | 3 +++
>>>>>>>>>       1 file changed, 3 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>>>>> index d697c8900fa7..dcac965a05fe 100644
>>>>>>>>> --- a/fs/f2fs/file.c
>>>>>>>>> +++ b/fs/f2fs/file.c
>>>>>>>>> @@ -2669,6 +2669,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>>>>>>>>>               map.m_len = pg_end - pg_start;
>>>>>>>>>               total = 0;
>>>>>>>>> +        if (!file_is_cold(inode))
>>>>>>>>> +                file_set_cold(inode);
>>>>>>>>> +
>>>>>>>>>               while (map.m_lblk < pg_end) {
>>>>>>>>>                       pgoff_t idx;
>>>>>>>>>                       int cnt = 0;
>>>>>>>>>
>>>>>>> .
>>>>>>>
>>>>> .
>>>>>
>>> .
>>>
>>
>>
>>   
> .
> 
