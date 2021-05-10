Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45D0377EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhEJJGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:06:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2607 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhEJJGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:06:20 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fdw656rm2zQldM;
        Mon, 10 May 2021 17:01:49 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 10 May
 2021 17:05:08 +0800
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: compress: add compress_inode to cache
 compressed blockst
From:   Chao Yu <yuchao0@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210202080056.51658-1-yuchao0@huawei.com>
 <46e9924c-0086-cd2a-2e93-7149b92ba27e@huawei.com>
 <YDsleDjeIcpuBXKA@google.com> <YEFBAuP26t0RzVHZ@google.com>
 <01a0ff76-6fa7-3196-8760-e7f6f163ef64@huawei.com>
 <YEa66ekikyuPWSyd@google.com>
 <a40929d4-a8de-98ea-8dd8-6c807d8a6adc@huawei.com>
 <YEkxpAp8FQjRUfm6@google.com>
 <157988c7-079f-0c9f-5cf9-e83bc2f835d1@huawei.com>
 <YID0sDPrUxOJLz+A@google.com>
 <6d574f4e-fed2-ded8-c9d5-4d88bff5d584@huawei.com>
Message-ID: <3f7ebf46-536e-dc80-ebda-71b2034cb4c9@huawei.com>
Date:   Mon, 10 May 2021 17:05:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6d574f4e-fed2-ded8-c9d5-4d88bff5d584@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/22 14:07, Chao Yu wrote:
> On 2021/4/22 11:59, Jaegeuk Kim wrote:
>> On 04/21, Chao Yu wrote:
>>> On 2021/3/11 4:52, Jaegeuk Kim wrote:
>>>> On 03/09, Chao Yu wrote:
>>>>> On 2021/3/9 8:01, Jaegeuk Kim wrote:
>>>>>> On 03/05, Chao Yu wrote:
>>>>>>> On 2021/3/5 4:20, Jaegeuk Kim wrote:
>>>>>>>> On 02/27, Jaegeuk Kim wrote:
>>>>>>>>> On 02/04, Chao Yu wrote:
>>>>>>>>>> Jaegeuk,
>>>>>>>>>>
>>>>>>>>>> On 2021/2/2 16:00, Chao Yu wrote:
>>>>>>>>>>> -	for (i = 0; i < dic->nr_cpages; i++) {
>>>>>>>>>>> +	for (i = 0; i < cc->nr_cpages; i++) {
>>>>>>>>>>>        		struct page *page = dic->cpages[i];
>>>>>>>>>>
>>>>>>>>>> por_fsstress still hang in this line?
>>>>>>>>>
>>>>>>>>> I'm stuck on testing the patches, since the latest kernel is panicking somehow.
>>>>>>>>> Let me update later, once I can test a bit. :(
>>>>>>>>
>>>>>>>> It seems this works without error.
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=4e6e1364dccba80ed44925870b97fbcf989b96c9
>>>>>>>
>>>>>>> Ah, good news.
>>>>>>>
>>>>>>> Thanks for helping to test the patch. :)
>>>>>>
>>>>>> Hmm, I hit this again. Let me check w/o compress_cache back. :(
>>>>>
>>>>> Oops :(
>>>>
>>>> Ok, apprantely that panic is caused by compress_cache. The test is running over
>>>> 24hours w/o it.
>>>
>>> Jaegeuk,
>>>
>>> I'm still struggling troubleshooting this issue.
>>>
>>> However, I failed again to reproduce this bug, I doubt the reason may be
>>> my test script and environment(device type/size) is different from yours.
>>> (btw, I used pmem as back-end device, and test w/ all fault injection
>>> points and w/o write_io/checkpoint fault injection points)
>>>
>>> Could you please share me your run.sh script? and test command?
>>>
>>> And I'd like to ask what's your device type and size?
>>
>> I'm using qemu with 16GB with this script.
>> https://github.com/jaegeuk/xfstests-f2fs/blob/f2fs/run.sh
>>
>> ./run.sh por_fsstress
> 
> Thanks, let me check the difference, and try again.

Finally, I can reproduce this bug, and after troubleshooting this
issue, I guess the root cause is not related to this patch, could
you please test patch "f2fs: compress: fix race condition of overwrite
vs truncate" with compress_cache enabled? I've ran por_fsstress case
for 6 hours w/o any problems.

Thanks,

> 
> Thanks,
> 
>>
>>>
>>> Thanks,
>>>
>>>> .
>>>>
>> .
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
