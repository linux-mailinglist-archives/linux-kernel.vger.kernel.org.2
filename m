Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25EA3A7AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhFOJkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231728AbhFOJjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:39:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E8CA6142E;
        Tue, 15 Jun 2021 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623749858;
        bh=cIuVJZS3Ve0C7PhQA5NlpZsVpNTpOsPlmjnBkrc2eXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+kwxVK54DI3YoWW5SDfauf4/oc7YbbzvXm1O4n1zaT3PnOynoVJWngUh0c9FjQBV
         7/sjTHFH2qf68uxjpIjbJJV2hhAmTKp2ucGtZeuadpSfr0SqWUD88MXzW2t0cTS5Ub
         eJ/P28IRIDv+CG/95HKDKA71TA5XnkfJ9fFKdwIg=
Date:   Tue, 15 Jun 2021 11:37:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tomer Tayar <ttayar@habana.ai>
Subject: Re: [PATCH v2 2/2] habanalabs: add support for dma-buf exporter
Message-ID: <YMh038iFBgzx+7aB@kroah.com>
References: <20210615085326.16134-1-ogabbay@kernel.org>
 <20210615085326.16134-2-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615085326.16134-2-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:53:26AM +0300, Oded Gabbay wrote:
> +struct hl_dmabuf_wrapper {
> +	struct dma_buf			*dmabuf;
> +	struct hl_ctx			*ctx;
> +	struct hl_vm_phys_pg_pack	*phys_pg_pack;
> +	struct list_head		node;
> +	struct sg_table			sgt;
> +	u64				total_size;
> +	u64				handle;
> +	int				fd;

As this reflects the __u64 you send to userspace, shouldn't the fd also
be u64 here?  Or does it really not matter?

> @@ -1598,6 +1626,7 @@ struct hl_vm_hw_block_list_node {
>   * @npages: num physical pages in the pack.
>   * @total_size: total size of all the pages in this list.
>   * @mapping_cnt: number of shared mappings.
> + * @exporting_cnt: number of dma-buf exporting.
>   * @asid: the context related to this list.
>   * @page_size: size of each page in the pack.
>   * @flags: HL_MEM_* flags related to this list.
> @@ -1612,6 +1641,7 @@ struct hl_vm_phys_pg_pack {
>  	u64			npages;
>  	u64			total_size;
>  	atomic_t		mapping_cnt;
> +	atomic_t		exporting_cnt;

Shouldn't this just be a refcount_t?  It seems like you are treating it
like one.

> @@ -347,6 +354,13 @@ static int free_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args)
>  			return -EINVAL;
>  		}
>  
> +		if (atomic_read(&phys_pg_pack->exporting_cnt) > 0) {
> +			dev_err(hdev->dev,
> +				"handle %u is exported, cannot free\n",	handle);

What prevents the count from changing right after you read it?  This
usually feels wrong.  What protects this from happening?

> +			spin_unlock(&vm->idr_lock);

Ah, the lock?  Then why is this atomic?


> +			return -EINVAL;
> +		}
> +
>  		/*
>  		 * must remove from idr before the freeing of the physical
>  		 * pages as the refcount of the pool is also the trigger of the
> @@ -1416,13 +1430,391 @@ int hl_hw_block_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +static int hl_dmabuf_attach(struct dma_buf *dmabuf,
> +				struct dma_buf_attachment *attachment)
> +{
> +	struct hl_dmabuf_wrapper *hl_dmabuf = dmabuf->priv;
> +	struct hl_device *hdev = hl_dmabuf->ctx->hdev;
> +
> +	dev_dbg(hdev->dev, "attaching dma-buf, handle 0x%llx, fd %d\n",
> +		hl_dmabuf->handle, hl_dmabuf->fd);
> +
> +	attachment->priv = hl_dmabuf;
> +
> +	return 0;
> +}
> +
> +static void hl_dmabuf_detach(struct dma_buf *dmabuf,
> +				struct dma_buf_attachment *attachment)
> +{
> +	struct hl_dmabuf_wrapper *hl_dmabuf = dmabuf->priv;
> +	struct hl_device *hdev = hl_dmabuf->ctx->hdev;
> +
> +	dev_dbg(hdev->dev, "detaching dma-buf, handle 0x%llx, fd %d\n",
> +		hl_dmabuf->handle, hl_dmabuf->fd);

Nothing needs to happen in detach?

Not clearing ->priv?

If not, why have this callback at all?

> +}
> +
> +static struct sg_table *hl_map_dmabuf(struct dma_buf_attachment *attachment,
> +					enum dma_data_direction dir)
> +{
> +	struct hl_dmabuf_wrapper *hl_dmabuf = attachment->priv;
> +	struct hl_device *hdev = hl_dmabuf->ctx->hdev;
> +
> +	dev_dbg(hdev->dev, "mapping dma-buf, handle 0x%llx, fd %d\n",
> +		hl_dmabuf->handle, hl_dmabuf->fd);
> +
> +	return &hl_dmabuf->sgt;
> +}
> +
> +static void hl_unmap_dmabuf(struct dma_buf_attachment *attachment,
> +				  struct sg_table *table,
> +				  enum dma_data_direction dir)
> +{
> +	struct hl_dmabuf_wrapper *hl_dmabuf = attachment->priv;
> +	struct hl_device *hdev = hl_dmabuf->ctx->hdev;
> +
> +	dev_dbg(hdev->dev, "unmapping dma-buf, handle 0x%llx, fd %d\n",
> +		hl_dmabuf->handle, hl_dmabuf->fd);

Same here, why have this?

> +}
> +
> +static void hl_release_dmabuf(struct dma_buf *dmabuf)
> +{
> +	struct hl_dmabuf_wrapper *hl_dmabuf = dmabuf->priv;
> +	struct hl_ctx *ctx = hl_dmabuf->ctx;
> +	struct hl_device *hdev = ctx->hdev;
> +
> +	dev_dbg(hdev->dev, "releasing dma-buf, handle 0x%llx, fd %d\n",
> +		hl_dmabuf->handle, hl_dmabuf->fd);

You do know about ftrace, right?  :)

These debugging lines should all now be removed.

> +/**
> + * export_dmabuf_from_addr() - export a dma-buf object for the given memory
> + *                             address and size.
> + * @ctx: pointer to the context structure.
> + * @device_addr:  device memory physical address.
> + * @size: size of device memory.
> + * @flags: DMA-BUF file/FD flags.
> + * @dmabuf_fd: pointer to result FD that represents the dma-buf object.
> + *
> + * Create and export a dma-buf object for an existing memory allocation inside
> + * the device memory, and return a FD which is associated with the dma-buf
> + * object.
> + *
> + * Return: 0 on success, non-zero for failure.
> + */
> +static int export_dmabuf_from_addr(struct hl_ctx *ctx, u64 device_addr,
> +					u64 size, int flags, int *dmabuf_fd)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	struct asic_fixed_properties *prop = &hdev->asic_prop;
> +	struct hl_dmabuf_wrapper *hl_dmabuf;
> +	int rc;
> +
> +	dev_dbg(hdev->dev, "exporting dma-buf for addr 0x%llx, size 0x%llx\n",
> +			device_addr, size);

Again, ftrace is your friend.

> +
> +	if (!IS_ALIGNED(device_addr, DMA_BUF_MEM_ADDR_ALIGNMENT)) {

How can this happen?

> +		dev_err(hdev->dev,
> +			"address of exported device memory should be aligned to 0x%x, address 0x%llx\n",
> +			DMA_BUF_MEM_ADDR_ALIGNMENT, device_addr);
> +		return -EINVAL;
> +	}
> +
> +	if (!size) {
> +		dev_err(hdev->dev,
> +			"size of exported device memory should be greater than 0\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!IS_ALIGNED(size, DMA_BUF_MEM_SIZE_ALIGNMENT)) {

Why would size need to be "aligned"?

> +		dev_err(hdev->dev,
> +			"size of exported device memory should be aligned to 0x%x, size 0x%llx\n",
> +			DMA_BUF_MEM_SIZE_ALIGNMENT, device_addr);
> +		return -EINVAL;
> +	}
> +
> +	if (device_addr < prop->dram_user_base_address ||
> +			device_addr + size > prop->dram_end_address) {
> +		dev_err(hdev->dev,
> +			"DRAM memory range is outside of DRAM boundaries, address 0x%llx, size 0x%llx\n",
> +			device_addr, size);
> +		return -EINVAL;
> +	}
> +
> +	hl_dmabuf = kzalloc(sizeof(*hl_dmabuf), GFP_KERNEL);
> +	if (!hl_dmabuf)
> +		return -ENOMEM;
> +
> +	hl_dmabuf->handle = device_addr;
> +	hl_dmabuf->total_size = size;
> +
> +	rc = export_dmabuf_common(ctx, hl_dmabuf, &device_addr, 1, size, flags,
> +					dmabuf_fd);
> +	if (rc)
> +		goto err_free_dmabuf_wrapper;
> +
> +	return 0;
> +
> +err_free_dmabuf_wrapper:
> +	kfree(hl_dmabuf);
> +	return rc;
> +}
> +
> +/**
> + * export_dmabuf_from_handle() - export a dma-buf object for the given memory
> + *                               handle.
> + * @ctx: pointer to the context structure.
> + * @handle: device memory allocation handle.
> + * @flags: DMA-BUF file/FD flags.
> + * @dmabuf_fd: pointer to result FD that represents the dma-buf object.
> + *
> + * Create and export a dma-buf object for an existing memory allocation inside
> + * the device memory, and return a FD which is associated with the dma-buf
> + * object.
> + *
> + * Return: 0 on success, non-zero for failure.
> + */
> +static int export_dmabuf_from_handle(struct hl_ctx *ctx, u64 handle, int flags,
> +					int *dmabuf_fd)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	struct hl_vm_phys_pg_pack *phys_pg_pack;
> +	struct hl_dmabuf_wrapper *hl_dmabuf;
> +	struct hl_vm *vm = &hdev->vm;
> +	enum vm_type_t *vm_type;
> +	u32 idr_handle;
> +	int rc;
> +
> +	dev_dbg(hdev->dev, "exporting dma-buf for handle 0x%llx\n", handle);
> +
> +	idr_handle = lower_32_bits(handle);
> +
> +	spin_lock(&vm->idr_lock);
> +
> +	phys_pg_pack = idr_find(&vm->phys_pg_pack_handles, idr_handle);
> +	if (!phys_pg_pack) {
> +		spin_unlock(&vm->idr_lock);
> +		dev_err(hdev->dev, "no match for handle 0x%x\n", idr_handle);
> +		return -EINVAL;
> +	}
> +
> +	/* increment now to avoid freeing device memory while exporting */
> +	atomic_inc(&phys_pg_pack->exporting_cnt);

Looks like you do this under a lock, so why have this be atomic at all?

> +
> +	spin_unlock(&vm->idr_lock);
> +
> +	vm_type = (enum vm_type_t *) phys_pg_pack;
> +	if (*vm_type != VM_TYPE_PHYS_PACK) {
> +		dev_err(hdev->dev, "handle 0x%llx is not for DRAM memory\n",
> +				handle);
> +		rc = -EINVAL;
> +		goto err_dec_exporting_cnt;
> +	}
> +
> +	hl_dmabuf = kzalloc(sizeof(*hl_dmabuf), GFP_KERNEL);
> +	if (!hl_dmabuf) {
> +		rc = -ENOMEM;
> +		goto err_dec_exporting_cnt;
> +	}
> +
> +	hl_dmabuf->phys_pg_pack = phys_pg_pack;
> +	hl_dmabuf->handle = handle;
> +	hl_dmabuf->total_size = phys_pg_pack->total_size;
> +
> +	rc = export_dmabuf_common(ctx, hl_dmabuf, phys_pg_pack->pages,
> +				phys_pg_pack->npages, phys_pg_pack->page_size,
> +				flags, dmabuf_fd);
> +	if (rc)
> +		goto err_free_dmabuf_wrapper;
> +
> +	return 0;
> +
> +err_free_dmabuf_wrapper:
> +	kfree(hl_dmabuf);
> +err_dec_exporting_cnt:
> +	atomic_dec(&phys_pg_pack->exporting_cnt);

No lock here?

> +	return rc;
> +}
> +
>  static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
>  {
>  	struct hl_device *hdev = hpriv->hdev;
>  	struct hl_ctx *ctx = hpriv->ctx;
>  	u64 block_handle, device_addr = 0;
>  	u32 handle = 0, block_size;
> -	int rc;
> +	int rc, dmabuf_fd = -EBADF;
>  
>  	switch (args->in.op) {
>  	case HL_MEM_OP_ALLOC:
> @@ -1471,6 +1863,16 @@ static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
>  		args->out.block_size = block_size;
>  		break;
>  
> +	case HL_MEM_OP_EXPORT_DMABUF_FD:
> +		rc = export_dmabuf_from_addr(ctx,
> +				args->in.export_dmabuf_fd.handle,
> +				args->in.export_dmabuf_fd.mem_size,
> +				args->in.flags,
> +				&dmabuf_fd);
> +		memset(args, 0, sizeof(*args));
> +		args->out.fd = dmabuf_fd;

No need to copy_to_user()?

> +		break;
> +
>  	default:
>  		dev_err(hdev->dev, "Unknown opcode for memory IOCTL\n");
>  		rc = -ENOTTY;
> @@ -1489,7 +1891,7 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
>  	struct hl_ctx *ctx = hpriv->ctx;
>  	u64 block_handle, device_addr = 0;
>  	u32 handle = 0, block_size;
> -	int rc;
> +	int rc, dmabuf_fd = -EBADF;
>  
>  	if (!hl_device_operational(hdev, &status)) {
>  		dev_warn_ratelimited(hdev->dev,
> @@ -1580,6 +1982,22 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
>  		args->out.block_size = block_size;
>  		break;
>  
> +	case HL_MEM_OP_EXPORT_DMABUF_FD:
> +		if (hdev->asic_prop.dram_supports_virtual_memory)
> +			rc = export_dmabuf_from_handle(ctx,
> +					args->in.export_dmabuf_fd.handle,
> +					args->in.flags,
> +					&dmabuf_fd);
> +		else
> +			rc = export_dmabuf_from_addr(ctx,
> +					args->in.export_dmabuf_fd.handle,
> +					args->in.export_dmabuf_fd.mem_size,
> +					args->in.flags,
> +					&dmabuf_fd);
> +		memset(args, 0, sizeof(*args));
> +		args->out.fd = dmabuf_fd;

Same here, no need to copy_to_user()?

thanks,

greg k-h
