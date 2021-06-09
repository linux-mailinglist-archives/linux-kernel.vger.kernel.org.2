Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78B83A167C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbhFIOFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:05:04 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47612 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbhFIOFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:05:00 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5998420B83C2;
        Wed,  9 Jun 2021 07:03:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5998420B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623247386;
        bh=IRts58tl+eYwjKkNGvvrg6lIfNUrj21VJzDxSCoORkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AxS4OoK9mboxHZ5xicd4/Qun7iZD4pccHsdXfoPMd5KALbDOcn2QWC4kjIEPYLxLM
         0Vqn2UWjdo2R1UhbbIUk6xI0p5633RrMb4t/F/0qEPXfsBjNUeLVB4EMT3KT8l2zGv
         65VJP9lwfb2UtrPydcyPkY+9ptQkAOg+sFrf/zX0=
Date:   Wed, 9 Jun 2021 09:03:03 -0500
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
Subject: Re: [PATCH 1/7] tee: remove unused tee_shm_pool_alloc_res_mem()
Message-ID: <20210609140303.GE4910@sequoia>
References: <20210609102324.2222332-1-jens.wiklander@linaro.org>
 <20210609102324.2222332-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609102324.2222332-2-jens.wiklander@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-09 12:23:18, Jens Wiklander wrote:
> None of the drivers in the TEE subsystem uses
> tee_shm_pool_alloc_res_mem() so remove the function.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  drivers/tee/tee_shm_pool.c | 56 --------------------------------------
>  include/linux/tee_drv.h    | 30 --------------------
>  2 files changed, 86 deletions(-)
> 
> diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
> index fcbb461fc59c..a9f9d50fd181 100644
> --- a/drivers/tee/tee_shm_pool.c
> +++ b/drivers/tee/tee_shm_pool.c
> @@ -47,62 +47,6 @@ static const struct tee_shm_pool_mgr_ops pool_ops_generic = {
>  	.destroy_poolmgr = pool_op_gen_destroy_poolmgr,
>  };
>  
> -/**
> - * tee_shm_pool_alloc_res_mem() - Create a shared memory pool from reserved
> - * memory range
> - * @priv_info:	Information for driver private shared memory pool
> - * @dmabuf_info: Information for dma-buf shared memory pool
> - *
> - * Start and end of pools will must be page aligned.
> - *
> - * Allocation with the flag TEE_SHM_DMA_BUF set will use the range supplied
> - * in @dmabuf, others will use the range provided by @priv.
> - *
> - * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
> - */
> -struct tee_shm_pool *
> -tee_shm_pool_alloc_res_mem(struct tee_shm_pool_mem_info *priv_info,
> -			   struct tee_shm_pool_mem_info *dmabuf_info)
> -{
> -	struct tee_shm_pool_mgr *priv_mgr;
> -	struct tee_shm_pool_mgr *dmabuf_mgr;
> -	void *rc;
> -
> -	/*
> -	 * Create the pool for driver private shared memory
> -	 */
> -	rc = tee_shm_pool_mgr_alloc_res_mem(priv_info->vaddr, priv_info->paddr,
> -					    priv_info->size,
> -					    3 /* 8 byte aligned */);
> -	if (IS_ERR(rc))
> -		return rc;
> -	priv_mgr = rc;
> -
> -	/*
> -	 * Create the pool for dma_buf shared memory
> -	 */
> -	rc = tee_shm_pool_mgr_alloc_res_mem(dmabuf_info->vaddr,
> -					    dmabuf_info->paddr,
> -					    dmabuf_info->size, PAGE_SHIFT);
> -	if (IS_ERR(rc))
> -		goto err_free_priv_mgr;
> -	dmabuf_mgr = rc;
> -
> -	rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> -	if (IS_ERR(rc))
> -		goto err_free_dmabuf_mgr;
> -
> -	return rc;
> -
> -err_free_dmabuf_mgr:
> -	tee_shm_pool_mgr_destroy(dmabuf_mgr);
> -err_free_priv_mgr:
> -	tee_shm_pool_mgr_destroy(priv_mgr);
> -
> -	return rc;
> -}
> -EXPORT_SYMBOL_GPL(tee_shm_pool_alloc_res_mem);
> -
>  struct tee_shm_pool_mgr *tee_shm_pool_mgr_alloc_res_mem(unsigned long vaddr,
>  							phys_addr_t paddr,
>  							size_t size,
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 54269e47ac9a..53b9b2a13a87 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -272,36 +272,6 @@ static inline void tee_shm_pool_mgr_destroy(struct tee_shm_pool_mgr *poolm)
>  	poolm->ops->destroy_poolmgr(poolm);
>  }
>  
> -/**
> - * struct tee_shm_pool_mem_info - holds information needed to create a shared
> - * memory pool
> - * @vaddr:	Virtual address of start of pool
> - * @paddr:	Physical address of start of pool
> - * @size:	Size in bytes of the pool
> - */
> -struct tee_shm_pool_mem_info {
> -	unsigned long vaddr;
> -	phys_addr_t paddr;
> -	size_t size;
> -};
> -
> -/**
> - * tee_shm_pool_alloc_res_mem() - Create a shared memory pool from reserved
> - * memory range
> - * @priv_info:	 Information for driver private shared memory pool
> - * @dmabuf_info: Information for dma-buf shared memory pool
> - *
> - * Start and end of pools will must be page aligned.
> - *
> - * Allocation with the flag TEE_SHM_DMA_BUF set will use the range supplied
> - * in @dmabuf, others will use the range provided by @priv.
> - *
> - * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
> - */
> -struct tee_shm_pool *
> -tee_shm_pool_alloc_res_mem(struct tee_shm_pool_mem_info *priv_info,
> -			   struct tee_shm_pool_mem_info *dmabuf_info);
> -
>  /**
>   * tee_shm_pool_free() - Free a shared memory pool
>   * @pool:	The shared memory pool to free
> -- 
> 2.31.1
> 
