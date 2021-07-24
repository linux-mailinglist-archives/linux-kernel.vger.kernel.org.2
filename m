Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B637A3D442E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 03:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhGXAjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 20:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233298AbhGXAjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 20:39:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62FDC60BD3;
        Sat, 24 Jul 2021 01:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627089580;
        bh=XuV5KnrUXo2aL81IJRXJlswdfQPfCVDznQiZ16njytg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYZlAfs8Imf/WwWcREV2GuOkNRc1EaWGErOPIpnkvXdUzt2II7cnyKnXFBHDt9a7V
         kw/3zailYAn6jYb/GE4RObeREspwBkXVmOGNFLlMLb6uHUr4a4nttMPxrPQlFg9nTD
         xoosOepTzoOMMP84uqN8C80gE9HtiKuyLxQf4ClmOx1ivsAKmRaiBs6Y1B3YuKXC5C
         qqRpsaLmnA/ncoQBIdmrdBvL7pNvGUFuOl1VvJJrD1bTWQlgjj6HmPujHCBiE3+5ca
         gu7gg0X5qZwhbm3TfOKGKXL+lfS0NiLCUdmmjt4ufRLJqagj7qqnuDdAYbJ3kThxaH
         1Ffquhf0mnaqQ==
Date:   Fri, 23 Jul 2021 18:19:38 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v3] f2fs: change fiemap way in printing compression chunk
Message-ID: <YPtqqkocZPNoeiCu@google.com>
References: <20210723074928.1659385-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723074928.1659385-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23, Daeho Jeong wrote:
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
>    Logical          Physical         Length           Flags
> 0:  0000000000000000 00000002c091f000 0000000000004000 1008
> 1:  0000000000004000 00000002c0920000 0000000000004000 1008
>   ...
> 9:  0000000000034000 0000000f8c623000 0000000000004000 1008
> 10: 0000000000038000 000000101a6eb000 0000000000004000 1008
> 
> <after>
> 0:  0000000000000000 00000002c091f000 0000000000004000 1008
> 1:  0000000000004000 00000002c0920000 0000000000004000 1008
>   ...
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
> 
> ---
> v3: fix the missing last extent flag issue
> v2: changed the print format
> ---
>  fs/f2fs/data.c | 75 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 42 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 3a01a1b50104..29b09a74cdc9 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1843,8 +1843,9 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	u64 logical = 0, phys = 0, size = 0;
>  	u32 flags = 0;
>  	int ret = 0;
> -	bool compr_cluster = false;
> +	bool compr_cluster = false, compr_appended;
>  	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
> +	unsigned int count_in_cluster;

Can we initialize to 0, as compiler complains?

	unsigned int count_in_cluster = 0;

>  	loff_t maxbytes;
>  
>  	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
> @@ -1892,15 +1893,17 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	map.m_next_pgofs = &next_pgofs;
>  	map.m_seg_type = NO_CHECK_TYPE;
>  
> -	if (compr_cluster)
> -		map.m_len = cluster_size - 1;
> +	if (compr_cluster) {
> +		map.m_lblk += 1;
> +		map.m_len = cluster_size - count_in_cluster;
> +	}
>  
>  	ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
>  	if (ret)
>  		goto out;
>  
>  	/* HOLE */
> -	if (!(map.m_flags & F2FS_MAP_FLAGS)) {
> +	if (!compr_cluster && !(map.m_flags & F2FS_MAP_FLAGS)) {
>  		start_blk = next_pgofs;
>  
>  		if (blks_to_bytes(inode, start_blk) < blks_to_bytes(inode,
> @@ -1910,6 +1913,14 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		flags |= FIEMAP_EXTENT_LAST;
>  	}
>  
> +	compr_appended = false;
> +	/* In a case of compressed cluster, append this to the last extent */
> +	if (compr_cluster && ((map.m_flags & F2FS_MAP_UNWRITTEN) ||
> +			!(map.m_flags & F2FS_MAP_FLAGS))) {
> +		compr_appended = true;
> +		goto skip_fill;
> +	}
> +
>  	if (size) {
>  		flags |= FIEMAP_EXTENT_MERGED;
>  		if (IS_ENCRYPTED(inode))
> @@ -1926,38 +1937,36 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	if (start_blk > last_blk)
>  		goto out;
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
>  	if (map.m_pblk == COMPRESS_ADDR) {
>  		compr_cluster = true;
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
>  prep_next:
>  	cond_resched();
> -- 
> 2.32.0.432.gabb21c7263-goog
