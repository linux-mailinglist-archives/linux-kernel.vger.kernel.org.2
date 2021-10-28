Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E34C43DACD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 07:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhJ1Fmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 01:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhJ1Fmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 01:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635399623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anF7BPmbH7+9aDUvnziYE4TDy5s8dDRfTV6pgnlOgB8=;
        b=d6qXdqVEYQfqk578iPMGav8ECdHC91nJvquQpAeAzOWxElO1rMjGKbLP1iZh9ZclQQSWkl
        ZgIer3wEjCE82E4RU+Jml/ExEqJs1878PPM+8L/BXSRXGA4LHSoieqsP4OxGhKFtywTqkv
        BNMTtrsDwmEWqfcw9Q+1jacKZRb2d4U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-4zTUyp86MB-Gd30okZPjfw-1; Thu, 28 Oct 2021 01:40:21 -0400
X-MC-Unique: 4zTUyp86MB-Gd30okZPjfw-1
Received: by mail-ed1-f69.google.com with SMTP id z1-20020a05640235c100b003dcf0fbfbd8so4501266edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 22:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=anF7BPmbH7+9aDUvnziYE4TDy5s8dDRfTV6pgnlOgB8=;
        b=MJD4ngbOAj6eO/7qHYTt9jO/IIOmnlM6eeZacdjL9PodSfaHLSy6SSlU5aSUz0/SOh
         8cENm772KRVixY/3owohNYgq9K2QPXykbF1QMNfnP86idfiN/DQl55d+HZt+E/jN/HHG
         +w6cBASHUzfQEFCwE+zdRbRU5pA085x9MuSYRcVCZwRMjnnZ6JBt33Y4pYdJijBZEVki
         8wV4S0tcJJ5RP4Izy92WkOopcOm48BPd/QcOiSK2vKBqxTmKhc+81xfENNFl7EP7MpMX
         +bYCQMK3Q1DM2JjKGODuchYh5BtAdrjFmVrVVg5hCmzNiGx9/vpZzbKj2aemyz2EvhzN
         dUuw==
X-Gm-Message-State: AOAM530fdq5CtoN+SJqyfUGLQ7Q+PJHOmdbqdWz4l+Ok0F1h/NdcJkkR
        vOYVJN1lBAmsUi/KnoK+NZyROZWJ23aZRP0VAdjqPYdC9mZ0O8xjA4/9KTuUrVjNhu9FTf/QGjA
        o7K8lNf/Sb+NueWCayzy5iDSc
X-Received: by 2002:a17:907:1caa:: with SMTP id nb42mr2599412ejc.333.1635399620608;
        Wed, 27 Oct 2021 22:40:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQhd1vOTP7CLD/BJ5RCWNsTIMoyg9pY3KHXHXK3KvUR6nZvmqchxP6Ys9Sd0YzoBlY6gk8EA==
X-Received: by 2002:a17:907:1caa:: with SMTP id nb42mr2599392ejc.333.1635399620384;
        Wed, 27 Oct 2021 22:40:20 -0700 (PDT)
Received: from redhat.com ([2.55.137.59])
        by smtp.gmail.com with ESMTPSA id n2sm657001ejl.92.2021.10.27.22.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 22:40:19 -0700 (PDT)
Date:   Thu, 28 Oct 2021 01:40:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Erdem Aktas <erdemaktas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] Add DMA_API support for Virtio devices earlier than VirtIO
 1.0
Message-ID: <20211028013901-mutt-send-email-mst@kernel.org>
References: <20211027232828.2043569-1-erdemaktas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027232828.2043569-1-erdemaktas@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 04:28:28PM -0700, Erdem Aktas wrote:
> Enable DMA_API for any VirtIO device earlier than Virtio 1.0 which
> is the only way for those devices to be configured correctly when
> memory access is retricted.
> 
> Virtio devices can use DMA_API to translate guest phsical addresses to
> device physical addresses if VIRTIO_F_ACCESS_PLATFORM feature is set
> while the device is being initialized. VIRTIO_F_ACCESS_PLATFORM
> feature is only supported in VirtIO 1.0 and later devices. This prevents
> any device using an earlier VirtIO version than Virtio 1.0 to be
> attached when memory access is restricted ie memory encryption features
> (AMD SEV [ES/SNP], Intel TDX, etc..) are enabled.
> 
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>


Sorry .. NACK.

Virtio before 1.0 is on life support. No new features. Just use 1.0
please.


> ---
> I have tested the this patch using linux-stable.git head, 5.15.0-rc6
> kernel and scsi disk with virtio 0.95 version with legacy VM and
> Confidential VM (AMD SEV). I want to get feedback if
> there is any risk or downside of enabling DMA_API on older virtio
> drivers when memory encrytion is enabled.
> 
>  drivers/virtio/virtio.c       |  7 ++-----
>  include/linux/virtio_config.h | 22 ++++++++++++++--------
>  2 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 236081afe9a2..71115ba85d07 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -179,11 +179,8 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (ret) {
>  		if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
>  			dev_warn(&dev->dev,
> -				 "device must provide VIRTIO_F_VERSION_1\n");
> -			return -ENODEV;
> -		}
> -
> -		if (!virtio_has_feature(dev, VIRTIO_F_ACCESS_PLATFORM)) {
> +				 "device does not provide VIRTIO_F_VERSION_1 while restricted memory access is enabled!.\n");
> +		} else if (!virtio_has_feature(dev, VIRTIO_F_ACCESS_PLATFORM)) {
>  			dev_warn(&dev->dev,
>  				 "device must provide VIRTIO_F_ACCESS_PLATFORM\n");
>  			return -ENODEV;
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 8519b3ae5d52..6eacb4d43318 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -170,6 +170,15 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
>  	return __virtio_test_bit(vdev, fbit);
>  }
>  
> +#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> +int arch_has_restricted_virtio_memory_access(void);
> +#else
> +static inline int arch_has_restricted_virtio_memory_access(void)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS */
> +
>  /**
>   * virtio_has_dma_quirk - determine whether this device has the DMA quirk
>   * @vdev: the device
> @@ -180,6 +189,11 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
>  	 * Note the reverse polarity of the quirk feature (compared to most
>  	 * other features), this is for compatibility with legacy systems.
>  	 */
> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> +	   arch_has_restricted_virtio_memory_access())
> +		return false;
> +
> +
>  	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
>  }
>  
> @@ -558,13 +572,5 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
>  		_r;							\
>  	})
>  
> -#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> -int arch_has_restricted_virtio_memory_access(void);
> -#else
> -static inline int arch_has_restricted_virtio_memory_access(void)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS */
>  
>  #endif /* _LINUX_VIRTIO_CONFIG_H */
> -- 
> 2.30.2

