Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F4544150F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhKAINo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231284AbhKAINn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:13:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B28C60C4B;
        Mon,  1 Nov 2021 08:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635754270;
        bh=RUFki9qBrHYRF5mCH4qHIpQeS+hm5cKlVdDUyxWnQk0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S39LsCj1UWB+6RfF10axT+FEVP8jlyFOoAnhYfqBafnBOaWrvDmaGWXZhNhc8ASW3
         qGRdGG8TMGZBlaphRXuBqCShKR/rrD3x1x7Wskg1bGdLND44rTR7FApVpxzQFzDnJJ
         PKt+Sy41FixjDC6sGjh1FSgBQNZo2lZjmzCf7vUqMKeiRRZwKC1+ev0LoQFjYxnc9P
         pDMG7h41EpqDPIhL37Va850QIWr0KRqKDAbhkIYgIjQIS6QRFnJkkNrIR0vrPjg6Ox
         vmSQxU9+IEtVR5NTOT9NonzbFwibWmtZ80u6vfk9puFzW/IP2WDqyVzlALN1Nih7jt
         NDvNuUh9VFPEQ==
Message-ID: <e1903d27-ff8e-adb2-ac64-5af662b99d1f@kernel.org>
Date:   Mon, 1 Nov 2021 16:11:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] F2FS: invalidate META_MAPPING before IPU/DIO write
Content-Language: en-US
To:     Hyeong-Jun Kim <hj514.kim@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <CGME20211101054217epcas1p3c695f37ab925f47156bd45e3adb5ed94@epcas1p3.samsung.com>
 <20211101054214.24456-1-hj514.kim@samsung.com>
 <d1929b64-15a3-feaf-5401-1552b2eb2461@kernel.org>
 <9a0360922130485f4252970de4bb535667cc26e9.camel@samsung.com>
 <75c52307-7bfd-2408-d067-26d1fca7bb73@kernel.org>
 <02ffe8465f514102f5278e97bf3854c520fae91d.camel@samsung.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <02ffe8465f514102f5278e97bf3854c520fae91d.camel@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/1 15:23, Hyeong-Jun Kim wrote:
> On Mon, 2021-11-01 at 15:12 +0800, Chao Yu wrote:
>> On 2021/11/1 15:09, Hyeong-Jun Kim wrote:
>>> On Mon, 2021-11-01 at 14:28 +0800, Chao Yu wrote:
>>>> On 2021/11/1 13:42, Hyeong-Jun Kim wrote:
>>>>> Encrypted pages during GC are read and cached in META_MAPPING.
>>>>> However, due to cached pages in META_MAPPING, there is an issue
>>>>> where
>>>>> newly written pages are lost by IPU or DIO writes.
>>>>>
>>>>> Thread A                              Thread B
>>>>> - f2fs_gc(): blk 0x10 -> 0x20 (a)
>>>>>                                          - IPU or DIO write on
>>>>> blk
>>>>> 0x20 (b)
>>>>> - f2fs_gc(): blk 0x20 -> 0x30 (c)
>>>>>
>>>>> (a) page for blk 0x20 is cached in META_MAPPING and page for
>>>>> blk
>>>>> 0x10
>>>>>        is invalidated from META_MAPPING.
>>>>> (b) write new data to blk 0x200 using IPU or DIO, but outdated
>>>>> data
>>>>>        still remains in META_MAPPING.
>>>>> (c) f2fs_gc() try to move blk from 0x20 to 0x30 using cached
>>>>> page
>>>>> in
>>>>>        META_MAPPING. In conclusion, the newly written data in
>>>>> (b) is
>>>>> lost.
>>>>
>>>> In c), f2fs_gc() will readahead encrypted block from disk via
>>>> ra_data_block() anyway,
>>>> not matter cached encrypted page of meta inode is uptodate or
>>>> not, so
>>>> it's safe, right?
>>>
>>> Right,
>>> However, if DIO write is performed between phase 3 and phase 4 of
>>> f2fs_gc(),
>>> the cached page of meta_mapping will be out-dated, though it read
>>> data
>>> from
>>> disk via ra_data_block() in phase 3.
>>>
>>> What do you think?
>>
>> Due to i_gc_rwsem lock coverage, the race condition should not happen
>> right now?
>>
> - Thread A                                       - Thread B
> /* phase 3 */
> down_write(i_gc_rwsem)
> ra_data_block()
> up_write(i_gc_rwsem)
>                                                         
>   f2fs_direct_IO() :
>                                                         
>   down_read(i_gc_rwsem)
>                                                         
>   __blockdev_direct_IO()
>                                                             ...
>                                                           
>   get_ddata_block_dio_write()
>                                                             ...
>                                                           
>   f2fs_dio_submit_bio()
>                                                         
>   up_read(i_gc_rwsem)
> /* phase 4 */
> down_write(i_gc_rwsem)
> move_data_block()
> up_write(i_gc_rwsem)
> 
> It looks, i_gc_rwsem could not protect page update between phase 3 and
> 4.
> 
> Am I missing anything?

It looks you're right, there is a hole in between readahead and movepage functions...

Could you please update the race condition description? and add a tag as below to fix
stable kernel as well:

Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")

Thanks,

> 
> Thanks
> 
>> Thanks,
>>
>>> Thanks,
>>>> Am I missing anything?
>>>>
>>>> Thanks,
>>>>
>>>>> To address this issue, invalidating pages in META_MAPPING
>>>>> before
>>>>> IPU or
>>>>> DIO write.
>>>>>
>>>>> Signed-off-by: Hyeong-Jun Kim <
>>>>> hj514.kim@samsung.com
>>>>>
>>>>>
>>>>> ---
>>>>>     fs/f2fs/data.c    | 2 ++
>>>>>     fs/f2fs/segment.c | 3 +++
>>>>>     2 files changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>> index 74e1a350c1d8..9f754aaef558 100644
>>>>> --- a/fs/f2fs/data.c
>>>>> +++ b/fs/f2fs/data.c
>>>>> @@ -1708,6 +1708,8 @@ int f2fs_map_blocks(struct inode *inode,
>>>>> struct f2fs_map_blocks *map,
>>>>>     		 */
>>>>>     		f2fs_wait_on_block_writeback_range(inode,
>>>>>     						map->m_pblk,
>>>>> map-
>>>>>> m_len);
>>>>>
>>>>> +		invalidate_mapping_pages(META_MAPPING(sbi),
>>>>> +						map->m_pblk,
>>>>> map-
>>>>>> m_pblk);
>>>>>
>>>>>     
>>>>>     		if (map->m_multidev_dio) {
>>>>>     			block_t blk_addr = map->m_pblk;
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index 526423fe84ce..f57c55190f9e 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -3652,6 +3652,9 @@ int f2fs_inplace_write_data(struct
>>>>> f2fs_io_info *fio)
>>>>>     		goto drop_bio;
>>>>>     	}
>>>>>     
>>>>> +	invalidate_mapping_pages(META_MAPPING(fio->sbi),
>>>>> +				fio->new_blkaddr, fio-
>>>>>> new_blkaddr);
>>>>> +
>>>>>     	stat_inc_inplace_blocks(fio->sbi);
>>>>>     
>>>>>     	if (fio->bio && !(SM_I(sbi)->ipu_policy & (1 <<
>>>>> F2FS_IPU_NOCACHE)))
>>>>>
>>>>
>>>>
>>
>>
> 
