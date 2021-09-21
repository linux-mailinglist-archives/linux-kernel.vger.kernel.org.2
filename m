Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3841371B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhIUQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhIUQSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:18:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76AAC061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:16:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t8so33877326wri.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+CTxDiEkqYMWmqQPeOUmYqmKLKbBDgvYPDzOPQ78M/0=;
        b=h/rwkqxZm7jxTW5tYuKGJvhiOpQKscVTAw6so0UV+1eUyfAc9/yjPN/ZM3WLbY8iwh
         65iYfaYWcSfjg2hGOG+518L7lt/uPjiGa1WRVMOOZUl/YG+Kv05PAepY1+nrs1KS2p8L
         pyePyNyB8emOr3i+5OC8ycyenvzVyyPaCiWTJIrroJ6Jzlau/5oClySBRLY4LjksIU2D
         SI9hiFZMaa2E94FcUFlIUv/fDiVuT8NrrDMPbdDhS/JXqfoC7Njba6pNwxKWD461Q7E1
         J11em3q6lY1YGQ4L5UDGKU+db6rcp+4NggWADyFIHJsFq7ETh6XGhc9MashKivzDQdWI
         nmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+CTxDiEkqYMWmqQPeOUmYqmKLKbBDgvYPDzOPQ78M/0=;
        b=cfuPuLKY8fjXiinJTAeEnCJIdH1rz+VlZy7dhYe3I6DU1LcNmizCrUlZIIzi76oHBs
         fKMQUNP6twYEKssxwjjx5XA38rJOvunWqneQD/mW+CAkBwn4Sdwmv4CSIWTrODr1wtnU
         S1R2OM2sLTxHOZcAk/4pcPvcNU/C2N6euYgVDfqqkRSN0i/u4xHzoChTF9grJtyj2NWD
         1X8TablmB3N0ZGBw0UfYKhdBTIRsPgQKk50LIta7nk5Lk3E+NyDFBa8gmlR6OUC859hS
         haWkbrZ/+w7oSHP5tLGEVuH4qnWjt355tBi/g1GToZTvpvXpUpsyDiku9n1WDazdvcl9
         7WmQ==
X-Gm-Message-State: AOAM530veBvTVl853ahsLW7uD1LORPARkMMKApbjWQCsqxCLWGAYPHvL
        +cRRHMDgGHeNLt4L2kj79CDAiw==
X-Google-Smtp-Source: ABdhPJyYy8Ov1VUqZi4K/daddChZpP5kpZm/UL9IHwusTYbuOtsRpmrZUam946gjF4u3xlJ0JlVyRg==
X-Received: by 2002:a1c:7f11:: with SMTP id a17mr5602673wmd.166.1632240992327;
        Tue, 21 Sep 2021 09:16:32 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id v10sm20755353wri.29.2021.09.21.09.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:16:31 -0700 (PDT)
Date:   Tue, 21 Sep 2021 17:16:10 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Vivek Gautam <vivek.gautam@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFC v1 10/11] uapi/virtio-iommu: Add a new request type
 to send page response
Message-ID: <YUoFSrAK2gi3GWp/@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-11-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423095147.27922-11-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 03:21:46PM +0530, Vivek Gautam wrote:
> Once the page faults are handled, the response has to be sent to
> virtio-iommu backend, from where it can be sent to the host to
> prepare the response to a generated io page fault by the device.
> Add a new virt-queue request type to handle this.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> ---
>  include/uapi/linux/virtio_iommu.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index c12d9b6a7243..1b174b98663a 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -48,6 +48,7 @@ struct virtio_iommu_config {
>  #define VIRTIO_IOMMU_T_PROBE			0x05
>  #define VIRTIO_IOMMU_T_ATTACH_TABLE		0x06
>  #define VIRTIO_IOMMU_T_INVALIDATE		0x07
> +#define VIRTIO_IOMMU_T_PAGE_RESP		0x08
>  
>  /* Status types */
>  #define VIRTIO_IOMMU_S_OK			0x00
> @@ -70,6 +71,23 @@ struct virtio_iommu_req_tail {
>  	__u8					reserved[3];
>  };
>  
> +struct virtio_iommu_req_page_resp {
> +	struct virtio_iommu_req_head		head;
> +	__le32					domain;

I don't think we need this field, since the fault report doesn't come with
a domain.

> +	__le32					endpoint;
> +#define VIRTIO_IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)

To be consistent with the rest of the document this would be
VIRTIO_IOMMU_PAGE_RESP_F_PASID_VALID

> +	__le32					flags;
> +	__le32					pasid;
> +	__le32					grpid;
> +#define VIRTIO_IOMMU_PAGE_RESP_SUCCESS		(0x0)
> +#define VIRTIO_IOMMU_PAGE_RESP_INVALID		(0x1)
> +#define VIRTIO_IOMMU_PAGE_RESP_FAILURE		(0x2)
> +	__le16					resp_code;
> +	__u8					pasid_valid;

This field isn't needed since there already is
VIRTIO_IOMMU_PAGE_RESP_PASID_VALID

> +	__u8					reserved[9];
> +	struct virtio_iommu_req_tail		tail;
> +};

I'd align the size of the struct to 16 bytes, but I don't think that's
strictly necessary.

Thanks,
Jean

> +
>  struct virtio_iommu_req_attach {
>  	struct virtio_iommu_req_head		head;
>  	__le32					domain;
> -- 
> 2.17.1
> 
