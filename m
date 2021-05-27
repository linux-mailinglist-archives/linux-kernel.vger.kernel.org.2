Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0083924B8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhE0COC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:14:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3956 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhE0COA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:14:00 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FrB8Y35gRz81Nv;
        Thu, 27 May 2021 10:09:33 +0800 (CST)
Received: from dggemx753-chm.china.huawei.com (10.0.44.37) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 10:12:26 +0800
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 10:12:25 +0800
Subject: Re: [PATCH 1/2] f2fs: swap: remove dead codes
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20210526062927.52629-1-yuchao0@huawei.com>
 <YK5NXdyjgB6EFY5Q@google.com>
 <e4c1df88-f1f4-99e0-6f83-fa0f3110d737@kernel.org>
 <YK74cyGYzWZCmZue@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <21ec5a95-bdbc-358d-99c7-e75e91228039@huawei.com>
Date:   Thu, 27 May 2021 10:12:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YK74cyGYzWZCmZue@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggemx704-chm.china.huawei.com (10.1.199.51) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/27 9:40, Jaegeuk Kim wrote:
> On 05/26, Chao Yu wrote:
>> On 2021/5/26 21:30, Jaegeuk Kim wrote:
>>> On 05/26, Chao Yu wrote:
>>>> After commit af4b6b8edf6a ("f2fs: introduce check_swap_activate_fast()"),
>>>> we will never run into original logic of check_swap_activate() before
>>>> f2fs supports non 4k-sized page, so let's delete those dead codes.
>>>
>>> Why not keeping this for large page support in future maybe?
>>
>> Well, if so, at that time, it would be better to refactor
>> check_swap_activate_fast() implementation based on f2fs_map_block() rather
>> than refactoring check_swap_activate() implementation based on low efficient
>> bmap()?
> 
> Let's first check whether we support large page. Have you quickly tested it?
> If we support it now and current flow is just inefficient, I'd say keeping but
> refactoring it later.

Let me check this, but I guess it missed to handle large page in lots of flows,
not sure where we may panic at... :(

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>    fs/f2fs/data.c | 171 +------------------------------------------------
>>>>    1 file changed, 3 insertions(+), 168 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index 3058c7e28b11..9c23fde93b76 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -3830,67 +3830,7 @@ int f2fs_migrate_page(struct address_space *mapping,
>>>>    #endif
>>>>    #ifdef CONFIG_SWAP
>>>> -static int f2fs_is_file_aligned(struct inode *inode)
>>>> -{
>>>> -	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>> -	block_t main_blkaddr = SM_I(sbi)->main_blkaddr;
>>>> -	block_t cur_lblock;
>>>> -	block_t last_lblock;
>>>> -	block_t pblock;
>>>> -	unsigned long nr_pblocks;
>>>> -	unsigned int blocks_per_sec = BLKS_PER_SEC(sbi);
>>>> -	unsigned int not_aligned = 0;
>>>> -	int ret = 0;
>>>> -
>>>> -	cur_lblock = 0;
>>>> -	last_lblock = bytes_to_blks(inode, i_size_read(inode));
>>>> -
>>>> -	while (cur_lblock < last_lblock) {
>>>> -		struct f2fs_map_blocks map;
>>>> -
>>>> -		memset(&map, 0, sizeof(map));
>>>> -		map.m_lblk = cur_lblock;
>>>> -		map.m_len = last_lblock - cur_lblock;
>>>> -		map.m_next_pgofs = NULL;
>>>> -		map.m_next_extent = NULL;
>>>> -		map.m_seg_type = NO_CHECK_TYPE;
>>>> -		map.m_may_create = false;
>>>> -
>>>> -		ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
>>>> -		if (ret)
>>>> -			goto out;
>>>> -
>>>> -		/* hole */
>>>> -		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
>>>> -			f2fs_err(sbi, "Swapfile has holes\n");
>>>> -			ret = -ENOENT;
>>>> -			goto out;
>>>> -		}
>>>> -
>>>> -		pblock = map.m_pblk;
>>>> -		nr_pblocks = map.m_len;
>>>> -
>>>> -		if ((pblock - main_blkaddr) & (blocks_per_sec - 1) ||
>>>> -			nr_pblocks & (blocks_per_sec - 1)) {
>>>> -			if (f2fs_is_pinned_file(inode)) {
>>>> -				f2fs_err(sbi, "Swapfile does not align to section");
>>>> -				ret = -EINVAL;
>>>> -				goto out;
>>>> -			}
>>>> -			not_aligned++;
>>>> -		}
>>>> -
>>>> -		cur_lblock += nr_pblocks;
>>>> -	}
>>>> -	if (not_aligned)
>>>> -		f2fs_warn(sbi, "Swapfile (%u) is not align to section: \n"
>>>> -			"\t1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate()",
>>>> -			not_aligned);
>>>> -out:
>>>> -	return ret;
>>>> -}
>>>> -
>>>> -static int check_swap_activate_fast(struct swap_info_struct *sis,
>>>> +static int check_swap_activate(struct swap_info_struct *sis,
>>>>    				struct file *swap_file, sector_t *span)
>>>>    {
>>>>    	struct address_space *mapping = swap_file->f_mapping;
>>>> @@ -3907,6 +3847,8 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
>>>>    	unsigned int not_aligned = 0;
>>>>    	int ret = 0;
>>>> +	f2fs_bug_on(sbi, PAGE_SIZE != F2FS_BLKSIZE);
>>>> +
>>>>    	/*
>>>>    	 * Map all the blocks into the extent list.  This code doesn't try
>>>>    	 * to be very smart.
>>>> @@ -3986,113 +3928,6 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
>>>>    	return ret;
>>>>    }
>>>> -/* Copied from generic_swapfile_activate() to check any holes */
>>>> -static int check_swap_activate(struct swap_info_struct *sis,
>>>> -				struct file *swap_file, sector_t *span)
>>>> -{
>>>> -	struct address_space *mapping = swap_file->f_mapping;
>>>> -	struct inode *inode = mapping->host;
>>>> -	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>> -	unsigned blocks_per_page;
>>>> -	unsigned long page_no;
>>>> -	sector_t probe_block;
>>>> -	sector_t last_block;
>>>> -	sector_t lowest_block = -1;
>>>> -	sector_t highest_block = 0;
>>>> -	int nr_extents = 0;
>>>> -	int ret = 0;
>>>> -
>>>> -	if (PAGE_SIZE == F2FS_BLKSIZE)
>>>> -		return check_swap_activate_fast(sis, swap_file, span);
>>>> -
>>>> -	ret = f2fs_is_file_aligned(inode);
>>>> -	if (ret)
>>>> -		goto out;
>>>> -
>>>> -	blocks_per_page = bytes_to_blks(inode, PAGE_SIZE);
>>>> -
>>>> -	/*
>>>> -	 * Map all the blocks into the extent list.  This code doesn't try
>>>> -	 * to be very smart.
>>>> -	 */
>>>> -	probe_block = 0;
>>>> -	page_no = 0;
>>>> -	last_block = bytes_to_blks(inode, i_size_read(inode));
>>>> -	while ((probe_block + blocks_per_page) <= last_block &&
>>>> -			page_no < sis->max) {
>>>> -		unsigned block_in_page;
>>>> -		sector_t first_block;
>>>> -		sector_t block = 0;
>>>> -
>>>> -		cond_resched();
>>>> -
>>>> -		block = probe_block;
>>>> -		ret = bmap(inode, &block);
>>>> -		if (ret)
>>>> -			goto out;
>>>> -		if (!block)
>>>> -			goto bad_bmap;
>>>> -		first_block = block;
>>>> -
>>>> -		/*
>>>> -		 * It must be PAGE_SIZE aligned on-disk
>>>> -		 */
>>>> -		if (first_block & (blocks_per_page - 1)) {
>>>> -			probe_block++;
>>>> -			goto reprobe;
>>>> -		}
>>>> -
>>>> -		for (block_in_page = 1; block_in_page < blocks_per_page;
>>>> -					block_in_page++) {
>>>> -
>>>> -			block = probe_block + block_in_page;
>>>> -			ret = bmap(inode, &block);
>>>> -			if (ret)
>>>> -				goto out;
>>>> -			if (!block)
>>>> -				goto bad_bmap;
>>>> -
>>>> -			if (block != first_block + block_in_page) {
>>>> -				/* Discontiguity */
>>>> -				probe_block++;
>>>> -				goto reprobe;
>>>> -			}
>>>> -		}
>>>> -
>>>> -		first_block >>= (PAGE_SHIFT - inode->i_blkbits);
>>>> -		if (page_no) {	/* exclude the header page */
>>>> -			if (first_block < lowest_block)
>>>> -				lowest_block = first_block;
>>>> -			if (first_block > highest_block)
>>>> -				highest_block = first_block;
>>>> -		}
>>>> -
>>>> -		/*
>>>> -		 * We found a PAGE_SIZE-length, PAGE_SIZE-aligned run of blocks
>>>> -		 */
>>>> -		ret = add_swap_extent(sis, page_no, 1, first_block);
>>>> -		if (ret < 0)
>>>> -			goto out;
>>>> -		nr_extents += ret;
>>>> -		page_no++;
>>>> -		probe_block += blocks_per_page;
>>>> -reprobe:
>>>> -		continue;
>>>> -	}
>>>> -	ret = nr_extents;
>>>> -	*span = 1 + highest_block - lowest_block;
>>>> -	if (page_no == 0)
>>>> -		page_no = 1;	/* force Empty message */
>>>> -	sis->max = page_no;
>>>> -	sis->pages = page_no - 1;
>>>> -	sis->highest_bit = page_no - 1;
>>>> -out:
>>>> -	return ret;
>>>> -bad_bmap:
>>>> -	f2fs_err(sbi, "Swapfile has holes\n");
>>>> -	return -EINVAL;
>>>> -}
>>>> -
>>>>    static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
>>>>    				sector_t *span)
>>>>    {
>>>> -- 
>>>> 2.29.2
> .
> 
