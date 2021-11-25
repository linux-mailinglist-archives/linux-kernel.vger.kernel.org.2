Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E844345D50C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349895AbhKYHFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:05:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348858AbhKYHDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637823638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YvGutxBVxczmzzfrYB1SU+rxjor3OVuX04qAGxlXkWA=;
        b=bbnBkuizO9WzsKhZSLns3FHmNYY20RGhZJTtOGSSP4eOlrRUVqhFfjD8AiJnoAETX9k0lg
        Xzax2BfXWxe+Adr315BPRCzGaRtKYl30bwBog6J5YqPfgc1TPomvFZVnvYJvEtoDdgR1tC
        JpF2AFrk73IYarexgkR1i34IXjHGBFI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-409-BjWu4MbqOLC4hITR3Ljj-w-1; Thu, 25 Nov 2021 02:00:35 -0500
X-MC-Unique: BjWu4MbqOLC4hITR3Ljj-w-1
Received: by mail-ed1-f69.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so4625858edq.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YvGutxBVxczmzzfrYB1SU+rxjor3OVuX04qAGxlXkWA=;
        b=Zf7t+518UHNqcgKilZuF6Lwcn7qCxw9pKI0DXYot1ufziOirz2XNZxfV7NSr5UDv6Y
         xZ/16a8devUXJ1qF6UlAgkgmdvkBVrrRdhOB1aCwr0Ce7qMr43/P3rFAnmjVxri1t2Fm
         PJts9+DJPiLcm00ebZc2bJzISjz9RFYP43eUTsUFQG9MFaspvatQeld38gwRrKi5hQk7
         0OY29flF1N7oY/kK6apIoUDuGoWePVeOaTM4lCEkPxwu6am62V1eV6TIMcFq2k56NCmd
         2uWMDDajj5FaP8cELJhE5axGFaVwlteszbtUpdFweSkdWJT56LvWru4zFWCGtqJlsQOM
         laUQ==
X-Gm-Message-State: AOAM532uncDpDXeUGCHMDFAwtxOBrrelJLf9/ZO0ZfOJJafkuPdEKlq8
        /cXPZNYsxTiew8S/SX0Lg8rZCOTIDddvLU9GSfcYMg1HKHeiieTPuNEq5OBPhIe48qAXvH8vH0t
        sEJ3HAOi16zkwX5K+2irz3fY0
X-Received: by 2002:a05:6402:514d:: with SMTP id n13mr37269602edd.380.1637823633713;
        Wed, 24 Nov 2021 23:00:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwt9AzGmm67AiDU2VeyIbtxIKZbPDa65Cxd5iNtULGb5LEPNWYW+LlxsIXin1YtDVEPx7kHTQ==
X-Received: by 2002:a05:6402:514d:: with SMTP id n13mr37269578edd.380.1637823633552;
        Wed, 24 Nov 2021 23:00:33 -0800 (PST)
Received: from redhat.com ([45.15.18.67])
        by smtp.gmail.com with ESMTPSA id z8sm1418082edb.5.2021.11.24.23.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 23:00:32 -0800 (PST)
Date:   Thu, 25 Nov 2021 02:00:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH net] virtio-net: enable big mode correctly
Message-ID: <20211125015532-mutt-send-email-mst@kernel.org>
References: <20211125060547.11961-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125060547.11961-1-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> large max_mtu. In this case, using small packet mode is not correct
> since it may breaks the networking when MTU is grater than
> ETH_DATA_LEN.
> 
> To have a quick fix, simply enable the big packet mode when
> VIRTIO_NET_F_MTU is not negotiated.

This will slow down dpdk hosts which disable mergeable buffers
and send standard MTU sized packets.

> We can do optimization on top.

I don't think it works like this, increasing mtu
from guest >4k never worked, we can't regress everyone's
performance with a promise to maybe sometime bring it back.

> Reported-by: Eli Cohen <elic@nvidia.com>
> Cc: Eli Cohen <elic@nvidia.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> ---
>  drivers/net/virtio_net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7c43bfc1ce44..83ae3ef5eb11 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		dev->mtu = mtu;
>  		dev->max_mtu = mtu;
>  
> -		/* TODO: size buffers correctly in this case. */
> -		if (dev->mtu > ETH_DATA_LEN)
> -			vi->big_packets = true;
>  	}
>  
> +	/* TODO: size buffers correctly in this case. */
> +	if (dev->max_mtu > ETH_DATA_LEN)
> +		vi->big_packets = true;
> +
>  	if (vi->any_header_sg)
>  		dev->needed_headroom = vi->hdr_len;
>  
> -- 
> 2.25.1

