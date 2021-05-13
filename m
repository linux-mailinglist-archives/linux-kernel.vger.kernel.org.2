Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D01737F833
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhEMMus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232944AbhEMMu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620910158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NSrjqlQIJu1uxoxnuhMrvLQLzbH8gXslRcYpELalTPg=;
        b=irllEUc7Yn8v5Vl9RqE6QuUePztTLGPxYfeYfiR15lXEInISCOiUcrLYnRORS2UZRL2mN3
        t1Q+6IXAdtREDLXAHpe12+eHYL1jlUJquZRYpfYTvpgVmlU21w+3UFETvx2bH5/RjfEeE0
        kgEjmYsdWuNGah7iwAkVEmusY8eshic=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-53JqNCMsMFiBrw9hDBSU7g-1; Thu, 13 May 2021 08:49:16 -0400
X-MC-Unique: 53JqNCMsMFiBrw9hDBSU7g-1
Received: by mail-ed1-f69.google.com with SMTP id p8-20020aa7c8880000b029038ce714c8d6so234239eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NSrjqlQIJu1uxoxnuhMrvLQLzbH8gXslRcYpELalTPg=;
        b=sTAVAqhbICXkVcMla7CdAaRFv8y3jwN6OTf0gEVI+nbYNurTe6i6ysdQj3eaoKC8H/
         NkAjyxiVHFsQUiHwc7ZKh0qGHCRAH+Whtojh6LKbgxkkg/F18X8XqEGmDxBNISNiiNvL
         PPiH44ZavSUoH29X2fIdp/hRr5M2GvDgwBdm3Lc6wxxSV8DAjFvztoXtWskq7VbN2aA3
         CUlRB1+siWWIfKnQmv3X0r6rm7LZue9PsiSlCTXo0VX6fI3gBi3/U3e4wHz8KI7mMjGP
         d9HJ9YAZgN9TjCXxINw3Selig4VITkMJ6YCj9oD0AlMdAhZQEQyFLy5oXAQIf95DRkdt
         PX+g==
X-Gm-Message-State: AOAM532GumyYqpo1nH9WI1lVmFgIhsnn/LxikQdeTW1Zgh7mS6HvIL4Z
        YVPVYPe5PCVnkk+BKOkGy4Hd6zY+MhuSzJJGl//DcJh6VBN2Q/kjFOdd1sdpP0TNH4Oul43MNSH
        g047gPx2b1CYyvm2o8qh/PATo
X-Received: by 2002:a17:906:144d:: with SMTP id q13mr45360840ejc.458.1620910155410;
        Thu, 13 May 2021 05:49:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoWSdvzLm133gY1yGZQzxSLocSHvkGSmNAzGowvENZeAXfZJswxcWVjdFLnXw30TfArShrKw==
X-Received: by 2002:a17:906:144d:: with SMTP id q13mr45360828ejc.458.1620910155258;
        Thu, 13 May 2021 05:49:15 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id j22sm1873651ejt.11.2021.05.13.05.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:49:14 -0700 (PDT)
Date:   Thu, 13 May 2021 14:49:12 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>,
        Colin Ian King <colin.king@canonical.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v9 14/19] virtio/vsock: enable SEQPACKET for transport
Message-ID: <20210513124912.sw4rea75re7xwjdz@steredhat>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163617.3432380-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210508163617.3432380-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 07:36:14PM +0300, Arseny Krasnov wrote:
>This adds
>1) SEQPACKET ops for virtio transport and 'seqpacket_allow()' callback.
>2) Handling of SEQPACKET bit: guest tries to negotiate it with vhost.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v8 -> v9:
> 1) Move 'seqpacket_allow' to 'struct virtio_vsock'.
>
> net/vmw_vsock/virtio_transport.c | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 2700a63ab095..f714c16af65d 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -62,6 +62,7 @@ struct virtio_vsock {
> 	struct virtio_vsock_event event_list[8];
>
> 	u32 guest_cid;
>+	bool seqpacket_allow;
> };
>
> static u32 virtio_transport_get_local_cid(void)
>@@ -443,6 +444,8 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
> 	queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> }
>
>+static bool virtio_transport_seqpacket_allow(u32 remote_cid);
>+
> static struct virtio_transport virtio_transport = {
> 	.transport = {
> 		.module                   = THIS_MODULE,
>@@ -469,6 +472,10 @@ static struct virtio_transport virtio_transport = {
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = virtio_transport_stream_allow,
>
>+		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
>+		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
>+		.seqpacket_allow          = virtio_transport_seqpacket_allow,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>@@ -485,6 +492,19 @@ static struct virtio_transport virtio_transport = {
> 	.send_pkt = virtio_transport_send_pkt,
> };
>
>+static bool virtio_transport_seqpacket_allow(u32 remote_cid)
>+{
>+	struct virtio_vsock *vsock;
>+	bool seqpacket_allow;
>+
>+	rcu_read_lock();
>+	vsock = rcu_dereference(the_virtio_vsock);
>+	seqpacket_allow = vsock->seqpacket_allow;
>+	rcu_read_unlock();
>+
>+	return seqpacket_allow;
>+}
>+
> static void virtio_transport_rx_work(struct work_struct *work)
> {
> 	struct virtio_vsock *vsock =
>@@ -612,6 +632,10 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>
> 	mutex_unlock(&the_virtio_vsock_mutex);
>+
>+	if (vdev->features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))

We should use virtio_has_feature() to check the device features.

>+		vsock->seqpacket_allow = true;

When we assign the_virtio_vsock pointer, we should already set all the 
fields, so please move this code before the following block:

	# here

	vdev->priv = vsock;
	rcu_assign_pointer(the_virtio_vsock, vsock);

