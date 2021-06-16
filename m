Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6B3A9E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhFPPBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:01:48 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:58032 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbhFPPBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1623855582; x=1655391582;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZCHt6g2k/RAsH8izkGc8n1Ws8mT2akbubiQMIWE/5EI=;
  b=AHpT9Cd0fXBsQ/USgxpiA4x+hjvxxlfZ//tJZlwQadyqdOCmIvNgmL1E
   QUtuE3L89qzgwuo0Gvt6G4mDzAZ7ppyFHukkrVZB0PNEanY+YHyUjVXBo
   1IyHaEEqvpVARb0qYHU1/m3RiyGdprYAOQ2dRmDiAg4EJb5UqVAja69Ng
   U=;
X-IronPort-AV: E=Sophos;i="5.83,278,1616457600"; 
   d="scan'208";a="120612442"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 16 Jun 2021 14:59:32 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 80DB9A1F78;
        Wed, 16 Jun 2021 14:59:31 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.144) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Wed, 16 Jun 2021 14:59:28 +0000
Subject: Re: [PATCH v2 2/2] habanalabs: add support for dma-buf exporter
To:     Oded Gabbay <ogabbay@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, Tomer Tayar <ttayar@habana.ai>
References: <20210615085326.16134-1-ogabbay@kernel.org>
 <20210615085326.16134-2-ogabbay@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <358b47b4-a7cc-deb8-9f29-92d3a0169c2d@amazon.com>
Date:   Wed, 16 Jun 2021 17:59:22 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210615085326.16134-2-ogabbay@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.144]
X-ClientProxiedBy: EX13D31UWA004.ant.amazon.com (10.43.160.217) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2021 11:53, Oded Gabbay wrote:
> @@ -1346,9 +1372,11 @@ struct hl_ctx {
>  	struct mutex			mem_hash_lock;
>  	struct mutex			mmu_lock;
>  	struct mutex			hw_block_list_lock;
> +	struct mutex			dmabuf_list_lock;
>  	struct list_head		debugfs_list;
>  	struct list_head		pending_cb_list;
>  	struct list_head		hw_block_mem_list;
> +	struct list_head		dmabuf_list;

Am I missing where this list is used? I only see insertions and deletions, but
what is it used for?

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
> +
> +	if (!IS_ALIGNED(device_addr, DMA_BUF_MEM_ADDR_ALIGNMENT)) {
> +		dev_err(hdev->dev,
> +			"address of exported device memory should be aligned to 0x%x, address 0x%llx\n",
> +			DMA_BUF_MEM_ADDR_ALIGNMENT, device_addr);
> +		return -EINVAL;
> +	}
> +
> +	if (!size) {
> +		dev_err(hdev->dev,
> +			"size of exported device memory should be greater than 0\n");

These cases can be caused by user providing wrong input, right? Maybe debug
level is more appropriate to prevent spamming dmesg.

> +		return -EINVAL;
> +	}
> +
> +	if (!IS_ALIGNED(size, DMA_BUF_MEM_SIZE_ALIGNMENT)) {
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
> +
> +	spin_unlock(&vm->idr_lock);
> +
> +	vm_type = (enum vm_type_t *) phys_pg_pack;

Why is this casting a struct instead of accessing its first field?

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

So these devices either work with virtual or physical memory, but the memory is
pinned regardless?

> +		memset(args, 0, sizeof(*args));
> +		args->out.fd = dmabuf_fd;
> +		break;
> +
>  	default:
>  		dev_err(hdev->dev, "Unknown opcode for memory IOCTL\n");
>  		rc = -ENOTTY;
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index a673e404f777..3a66e56d7cd5 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -685,6 +685,7 @@ static int gaudi_early_init(struct hl_device *hdev)
>  	}
>  
>  	prop->dram_pci_bar_size = pci_resource_len(pdev, HBM_BAR_ID);
> +	hdev->dram_pci_bar_start = pci_resource_start(pdev, HBM_BAR_ID);
>  
>  	/* If FW security is enabled at this point it means no access to ELBI */
>  	if (hdev->asic_prop.fw_security_enabled) {
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index 5a837c0b4d76..ad2c6f788030 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -617,6 +617,7 @@ static int goya_early_init(struct hl_device *hdev)
>  	}
>  
>  	prop->dram_pci_bar_size = pci_resource_len(pdev, DDR_BAR_ID);
> +	hdev->dram_pci_bar_start = pci_resource_start(pdev, DDR_BAR_ID);
>  
>  	/* If FW security is enabled at this point it means no access to ELBI */
>  	if (hdev->asic_prop.fw_security_enabled) {
> 

Pedantic checkpatch has a lot to say about this patch :).

Reviewed-by: Gal Pressman <galpress@amazon.com>
