Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421093A1845
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbhFIPAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:00:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54966 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbhFIPAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:00:12 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3A72220B7188;
        Wed,  9 Jun 2021 07:58:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A72220B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623250697;
        bh=UJ8w+2UkCTqOO7t0THpVN1Z+lmRBpIYgm5bx/zHc61k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r+mbMmR7zBOFUPNpvddxTsw6rYp5Yv6seXHZlg4vEYBw9ut8QsoWzSVElTA2B1qBt
         i3XUSJI+6bmdMbHf9gmIoE2jI+7HErf1ru10WB8h/qqH811cZnhgtGYomhaHpfruRF
         sJcKGyf5IJP/CLii/BhpRrtqruuZu5KpPRaAqbrA=
Date:   Wed, 9 Jun 2021 09:58:11 -0500
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
Subject: Re: [PATCH 6/7] firmware: tee_bnxt: use tee_shm_alloc_kernel_buf()
Message-ID: <20210609145811.GJ4910@sequoia>
References: <20210609102324.2222332-1-jens.wiklander@linaro.org>
 <20210609102324.2222332-7-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609102324.2222332-7-jens.wiklander@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-09 12:23:23, Jens Wiklander wrote:
> Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
> the old deprecated tee_shm_alloc() function which required specific
> TEE_SHM-flags.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Since this series is essentially a rewrite of the shm allocation logic,
it is worth pointing out that the rewrite still uses contiguous
allocations (from alloc_pages()). The tee_bnxt_fw driver is performing
an order-10 allocation which is the max, by default. I've only tested
tee_bnxt_fw when it was built-in to the kernel and tee_bnxt_fw_probe()
was called early in boot but I suspect that it might not succeed when
built as a module and loaded later after memory is segmented. I think
this driver would benefit from being able to request a non-contiguous
allocation.

Is this rewrite a good time to offer drivers a way to perform a
non-contiguous allocation?

Tyler

> ---
>  drivers/firmware/broadcom/tee_bnxt_fw.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
> index ed10da5313e8..56d00ddd4357 100644
> --- a/drivers/firmware/broadcom/tee_bnxt_fw.c
> +++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
> @@ -212,10 +212,9 @@ static int tee_bnxt_fw_probe(struct device *dev)
>  
>  	pvt_data.dev = dev;
>  
> -	fw_shm_pool = tee_shm_alloc(pvt_data.ctx, MAX_SHM_MEM_SZ,
> -				    TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +	fw_shm_pool = tee_shm_alloc_kernel_buf(pvt_data.ctx, MAX_SHM_MEM_SZ);
>  	if (IS_ERR(fw_shm_pool)) {
> -		dev_err(pvt_data.dev, "tee_shm_alloc failed\n");
> +		dev_err(pvt_data.dev, "tee_shm_alloc_kernel_buf failed\n");
>  		err = PTR_ERR(fw_shm_pool);
>  		goto out_sess;
>  	}
> -- 
> 2.31.1
> 
