Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAB139A517
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhFCP4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhFCP4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:56:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5893C613DA;
        Thu,  3 Jun 2021 15:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622735710;
        bh=TId5wYGrUkaaw8Pm5vS104rvnq3wPFmOh7TAFuCAr/I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lVWqWCZ0LV40VYBbWqng7qvpQHKDvnU9y0XwVe4xOBLTz4m5ZWBBcVdlJcxYcrPGI
         ohw5rIwOstg5t8wamtk0xQqMLpLX1mp/ZyIL1NLmpA9szdBdu9GchC7zFJ53QG7gnD
         83YolVMNhBU6/YeyN8gYT1+P1gC0Ox4altzvUW1QuDN3wo4AWNVCXnTqIFDA8hRKwd
         2ntsl3zzkeVBNscOB4+AbzY9fWzLNX15p2wuaqmsRQBfDilBqKusIA72Oo5TCwfEt/
         ZvE1pQ5A0KNs0NJfBKPH93X65EiC9HwxFEGbQezXxrZBkr+i0VxddNospPz1d/3AVi
         bstUf0fIJ8tIA==
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: compress: add compress_inode to cache
 compressed blocks
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <YKz0VJSYYBEnF75V@google.com> <YKz1gGctmOJ+LjOn@google.com>
 <2c4db877-b5e6-1139-98b5-be2d9e7872be@kernel.org>
 <YK0DVi4aTNdXDN3L@google.com>
 <dda2400f-4a06-0ef6-b4f5-8aafe86bd81d@huawei.com>
 <YK5Mewfb3gMg1yGM@google.com>
 <5140516c-e4c6-fd6a-69b2-7566c903cb53@kernel.org>
 <YLZc0y0S3sGkU6f4@google.com> <YLZt+rFClf7xEzOa@google.com>
 <09fa74d3-a9df-028f-3ebc-2b845e5cd609@kernel.org>
 <YLek7U+BaFvHhz58@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <eb52cab7-d9b3-c84b-1c7b-8fee463b06c5@kernel.org>
Date:   Thu, 3 Jun 2021 23:55:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLek7U+BaFvHhz58@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/2 23:34, Jaegeuk Kim wrote:
> On 06/02, Chao Yu wrote:
>> On 2021/6/2 1:27, Jaegeuk Kim wrote:
>>> On 06/01, Jaegeuk Kim wrote:
>>>> On 05/26, Chao Yu wrote:
>>>>> On 2021/5/26 21:26, Jaegeuk Kim wrote:
>>>>>> On 05/26, Chao Yu wrote:
>>>>>>> On 2021/5/25 22:01, Jaegeuk Kim wrote:
>>>>>>>> On 05/25, Chao Yu wrote:
>>>>>>>>> On 2021/5/25 21:02, Jaegeuk Kim wrote:
>>>>>>>>>> On 05/25, Jaegeuk Kim wrote:
>>>>>>>>>>> On 05/25, Chao Yu wrote:
>>>>>>>>>>>> Also, and queue this?
>>>>>>>>>>>
>>>>>>>>>>> Easy to get this?
>>>>>>>>>>
>>>>>>>>>> need GFP_NOFS?
>>>>>>>>>
>>>>>>>>> Not sure, I use __GFP_IO intentionally here to avoid __GFP_RECLAIM from
>>>>>>>>> GFP_NOFS, because in low memory case, I don't want to instead page cache
>>>>>>>>> of normal file with page cache of sbi->compress_inode.
>>>>>>>>>
>>>>>>>>> What is memory size in your vm?
>>>>>>>>
>>>>>>>> 4GB. If I set GFP_NOFS, I don't see the error anymore, at least.
>>>>>>>
>>>>>>> I applied below patch and don't see the warning message anymore.
>>>>>>>
>>>>>>> ---
>>>>>>>     fs/f2fs/compress.c | 2 +-
>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>>>>>>> index 701dd0f6f4ec..ed5b7fabc604 100644
>>>>>>> --- a/fs/f2fs/compress.c
>>>>>>> +++ b/fs/f2fs/compress.c
>>>>>>> @@ -1703,7 +1703,7 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
>>>>>>>     	avail_ram = si.totalram - si.totalhigh;
>>>>>>>
>>>>>>>     	/* free memory is lower than watermark, deny caching compress page */
>>>>>>> -	if (free_ram <= sbi->compress_watermark / 100 * avail_ram)
>>>>>
>>>>> This is buggy, because sbi->compress_watermark equals to 20, so that
>>>>> sbi->compress_watermark / 100 * avail_ram always be zero...
>>>>>
>>>>> After this change, if free ram is lower, we may just skip caching
>>>>> compressed blocks here.
>>>>
>>>> Can we move this in f2fs_available_free_memory()?
>>
>> More clean.
>>
>> One comment below:
>>
>>>
>>> Testing this.
>>>
>>> ---
>>>    fs/f2fs/compress.c | 14 +-------------
>>>    fs/f2fs/node.c     | 11 ++++++++++-
>>>    fs/f2fs/node.h     |  1 +
>>>    3 files changed, 12 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>>> index 9fd62a0a646b..455561826c7d 100644
>>> --- a/fs/f2fs/compress.c
>>> +++ b/fs/f2fs/compress.c
>>> @@ -1688,8 +1688,6 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
>>>    {
>>>    	struct page *cpage;
>>>    	int ret;
>>> -	struct sysinfo si;
>>> -	unsigned long free_ram, avail_ram;
>>>    	if (!test_opt(sbi, COMPRESS_CACHE))
>>>    		return;
>>> @@ -1697,17 +1695,7 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
>>>    	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE_READ))
>>>    		return;
>>> -	si_meminfo(&si);
>>> -	free_ram = si.freeram;
>>> -	avail_ram = si.totalram - si.totalhigh;
>>> -
>>> -	/* free memory is lower than watermark, deny caching compress page */
>>> -	if (free_ram <= sbi->compress_watermark / 100 * avail_ram)
>>> -		return;
>>> -
>>> -	/* cached page count exceed threshold, deny caching compress page */
>>> -	if (COMPRESS_MAPPING(sbi)->nrpages >=
>>
>> Need to cover COMPRESS_MAPPING() with CONFIG_F2FS_FS_COMPRESSION.
> 
> Added like this.
> 
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -99,6 +99,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
>                                  sizeof(struct discard_cmd)) >> PAGE_SHIFT;
>                  res = mem_size < (avail_ram * nm_i->ram_thresh / 100);
>          } else if (type == COMPRESS_PAGE) {
> +#ifdef CONFIG_F2FS_FS_COMPRESSION

How about adding free_ram definition and assigment here?

unsigned long free_ram = val.freeram;

Thanks,

>                  /*
>                   * free memory is lower than watermark or cached page count
>                   * exceed threshold, deny caching compress page.
> @@ -106,6 +107,9 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
>                  res = (free_ram > avail_ram * sbi->compress_watermark / 100) &&
>                          (COMPRESS_MAPPING(sbi)->nrpages <
>                           free_ram * sbi->compress_percent / 100);
> +#else
> +               res = false;
> +#endif
>          } else {
>                  if (!sbi->sb->s_bdi->wb.dirty_exceeded)
>                          return true;
> 
>>
>> Thanks,
>>
>>> -			free_ram / 100 * sbi->compress_percent)
>>> +	if (!f2fs_available_free_memory(sbi, COMPRESS_PAGE))
>>>    		return;
>>>    	cpage = find_get_page(COMPRESS_MAPPING(sbi), blkaddr);
>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>> index 3a8f7afa5059..67093416ce9c 100644
>>> --- a/fs/f2fs/node.c
>>> +++ b/fs/f2fs/node.c
>>> @@ -45,7 +45,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
>>>    	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>    	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>>>    	struct sysinfo val;
>>> -	unsigned long avail_ram;
>>> +	unsigned long avail_ram, free_ram;
>>>    	unsigned long mem_size = 0;
>>>    	bool res = false;
>>> @@ -56,6 +56,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
>>>    	/* only uses low memory */
>>>    	avail_ram = val.totalram - val.totalhigh;
>>> +	free_ram = val.freeram;
>>>    	/*
>>>    	 * give 25%, 25%, 50%, 50%, 50% memory for each components respectively
>>> @@ -97,6 +98,14 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
>>>    		mem_size = (atomic_read(&dcc->discard_cmd_cnt) *
>>>    				sizeof(struct discard_cmd)) >> PAGE_SHIFT;
>>>    		res = mem_size < (avail_ram * nm_i->ram_thresh / 100);
>>> +	} else if (type == COMPRESS_PAGE) {
>>> +		/*
>>> +		 * free memory is lower than watermark or cached page count
>>> +		 * exceed threshold, deny caching compress page.
>>> +		 */
>>> +		res = (free_ram > avail_ram * sbi->compress_watermark / 100) &&
>>> +			(COMPRESS_MAPPING(sbi)->nrpages <
>>> +			 free_ram * sbi->compress_percent / 100);
>>>    	} else {
>>>    		if (!sbi->sb->s_bdi->wb.dirty_exceeded)
>>>    			return true;
>>> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
>>> index d85e8659cfda..84d45385d1f2 100644
>>> --- a/fs/f2fs/node.h
>>> +++ b/fs/f2fs/node.h
>>> @@ -148,6 +148,7 @@ enum mem_type {
>>>    	EXTENT_CACHE,	/* indicates extent cache */
>>>    	INMEM_PAGES,	/* indicates inmemory pages */
>>>    	DISCARD_CACHE,	/* indicates memory of cached discard cmds */
>>> +	COMPRESS_PAGE,	/* indicates memory of cached compressed pages */
>>>    	BASE_CHECK,	/* check kernel status */
>>>    };
>>>
