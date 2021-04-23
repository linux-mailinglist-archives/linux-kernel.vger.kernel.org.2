Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07138368BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 05:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbhDWDhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 23:37:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16152 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhDWDhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 23:37:47 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FRKdq6wF0zpbFn;
        Fri, 23 Apr 2021 11:34:07 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 23 Apr
 2021 11:37:06 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: set prefree as free segments after clear
 prefree segments
To:     =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
CC:     <jaegeuk@kernel.org>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <AIMAXgAnDv8vtlWxuL6mq4q3.3.1619145657480.Hmail.frank.li@vivo.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3323e5c0-cd52-528a-6a57-5982db05a4bf@huawei.com>
Date:   Fri, 23 Apr 2021 11:37:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <AIMAXgAnDv8vtlWxuL6mq4q3.3.1619145657480.Hmail.frank.li@vivo.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

On 2021/4/23 10:40, 李扬韬 wrote:
> HI Chao,
>   
>>> For now, when do_checkpoint fails, the prefree bitmap is not cleared,
>>> but these segments are already in the free state. If these segments
>>> are used, the segments in use will be reset to the free state when
>>> f2fs_clear_prefree_segments is called next time.
>>>
>>> So move set_prefree_as_free_segments after clear_prefree_segments.
>>
>> That's not correct.
>>
>> /*
>>   * Should call f2fs_clear_prefree_segments after checkpoint is done.
>>   */
>> static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
>>
>> Comments above set_prefree_as_free_segments() should have told you
>> the rule, otherwise if checkpoint failed, valid data in last valid
>> checkpoint could be corrupted after segment reuse.

Oh, it seems I misunderstood what the patch did, please ignore above
comments.

> 
> For do_checkpoint sucess:
> 
> f2fs_write_checkpoint
> ->f2fs_flush_sit_entries
>      ->set_prefree_as_free_segments
> ->do_checkpoint
> ->f2fs_clear_prefree_segments
> 
> 
> Calling set_prefree_as_free_segments when do_checkpoint fails,
> seems to be incorrect. I think clear free bitmap should be after
> clear prefree bitmap.
> 
> For do_checkpoint fail:
> 
> f2fs_write_checkpoint
> ->f2fs_flush_sit_entries
>      ->set_prefree_as_free_segments
> ->do_checkpoint
> ->f2fs_release_discard_addrs
> 
> The prefree bitmap is not cleared, but free bitmap is cleared，which means
> we can use these segments that are marked as free. When the free segments
> is used, the next f2fs_clear_prefree_segments will mark prefree as free again,
> causing some problem.

Okay, I can understand that.

But the problem here is, after applying this patch, successful checkpoint
may record wrong free_segment value:

- f2fs_write_checkpoint
  - f2fs_flush_sit_entries
  - do_checkpoint
   - ckpt->free_segment_count = cpu_to_le32(free_segments(sbi));
  - f2fs_clear_prefree_segments
   - __set_test_and_free
    - free_i->free_segments++;

I guess for the case of do_checkpoint() fails, maybe we can reset
free segment to prefree status.

Thoughts?

Thanks,

> 
> With this patch, for do_checkpoint fail:
> 
> f2fs_write_checkpoint
> ->f2fs_flush_sit_entries
> ->do_checkpoint
> ->f2fs_release_discard_addrs
> 
> At this time, we did not mark prefree as free segments, so these segments will not be used.
> 
> Thx
> 
