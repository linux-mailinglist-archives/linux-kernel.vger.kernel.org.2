Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE9742BC40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbhJMJ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236501AbhJMJ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634119052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lr3epdSoyD9tsHtOQNYbPUXEeZwWL7vVg7MIPONlWnE=;
        b=MBaSUZUIjN3+ff0F39FvLuZ9JPuKsZtOth5AwkMghc0m02Xng1Lcp5Wp56Eh4GleqHI7SN
        othlpBim3vy2Gtikt2p7jaAWTe9nZzs7joymkFzvNKh1PT+6LSqtWgYxM1IUXFUQQl02xV
        YbXDZgasjpis4MPa+FvUilp7zNhGYfU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-IOfQYYc6MDWoXNVvtj4Yug-1; Wed, 13 Oct 2021 05:57:31 -0400
X-MC-Unique: IOfQYYc6MDWoXNVvtj4Yug-1
Received: by mail-wr1-f70.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso1565628wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 02:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lr3epdSoyD9tsHtOQNYbPUXEeZwWL7vVg7MIPONlWnE=;
        b=FbrNj6oC+0L2N0pSeLnQKMf0gikmGPKMjTCMm0v+Xi1PEm16+BYDBawAom1bMraqG9
         ALjCQ8vMuEe2kMwKSZ/oktLhfnbv0MtC5b0F6/GVUMex4USGjyVnfj0D2hUU3qrFpChR
         +bNl3M/yEoyidfXNyC12h3C4hp1X2LoTx9V88iJQw9JIvYGx3orocgLV6Rqn6qn06VWA
         rvOwqm52XZIs9HukrmODjM+8oml1m5CUYO89pd4w0bXdpUo0Zz7CW1ULY9ZHDuqIM1NK
         5MNzhuG6BvkKhw+jVe/wGy4MzNa3qJXkhxUh4oB8Chh1aBd3cENrtMcdfOk+59XPuMKH
         WUBg==
X-Gm-Message-State: AOAM53104djd8WqVfxzwNONx2TOnWGXG/EOZcH4BcKyQz906bh2RS9Bj
        WiNKBcJZ4sv1p+PtUYb8rk8u4hQaXq1h4jUrQdDuyQiYpHtWYSuyNkvyq+YP3lIf9Hlq1LeLF/a
        qAs8fzt3L/OUjzfycX541G6ay
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr11843765wmg.38.1634119049814;
        Wed, 13 Oct 2021 02:57:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/2iWFNAXXDAi19/czXJ1HhQNIQP5oBQDFC8kUKve2d6ed2R9dgQg4rxtao35XZvCFS4LfIA==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr11843745wmg.38.1634119049587;
        Wed, 13 Oct 2021 02:57:29 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id c77sm4830641wme.48.2021.10.13.02.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 02:57:29 -0700 (PDT)
Date:   Wed, 13 Oct 2021 05:57:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: Re: [PATCH V2 05/12] virtio_config: introduce a new ready method
Message-ID: <20211013055401-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-6-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012065227.9953-6-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 02:52:20PM +0800, Jason Wang wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/linux/virtio_config.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 8519b3ae5d52..f2891c6221a1 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -23,6 +23,8 @@ struct virtio_shm_region {
>   *       any of @get/@set, @get_status/@set_status, or @get_features/
>   *       @finalize_features are NOT safe to be called from an atomic
>   *       context.
> + * @ready: make the device ready
> + *      vdev: the virtio_device
>   * @get: read the value of a configuration field
>   *	vdev: the virtio_device
>   *	offset: the offset of the configuration field

I think it's too vague. device_ready makes device ready to receive
kicks. What does this one do? I don't like calling things by where
they are called from, I prefer calling them by what they do.
It actually enables callbacks, right?
So enable_cbs?


> @@ -75,6 +77,7 @@ struct virtio_shm_region {
>   */
>  typedef void vq_callback_t(struct virtqueue *);
>  struct virtio_config_ops {
> +	void (*ready)(struct virtio_device *vdev);
>  	void (*get)(struct virtio_device *vdev, unsigned offset,
>  		    void *buf, unsigned len);
>  	void (*set)(struct virtio_device *vdev, unsigned offset,
> @@ -229,6 +232,9 @@ void virtio_device_ready(struct virtio_device *dev)
>  {
>  	unsigned status = dev->config->get_status(dev);
>  
> +	if (dev->config->ready)
> +                  dev->config->ready(dev);
> +
>  	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>  	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>  }
> -- 
> 2.25.1

