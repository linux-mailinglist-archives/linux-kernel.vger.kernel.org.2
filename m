Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D1732C12E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838293AbhCCTAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:00:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:60722 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350093AbhCCS2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:28:36 -0500
IronPort-SDR: eRw2tVSf+tmaBTb1JxaGZeShx5IIw7yaZHCfLXiCeFQx/0dxmA4ug18hvtmLdjUkWGbl+3MPrE
 Y0+7uwpDLcgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="184838833"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="184838833"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 10:26:33 -0800
IronPort-SDR: flZ7ydHew/uLhmA0gDtrMwbn8pEMwFG07GAmfz4SHyILz2W2OCSJgnBR1uJ6kAa/Ww7OBC5TmT
 S3ny2ZIn3+Ww==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="428367968"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 10:26:33 -0800
Date:   Wed, 3 Mar 2021 10:28:48 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Vivek Gautam <vivek.gautam@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        jean-philippe@linaro.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
        shameerali.kolothum.thodi@huawei.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH RFC v1 12/15] iommu/virtio: Add support for INVALIDATE
 request
Message-ID: <20210303102848.5d879f0e@jacob-builder>
In-Reply-To: <20210115121342.15093-13-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
        <20210115121342.15093-13-vivek.gautam@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Fri, 15 Jan 2021 17:43:39 +0530, Vivek Gautam <vivek.gautam@arm.com>
wrote:

> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> Add support for tlb invalidation ops that can send invalidation
> requests to back-end virtio-iommu when stage-1 page tables are
> supported.
> 
Just curious if it possible to reuse the iommu uapi for invalidation and others.
When we started out designing the iommu uapi, the intention was to support
both emulated and virtio iommu.

> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> [Vivek: Refactoring the iommu_flush_ops, and adding only one pasid sync
>         op that's needed with current iommu-pasid-table infrastructure.
> 	Also updating uapi defines as required by latest changes]
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/virtio-iommu.c | 95 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index ae5dfd3f8269..004ea94e3731 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -13,6 +13,7 @@
>  #include <linux/freezer.h>
>  #include <linux/interval_tree.h>
>  #include <linux/iommu.h>
> +#include <linux/io-pgtable.h>
>  #include <linux/module.h>
>  #include <linux/of_iommu.h>
>  #include <linux/of_platform.h>
> @@ -63,6 +64,8 @@ struct viommu_mapping {
>  };
>  
>  struct viommu_mm {
> +	int				pasid;
> +	u64				archid;
>  	struct io_pgtable_ops		*ops;
>  	struct viommu_domain		*domain;
>  };
> @@ -692,6 +695,98 @@ static void viommu_event_handler(struct virtqueue
> *vq) virtqueue_kick(vq);
>  }
>  
> +/* PASID and pgtable APIs */
> +
> +static void __viommu_flush_pasid_tlb_all(struct viommu_domain *vdomain,
> +					 int pasid, u64 arch_id, int
> type) +{
> +	struct virtio_iommu_req_invalidate req = {
> +		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
> +		.inv_gran	=
> cpu_to_le32(VIRTIO_IOMMU_INVAL_G_PASID),
> +		.flags		=
> cpu_to_le32(VIRTIO_IOMMU_INVAL_F_PASID),
> +		.inv_type	= cpu_to_le32(type),
> +
> +		.domain		= cpu_to_le32(vdomain->id),
> +		.pasid		= cpu_to_le32(pasid),
> +		.archid		= cpu_to_le64(arch_id),
> +	};
> +
> +	if (viommu_send_req_sync(vdomain->viommu, &req, sizeof(req)))
> +		pr_debug("could not send invalidate request\n");
> +}
> +
> +static void viommu_flush_tlb_add(struct iommu_iotlb_gather *gather,
> +				 unsigned long iova, size_t granule,
> +				 void *cookie)
> +{
> +	struct viommu_mm *viommu_mm = cookie;
> +	struct viommu_domain *vdomain = viommu_mm->domain;
> +	struct iommu_domain *domain = &vdomain->domain;
> +
> +	iommu_iotlb_gather_add_page(domain, gather, iova, granule);
> +}
> +
> +static void viommu_flush_tlb_walk(unsigned long iova, size_t size,
> +				  size_t granule, void *cookie)
> +{
> +	struct viommu_mm *viommu_mm = cookie;
> +	struct viommu_domain *vdomain = viommu_mm->domain;
> +	struct virtio_iommu_req_invalidate req = {
> +		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
> +		.inv_gran	= cpu_to_le32(VIRTIO_IOMMU_INVAL_G_VA),
> +		.inv_type	= cpu_to_le32(VIRTIO_IOMMU_INV_T_IOTLB),
> +		.flags		=
> cpu_to_le32(VIRTIO_IOMMU_INVAL_F_ARCHID), +
> +		.domain		= cpu_to_le32(vdomain->id),
> +		.pasid		= cpu_to_le32(viommu_mm->pasid),
> +		.archid		= cpu_to_le64(viommu_mm->archid),
> +		.virt_start	= cpu_to_le64(iova),
> +		.nr_pages	= cpu_to_le64(size / granule),
> +		.granule	= ilog2(granule),
> +	};
> +
> +	if (viommu_add_req(vdomain->viommu, &req, sizeof(req)))
> +		pr_debug("could not add invalidate request\n");
> +}
> +
> +static void viommu_flush_tlb_all(void *cookie)
> +{
> +	struct viommu_mm *viommu_mm = cookie;
> +
> +	if (!viommu_mm->archid)
> +		return;
> +
> +	__viommu_flush_pasid_tlb_all(viommu_mm->domain, viommu_mm->pasid,
> +				     viommu_mm->archid,
> +				     VIRTIO_IOMMU_INV_T_IOTLB);
> +}
> +
> +static struct iommu_flush_ops viommu_flush_ops = {
> +	.tlb_flush_all		= viommu_flush_tlb_all,
> +	.tlb_flush_walk		= viommu_flush_tlb_walk,
> +	.tlb_add_page		= viommu_flush_tlb_add,
> +};
> +
> +static void viommu_flush_pasid(void *cookie, int pasid, bool leaf)
> +{
> +	struct viommu_domain *vdomain = cookie;
> +	struct virtio_iommu_req_invalidate req = {
> +		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
> +		.inv_gran	=
> cpu_to_le32(VIRTIO_IOMMU_INVAL_G_PASID),
> +		.inv_type	= cpu_to_le32(VIRTIO_IOMMU_INV_T_PASID),
> +		.flags		=
> cpu_to_le32(VIRTIO_IOMMU_INVAL_F_PASID), +
> +		.domain		= cpu_to_le32(vdomain->id),
> +		.pasid		= cpu_to_le32(pasid),
> +	};
> +
> +	if (leaf)
> +		req.flags	|=
> cpu_to_le32(VIRTIO_IOMMU_INVAL_F_LEAF); +
> +	if (viommu_send_req_sync(vdomain->viommu, &req, sizeof(req)))
> +		pr_debug("could not send invalidate request\n");
> +}
> +
>  /* IOMMU API */
>  
>  static struct iommu_domain *viommu_domain_alloc(unsigned type)


Thanks,

Jacob
