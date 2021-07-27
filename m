Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510B83D72F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhG0KTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:19:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236303AbhG0KTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:19:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C3D161529;
        Tue, 27 Jul 2021 10:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627381152;
        bh=Fdsa4sSlTEdolf4YyPr9QUc/UAI4GX3r8iZ7QTaseiY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OuCNkzhPt9jE3hPOfZNBGQ2Gm7IHWHh3VO9r7aGmZA2a6B6Dvl6qKG9Y+y69ryBbw
         4AL5iA9/ukNifR4jcaXWCa3Q6JU1YCI3EnpRpq2R1LlXJWSZh0kFujHswcqgyrIai2
         zio1sOzGpiVFp8dnxWx91qug65KSzCnq/F4lm8PhLe7ZthKKOak/lrNB6na7z4M3wB
         0mrD1wtRs+9h89hlXm/TPYH7IllGZj1bZkXk7Dqf3DehHiasMoRLpXSWHQ5Gm4HuqF
         kqdvYyQBUi80eWyBeOo/Xp9mFfVCIHRgQ7QmX/3mpJw5nSb5qUZkuOBVWXOYAkTdQ9
         A0lcIVgb/FNMA==
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: change fiemap way in printing
 compression chunk
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@google.com>
References: <20210726041819.2059593-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <f9555521-8878-2d46-36f1-3032bb8bbc0a@kernel.org>
Date:   Tue, 27 Jul 2021 18:19:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726041819.2059593-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/26 12:18, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When we print out a discontinuous compression chunk, it shows like a
> continuous chunk now. To show it more correctly, I've changed the way of
> printing fiemap info like below. Plus, eliminated NEW_ADDR(-1) in fiemap
> info, since it is not in fiemap user api manual.
> 
> Let's assume 16KB compression cluster.
> 
> <before>
>     Logical          Physical         Length           Flags
> 0:  0000000000000000 00000002c091f000 0000000000004000 1008
> 1:  0000000000004000 00000002c0920000 0000000000004000 1008
>    ...
> 9:  0000000000034000 0000000f8c623000 0000000000004000 1008
> 10: 0000000000038000 000000101a6eb000 0000000000004000 1008
> 
> <after>
> 0:  0000000000000000 00000002c091f000 0000000000004000 1008
> 1:  0000000000004000 00000002c0920000 0000000000004000 1008
>    ...
> 9:  0000000000034000 0000000f8c623000 0000000000001000 1008
> 10: 0000000000035000 000000101a6ea000 0000000000003000 1008
> 11: 0000000000038000 000000101a6eb000 0000000000002000 1008
> 12: 000000000003a000 00000002c3544000 0000000000002000 1008
> 
> Flags
> 0x1000 => FIEMAP_EXTENT_MERGED
> 0x0008 => FIEMAP_EXTENT_ENCODED
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Tested-by: Eric Biggers <ebiggers@google.com>
> 
> ---
> v4: initialized count_in_cluster
> v3: fix the missing last extent flag issue
> v2: changed the print format
> ---
>   fs/f2fs/data.c | 75 ++++++++++++++++++++++++++++----------------------
>   1 file changed, 42 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 3a01a1b50104..1a716c3b5457 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1843,8 +1843,9 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   	u64 logical = 0, phys = 0, size = 0;
>   	u32 flags = 0;
>   	int ret = 0;
> -	bool compr_cluster = false;
> +	bool compr_cluster = false, compr_appended;
>   	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
> +	unsigned int count_in_cluster = 0;
>   	loff_t maxbytes;
>   
>   	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
> @@ -1892,15 +1893,17 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   	map.m_next_pgofs = &next_pgofs;
>   	map.m_seg_type = NO_CHECK_TYPE;
>   
> -	if (compr_cluster)
> -		map.m_len = cluster_size - 1;
> +	if (compr_cluster) {
> +		map.m_lblk += 1;
> +		map.m_len = cluster_size - count_in_cluster;
> +	}
>   
>   	ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
>   	if (ret)
>   		goto out;
>   
>   	/* HOLE */
> -	if (!(map.m_flags & F2FS_MAP_FLAGS)) {
> +	if (!compr_cluster && !(map.m_flags & F2FS_MAP_FLAGS)) {
>   		start_blk = next_pgofs;
>   
>   		if (blks_to_bytes(inode, start_blk) < blks_to_bytes(inode,
> @@ -1910,6 +1913,14 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   		flags |= FIEMAP_EXTENT_LAST;
>   	}
>   
> +	compr_appended = false;
> +	/* In a case of compressed cluster, append this to the last extent */
> +	if (compr_cluster && ((map.m_flags & F2FS_MAP_UNWRITTEN) ||
> +			!(map.m_flags & F2FS_MAP_FLAGS))) {
> +		compr_appended = true;
> +		goto skip_fill;
> +	}
> +
>   	if (size) {
>   		flags |= FIEMAP_EXTENT_MERGED;
>   		if (IS_ENCRYPTED(inode))
> @@ -1926,38 +1937,36 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   	if (start_blk > last_blk)
>   		goto out;
>   
> -	if (compr_cluster) {
> -		compr_cluster = false;
> -
> -
> -		logical = blks_to_bytes(inode, start_blk - 1);
> -		phys = blks_to_bytes(inode, map.m_pblk);
> -		size = blks_to_bytes(inode, cluster_size);
> -
> -		flags |= FIEMAP_EXTENT_ENCODED;
> -
> -		start_blk += cluster_size - 1;
> -
> -		if (start_blk > last_blk)
> -			goto out;
> -
> -		goto prep_next;
> -	}
> -
> +skip_fill:
>   	if (map.m_pblk == COMPRESS_ADDR) {

Looks good, but one more thing I concern is how about detecting and
returning -EFSCORRUPTED for below corrupted metadata cases:
- [COMPRESS_ADDR, blkaddr, COMPRESS_ADDR, NEW_ADDR]
- [blkaddr, COMPRESS_ADDR, NULL_ADDR, NULL_ADDR]

Thanks,

>   		compr_cluster = true;
> -		start_blk++;
> -		goto prep_next;
> -	}
> -
> -	logical = blks_to_bytes(inode, start_blk);
> -	phys = blks_to_bytes(inode, map.m_pblk);
> -	size = blks_to_bytes(inode, map.m_len);
> -	flags = 0;
> -	if (map.m_flags & F2FS_MAP_UNWRITTEN)
> -		flags = FIEMAP_EXTENT_UNWRITTEN;
> +		count_in_cluster = 1;
> +	} else if (compr_appended) {
> +		unsigned int appended_blks = cluster_size -
> +						count_in_cluster + 1;
> +		size += blks_to_bytes(inode, appended_blks);
> +		start_blk += appended_blks;
> +		compr_cluster = false;
> +	} else {
> +		logical = blks_to_bytes(inode, start_blk);
> +		phys = __is_valid_data_blkaddr(map.m_pblk) ?
> +			blks_to_bytes(inode, map.m_pblk) : 0;
> +		size = blks_to_bytes(inode, map.m_len);
> +		flags = 0;
> +
> +		if (compr_cluster) {
> +			flags = FIEMAP_EXTENT_ENCODED;
> +			count_in_cluster += map.m_len;
> +			if (count_in_cluster == cluster_size) {
> +				compr_cluster = false;
> +				size += blks_to_bytes(inode, 1);
> +			}
> +		} else if (map.m_flags & F2FS_MAP_UNWRITTEN) {
> +			flags = FIEMAP_EXTENT_UNWRITTEN;
> +		}
>   
> -	start_blk += bytes_to_blks(inode, size);
> +		start_blk += bytes_to_blks(inode, size);
> +	}
>   
>   prep_next:
>   	cond_resched();
> 
