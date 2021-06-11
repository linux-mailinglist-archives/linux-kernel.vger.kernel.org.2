Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E643A3B47
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 07:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFKFTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 01:19:31 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:46057 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhFKFTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 01:19:30 -0400
Received: by mail-lj1-f171.google.com with SMTP id a19so4800605ljq.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 22:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyj5SdPfNyQtiASRP36GPtu32bXzI+wL6n1PWw7J0sI=;
        b=gJATbDLIE1ZTmNmyxCMb3WaAShm5EV56gII2UEwB1nmyrs3ytAryxfqMgZJnHcFiSh
         RfXvt/8+UX3axvsE93C5aqsNaaLmpbJHzkdlQxk0gKF0SqMz9G7t4aydro9wwPCI40I7
         L1v1otgLI7VgKa6g09nRvkaq52+GyppWeBsLB5uShR5vLa5thyAA5K1hbVuf+NnTGe67
         cFufoLWlvEjSWvlEthm7aIDZaT5yxp6YCJ/MK08neSy96rqA6rZ26sMU8vtDnrtepthG
         ANKXSUdZxdl+oGKeqZbXhgtKmrw34ibPI2fZ/laduNThZXmtC143rb3+ZGAuF9RHsFi+
         1Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyj5SdPfNyQtiASRP36GPtu32bXzI+wL6n1PWw7J0sI=;
        b=WmhlszTyM3AUaIMIkypwxNYuxC+iWH+jEHwGxKHS5IZ1geay1+wOMTNPjFDZKBbzEH
         yQXUlfWXep4j492FrmLi1juEsHYsgpCxJP/k+3N3P6eQUm4qw1lrB2lf+u6C694k60TI
         SffN00Q9b9DYJvcr5B4+kFEBh06hUaF/aY9FXcvYR97szG2ga9AtktLmeP09XN69NXIt
         DbDY5kLjThlvipzjnDgChg0wi8O5Hke5YAkBw6Eg/tsbMQPHYP93V/o2kDTxf8uSJTtb
         xaoPecHFtWjqSmBEv9FMngt8ljTXPyMSG4CkqDM+6brOu6bKlxoVmZK8byCT30fRtRiX
         0Bhg==
X-Gm-Message-State: AOAM532O743ZUxgTgflytsS97PSaPLYDEqi2YKIkz34xVMFPbCtf71LB
        mUkJhl48EL+jWwS3G71c+X8xoBlVjlkBeg2CCTZPTg==
X-Google-Smtp-Source: ABdhPJz5i3I6GjTKhbtNhG2oTgwzlpu84D8lr6tgvjr9hfM31HGkzcRmKSVL+L31wq4Sx82KRerKOPia9J/1sxEKqzA=
X-Received: by 2002:a2e:2f09:: with SMTP id v9mr1525954ljv.152.1623388592055;
 Thu, 10 Jun 2021 22:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com> <20210610210913.536081-7-tyhicks@linux.microsoft.com>
In-Reply-To: <20210610210913.536081-7-tyhicks@linux.microsoft.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 11 Jun 2021 10:46:20 +0530
Message-ID: <CAFA6WYMcGGkAAWxK2vmM8CNsgTKJpegkZZjJZy4pvXhKe9WGvA@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] tee: Support kernel shm registration without
 dma-buf backing
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        op-tee@lists.trustedfirmware.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 at 02:39, Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
>
> Uncouple the registration of kernel shared memory buffers from the
> TEE_SHM_DMA_BUF flag. Drivers may wish to allocate multi-page contiguous
> shared memory regions but do not need them to be backed by a dma-buf
> when the memory region is only used by the driver.
>
> If the TEE implementation does not require shared memory to be
> registered, clear the flag prior to calling the corresponding pool alloc
> function. Update the OP-TEE driver to respect TEE_SHM_REGISTER, rather
> than TEE_SHM_DMA_BUF, when deciding whether to (un)register on
> alloc/free operations.

> The AMD-TEE driver continues to ignore the
> TEE_SHM_REGISTER flag.
>

That's the main point that no other TEE implementation would honour
TEE_SHM_REGISTER and I think it's just the incorrect usage of
TEE_SHM_REGISTER flag to suffice OP-TEE underlying implementation.

> Allow callers of tee_shm_alloc_kernel_buf() to allocate and register a
> shared memory region without the backing of dma-buf.
>
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/tee/optee/shm_pool.c |  5 ++---
>  drivers/tee/tee_shm.c        | 13 +++++++++++--
>  2 files changed, 13 insertions(+), 5 deletions(-)
>

This patch is just mixing two separate approaches to TEE shared
memory. Have a look at alternative suggestions below.

> diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> index da06ce9b9313..6054343a29fb 100644
> --- a/drivers/tee/optee/shm_pool.c
> +++ b/drivers/tee/optee/shm_pool.c
> @@ -27,7 +27,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>         shm->paddr = page_to_phys(page);
>         shm->size = PAGE_SIZE << order;
>
> -       if (shm->flags & TEE_SHM_DMA_BUF) {
> +       if (shm->flags & TEE_SHM_REGISTER) {

Here you can just do following check instead:

       if (!(shm->flags & TEE_SHM_PRIV)) {

And this flag needs to be passed from the call sites here [1] [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tee/optee/core.c#n280
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tee/optee/call.c#n186

>                 unsigned int nr_pages = 1 << order, i;
>                 struct page **pages;
>
> @@ -42,7 +42,6 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>                         page++;
>                 }
>
> -               shm->flags |= TEE_SHM_REGISTER;

This should remain as it is.

>                 rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
>                                         (unsigned long)shm->kaddr);
>                 kfree(pages);
> @@ -60,7 +59,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>  static void pool_op_free(struct tee_shm_pool_mgr *poolm,
>                          struct tee_shm *shm)
>  {
> -       if (shm->flags & TEE_SHM_DMA_BUF)
> +       if (shm->flags & TEE_SHM_REGISTER)

Same as above.

>                 optee_shm_unregister(shm->ctx, shm);
>
>         free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index c65e44707cd6..26a76f817c57 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -117,7 +117,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF))) {
> +       if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER))) {

No need for this change.

>                 dev_err(teedev->dev.parent, "invalid shm flags 0x%x", flags);
>                 return ERR_PTR(-EINVAL);
>         }
> @@ -137,6 +137,15 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
>                 goto err_dev_put;
>         }
>
> +       if (!teedev->desc->ops->shm_register ||
> +           !teedev->desc->ops->shm_unregister) {
> +               /* registration is not required by the TEE implementation */
> +               flags &= ~TEE_SHM_REGISTER;
> +       } else if (flags & TEE_SHM_DMA_BUF) {
> +               /* all dma-buf backed shm allocations are registered */
> +               flags |= TEE_SHM_REGISTER;
> +       }
> +

This change isn't required as well as underlying TEE implementation:
OP-TEE in this case knows how to implement shared memory allocation
whether to use reserved shared memory pool or dynamic shared memory
pool. For more details see shared memory pool creation in
optee_probe().

>         shm->flags = flags | TEE_SHM_POOL;
>         shm->ctx = ctx;
>         if (flags & TEE_SHM_DMA_BUF)
> @@ -207,7 +216,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc);
>   */
>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
>  {
> -       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_REGISTER);

Here it could just be:

       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED);

-Sumit

>  }
>  EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
>
> --
> 2.25.1
>
