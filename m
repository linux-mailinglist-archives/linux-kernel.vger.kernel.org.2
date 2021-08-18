Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD453F0E22
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 00:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhHRWaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 18:30:07 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41936 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232456AbhHRWaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 18:30:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UjqEgEW_1629325768;
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0UjqEgEW_1629325768)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Aug 2021 06:29:28 +0800
Date:   Thu, 19 Aug 2021 06:29:28 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Eryu Guan <eguan@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs: support reading chunk-based uncompressed files
Message-ID: <20210818222928.GB73193@rsjd01523.et2sqa>
Reply-To: bo.liu@linux.alibaba.com
References: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
 <20210818070713.4437-2-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818070713.4437-2-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 03:07:13PM +0800, Gao Xiang wrote:
> Add runtime support for chunk-based uncompressed files
> described in the previous patch.
>

Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
thanks,
liubo

> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/data.c     | 90 ++++++++++++++++++++++++++++++++++++++++-----
>  fs/erofs/inode.c    | 18 ++++++++-
>  fs/erofs/internal.h |  5 +++
>  3 files changed, 102 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index b2a22aabc9bc..78d625709481 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (C) 2017-2018 HUAWEI, Inc.
>   *             https://www.huawei.com/
> + * Copyright (C) 2021, Alibaba Cloud
>   */
>  #include "internal.h"
>  #include <linux/prefetch.h>
> @@ -37,13 +38,6 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
>  	lastblk = nblocks - tailendpacking;
>  
> -	if (offset >= inode->i_size) {
> -		/* leave out-of-bound access unmapped */
> -		map->m_flags = 0;
> -		map->m_plen = 0;
> -		goto out;
> -	}
> -
>  	/* there is no hole in flatmode */
>  	map->m_flags = EROFS_MAP_MAPPED;
>  
> @@ -78,14 +72,90 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  		goto err_out;
>  	}
>  
> -out:
>  	map->m_llen = map->m_plen;
> -
>  err_out:
>  	trace_erofs_map_blocks_flatmode_exit(inode, map, flags, 0);
>  	return err;
>  }
>  
> +static int erofs_map_blocks(struct inode *inode,
> +			    struct erofs_map_blocks *map, int flags)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct erofs_inode *vi = EROFS_I(inode);
> +	struct erofs_inode_chunk_index *idx;
> +	struct page *page;
> +	u64 chunknr;
> +	unsigned int unit;
> +	erofs_off_t pos;
> +	int err = 0;
> +
> +	if (map->m_la >= inode->i_size) {
> +		/* leave out-of-bound access unmapped */
> +		map->m_flags = 0;
> +		map->m_plen = 0;
> +		goto out;
> +	}
> +
> +	if (vi->datalayout != EROFS_INODE_CHUNK_BASED)
> +		return erofs_map_blocks_flatmode(inode, map, flags);
> +
> +	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
> +		unit = sizeof(*idx);	/* chunk index */
> +	else
> +		unit = 4;		/* block map */
> +
> +	chunknr = map->m_la >> vi->chunkbits;
> +	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
> +		    vi->xattr_isize, unit) + unit * chunknr;
> +
> +	page = erofs_get_meta_page(inode->i_sb, erofs_blknr(pos));
> +	if (IS_ERR(page))
> +		return PTR_ERR(page);
> +
> +	map->m_la = chunknr << vi->chunkbits;
> +	map->m_plen = min_t(erofs_off_t, 1UL << vi->chunkbits,
> +			    roundup(inode->i_size - map->m_la, EROFS_BLKSIZ));
> +
> +	/* handle block map */
> +	if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
> +		__le32 *blkaddr = page_address(page) + erofs_blkoff(pos);
> +
> +		if (le32_to_cpu(*blkaddr) == EROFS_NULL_ADDR) {
> +			map->m_flags = 0;
> +		} else {
> +			map->m_pa = blknr_to_addr(le32_to_cpu(*blkaddr));
> +			map->m_flags = EROFS_MAP_MAPPED;
> +		}
> +		goto out_unlock;
> +	}
> +	/* parse chunk indexes */
> +	idx = page_address(page) + erofs_blkoff(pos);
> +	switch (le32_to_cpu(idx->blkaddr)) {
> +	case EROFS_NULL_ADDR:
> +		map->m_flags = 0;
> +		break;
> +	default:
> +		/* only one device is supported for now */
> +		if (idx->device_id) {
> +			erofs_err(sb, "invalid device id %u @ %llu for nid %llu",
> +				  le32_to_cpu(idx->device_id),
> +				  chunknr, vi->nid);
> +			err = -EFSCORRUPTED;
> +			goto out_unlock;
> +		}
> +		map->m_pa = blknr_to_addr(le32_to_cpu(idx->blkaddr));
> +		map->m_flags = EROFS_MAP_MAPPED;
> +		break;
> +	}
> +out_unlock:
> +	unlock_page(page);
> +	put_page(page);
> +out:
> +	map->m_llen = map->m_plen;
> +	return err;
> +}
> +
>  static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
>  {
> @@ -95,7 +165,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	map.m_la = offset;
>  	map.m_llen = length;
>  
> -	ret = erofs_map_blocks_flatmode(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 92728da1d206..036a6cc97d10 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (C) 2017-2018 HUAWEI, Inc.
>   *             https://www.huawei.com/
> + * Copyright (C) 2021, Alibaba Cloud
>   */
>  #include "xattr.h"
>  
> @@ -122,7 +123,9 @@ static struct page *erofs_read_inode(struct inode *inode,
>  		/* total blocks for compressed files */
>  		if (erofs_inode_is_data_compressed(vi->datalayout))
>  			nblks = le32_to_cpu(die->i_u.compressed_blocks);
> -
> +		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
> +			/* fill chunked inode summary info */
> +			vi->chunkformat = __le16_to_cpu(die->i_u.c.format);
>  		kfree(copied);
>  		break;
>  	case EROFS_INODE_LAYOUT_COMPACT:
> @@ -160,6 +163,8 @@ static struct page *erofs_read_inode(struct inode *inode,
>  		inode->i_size = le32_to_cpu(dic->i_size);
>  		if (erofs_inode_is_data_compressed(vi->datalayout))
>  			nblks = le32_to_cpu(dic->i_u.compressed_blocks);
> +		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
> +			vi->chunkformat = __le16_to_cpu(dic->i_u.c.format);
>  		break;
>  	default:
>  		erofs_err(inode->i_sb,
> @@ -169,6 +174,17 @@ static struct page *erofs_read_inode(struct inode *inode,
>  		goto err_out;
>  	}
>  
> +	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
> +		if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_ALL)) {
> +			erofs_err(inode->i_sb,
> +				  "unsupported chunk format %x of nid %llu",
> +				  vi->chunkformat, vi->nid);
> +			err = -EOPNOTSUPP;
> +			goto err_out;
> +		}
> +		vi->chunkbits = LOG_BLOCK_SIZE +
> +			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
> +	}
>  	inode->i_mtime.tv_sec = inode->i_ctime.tv_sec;
>  	inode->i_atime.tv_sec = inode->i_ctime.tv_sec;
>  	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 25b094085ca6..0a46e149aadd 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (C) 2017-2018 HUAWEI, Inc.
>   *             https://www.huawei.com/
> + * Copyright (C) 2021, Alibaba Cloud
>   */
>  #ifndef __EROFS_INTERNAL_H
>  #define __EROFS_INTERNAL_H
> @@ -260,6 +261,10 @@ struct erofs_inode {
>  
>  	union {
>  		erofs_blk_t raw_blkaddr;
> +		struct {
> +			unsigned short	chunkformat;
> +			unsigned char	chunkbits;
> +		};
>  #ifdef CONFIG_EROFS_FS_ZIP
>  		struct {
>  			unsigned short z_advise;
> -- 
> 2.24.4
