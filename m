Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F1641B663
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 20:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242553AbhI1Sez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 14:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242546AbhI1SeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:34:14 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2486C061764
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 11:32:21 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id et16so4786085qvb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bg5/FXYy6+0jcxwwe7U26Md8Qo1QDW6vkKmJYeX4i1Y=;
        b=Hl/E00tVRRsG4VyZTxHCUyfFppftH6aDIraQlh7Zo4b85gvTNF+AYqXgzSNwc5/npf
         l06458g+lvnyddemEzX90uBn/bHB8RYcKfeo1e7FpLjMI+74Dzz/0g/94z+f7GzW+0Zd
         CfpRY5E+W8e1NS+sbJ1/ugjuNMbciPIgxXLMQk1vyLzXxq0uHenjiyziZ6R3dyiq9JVL
         p4sfE2H5q8AjNru6j9eT1fchBVmabhTgc0UQSbcACR3kakx5Tj48HjTa5txeDIwD47Yn
         QqR/fi/0MROMXY9kXIbtoFfIdbEtX3H3w3iXU5cvYHfX3miyrcJhnWwRC/Xh64nSBvuk
         yGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bg5/FXYy6+0jcxwwe7U26Md8Qo1QDW6vkKmJYeX4i1Y=;
        b=CLCTAQpiTK+6RylpfWeBU5xxpMPkHXemoFRegsTvZySBDjPguVNo3ty2X7iaJolpS9
         Bzz8oKDtV8u4CycAkY7S3e979HzPvnqD7CwV7BwEbfESM+wqEftMlxzFJ4uOooWKBshT
         xP1tuphJYaW55ycXQZt0VsQSUGeUDT8LtVRCvpNTEdGlGdN2cfoOhu6UBmMVaW243EWi
         DKC7GhdBmqVgrZhji38WKzTbOsiQjaKnJIn7Bcw9dL1KelQ47ApwYvpQKZurYjwWrbIj
         Tz2r/3v4x5yOHiCT/3z/4PZAF+nJvngmcFHN3NBXEHZ0SPSDybPeAKgH5RzFjVkdrBq7
         e+7g==
X-Gm-Message-State: AOAM530aAozDLu5tSGToAsX0E/Xp4ssK0z4ihcBzGT5sKwCpqDN1Bi7k
        SlrexiEOITG8LxiOUz0UaAc8owtQYDT9gg==
X-Google-Smtp-Source: ABdhPJzfCJn9TE545S5oPvfgJD/DrRXSPKUbE0avVhY8SKIQnFw2dHzYLn+zJmKsF3kZryoXkBtS0Q==
X-Received: by 2002:ad4:4652:: with SMTP id y18mr7157907qvv.2.1632853940961;
        Tue, 28 Sep 2021 11:32:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id w185sm16014000qkd.30.2021.09.28.11.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 11:32:20 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVHtr-007FEl-RE; Tue, 28 Sep 2021 15:32:19 -0300
Date:   Tue, 28 Sep 2021 15:32:19 -0300
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
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 01/20] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
Message-ID: <20210928183219.GJ3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210916234100.122368-2-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:41PM -0600, Logan Gunthorpe wrote:
> Make use of the third free LSB in scatterlist's page_link on 64bit systems.
> 
> The extra bit will be used by dma_[un]map_sg_p2pdma() to determine when a
> given SGL segments dma_address points to a PCI bus address.
> dma_unmap_sg_p2pdma() will need to perform different cleanup when a
> segment is marked as P2PDMA.
> 
> Using this bit requires adding an additional dependency on CONFIG_64BIT to
> CONFIG_PCI_P2PDMA. This should be acceptable as the majority of P2PDMA
> use cases are restricted to newer root complexes and roughly require the
> extra address space for memory BARs used in the transactions.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>  drivers/pci/Kconfig         |  2 +-
>  include/linux/scatterlist.h | 50 ++++++++++++++++++++++++++++++++++---
>  2 files changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 0c473d75e625..90b4bddb3300 100644
> +++ b/drivers/pci/Kconfig
> @@ -163,7 +163,7 @@ config PCI_PASID
>  
>  config PCI_P2PDMA
>  	bool "PCI peer-to-peer transfer support"
> -	depends on ZONE_DEVICE
> +	depends on ZONE_DEVICE && 64BIT

Perhaps a comment to explain what the 64bit is doing?

>  	select GENERIC_ALLOCATOR
>  	help
>  	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 266754a55327..e62b1cf6386f 100644
> +++ b/include/linux/scatterlist.h
> @@ -64,6 +64,21 @@ struct sg_append_table {
>  #define SG_CHAIN	0x01UL
>  #define SG_END		0x02UL
>  
> +/*
> + * bit 2 is the third free bit in the page_link on 64bit systems which
> + * is used by dma_unmap_sg() to determine if the dma_address is a PCI
> + * bus address when doing P2PDMA.
> + * Note: CONFIG_PCI_P2PDMA depends on CONFIG_64BIT because of this.
> + */
> +
> +#ifdef CONFIG_PCI_P2PDMA
> +#define SG_DMA_PCI_P2PDMA	0x04UL

Add a 
	static_assert(__alignof__(void *) == 8);

?

> +#else
> +#define SG_DMA_PCI_P2PDMA	0x00UL
> +#endif
> +
> +#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END | SG_DMA_PCI_P2PDMA)
> +
>  /*
>   * We overload the LSB of the page pointer to indicate whether it's
>   * a valid sg entry, or whether it points to the start of a new scatterlist.
> @@ -72,7 +87,9 @@ struct sg_append_table {
>  #define sg_is_chain(sg)		((sg)->page_link & SG_CHAIN)
>  #define sg_is_last(sg)		((sg)->page_link & SG_END)
>  #define sg_chain_ptr(sg)	\
> -	((struct scatterlist *) ((sg)->page_link & ~(SG_CHAIN | SG_END)))
> +	((struct scatterlist *)((sg)->page_link & ~SG_PAGE_LINK_MASK))
> +
> +#define sg_is_dma_pci_p2pdma(sg) ((sg)->page_link & SG_DMA_PCI_P2PDMA)

I've been encouraging people to use static inlines more..

static inline unsigned int __sg_flags(struct scatterlist *sg)
{
	return sg->page_link & SG_PAGE_LINK_MASK;
}
static inline bool sg_is_chain(struct scatterlist *sg)
{
	return __sg_flags(sg) & SG_CHAIN;
}
static inline bool sg_is_last(struct scatterlist *sg)
{
	return __sg_flags(sg) & SG_END;
}
static inline bool sg_is_dma_pci_p2pdma(struct scatterlist *sg)
{
	return __sg_flags(sg) & SG_DMA_PCI_P2PDMA;
}

>  /**
>   * sg_assign_page - Assign a given page to an SG entry
> @@ -86,13 +103,13 @@ struct sg_append_table {
>   **/
>  static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
>  {
> -	unsigned long page_link = sg->page_link & (SG_CHAIN | SG_END);
> +	unsigned long page_link = sg->page_link & SG_PAGE_LINK_MASK;

I think this should just be '& SG_END', sg_assign_page() doesn't look
like it should ever be used on a sg_chain entry, so this is just
trying to preserve the end stamp.

Anyway, this looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
