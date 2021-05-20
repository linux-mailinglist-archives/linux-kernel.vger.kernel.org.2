Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41767389EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhETHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:37:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229534AbhETHhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621496141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c2GC6XfcAGM7klDITVVJQzbY0FDd+BlAJFrTDoANgwk=;
        b=i3AZHTyrCrZ0+/w4ZhB1hQPD1w7N8dZp4b5hGYBAZLqinpMhUdsajaKxY9uOurc6mUoVGg
        zAUztllzJu9SFlWS31rUv7qTgvLhx/rVq24H8KLZQ98uhMSccELzIFvHtZia6G7IcO/xb8
        Bp3LwJM+SLFpl5TZQg1lE9i2i2UIdAU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-Dkbx3AwlO7GIgxa_uNblkA-1; Thu, 20 May 2021 03:35:40 -0400
X-MC-Unique: Dkbx3AwlO7GIgxa_uNblkA-1
Received: by mail-ej1-f69.google.com with SMTP id x20-20020a1709061354b02903cff4894505so4607201ejb.14
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 00:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c2GC6XfcAGM7klDITVVJQzbY0FDd+BlAJFrTDoANgwk=;
        b=jwu9b9lBraCqPmPgyn3ltHkQNucrG3jOLAcIZWji6K2XkW9fGsczuLEPi7Qbcqi/7v
         Er5wXpoI3gGmH8/xTTtGhZq6C8isJ12SVeV00Jol8IZ0l5gWG5/sA3ygEFDBa0XH/IAz
         +OA5BtxQEBQ5+g+H+LAllURTAiKTASK9Lqbp0vz5gx/JBuTFcwqOqZ2dCmbVxbbIFRRY
         b/r+JoFnr3NdEmKyxUcFt8LEYMo5wNuiqsq80bIsRwfe5Eh2fxu9fmVIr72Or+aacctZ
         G8Jr7ODivEuZWACyKVD9pj5ItKQoTzM3xhA7k/ivbqAHqqNS96ibaTyvB6cY4bHyyNCE
         zjsg==
X-Gm-Message-State: AOAM533uIZt+bwhfTPzK13FXnNGiuwaqkpPCEzXomNpcH+5nHJvkXerk
        S7wuLds62rjq/5U8JDmvzvCl3jcMUGCmV5OqvHwbclj5vKARxm5a8eN20rsGCdXp/stkhc/K1zi
        hldV6wNQFS4WY0asu7/1DOVfa
X-Received: by 2002:a17:906:5fd1:: with SMTP id k17mr3268852ejv.78.1621496138922;
        Thu, 20 May 2021 00:35:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3yNqbBi9L1vw+iCsmEmnynKc2Wo1hueUUMZwRAIdxoVlgOwjm86mz7dHambL3NGBp2Mtvog==
X-Received: by 2002:a17:906:5fd1:: with SMTP id k17mr3268844ejv.78.1621496138769;
        Thu, 20 May 2021 00:35:38 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id ga3sm951545ejb.34.2021.05.20.00.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 00:35:38 -0700 (PDT)
Date:   Thu, 20 May 2021 09:35:36 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        kuba@kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Remove BUG() to aviod machine dead
Message-ID: <20210520073536.wwt35gsz62bv27hm@steredhat>
References: <a351fbe1-0233-8515-2927-adc826a7fb94@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a351fbe1-0233-8515-2927-adc826a7fb94@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you need to respin, there is a typo in the title s/aviod/avoid/

On Tue, May 18, 2021 at 05:46:56PM +0800, Xianting Tian wrote:
>When met error, we output a print to avoid a BUG().
>
>Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>---
> drivers/net/virtio_net.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index c921ebf3ae82..a66174d13e81 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -1647,9 +1647,8 @@ static int xmit_skb(struct send_queue *sq, 
>struct sk_buff *skb)
> 		hdr = skb_vnet_hdr(skb);
>
> 	if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
>-				    virtio_is_little_endian(vi->vdev), false,
>-				    0))
>-		BUG();
>+				virtio_is_little_endian(vi->vdev), false, 0))
                                 ^
                                 This change is not related.

>+		return -EPROTO;
>
> 	if (vi->mergeable_rx_bufs)
> 		hdr->num_buffers = 0;
>-- 
>2.17.1
>

