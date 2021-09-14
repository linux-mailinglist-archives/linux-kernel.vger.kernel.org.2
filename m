Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF9A40AE72
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhINM7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233145AbhINM7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631624314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+i8tXrYj4yDnCoPDe/Tv3/7/5YA9BMLPa/F1k7LioJM=;
        b=EMTRTFVfIvGlHQ404ZTrJT6w8JHsyOGWPXbrZ4ci4RBDzd1vCRQ65jhoDY3Z6F3Gn8Ro18
        A/qDYt33ykXW5B9UWzWu7Z+SviVLnfxB4sAoSCMuuKufYjrJ4gAQKK1pbm8v1mi69aT2ij
        4nJhRzzj+0cTmRJJ+LpIltH/hNfDQHI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-jkbUNOPOP--9NcU-if7uug-1; Tue, 14 Sep 2021 08:58:33 -0400
X-MC-Unique: jkbUNOPOP--9NcU-if7uug-1
Received: by mail-wm1-f70.google.com with SMTP id g70-20020a1c2049000000b00303d06c20b2so1168936wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+i8tXrYj4yDnCoPDe/Tv3/7/5YA9BMLPa/F1k7LioJM=;
        b=AQ2sEeDkzrAMlIUU+nBpLuzKWK+0nLrzo6EyWY/oX0RmH+1YHa3coivnhKGK5BeHQy
         +Uw1yEKodC1VhzmXbcU2EccJfkSwwFTAIBWGDU1dyW84+vQMLRj9T8goPwh1A06hxvre
         LUTK2twMvev360gWWL/PsMWzryWMMn/KwX1nvQzrXY/UxAehWt93H65YpAvOYvIClCPO
         36J7WUjMeGoWdjVodKyPBNxIjkqurgQq4XLwfX6X6+RscDjqKIDRw3pw96Ef6OYZ0PGI
         G78p2ziGA6/ODkAE6RmqxP0PQ+KY/xQScl+Hs0O6ckgx3BtUnIp4mbONEsNWRemVOf2O
         oYvg==
X-Gm-Message-State: AOAM530Sjl8ZoTLVtzrmXLsV1B0wrYhIQM+06+yOFtTA3qlDMtLmq0I6
        Zv0bxtNmpiUk9E4R2nJUO1FuG5i/3MdrCtIz+I+NLQQOtQhHo0XlXN6BAgc3TCaUvRF7Q11r3PD
        MYxE0uT2zdjXKwhqN3iB11ND5
X-Received: by 2002:a1c:cc03:: with SMTP id h3mr2044632wmb.73.1631624312219;
        Tue, 14 Sep 2021 05:58:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHtbUQhdNaZzLMjWktMr/Fa0pUFCfp6kfBfoBbJYkI/xrFMVITu+svlOkLkMY+p+sXXK31Tw==
X-Received: by 2002:a1c:cc03:: with SMTP id h3mr2044619wmb.73.1631624312047;
        Tue, 14 Sep 2021 05:58:32 -0700 (PDT)
Received: from redhat.com ([2.55.151.134])
        by smtp.gmail.com with ESMTPSA id c9sm11063685wrf.77.2021.09.14.05.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:58:31 -0700 (PDT)
Date:   Tue, 14 Sep 2021 08:58:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wei.yang1@linux.alibaba.com
Subject: Re: [PATCH v2 4/5] vdpa: add new vdpa attribute
 VDPA_ATTR_DEV_F_VERSION_1
Message-ID: <20210914085711-mutt-send-email-mst@kernel.org>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> This new attribute advertises whether the vdpa device is legacy or not.
> Users can pick right virtqueue size if the vdpa device is legacy which
> doesn't support to change virtqueue size.
> 
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

So if we are bothering with legacy, I think there are
several things to do when building the interface
- support transitional devices, that is allow userspace
  to tell device it's in legacy mode
- support reporting/setting supporting endian-ness

> ---
>  drivers/vdpa/vdpa.c          | 6 ++++++
>  drivers/virtio/virtio_vdpa.c | 7 ++++++-
>  include/uapi/linux/vdpa.h    | 1 +
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1dc121a07a93..533d7f589eee 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/vdpa.h>
>  #include <uapi/linux/vdpa.h>
> +#include <uapi/linux/virtio_config.h>
>  #include <net/genetlink.h>
>  #include <linux/mod_devicetable.h>
>  
> @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>  	u16 max_vq_size;
>  	u32 device_id;
>  	u32 vendor_id;
> +	u64 features;
>  	void *hdr;
>  	int err;
>  
> @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>  	device_id = vdev->config->get_device_id(vdev);
>  	vendor_id = vdev->config->get_vendor_id(vdev);
>  	max_vq_size = vdev->config->get_vq_num_max(vdev);
> +	features = vdev->config->get_features(vdev);
>  
>  	err = -EMSGSIZE;
>  	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>  		goto msg_err;
>  	if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
>  		goto msg_err;
> +	if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> +	    nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> +		goto msg_err;
>  
>  	genlmsg_end(msg, hdr);
>  	return 0;
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 72eaef2caeb1..1cba957c4cdc 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -7,6 +7,7 @@
>   *
>   */
>  
> +#include "linux/virtio_config.h"
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>  	/* Assume split virtqueue, switch to packed if necessary */
>  	struct vdpa_vq_state state = {0};
>  	unsigned long flags;
> +	bool may_reduce_num = false;
>  	u32 align, num;
>  	int err;
>  
> @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>  		goto error_new_virtqueue;
>  	}
>  
> +	if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> +		may_reduce_num = true;
> +
>  	/* Create the vring */
>  	align = ops->get_vq_align(vdpa);
>  	vq = vring_create_virtqueue(index, num, align, vdev,
> -				    true, true, ctx,
> +				    true, may_reduce_num, ctx,
>  				    virtio_vdpa_notify, callback, name);
>  	if (!vq) {
>  		err = -ENOMEM;
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 66a41e4ec163..ce0b74276a5b 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -32,6 +32,7 @@ enum vdpa_attr {
>  	VDPA_ATTR_DEV_VENDOR_ID,		/* u32 */
>  	VDPA_ATTR_DEV_MAX_VQS,			/* u32 */
>  	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
> +	VDPA_ATTR_DEV_VERSION_1,		/* flag */
>  
>  	/* new attributes must be added above here */
>  	VDPA_ATTR_MAX,
> -- 
> 2.31.1

