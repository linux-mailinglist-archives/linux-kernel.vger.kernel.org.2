Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29D43A17FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbhFIOy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:54:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54270 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhFIOy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:54:57 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 183BC20B7188;
        Wed,  9 Jun 2021 07:53:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 183BC20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623250382;
        bh=HhHhUu3sZTkLyr/eSUx74slyUT3vr66VzrX8x+epWEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5kQa+Il+On6I1y9Wgum53+A9ZGdTcxYpqSuu291t9sRCFn2ieEbCB55BmaUC3sr3
         H7FaJoQV5WAOlKevvJxjBawEddDe1lNWFmOIyjOOd/rLRbCFlGSsKj4enkgfFrK4Cf
         X6mMc3IqGYmaAYJZ0ple1o9EUe7ThL/nbsFO10k0=
Date:   Wed, 9 Jun 2021 09:53:00 -0500
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
Subject: Re: [PATCH 5/7] tpm_ftpm_tee: use tee_shm_alloc_kernel_buf()
Message-ID: <20210609145300.GI4910@sequoia>
References: <20210609102324.2222332-1-jens.wiklander@linaro.org>
 <20210609102324.2222332-6-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609102324.2222332-6-jens.wiklander@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-09 12:23:22, Jens Wiklander wrote:
> Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
> the old deprecated tee_shm_alloc() function which required specific
> TEE_SHM-flags.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 2ccdf8ac6994..6e3235565a4d 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -254,11 +254,11 @@ static int ftpm_tee_probe(struct device *dev)
>  	pvt_data->session = sess_arg.session;
>  
>  	/* Allocate dynamic shared memory with fTPM TA */
> -	pvt_data->shm = tee_shm_alloc(pvt_data->ctx,
> -				      MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE,
> -				      TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +	pvt_data->shm = tee_shm_alloc_kernel_buf(pvt_data->ctx,
> +						 MAX_COMMAND_SIZE +
> +						 MAX_RESPONSE_SIZE);
>  	if (IS_ERR(pvt_data->shm)) {
> -		dev_err(dev, "%s: tee_shm_alloc failed\n", __func__);
> +		dev_err(dev, "%s: tee_shm_alloc_kernel_buf failed\n", __func__);
>  		rc = -ENOMEM;
>  		goto out_shm_alloc;
>  	}
> -- 
> 2.31.1
> 
