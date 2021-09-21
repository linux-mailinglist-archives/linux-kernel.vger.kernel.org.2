Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1179D4136D4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhIUQAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbhIUQAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:00:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC5CC061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:58:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u15so40665961wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rNZaBRo6KuYpkYQWXBblrhd42cpP2Z/LzyFVP0pduSg=;
        b=owdSaQODCfjwam9yCa/45kwOkRitWJz6P7xw58GNzOuAi9z3vUcDQ6zYY+hKxCkGBg
         HziiVMWTPnEW3Rpn6kaulnon9zQlShOzupU71xnPlabFe6r2C7IFFIN9svHtz5+8OEve
         w99a5xLpWckDqllV6ACAFLVupF5vJI1b9Xo8cEUvMD33L05IvqXWGUEer++XtNdJb8VZ
         et0s9UzBjuv5ETPcV7VjpIqkBfDi4PSvkRfuEONCULtAA0rjLPLwJLA3f/QsMdx2zHyQ
         qxtRsdQLRxWoF3UsfCC6xTrkkJsR0y7nRjXfJr5LXGz/bON5L4+UX42F0CqRGSTgPsDU
         yukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rNZaBRo6KuYpkYQWXBblrhd42cpP2Z/LzyFVP0pduSg=;
        b=dAP85e4tmArRMns9pLBYCMCJQhFKjX7kBX49MeSwkJtz2BJOJKMIGV/MOGXOqZsqRE
         tcQ+zm7UYl16RoijLYLVdYj30nqKCwP5JOml5mUACPJymOneL/uZKyB7CYBnyQ5rtBan
         HA3QZ6ffB61UwE+NI3vWhznHqS3ivDo8yToZis2VMQuTThabLANaqEvzJE1Ql0q4ZBg/
         Q1MuO+2mjYhYhoD2YwXuMQ9D9DMoS8GNmNbrcltNcTmoF9ywDwd1PcXx9V+9O60Aw3U1
         0gW5SYS+mjINnoKOlaWWkyMByq5ydoWtd45OAOfXXANRB1ex+otkkrRJ+Tp7To1a5pOZ
         HOXw==
X-Gm-Message-State: AOAM5303gY9tu4Xe+DFtowHfBEqo2+33Hdhw3rtLB2oF2k/SO9sUlBXd
        INKt5xTCvlmlsmKhOjnrqTwlvseERCuaWQ==
X-Google-Smtp-Source: ABdhPJzCu4pXqY9304sJsjOUOKqLOE9NZBXLU1E16vU0ec0UFC0QKS3WsIUo6q+DMz8jdf+Bi/MtVQ==
X-Received: by 2002:a5d:598c:: with SMTP id n12mr35092715wri.391.1632239922976;
        Tue, 21 Sep 2021 08:58:42 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id q10sm3272495wmq.12.2021.09.21.08.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 08:58:42 -0700 (PDT)
Date:   Tue, 21 Sep 2021 16:58:20 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Vivek Gautam <vivek.gautam@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFC v1 01/11] uapi/virtio-iommu: Add page request grp-id
 and flags information
Message-ID: <YUoBHA6NZaz8wlkA@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-2-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423095147.27922-2-vivek.gautam@arm.com>
X-TUID: Sphz2dU6TdZ7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

Thanks a lot for your work on this

On Fri, Apr 23, 2021 at 03:21:37PM +0530, Vivek Gautam wrote:
> Add fault information for group-id and necessary flags for page
> request faults that can be handled by page fault handler in
> virtio-iommu driver.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will.deacon@arm.com>
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
>  include/uapi/linux/virtio_iommu.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index f8bf927a0689..accc3318ce46 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -307,14 +307,27 @@ struct virtio_iommu_req_invalidate {
>  #define VIRTIO_IOMMU_FAULT_F_DMA_UNRECOV	1
>  #define VIRTIO_IOMMU_FAULT_F_PAGE_REQ		2
>  
> +#define VIRTIO_IOMMU_FAULT_PRQ_F_PASID_VALID		(1 << 0)
> +#define VIRTIO_IOMMU_FAULT_PRQ_F_LAST_PAGE		(1 << 1)
> +#define VIRTIO_IOMMU_FAULT_PRQ_F_PRIV_DATA		(1 << 2)
> +#define VIRTIO_IOMMU_FAULT_PRQ_F_NEEDS_PASID		(1 << 3)

I don't think this one is necessary here. The NEEDS_PASID flags added by
commit 970471914c67 ("iommu: Allow page responses without PASID") mainly
helps Linux keep track of things internally. It does tell the fault
handler whether to reply with PASID or not, but we don't need that here.
The virtio-iommu driver knows whether a PASID is required by looking at
the "PRG Response PASID Required" bit in the PCIe capability. For non-PCIe
faults (e.g. SMMU stall), I'm guessing we'll need a PROBE property to
declare that the endpoint supports recoverable faults anyway, so "PASID
required in response" can go through there as well.

> +
> +#define VIRTIO_IOMMU_FAULT_UNREC_F_PASID_VALID		(1 << 0)
> +#define VIRTIO_IOMMU_FAULT_UNREC_F_ADDR_VALID		(1 << 1)
> +#define VIRTIO_IOMMU_FAULT_UNREC_F_FETCH_ADDR_VALID	(1 << 2)
> +
>  struct virtio_iommu_fault {
>  	__u8					reason;
>  	__u8					reserved[3];
>  	__le16					flt_type;
>  	__u8					reserved2[2];
> +	/* flags is actually permission flags */

It's also used for declaring validity of fields.
VIRTIO_IOMMU_FAULT_F_ADDRESS already tells whether the address field is
valid, so all the other flags introduced by this patch can go in here.

>  	__le32					flags;
> +	/* flags for PASID and Page request handling info */
> +	__le32					pr_evt_flags;
>  	__le32					endpoint;
>  	__le32					pasid;
> +	__le32					grpid;

I'm not sure why we made it 32-bit in Linux UAPI, it's a little wasteful.
PCIe PRGI is 9-bits and SMMU STAG is 16-bits. Since the scope of the grpid
is the endpoint, 16-bit means 64k in-flight faults per endpoint, which
seems more than enough.

New fields must be appended at the end of the struct, because old drivers
will expect to find the 'endpoint' field at this offset. You could remove
'reserved3' while adding 'grpid', to keep the struct layout.

>  	__u8					reserved3[4];
>  	__le64					address;
>  	__u8					reserved4[8];


So the base structure, currently in the spec, looks like this:

	struct virtio_iommu_fault {
		u8   reason;
		u8   reserved[3];
		le32 flags;
		le32 endpoint;
		le32 reserved1;
		le64 address;
	};

	#define VIRTIO_IOMMU_FAULT_F_READ	(1 << 0)
	#define VIRTIO_IOMMU_FAULT_F_WRITE	(1 << 1)
	#define VIRTIO_IOMMU_FAULT_F_ADDRESS	(1 << 8)

The extended struct could be:

	struct virtio_iommu_fault {
		u8   reason;
		u8   reserved[3];
		le32 flags;
		le32 endpoint;
		le32 pasid;
		le64 address;
		/* Page request group ID */
		le16 group_id;
		u8   reserved1[6];
		/* For VT-d private data */
		le64 private_data[2];
	};

	#define VIRTIO_IOMMU_FAULT_F_READ	(1 << 0)
	#define VIRTIO_IOMMU_FAULT_F_WRITE	(1 << 1)
	#define VIRTIO_IOMMU_FAULT_F_EXEC	(1 << 2)
	#define VIRTIO_IOMMU_FAULT_F_PRIVILEGED	(1 << 3)
	/* Last fault in group */
	#define VIRTIO_IOMMU_FAULT_F_LAST	(1 << 4)
	/* Fault is a recoverable page request and requires a response */
	#define VIRTIO_IOMMU_FAULT_F_PAGE_REQ	(1 << 5)

	/* address field is valid */
	#define VIRTIO_IOMMU_FAULT_F_ADDRESS	(1 << 8)
	/* pasid field is valid */
	#define VIRTIO_IOMMU_FAULT_F_PASID	(1 << 9)
	/* group_id field is valid */
	#define VIRTIO_IOMMU_FAULT_F_GROUP_ID	(1 << 10)
	/* private data field is valid */
	#define VIRTIO_IOMMU_FAULT_F_PRIV_DATA	(1 << 11)

Thanks,
Jean
