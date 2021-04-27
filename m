Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7328B36BD58
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 04:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhD0CdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 22:33:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17818 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhD0CdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 22:33:20 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FTm276dwwz7vsT;
        Tue, 27 Apr 2021 10:30:07 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 27 Apr
 2021 10:32:30 +0800
Subject: Re: [RFC PATCH] f2fs: restructure f2fs page.private layout
To:     Matthew Wilcox <willy@infradead.org>
CC:     <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210426100908.109435-1-yuchao0@huawei.com>
 <20210426154021.GN235567@casper.infradead.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <498cdef5-a528-1b65-4af8-906ae2ac3cac@huawei.com>
Date:   Tue, 27 Apr 2021 10:32:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210426154021.GN235567@casper.infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/26 23:40, Matthew Wilcox wrote:
> On Mon, Apr 26, 2021 at 06:09:08PM +0800, Chao Yu wrote:
>> Restruct f2fs page private layout for below reasons:
>>
>> There are some cases that f2fs wants to set a flag in a page to
>> indicate a specified status of page:
>> a) page is in transaction list for atomic write
>> b) page contains dummy data for aligned write
>> c) page is migrating for GC
>> d) page contains inline data for inline inode flush
>> e) page is verified in merkle tree for fsverity
> 
> hm, why do you need to record that?  I would have thought that if a file
> is marked as being protected by the merkle tree then any pages read in
> would be !uptodate until the merkle tree verification had happened.

I should describe more clearly about the page, the page is belong to merkle
tree, rather than the one contains user data, for more details:

https://elixir.bootlin.com/linux/latest/source/fs/verity/verify.c#L69

> 
>> f) page is dirty and has filesystem/inode reference count for writeback
>> g) page is temporary and has decompress io context reference for compression
>>
>> There are existed places in page structure we can use to store
>> f2fs private status/data:
>> - page.flags: PG_checked, PG_private
>> - page.private
>>
>> However it was a mess when we using them, which may cause potential
>> confliction:
>> 		page.private	PG_private	PG_checked
>> a)		-1		set
>> b)		-2

Sorry,

b) should have set PG_private.

>> c), d), e)					set
>> f)		0		set
>> g)		pointer		set
>>
>> The other problem is page.flags has no free slot, if we can avoid set
>> zero to page.private and set PG_private flag, then we use non-zero value
>> to indicate PG_private status, so that we may have chance to reclaim
>> PG_private slot for other usage. [1]
>>
>> So in this patch let's restructure f2fs' page.private as below:
>>
>> Layout A: lowest bit should be 1
>> | bit0 = 1 | bit1 | bit2 | ... | bit MAX | private data .... |
>>   bit 0	PAGE_PRIVATE_NOT_POINTER
>>   bit 1	PAGE_PRIVATE_ATOMIC_WRITE
>>   bit 2	PAGE_PRIVATE_DUMMY_WRITE
>>   bit 3	PAGE_PRIVATE_ONGOING_MIGRATION
>>   bit 4	PAGE_PRIVATE_INLINE_INODE
>>   bit 5	PAGE_PRIVATE_REF_RESOURCE
>>   bit 6-	f2fs private data
>>
>> Layout B: lowest bit should be 0
>>   page.private is a wrapped pointer.
>>
>> After the change:
>> 		page.private	PG_private	PG_checked
>> a)		11		set
>> b)		101

ditto,

>> c)		1001
>> d)		10001
>> e)						set
>> f)		100001		set
>> g)		pointer		set
> 
> Mmm ... this isn't enough to let us remove PG_private.  We'd need PG_private
> to be set for b,c,d as well.

I can try to add PG_private for c) and d).

> 
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 817d0bcb5c67..e393a67a023c 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -444,7 +444,11 @@ static int f2fs_set_meta_page_dirty(struct page *page)
>>   	if (!PageDirty(page)) {
>>   		__set_page_dirty_nobuffers(page);
>>   		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_META);
>> -		f2fs_set_page_private(page, 0);
>> +		set_page_private_reference(page);
>> +		if (!PagePrivate(page)) {
>> +			SetPagePrivate(page);
>> +			get_page(page);
>> +		}
> 
> I'm not a big fan of this pattern (which seems to be repeated quite often)
> I think it should be buried within set_page_private_reference().  Also,

Let me check how to avoid duplicated codes.

> are the states abcdf all mutually exclusive, or can a page be in states
> (eg) b and d at the same time?

Not all states are mutually exclusive, e.g a) and f) are mutually exclusive.

> 
>> -		if (IS_DUMMY_WRITTEN_PAGE(page)) {
>> -			set_page_private(page, (unsigned long)NULL);
>> +		if (page_private_dummy(page)) {
>> +			clear_page_private_dummy(page);
>>   			ClearPagePrivate(page);
> 
> I think the ClearPagePrivate should be buried in the page_private_dummy()
> macro too ... and shouldn't there be a put_page() for this too?

b) and g) are allocated from mempool, should we add one extra reference
count for them after set PG_private?

Thanks,

> 
> .
> 
