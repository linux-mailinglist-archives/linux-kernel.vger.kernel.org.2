Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429233A17F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbhFIOx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:53:56 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54086 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbhFIOxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:53:50 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 36F1720B7188;
        Wed,  9 Jun 2021 07:51:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36F1720B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623250315;
        bh=/HOmnjissLx+lpthetr985W/qYtb76YNAtpL9Q+TgUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c80DgLo+RZ7PeCM+jUdVjeYBRw/W44I+zJd6qzZdHN9r7ORuQQ6AGzFitDP+/AVLR
         JLqhPwpsBqvYed6u1ExXDP2dxSO+TkFg+aHZOAMCQwO11kq6EKDMweBAINbQYrfvAS
         Ymdij+JezbRgdwPbVaGZvQYQQ2nDt5LNqgJSnrw8=
Date:   Wed, 9 Jun 2021 09:51:53 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4/7] hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
Message-ID: <20210609145153.GH4910@sequoia>
References: <20210609102324.2222332-1-jens.wiklander@linaro.org>
 <20210609102324.2222332-5-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609102324.2222332-5-jens.wiklander@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-09 12:23:21, Jens Wiklander wrote:
> Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
> the old deprecated tee_shm_alloc() function which required specific
> TEE_SHM-flags.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  drivers/char/hw_random/optee-rng.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
> index 135a82590923..a948c0727b2b 100644
> --- a/drivers/char/hw_random/optee-rng.c
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -145,10 +145,10 @@ static int optee_rng_init(struct hwrng *rng)
>  	struct optee_rng_private *pvt_data = to_optee_rng_private(rng);
>  	struct tee_shm *entropy_shm_pool = NULL;
>  
> -	entropy_shm_pool = tee_shm_alloc(pvt_data->ctx, MAX_ENTROPY_REQ_SZ,
> -					 TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +	entropy_shm_pool = tee_shm_alloc_kernel_buf(pvt_data->ctx,
> +						    MAX_ENTROPY_REQ_SZ);
>  	if (IS_ERR(entropy_shm_pool)) {
> -		dev_err(pvt_data->dev, "tee_shm_alloc failed\n");
> +		dev_err(pvt_data->dev, "tee_shm_alloc_kernel_buf failed\n");
>  		return PTR_ERR(entropy_shm_pool);
>  	}
>  
> -- 
> 2.31.1
> 
