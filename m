Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825A4372C4F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhEDOnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhEDOnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:43:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF68C613B4;
        Tue,  4 May 2021 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620139346;
        bh=5/y4t4rgPYKWP8Sygi6NZZixNOOrVT9vxB45I1DKOMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r505mmRs2qM2fN0TQebZUs0F9lhLXNGzDPzzcK34EqPsKKhdRAi0FS3JvWqr47OU+
         EsDMpjOspSwU9ob0isexPQyGzAhRqY3pn9pqdhkOtRYNeWz6uUVvAEUtQx1lwhTa0j
         rX7FpL3wjgAJyxzkmzkRe4RqXSCA5Gqi0x6aAd3lmMQ/JXXG65dSIyHbAT8rxtpcyx
         SYyK78Dc5lsBTEX4N+TLJ4FkCQE9GOl8yPRUyL2rdbhcN7NMPeD2EUi+9aVcBw2PSe
         EI5snYVosw/wqNLaaYrrww9mTrE829BXkPtcwcV9DO35PqNuGuAhrfwE2deEHhERr5
         /gmc8+p4S7fGw==
Date:   Tue, 4 May 2021 07:42:24 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v2] f2fs: compress: remove unneed check condition
Message-ID: <YJFdUEmYFba8sEKJ@google.com>
References: <20210427030730.90331-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427030730.90331-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

I split this into two patches along with upstreamed change.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test

Thanks,

On 04/27, Chao Yu wrote:
> This patch changes as below:
> - remove unneeded check condition in __cluster_may_compress()
> - rename __cluster_may_compress() to cluster_has_invalid_data() for
> better readability
> - add cp_error check in f2fs_write_compressed_pages() like we did
> in f2fs_write_single_data_page()
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - rename function for better readability
> - add cp_error check in f2fs_write_compressed_pages()
>  fs/f2fs/compress.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 6e46a00c1930..53f78befed8f 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -888,9 +888,8 @@ bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index)
>  	return is_page_in_cluster(cc, index);
>  }
>  
> -static bool __cluster_may_compress(struct compress_ctx *cc)
> +static bool cluster_has_invalid_data(struct compress_ctx *cc)
>  {
> -	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
>  	loff_t i_size = i_size_read(cc->inode);
>  	unsigned nr_pages = DIV_ROUND_UP(i_size, PAGE_SIZE);
>  	int i;
> @@ -898,18 +897,13 @@ static bool __cluster_may_compress(struct compress_ctx *cc)
>  	for (i = 0; i < cc->cluster_size; i++) {
>  		struct page *page = cc->rpages[i];
>  
> -		f2fs_bug_on(sbi, !page);
> -
> -		if (unlikely(f2fs_cp_error(sbi)))
> -			return false;
> -		if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> -			return false;
> +		f2fs_bug_on(F2FS_I_SB(cc->inode), !page);
>  
>  		/* beyond EOF */
>  		if (page->index >= nr_pages)
> -			return false;
> +			return true;
>  	}
> -	return true;
> +	return false;
>  }
>  
>  static int __f2fs_cluster_blocks(struct compress_ctx *cc, bool compr)
> @@ -985,7 +979,7 @@ static bool cluster_may_compress(struct compress_ctx *cc)
>  		return false;
>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(cc->inode))))
>  		return false;
> -	return __cluster_may_compress(cc);
> +	return !cluster_has_invalid_data(cc);
>  }
>  
>  static void set_cluster_writeback(struct compress_ctx *cc)
> @@ -1232,6 +1226,12 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  	loff_t psize;
>  	int i, err;
>  
> +	/* we should bypass data pages to proceed the kworkder jobs */
> +	if (unlikely(f2fs_cp_error(sbi))) {
> +		mapping_set_error(cc->rpages[0]->mapping, -EIO);
> +		goto out_free;
> +	}
> +
>  	if (IS_NOQUOTA(inode)) {
>  		/*
>  		 * We need to wait for node_write to avoid block allocation during
> -- 
> 2.29.2
