Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BC7442749
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 07:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhKBGxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 02:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhKBGxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 02:53:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF20860E8C;
        Tue,  2 Nov 2021 06:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635835858;
        bh=0m2h0gxAR4wB7PVa2oQ4sTYz0e/lrZ3V9+uXt+Kp2iQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V4RIxDv66FDQB9Lz6AzG2yzCDhVK0M+pR1pxC7lLvjwypxqOxy+C1oK1o0OShzvPR
         6Bm3jftA0uM9QniEDtQ7pKfQTeJlmSER5ZtsEqUczSS+Fuw96r7wKE+erQ2JnvBG4j
         Gzjo3b5Nq6ziIE9T3vDa8ZlhKbl6tpRKrYq0SgOTeNsrIeHRi3iwSP4by6mcgWK6eu
         OT4L8hNtKYxup4GYO8LBKOvMeLbZH8Kzc22S/goWprl/zuojCTiDZk4Uk7CpW73Q7Z
         WB7QOfqoRqu1gk5rfA0gQFYYLQ+agPc9IEth3E0GW66X1AVIJDaNSHTPdW/NhwawVf
         G+5kjhYCobM/w==
Message-ID: <1f724fcc-6a32-6483-444c-53c78376201d@kernel.org>
Date:   Tue, 2 Nov 2021 14:50:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3] F2FS: invalidate META_MAPPING before IPU/DIO write
Content-Language: en-US
To:     Hyeong-Jun Kim <hj514.kim@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     sj1557.seo@samsung.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <CGME20211102045952epcas1p44cb6fd41baa76a19e0924c4b6b3cf1e6@epcas1p4.samsung.com>
 <20211102045949.63530-1-hj514.kim@samsung.com>
 <9ee5741f-35f8-c0b9-f045-fb70aa49f6de@kernel.org>
 <cc63ca8752da7932b57769d58fce68dea5d9a8bc.camel@samsung.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <cc63ca8752da7932b57769d58fce68dea5d9a8bc.camel@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/2 14:49, Hyeong-Jun Kim wrote:
> On Tue, 2021-11-02 at 14:47 +0800, Chao Yu wrote:
>> On 2021/11/2 12:59, Hyeong-Jun Kim wrote:
>>> Encrypted pages during GC are read and cached in META_MAPPING.
>>> However, due to cached pages in META_MAPPING, there is an issue
>>> where
>>> newly written pages are lost by IPU or DIO writes.
>>>
>>> Thread A - f2fs_gc()            Thread B
>>> /* phase 3 */
>>> down_write(i_gc_rwsem)
>>> ra_data_block()       ---- (a)
>>> up_write(i_gc_rwsem)
>>>                                   f2fs_direct_IO() :
>>>                                    - down_read(i_gc_rwsem)
>>>                                    - __blockdev_direct_io()
>>>                                    - get_data_block_dio_write()
>>>                                    - f2fs_dio_submit_bio()  ---- (b)
>>>                                    - up_read(i_gc_rwsem)
>>> /* phase 4 */
>>> down_write(i_gc_rwsem)
>>> move_data_block()     ---- (c)
>>> up_write(i_gc_rwsem)
>>>
>>> (a) In phase 3 of f2fs_gc(), up-to-date page is read from storage
>>> and
>>>       cached in META_MAPPING.
>>> (b) In thread B, writing new data by IPU or DIO write on same
>>> blkaddr as
>>>       read in (a). cached page in META_MAPPING become out-dated.
>>> (c) In phase 4 of f2fs_gc(), out-dated page in META_MAPPING is
>>> copied to
>>>       new blkaddr. In conclusion, the newly written data in (b) is
>>> lost.
>>>
>>> To address this issue, invalidating pages in META_MAPPING before
>>> IPU or
>>> DIO write.
>>>
>>> ---
>>> v3:
>>>    - Use sbi instead of fio->sbi in f2fs_inplace_write_data()
>>> v2:
>>>    - Update patch description with race condition
>>
>>
>>
>>> Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")
>>> Signed-off-by: Hyeong-Jun Kim <
>>> hj514.kim@samsung.com
>>>>
>>> ---
>>
>> Change log should be attached here, otherwise Fixes & Signed-off-by
>> tag will be lost
>> after applying this patch.
>>
>> Thanks,
>>
> Thanks for your comment.
> Should I re-send this patch?

Yes, please. :)

Thanks,

> 
> Thanks,
>>>    fs/f2fs/data.c    | 2 ++
>>>    fs/f2fs/segment.c | 3 +++
>>>    2 files changed, 5 insertions(+)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 74e1a350c1d8..9f754aaef558 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1708,6 +1708,8 @@ int f2fs_map_blocks(struct inode *inode,
>>> struct f2fs_map_blocks *map,
>>>    		 */
>>>    		f2fs_wait_on_block_writeback_range(inode,
>>>    						map->m_pblk, map-
>>>> m_len);
>>> +		invalidate_mapping_pages(META_MAPPING(sbi),
>>> +						map->m_pblk, map-
>>>> m_pblk);
>>>    
>>>    		if (map->m_multidev_dio) {
>>>    			block_t blk_addr = map->m_pblk;
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 526423fe84ce..df9ed75f0b7a 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -3652,6 +3652,9 @@ int f2fs_inplace_write_data(struct
>>> f2fs_io_info *fio)
>>>    		goto drop_bio;
>>>    	}
>>>    
>>> +	invalidate_mapping_pages(META_MAPPING(sbi),
>>> +				fio->new_blkaddr, fio->new_blkaddr);
>>> +
>>>    	stat_inc_inplace_blocks(fio->sbi);
>>>    
>>>    	if (fio->bio && !(SM_I(sbi)->ipu_policy & (1 <<
>>> F2FS_IPU_NOCACHE)))
>>>
>>
>>
> 
