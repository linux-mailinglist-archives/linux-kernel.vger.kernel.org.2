Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD6348E42
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCYKmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230237AbhCYKmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616668931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQDI6ul2y7LDTOrys0NWj2wyx1hXa7tSyglML0bhC18=;
        b=KchhdeGfkta7UjzBaNgoi/j/pZtgG3NjgR/rt4JDX9XQs3yTi5JPYx9IM09ZgE6hAVSQtg
        KgxiMfUZcsPp5Af0VB0rF/git+pGcnFQFcGXJSuKkcBA8CVMXYbAz4yTelCXDq90YbK1Yx
        DtZbxLoa/WeTwt0nEJknzAbmRZiWBj0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-ukc6U82mOO2oA8iYpCn8Qg-1; Thu, 25 Mar 2021 06:42:09 -0400
X-MC-Unique: ukc6U82mOO2oA8iYpCn8Qg-1
Received: by mail-wr1-f72.google.com with SMTP id f3so2448839wrt.14
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 03:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aQDI6ul2y7LDTOrys0NWj2wyx1hXa7tSyglML0bhC18=;
        b=q9S67l1AyLBpTYm1uDL5NN4sSCTTpOdI6bRLhvScE+qCQtMYCuYED7JD75RdvQqvam
         +6esFOA+5ChFSmEiv/i6NpvNdRaF0yVg8eiGpv4kVwnaH7yOJwj1V0M/wxidRqTzjG7a
         v0Xgn3g5z5TtpCZfyRys2uPZXBiA/xHeDIodmQmrcBH0XQd4xmUAuolh+4bA3Y+ijzUk
         zBGQpzjgaLT/Wdrq33r5gTeEQkHUZllVr9yvPnerYnpBz8XvSBpqmgE8sY/TwwOXZd+m
         eHbIpY+e2v7bhVhWRdV0475O3+6EWvBDDwU+SfbQDb7+FARUu0lMArLD5KXYHjYEIpm+
         6ZDQ==
X-Gm-Message-State: AOAM531sBrdT1jCeD+X8/SYG0jXjoCh7XvehS5LRu1FzpUb8nGtvo2xT
        11Ru5L2S7uhqCs00Rb6eplJcgCKgLuZfBIwEG/cGL7birpICKtx4S6u0tkug/hX7noiEZEZoQKV
        HuUTj9V8wIAjiTFhmtDFNdKsV
X-Received: by 2002:a05:600c:3506:: with SMTP id h6mr7332005wmq.168.1616668928292;
        Thu, 25 Mar 2021 03:42:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG/dVJd/zV/tTUYY28Q+C/IDwYWmzMmVdSbdEw8RE1Cc5u1xVljyOZijxgygq5uU0DSr+VGA==
X-Received: by 2002:a05:600c:3506:: with SMTP id h6mr7331961wmq.168.1616668927966;
        Thu, 25 Mar 2021 03:42:07 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id p18sm6580970wrs.68.2021.03.25.03.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 03:42:07 -0700 (PDT)
Date:   Thu, 25 Mar 2021 11:42:05 +0100
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
        Jeff Vander Stoep <jeffv@google.com>,
        Alexander Popov <alex.popov@linux.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v7 17/22] vhost/vsock: setup SEQPACKET ops for
 transport
Message-ID: <20210325104205.y5z6qjv5g2kzvj3m@steredhat>
References: <20210323130716.2459195-1-arseny.krasnov@kaspersky.com>
 <20210323131421.2461760-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210323131421.2461760-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 04:14:18PM +0300, Arseny Krasnov wrote:
>This also removes ignore of non-stream type of packets and adds
>'seqpacket_allow()' callback.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> drivers/vhost/vsock.c | 15 +++++++++++++--
> 1 file changed, 13 insertions(+), 2 deletions(-)

Same thing for this transporter too, maybe we can merge with the patch 
"vhost/vsock: SEQPACKET feature bit support".

Stefano

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 5e78fb719602..5af141772068 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -354,8 +354,7 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
> 		return NULL;
> 	}
>
>-	if (le16_to_cpu(pkt->hdr.type) == VIRTIO_VSOCK_TYPE_STREAM)
>-		pkt->len = le32_to_cpu(pkt->hdr.len);
>+	pkt->len = le32_to_cpu(pkt->hdr.len);
>
> 	/* No payload */
> 	if (!pkt->len)
>@@ -398,6 +397,8 @@ static bool vhost_vsock_more_replies(struct vhost_vsock *vsock)
> 	return val < vq->num;
> }
>
>+static bool vhost_transport_seqpacket_allow(void);
>+
> static struct virtio_transport vhost_transport = {
> 	.transport = {
> 		.module                   = THIS_MODULE,
>@@ -424,6 +425,10 @@ static struct virtio_transport vhost_transport = {
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = virtio_transport_stream_allow,
>
>+		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
>+		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
>+		.seqpacket_allow          = vhost_transport_seqpacket_allow,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>@@ -439,8 +444,14 @@ static struct virtio_transport vhost_transport = {
> 	},
>
> 	.send_pkt = vhost_transport_send_pkt,
>+	.seqpacket_allow = false
> };
>
>+static bool vhost_transport_seqpacket_allow(void)
>+{
>+	return vhost_transport.seqpacket_allow;
>+}
>+
> static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> {
> 	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
>-- 
>2.25.1
>

