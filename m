Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76720365003
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 03:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhDTBxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 21:53:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16139 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhDTBxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 21:53:25 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FPRSy1sJnzmdWg;
        Tue, 20 Apr 2021 09:49:54 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 20 Apr
 2021 09:52:48 +0800
Subject: Re: [PATCH] f2fs: fix to cover allocate_segment() with lock
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210414012134.128066-1-yuchao0@huawei.com>
 <YH22a55sexxwmGCe@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <03dc1c69-9215-1b5f-b1cc-c38454f3b90a@huawei.com>
Date:   Tue, 20 Apr 2021 09:52:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YH22a55sexxwmGCe@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/20 0:57, Jaegeuk Kim wrote:
> On 04/14, Chao Yu wrote:
>> As we did for other cases, in fix_curseg_write_pointer(), let's
>> change as below:
>> - use callback function s_ops->allocate_segment() instead of
>> raw function allocate_segment_by_default();
>> - cover allocate_segment() with curseg_lock and sentry_lock.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/segment.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index b2ee6b7791b0..daf9531ec58f 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -4848,7 +4848,12 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
>>   
>>   	f2fs_notice(sbi, "Assign new section to curseg[%d]: "
>>   		    "curseg[0x%x,0x%x]", type, cs->segno, cs->next_blkoff);
>> -	allocate_segment_by_default(sbi, type, true);
>> +
>> +	down_read(&SM_I(sbi)->curseg_lock);
>> +	down_write(&SIT_I(sbi)->sentry_lock);
>> +	SIT_I(sbi)->s_ops->allocate_segment(sbi, type, true);
>> +	up_write(&SIT_I(sbi)->sentry_lock);
>> +	up_read(&SM_I(sbi)->curseg_lock);
> 
> Seems f2fs_allocate_new_section()?

f2fs_allocate_new_section() will allocate new section only when current
section has been initialized and has valid block/ckpt_block.

It looks fix_curseg_write_pointer() wants to force migrating current segment
to new section whenever write pointer and curseg->next_blkoff is inconsistent.

So how about adding a parameter to force f2fs_allocate_new_section() to
allocate new section?

Thanks,

> 
>>   
>>   	/* check consistency of the zone curseg pointed to */
>>   	if (check_zone_write_pointer(sbi, zbd, &zone))
>> -- 
>> 2.29.2
> .
> 
