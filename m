Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4A33AA821
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 02:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhFQAbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 20:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhFQAbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 20:31:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A65B613CD;
        Thu, 17 Jun 2021 00:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623889751;
        bh=c6/UgIpgeNcNi4unNQ/ylhL9ijWKo/B8SV0ZczXTMVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BRmNWSOSnu7pks8kP/2h7R/hduZJGEnYVXbHIBzoqFjbXkCm75pIt2cbP+1SQehE0
         kkG4PLADA3FtZwuOJVbpx0Wf7Hi+ViRZ1cY6SA+E8i2X9Gi+YzIf4XBmpHnQ2nI48n
         FlbLRSJ10+tIsXy0GjF5Xe92FXqT3AGcey+2wRxcystoAF70ycYktBSJxWMRtdn3tJ
         rhPagjvHAWU5flKRgWkEy7lkuKYy66OWiaw48XcZYk8F9dXBnLJeofh8IkDa2I26FP
         YR2G9GS5H4kHWse9IaCsVEh2ar8xA3i1YcT27OLNB/eCss/P9Cfx2jL263dFXYpkAq
         0L6PyFOTpuyPw==
Date:   Wed, 16 Jun 2021 17:29:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 02/10] block: blk-crypto: introduce
 blk_crypto_bio_sectors_alignment()
Message-ID: <YMqXVe7DdukZNSEF@sol.localdomain>
References: <20210604195900.2096121-1-satyat@google.com>
 <20210604195900.2096121-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604195900.2096121-3-satyat@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 07:58:52PM +0000, Satya Tangirala wrote:
> The size of any bio must be aligned to the data unit size of the bio crypt
> context (if it exists) of that bio. This must also be ensured whenever a
> bio is split. Introduce blk_crypto_bio_sectors_alignment() that returns the
> required alignment in sectors. The number of sectors passed to any call of
> bio_split() must be aligned to blk_crypto_bio_sectors_alignment().
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/blk-crypto-internal.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
> index 0d36aae538d7..7f1535cc7e7c 100644
> --- a/block/blk-crypto-internal.h
> +++ b/block/blk-crypto-internal.h
> @@ -60,6 +60,21 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
>  	return rq->crypt_ctx;
>  }
>  
> +/*
> + * Returns the alignment requirement for the number of sectors in this bio based
> + * on its bi_crypt_context. Any bios split from this bio must follow this
> + * alignment requirement as well. Note that a bio must contain a whole number of
> + * crypto data units (which is selected by the submitter of bio), since
> + * encryption/decryption can only be performed on a complete crypto data unit.
> + */
> +static inline unsigned int blk_crypto_bio_sectors_alignment(struct bio *bio)
> +{
> +	if (!bio_has_crypt_ctx(bio))
> +		return 1;
> +	return bio->bi_crypt_context->bc_key->crypto_cfg.data_unit_size >>
> +								SECTOR_SHIFT;
> +}
> +
>  #else /* CONFIG_BLK_INLINE_ENCRYPTION */
>  
>  static inline bool bio_crypt_rq_ctx_compatible(struct request *rq,
> @@ -93,6 +108,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
>  	return false;
>  }
>  
> +static inline unsigned int blk_crypto_bio_sectors_alignment(struct bio *bio)
> +{
> +	return 1;
> +}
> +
>  #endif /* CONFIG_BLK_INLINE_ENCRYPTION */

Looks fine, but I think we should rework the comment to be a bit easier to
understand.  Maybe:

/*
 * Return the number of sectors to which the size of this bio (and any bios
 * split from it) must be aligned based on its encryption context.
 */
static inline unsigned int blk_crypto_bio_sectors_alignment(struct bio *bio)
{
	if (!bio_has_crypt_ctx(bio))
		return 1;
	/*
	 * If the bio has an encryption context, its size must be aligned to its
	 * crypto data unit size (which the submitter of the bio selected), as
	 * encryption/decryption can only be done on complete crypto data units.
	 */
	return bio->bi_crypt_context->bc_key->crypto_cfg.data_unit_size >>
								SECTOR_SHIFT;
}
