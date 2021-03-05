Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B994632E261
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 07:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhCEGld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 01:41:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhCEGlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 01:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614926491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JnmAd/cAWPZB1mz8gyad2diGqBlDPO14Y3hGtx+7soo=;
        b=fOYiAyBBsNNINZ+dQhjbK9bclbweX55Gkly3do0t0GFSsNNmeswIkks6XC7H/VCiGDwF4F
        /ekbUBJhC08zQ9XW9lK8ZJNyYDjie8/uTpcAYw9PHz46f3D9xdShtfg4Y8ersLG4dsQRb1
        YB8vMbJi1gy7Za5rvRr56ySX+5phJbI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-65aD7sb5NnKN1ICUU05nWA-1; Fri, 05 Mar 2021 01:41:29 -0500
X-MC-Unique: 65aD7sb5NnKN1ICUU05nWA-1
Received: by mail-pg1-f197.google.com with SMTP id f7so649523pgp.19
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 22:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JnmAd/cAWPZB1mz8gyad2diGqBlDPO14Y3hGtx+7soo=;
        b=WCaS0l4WhFHEVNr+kimJixryuveK5g7E2nkZMGChhWnEKUzOPMahyTcC8e0cugpbK5
         2YrEUvyxOwINKQZHXREFbKCFaD4XreUEHq8a5qwdbfEWz2qMS+mgIzaPzAKV+JDLDCWe
         BITa0tnB4quZdbxRbHBTTKgIJ19sEvKKdt19n4wRaJQAFYzmh7lHjelxb0reIEjunYc0
         7dXn+yn/NUp/XVG3gRfspF9Yv4pfe5Moudp1EZ0UDSsSLDV4pyvmIptoC9W1f0fcK9m3
         CkfT2Giiuq2YhZwjkvTwsFmSQsAUpSYDMBo+nfgs9THDGVR+0hq5/KIVBR53qDOhOw0s
         1c9g==
X-Gm-Message-State: AOAM532/NMY31E7plOqzSaWuAr30oFR5fTxARY8TBSHVKjb+csSVgNdW
        yorA5jpKZLRDL/XSyrvzHqYztOPyDOuO4gK8/GMWxafVNay21js6bRiq9FDlEnNSRLWy4rUGmCz
        R8t2enJYmkR80N3fKE/Zx3DAc
X-Received: by 2002:a65:6209:: with SMTP id d9mr6740461pgv.206.1614926488626;
        Thu, 04 Mar 2021 22:41:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxC7frt3RFKJdsozBuny+luFPIDt4luub4tK+4JtOYyAspsCezfpvpM0F+OfJ9Kwgx/Xz3Gaw==
X-Received: by 2002:a65:6209:: with SMTP id d9mr6740443pgv.206.1614926488308;
        Thu, 04 Mar 2021 22:41:28 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 144sm1279435pgd.83.2021.03.04.22.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 22:41:28 -0800 (PST)
Date:   Fri, 5 Mar 2021 14:41:17 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        guoweichao@oppo.com, zhangshiming@oppo.com
Subject: Re: [PATCH 2/2] erofs: decompress in endio if possible
Message-ID: <20210305064117.GA3093390@xiangao.remote.csb>
References: <20210305062219.557128-1-huangjianan@oppo.com>
 <20210305062219.557128-2-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210305062219.557128-2-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 02:22:19PM +0800, Huang Jianan via Linux-erofs wrote:
> z_erofs_decompressqueue_endio may not be executed in the interrupt
> context, for example, when dm-verity is turned on. In this scenario,
> io should be decompressed directly to avoid additional scheduling
> overhead. Also there is no need to wait for endio to execute
> synchronous decompression.

z_erofs_decompressqueue_endio may not be executed in the atomic
context, for example, when dm-verity is turned on. In this scenario,
data can be decompressed directly to get rid of additional kworker
scheduling overhead. Also, it makes no sense to apply synchronous
decompression for such case.

> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>  fs/erofs/internal.h |   3 ++
>  fs/erofs/super.c    |   1 +
>  fs/erofs/zdata.c    | 102 ++++++++++++++++++++++++--------------------
>  3 files changed, 60 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 77965490dced..a19bcbb681fc 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -71,6 +71,9 @@ struct erofs_sb_info {
>  	/* pseudo inode to manage cached pages */
>  	struct inode *managed_cache;
>  
> +	/* decide whether to decompress synchronously */
> +	bool sync_decompress;

bool readahead_sync_decompress;

> +
>  	/* # of pages needed for EROFS lz4 rolling decompression */
>  	u16 lz4_max_distance_pages;
>  #endif	/* CONFIG_EROFS_FS_ZIP */
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 37f1cc9d28cc..5b9a21d10a30 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -188,6 +188,7 @@ static int erofs_read_superblock(struct super_block *sb)
>  		goto out;
>  	}
>  
> +	sbi->sync_decompress = false;

Ah, could you rebase the patch on the top of 5.12-rc1
rather than dev-test? since I've fold your
"erofs: support adjust lz4 history window size"
into a new patchset, see:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/compr_cfgs

>  	/* parse on-disk compression configurations */
>  	z_erofs_load_lz4_config(sbi, dsb);
>  	ret = 0;
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 6cb356c4217b..727dd01f55c1 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -706,56 +706,11 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	goto out;
>  }
>  
> -static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> -				       bool sync, int bios)
> -{
> -	/* wake up the caller thread for sync decompression */
> -	if (sync) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&io->u.wait.lock, flags);
> -		if (!atomic_add_return(bios, &io->pending_bios))
> -			wake_up_locked(&io->u.wait);
> -		spin_unlock_irqrestore(&io->u.wait.lock, flags);
> -		return;
> -	}
> -
> -	if (!atomic_add_return(bios, &io->pending_bios))
> -		queue_work(z_erofs_workqueue, &io->u.work);
> -}

Is it necessary to move the code snippet?

> -
>  static bool z_erofs_page_is_invalidated(struct page *page)
>  {
>  	return !page->mapping && !z_erofs_is_shortlived_page(page);
>  }
>  
> -static void z_erofs_decompressqueue_endio(struct bio *bio)
> -{
> -	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
> -	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
> -	blk_status_t err = bio->bi_status;
> -	struct bio_vec *bvec;
> -	struct bvec_iter_all iter_all;
> -
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		struct page *page = bvec->bv_page;
> -
> -		DBG_BUGON(PageUptodate(page));
> -		DBG_BUGON(z_erofs_page_is_invalidated(page));
> -
> -		if (err)
> -			SetPageError(page);
> -
> -		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
> -			if (!err)
> -				SetPageUptodate(page);
> -			unlock_page(page);
> -		}
> -	}
> -	z_erofs_decompress_kickoff(q, tagptr_unfold_tags(t), -1);
> -	bio_put(bio);
> -}
> -
>  static int z_erofs_decompress_pcluster(struct super_block *sb,
>  				       struct z_erofs_pcluster *pcl,
>  				       struct list_head *pagepool)
> @@ -991,6 +946,60 @@ static void z_erofs_decompressqueue_work(struct work_struct *work)
>  	kvfree(bgq);
>  }
>  
> +static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> +				       bool sync, int bios)
> +{
> +	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
> +
> +	/* wake up the caller thread for sync decompression */
> +	if (sync) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&io->u.wait.lock, flags);
> +		if (!atomic_add_return(bios, &io->pending_bios))
> +			wake_up_locked(&io->u.wait);
> +		spin_unlock_irqrestore(&io->u.wait.lock, flags);
> +		return;
> +	}
> +
> +	if (!atomic_add_return(bios, &io->pending_bios)) {
> +		if (in_atomic() || irqs_disabled()) {
> +			queue_work(z_erofs_workqueue, &io->u.work);
> +			if (unlikely(!sbi->sync_decompress))
> +				sbi->sync_decompress = true;
> +		}
> +		else
> +			z_erofs_decompressqueue_work(&io->u.work);

Nit: coding style:

if () {
	...
} else {	this arm is needed.
	...
}

> +	}
> +}
> +
> +static void z_erofs_decompressqueue_endio(struct bio *bio)
> +{
> +	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
> +	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
> +	blk_status_t err = bio->bi_status;
> +	struct bio_vec *bvec;
> +	struct bvec_iter_all iter_all;
> +
> +	bio_for_each_segment_all(bvec, bio, iter_all) {
> +		struct page *page = bvec->bv_page;
> +
> +		DBG_BUGON(PageUptodate(page));
> +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> +
> +		if (err)
> +			SetPageError(page);
> +
> +		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
> +			if (!err)
> +				SetPageUptodate(page);
> +			unlock_page(page);
> +		}
> +	}
> +	z_erofs_decompress_kickoff(q, tagptr_unfold_tags(t), -1);
> +	bio_put(bio);
> +}
> +
>  static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
>  					       unsigned int nr,
>  					       struct list_head *pagepool,
> @@ -1333,7 +1342,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
>  	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
>  
>  	unsigned int nr_pages = readahead_count(rac);
> -	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages);
> +	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages) &
> +			sbi->sync_decompress;

it would be better written as:

bool sync = (sbi->readahead_sync_decompress &&
	     nr_pages <= sbi->ctx.max_sync_decompress_pages);

Thanks,
Gao Xiang

>  	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
>  	struct page *page, *head = NULL;
>  	LIST_HEAD(pagepool);
> -- 
> 2.25.1
> 

