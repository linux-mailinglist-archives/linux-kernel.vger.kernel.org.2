Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C547C430A39
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbhJQPgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233403AbhJQPgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:36:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1FF560FE3;
        Sun, 17 Oct 2021 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634484865;
        bh=7jhb1Wyq+71lre1s9WFUWo2AkQ+YxR5/oFwXfQMBRiU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fALg7snTSGO37tNicCi6RLuwprnbPsfiJgJ6Z/x3bz12mRQqo46ty7lmUluvIh22P
         sxqcNLsQYB5XoUwyQ3gmkfyRL8yH9jbIutkw7uwZwW5FpkPPy0JwmMRaHsQ9S/rjsb
         /+LD3n7H0svgYVtt8/Kyo1a6fAj7OuS2PNko60zNyBbbrg3+O/X+ZS7EBT2WCTJcbT
         5aYLT9vQfM+jDgaavRUVaxJjFSxJ/fCzqyCyhke8f7XrrUlYxWUq7SpoCXel3Rg0U+
         SbMs3UHVZvadL34U0+aqS6YuGZ1ZN+rYEqZWnW51SwFjpSWeL7Ke19Ee3yr4He5zt/
         V4Ff2gaxCppIQ==
Message-ID: <8e39e5d1-285d-52b6-8fea-8bb9ff10bf5a@kernel.org>
Date:   Sun, 17 Oct 2021 23:34:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] erofs: introduce readmore decompression strategy
Content-Language: en-US
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20211008200839.24541-1-xiang@kernel.org>
 <20211008200839.24541-4-xiang@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211008200839.24541-4-xiang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/9 4:08, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Previously, the readahead window was strictly followed by EROFS
> decompression strategy in order to minimize extra memory footprint.
> However, it could become inefficient if just reading the partial
> requested data for much big LZ4 pclusters and the upcoming LZMA
> implementation.
> 
> Let's try to request the leading data in a pcluster without
> triggering memory reclaiming instead for the LZ4 approach first
> to boost up 100% randread of large big pclusters, and it has no real
> impact on low memory scenarios.
> 
> It also introduces a way to expand read lengths in order to decompress
> the whole pcluster, which is useful for LZMA since the algorithm
> itself is relatively slow and causes CPU bound, but LZ4 is not.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/internal.h | 13 ++++++
>   fs/erofs/zdata.c    | 99 ++++++++++++++++++++++++++++++++++++---------
>   2 files changed, 93 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 48bfc6eb2b02..7f96265ccbdb 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -307,6 +307,19 @@ static inline unsigned int erofs_inode_datalayout(unsigned int value)
>   			      EROFS_I_DATALAYOUT_BITS);
>   }
>   
> +/*
> + * Different from grab_cache_page_nowait(), reclaiming is never triggered
> + * when allocating new pages.
> + */
> +static inline
> +struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
> +					  pgoff_t index)
> +{
> +	return pagecache_get_page(mapping, index,
> +			FGP_LOCK|FGP_CREAT|FGP_NOFS|FGP_NOWAIT,
> +			readahead_gfp_mask(mapping) & ~__GFP_RECLAIM);
> +}
> +
>   extern const struct super_operations erofs_sops;
>   
>   extern const struct address_space_operations erofs_raw_access_aops;
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 5c34ef66677f..febb018e10a7 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1377,6 +1377,72 @@ static void z_erofs_runqueue(struct super_block *sb,
>   	z_erofs_decompress_queue(&io[JQ_SUBMIT], pagepool);
>   }
>   
> +/*
> + * Since partial uptodate is still unimplemented for now, we have to use
> + * approximate readmore strategies as a start.
> + */
> +static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
> +				      struct readahead_control *rac,
> +				      erofs_off_t end,
> +				      struct list_head *pagepool,
> +				      bool backmost)
> +{
> +	struct inode *inode = f->inode;
> +	struct erofs_map_blocks *map = &f->map;
> +	erofs_off_t cur;
> +	int err;
> +
> +	if (backmost) {
> +		map->m_la = end;
> +		/* TODO: pass in EROFS_GET_BLOCKS_READMORE for LZMA later */
> +		err = z_erofs_map_blocks_iter(inode, map, 0);
> +		if (err)
> +			return;
> +
> +		/* expend ra for the trailing edge if readahead */
> +		if (rac) {
> +			loff_t newstart = readahead_pos(rac);
> +
> +			cur = round_up(map->m_la + map->m_llen, PAGE_SIZE);
> +			readahead_expand(rac, newstart, cur - newstart);
> +			return;
> +		}
> +		end = round_up(end, PAGE_SIZE);
> +	} else {
> +		end = round_up(map->m_la, PAGE_SIZE);
> +
> +		if (!map->m_llen)
> +			return;
> +	}
> +
> +	cur = map->m_la + map->m_llen - 1;
> +	while (cur >= end) {
> +		pgoff_t index = cur >> PAGE_SHIFT;
> +		struct page *page;
> +
> +		page = erofs_grab_cache_page_nowait(inode->i_mapping, index);
> +		if (!page)
> +			goto skip;
> +
> +		if (PageUptodate(page)) {
> +			unlock_page(page);
> +			put_page(page);
> +			goto skip;
> +		}
> +
> +		err = z_erofs_do_read_page(f, page, pagepool);
> +		if (err)
> +			erofs_err(inode->i_sb,
> +				  "readmore error at page %lu @ nid %llu",
> +				  index, EROFS_I(inode)->nid);
> +		put_page(page);
> +skip:
> +		if (cur < PAGE_SIZE)
> +			break;
> +		cur = (index << PAGE_SHIFT) - 1;

Looks a little bit weird to readahead backward, any special reason here?

Thanks,

> +	}
> +}
> +
>   static int z_erofs_readpage(struct file *file, struct page *page)
>   {
>   	struct inode *const inode = page->mapping->host;
> @@ -1385,10 +1451,13 @@ static int z_erofs_readpage(struct file *file, struct page *page)
>   	LIST_HEAD(pagepool);
>   
>   	trace_erofs_readpage(page, false);
> -
>   	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
>   
> +	z_erofs_pcluster_readmore(&f, NULL, f.headoffset + PAGE_SIZE - 1,
> +				  &pagepool, true);
>   	err = z_erofs_do_read_page(&f, page, &pagepool);
> +	z_erofs_pcluster_readmore(&f, NULL, 0, &pagepool, false);
> +
>   	(void)z_erofs_collector_end(&f.clt);
>   
>   	/* if some compressed cluster ready, need submit them anyway */
> @@ -1409,29 +1478,20 @@ static void z_erofs_readahead(struct readahead_control *rac)
>   {
>   	struct inode *const inode = rac->mapping->host;
>   	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
> -
> -	unsigned int nr_pages = readahead_count(rac);
> -	bool sync = (sbi->ctx.readahead_sync_decompress &&
> -			nr_pages <= sbi->ctx.max_sync_decompress_pages);
>   	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
>   	struct page *page, *head = NULL;
> +	unsigned int nr_pages;
>   	LIST_HEAD(pagepool);
>   
> -	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
> -
>   	f.readahead = true;
>   	f.headoffset = readahead_pos(rac);
>   
> -	while ((page = readahead_page(rac))) {
> -		prefetchw(&page->flags);
> -
> -		/*
> -		 * A pure asynchronous readahead is indicated if
> -		 * a PG_readahead marked page is hitted at first.
> -		 * Let's also do asynchronous decompression for this case.
> -		 */
> -		sync &= !(PageReadahead(page) && !head);
> +	z_erofs_pcluster_readmore(&f, rac, f.headoffset +
> +				  readahead_length(rac) - 1, &pagepool, true);
> +	nr_pages = readahead_count(rac);
> +	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
>   
> +	while ((page = readahead_page(rac))) {
>   		set_page_private(page, (unsigned long)head);
>   		head = page;
>   	}
> @@ -1450,11 +1510,12 @@ static void z_erofs_readahead(struct readahead_control *rac)
>   				  page->index, EROFS_I(inode)->nid);
>   		put_page(page);
>   	}
> -
> +	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
>   	(void)z_erofs_collector_end(&f.clt);
>   
> -	z_erofs_runqueue(inode->i_sb, &f, &pagepool, sync);
> -
> +	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
> +			 sbi->ctx.readahead_sync_decompress &&
> +			 nr_pages <= sbi->ctx.max_sync_decompress_pages);
>   	if (f.map.mpage)
>   		put_page(f.map.mpage);
>   
> 
