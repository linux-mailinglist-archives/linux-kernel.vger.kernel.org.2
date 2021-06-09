Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE383A17EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbhFIOxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:53:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54000 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbhFIOxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:53:17 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id C2EF320B7188;
        Wed,  9 Jun 2021 07:51:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2EF320B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623250282;
        bh=NeJm9Sv8T7FXNiunLp/bvLL/Ts+yZdRrx9+3BOizJYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Im2bNCAoGQsV+pp/wA4+jYTFrlKIeZ6z1AjrrfXLMo9fbn8UkuXcZsaZt/7NqA6kk
         5W+qebRTmAATVGPnKzrs+AbgmxQwjhJNowWhVpojhYeUoa/B+S771VpBTh30b8Dkwe
         MODYzUioElbeF29xxAUMLJCQcdrY3Mv9konmw/qQ=
Date:   Wed, 9 Jun 2021 09:51:19 -0500
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
Subject: Re: [PATCH 3/7] tee: add tee_shm_alloc_kernel_buf()
Message-ID: <20210609145119.GG4910@sequoia>
References: <20210609102324.2222332-1-jens.wiklander@linaro.org>
 <20210609102324.2222332-4-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609102324.2222332-4-jens.wiklander@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-09 12:23:20, Jens Wiklander wrote:
> Adds a new function tee_shm_alloc_kernel_buf() to allocate shared memory
> from a kernel driver. This function can later be made more lightweight
> by unnecessary dma-buf export.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  drivers/tee/tee_shm.c   | 18 ++++++++++++++++++
>  include/linux/tee_drv.h |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index b9dbf4bce149..63fce8d39d8b 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -192,6 +192,24 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_alloc);
>  
> +/**
> + * tee_shm_alloc_kernel_buf() - Allocate shared memory for kernel buffer
> + * @ctx:	Context that allocates the shared memory
> + * @size:	Requested size of shared memory
> + *
> + * The returned memory registered in secure world and is suitable to be
> + * passed as a memory buffer in parameter argument to
> + * tee_client_invoke_func(). The memory allocated is later freed with a
> + * call to tee_shm_free().
> + *
> + * @returns a pointer to 'struct tee_shm'
> + */
> +struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
> +{
> +	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +}
> +EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
> +
>  struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>  				 size_t length, u32 flags)
>  {
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 62b7c7a55743..58b319766f8e 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -282,6 +282,7 @@ void *tee_get_drvdata(struct tee_device *teedev);
>   * @returns a pointer to 'struct tee_shm'
>   */
>  struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags);
> +struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
>  
>  /**
>   * tee_shm_register() - Register shared memory buffer
> -- 
> 2.31.1
> 
