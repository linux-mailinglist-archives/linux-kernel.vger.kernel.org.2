Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098B836CBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbhD0Tsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbhD0Tsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:48:41 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87079C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:47:56 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q136so40274169qka.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AjrAoCiFehNYhoJcuGAEBZrhhpGrqdOWIeMvT8fZfQE=;
        b=graEdUl6h9bRI6879DOV+jpvit1zfjy1sguqq286DV1F/2+gigtoCBWC3FM8vofgQl
         frU5tmA5Yo5liP+gMHQyrmUq7cN1npCBY2bA3DqaAxH06CuLnP0NWeNuc8kjlvuN1iJn
         RdKbTcJWt7HM17bR6iMbdLR+Jh0BXdc3dZvBEz4QmXJ6kQmenIxZg2f5iyAHzEGw5iRb
         rqTOz8C5voOg+HeAyWzUJQcZ/iGz5ZMG+AB4pgyf8vAxm5rXA349KgOhQxhfMCafKqsg
         8i7gUoB/5zWgVNo8NelgGibkEKBeWRzNqnyj5N71rIYwMTksaYGDH0BittbK3OmOjGkd
         CYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AjrAoCiFehNYhoJcuGAEBZrhhpGrqdOWIeMvT8fZfQE=;
        b=Yp8b+qTNwc8lbr5Y0odOsZqvZqKXNFh3sMsBaUx8t3wNCQF1lYRiPZfdojjfNZ/TDo
         kZ4lOd5fnu4/ZwxLnQTDE+n62d6wPxrOordDMGYiDsmrx9KUd+5mB2OQhBwmPvf6vDv7
         O48NDLKNNIIJEpqi4IwSI6V/w6BAFopu7xw7den3EaEKjhjRvMiWNtyZ43EkpcWVNV6a
         3NHhXFsi0THRQ5FOmTpi0rimerZFDiGXeK92vbDb240UXLvDCm6oBnuOZdJszv58JJeu
         fPDqJZx3rN6PaocmJvvK7BJfruYH2xuXzjef8FWdqaonZ9IfFNC5jc8NbcoyD90WMtNT
         aQvw==
X-Gm-Message-State: AOAM531iwSjRYLOsY+/6aZpUuPH53EEKCBD49wzPI+r0+LvD2Q1LmdZU
        ZLpZvHl+RstIEjFG2TFB88+d8w==
X-Google-Smtp-Source: ABdhPJw/yRbsqLsGFNvUPkPPJ1aCygnt+iyVESC5mkhFcaOFoCh8V5g49hIvCNxFvRyeXQBLFWfZKw==
X-Received: by 2002:a37:41ce:: with SMTP id o197mr25280932qka.122.1619552875839;
        Tue, 27 Apr 2021 12:47:55 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d19sm625708qtd.29.2021.04.27.12.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:47:55 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lbTgX-00DhBD-OP; Tue, 27 Apr 2021 16:47:53 -0300
Date:   Tue, 27 Apr 2021 16:47:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 14/16] nvme-rdma: Ensure dma support when using p2pdma
Message-ID: <20210427194753.GU2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-15-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-15-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 11:01:21AM -0600, Logan Gunthorpe wrote:
> Ensure the dma operations support p2pdma before using the RDMA
> device for P2PDMA. This allows switching the RDMA driver from
> pci_p2pdma_map_sg() to dma_map_sg_p2pdma().
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/nvme/target/rdma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 6c1f3ab7649c..3ec7e77e5416 100644
> +++ b/drivers/nvme/target/rdma.c
> @@ -414,7 +414,8 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
>  	if (ib_dma_mapping_error(ndev->device, r->send_sge.addr))
>  		goto out_free_rsp;
>  
> -	if (!ib_uses_virt_dma(ndev->device))
> +	if (!ib_uses_virt_dma(ndev->device) &&
> +	    dma_pci_p2pdma_supported(&ndev->device->dev))

ib_uses_virt_dma() should not be called by nvme and this is using the
wrong device pointer to query for DMA related properties.

I suspect this wants a ib_dma_pci_p2p_dma_supported() wrapper like
everything else.

Jason
