Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C458E348E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCYKka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229854AbhCYKj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616668796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/kpD2aeNiHkluUl+lY5UKmHgOwXffwSQz+l4fa/jph4=;
        b=cnu+/53sQdcj1f2aVCX1bdB85aJOH69WeDUYsurcz0forrowm5FxZqvcbJBTqteiEzceer
        duOczffPczCXzMV4SPGRb4010DkK0ew2GWh+KiXQFU9pBtcQkO+s2muus1G0dwAyn61P+Y
        mwleDr2GrRYZsh36qTiYqK6EJo5LCR4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-xHd6uyUyMVakeZDHKjdIzA-1; Thu, 25 Mar 2021 06:39:55 -0400
X-MC-Unique: xHd6uyUyMVakeZDHKjdIzA-1
Received: by mail-wm1-f69.google.com with SMTP id r65-20020a1c2b440000b029010f4ee06223so783340wmr.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 03:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/kpD2aeNiHkluUl+lY5UKmHgOwXffwSQz+l4fa/jph4=;
        b=qps6Ea0tbdfEUjK20WSAmEmcZu/AEirUeAJVyj4KgdBiQt+R/Df0zYoFASr5tiX94o
         Ayzle8gwrSzBU80RrcSLQQ8Ff8Wvp1cEOV0qPEl73nIoa78S01DpRIHEKecTZSujqKM8
         aOjrNUXcO6y81v45y81BYye2NPu0ByrPY9VZfdhzYeE7NOLwe/xCcc0oaZzHopJJTdc8
         MWWxPjwyS1c9DDB2eKqdjIH2eKYy/uZo4+MOtYBrwQTURvvPv9w/w7khZA91AgIOmvoD
         nzBEDRZwvBy8tXhgHPIYW2Uo9+XV/EC+I1fk6+3pLFDrjewhv4FuYbyLqntu5QjuzNyC
         b4Sw==
X-Gm-Message-State: AOAM532L0etRe9a4w/NjaD6p6PHIc6gHP/i6KeBjJYJByxk6l37OOr48
        pTaqbL0pDHNef/OdsQ3onPt++Qxc5AH1lbZ5YCVQF3OAwX+oh8aGi7u8AGRL/P2ne6SGZr1/JOB
        u2fvHeIagBA5quagpsihhN0l5
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr8193212wrw.355.1616668793957;
        Thu, 25 Mar 2021 03:39:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSTH23goWjAebsKh2RhkZfdPUdCAZpsy4s0EXvpQEhvBoOO6j7qufPnU+Ca8egdJ+gYncnng==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr8193189wrw.355.1616668793779;
        Thu, 25 Mar 2021 03:39:53 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id c2sm6099603wmr.22.2021.03.25.03.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 03:39:53 -0700 (PDT)
Date:   Thu, 25 Mar 2021 11:39:50 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Colin Ian King <colin.king@canonical.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Jeff Vander Stoep <jeffv@google.com>,
        Alexander Popov <alex.popov@linux.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v7 16/22] virtio/vsock: setup SEQPACKET ops for
 transport
Message-ID: <20210325103950.7k75hntees5ppgbm@steredhat>
References: <20210323130716.2459195-1-arseny.krasnov@kaspersky.com>
 <20210323131406.2461651-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210323131406.2461651-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 04:14:03PM +0300, Arseny Krasnov wrote:
>This adds SEQPACKET ops for virtio transport and 'seqpacket_allow()'
>callback.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/virtio_transport.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)

Sorry for not mentioning this in the previous review, but maybe we can 
merge this patch with "virtio/vsock: SEQPACKET feature bit support", so 
we have a single patch when we fully enable the SEQPACKET support in 
this transport.

Anyway, I don't have a strong opinion on that.

What do you think?

Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport.c 
>b/net/vmw_vsock/virtio_transport.c
>index 2700a63ab095..83ae2078c847 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -443,6 +443,8 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
> 	queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> }
>
>+static bool virtio_transport_seqpacket_allow(void);
>+
> static struct virtio_transport virtio_transport = {
> 	.transport = {
> 		.module                   = THIS_MODULE,
>@@ -469,6 +471,10 @@ static struct virtio_transport virtio_transport = {
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
>@@ -483,8 +489,14 @@ static struct virtio_transport virtio_transport = {
> 	},
>
> 	.send_pkt = virtio_transport_send_pkt,
>+	.seqpacket_allow = false
> };
>
>+static bool virtio_transport_seqpacket_allow(void)
>+{
>+	return virtio_transport.seqpacket_allow;
>+}
>+
> static void virtio_transport_rx_work(struct work_struct *work)
> {
> 	struct virtio_vsock *vsock =
>-- 2.25.1
>

