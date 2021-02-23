Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84A8322C12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhBWOSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:18:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232331AbhBWOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614089827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sdXyf3LSwUfaOHdYYNvJzMwzVE2QLNggB+GkV4jURgg=;
        b=SC8MshRB+n5jHs5hMXe1mmXYi/h9Mz4Eb6AYLDo9mltkuhrZVhEB2OeW+dbdk/zs4nei/i
        BfKYxwiTlbVn9KIf30UirrP7SYEZJBZBHBDXUeeNQ0sBL4pwYtcUTnxIqJ0e0xl6b0lIpw
        r4wUCCPmtOx5p5ziBMLV9CFWXKayGfo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-YMuT0lZVPVibswTBTCQbDw-1; Tue, 23 Feb 2021 09:17:06 -0500
X-MC-Unique: YMuT0lZVPVibswTBTCQbDw-1
Received: by mail-wr1-f69.google.com with SMTP id v3so920170wro.21
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 06:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sdXyf3LSwUfaOHdYYNvJzMwzVE2QLNggB+GkV4jURgg=;
        b=a9CqLJ58ZxhdnzHFl2T9i2otX4V++lxJut+9weC9nevpSBFgThcUQzR8KIT5vmPJTC
         awAsCIigmb/mLSkLUkb+a23xY4vS2b6E9Uq/5ExZH16khoWYv8ZuFbXf9SxbasCjwo/6
         eMyAfbGnYAkBbarJu0HJwXKW+kOpnf7BkhaVhI9+0DHFG/SOwMhOPY+NbSoCnfg55/mt
         etCAfShlkQYqK/TFSdJnFmMz9QyNJ52qE1Lb4gDBslhBu34GnEUnTjUXVLNZN5IwKyod
         3yggGy0C5ybsZwEDfN/my1U6QSlWme/HHZS121Shv5A2D9upTeGUO4bBTaBWynWZcTi5
         DL4g==
X-Gm-Message-State: AOAM5308tzGzfNCj3brG3UaR+P4KHDfcPw8mlDclV6dq2t/iFIDmEDRd
        MNMvvg1gWbo9rTtFXGZUtzeEqHaT4PHPvDjfFmRxMJ3w8X2V71FzEsAbOQz1YFznktkdztjwqHW
        uGm6UllZqpKe+xvUVaAnL/Fqk
X-Received: by 2002:a5d:6281:: with SMTP id k1mr348207wru.405.1614089825287;
        Tue, 23 Feb 2021 06:17:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJRkCFoKbQo6xkTrUQIfNHvZqxmgXuNRPSXDblbZ7p/K2Lm7SUd5TdeJEawHMxG9rT2h8eEQ==
X-Received: by 2002:a5d:6281:: with SMTP id k1mr348184wru.405.1614089825095;
        Tue, 23 Feb 2021 06:17:05 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id 6sm40310912wra.63.2021.02.23.06.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 06:17:04 -0800 (PST)
Date:   Tue, 23 Feb 2021 09:17:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
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
Subject: Re: [RFC PATCH v5 11/19] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210223091536-mutt-send-email-mst@kernel.org>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210218053940.1068164-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218053940.1068164-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 08:39:37AM +0300, Arseny Krasnov wrote:
> This adds transport callback and it's logic for SEQPACKET dequeue.
> Callback fetches RW packets from rx queue of socket until whole record
> is copied(if user's buffer is full, user is not woken up). This is done
> to not stall sender, because if we wake up user and it leaves syscall,
> nobody will send credit update for rest of record, and sender will wait
> for next enter of read syscall at receiver's side. So if user buffer is
> full, we just send credit update and drop data. If during copy SEQ_BEGIN
> was found(and not all data was copied), copying is restarted by reset
> user's iov iterator(previous unfinished data is dropped).
> 
> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> ---
>  include/linux/virtio_vsock.h            |  10 +++
>  include/uapi/linux/virtio_vsock.h       |  16 ++++
>  net/vmw_vsock/virtio_transport_common.c | 114 ++++++++++++++++++++++++
>  3 files changed, 140 insertions(+)
> 
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index dc636b727179..003d06ae4a85 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -36,6 +36,11 @@ struct virtio_vsock_sock {
>  	u32 rx_bytes;
>  	u32 buf_alloc;
>  	struct list_head rx_queue;
> +
> +	/* For SOCK_SEQPACKET */
> +	u32 user_read_seq_len;
> +	u32 user_read_copied;
> +	u32 curr_rx_msg_cnt;


wrap these in a struct to make it's clearer they
are related?

>  };
>  
>  struct virtio_vsock_pkt {
> @@ -80,6 +85,11 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
>  			       struct msghdr *msg,
>  			       size_t len, int flags);
>  
> +int
> +virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> +				   struct msghdr *msg,
> +				   int flags,
> +				   bool *msg_ready);
>  s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
>  s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>  
> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> index 1d57ed3d84d2..cf9c165e5cca 100644
> --- a/include/uapi/linux/virtio_vsock.h
> +++ b/include/uapi/linux/virtio_vsock.h
> @@ -63,8 +63,14 @@ struct virtio_vsock_hdr {
>  	__le32	fwd_cnt;
>  } __attribute__((packed));
>  
> +struct virtio_vsock_seq_hdr {
> +	__le32  msg_cnt;
> +	__le32  msg_len;
> +} __attribute__((packed));
> +
>  enum virtio_vsock_type {
>  	VIRTIO_VSOCK_TYPE_STREAM = 1,
> +	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
>  };
>  
>  enum virtio_vsock_op {
> @@ -83,6 +89,11 @@ enum virtio_vsock_op {
>  	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
>  	/* Request the peer to send the credit info to us */
>  	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
> +
> +	/* Record begin for SOCK_SEQPACKET */
> +	VIRTIO_VSOCK_OP_SEQ_BEGIN = 8,
> +	/* Record end for SOCK_SEQPACKET */
> +	VIRTIO_VSOCK_OP_SEQ_END = 9,
>  };
>  
>  /* VIRTIO_VSOCK_OP_SHUTDOWN flags values */
> @@ -91,4 +102,9 @@ enum virtio_vsock_shutdown {
>  	VIRTIO_VSOCK_SHUTDOWN_SEND = 2,
>  };
>  
> +/* VIRTIO_VSOCK_OP_RW flags values */
> +enum virtio_vsock_rw {
> +	VIRTIO_VSOCK_RW_EOR = 1,
> +};
> +
>  #endif /* _UAPI_LINUX_VIRTIO_VSOCK_H */

Probably a good idea to also have a feature bit gating
this functionality.

-- 
MST

