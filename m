Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A92837F7A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhEMMP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233463AbhEMMPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620908046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SQD/pcH6/EwepQ7zwHhPK/O6wsXARP4FrHE+OPXdfJc=;
        b=dCWnbp8YcmX7203KW84kgS3WJvJiPiTcQlO4yoYjFtd2Jdgeyghhx6/M28tgG7Ltx3o0ST
        pObs4N5squKHiEVIhETG6czaKXVIjqaJg7Ag4oGcxLWfgeIptbjL+T8KTMJ+5gkCR/4DFx
        xWfj7yRHXApHjPJUtu6t9QKJMeYER3U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-TCMdD1UKP2q3mPgHnHItsQ-1; Thu, 13 May 2021 08:14:05 -0400
X-MC-Unique: TCMdD1UKP2q3mPgHnHItsQ-1
Received: by mail-ej1-f72.google.com with SMTP id o18-20020a17090637d2b02903bf3465db95so4159877ejc.18
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SQD/pcH6/EwepQ7zwHhPK/O6wsXARP4FrHE+OPXdfJc=;
        b=CjPIf22RdEPXDjUNWWFOXxPN1cp666NkuV1ozfNZLpktDkx8FQ91sqgXw6TE0uc+H3
         46zorLoQbqOpfVFhIkBuAqwpJCIi6MXO9NFDv4+M1s6JjqsNYOJ6M259pyjRtSmCzuYA
         qat4NrRXxAjaDkp+1tyZqsnnp0BDOGM8obzmUJTDPJM1/YYbYrySg4zjZIuj97x2KKlb
         osvmOY2f3K0O6WaSSBExYVdRu0RpByyhbqLF8AJIDfficGI3Yt901b+5BIz7VhHYDmOe
         idyjXxCAGRuqu8dReLLVuViWhFel10/tb27aFX8hxe1q50qUWL1ZvuX5/3YXkfnDsVqN
         k1GA==
X-Gm-Message-State: AOAM532jv48Lor+Clef2LBEMF50sSnPnhPePpUK1UeEUC9p6HiavrnoU
        DqtNJTEnwhkywkTnNxqgz5O61X4wbzGprA6PpXm1AZoycDS8XbRpIk+r7m24/J20zDClaukhMx9
        XmoymmyQ81z+ra1kfOUu2rS5Y
X-Received: by 2002:a05:6402:6cd:: with SMTP id n13mr51384883edy.330.1620908043091;
        Thu, 13 May 2021 05:14:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiXiCGmnyqZKpqgMhRFcjk2WSuaiuU6ojG6BUl5WGN+JeIJysyCkHdp91nTXn7XKitQGIpkA==
X-Received: by 2002:a05:6402:6cd:: with SMTP id n13mr51384863edy.330.1620908042947;
        Thu, 13 May 2021 05:14:02 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id bn5sm1728763ejb.97.2021.05.13.05.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:14:02 -0700 (PDT)
Date:   Thu, 13 May 2021 14:14:00 +0200
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
Subject: Re: [RFC PATCH v9 12/19] virtio/vsock: add SEQPACKET receive logic
Message-ID: <20210513121400.7u7kectkxwame76b@steredhat>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163544.3432132-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210508163544.3432132-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 07:35:40PM +0300, Arseny Krasnov wrote:
>This modifies current receive logic for SEQPACKET support:
>1) Inserts 'RW' packet to socket's rx queue, but without merging with
>   buffer of last packet in queue.

This is not true anymore, right?

>2) Performs check for packet and socket types on receive(if mismatch,
>   then reset connection).
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Also this patch is changed :-)

>---
> net/vmw_vsock/virtio_transport_common.c | 28 +++++++++++++++++++++++--
> 1 file changed, 26 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index f649a21dd23b..7fea0a2192f7 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -165,6 +165,14 @@ void virtio_transport_deliver_tap_pkt(struct virtio_vsock_pkt *pkt)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
>
>+static u16 virtio_transport_get_type(struct sock *sk)
>+{
>+	if (sk->sk_type == SOCK_STREAM)
>+		return VIRTIO_VSOCK_TYPE_STREAM;
>+	else
>+		return VIRTIO_VSOCK_TYPE_SEQPACKET;
>+}
>+
> /* This function can only be used on connecting/connected sockets,
>  * since a socket assigned to a transport is required.
>  *
>@@ -980,11 +988,15 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 		/* If there is space in the last packet queued, we copy the
> 		 * new packet in its buffer.
> 		 */
>-		if (pkt->len <= last_pkt->buf_len - last_pkt->len) {
>+		if ((pkt->len <= last_pkt->buf_len - last_pkt->len) &&
>+		    !(le32_to_cpu(last_pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR)) {

Maybe we should update the comment above.

> 			memcpy(last_pkt->buf + last_pkt->len, pkt->buf,
> 			       pkt->len);
> 			last_pkt->len += pkt->len;
> 			free_pkt = true;
>+
>+			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR)
>+				last_pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);

What about doing the following in any case?

			last_pkt->hdr.flags |= pkt->hdr.flags;

> 			goto out;
> 		}
> 	}

