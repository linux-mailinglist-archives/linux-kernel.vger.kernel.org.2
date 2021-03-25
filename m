Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A25B348DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCYKIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229533AbhCYKIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616666896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pU5HF2Zqf9J2oGlSjnzcSVRUkp00dVcRxrCu9/f0WWI=;
        b=dSN9DwuDx2vbd1ZDjK7K4s4cyUrxt8m3qaCWrY86OMH9J0CfEz8QZMKiLcSItlChuYPopS
        srPiZyAs7qetWTD/GrBh60PtjNiktVOnx+Tv5kbOhgYNHFTlqgi4dmyqOUc5INKrHTpicZ
        CQFpD7Kmg19kRkpOE7sjwzjUS1iMx6A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-go85J5djORmEPsVjmoUEVQ-1; Thu, 25 Mar 2021 06:08:14 -0400
X-MC-Unique: go85J5djORmEPsVjmoUEVQ-1
Received: by mail-wm1-f71.google.com with SMTP id r18so1476369wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 03:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pU5HF2Zqf9J2oGlSjnzcSVRUkp00dVcRxrCu9/f0WWI=;
        b=LzHkBFN3l+Ci139NFKrwZ2Qno2xht3YLU8UkqMlBBh4kEsZ7rLLQgYAsxuOYENMAI6
         iicFezPb9RfUVMBezSKYECWdO+zUBtJ7PYbwV2pfduEvJcdig5PDyiRu7poV8ff3oRyB
         0upuPhEcXm50ChNod/UfxlqObVAoGS04sixmmhJFU8xgd8oVcGRN/YuK+ZOLIyKBxIcV
         7WwQubXtUe3N1RQ1kuqNGmWIP8/0+NAjj+gu0b+Y8fgYLXe+jWLEJ+zI9c7h4Xgjj9YV
         8gisrr9pEjpS4dfUIAC2hLUQ4tQaY9MPQ7yosDP3Gp8rjJkBUh070R4mlOlBvACl4ZkQ
         sDVg==
X-Gm-Message-State: AOAM533sZb4Nyd1qvOJ6bFRuoNWZbCcuyUODoG6Z3PkPKN5EVSROQorn
        K9OvNOmbEVNuU5z4VwCHcFlqisQBcvoZeFk72nhMKm4ZWn0cO9j00+2Qx/v/zePNwmkkmnyb4H6
        OT5elcmTAETqxW5e4ot3vzcYd
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr8050183wrn.346.1616666893649;
        Thu, 25 Mar 2021 03:08:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMEBLS+WucRFXH7pX2XfS53TCF8pklH4jcshSQtgYvkIE6JYp/hse6ZXrowfH28LtmJN8axw==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr8050152wrn.346.1616666893409;
        Thu, 25 Mar 2021 03:08:13 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id i3sm6673746wra.66.2021.03.25.03.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 03:08:13 -0700 (PDT)
Date:   Thu, 25 Mar 2021 11:08:10 +0100
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
        Alexander Popov <alex.popov@linux.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v7 12/22] virtio/vsock: fetch length for SEQPACKET
 record
Message-ID: <20210325100810.ygmg6vqb2f7rxoyx@steredhat>
References: <20210323130716.2459195-1-arseny.krasnov@kaspersky.com>
 <20210323131258.2461163-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210323131258.2461163-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 04:12:55PM +0300, Arseny Krasnov wrote:
>This adds transport callback which tries to fetch record begin marker
>from socket's rx queue. It is called from af_vsock.c before reading data
>packets of record.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v6 -> v7:
> 1) Now 'virtio_transport_seqpacket_seq_get_len()' returns 0, if rx
>    queue of socket is empty. Else it returns length of current message
>    to handle.
> 2) If dequeue callback is called, but there is no detected length of
>    message to dequeue, EAGAIN is returned, and outer loop restarts
>    receiving.
>
> net/vmw_vsock/virtio_transport_common.c | 61 +++++++++++++++++++++++++
> 1 file changed, 61 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index a8f4326e45e8..41f05034593e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -399,6 +399,62 @@ static inline void virtio_transport_remove_pkt(struct virtio_vsock_pkt *pkt)
> 	virtio_transport_free_pkt(pkt);
> }
>
>+static size_t virtio_transport_drop_until_seq_begin(struct 
>virtio_vsock_sock *vvs)
>+{
>+	struct virtio_vsock_pkt *pkt, *n;
>+	size_t bytes_dropped = 0;
>+
>+	list_for_each_entry_safe(pkt, n, &vvs->rx_queue, list) {
>+		if (le16_to_cpu(pkt->hdr.op) == VIRTIO_VSOCK_OP_SEQ_BEGIN)
>+			break;
>+
>+		bytes_dropped += le32_to_cpu(pkt->hdr.len);
>+		virtio_transport_dec_rx_pkt(vvs, pkt);
>+		virtio_transport_remove_pkt(pkt);
>+	}
>+
>+	return bytes_dropped;
>+}
>+
>+static size_t virtio_transport_seqpacket_seq_get_len(struct vsock_sock *vsk)
>+{
>+	struct virtio_vsock_seq_hdr *seq_hdr;
>+	struct virtio_vsock_sock *vvs;
>+	struct virtio_vsock_pkt *pkt;
>+	size_t bytes_dropped = 0;
>+
>+	vvs = vsk->trans;
>+
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	/* Have some record to process, return it's length. */
>+	if (vvs->seq_state.user_read_seq_len)
>+		goto out;
>+
>+	/* Fetch all orphaned 'RW' packets and send credit update. */
>+	bytes_dropped = virtio_transport_drop_until_seq_begin(vvs);
>+
>+	if (list_empty(&vvs->rx_queue))
>+		goto out;
>+
>+	pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
>+
>+	vvs->seq_state.user_read_copied = 0;
>+
>+	seq_hdr = (struct virtio_vsock_seq_hdr *)pkt->buf;
>+	vvs->seq_state.user_read_seq_len = le32_to_cpu(seq_hdr->msg_len);
>+	vvs->seq_state.curr_rx_msg_id = le32_to_cpu(seq_hdr->msg_id);
>+	virtio_transport_dec_rx_pkt(vvs, pkt);
>+	virtio_transport_remove_pkt(pkt);
>+out:
>+	spin_unlock_bh(&vvs->rx_lock);
>+
>+	if (bytes_dropped)
>+		virtio_transport_send_credit_update(vsk);
>+
>+	return vvs->seq_state.user_read_seq_len;
>+}
>+
> static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 						 struct msghdr *msg,
> 						 bool *msg_ready)
>@@ -522,6 +578,11 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> 	if (flags & MSG_PEEK)
> 		return -EOPNOTSUPP;
>
>+	*msg_len = virtio_transport_seqpacket_seq_get_len(vsk);
>+
>+	if (*msg_len == 0)
>+		return -EAGAIN;
>+

Okay, I see now, I think you can move this patch before the previous one 
or merge them in a single patch, it is better to review and to bisect.

As mentioned, I think we can return msg_len if 
virtio_transport_seqpacket_do_dequeue() does not fail, otherwise the 
error.

I mean something like this:

static ssize_t virtio_transport_seqpacket_do_dequeue(...)
{
	size_t msg_len;
	ssize_t ret;

	msg_len = virtio_transport_seqpacket_seq_get_len(vsk);
	if (msg_len == 0)
		return -EAGAIN;

	ret = virtio_transport_seqpacket_do_dequeue(vsk, msg, msg_ready);
	if (ret < 0)
		return ret;

	return msg_len;
}

> 	return virtio_transport_seqpacket_do_dequeue(vsk, msg, msg_ready);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>-- 2.25.1
>

