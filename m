Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89FE446E0E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 14:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhKFNaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 09:30:01 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:38995 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233692AbhKFN37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 09:29:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UvIHVwt_1636205234;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UvIHVwt_1636205234)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 06 Nov 2021 21:27:16 +0800
Date:   Sat, 6 Nov 2021 21:27:11 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <huyue2@yulong.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, zhangwen@yulong.com,
        geshifei@yulong.com, zbestahu@gmail.com
Subject: Re: [PATCH v2] erofs: remove useless cache strategy of DELAYEDALLOC
Message-ID: <YYaCr9YgK1I91MXX@B-P7TQMD6M-0146.local>
References: <20211106082315.25781-1-huyue2@yulong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211106082315.25781-1-huyue2@yulong.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

On Sat, Nov 06, 2021 at 04:23:15PM +0800, Yue Hu wrote:
> DELAYEDALLOC is not used at all, remove related dead code. Also,
> remove the blank line at the end of zdata.h.

I'll update the commit message to:

After commit 1825c8d7ce93 ("erofs: force inplace I/O under low
memory scenario") and TRYALLOC is widely used, DELAYEDALLOC won't
be used anymore. Remove related dead code. Also, remove the blank
line at the end of zdata.h.

> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
> v2: remove the blank line at the end of zdata.h.
> 
>  fs/erofs/zdata.c | 20 --------------------
>  fs/erofs/zdata.h |  1 -
>  2 files changed, 21 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index bcb1b91b234f..812c7c6ae456 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -96,16 +96,9 @@ static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
>  	DBG_BUGON(1);
>  }
>  
> -/*
> - * a compressed_pages[] placeholder in order to avoid
> - * being filled with file pages for in-place decompression.
> - */
> -#define PAGE_UNALLOCATED     ((void *)0x5F0E4B1D)
> -
>  /* how to allocate cached pages for a pcluster */
>  enum z_erofs_cache_alloctype {
>  	DONTALLOC,	/* don't allocate any cached pages */
> -	DELAYEDALLOC,	/* delayed allocation (at the time of submitting io) */
>  	/*
>  	 * try to use cached I/O if page allocation succeeds or fallback
>  	 * to in-place I/O instead to avoid any direct reclaim.
> @@ -267,10 +260,6 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
>  			/* I/O is needed, no possible to decompress directly */
>  			standalone = false;
>  			switch (type) {
> -			case DELAYEDALLOC:
> -				t = tagptr_init(compressed_page_t,
> -						PAGE_UNALLOCATED);
> -				break;
>  			case TRYALLOC:
>  				newpage = erofs_allocpage(pagepool, gfp);
>  				if (!newpage)
> @@ -1089,15 +1078,6 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
>  	if (!page)
>  		goto out_allocpage;
>  
> -	/*
> -	 * the cached page has not been allocated and
> -	 * an placeholder is out there, prepare it now.
> -	 */
> -	if (page == PAGE_UNALLOCATED) {
> -		tocache = true;
> -		goto out_allocpage;
> -	}
> -
>  	/* process the target tagged pointer */
>  	t = tagptr_init(compressed_page_t, page);
>  	justfound = tagptr_unfold_tags(t);
> diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
> index 879df5362777..4a69515dea75 100644
> --- a/fs/erofs/zdata.h
> +++ b/fs/erofs/zdata.h
> @@ -179,4 +179,3 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
>  #define Z_EROFS_VMAP_GLOBAL_PAGES	2048
>  
>  #endif
> -
> -- 
> 2.17.1
> 
> 
