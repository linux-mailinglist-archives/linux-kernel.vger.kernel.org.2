Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5443A3D72
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhFKHpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:45:19 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:36520 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFKHpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:45:18 -0400
Received: by mail-lj1-f170.google.com with SMTP id 131so8419147ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kw+FU3qzojv4u0PEEcHRHhktciBtC+NnGgOLFwUlevc=;
        b=xBqE3gDnwQUpn13sxz3j4KlHPql7Yk2k++4Y1gKplwCDH3eyOVtyROql+rNoOvIMon
         hjlgE2Sab4qve0FQ9kgetFH/niSP6cwDu1GeWUqwed7k2wFpclJKjTYimam+k4X2cntN
         LeJZzMfkGtV/BZwWItVdDt1JISSZQ3AJGgXQ25MqDC5vIQJ0yhI7nqh8X7jskMwZcI7V
         foqmSBKgCuMMOpdOSxbR3NJHQ/jbO249LPhdAeKXIoKrHwRltakCy2+W6CBFqlvMJXLQ
         uPFY0IYM2prqvEfLT9yFgoRg6SmFHtKMyGQYIdvFDIZbE2VfS76YSpu9eMwx6wq7JSha
         kGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kw+FU3qzojv4u0PEEcHRHhktciBtC+NnGgOLFwUlevc=;
        b=c8ZDSb4HUZKj2QE/iHUCxr2/sb2foc9XXTfRgbhAFGJqFK9R9w2G3Uj7XegFX3pyJ0
         WjAF8Hfk1ok8tDI00xM1t5R+9gCPOWx2qmv/xyNZn+xmyUXtsX4P5RlNy5F4vmWbzWEu
         GELE7+fu6PFXmhzBd20Ghgjxp+uN0hCk3NR6qlcNCQBMIZ+CElW0Jt63NWSVrjQNR9Zm
         nBQnTuvfRsOk8OxTLBRE37FmHrCvNliriusg6OgBduwR8ovhuSprJSRV/CbQjdtAt5RX
         pcZi0XhiJ7yhhLk1LqscLZ2ZS6h0mGxYe3RebalVanvEb9RVQyjnQZ42LcA3EjBVjT9U
         UI/A==
X-Gm-Message-State: AOAM531OnYJg8EKBRYRc/EqrvOtchNnF17E9Cx2A7LhOx4f0Gj6qH3kK
        KLqGFWiWG2KKCy3vaTjs2tYbvNZacG6CXNBK
X-Google-Smtp-Source: ABdhPJz0Tmd6bITHxsZeWMp4hDaufXQA9CP2DO0GrXArxsPGdH3Vr8n+QmRPOibMwaaHEMrF+Tt35g==
X-Received: by 2002:a2e:b5b5:: with SMTP id f21mr1981357ljn.479.1623397328996;
        Fri, 11 Jun 2021 00:42:08 -0700 (PDT)
Received: from jade (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id g20sm608632lja.2.2021.06.11.00.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 00:42:08 -0700 (PDT)
Date:   Fri, 11 Jun 2021 09:42:07 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 7/7] tee: replace tee_shm_alloc()
Message-ID: <20210611074207.GE2753553@jade>
References: <20210609102324.2222332-1-jens.wiklander@linaro.org>
 <20210609102324.2222332-8-jens.wiklander@linaro.org>
 <20210609153215.GK4910@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210609153215.GK4910@sequoia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 10:32:15AM -0500, Tyler Hicks wrote:
> On 2021-06-09 12:23:24, Jens Wiklander wrote:
> > tee_shm_alloc() is replaced by three new functions,
> > 
> > tee_shm_alloc_user_buf() - for user mode allocations, replacing passing
> > the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF
> > 
> > tee_shm_alloc_kernel_buf() - for kernel mode allocations, slightly
> > optimized compared to using the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF
> > since we now can avoid using the dma-buf registration.
> > 
> > tee_shm_alloc_anon_kernel_buf() - for TEE driver internal use only
> > allowing decoupling a shared memory object from its original
> > tee_context.
> > 
> > This also makes the interface easier to use as we can get rid of the
> > somewhat hard to use flags parameter.
> > 
> > The TEE subsystem and the TEE drivers are updated to use the new
> > functions instead.
> > 
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/call.c   |  16 ++--
> >  drivers/tee/optee/core.c   |   4 +-
> >  drivers/tee/optee/device.c |   5 +-
> >  drivers/tee/optee/rpc.c    |   8 +-
> >  drivers/tee/tee_core.c     |   2 +-
> >  drivers/tee/tee_shm.c      | 186 +++++++++++++++++++++++++++----------
> >  include/linux/tee_drv.h    |  19 +---
> >  7 files changed, 156 insertions(+), 84 deletions(-)
> > 
> > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > index 6132cc8d014c..f31257649c0e 100644
> > --- a/drivers/tee/optee/call.c
> > +++ b/drivers/tee/optee/call.c
> > @@ -183,8 +183,8 @@ static struct tee_shm *get_msg_arg(struct tee_context *ctx, size_t num_params,
> >  	struct tee_shm *shm;
> >  	struct optee_msg_arg *ma;
> >  
> > -	shm = tee_shm_alloc(ctx, OPTEE_MSG_GET_ARG_SIZE(num_params),
> > -			    TEE_SHM_MAPPED);
> > +	shm = tee_shm_alloc_anon_kernel_buf(ctx,
> > +					    OPTEE_MSG_GET_ARG_SIZE(num_params));
> 
> The error handling in get_msg_arg() should be updated to call
> tee_shm_free_anon_kernel_buf() instead of tee_shm_free().

You're right, I'll fix.

> 
> >  	if (IS_ERR(shm))
> >  		return shm;
> >  
> > @@ -281,7 +281,7 @@ int optee_open_session(struct tee_context *ctx,
> >  		arg->ret_origin = msg_arg->ret_origin;
> >  	}
> >  out:
> > -	tee_shm_free(shm);
> > +	tee_shm_free_anon_kernel_buf(ctx, shm);
> >  
> >  	return rc;
> >  }
> > @@ -312,7 +312,7 @@ int optee_close_session(struct tee_context *ctx, u32 session)
> >  	msg_arg->session = session;
> >  	optee_do_call_with_arg(ctx, msg_parg);
> >  
> > -	tee_shm_free(shm);
> > +	tee_shm_free_anon_kernel_buf(ctx, shm);
> >  	return 0;
> >  }
> >  
> > @@ -358,7 +358,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> >  	arg->ret = msg_arg->ret;
> >  	arg->ret_origin = msg_arg->ret_origin;
> >  out:
> > -	tee_shm_free(shm);
> > +	tee_shm_free_anon_kernel_buf(ctx, shm);
> >  	return rc;
> >  }
> >  
> > @@ -386,7 +386,7 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
> >  	msg_arg->cancel_id = cancel_id;
> >  	optee_do_call_with_arg(ctx, msg_parg);
> >  
> > -	tee_shm_free(shm);
> > +	tee_shm_free_anon_kernel_buf(ctx, shm);
> >  	return 0;
> >  }
> >  
> > @@ -625,7 +625,7 @@ int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> >  	    msg_arg->ret != TEEC_SUCCESS)
> >  		rc = -EINVAL;
> >  
> > -	tee_shm_free(shm_arg);
> > +	tee_shm_free_anon_kernel_buf(ctx, shm_arg);
> >  out:
> >  	optee_free_pages_list(pages_list, num_pages);
> >  	return rc;
> > @@ -650,7 +650,7 @@ int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
> >  	if (optee_do_call_with_arg(ctx, msg_parg) ||
> >  	    msg_arg->ret != TEEC_SUCCESS)
> >  		rc = -EINVAL;
> > -	tee_shm_free(shm_arg);
> > +	tee_shm_free_anon_kernel_buf(ctx, shm_arg);
> >  	return rc;
> >  }
> >  
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 0c287345f9fe..a15dc3881636 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -277,7 +277,7 @@ static void optee_release(struct tee_context *ctx)
> >  	if (!ctxdata)
> >  		return;
> >  
> > -	shm = tee_shm_alloc(ctx, sizeof(struct optee_msg_arg), TEE_SHM_MAPPED);
> > +	shm = tee_shm_alloc_anon_kernel_buf(ctx, sizeof(struct optee_msg_arg));
> >  	if (!IS_ERR(shm)) {
> >  		arg = tee_shm_get_va(shm, 0);
> >  		/*
> > @@ -305,7 +305,7 @@ static void optee_release(struct tee_context *ctx)
> >  	kfree(ctxdata);
> >  
> >  	if (!IS_ERR(shm))
> > -		tee_shm_free(shm);
> > +		tee_shm_free_anon_kernel_buf(ctx, shm);
> >  
> >  	ctx->data = NULL;
> >  
> > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > index ec1d24693eba..5a5bf86b1b95 100644
> > --- a/drivers/tee/optee/device.c
> > +++ b/drivers/tee/optee/device.c
> > @@ -113,10 +113,9 @@ static int __optee_enumerate_devices(u32 func)
> >  	if (rc < 0 || !shm_size)
> >  		goto out_sess;
> >  
> > -	device_shm = tee_shm_alloc(ctx, shm_size,
> > -				   TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> > +	device_shm = tee_shm_alloc_kernel_buf(ctx, shm_size);
> 
> The error handling in the 'err' label needs to use
> tee_shm_free_anon_kernel_buf() instead of tee_shm_free().

I'll update with tee_shm_free_kernel_buf() as suggested in your next
mail.

> 
> >  	if (IS_ERR(device_shm)) {
> > -		pr_err("tee_shm_alloc failed\n");
> > +		pr_err("tee_shm_alloc_kernel_buf failed\n");
> >  		rc = PTR_ERR(device_shm);
> >  		goto out_sess;
> >  	}
> > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > index 1849180b0278..9108aedb3eee 100644
> > --- a/drivers/tee/optee/rpc.c
> > +++ b/drivers/tee/optee/rpc.c
> > @@ -314,7 +314,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> >  		shm = cmd_alloc_suppl(ctx, sz);
> >  		break;
> >  	case OPTEE_RPC_SHM_TYPE_KERNEL:
> > -		shm = tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED);
> > +		shm = tee_shm_alloc_anon_kernel_buf(ctx, sz);
> 
> The error handling in the 'bad' label still uses tee_shm_free(). I guess
> it needs to do something like handle_rpc_func_cmd_shm_free()?

Thanks, I'll fix.

> 
> >  		break;
> >  	default:
> >  		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > @@ -424,7 +424,7 @@ static void handle_rpc_func_cmd_shm_free(struct tee_context *ctx,
> >  		cmd_free_suppl(ctx, shm);
> >  		break;
> >  	case OPTEE_RPC_SHM_TYPE_KERNEL:
> > -		tee_shm_free(shm);
> > +		tee_shm_free_anon_kernel_buf(ctx, shm);
> >  		break;
> >  	default:
> >  		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > @@ -502,7 +502,7 @@ void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
> >  
> >  	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
> >  	case OPTEE_SMC_RPC_FUNC_ALLOC:
> > -		shm = tee_shm_alloc(ctx, param->a1, TEE_SHM_MAPPED);
> > +		shm = tee_shm_alloc_anon_kernel_buf(ctx, param->a1);
> >  		if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
> >  			reg_pair_from_64(&param->a1, &param->a2, pa);
> >  			reg_pair_from_64(&param->a4, &param->a5,
> > @@ -516,7 +516,7 @@ void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
> >  		break;
> >  	case OPTEE_SMC_RPC_FUNC_FREE:
> >  		shm = reg_pair_to_ptr(param->a1, param->a2);
> > -		tee_shm_free(shm);
> > +		tee_shm_free_anon_kernel_buf(ctx, shm);
> >  		break;
> >  	case OPTEE_SMC_RPC_FUNC_FOREIGN_INTR:
> >  		/*
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 480d294a23ab..4f5c7c17a434 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -293,7 +293,7 @@ static int tee_ioctl_shm_alloc(struct tee_context *ctx,
> >  	if (data.flags)
> >  		return -EINVAL;
> >  
> > -	shm = tee_shm_alloc(ctx, data.size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> > +	shm = tee_shm_alloc_user_buf(ctx, data.size);
> >  	if (IS_ERR(shm))
> >  		return PTR_ERR(shm);
> >  
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 63fce8d39d8b..d134e2778a3a 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -96,25 +96,14 @@ static const struct dma_buf_ops tee_shm_dma_buf_ops = {
> >  	.mmap = tee_shm_op_mmap,
> >  };
> >  
> > -struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> > +static struct tee_shm *shm_alloc_helper(struct tee_context *ctx, size_t size,
> > +					size_t align, u32 flags)
> >  {
> >  	struct tee_device *teedev = ctx->teedev;
> >  	struct tee_shm *shm;
> > -	size_t align;
> >  	void *ret;
> >  	int rc;
> >  
> > -	if (!(flags & TEE_SHM_MAPPED)) {
> > -		dev_err(teedev->dev.parent,
> > -			"only mapped allocations supported\n");
> > -		return ERR_PTR(-EINVAL);
> > -	}
> > -
> > -	if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF))) {
> > -		dev_err(teedev->dev.parent, "invalid shm flags 0x%x", flags);
> > -		return ERR_PTR(-EINVAL);
> > -	}
> > -
> >  	if (!tee_device_get(teedev))
> >  		return ERR_PTR(-EINVAL);
> >  
> > @@ -131,17 +120,14 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> >  	}
> >  
> >  	shm->flags = flags | TEE_SHM_POOL;
> > +
> > +	/*
> > +	 * We're assigning this as it is needed if the shm is to be
> > +	 * registered. If this function returns OK then the caller expected
> > +	 * to call teedev_ctx_get() or clear shm->ctx in case it's not
> > +	 * needed any longer.
> > +	 */
> >  	shm->ctx = ctx;
> > -	if (flags & TEE_SHM_DMA_BUF) {
> > -		align = PAGE_SIZE;
> > -		/*
> > -		 * Request to register the shm in the pool allocator below
> > -		 * if supported.
> > -		 */
> > -		shm->flags |= TEE_SHM_REGISTER;
> > -	} else {
> > -		align = 2 * sizeof(long);
> > -	}
> >  
> >  	rc = teedev->pool->ops->alloc(teedev->pool, shm, size, align);
> >  	if (rc) {
> > @@ -149,48 +135,71 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> >  		goto err_kfree;
> >  	}
> >  
> > +	return shm;
> > +err_kfree:
> > +	kfree(shm);
> > +err_dev_put:
> > +	tee_device_put(teedev);
> > +	return ret;
> > +}
> >  
> > -	if (flags & TEE_SHM_DMA_BUF) {
> > -		DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > +/**
> > + * tee_shm_alloc_user_buf() - Allocate shared memory for user space
> > + * @ctx:	Context that allocates the shared memory
> > + * @size:	Requested size of shared memory
> > + *
> > + * Memory allocated as user space shared memory is automatically freed when
> > + * the TEE file pointer is closed. The primary usage of this function is
> > + * when the TEE driver doesn't support registering ordinary user space
> > + * memory.
> > + *
> > + * @returns a pointer to 'struct tee_shm'
> > + */
> > +struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
> > +{
> > +	u32 flags = TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER;
> 
> Why not TEE_SHM_USER_MAPPED instead of TEE_SHM_MAPPED here?

The name TEE_SHM_USER_MAPPED is perhaps not the best, it means that it's
normal user space memory that we have pinned. We're allocating memory
which later can be mapped by user space (via dma-buf) here.

> 
> > +	struct tee_device *teedev = ctx->teedev;
> > +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > +	struct tee_shm *shm;
> > +	void *ret;
> >  
> > -		mutex_lock(&teedev->mutex);
> > -		shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
> > -		mutex_unlock(&teedev->mutex);
> > -		if (shm->id < 0) {
> > -			ret = ERR_PTR(shm->id);
> > -			goto err_pool_free;
> > -		}
> > +	shm = shm_alloc_helper(ctx, size, PAGE_SIZE, flags);
> > +	if (IS_ERR(shm))
> > +		return shm;
> >  
> > -		exp_info.ops = &tee_shm_dma_buf_ops;
> > -		exp_info.size = shm->size;
> > -		exp_info.flags = O_RDWR;
> > -		exp_info.priv = shm;
> > +	mutex_lock(&teedev->mutex);
> > +	shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
> > +	mutex_unlock(&teedev->mutex);
> > +	if (shm->id < 0) {
> > +		ret = ERR_PTR(shm->id);
> > +		goto err_pool_free;
> > +	}
> >  
> > -		shm->dmabuf = dma_buf_export(&exp_info);
> > -		if (IS_ERR(shm->dmabuf)) {
> > -			ret = ERR_CAST(shm->dmabuf);
> > -			goto err_rem;
> > -		}
> > +	exp_info.ops = &tee_shm_dma_buf_ops;
> > +	exp_info.size = shm->size;
> > +	exp_info.flags = O_RDWR;
> > +	exp_info.priv = shm;
> > +
> > +	shm->dmabuf = dma_buf_export(&exp_info);
> > +	if (IS_ERR(shm->dmabuf)) {
> > +		ret = ERR_CAST(shm->dmabuf);
> > +		goto err_rem;
> >  	}
> >  
> >  	teedev_ctx_get(ctx);
> > -
> >  	return shm;
> >  err_rem:
> > -	if (flags & TEE_SHM_DMA_BUF) {
> > -		mutex_lock(&teedev->mutex);
> > -		idr_remove(&teedev->idr, shm->id);
> > -		mutex_unlock(&teedev->mutex);
> > -	}
> > +	mutex_lock(&teedev->mutex);
> > +	idr_remove(&teedev->idr, shm->id);
> > +	mutex_unlock(&teedev->mutex);
> >  err_pool_free:
> >  	teedev->pool->ops->free(teedev->pool, shm);
> > -err_kfree:
> >  	kfree(shm);
> > -err_dev_put:
> >  	tee_device_put(teedev);
> >  	return ret;
> > +
> >  }
> > -EXPORT_SYMBOL_GPL(tee_shm_alloc);
> > +EXPORT_SYMBOL_GPL(tee_shm_alloc_user_buf);
> >  
> >  /**
> >   * tee_shm_alloc_kernel_buf() - Allocate shared memory for kernel buffer
> > @@ -206,10 +215,85 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc);
> >   */
> >  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
> >  {
> > -	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> > +	u32 flags = TEE_SHM_MAPPED | TEE_SHM_REGISTER;
> 
> Similar question as above... why not TEE_SHM_KERNEL_MAPPED instead of
> TEE_SHM_MAPPED?

Also here is the name a bit unfortunate, it means that the memory
originated as kernel owned memory where we've called get_kernel_pages().

> 
> > +	struct tee_shm *shm;
> > +
> > +	shm = shm_alloc_helper(ctx, size, PAGE_SIZE, flags);
> > +	if (IS_ERR(shm))
> > +		return shm;
> > +
> > +	teedev_ctx_get(ctx);
> > +	return shm;
> >  }
> >  EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
> >  
> > +/**
> > + * tee_shm_alloc_anon_kernel_buf() - Allocate shared memory for anonymous
> > + *				     kernel buffer
> > + * @ctx:	Context that allocates the shared memory
> > + * @size:	Requested size of shared memory
> > + *
> > + * This function returns similar shared memory as tee_shm_alloc_kernel_buf(),
> > + * but with two differences:
> > + * 1. The memory might not be registered in secure world
> > + *    in case the driver supports passing memory not registered in advance.
> > + * 2. The memory is not directly associated with the passed tee_context,
> > + *    rather the tee_device used by the context.
> > + *
> > + * This function should normally only be used internally in the TEE
> > + * drivers. The memory must later only be freed using
> > + * tee_shm_free_anon_kernel_buf() with a tee_contex with the same internal
> > + * tee_device as when the memory was allocated.
> > + *
> > + * This allows allocating the shared memory using one context which is
> > + * destroyed while the memory continues to live and finally freed using
> > + * another context.
> > + *
> > + * @returns a pointer to 'struct tee_shm'
> > + */
> > +struct tee_shm *tee_shm_alloc_anon_kernel_buf(struct tee_context *ctx,
> > +					      size_t size)
> > +{
> > +	struct tee_shm *shm;
> > +
> > +	shm = shm_alloc_helper(ctx, size, sizeof(long) * 2, TEE_SHM_MAPPED);
> 
> The generic TEE_SHM_MAPPED is used here, as well.

Yes, it's needed by tee_shm_va2pa() and friends.

Thanks for the review,
Jens
