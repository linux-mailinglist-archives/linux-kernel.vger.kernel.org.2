Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03771327621
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 03:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhCACmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 21:42:20 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13387 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhCACmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 21:42:19 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Dpkxm1qP7z7qw3;
        Mon,  1 Mar 2021 10:39:56 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 1 Mar 2021
 10:41:32 +0800
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: check if swapfile is
 section-alligned
To:     Huang Jianan <huangjianan@oppo.com>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>, <zhangshiming@oppo.com>
References: <20210227120231.136559-1-huangjianan@oppo.com>
 <20210227120231.136559-3-huangjianan@oppo.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b4ae58b2-3325-6cdf-26b4-b77810d33bbc@huawei.com>
Date:   Mon, 1 Mar 2021 10:41:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210227120231.136559-3-huangjianan@oppo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianan,

On 2021/2/27 20:02, Huang Jianan via Linux-f2fs-devel wrote:
> If the swapfile isn't created by pin and fallocate, it cann't be

Typo:

can't

> guaranteed section-aligned, so it may be selected by f2fs gc. When
> gc_pin_file_threshold is reached, the address of swapfile may change,
> but won't be synchroniz to swap_extent, so swap will write to wrong

synchronized

> address, which will cause data corruption.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>   fs/f2fs/data.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 4dbc1cafc55d..3e523d6e4643 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3781,11 +3781,63 @@ int f2fs_migrate_page(struct address_space *mapping,
>   #endif
>   
>   #ifdef CONFIG_SWAP
> +static int f2fs_check_file_aligned(struct inode *inode)

f2fs_check_file_alignment() or f2fs_is_file_aligned()?

> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	block_t main_blkaddr = SM_I(sbi)->main_blkaddr;
> +	block_t cur_lblock;
> +	block_t last_lblock;
> +	block_t pblock;
> +	unsigned long len;
> +	unsigned long nr_pblocks;
> +	unsigned int blocks_per_sec = sbi->blocks_per_seg * sbi->segs_per_sec;

unsigned int blocks_per_sec = BLKS_PER_SEC(sbi);

> +	int ret;
> +
> +	cur_lblock = 0;
> +	last_lblock = bytes_to_blks(inode, i_size_read(inode));
> +	len = i_size_read(inode);
> +
> +	while (cur_lblock < last_lblock) {
> +		struct f2fs_map_blocks map;
> +		pgoff_t next_pgofs;
> +
> +		memset(&map, 0, sizeof(map));
> +		map.m_lblk = cur_lblock;
> +		map.m_len = bytes_to_blks(inode, len) - cur_lblock;

map.m_len = last_lblock - cur_lblock;

> +		map.m_next_pgofs = &next_pgofs;

map.m_next_pgofs = NULL;
map.m_next_extent = NULL;

> +		map.m_seg_type = NO_CHECK_TYPE;

map.m_may_create = false;

> +
> +		ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
> +

Unneeded blank line.

> +		if (ret)
> +			goto err_out;
> +
> +		/* hole */
> +		if (!(map.m_flags & F2FS_MAP_FLAGS))

ret = -ENOENT;

> +			goto err_out;
> +
> +		pblock = map.m_pblk;
> +		nr_pblocks = map.m_len;
> +
> +		if ((pblock - main_blkaddr) & (blocks_per_sec - 1) ||
> +			nr_pblocks & (blocks_per_sec - 1))

ret = -EINVAL;

> +			goto err_out;
> +
> +		cur_lblock += nr_pblocks;
> +	}
> +
> +	return 0;
> +err_out:
> +	pr_err("swapon: swapfile isn't section-aligned\n");

We should show above message only after we fail in check condition:

	if ((pblock - main_blkaddr) & (blocks_per_sec - 1) ||
		nr_pblocks & (blocks_per_sec - 1)) {
		f2fs_err(sbi, "Swapfile does not align to section");
		goto err_out;
	}

And please use f2fs_{err,warn,info..} macro rather than pr_{err,warn,info..}.

Could you please fix above related issues in check_swap_activate_fast() as well.

> +	return -EINVAL;

return ret;

> +}
> +
>   static int check_swap_activate_fast(struct swap_info_struct *sis,
>   				struct file *swap_file, sector_t *span)
>   {
>   	struct address_space *mapping = swap_file->f_mapping;
>   	struct inode *inode = mapping->host;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	sector_t cur_lblock;
>   	sector_t last_lblock;
>   	sector_t pblock;
> @@ -3793,6 +3845,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
>   	sector_t highest_pblock = 0;
>   	int nr_extents = 0;
>   	unsigned long nr_pblocks;
> +	unsigned int blocks_per_sec = sbi->blocks_per_seg * sbi->segs_per_sec;

Ditto,

>   	u64 len;
>   	int ret;
>   
> @@ -3827,6 +3880,13 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
>   		pblock = map.m_pblk;
>   		nr_pblocks = map.m_len;
>   
> +		if ((pblock - SM_I(sbi)->main_blkaddr) & (blocks_per_sec - 1) ||
> +			nr_pblocks & (blocks_per_sec - 1)) {
> +			pr_err("swapon: swapfile isn't section-aligned\n");

Ditto,

> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
>   		if (cur_lblock + nr_pblocks >= sis->max)
>   			nr_pblocks = sis->max - cur_lblock;
>   
> @@ -3878,6 +3938,9 @@ static int check_swap_activate(struct swap_info_struct *sis,
>   	if (PAGE_SIZE == F2FS_BLKSIZE)
>   		return check_swap_activate_fast(sis, swap_file, span);
>   
> +	if (f2fs_check_file_aligned(inode))

ret = f2fs_check_file_aligned();
if (ret)
	return ret;

Thanks,

> +		return -EINVAL;
> +
>   	blocks_per_page = bytes_to_blks(inode, PAGE_SIZE);
>   
>   	/*
> 
