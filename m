Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C83942BC75
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbhJMKLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbhJMKLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634119750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+H2CcqHQa3aHsMSE5edugMU+61s5pxwJjosotJGK2ew=;
        b=b9vNQPGdEUh7h8/NeWcZhitH0hQbKQ+3/LzZtzVSAqQSqoM1kB7FDO2N65rGH/23sd9qki
        iKqcVz7BoGgYouWP19vFHKHjrNjwovk9oiH806H+CnoU3l7TeORa1hf4zwmdPKabv8DmQl
        MXHf3FmTJkMixUCPXFtn3qoqGALjA0s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-tjsIowIfPYS2ysxESYz2dw-1; Wed, 13 Oct 2021 06:09:08 -0400
X-MC-Unique: tjsIowIfPYS2ysxESYz2dw-1
Received: by mail-wr1-f71.google.com with SMTP id d13-20020adfa34d000000b00160aa1cc5f1so1553998wrb.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+H2CcqHQa3aHsMSE5edugMU+61s5pxwJjosotJGK2ew=;
        b=qpYjJckR/w5fN8Rbk7dfrodldsX2eY5xDh4VsaGuLAcS6rz9tdybwB6/OcjBeAAq0f
         r5yabgzIILKtAY9Bbhi/1gvfPlTNx7E5QMboshHbvQEofQ/wXD1IahMqjRc+sRMcdt+T
         2RmCqI0oNAZziGyBCYLrpleczwDHkue/gg2XuePb+cVjlUwXv4D+e8dp9ynOo6wuKmSJ
         RsTPeRPdvXOfFH+0hCAlDFKfvipQ0hz2Kr1/vF+qJzkRpSRWF8gZhERPYMj9nx+C3JmY
         rPn53pKket9q/jlX0nkFIXTkWpVOgEIOTlzZiDg3NW+kTGPB0RYcBVjvRUQXfLKaG3Rw
         rrPg==
X-Gm-Message-State: AOAM530ux+SLLrHyRmeZVIRzdI/8Ar1as+SoMbxFzTzQuDz84y7RAi3f
        yVTTjlIn3pLAXORjhvGxGsIB5CUlCxOvNYgxpfHUwna2R83X+kaJyXu18uuE7XWizBOy1TbFBlu
        +MIa8cmXAwI2gPWNtpA6mlYL6
X-Received: by 2002:a1c:7212:: with SMTP id n18mr11952921wmc.87.1634119747523;
        Wed, 13 Oct 2021 03:09:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAG6+SiB0W+JEraq7KKny4L51lvdAdz9tBqTVTomwWEDTigwLRxfDFPNdqwRmIp2zegjsS7Q==
X-Received: by 2002:a1c:7212:: with SMTP id n18mr11952906wmc.87.1634119747323;
        Wed, 13 Oct 2021 03:09:07 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id i24sm4502602wml.26.2021.10.13.03.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:09:06 -0700 (PDT)
Date:   Wed, 13 Oct 2021 06:09:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: Re: [PATCH V2 02/12] virtio: add doc for validate() method
Message-ID: <20211013060808-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012065227.9953-3-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 02:52:17PM +0800, Jason Wang wrote:
> This patch adds doc for validate() method.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

And maybe document __virtio_clear_bit : it says
"for use by transports" and now it's also legal in the
validate callback.

> ---
>  include/linux/virtio.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 41edbc01ffa4..0cd8685aeba4 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -152,6 +152,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
>   * @feature_table_size: number of entries in the feature table array.
>   * @feature_table_legacy: same as feature_table but when working in legacy mode.
>   * @feature_table_size_legacy: number of entries in feature table legacy array.
> + * @validate: optional function to do early checks
>   * @probe: the function to call when a device is found.  Returns 0 or -errno.
>   * @scan: optional function to call after successful probe; intended
>   *    for virtio-scsi to invoke a scan.
> -- 
> 2.25.1

