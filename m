Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8906A318D27
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 15:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhBKORq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 09:17:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47906 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232085AbhBKOAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 09:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613051932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1bEflgou0H31BnnK3AQtbjmN1ZghmRenGr52+hcNzT0=;
        b=e2mIsZoxMJd+7o/U3tp0mHKYDk0ikgRvUxcJTuQdm3EqXRkkl17hDhXn8HoVmH1FHs0iCI
        YdxG0SvPhgHhWRDP+xFwT98kfH1qloO1H/X4vaQEbk/P+gYPKNGKQOH3MMvsDAh6u8aajD
        TvKHlvWXLAWxDHhNg1gwR/bnRLh5B4s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-LwLu3DQ8Pt2UBYjWCQpQzQ-1; Thu, 11 Feb 2021 08:58:51 -0500
X-MC-Unique: LwLu3DQ8Pt2UBYjWCQpQzQ-1
Received: by mail-ed1-f72.google.com with SMTP id f21so4569941edx.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 05:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1bEflgou0H31BnnK3AQtbjmN1ZghmRenGr52+hcNzT0=;
        b=KiUmx2w5Tw+eXbw+7kUBrfcCtfkVSdXHT/etVby/gGG7dJUq+tntfe63C6hlraSLRd
         F38u24TSEcPtLYFGgGRLbpJEQTzPn3oWtV6Ty0T/3Ci31r593gCQc5BX2DWwCkRhvvgq
         td3cFjsmq00fk65b+NL4e9MLhVjPURiSbASWcgI77SuZDI+PVN+yKfjR4bXUiDYzZK8Y
         HI+t+xqdVpImt+fErLtIAhgTWktP8rwOF+RBTyMvbc+2J012iHogq6I4nxjvqeKXUwHN
         DbnhO/Tnfe6Hpe4MN0+FzA5+p2eWnd+HNGZyMJn5KZfxjXbPVfeQSTpg0XKbrAJlvHjt
         Q+LA==
X-Gm-Message-State: AOAM532KxxFqzTauPLhYPvpoGSuIr5vKmRwc2M/dUxD3Zp//7hnMjrn2
        T6oiP6vstV3tdJenVtTgP8WiG8sIZK3utfYb0W9WVSNbe10Q+DXJs1hW5aN7hkcPEtZja8i/gNb
        s7KzGHoTO5IIWbK/4flbMqBfc
X-Received: by 2002:a05:6402:5112:: with SMTP id m18mr8549451edd.129.1613051929541;
        Thu, 11 Feb 2021 05:58:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfq7X7hD1JmHzQK5zfZIpxq+rP5EN2ilMJ1bkKStokLGIe1TtlOeeeu3gyeUI3B8S6k0JFzg==
X-Received: by 2002:a05:6402:5112:: with SMTP id m18mr8549428edd.129.1613051929358;
        Thu, 11 Feb 2021 05:58:49 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id bd27sm3969917edb.37.2021.02.11.05.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 05:58:48 -0800 (PST)
Date:   Thu, 11 Feb 2021 14:58:46 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Colin Ian King <colin.king@canonical.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Jeff Vander Stoep <jeffv@google.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 10/17] virtio/vsock: fetch length for SEQPACKET
 record
Message-ID: <20210211135846.mxqdranvda72vq65@steredhat>
References: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
 <20210207151711.805503-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210207151711.805503-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 06:17:08PM +0300, Arseny Krasnov wrote:
>This adds transport callback which tries to fetch record begin marker
>from socket's rx queue. It is called from af_vsock.c before reading data
>packets of record.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport_common.c | 40 +++++++++++++++++++++++++
> 2 files changed, 41 insertions(+)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 4d0de3dee9a4..a5e8681bfc6a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -85,6 +85,7 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
> 			       size_t len, int flags);
>
>+size_t virtio_transport_seqpacket_seq_get_len(struct vsock_sock *vsk);
> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 4572d01c8ea5..7ac552bfd90b 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -420,6 +420,46 @@ static size_t virtio_transport_drop_until_seq_begin(struct virtio_vsock_sock *vv
> 	return bytes_dropped;
> }
>
>+size_t virtio_transport_seqpacket_seq_get_len(struct vsock_sock *vsk)
>+{
>+	struct virtio_vsock_seq_hdr *seq_hdr;
>+	struct virtio_vsock_sock *vvs;
>+	struct virtio_vsock_pkt *pkt;
>+	size_t bytes_dropped;
>+
>+	vvs = vsk->trans;
>+
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	/* Fetch all orphaned 'RW', packets, and
>+	 * send credit update.

Single line?

>+	 */
>+	bytes_dropped = virtio_transport_drop_until_seq_begin(vvs);
>+
>+	if (list_empty(&vvs->rx_queue))
>+		goto out;
>+
>+	pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
>+
>+	vvs->user_read_copied = 0;
>+
>+	seq_hdr = (struct virtio_vsock_seq_hdr *)pkt->buf;
>+	vvs->user_read_seq_len = le32_to_cpu(seq_hdr->msg_len);
>+	vvs->curr_rx_msg_cnt = le32_to_cpu(seq_hdr->msg_cnt);
>+	virtio_transport_dec_rx_pkt(vvs, pkt);
>+	virtio_transport_remove_pkt(pkt);
>+out:
>+	spin_unlock_bh(&vvs->rx_lock);
>+
>+	if (bytes_dropped)
>+		virtio_transport_send_credit_update(vsk,
>+						    VIRTIO_VSOCK_TYPE_SEQPACKET,
>+						    NULL);
>+
>+	return vvs->user_read_seq_len;
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_seq_get_len);
>+
> static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 						 struct msghdr *msg,
> 						 bool *msg_ready)
>-- 
>2.25.1
>

