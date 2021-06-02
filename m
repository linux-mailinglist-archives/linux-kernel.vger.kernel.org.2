Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15838398D47
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhFBOl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhFBOl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:41:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF6D7613AA;
        Wed,  2 Jun 2021 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622644783;
        bh=jI+GIBfW+TTSPEkqnl9cajZsedb1xU15s5PN+0Ulsm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLA8dEJsn5AN9LP9sVq8efoYniWRR1tfgU0lv7D1Z1C0PGsBAIivJU601YNX0koiX
         ZAfeGHRjs49+Nj1WYzTRQ+pFlQKUtNpi7FXoxto+ya+HEffNbDKjmWGhb0uBBXmUMG
         omPTip3iY20rdDSiiUkUeqZHFGc6FcoMBxzTNKgIT95Q4RmueG7vq5nWQIKpFwQRVv
         kPZpqWrtB+vSQZvfh89RPF9UiNSwaMYxAZba80cZWBHUoz0D8eP8atmVW04j7IlY9U
         FTFtalztjYK6q9/YGuMQrNqgAXj7dpilUUMuWZbm1+KiwNnwSKTKsLw3BK/vK9pmB2
         0Glq1dhflBldw==
Date:   Wed, 2 Jun 2021 07:39:40 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-nvme@lists.infradead.org, dan.j.williams@intel.com,
        logang@deltatee.com, linux-mm@kvack.org, hch@lst.de,
        sagi@grimberg.me, david@redhat.com, oren@nvidia.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3/3] nvme-pci: align CMB size according to P2PMEM
 alignment
Message-ID: <20210602143940.GA5751@dhcp-10-100-145-180.wdc.com>
References: <20210602111055.10480-1-mgurtovoy@nvidia.com>
 <20210602111055.10480-4-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602111055.10480-4-mgurtovoy@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 02:10:55PM +0300, Max Gurtovoy wrote:
> P2PMEM is using mhp framework to connect to the memory subsystem. In
> case the CMB size is not compatible to mhp alignment, the CMB mapping
> will fail. Use pci_p2pdma_align_size to align CMB size in order to
> successfully map non-aligned original CMB.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/nvme/host/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a29b170701fc..1197263b4cd0 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1817,6 +1817,7 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>  	u64 size, offset;
>  	resource_size_t bar_size;
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +	unsigned long nr_pages, min_align;

These new variables don't appear to be used anywhere.

>  	int bar;
>  
>  	if (dev->cmb_size)
> @@ -1856,6 +1857,12 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>  	if (size > bar_size - offset)
>  		size = bar_size - offset;
>  
> +	size = pci_p2pdma_align_size(size);
> +	if (!size) {
> +		dev_warn(dev->ctrl.device, "CMB size is 0 after alignment\n");
> +		return;
> +	}
> +
>  	if (pci_p2pdma_add_resource(pdev, bar, size, offset)) {
>  		dev_warn(dev->ctrl.device,
>  			 "failed to register the CMB\n");
> -- 
