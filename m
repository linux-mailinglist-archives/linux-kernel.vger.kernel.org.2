Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D993322BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 14:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhBWNuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 08:50:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232227AbhBWNux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 08:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614088166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GOvexyYc/ObMQAaHFdie5/nomXHMwOs8rdABZEM/9Ps=;
        b=GMe5qvLqJszJzrOeGBYhPRAvyojqZkBmDlM5/7TJwr9Bp92NZ0PXWG9PKR05tn0K8//qsf
        k/fcqKIzmCOLlddRlPg/unXi5TVuRnUQ8GtuhPG79fwTktJdPILEbopnr0g8d53Xs2SoFF
        bzPFBfB9Nw5uLIFAqrZEbz5/EESMNcQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-JahgjmLpMgSuJJ9XwZWO-g-1; Tue, 23 Feb 2021 08:49:24 -0500
X-MC-Unique: JahgjmLpMgSuJJ9XwZWO-g-1
Received: by mail-wm1-f70.google.com with SMTP id f18so682336wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 05:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GOvexyYc/ObMQAaHFdie5/nomXHMwOs8rdABZEM/9Ps=;
        b=C/aPyJcJb2hkDKl8qvVSTwXzmT+pXNtlCnNtNPKR7ndZMC/96qCIS9vHU8yM9mpJVc
         MiQOMh08qgDkfTHvNCmbd7wFY1UDc2cNveLPqhyQFBAmWVGOiJPQ7wbT1AqlvXYMeDZm
         dB8wqk9J+ZK4TvR+UUDnKeK/1Q/mtQD10O9PSagUpG6riCF1l3XJSdnRTQz2E4HEpieK
         9Z3PslVO5sEa+GQSIhj+/3Xy1gEKjNuN+hSK8jGKqeEHp7qzggorEn70kcFuFnAAGS2Y
         R+MI7YaidrEVlWhPR808avIz1ZCEpVNN/10o0T3mV7cVCPmAPzI9P0vGLWA7BvAMxwyY
         xf5A==
X-Gm-Message-State: AOAM530MZmgsvaVqjUdVrdLq0NgQFYG596+gtj0i1bOuTT3IYdnnfVoo
        zYwbM9gCFMelX/knU8aa4XIRQcHTf/3zRuZNsXLQJkCwOkBAkS2EPcnW9tHzq2g/jyMQOP0N2bq
        PAQfuVjFyYiIH0W74LNQJ36BS
X-Received: by 2002:a1c:b741:: with SMTP id h62mr17331291wmf.85.1614088163362;
        Tue, 23 Feb 2021 05:49:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWyIcShiLHe07mw9HE/r5BInLl+NukEK8C2wh6/ekL9Dgw0dtDjxRuJKOsywf6vYjLteh5cg==
X-Received: by 2002:a1c:b741:: with SMTP id h62mr17331273wmf.85.1614088163149;
        Tue, 23 Feb 2021 05:49:23 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id s84sm198526wme.11.2021.02.23.05.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 05:49:22 -0800 (PST)
Date:   Tue, 23 Feb 2021 14:49:20 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Colin Ian King <colin.king@canonical.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v5 10/19] virtio/vsock: simplify credit update
 function API
Message-ID: <20210223134920.nvecqujytdfcqnbt@steredhat>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210218053926.1068053-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210218053926.1068053-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 08:39:23AM +0300, Arseny Krasnov wrote:
>'virtio_transport_send_credit_update()' has some extra args:
>1) 'type' may be set in 'virtio_transport_send_pkt_info()' using type
>   of socket.
>2) This function is static and 'hdr' arg was always NULL.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 15 ++++-----------
> 1 file changed, 4 insertions(+), 11 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 1c9d71ca5e8e..833104b71a1c 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -271,13 +271,10 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_put_credit);
>
>-static int virtio_transport_send_credit_update(struct vsock_sock *vsk,
>-					       int type,
>-					       struct virtio_vsock_hdr *hdr)
>+static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
>-		.type = type,
> 		.vsk = vsk,
> 	};

I don't know if it's better to remove type with the others changes in 
the previous patch, maybe it's more consistent.

I mean only the removal of 'type' parameter, the 'hdr' parameter should 
be removed with this patch.

>
>@@ -385,11 +382,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	 * messages, we set the limit to a high value. TODO: experiment
> 	 * with different values.
> 	 */
>-	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
>-		virtio_transport_send_credit_update(vsk,
>-						    
>VIRTIO_VSOCK_TYPE_STREAM,
>-						    NULL);
>-	}
>+	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>+		virtio_transport_send_credit_update(vsk);
>
> 	return total;
>
>@@ -498,8 +492,7 @@ void virtio_transport_notify_buffer_size(struct vsock_sock *vsk, u64 *val)
>
> 	vvs->buf_alloc = *val;
>
>-	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_STREAM,
>-					    NULL);
>+	virtio_transport_send_credit_update(vsk);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_notify_buffer_size);
>
>-- 
>2.25.1
>

