Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340BF42BC68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhJMKGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237525AbhJMKGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634119487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OhtK0nXUdl5AJXub6wt3SlLG8E5tzLdcIINFEk1zgkM=;
        b=hoyEHYV79eFTasdlFBCqwqwILw3N715NHACSPzi94d8VQeD2okB7lbOjX3VppLGJO7bGv9
        fXjjG6jYQIueoACPww135Mqe1bFWaX+/FoQJbkBHp5hDEkupix4jD+h2WWWlw1AfsoCNzF
        D7w1ItOuRl8qDgTqMJ7mMvNvVQ08f3Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-eK5APgFIP72wlYG_MWTdTw-1; Wed, 13 Oct 2021 06:04:46 -0400
X-MC-Unique: eK5APgFIP72wlYG_MWTdTw-1
Received: by mail-wr1-f71.google.com with SMTP id 75-20020adf82d1000000b00160cbb0f800so1527513wrc.22
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OhtK0nXUdl5AJXub6wt3SlLG8E5tzLdcIINFEk1zgkM=;
        b=0//cEscaiZBW0JgvkcMGnI90J9kBRE98QUh+WEm9S3hz+hLPU/RQdcUL1L8pMs7ftn
         FStChjLT2h/bT/o/jI8E4RUqDYVCYFAQI0OxhTsRFm1acdhEiWyG47hwIMUL8CdKI0KK
         r3u1s0OOrhQbQOsGyIRM+zZQftQfg69WpLDEWbIbICkWJfc9yiSl70cnCRrjL0YxN9Mg
         eRCRpfGW31gsE2bj1OLx+dK1sosv4BtSgR1/kfXAnjVWSplrAF/UaNM+ldPSJgeBSdZ2
         h/H8/YVrDpz9IwQQ5FvfxyIJLqKWI1yb28ZkP6g1jOdA/N63U6TRMJaGutKMu+2MbZyf
         fhdw==
X-Gm-Message-State: AOAM533KHT1xs/YoyovFJyxN2B+iByadRBmPq0oS+VyihzDqMcyZ4SGw
        PV7s2wr83dy518cKRS8VC8yUbSkGxeZgrdpobKNuhz3yvHo7b+EEZ1vrlufV8CJTlOe4DnYHlI7
        Sq/tcwxnkj5titeYZsl5SGmsF
X-Received: by 2002:a5d:4344:: with SMTP id u4mr40366218wrr.106.1634119485498;
        Wed, 13 Oct 2021 03:04:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGAAkxN28lCL/1rNJa4xwl0lLeA2jwCGcDEI+EhVuW39fm1FqtHtMBRNyPP8sfVmXbdTaljQ==
X-Received: by 2002:a5d:4344:: with SMTP id u4mr40366199wrr.106.1634119485316;
        Wed, 13 Oct 2021 03:04:45 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id b3sm1591483wrp.52.2021.10.13.03.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:04:44 -0700 (PDT)
Date:   Wed, 13 Oct 2021 06:04:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V2 01/12] virtio-blk: validate num_queues during probe
Message-ID: <20211013060341-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012065227.9953-2-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 02:52:16PM +0800, Jason Wang wrote:
> If an untrusted device neogitates BLK_F_MQ but advertises a zero
> num_queues, the driver may end up trying to allocating zero size
> buffers where ZERO_SIZE_PTR is returned which may pass the checking
> against the NULL. This will lead unexpected results.
> 
> Fixing this by using single queue if num_queues is zero.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I'd rather fail probe so we don't need to support that.

> ---
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 9b3bd083b411..9deff01a38cb 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -495,7 +495,8 @@ static int init_vq(struct virtio_blk *vblk)
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
>  				   struct virtio_blk_config, num_queues,
>  				   &num_vqs);
> -	if (err)
> +	/* We need at least one virtqueue */
> +	if (err || !num_vqs)
>  		num_vqs = 1;
>  
>  	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> -- 
> 2.25.1

