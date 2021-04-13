Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4781035D59F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbhDMDEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:04:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16532 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbhDMDEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:04:49 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FK9Nw3fTQzPpCY;
        Tue, 13 Apr 2021 11:01:36 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 13 Apr
 2021 11:04:23 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid touching checkpointed
 data in get_victim()
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210324031828.67133-1-yuchao0@huawei.com>
 <YFvQGxLbpmDjxEzR@google.com>
 <2dfb085b-80ce-050b-5650-986675a07488@huawei.com>
 <66e0a225-7f52-a33e-ccd6-e7bfa1067ed1@kernel.org>
 <YHUJFElliMOWMbWN@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c83a46b3-de4b-5ba0-2cb4-162a349907aa@huawei.com>
Date:   Tue, 13 Apr 2021 11:04:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YHUJFElliMOWMbWN@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/13 10:59, Jaegeuk Kim wrote:
> On 04/11, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> Could you please help to merge below cleanup diff into original patch?
>> or merge this separately if it is too late since it is near rc7.
> 
> I didn't review this tho, this gives an error in xfstests/083.

My bad, I hit this issue too, let me check this.

Thanks,

> 
>>
>>  From 5a342a8f332a1b3281ec0e2b4d41b5287689c8ed Mon Sep 17 00:00:00 2001
>> From: Chao Yu <yuchao0@huawei.com>
>> Date: Sun, 11 Apr 2021 14:29:34 +0800
>> Subject: [PATCH] f2fs: avoid duplicated codes for cleanup
>>
>> f2fs_segment_has_free_slot() was copied from __next_free_blkoff(),
>> the main implementation of them is almost the same, clean up them to
>> reuse common code as much as possible.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/segment.c | 32 ++++++++++----------------------
>>   1 file changed, 10 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index b33273aa5c22..bd9056165d62 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -2627,22 +2627,20 @@ static void new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
>>   	curseg->alloc_type = LFS;
>>   }
>>
>> -static void __next_free_blkoff(struct f2fs_sb_info *sbi,
>> -			struct curseg_info *seg, block_t start)
>> +static int __next_free_blkoff(struct f2fs_sb_info *sbi,
>> +					int segno, block_t start)
>>   {
>> -	struct seg_entry *se = get_seg_entry(sbi, seg->segno);
>> +	struct seg_entry *se = get_seg_entry(sbi, segno);
>>   	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
>>   	unsigned long *target_map = SIT_I(sbi)->tmp_map;
>>   	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
>>   	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
>> -	int i, pos;
>> +	int i;
>>
>>   	for (i = 0; i < entries; i++)
>>   		target_map[i] = ckpt_map[i] | cur_map[i];
>>
>> -	pos = __find_rev_next_zero_bit(target_map, sbi->blocks_per_seg, start);
>> -
>> -	seg->next_blkoff = pos;
>> +	return __find_rev_next_zero_bit(target_map, sbi->blocks_per_seg, start);
>>   }
>>
>>   /*
>> @@ -2654,26 +2652,16 @@ static void __refresh_next_blkoff(struct f2fs_sb_info *sbi,
>>   				struct curseg_info *seg)
>>   {
>>   	if (seg->alloc_type == SSR)
>> -		__next_free_blkoff(sbi, seg, seg->next_blkoff + 1);
>> +		seg->next_blkoff =
>> +			__next_free_blkoff(sbi, seg->segno,
>> +						seg->next_blkoff + 1);
>>   	else
>>   		seg->next_blkoff++;
>>   }
>>
>>   bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
>>   {
>> -	struct seg_entry *se = get_seg_entry(sbi, segno);
>> -	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
>> -	unsigned long *target_map = SIT_I(sbi)->tmp_map;
>> -	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
>> -	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
>> -	int i, pos;
>> -
>> -	for (i = 0; i < entries; i++)
>> -		target_map[i] = ckpt_map[i] | cur_map[i];
>> -
>> -	pos = __find_rev_next_zero_bit(target_map, sbi->blocks_per_seg, 0);
>> -
>> -	return pos < sbi->blocks_per_seg;
>> +	return __next_free_blkoff(sbi, segno, 0) < sbi->blocks_per_seg;
>>   }
>>
>>   /*
>> @@ -2701,7 +2689,7 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type, bool flush)
>>
>>   	reset_curseg(sbi, type, 1);
>>   	curseg->alloc_type = SSR;
>> -	__next_free_blkoff(sbi, curseg, 0);
>> +	__next_free_blkoff(sbi, curseg->segno, 0);
>>
>>   	sum_page = f2fs_get_sum_page(sbi, new_segno);
>>   	if (IS_ERR(sum_page)) {
>> -- 
>> 2.22.1
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
