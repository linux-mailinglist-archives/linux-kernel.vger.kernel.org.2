Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B793412A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 03:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhCSCPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 22:15:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13199 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhCSCP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 22:15:26 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F1nVK65MjzmXLp;
        Fri, 19 Mar 2021 10:12:57 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 19 Mar
 2021 10:15:19 +0800
Subject: Re: [PATCH v2] erofs: fix bio->bi_max_vecs behavior change
To:     Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Gao Xiang <hsiangkao@redhat.com>,
        "Martin DEVERA" <devik@eaxlabs.cz>
References: <20210306033109.28466-1-hsiangkao@aol.com>
 <20210306040438.8084-1-hsiangkao@aol.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <dffa941d-63b5-2068-80f4-dd012f520147@huawei.com>
Date:   Fri, 19 Mar 2021 10:15:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210306040438.8084-1-hsiangkao@aol.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/6 12:04, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> Martin reported an issue that directory read could be hung on the
> latest -rc kernel with some certain image. The root cause is that
> commit baa2c7c97153 ("block: set .bi_max_vecs as actual allocated
> vector number") changes .bi_max_vecs behavior. bio->bi_max_vecs
> is set as actual allocated vector number rather than the requested
> number now.
> 
> Let's avoid using .bi_max_vecs completely instead.
> 
> Reported-by: Martin DEVERA <devik@eaxlabs.cz>
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> ---
> change since v1:
>   - since bio->bi_max_vecs doesn't record extent blocks anymore,
>     introduce a remaining extent block to avoid extent excess.
> 
>   fs/erofs/data.c | 28 +++++++++++-----------------
>   1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index f88851c5c250..1249e74b3bf0 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -129,6 +129,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>   					      struct page *page,
>   					      erofs_off_t *last_block,
>   					      unsigned int nblocks,
> +					      unsigned int *eblks,
>   					      bool ra)
>   {
>   	struct inode *const inode = mapping->host;
> @@ -145,8 +146,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>   
>   	/* note that for readpage case, bio also equals to NULL */
>   	if (bio &&
> -	    /* not continuous */
> -	    *last_block + 1 != current_block) {
> +	    (*last_block + 1 != current_block || !*eblks)) {

Xiang,

I found below function during checking bi_max_vecs usage in f2fs:

/**
  * bio_full - check if the bio is full
  * @bio:        bio to check
  * @len:        length of one segment to be added
  *
  * Return true if @bio is full and one segment with @len bytes can't be
  * added to the bio, otherwise return false
  */
static inline bool bio_full(struct bio *bio, unsigned len)
{
         if (bio->bi_vcnt >= bio->bi_max_vecs)
                 return true;

         if (bio->bi_iter.bi_size > UINT_MAX - len)
                 return true;

         return false;
}

Could you please check that whether it will be better to use bio_full()
rather than using left-space-in-bio maintained by erofs itself? something
like:

if (bio && (bio_full(bio, PAGE_SIZE) ||
	/* not continuous */
	(*last_block + 1 != current_block))

I'm thinking we need to decouple bio detail implementation as much as
possible, to avoid regression whenever bio used/max size definition
updates, though I've no idea how to fix f2fs case.

Let me know if you have other concern.

Thanks,

>   submit_bio_retry:
>   		submit_bio(bio);
>   		bio = NULL;
> @@ -216,7 +216,8 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>   		if (nblocks > DIV_ROUND_UP(map.m_plen, PAGE_SIZE))
>   			nblocks = DIV_ROUND_UP(map.m_plen, PAGE_SIZE);
>   
> -		bio = bio_alloc(GFP_NOIO, bio_max_segs(nblocks));
> +		*eblks = bio_max_segs(nblocks);
> +		bio = bio_alloc(GFP_NOIO, *eblks);
>   
>   		bio->bi_end_io = erofs_readendio;
>   		bio_set_dev(bio, sb->s_bdev);
> @@ -229,16 +230,8 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>   	/* out of the extent or bio is full */
>   	if (err < PAGE_SIZE)
>   		goto submit_bio_retry;
> -
> +	--*eblks;
>   	*last_block = current_block;
> -
> -	/* shift in advance in case of it followed by too many gaps */
> -	if (bio->bi_iter.bi_size >= bio->bi_max_vecs * PAGE_SIZE) {
> -		/* err should reassign to 0 after submitting */
> -		err = 0;
> -		goto submit_bio_out;
> -	}
> -
>   	return bio;
>   
>   err_out:
> @@ -252,7 +245,6 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>   
>   	/* if updated manually, continuous pages has a gap */
>   	if (bio)
> -submit_bio_out:
>   		submit_bio(bio);
>   	return err ? ERR_PTR(err) : NULL;
>   }
> @@ -264,23 +256,26 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>   static int erofs_raw_access_readpage(struct file *file, struct page *page)
>   {
>   	erofs_off_t last_block;
> +	unsigned int eblks;
>   	struct bio *bio;
>   
>   	trace_erofs_readpage(page, true);
>   
>   	bio = erofs_read_raw_page(NULL, page->mapping,
> -				  page, &last_block, 1, false);
> +				  page, &last_block, 1, &eblks, false);
>   
>   	if (IS_ERR(bio))
>   		return PTR_ERR(bio);
>   
> -	DBG_BUGON(bio);	/* since we have only one bio -- must be NULL */
> +	if (bio)
> +		submit_bio(bio);
>   	return 0;
>   }
>   
>   static void erofs_raw_access_readahead(struct readahead_control *rac)
>   {
>   	erofs_off_t last_block;
> +	unsigned int eblks;
>   	struct bio *bio = NULL;
>   	struct page *page;
>   
> @@ -291,7 +286,7 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
>   		prefetchw(&page->flags);
>   
>   		bio = erofs_read_raw_page(bio, rac->mapping, page, &last_block,
> -				readahead_count(rac), true);
> +				readahead_count(rac), &eblks, true);
>   
>   		/* all the page errors are ignored when readahead */
>   		if (IS_ERR(bio)) {
> @@ -305,7 +300,6 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
>   		put_page(page);
>   	}
>   
> -	/* the rare case (end in gaps) */
>   	if (bio)
>   		submit_bio(bio);
>   }
> 
