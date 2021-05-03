Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FFC371298
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhECIs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230490AbhECIs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620031654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNh3VIIaagnprujVXdPtNBa4jPKLHbvzqtglqUzkcjA=;
        b=e8RC2eL+gnIHgBWKOfx+Hl9RYkeKrrYo7MUxRfcsI1bb2zm01SWe7udILlPhPmH+L6IE1h
        TCg0jyyWlhPi24bWNYZIweJXrCFs4a9ofidjuvD9PJc0aYFwrZSqY6fDGQd1905vSDLIYG
        LS2GmVgq0j6RcEMYA96HrKjQYpkBKzQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-MNjSWEppO9yUZHMM3tGezg-1; Mon, 03 May 2021 04:47:32 -0400
X-MC-Unique: MNjSWEppO9yUZHMM3tGezg-1
Received: by mail-wr1-f72.google.com with SMTP id 63-20020adf84450000b029010dd0171a96so2940191wrf.21
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 01:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oNh3VIIaagnprujVXdPtNBa4jPKLHbvzqtglqUzkcjA=;
        b=iz0EYbgkBnfymMfklMOpnFD55y8S8JIY0gxhtQNcEM7hLhtemx4zd2IoCylH2wDJPK
         mPUiA/mNiFWSX/zAWpJSJI9BeOW5U1/iXfdIrBeQ8jr/Fo5YsiE3ULb7LJFOzvrE6gAt
         /ZhRn0tK/k9fiD8HTQ4gvegU5UVDg8UxBQsSjVLycc27j2J/IXGBn4Qc1yeUF4rBf8cC
         n1lMSVUjjhAPPzQiCBmO/IRemlPkdjP1GYVYbQ8T7IpaYRGhXHzbj700r4CPcrhKh2iO
         Pxx5RRfoMKiK4XZS46Ob233AHhgxentR+uLgdv0XeaSFtE31pbmXCwNg7ZVA5X0VEqat
         jMgw==
X-Gm-Message-State: AOAM532W+EkDMGkm8aF1ljHdiyoXk7Th/vMF7UOgyG2cRtT8Uwd1QN9X
        CIQPtasyQwioGcQUKInKq4RdlwEHpoOMn0eC1F+1MsRETwzNdMUxJXPypUT+VK5N6V5hOspsgRD
        LpsQ9GWcaX/XSggBA2a6GQ0do
X-Received: by 2002:adf:f00a:: with SMTP id j10mr23036892wro.231.1620031651547;
        Mon, 03 May 2021 01:47:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvQn7ZILmdzPLig2hPkrpiOMpynXsLhaYHpmRxuCUep9NSoCwjLciJspeYLkl3+SmLIr8RrA==
X-Received: by 2002:adf:f00a:: with SMTP id j10mr23036877wro.231.1620031651405;
        Mon, 03 May 2021 01:47:31 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
        by smtp.gmail.com with ESMTPSA id i20sm20091020wmq.29.2021.05.03.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 01:47:30 -0700 (PDT)
Date:   Mon, 3 May 2021 04:47:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Zhu Lingshan <lingshan.zhu@intel.com>
Cc:     jasowang@redhat.com, lulu@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/3] vDPA/ifcvf: enable Intel C5000X-PL virtio-block
 for vDPA
Message-ID: <20210503043801-mutt-send-email-mst@kernel.org>
References: <20210419063326.3748-1-lingshan.zhu@intel.com>
 <20210419063326.3748-3-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419063326.3748-3-lingshan.zhu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 02:33:25PM +0800, Zhu Lingshan wrote:
> This commit enabled Intel FPGA SmartNIC C5000X-PL virtio-block
> for vDPA.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_base.h |  8 +++++++-
>  drivers/vdpa/ifcvf/ifcvf_main.c | 19 ++++++++++++++++++-
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
> index 1c04cd256fa7..0111bfdeb342 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.h
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
> @@ -15,6 +15,7 @@
>  #include <linux/pci_regs.h>
>  #include <linux/vdpa.h>
>  #include <uapi/linux/virtio_net.h>
> +#include <uapi/linux/virtio_blk.h>
>  #include <uapi/linux/virtio_config.h>
>  #include <uapi/linux/virtio_pci.h>
>  
> @@ -28,7 +29,12 @@
>  #define C5000X_PL_SUBSYS_VENDOR_ID	0x8086
>  #define C5000X_PL_SUBSYS_DEVICE_ID	0x0001
>  
> -#define IFCVF_SUPPORTED_FEATURES \
> +#define C5000X_PL_BLK_VENDOR_ID		0x1AF4


Come on this is just PCI_VENDOR_ID_REDHAT_QUMRANET right?



> +#define C5000X_PL_BLK_DEVICE_ID		0x1001

0x1001 is a transitional blk device from virtio spec too right? Let's add these to virtio_ids.h?

> +#define C5000X_PL_BLK_SUBSYS_VENDOR_ID	0x8086
> +#define C5000X_PL_BLK_SUBSYS_DEVICE_ID	0x0002

VIRTIO_ID_BLOCK?

> +
> +#define IFCVF_NET_SUPPORTED_FEATURES \
>  		((1ULL << VIRTIO_NET_F_MAC)			| \
>  		 (1ULL << VIRTIO_F_ANY_LAYOUT)			| \
>  		 (1ULL << VIRTIO_F_VERSION_1)			| \
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 66927ec81fa5..9a4a6df91f08 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -168,10 +168,23 @@ static struct ifcvf_hw *vdpa_to_vf(struct vdpa_device *vdpa_dev)
>  
>  static u64 ifcvf_vdpa_get_features(struct vdpa_device *vdpa_dev)
>  {
> +	struct ifcvf_adapter *adapter = vdpa_to_adapter(vdpa_dev);
>  	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> +	struct pci_dev *pdev = adapter->pdev;
> +
>  	u64 features;
>  
> -	features = ifcvf_get_features(vf) & IFCVF_SUPPORTED_FEATURES;
> +	switch (vf->dev_type) {
> +	case VIRTIO_ID_NET:
> +		features = ifcvf_get_features(vf) & IFCVF_NET_SUPPORTED_FEATURES;
> +		break;
> +	case VIRTIO_ID_BLOCK:
> +		features = ifcvf_get_features(vf);
> +		break;
> +	default:
> +		features = 0;
> +		IFCVF_ERR(pdev, "VIRTIO ID %u not supported\n", vf->dev_type);
> +	}
>  
>  	return features;
>  }
> @@ -514,6 +527,10 @@ static struct pci_device_id ifcvf_pci_ids[] = {
>  			 C5000X_PL_DEVICE_ID,
>  			 C5000X_PL_SUBSYS_VENDOR_ID,
>  			 C5000X_PL_SUBSYS_DEVICE_ID) },
> +	{ PCI_DEVICE_SUB(C5000X_PL_BLK_VENDOR_ID,
> +			 C5000X_PL_BLK_DEVICE_ID,
> +			 C5000X_PL_BLK_SUBSYS_VENDOR_ID,
> +			 C5000X_PL_BLK_SUBSYS_DEVICE_ID) },
>  
>  	{ 0 },
>  };
> -- 
> 2.27.0

