Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A13F366711
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhDUIiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230250AbhDUIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618994265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sDT07Cw674WH/mojd5E+GUtnkF6CqYLs/uZ0jQ1hic0=;
        b=M4iRg3MhE+gUAuN6UqgrELKDYARkrX42QwKuUZEev53NjzC2N+9JAh5Z1AWymhaSyqHdcK
        k+Gfcp+qlCtG6c1y/mxouThRC3MjgckkH0SQn5EWqjXlP38T0Dt21TsbADa6N8b7fyiMmt
        zQQSr3bC0+Fw5rspSCb0X8ckHTnCDGM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-VcbqB43kOq-kk_RtOvWXQA-1; Wed, 21 Apr 2021 04:37:36 -0400
X-MC-Unique: VcbqB43kOq-kk_RtOvWXQA-1
Received: by mail-ed1-f69.google.com with SMTP id p16-20020a0564021550b029038522733b66so6556449edx.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sDT07Cw674WH/mojd5E+GUtnkF6CqYLs/uZ0jQ1hic0=;
        b=IqQe6IgP88n1fK7LeucZhYzep51TOBXRsnTBILjKjHiGCvanM+7M0kSsqmgbY0G9AH
         1rJ6Rgu5a+cGmY29EwwT+QYF3DaIvPpQPfoiUdBotzq0ybb+Ay4GOGCCBITi3i8IrE7w
         +nDh5tbvwoIOGRJLg2fE/cLpZolkBT/NwONUeZ9SBsnORWD0dTnG7tSfVSXa9PNuLeBn
         q5atqPKWYGRi1ikTsMjQiEqq2B/GRbhUqB83XPGbMSRIhfaN79oy2FKSwVoZMg/1X0bq
         Q5uVMhKNNIhzqrxJMW7z85TmLfSziTBhsXTjyLxU2IkU0xQfMdGpT354y2geVsuCpL7a
         iPNg==
X-Gm-Message-State: AOAM5325b/jGtBNpGEh4OSCLBJ90SgF8qHZX5HlFauLKEpNVC0BmsD0M
        8i0kN5X29WuStlcctbew+Gk2fUQjEgEkAiXYmKfrZ9Nwey+oBIby46UK6w0fWhG87qLYYe5sG97
        pBnG8l3wAk1BEPEgs20tuVBC2
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr31882940ejc.283.1618994255626;
        Wed, 21 Apr 2021 01:37:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSP6XGvPrxAywAWr8b/JgEcImy2Q+kz2faESZbGiR2d6lEZWR9hpP8hNuyIR/PuDv+hiDtpg==
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr31882918ejc.283.1618994255344;
        Wed, 21 Apr 2021 01:37:35 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id m14sm2254201edr.45.2021.04.21.01.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 01:37:34 -0700 (PDT)
Date:   Wed, 21 Apr 2021 10:37:32 +0200
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
Subject: Re: [RFC PATCH v8 04/19] af_vsock: implement SEQPACKET receive loop
Message-ID: <20210421083732.hxlilatddifcokjx@steredhat>
References: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
 <20210413124250.3400313-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210413124250.3400313-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 03:42:47PM +0300, Arseny Krasnov wrote:
>This adds receive loop for SEQPACKET. It looks like receive loop for
>STREAM, but there is a little bit difference:
>1) It doesn't call notify callbacks.
>2) It doesn't care about 'SO_SNDLOWAT' and 'SO_RCVLOWAT' values, because
>   there is no sense for these values in SEQPACKET case.
>3) It waits until whole record is received or error is found during
>   receiving.
>4) It processes and sets 'MSG_TRUNC' flag.
>
>So to avoid extra conditions for two types of socket inside one loop, two
>independent functions were created.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
>v7 -> v8:
> - Length of message is now not returned by callback, it returns only
>   length of data read by each call.
> - Previous case, when EAGAIN is return and dequeue loop restarted now
>   removed(in this simplified version we consider that message could not
>   be corrupted).
> - MSG_TRUNC in input flags is now handled by callback.
>
> include/net/af_vsock.h   |  4 +++
> net/vmw_vsock/af_vsock.c | 66 +++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 69 insertions(+), 1 deletion(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index b1c717286993..5175f5a52ce1 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -135,6 +135,10 @@ struct vsock_transport {
> 	bool (*stream_is_active)(struct vsock_sock *);
> 	bool (*stream_allow)(u32 cid, u32 port);
>
>+	/* SEQ_PACKET. */
>+	ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
>+				     int flags, bool *msg_ready);
>+
> 	/* Notification. */
> 	int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);
> 	int (*notify_poll_out)(struct vsock_sock *, size_t, bool *);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index c4f6bfa1e381..d9fb4f9a3063 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1974,6 +1974,67 @@ static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
> 	return err;
> }
>
>+static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>+				     size_t len, int flags)
>+{
>+	const struct vsock_transport *transport;
>+	bool msg_ready;
>+	struct vsock_sock *vsk;
>+	ssize_t record_len;
>+	long timeout;
>+	int err = 0;
>+	DEFINE_WAIT(wait);
>+
>+	vsk = vsock_sk(sk);
>+	transport = vsk->transport;
>+
>+	timeout = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>+	msg_ready = false;
>+	record_len = 0;
>+
>+	while (1) {
>+		ssize_t tmp_record_len;

Maybe better a name like `partial_len`, `fragment_len`, or just `read`.

>+
>+		if (vsock_wait_data(sk, &wait, timeout, NULL, 0) <= 0) {
>+			/* In case of any loop break(timeout, signal
>+			 * interrupt or shutdown), we report user that
>+			 * nothing was copied.
>+			 */
>+			err = 0;
>+			break;
>+		}
>+
>+		tmp_record_len = transport->seqpacket_dequeue(vsk, msg, flags, &msg_ready);

I think we can avoid to pass 'flags' down to the transports.

We can require that seqpacket_dequeue() should always return the real 
size of the packet received, and then check below if 'MSG_TRUNC' was 
set...

>+
>+		if (tmp_record_len < 0) {
>+			err = -ENOMEM;
>+			break;
>+		}
>+
>+		record_len += tmp_record_len;
>+
>+		if (msg_ready)
>+			break;
>+	}
>+
>+	if (sk->sk_err)
>+		err = -sk->sk_err;
>+	else if (sk->sk_shutdown & RCV_SHUTDOWN)
>+		err = 0;
>+
>+	if (msg_ready && err == 0) {
>+		err = record_len;
>+
>+		/* Always set MSG_TRUNC if real length of packet is
>+		 * bigger than user's buffer.
>+		 */

...here:
		if (flags & MSG_TRUNC && record_len > len)

>+		if (record_len > len)
>+			msg->msg_flags |= MSG_TRUNC;
>+	}
>+
>+	return err;
>+}
>+
> static int
> vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 			  int flags)
>@@ -2029,7 +2090,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 		goto out;
> 	}
>
>-	err = __vsock_stream_recvmsg(sk, msg, len, flags);
>+	if (sk->sk_type == SOCK_STREAM)
>+		err = __vsock_stream_recvmsg(sk, msg, len, flags);
>+	else
>+		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
>
> out:
> 	release_sock(sk);
>-- )
>2.25.1
>

