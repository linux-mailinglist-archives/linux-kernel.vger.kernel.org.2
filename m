Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3534039BB69
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFDPIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbhFDPIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622819207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R4lH0ENSCRPWcR6tjmSMqiJJcwn1xqWLtNNasWP/7BY=;
        b=gaUWEbFSO88tLQpjZwTHnnNYVZK9gjwQHl7mcDcP5qoeNY4w1MHZQB7s54s4aXR7aRjtzL
        QQ+cuH+xAzsz0/YBhTfXybHXwcI+djjg3y0svcwyoE5QWMvouWdfTBFU9RKVfMsWpM9sEV
        2UtHiBlb5jD3kcioqZKc8hvVi6wqmyg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-X-g90SNIM-OqGZWp6qgv4Q-1; Fri, 04 Jun 2021 11:06:45 -0400
X-MC-Unique: X-g90SNIM-OqGZWp6qgv4Q-1
Received: by mail-ed1-f70.google.com with SMTP id h18-20020a05640250d2b029038cc3938914so5131589edb.17
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4lH0ENSCRPWcR6tjmSMqiJJcwn1xqWLtNNasWP/7BY=;
        b=B/l4cfSYbdPbEokrNdGxw4C6lb1KzfOV8jYAHSAX8t4Jr0/BtKz5PlAsaYmbiReYiX
         i4yKvnHsC9r0SyHJBD7f5j6KWJMumHUvbdKTInbX0gO7A3Ay3zboQU22FwizQcs+ztdU
         x4XRYnSzD5T76UBBM7n8xk8jk4/G341ChNNB9w/SUgHgwZHlhvPcZajMeBfXG+QBveJg
         FLNJXXk8rrWYrQVmhn4Av4q47HQviVre2p10MDP8Sd+tn8FREFH+UMeCHuzjnsS+O+bk
         ZYYJguRFrxIGCbYwC+lgh/I8SdEzEOWol0oNqTIjA5v6P2Zl1t7EDkla72OXc6gMvrtI
         ajeg==
X-Gm-Message-State: AOAM533YcDCVkAcuLWa8gEkYLU24Kenm3iPHHV4AZb8wkCJmeVHZljoO
        7CDTbQW6iFNWmcc4VpkkO1jMPsQz3sEFfpgOsgqItHUyqtFjwY8RhqFxOIjCHx+VAjeg5pJe1UJ
        rWKDKCvGK7ei9Cn3vOu7nEY7Y
X-Received: by 2002:a17:906:b307:: with SMTP id n7mr4531786ejz.261.1622819203844;
        Fri, 04 Jun 2021 08:06:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFKUEl+a6SCxy6FtoRWYARC6BFE/SxvneKPM+vbJAKJH5rGGVaDehSBEGg8bb1AIBMBTVsMA==
X-Received: by 2002:a17:906:b307:: with SMTP id n7mr4531750ejz.261.1622819203625;
        Fri, 04 Jun 2021 08:06:43 -0700 (PDT)
Received: from steredhat ([5.170.129.161])
        by smtp.gmail.com with ESMTPSA id w11sm3677629ede.54.2021.06.04.08.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:06:43 -0700 (PDT)
Date:   Fri, 4 Jun 2021 17:06:38 +0200
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
        Norbert Slusarek <nslusarek@gmx.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, oxffffaa@gmail.com
Subject: Re: [PATCH v10 04/18] af_vsock: implement SEQPACKET receive loop
Message-ID: <20210604150638.rmx262k4wjmp2zob@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210520191611.1271204-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210520191611.1271204-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 10:16:08PM +0300, Arseny Krasnov wrote:
>Add receive loop for SEQPACKET. It looks like receive loop for
>STREAM, but there are differences:
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
> v9 -> v10:
> 1) Use 'msg_data_left()' instead of direct access to 'msg_hdr'.
>
> include/net/af_vsock.h   |  4 +++
> net/vmw_vsock/af_vsock.c | 72 +++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 75 insertions(+), 1 deletion(-)
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
>index c4f6bfa1e381..aede474343d1 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1974,6 +1974,73 @@ static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
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
>+		ssize_t fragment_len;
>+
>+		if (vsock_wait_data(sk, &wait, timeout, NULL, 0) <= 0) {
>+			/* In case of any loop break(timeout, signal
>+			 * interrupt or shutdown), we report user that
>+			 * nothing was copied.
>+			 */
>+			err = 0;

Why we report that nothing was copied?

What happen to the bytes already copied in `msg`?


>+			break;
>+		}
>+
>+		fragment_len = transport->seqpacket_dequeue(vsk, msg, flags, &msg_ready);
>+
>+		if (fragment_len < 0) {
>+			err = -ENOMEM;
>+			break;
>+		}
>+
>+		record_len += fragment_len;
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
>+		/* User sets MSG_TRUNC, so return real length of
>+		 * packet.
>+		 */
>+		if (flags & MSG_TRUNC)
>+			err = record_len;
>+		else
>+			err = len - msg_data_left(msg);
>+
>+		/* Always set MSG_TRUNC if real length of packet is
>+		 * bigger than user's buffer.
>+		 */
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
>@@ -2029,7 +2096,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
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
>-- 
>2.25.1
>

