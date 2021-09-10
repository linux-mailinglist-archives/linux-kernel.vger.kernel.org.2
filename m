Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE01407334
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 00:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhIJWFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 18:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234722AbhIJWFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 18:05:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ED4061205;
        Fri, 10 Sep 2021 22:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631311480;
        bh=3JR8G3EKcM2k1RFRog8eh3eVWwB/J9K7BivJ3sbD6Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXtSl/ycaBYktotlT+4ORlnv9Z/qUhP8nqLgQqNpHQCYecWW9SXSgOrA3aBgs/IzV
         yuL9gfu2EAGOnSVqMhX90a0ncfB8j8/o/atzmEB0X+8XmtUrUg2SCz68tXEBS42CN0
         8DS+9RYF4U26ECgR8dkFqmn0Abzmx1ULUlfPJVbT8kG4r51mQMDN616BcNtBOEjF7f
         Gh6Czd8Vde8jG6UVaVYs0gVES3N+YP4BhwfJKBtL/VObV7iHgHJiLMbZ2DOjUHjpn4
         hXjtl5+BqedzDumhRn9gcp4iigvEZV+JXpu69KOX5xm5Hvd0cmhSWQK2qP2nRCgGbe
         TPb4iLOOXqplQ==
Date:   Fri, 10 Sep 2021 15:04:39 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
Subject: Re: [PATCH] f2fs: introduce excess_dirty_threshold()
Message-ID: <YTvWd1/EzwFu6I4T@google.com>
References: <20210901073232.109355-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901073232.109355-1-chao@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01, Chao Yu wrote:
> This patch enables f2fs_balance_fs_bg() to check all metadatas' dirty
> threshold rather than just checking node block's, so that checkpoint()
> from background can be triggered more frequently to avoid heaping up
> too much dirty metadatas.
> 
> Threshold value by default:
> race with foreground ops	single type	global
> No				16MB		24MB
> Yes				24MB		36MB
> 
> In addtion, let f2fs_balance_fs_bg() be aware of roll-forward sapce
> as well as fsync().
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h    |  3 +++
>  fs/f2fs/node.h    |  5 -----
>  fs/f2fs/segment.c | 23 +++++++++++++++++++++--
>  3 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 6c5e75f86da4..5ae2ca6dba96 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -562,6 +562,9 @@ enum {
>  
>  #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
>  
> +/* dirty segments threshold for triggering CP */
> +#define DEFAULT_DIRTY_THRESHOLD		4
> +
>  /* for in-memory extent cache entry */
>  #define F2FS_MIN_EXTENT_LEN	64	/* minimum extent length */
>  
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index ff14a6e5ac1c..18b98cf0465b 100644
> --- a/fs/f2fs/node.h
> +++ b/fs/f2fs/node.h
> @@ -138,11 +138,6 @@ static inline bool excess_cached_nats(struct f2fs_sb_info *sbi)
>  	return NM_I(sbi)->nat_cnt[TOTAL_NAT] >= DEF_NAT_CACHE_THRESHOLD;
>  }
>  
> -static inline bool excess_dirty_nodes(struct f2fs_sb_info *sbi)
> -{
> -	return get_pages(sbi, F2FS_DIRTY_NODES) >= sbi->blocks_per_seg * 8;
> -}
> -
>  enum mem_type {
>  	FREE_NIDS,	/* indicates the free nid list */
>  	NAT_ENTRIES,	/* indicates the cached nat entry */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 7358342652ec..ffd148429a9d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -535,6 +535,25 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
>  	}
>  }
>  
> +static inline bool excess_dirty_threshold(struct f2fs_sb_info *sbi)
> +{
> +	int factor = rwsem_is_locked(&sbi->cp_rwsem) ? 3 : 2;
> +	unsigned int dents = get_pages(sbi, F2FS_DIRTY_DENTS);
> +	unsigned int qdata = get_pages(sbi, F2FS_DIRTY_QDATA);
> +	unsigned int nodes = get_pages(sbi, F2FS_DIRTY_NODES);
> +	unsigned int meta = get_pages(sbi, F2FS_DIRTY_META);
> +	unsigned int imeta = get_pages(sbi, F2FS_DIRTY_IMETA);
> +	unsigned int threshold = sbi->blocks_per_seg * factor *
> +					DEFAULT_DIRTY_THRESHOLD;
> +	unsigned int global_threshold = threshold * 3 / 2;
> +
> +	if (dents >= threshold || qdata >= threshold ||
> +		nodes >= threshold || meta >= threshold ||
> +		imeta >= threshold)
> +		return true;
> +	return dents + qdata + nodes + meta + imeta >  global_threshold;
> +}
> +
>  void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
>  {
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> @@ -553,8 +572,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
>  	else
>  		f2fs_build_free_nids(sbi, false, false);
>  
> -	if (excess_dirty_nats(sbi) || excess_dirty_nodes(sbi) ||
> -		excess_prefree_segs(sbi))
> +	if (excess_dirty_nats(sbi) || excess_dirty_threshold(sbi) ||
> +		excess_prefree_segs(sbi) || f2fs_space_for_roll_forward(sbi))

f2fs_space_for_roll_forward() == 0?


>  		goto do_sync;
>  
>  	/* there is background inflight IO or foreground operation recently */
> -- 
> 2.32.0
