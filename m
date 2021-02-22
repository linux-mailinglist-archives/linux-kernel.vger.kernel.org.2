Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A01C321582
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBVLzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:55:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230010AbhBVLzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613994821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uwBWTvI52wqLrpQP0Tt3FcCpkL+x02v8vMn3ChAyK8U=;
        b=Xm2xHlduC8T13SPIOt6JoKlpsz8FgUNEU6y2fcmib0/GFaWq8bSxmdsy0YDUf4VaIW20xk
        cbjpC8dQG4TtEhqDwb9v7pAWnZS/ydfINuEXDzGzT7vqWJxGEQ550tAEBXb89Bd5bwhnlP
        fjrDd1YLtuQLR71i1FwHHe1jNni7LGw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-URXpIemqOreVOayVONWIOg-1; Mon, 22 Feb 2021 06:53:37 -0500
X-MC-Unique: URXpIemqOreVOayVONWIOg-1
Received: by mail-wm1-f70.google.com with SMTP id z67so4954687wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 03:53:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uwBWTvI52wqLrpQP0Tt3FcCpkL+x02v8vMn3ChAyK8U=;
        b=Wr3lcXIySv5LJslEnVzBKDINC94QcJIDIWzZRCuVNdKIxZQXA6TzDd5xeCp2VM2Ek7
         bpy0Am23BLISpGvHB9T69hH77sWIeDPS+QPPXHhmiiq1lLgUCPXiYW0UQRGmXP9SuGlO
         BIrIrWESOGvbtFQ66+HAdXNBShl+Vo7623qxRIhIA2RT2wOWNWGepyJWp7HCVTJJhfq/
         JvbOzHtYIjq6NYzFLSTI0ATPk2jcA6wFT5e6Gkj0OIB9XrBUueg1mvvn0uvXz4fybNLe
         xN43dKZ0/vbk424uW362r5o+IBKyRRIi9RBnNzjSUisX+Clm7HuFiVUEjRe6qAkD/HH6
         CooA==
X-Gm-Message-State: AOAM533CPGLiu7hwCx0mQsEsdtst8x++g5HasRWBsp1XU8xTo1l/OK0T
        7UkspBF9dIuZLhvg+BrqELRluOlhjzDxHjmW/w9pZPeTDjm0QNAzK8RKc6tuCSqoyf4yvO7aEWe
        6D93T+Es8/d/XsipHPIEbQ4dN
X-Received: by 2002:adf:a2c7:: with SMTP id t7mr21259236wra.42.1613994816239;
        Mon, 22 Feb 2021 03:53:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwF3z2re71U2qX2sBvyIA4CC2xz2iu5FyqhwdzeqbDwD5LQo1ZoMCLS2hsoaBHr951kbzi9wg==
X-Received: by 2002:adf:a2c7:: with SMTP id t7mr21259216wra.42.1613994816075;
        Mon, 22 Feb 2021 03:53:36 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id v15sm28906877wra.61.2021.02.22.03.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 03:53:35 -0800 (PST)
Date:   Mon, 22 Feb 2021 12:53:32 +0100
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
Subject: Re: [RFC PATCH v5 04/19] af_vsock: implement SEQPACKET receive loop
Message-ID: <20210222115332.bmfwqzbytimk65ta@steredhat>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210218053719.1067237-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210218053719.1067237-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 08:37:15AM +0300, Arseny Krasnov wrote:
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
> include/net/af_vsock.h   |  5 +++
> net/vmw_vsock/af_vsock.c | 97 +++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 101 insertions(+), 1 deletion(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index b1c717286993..01563338cc03 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -135,6 +135,11 @@ struct vsock_transport {
> 	bool (*stream_is_active)(struct vsock_sock *);
> 	bool (*stream_allow)(u32 cid, u32 port);
>
>+	/* SEQ_PACKET. */
>+	size_t (*seqpacket_seq_get_len)(struct vsock_sock *vsk);
>+	int (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
>+				     int flags, bool *msg_ready);

I think this should be:
	int (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
				 int flags, bool *msg_ready);

To avoid:
$ ./scripts/checkpatch.pl --strict -g HEAD
CHECK: Alignment should match open parenthesis
#35: FILE: include/net/af_vsock.h:141:
+	int (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
+				     int flags, bool *msg_ready);

>+
> 	/* Notification. */
> 	int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);
> 	int (*notify_poll_out)(struct vsock_sock *, size_t, bool *);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d277dc1cdbdf..b754927a556a 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1972,6 +1972,98 @@ static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
> 	return err;
> }
>
>+static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>+				     size_t len, int flags)
>+{
>+	const struct vsock_transport *transport;
>+	const struct iovec *orig_iov;
>+	unsigned long orig_nr_segs;
>+	bool msg_ready;
>+	struct vsock_sock *vsk;
>+	size_t record_len;
>+	long timeout;
>+	int err = 0;
>+	DEFINE_WAIT(wait);
>+
>+	vsk = vsock_sk(sk);
>+	transport = vsk->transport;
>+
>+	timeout = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>+	orig_nr_segs = msg->msg_iter.nr_segs;
>+	orig_iov = msg->msg_iter.iov;
>+	msg_ready = false;
>+	record_len = 0;
>+
>+	while (1) {
>+		err = vsock_wait_data(sk, &wait, timeout, NULL, 0);
>+
>+		if (err <= 0) {
>+			/* In case of any loop break(timeout, signal
>+			 * interrupt or shutdown), we report user that
>+			 * nothing was copied.
>+			 */
>+			err = 0;
>+			break;
>+		}
>+
>+		if (record_len == 0) {
>+			record_len =
>+				transport->seqpacket_seq_get_len(vsk);
>+
>+			if (record_len == 0)
>+				continue;
>+		}
>+
>+		err = transport->seqpacket_dequeue(vsk, msg,
>+					flags, &msg_ready);
>+

Sorry, I expressed myself wrong.

Here it's fine to avoid the blank line as in the previous version, by 
single line I meant the seqpacket_dequeue() call, something like this:

		err = transport->seqpacket_dequeue(vsk, msg, flags, &msg_ready);
		if (err < 0) {


>+		if (err < 0) {
>+			if (err == -EAGAIN) {
>+				iov_iter_init(&msg->msg_iter, READ,
>+					      orig_iov, orig_nr_segs,
>+					      len);
>+				/* Clear 'MSG_EOR' here, because dequeue
>+				 * callback above set it again if it was
>+				 * set by sender. This 'MSG_EOR' is from
>+				 * dropped record.
>+				 */
>+				msg->msg_flags &= ~MSG_EOR;
>+				record_len = 0;
>+				continue;
>+			}
>+
>+			err = -ENOMEM;
>+			break;
>+		}
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
>+	if (msg_ready) {
>+		/* User sets MSG_TRUNC, so return real length of
>+		 * packet.
>+		 */
>+		if (flags & MSG_TRUNC)
>+			err = record_len;
>+		else
>+			err = len - msg->msg_iter.count;
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
>@@ -2027,7 +2119,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
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

