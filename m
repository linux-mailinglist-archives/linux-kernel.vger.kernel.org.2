Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CF93D1AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 02:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhGVAFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 20:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhGVAFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 20:05:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5B3161249;
        Thu, 22 Jul 2021 00:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626914787;
        bh=mz+LGLYopDu3grjmRh1FTALJXKcS5wBE1910DCuddj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qzsxEazLzBmEZ437kjht81tKYqZt/WeJh3+pXlm50qFk6gmVtVXBzuOEhN5P05tfM
         DzUGaqHxo5lS7zxHBOHFy5bnqtnzSZibKXI6NEwnWXDr8Ylsv+V5j+n7GEnqubPMtA
         mEKB5ZxjFQV5OJAJQxWf3oOTHOlKKq6aVkkczCWdFGn/vit/6EMtTbnfwddL8d0htB
         ZhEe3rE/RvYu74hnj6wUf9U76pJCglMFC2CIf7CtM5bMpJ71/Vkjl5Mzt34q9uW+Qp
         KhOQXb82I5SjUkJoHEVgBz8sFjJoc6Q4hjl/gI4nmUIFeay3BX0dkocLyPyihr5v9R
         D9g0UDm3lM5ow==
Date:   Wed, 21 Jul 2021 17:46:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, Chao Yu <chao.yu@linux.dev>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix wrong inflight page stats for
 directIO
Message-ID: <YPi/4kMUAhlRZV3M@sol.localdomain>
References: <20210719084548.25895-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719084548.25895-1-chao@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 04:45:48PM +0800, Chao Yu wrote:
> Previously, we use sbi->nr_pages[] to account direct IO, the count should
> be based on page granularity rather than bio granularity, fix it.
> 
> Fixes: 02b16d0a34a1 ("f2fs: add to account direct IO")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - There is one missing line when I reorder in development patches,
> so just resend the patch as v2, sorry.
>  fs/f2fs/data.c | 11 +++++++----
>  fs/f2fs/f2fs.h | 13 +++++++++++++
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index e6f107de4c92..095350ccf80d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3494,8 +3494,9 @@ static void f2fs_dio_end_io(struct bio *bio)
>  {
>  	struct f2fs_private_dio *dio = bio->bi_private;
>  
> -	dec_page_count(F2FS_I_SB(dio->inode),
> -			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
> +	dec_page_counts(F2FS_I_SB(dio->inode),
> +			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ,
> +			dio->blkcnt);
>  
>  	bio->bi_private = dio->orig_private;
>  	bio->bi_end_io = dio->orig_end_io;
> @@ -3510,6 +3511,7 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
>  {
>  	struct f2fs_private_dio *dio;
>  	bool write = (bio_op(bio) == REQ_OP_WRITE);
> +	unsigned int blkcnt = bio_sectors(bio) >> F2FS_LOG_SECTORS_PER_BLOCK;
>  
>  	dio = f2fs_kzalloc(F2FS_I_SB(inode),
>  			sizeof(struct f2fs_private_dio), GFP_NOFS);
> @@ -3519,13 +3521,14 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
>  	dio->inode = inode;
>  	dio->orig_end_io = bio->bi_end_io;
>  	dio->orig_private = bio->bi_private;
> +	dio->blkcnt = blkcnt;
>  	dio->write = write;
>  
>  	bio->bi_end_io = f2fs_dio_end_io;
>  	bio->bi_private = dio;
>  
> -	inc_page_count(F2FS_I_SB(inode),
> -			write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
> +	inc_page_counts(F2FS_I_SB(inode),
> +			write ? F2FS_DIO_WRITE : F2FS_DIO_READ, dio->blkcnt);
>  
>  	submit_bio(bio);
>  	return;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 867f2c5d9559..7369f8087f64 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1759,6 +1759,7 @@ struct f2fs_private_dio {
>  	struct inode *inode;
>  	void *orig_private;
>  	bio_end_io_t *orig_end_io;
> +	unsigned int blkcnt;
>  	bool write;
>  };
>  
> @@ -2267,6 +2268,12 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
>  		set_sbi_flag(sbi, SBI_IS_DIRTY);
>  }
>  
> +static inline void inc_page_counts(struct f2fs_sb_info *sbi, int count_type,
> +							unsigned int count)
> +{
> +	atomic_add(count, &sbi->nr_pages[count_type]);
> +}
> +
>  static inline void inode_inc_dirty_pages(struct inode *inode)
>  {
>  	atomic_inc(&F2FS_I(inode)->dirty_pages);
> @@ -2281,6 +2288,12 @@ static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
>  	atomic_dec(&sbi->nr_pages[count_type]);
>  }
>  
> +static inline void dec_page_counts(struct f2fs_sb_info *sbi, int count_type,
> +							unsigned int count)
> +{
> +	atomic_sub(count, &sbi->nr_pages[count_type]);
> +}
> +

Please give these proper names like add_to_page_count() and
sub_from_page_count().  They change one counter, not multiple.

- Eric
