Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15C43A83F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhFOP3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231398AbhFOP3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623770850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BBaVLpIdsAFYJF8kqK3yekJ5AzD1bcUpe8+m6jwsVLg=;
        b=fSBjcT318OH6wnTl6N7EHhkq2zdRp2JFmiKMkBfeMzkl9RXUivf4h6bBXFjih5YpZZRyd8
        tLoVHSThaHqUDfNUMCMwFZ6UhltYgi71D5VzgNamut0P9PqmnFY6t11WztoVS4WOzY1ePW
        x5PkBVmK58zFA/Gs96pwClfVxcTOklY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-GkoiM_NONY-kgrEj9S9HZA-1; Tue, 15 Jun 2021 11:27:29 -0400
X-MC-Unique: GkoiM_NONY-kgrEj9S9HZA-1
Received: by mail-ed1-f69.google.com with SMTP id h23-20020aa7c5d70000b029038fed7b27d5so22326141eds.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 08:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BBaVLpIdsAFYJF8kqK3yekJ5AzD1bcUpe8+m6jwsVLg=;
        b=oIs8vi1QO90uW+yLt/sTblrgv1oayUlk9PrRiOxxjUHcUkSWI9DukIR2uOT8EQoKRn
         GlmkfjaqtubW/ZIaJD0yhsfd2xtqlwifZtzxMjsexY52fjhGkpZnnFFbbB1O761MukVp
         8wQgdLS9h3bVAfbiI7SW6DpWyJJNCDwARbZcdWnxCvg6PGcD/fV/XKr/f0FhIRTrURi6
         cK/pL3B6oktnseNZAHJKxHJxcmPCqmFPVCUlRiM41/Mg+yE8YJCQwRHNi2VQB7iWYTEi
         K3epSNm1RBWZUr0bgiTRNiNPt4mUWRO6PFc0z6ntNAif0Ncz3LnAokuR0KtAiXS/INKT
         o5ew==
X-Gm-Message-State: AOAM533LLUnFL3tU0zs1nDzQmGBD0JoLctTsCzVCqVBmdbAwvGOvbEJu
        pAtfye2QUGVTT41LXUSxfraDWmVUNMt1s+37Ltq7pGe8Hvx4zEzE5gLjHdHVB6hJAsNziyzE6bC
        wP68o+uGSscLJZ0pV41ZBArx7
X-Received: by 2002:a17:907:e8d:: with SMTP id ho13mr40593ejc.387.1623770848248;
        Tue, 15 Jun 2021 08:27:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyccg0L1KZ9HRDmng0aCPycLedCiLWQMiR/1yuXJ4epefHBw9Kz5GYIcrrgex/qKDfX2NhxbQ==
X-Received: by 2002:a17:907:e8d:: with SMTP id ho13mr40579ejc.387.1623770848094;
        Tue, 15 Jun 2021 08:27:28 -0700 (PDT)
Received: from redhat.com ([77.126.22.11])
        by smtp.gmail.com with ESMTPSA id y10sm10323681ejm.76.2021.06.15.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 08:27:26 -0700 (PDT)
Date:   Tue, 15 Jun 2021 11:27:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio-blk: Add validation for block size in config
 space
Message-ID: <20210615112612-mutt-send-email-mst@kernel.org>
References: <20210615104810.151-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615104810.151-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 06:48:10PM +0800, Xie Yongji wrote:
> This ensures that we will not use an invalid block size
> in config space (might come from an untrusted device).
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

I'd say if device presents an unreasonable value,
and we want to ignore that, then we should not
negotiate VIRTIO_BLK_F_BLK_SIZE so that host knows.

So maybe move the logic to validate_features.

> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b9fa3ef5b57c..85ae3b27ea4b 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -827,7 +827,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
>  				   struct virtio_blk_config, blk_size,
>  				   &blk_size);
> -	if (!err)
> +	if (!err && blk_size >= SECTOR_SIZE && blk_size <= PAGE_SIZE)
>  		blk_queue_logical_block_size(q, blk_size);
>  	else
>  		blk_size = queue_logical_block_size(q);
> -- 
> 2.11.0

