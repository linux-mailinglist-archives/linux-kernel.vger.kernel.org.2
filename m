Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951C7311740
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhBEXnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:43:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232048AbhBEOTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612540561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YxfECkOsSZ1stOC425/5nMxggTO4yyHeVSunIkBmhLY=;
        b=EEZgGQFTmppmsZbUEk10t1j4jOhUGu1NA6wK6yFoyiBt6v4M+VJvXBYcg6rROgig9kH3lz
        MlpBozNfLUuIqcbhEf459P+R5KT47GrrRgSZyPc36srPltoraLEjyABfbW0a1fsvIvlFJI
        jktMHuDzcgErAZosOG09TJ8tg+sQ3qg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-f3KqPuZUOO-RP-iqDgoIkw-1; Fri, 05 Feb 2021 10:25:06 -0500
X-MC-Unique: f3KqPuZUOO-RP-iqDgoIkw-1
Received: by mail-wr1-f70.google.com with SMTP id j8so5526375wrx.17
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YxfECkOsSZ1stOC425/5nMxggTO4yyHeVSunIkBmhLY=;
        b=mkgQe9gXB/zDj7BWAnAIyzhMBF2foDrIzRheQZsfunx1lw9RwO2dOubMKfSctx9HLS
         wPxU7StLoMooYI+F4y2izgOaanQGMayGHXgQwWs5p8oQifKE4Web1R1WtU+25+OnBJH5
         ATxEBfR/cUedyVKUs9ct0XjfUOtR/KpDfT180442CKY1QdPQGHNI5iep230k8IlCifiT
         yCcKjpA2yzZm9NWZkYU58QddXjFuwrFB619yViDOXtp4HkUFJruWOmpGqgKBnnaDiPVy
         74EHUqNxtNlne63acgYqiiOhcyV/IlrWOqzDt6XrFgtkmII5xRWl21OFvy4xMoGkqWvw
         mUEA==
X-Gm-Message-State: AOAM530zx20ZWrciZe0no7NgryQG5SUhGprSbEIjVucQ6DBBdWeVGQV9
        lDjqXhSz0XS4UiTIGq3qpJr5YCUVr9j0boQ8nlrz8B1zWtOHBBmfD2b94KFDaepYAaEsMiGEVuT
        rbwbwfiNnUh6adBVljbI05kK7
X-Received: by 2002:a05:6000:41:: with SMTP id k1mr5536468wrx.386.1612538704681;
        Fri, 05 Feb 2021 07:25:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxh9sPVEw44Ux+BaaaaDLWX/oOyRAPVDo/jFYvRscnoIbqqTxP54NPPzP3n77CaXR4yrWtdw==
X-Received: by 2002:a05:6000:41:: with SMTP id k1mr5536451wrx.386.1612538704557;
        Fri, 05 Feb 2021 07:25:04 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id d9sm13031562wrq.74.2021.02.05.07.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 07:25:03 -0800 (PST)
Date:   Fri, 5 Feb 2021 10:24:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        lulu@redhat.com, sgarzare@redhat.com, rdunlap@infradead.org
Subject: Re: [PATCH V3 18/19] virtio_vdpa: don't warn when fail to disable vq
Message-ID: <20210205102442-mutt-send-email-mst@kernel.org>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-19-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104065503.199631-19-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 02:55:02PM +0800, Jason Wang wrote:
> There's no guarantee that the device can disable a specific virtqueue
> through set_vq_ready(). One example is the modern virtio-pci
> device. So this patch removes the warning.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Do we need the read as a kind of flush though?

> ---
>  drivers/virtio/virtio_vdpa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 4a9ddb44b2a7..e28acf482e0c 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -225,9 +225,8 @@ static void virtio_vdpa_del_vq(struct virtqueue *vq)
>  	list_del(&info->node);
>  	spin_unlock_irqrestore(&vd_dev->lock, flags);
>  
> -	/* Select and deactivate the queue */
> +	/* Select and deactivate the queue (best effort) */
>  	ops->set_vq_ready(vdpa, index, 0);
> -	WARN_ON(ops->get_vq_ready(vdpa, index));
>  
>  	vring_del_virtqueue(vq);
>  
> -- 
> 2.25.1

