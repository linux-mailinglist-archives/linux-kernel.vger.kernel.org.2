Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2632C453447
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbhKPOhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:37:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237484AbhKPOg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637073239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gw+zT5Bn7Yu9SFxWiKnZNuSsR3PCxJWgrO3fVTViz5U=;
        b=bMHmzMo5pk1b571vuRuHNZdFGMHmALpi9CObtxAB/DJbhG0uU9dqIV3lI10GcmgucRT+XJ
        zR3uixQUWWu3kF70YfgPesf/a2oarEgGZ9V8J6iHD2X9/beNjKdFzboTXKt2eB6FDT7bMk
        QAh4QrjwaZX43OWy2pA1piwcEnIwUA0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-YSVv7ftvOZypgf7RSOMBSQ-1; Tue, 16 Nov 2021 09:33:58 -0500
X-MC-Unique: YSVv7ftvOZypgf7RSOMBSQ-1
Received: by mail-ed1-f72.google.com with SMTP id r16-20020a056402019000b003e6cbb77ed2so7455999edv.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gw+zT5Bn7Yu9SFxWiKnZNuSsR3PCxJWgrO3fVTViz5U=;
        b=JyfJ5qT2imDpaWlzRTVnhKKdz0Nvog1LH0ZI/mv9A9+TiH9tqpvT2X3ggqDKUyXYHU
         OQzjkBqHkLIDBJPCUiZC9Cl/TBwvqcPfl4IGEn+AcMvwqUIq01bNATJDiRe7ZlHK0tX9
         TpFDwwCfVrGR2EdKKz2WeQHv64owMRzPDIHI+OgE2Gsnc/1dQTM7MLwFawF1MvcZoUMO
         bw5AxggF2LM3Ah+MGkVWyJZW9LY9clsiz5ydhjsxYSmUApCJy8HEN6j2zOPU6GVBFszI
         lwBt31h8gx0qB0XVC9Uj/ohthgbk2aK7WtgcY5eGX3EVN4PGEr0G8n34Hgud6+l7XEV9
         wLzQ==
X-Gm-Message-State: AOAM533X/55eyxgS0Z//0wmT7+VovYK40hAm+7k2qysV/GrBhKA65lAK
        sn0pW6HlwrvSdwzHJpfCHN8YqB7tcseXUnYAjNQ4abL8LsD9+ReI9p8k8Yc4fVjjkBxtTdBSYtL
        xCwhh3dq+S0zlLkinuWlzDKPY
X-Received: by 2002:a17:906:2cd5:: with SMTP id r21mr10866454ejr.435.1637073236970;
        Tue, 16 Nov 2021 06:33:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsudr1k0KsGdEMmED92N84TSbVeptPs2C1EJfEE9/7YPC8Go6Zta6pz56XSBZBy8eqwHLpGA==
X-Received: by 2002:a17:906:2cd5:: with SMTP id r21mr10866430ejr.435.1637073236801;
        Tue, 16 Nov 2021 06:33:56 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id g15sm8766816ejt.10.2021.11.16.06.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 06:33:56 -0800 (PST)
Date:   Tue, 16 Nov 2021 15:33:54 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Andrey Ryabinin <arbn@yandex-team.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] vhost_net: get rid of vhost_net_flush_vq() and extra
 flush calls
Message-ID: <20211116143354.exgqcjfbmmbaahs4@steredhat>
References: <20211115153003.9140-1-arbn@yandex-team.com>
 <20211115153003.9140-2-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211115153003.9140-2-arbn@yandex-team.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 06:29:59PM +0300, Andrey Ryabinin wrote:
>vhost_net_flush_vq() calls vhost_work_dev_flush() twice passing
>vhost_dev pointer obtained via 'n->poll[index].dev' and
>'n->vqs[index].vq.poll.dev'. This is actually the same pointer,
>initialized in vhost_net_open()/vhost_dev_init()/vhost_poll_init()
>
>Remove vhost_net_flush_vq() and call vhost_work_dev_flush() directly.
>Do the flushes only once instead of several flush calls in a row
>which seems rather useless.
>
>Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
>---
> drivers/vhost/net.c   | 11 ++---------
> drivers/vhost/vhost.h |  1 +
> 2 files changed, 3 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>index 11221f6d11b8..b1feb5e0571e 100644
>--- a/drivers/vhost/net.c
>+++ b/drivers/vhost/net.c
>@@ -1373,16 +1373,9 @@ static void vhost_net_stop(struct vhost_net *n, struct socket **tx_sock,
> 	*rx_sock = vhost_net_stop_vq(n, &n->vqs[VHOST_NET_VQ_RX].vq);
> }
>
>-static void vhost_net_flush_vq(struct vhost_net *n, int index)
>-{
>-	vhost_work_dev_flush(n->poll[index].dev);
>-	vhost_work_dev_flush(n->vqs[index].vq.poll.dev);
>-}
>-
> static void vhost_net_flush(struct vhost_net *n)
> {
>-	vhost_net_flush_vq(n, VHOST_NET_VQ_TX);
>-	vhost_net_flush_vq(n, VHOST_NET_VQ_RX);
>+	vhost_work_dev_flush(&n->dev);
> 	if (n->vqs[VHOST_NET_VQ_TX].ubufs) {
> 		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
> 		n->tx_flush = true;
>@@ -1572,7 +1565,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
> 	}
>
> 	if (oldsock) {
>-		vhost_net_flush_vq(n, index);
>+		vhost_work_dev_flush(&n->dev);
> 		sockfd_put(oldsock);
> 	}
>
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index 638bb640d6b4..ecbaa5c6005f 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -15,6 +15,7 @@
> #include <linux/vhost_iotlb.h>
> #include <linux/irqbypass.h>
>
>+struct vhost_dev;

Is this change needed?

Stefano

