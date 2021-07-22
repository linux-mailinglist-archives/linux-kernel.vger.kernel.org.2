Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8243D2703
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhGVPHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 11:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhGVPHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:07:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11B2C6100C;
        Thu, 22 Jul 2021 15:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626968897;
        bh=N+3UNY0ChTG0TW/Nyen5kYeSAGbhTDlwNe+vE04QuI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFH7KnaLSaq2l29PXug7JJ0ITGeHdZZ5IKs2bteKA9f4e/67EU+ZjBs8qt1+ujZrw
         hDGFmUdfO5pl0/RRCzmlhmx1Rm2b+94y5+LhF1k0Z/0C6H+gV3tyx7RFCwG1dAN9qF
         yNf1LE29kWBqCSGBC+mU22Q19c+BoOazDGE2yyL3TVM4kVjWUf3VyuIbpNnGtiN4ai
         m99x5SQewexWx5ZM+jG9Gp5a6y0ID3CywvTn4mMKyxxx9XRPNm6wanSnzQ4UOYufIU
         DTisWBGhJZcejO3uf5fkoAOn071VB+7U9Zj6W+auGLgDMPZx+es+M5CaQ8bBfm3zgl
         tNjTQFZPGKSBA==
Date:   Thu, 22 Jul 2021 08:48:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, Chao Yu <chao.yu@linux.dev>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: simplify accounting inflight directIO
 request
Message-ID: <YPmTP5EixgTp1Wze@gmail.com>
References: <20210722131617.749204-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722131617.749204-1-chao@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 09:16:17PM +0800, Chao Yu wrote:
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index ba120d55e9b1..d0a1ca6ae38e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1720,6 +1720,9 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
>  		map_bh(bh, inode->i_sb, map.m_pblk);
>  		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
>  		bh->b_size = blks_to_bytes(inode, map.m_len);
> +
> +		if (flag == F2FS_GET_BLOCK_DIO)
> +			bh->b_private = (void *)may_write;

Why is this hunk needed?

> +static int f2fs_dio_end_io(struct kiocb *iocb, loff_t offset,
> +					ssize_t bytes, void *private)
>  {
> -	struct f2fs_private_dio *dio = bio->bi_private;
> -
> -	dec_page_count(F2FS_I_SB(dio->inode),
> -			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
> -
> -	bio->bi_private = dio->orig_private;
> -	bio->bi_end_io = dio->orig_end_io;
> -
> -	kfree(dio);
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	bool may_write = private;
>  
> -	bio_endio(bio);
> +	dec_dio_req_count(F2FS_I_SB(inode), may_write ? WRITE : READ);
> +	return 0;
>  }
>  
>  static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
>  							loff_t file_offset)
>  {
> -	struct f2fs_private_dio *dio;
> -	bool write = (bio_op(bio) == REQ_OP_WRITE);
> -
> -	dio = f2fs_kzalloc(F2FS_I_SB(inode),
> -			sizeof(struct f2fs_private_dio), GFP_NOFS);
> -	if (!dio)
> -		goto out;
> -
> -	dio->inode = inode;
> -	dio->orig_end_io = bio->bi_end_io;
> -	dio->orig_private = bio->bi_private;
> -	dio->write = write;
> -
> -	bio->bi_end_io = f2fs_dio_end_io;
> -	bio->bi_private = dio;
> -
> -	inc_page_count(F2FS_I_SB(inode),
> -			write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
> +	inc_dio_req_count(F2FS_I_SB(inode),
> +			op_is_write(bio_op(bio)) ? WRITE : READ);
>  
>  	submit_bio(bio);
> -	return;
> -out:
> -	bio->bi_status = BLK_STS_IOERR;
> -	bio_endio(bio);
>  }

The inc and dec here aren't correctly paired, since f2fs_dio_submit_bio() is
called once per bio whereas f2fs_dio_end_io() is called when the entire direct
I/O request (which may have consisted of multiple bios) has completed.

The correct way to do this would be to do the inc before calling
__blockdev_direct_IO(), and do the dec in end_io or if __blockdev_direct_IO()
returned without actually issuing any I/O.

But I think you shouldn't bother with this part of the change before we switch
to iomap, as it will then need to be changed again anyway.

- Eric
