Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F713AA831
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 02:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbhFQAja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 20:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhFQAj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 20:39:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9EED613B9;
        Thu, 17 Jun 2021 00:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623890241;
        bh=SXA3yBsohkpZT852yLw/Ew5Vyq6uE3A+kzcgpLwYHgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vc8kzuGfX+c2v/+HG4VJgoJs6jYqcGL6ybW7bKooIRoQeH9QVMMOiTw3vY4gCoK3W
         1S7ue3Nmv37xD6UmVlE27K1+dM7SSZvCu4DSvHP2lhdK9Ply04NfXIpiFW2tEuD2R3
         XCHEDjGkqGp9V9ieJwL4M006qQpUnZ0DPWZutnHTrJFczsXphj3u7nt2cMyVImJMwF
         iQcCgmaVpHaxye+AN8HBqvVYDjWgRHKsa8CVezI19MrtaFywilZ4xxvFy3lw8+L6EC
         KZO7asNI3GApZLy9Kn3Wu/5XfSglJVONa2hf+UYVQoN+O8UN6ytriKKRuiUKrd6LOQ
         Qmr9dYx0IJzcQ==
Date:   Wed, 16 Jun 2021 17:37:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 03/10] block: introduce bio_required_sector_alignment()
Message-ID: <YMqZQDezz9upYS8z@sol.localdomain>
References: <20210604195900.2096121-1-satyat@google.com>
 <20210604195900.2096121-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604195900.2096121-4-satyat@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 07:58:53PM +0000, Satya Tangirala wrote:
> This function returns the required alignment for the number of sectors in
> a bio. In particular, the number of sectors passed to bio_split() must be
> aligned to this value.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/blk.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/block/blk.h b/block/blk.h
> index 8b3591aee0a5..c8dcad7dde81 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -262,6 +262,20 @@ static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
>  	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
>  }
>  
> +/*
> + * The required sector alignment for a bio. The number of sectors in any bio
> + * must be aligned to this value.
> + */
> +static inline unsigned int bio_required_sector_alignment(struct bio *bio)
> +{
> +	unsigned int alignmask =
> +		(bdev_logical_block_size(bio->bi_bdev) >> SECTOR_SHIFT) - 1;
> +
> +	alignmask |= blk_crypto_bio_sectors_alignment(bio) - 1;
> +
> +	return alignmask + 1;
> +}

Looks fine, but I think we could rework the comment to be a bit easier to
understand:

/*
 * Return the number of sectors to which the size of the given bio (and any bios
 * split from it) must be aligned.
 *
 * Normally this is just the disk's logical block size in sectors, but it may be
 * greater if the bio has an encryption context.
 */
static inline unsigned int bio_required_sector_alignment(struct bio *bio)
{
	unsigned int alignmask =
		(bdev_logical_block_size(bio->bi_bdev) >> SECTOR_SHIFT) - 1;

	alignmask |= blk_crypto_bio_sectors_alignment(bio) - 1;

	return alignmask + 1;
}
