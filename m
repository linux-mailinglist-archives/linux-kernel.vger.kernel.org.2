Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68930346EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhCXBXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:23:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14511 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhCXBXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:23:34 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4r646kJxzPlSH;
        Wed, 24 Mar 2021 09:21:00 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 24 Mar
 2021 09:23:29 +0800
Subject: Re: [PATCH] f2fs: fix to align to section for fallocate() on pinned
 file
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20210305095601.96591-1-yuchao0@huawei.com>
 <d9c118eb-45b3-7f35-70bd-cb016957e6e8@kernel.org>
 <YFo0Tz1zl4tw7lUP@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d08a10bb-d6ac-1dde-7e61-836030c96f34@huawei.com>
Date:   Wed, 24 Mar 2021 09:23:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YFo0Tz1zl4tw7lUP@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/24 2:32, Jaegeuk Kim wrote:
> On 03/23, Chao Yu wrote:
>> On 2021/3/5 17:56, Chao Yu wrote:
>>> Now, fallocate() on a pinned file only allocates blocks which aligns
>>> to segment rather than section, so GC may try to migrate pinned file's
>>> block, and after several times of failure, pinned file's block could
>>> be migrated to other place, however user won't be aware of such
>>> condition, and then old obsolete block address may be readed/written
>>> incorrectly.
>>>
>>> To avoid such condition, let's try to allocate pinned file's blocks
>>> with section alignment.
>>>
>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>
>> Jaegeuk,
>>
>> Could you please check and apply below diff into original patch?
>>
>> ---
>>   fs/f2fs/file.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 236f3f69681a..24fa68fdcaa0 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1648,13 +1648,13 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
>>   		return 0;
>>
>>   	if (f2fs_is_pinned_file(inode)) {
>> -		block_t len = (map.m_len >> sbi->log_blocks_per_seg) <<
>> -					sbi->log_blocks_per_seg;
>> +		block_t sec_blks = BLKS_PER_SEC(sbi);
>> +		block_t len = rounddown(map.m_len, sec_blks);
> 
> len is declared above, so let me rephrase this as well.

Oh, right.

> 
>>
>> -		if (map.m_len % sbi->blocks_per_seg)
>> -			len += sbi->blocks_per_seg;
>> +		if (map.m_len % sec_blks)
>> +			len += sec_blks;
> 
> is this roundup()?

More clean.

> 
> Could you check this?
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=e1175f02291141bbd924fc578299305fcde35855

Looks good to me. :)

Thanks,

> 
>>
>> -		map.m_len = sbi->blocks_per_seg;
>> +		map.m_len = sec_blks;
>>   next_alloc:
>>   		if (has_not_enough_free_secs(sbi, 0,
>>   			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
>> -- 
>> 2.22.1
>>
> .
> 
