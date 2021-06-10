Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DAE3A2799
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFJJEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:04:41 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:38444 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhFJJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:04:33 -0400
Received: by mail-lf1-f50.google.com with SMTP id r5so2038768lfr.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3rhbKuOsD1LDjtIdtSLuV7MxxOFM6agVltJ2iO2qngs=;
        b=zFULX0YCYqr87PDbQyTrqKjgPOyYGAAcdov0Otb41MRhcNYUDyPgAQiEDYSkyNP9/x
         rxw4lssNX+Xbga2uIiOjcTOmdyMiTDwELH/hll5Btl2lytbRORRwsdC11qBRrJodhHd9
         51mUEVG6wm1QKiDGEdYWF1b8X76HEm1apNY4t++pvD79iwpu+yv1TyPVSVaSe8pt11to
         N/aPz5HPWT0Szfq7nW/mEDur79PuLtlJaN/GCsmHa8LZJXn9rScfJMFIyZexBcf8xTzj
         UQtKYtCPKWatTDN004UM8Uoyj9OURVi+UR7lbVn3AVDiFVbLHKoWABMR2+Bh4L2Cbw6h
         XPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3rhbKuOsD1LDjtIdtSLuV7MxxOFM6agVltJ2iO2qngs=;
        b=e3QwA7UcN4oWTev97V5Gpw3OjFl3g2LLgoKISM0nO9P/L7lPV5aomXULC8475/dN0v
         UY4ILcSVPs29Qe4QcPKLcsAg2m5PQgHhS5NwpRuvwFHc7q1fVzAbcy4Z8nE6omGny7l+
         6mXHOk/3Jk+GMqmt+mGBWP0fESTPNVrmaC5Okx3UNNgSoCDl5xKhAFxOc33CCXOfGax5
         yq9UcQozcIRFoM6WB52FvM1padI4VdSBP1t3y8j6nyRxoCHvJAc4CrhobU9MUryfIud7
         N9a0mbslXQ3siXqKO8gg3+0eWMB0zuo7yJK2XmhfrUDZCuM404PzS1wK16O6SGkqDOya
         tRVA==
X-Gm-Message-State: AOAM530aihlBD+GlqI49XQGTnkymmm4qOp9plSf3HvxN+QVqV/zYuD3o
        IwGbFwmd8aQqXpglhn82unX+3g==
X-Google-Smtp-Source: ABdhPJwEiF36xABXTIEFBIUI+dP2aKZlQq9lVRVvfdlsv4xmatb/2JS8d8NW7RDOAo1lmDMvspRUGQ==
X-Received: by 2002:ac2:5b8e:: with SMTP id o14mr1235359lfn.558.1623315696260;
        Thu, 10 Jun 2021 02:01:36 -0700 (PDT)
Received: from jade (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id i25sm237680lfc.146.2021.06.10.02.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:01:35 -0700 (PDT)
Date:   Thu, 10 Jun 2021 11:01:34 +0200
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
Subject: Re: [PATCH 2/7] tee: simplify shm pool handling
Message-ID: <20210610090134.GD2753553@jade>
References: <20210609102324.2222332-1-jens.wiklander@linaro.org>
 <20210609102324.2222332-3-jens.wiklander@linaro.org>
 <20210609145004.GF4910@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210609145004.GF4910@sequoia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 09:50:04AM -0500, Tyler Hicks wrote:
> On 2021-06-09 12:23:19, Jens Wiklander wrote:
> > Replaces the shared memory pool based on two pools with a single pool.
> > The alloc() function pointer in struct tee_shm_pool_ops gets another
> > parameter, align. This makes it possible to make less than page aligned
> > allocations from the optional reserved shared memory pool while still
> > making user space allocations page aligned. With in practice unchanged
> > behaviour using only a single pool for bookkeeping.
> > 
> > The optee and amdtee drivers are updated as needed to work with this
> > changed pool handling.
> > 
> > This also removes OPTEE_SHM_NUM_PRIV_PAGES which becomes obsolete with
> > this change as the private pages can be mixed with the payload pages.
> > 
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/amdtee/shm_pool.c |  55 ++++++------------
> >  drivers/tee/optee/Kconfig     |   8 ---
> >  drivers/tee/optee/core.c      |  72 +++--------------------
> >  drivers/tee/optee/shm_pool.c  |  51 ++++++++++-------
> >  drivers/tee/optee/shm_pool.h  |   2 +-
> >  drivers/tee/tee_private.h     |  11 ----
> >  drivers/tee/tee_shm.c         |  29 +++++-----
> >  drivers/tee/tee_shm_pool.c    | 104 +++++++++++-----------------------
> >  include/linux/tee_drv.h       |  58 +++++++------------
> >  9 files changed, 120 insertions(+), 270 deletions(-)
> > 
> > diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
> > index 065854e2db18..81c23f30b455 100644
> > --- a/drivers/tee/amdtee/shm_pool.c
> > +++ b/drivers/tee/amdtee/shm_pool.c
> > @@ -8,13 +8,17 @@
> >  #include <linux/psp-sev.h>
> >  #include "amdtee_private.h"
> >  
> > -static int pool_op_alloc(struct tee_shm_pool_mgr *poolm, struct tee_shm *shm,
> > -			 size_t size)
> > +static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
> > +			 size_t size, u_int align)
> >  {
> >  	unsigned int order = get_order(size);
> >  	unsigned long va;
> >  	int rc;
> >  
> > +	/*
> > +	 * Ignore alignment since this is already going to be page aligned
> > +	 * and there's no need for any larger alignment.
> > +	 */
> >  	va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> >  	if (!va)
> >  		return -ENOMEM;
> > @@ -34,7 +38,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm, struct tee_shm *shm,
> >  	return 0;
> >  }
> >  
> > -static void pool_op_free(struct tee_shm_pool_mgr *poolm, struct tee_shm *shm)
> > +static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
> >  {
> >  	/* Unmap the shared memory from TEE */
> >  	amdtee_unmap_shmem(shm);
> > @@ -42,52 +46,25 @@ static void pool_op_free(struct tee_shm_pool_mgr *poolm, struct tee_shm *shm)
> >  	shm->kaddr = NULL;
> >  }
> >  
> > -static void pool_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
> > +static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> >  {
> > -	kfree(poolm);
> > +	kfree(pool);
> >  }
> >  
> > -static const struct tee_shm_pool_mgr_ops pool_ops = {
> > +static const struct tee_shm_pool_ops pool_ops = {
> >  	.alloc = pool_op_alloc,
> >  	.free = pool_op_free,
> > -	.destroy_poolmgr = pool_op_destroy_poolmgr,
> > +	.destroy_pool = pool_op_destroy_pool,
> >  };
> >  
> > -static struct tee_shm_pool_mgr *pool_mem_mgr_alloc(void)
> > -{
> > -	struct tee_shm_pool_mgr *mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
> > -
> > -	if (!mgr)
> > -		return ERR_PTR(-ENOMEM);
> > -
> > -	mgr->ops = &pool_ops;
> > -
> > -	return mgr;
> > -}
> > -
> >  struct tee_shm_pool *amdtee_config_shm(void)
> >  {
> > -	struct tee_shm_pool_mgr *priv_mgr;
> > -	struct tee_shm_pool_mgr *dmabuf_mgr;
> > -	void *rc;
> > +	struct tee_shm_pool *pool = kzalloc(sizeof(*pool), GFP_KERNEL);
> >  
> > -	rc = pool_mem_mgr_alloc();
> > -	if (IS_ERR(rc))
> > -		return rc;
> > -	priv_mgr = rc;
> > -
> > -	rc = pool_mem_mgr_alloc();
> > -	if (IS_ERR(rc)) {
> > -		tee_shm_pool_mgr_destroy(priv_mgr);
> > -		return rc;
> > -	}
> > -	dmabuf_mgr = rc;
> > +	if (!pool)
> > +		return ERR_PTR(-ENOMEM);
> >  
> > -	rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > -	if (IS_ERR(rc)) {
> > -		tee_shm_pool_mgr_destroy(priv_mgr);
> > -		tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > -	}
> > +	pool->ops = &pool_ops;
> >  
> > -	return rc;
> > +	return pool;
> >  }
> > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> > index 3ca71e3812ed..f121c224e682 100644
> > --- a/drivers/tee/optee/Kconfig
> > +++ b/drivers/tee/optee/Kconfig
> > @@ -7,11 +7,3 @@ config OPTEE
> >  	help
> >  	  This implements the OP-TEE Trusted Execution Environment (TEE)
> >  	  driver.
> > -
> > -config OPTEE_SHM_NUM_PRIV_PAGES
> > -	int "Private Shared Memory Pages"
> > -	default 1
> > -	depends on OPTEE
> > -	help
> > -	  This sets the number of private shared memory pages to be
> > -	  used by OP-TEE TEE driver.
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index ddb8f9ecf307..0c287345f9fe 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> 
> This patch should also remove the #define at the top of core.c:
> 
> #define OPTEE_SHM_NUM_PRIV_PAGES       CONFIG_OPTEE_SHM_NUM_PRIV_PAGES

Good point, I'll fix.

> 
> > @@ -428,33 +428,6 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
> >  	return true;
> >  }
> >  
> > -static struct tee_shm_pool *optee_config_dyn_shm(void)
> > -{
> > -	struct tee_shm_pool_mgr *priv_mgr;
> > -	struct tee_shm_pool_mgr *dmabuf_mgr;
> > -	void *rc;
> > -
> > -	rc = optee_shm_pool_alloc_pages();
> > -	if (IS_ERR(rc))
> > -		return rc;
> > -	priv_mgr = rc;
> > -
> > -	rc = optee_shm_pool_alloc_pages();
> > -	if (IS_ERR(rc)) {
> > -		tee_shm_pool_mgr_destroy(priv_mgr);
> > -		return rc;
> > -	}
> > -	dmabuf_mgr = rc;
> > -
> > -	rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > -	if (IS_ERR(rc)) {
> > -		tee_shm_pool_mgr_destroy(priv_mgr);
> > -		tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > -	}
> > -
> > -	return rc;
> > -}
> > -
> >  static struct tee_shm_pool *
> >  optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
> >  {
> > @@ -468,10 +441,7 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
> >  	phys_addr_t begin;
> >  	phys_addr_t end;
> >  	void *va;
> > -	struct tee_shm_pool_mgr *priv_mgr;
> > -	struct tee_shm_pool_mgr *dmabuf_mgr;
> >  	void *rc;
> > -	const int sz = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> >  
> >  	invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
> >  	if (res.result.status != OPTEE_SMC_RETURN_OK) {
> > @@ -489,11 +459,6 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
> >  	paddr = begin;
> >  	size = end - begin;
> >  
> > -	if (size < 2 * OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE) {
> > -		pr_err("too small shared memory area\n");
> > -		return ERR_PTR(-EINVAL);
> > -	}
> > -
> >  	va = memremap(paddr, size, MEMREMAP_WB);
> >  	if (!va) {
> >  		pr_err("shared memory ioremap failed\n");
> > @@ -501,35 +466,13 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
> >  	}
> >  	vaddr = (unsigned long)va;
> >  
> > -	rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
> > -					    3 /* 8 bytes aligned */);
> > -	if (IS_ERR(rc))
> > -		goto err_memunmap;
> > -	priv_mgr = rc;
> > -
> > -	vaddr += sz;
> > -	paddr += sz;
> > -	size -= sz;
> > -
> > -	rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_SHIFT);
> > +	rc = tee_shm_pool_alloc_res_mem(vaddr, paddr, size,
> > +					9 /* 512 bytes aligned */);
> >  	if (IS_ERR(rc))
> > -		goto err_free_priv_mgr;
> > -	dmabuf_mgr = rc;
> > -
> > -	rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > -	if (IS_ERR(rc))
> > -		goto err_free_dmabuf_mgr;
> > -
> > -	*memremaped_shm = va;
> > -
> > -	return rc;
> > +		memunmap(va);
> > +	else
> > +		*memremaped_shm = va;
> >  
> > -err_free_dmabuf_mgr:
> > -	tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > -err_free_priv_mgr:
> > -	tee_shm_pool_mgr_destroy(priv_mgr);
> > -err_memunmap:
> > -	memunmap(va);
> >  	return rc;
> >  }
> >  
> > @@ -637,7 +580,7 @@ static int optee_probe(struct platform_device *pdev)
> >  	 * Try to use dynamic shared memory if possible
> >  	 */
> >  	if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> > -		pool = optee_config_dyn_shm();
> > +		pool = optee_shm_pool_alloc_pages();
> >  
> >  	/*
> >  	 * If dynamic shared memory is not available or failed - try static one
> > @@ -712,8 +655,7 @@ static int optee_probe(struct platform_device *pdev)
> >  		tee_device_unregister(optee->teedev);
> >  		kfree(optee);
> >  	}
> > -	if (pool)
> > -		tee_shm_pool_free(pool);
> > +	tee_shm_pool_free(pool);
> >  	if (memremaped_shm)
> >  		memunmap(memremaped_shm);
> >  	return rc;
> > diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> > index d767eebf30bd..b036714845c1 100644
> > --- a/drivers/tee/optee/shm_pool.c
> > +++ b/drivers/tee/optee/shm_pool.c
> > @@ -12,13 +12,17 @@
> >  #include "optee_smc.h"
> >  #include "shm_pool.h"
> >  
> > -static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> > -			 struct tee_shm *shm, size_t size)
> > +static int pool_op_alloc(struct tee_shm_pool *pool,
> > +			 struct tee_shm *shm, size_t size, u_int align)
> >  {
> >  	unsigned int order = get_order(size);
> >  	struct page *page;
> >  	int rc = 0;
> >  
> > +	/*
> > +	 * Ignore alignment since this is already going to be page aligned
> > +	 * and there's no need for any larger alignment.
> > +	 */
> >  	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> >  	if (!page)
> >  		return -ENOMEM;
> > @@ -27,47 +31,52 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> >  	shm->paddr = page_to_phys(page);
> >  	shm->size = PAGE_SIZE << order;
> >  
> > -	if (shm->flags & TEE_SHM_DMA_BUF) {
> > +	if (shm->flags & TEE_SHM_REGISTER) {
> >  		unsigned int nr_pages = 1 << order, i;
> >  		struct page **pages;
> >  
> >  		pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
> > -		if (!pages)
> > -			return -ENOMEM;
> > -
> > -		for (i = 0; i < nr_pages; i++) {
> > -			pages[i] = page;
> > -			page++;
> > +		if (!pages) {
> > +			rc = -ENOMEM;
> > +			goto err;
> >  		}
> >  
> > -		shm->flags |= TEE_SHM_REGISTER;
> > +		for (i = 0; i < nr_pages; i++)
> > +			pages[i] = page + i;
> > +
> >  		rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
> >  					(unsigned long)shm->kaddr);
> >  		kfree(pages);
> > +		if (rc)
> > +			goto err;
> >  	}
> >  
> > +	return 0;
> > +
> > +err:
> > +	free_pages((unsigned long)shm->kaddr, order);
> 
> This memory leak fix should be split out and sent to stable. I've sent a
> patch that does this:
> 
>  https://lore.kernel.org/lkml/20210609002326.210024-2-tyhicks@linux.microsoft.com/

Makes sense, I'll rebase on that in the next version.

> 
> >  	return rc;
> >  }
> >  
> > -static void pool_op_free(struct tee_shm_pool_mgr *poolm,
> > +static void pool_op_free(struct tee_shm_pool *pool,
> >  			 struct tee_shm *shm)
> >  {
> > -	if (shm->flags & TEE_SHM_DMA_BUF)
> > +	if (shm->flags & TEE_SHM_REGISTER)
> >  		optee_shm_unregister(shm->ctx, shm);
> >  
> >  	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> >  	shm->kaddr = NULL;
> >  }
> >  
> > -static void pool_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
> > +static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> >  {
> > -	kfree(poolm);
> > +	kfree(pool);
> >  }
> >  
> > -static const struct tee_shm_pool_mgr_ops pool_ops = {
> > +static const struct tee_shm_pool_ops pool_ops = {
> >  	.alloc = pool_op_alloc,
> >  	.free = pool_op_free,
> > -	.destroy_poolmgr = pool_op_destroy_poolmgr,
> > +	.destroy_pool = pool_op_destroy_pool,
> >  };
> >  
> >  /**
> > @@ -76,14 +85,14 @@ static const struct tee_shm_pool_mgr_ops pool_ops = {
> >   * This pool is used when OP-TEE supports dymanic SHM. In this case
> >   * command buffers and such are allocated from kernel's own memory.
> >   */
> > -struct tee_shm_pool_mgr *optee_shm_pool_alloc_pages(void)
> > +struct tee_shm_pool *optee_shm_pool_alloc_pages(void)
> >  {
> > -	struct tee_shm_pool_mgr *mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
> > +	struct tee_shm_pool *pool = kzalloc(sizeof(*pool), GFP_KERNEL);
> >  
> > -	if (!mgr)
> > +	if (!pool)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > -	mgr->ops = &pool_ops;
> > +	pool->ops = &pool_ops;
> >  
> > -	return mgr;
> > +	return pool;
> >  }
> > diff --git a/drivers/tee/optee/shm_pool.h b/drivers/tee/optee/shm_pool.h
> > index 28109d991c4b..7024b9926ada 100644
> > --- a/drivers/tee/optee/shm_pool.h
> > +++ b/drivers/tee/optee/shm_pool.h
> > @@ -9,6 +9,6 @@
> >  
> >  #include <linux/tee_drv.h>
> >  
> > -struct tee_shm_pool_mgr *optee_shm_pool_alloc_pages(void);
> > +struct tee_shm_pool *optee_shm_pool_alloc_pages(void);
> >  
> >  #endif
> > diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> > index e55204df31ce..72376cf38bc0 100644
> > --- a/drivers/tee/tee_private.h
> > +++ b/drivers/tee/tee_private.h
> > @@ -12,17 +12,6 @@
> >  #include <linux/mutex.h>
> >  #include <linux/types.h>
> >  
> > -/**
> > - * struct tee_shm_pool - shared memory pool
> > - * @private_mgr:	pool manager for shared memory only between kernel
> > - *			and secure world
> > - * @dma_buf_mgr:	pool manager for shared memory exported to user space
> > - */
> > -struct tee_shm_pool {
> > -	struct tee_shm_pool_mgr *private_mgr;
> > -	struct tee_shm_pool_mgr *dma_buf_mgr;
> > -};
> > -
> >  #define TEE_DEVICE_FLAG_REGISTERED	0x1
> >  #define TEE_MAX_DEV_NAME_LEN		32
> >  
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 00472f5ce22e..b9dbf4bce149 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -39,14 +39,7 @@ static void tee_shm_release(struct tee_shm *shm)
> >  	}
> >  
> >  	if (shm->flags & TEE_SHM_POOL) {
> > -		struct tee_shm_pool_mgr *poolm;
> > -
> > -		if (shm->flags & TEE_SHM_DMA_BUF)
> > -			poolm = teedev->pool->dma_buf_mgr;
> > -		else
> > -			poolm = teedev->pool->private_mgr;
> > -
> > -		poolm->ops->free(poolm, shm);
> > +		teedev->pool->ops->free(teedev->pool, shm);
> >  	} else if (shm->flags & TEE_SHM_REGISTER) {
> >  		int rc = teedev->desc->ops->shm_unregister(shm->ctx, shm);
> >  
> > @@ -106,8 +99,8 @@ static const struct dma_buf_ops tee_shm_dma_buf_ops = {
> >  struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> >  {
> >  	struct tee_device *teedev = ctx->teedev;
> > -	struct tee_shm_pool_mgr *poolm = NULL;
> >  	struct tee_shm *shm;
> > +	size_t align;
> 
> You use u_int for the align parameter type in the .alloc function
> prototype. Perhaps switch it to size_t to match the argument that
> you're passing in?

OK, I'll fix.

> 
> >  	void *ret;
> >  	int rc;
> >  
> > @@ -139,12 +132,18 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> >  
> >  	shm->flags = flags | TEE_SHM_POOL;
> >  	shm->ctx = ctx;
> > -	if (flags & TEE_SHM_DMA_BUF)
> > -		poolm = teedev->pool->dma_buf_mgr;
> > -	else
> > -		poolm = teedev->pool->private_mgr;
> > +	if (flags & TEE_SHM_DMA_BUF) {
> > +		align = PAGE_SIZE;
> > +		/*
> > +		 * Request to register the shm in the pool allocator below
> > +		 * if supported.
> > +		 */
> > +		shm->flags |= TEE_SHM_REGISTER;
> > +	} else {
> > +		align = 2 * sizeof(long);
> 
> Where does this alignment requirement come from?

There are some Arm instructions that requires double word aligned pointers.

I believe it's good practice for a memory allocator to keep the returned
buffers at least double word aligned, unless there's a specific reason
to do otherwise.

> 
> > +	}
> >  
> > -	rc = poolm->ops->alloc(poolm, shm, size);
> > +	rc = teedev->pool->ops->alloc(teedev->pool, shm, size, align);
> >  	if (rc) {
> >  		ret = ERR_PTR(rc);
> >  		goto err_kfree;
> > @@ -184,7 +183,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> >  		mutex_unlock(&teedev->mutex);
> >  	}
> >  err_pool_free:
> > -	poolm->ops->free(poolm, shm);
> > +	teedev->pool->ops->free(teedev->pool, shm);
> >  err_kfree:
> >  	kfree(shm);
> >  err_dev_put:
> > diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
> > index a9f9d50fd181..5ceab73ff1b5 100644
> > --- a/drivers/tee/tee_shm_pool.c
> > +++ b/drivers/tee/tee_shm_pool.c
> > @@ -9,14 +9,16 @@
> >  #include <linux/tee_drv.h>
> >  #include "tee_private.h"
> >  
> > -static int pool_op_gen_alloc(struct tee_shm_pool_mgr *poolm,
> > -			     struct tee_shm *shm, size_t size)
> > +static int pool_op_gen_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
> > +			     size_t size, u_int align)
> >  {
> >  	unsigned long va;
> > -	struct gen_pool *genpool = poolm->private_data;
> > -	size_t s = roundup(size, 1 << genpool->min_alloc_order);
> > +	struct gen_pool *genpool = pool->private_data;
> > +	size_t a = max(align, 1U << genpool->min_alloc_order);
> > +	struct genpool_data_align data = { .align = a };
> > +	size_t s = roundup(size, a);
> >  
> > -	va = gen_pool_alloc(genpool, s);
> > +	va = gen_pool_alloc_algo(genpool, s, gen_pool_first_fit_align, &data);
> 
> This is an algo change from the existing use of gen_pool_best_fit. Was
> that intentional? If so, a mention of the reasoning for this change in
> the commit message might be helpful in the future.

Best-fit was the default choice and not a conscious choice from the
beginning. We're doing first-fit now since that supports requesting an
alignment, while best-fit doesn't. I'll add something in the commit
message.

Cheers,
Jens
