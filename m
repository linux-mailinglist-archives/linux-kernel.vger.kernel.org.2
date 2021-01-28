Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9FF307B11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhA1QgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:36:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232401AbhA1Qev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611851592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FdUYV04vZro17uutaKWrqsCYU3iMGEHyKXk4ksXfiJ4=;
        b=FIaCzwrsnVzaojcicZzYv1iNJTZHGaxmM8h6FbflgZJa81NIrlJ8U5ZGs7WxeYMWJd64Hw
        JIM8E+9J+hCXpdv3nLsgmE54wbkzPo/OKE6UO9pEv1mW+zxppSUT/88bTI1z+Y8bZWNNwo
        mEIhdYa0pLzUR0hrZ8/cSc0ymjAQo2s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-RQU7zECdMHuzgaQDoiAKDw-1; Thu, 28 Jan 2021 11:33:04 -0500
X-MC-Unique: RQU7zECdMHuzgaQDoiAKDw-1
Received: by mail-wr1-f70.google.com with SMTP id r5so3374274wrx.18
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 08:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FdUYV04vZro17uutaKWrqsCYU3iMGEHyKXk4ksXfiJ4=;
        b=rz+3QWyoYaNNTD3b5PEMrqbkEsN3M00aCk5NvnGjw+byag7DFxOAcP6+/RxYw4h5wV
         E4zAmI4fEjs6ZFVDqme/NTYegHzhyx0JwRRIpPo97xkSaAJPENxGEqTeDy+UPCSZmmjT
         x1eg82/GFYrKKW+n4ZW992kP9jRJ5J0IGDRBysx496ZlZzFBJNbJnb+lSk2vVJSoaRr6
         TLMSG0QirWdsMtSRK2CbUXx+oiRJG+m/qoIW3PD/pgpbjYi9lFLxfUPCXqYPtt+CUERc
         +mmVJIQmlO+AHbNKD6vk7vzGjyO+q0pxGs2ao2x8+rT4b6nHsjkJ7YQS88UPkd0FRqy7
         Ql+A==
X-Gm-Message-State: AOAM533I/m4Q52y+kLrA787kyplOfuSHOih/EUkz2HiLRmhHEDRT18hU
        jyJPwxOSyolmkDjeSiOEhA3luYanrmQFknxJJ8qsuDg2dfDH3YpJliMF0NSv6IQKhzRroLLn1AO
        +ft7pesbqF05ydt7ifllTRuJ7
X-Received: by 2002:adf:f849:: with SMTP id d9mr17491592wrq.349.1611851582942;
        Thu, 28 Jan 2021 08:33:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxF+ScPOLAhB6bXIWSvwvFKyZ7WpX/FQO/3pX5dZXvg16LtuNb18msqzMvprBKdi2kv2PiLwg==
X-Received: by 2002:adf:f849:: with SMTP id d9mr17491573wrq.349.1611851582752;
        Thu, 28 Jan 2021 08:33:02 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id w25sm6657568wmc.42.2021.01.28.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 08:33:02 -0800 (PST)
Date:   Thu, 28 Jan 2021 17:32:59 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Colin Ian King <colin.king@canonical.com>,
        Jeff Vander Stoep <jeffv@google.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v3 02/13] af_vsock: prepare
 'vsock_connectible_recvmsg()'
Message-ID: <20210128163259.3lhcy43tm4t6ejys@steredhat>
References: <20210125110903.597155-1-arseny.krasnov@kaspersky.com>
 <20210125111200.598103-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210125111200.598103-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 02:11:57PM +0300, Arseny Krasnov wrote:
>This prepares 'vsock_connectible_recvmg()' to call SEQPACKET receive
>loop:
>1) Some shared check left in this function, then socket type
>   specific receive loop is called.
>2) Stream receive loop is moved to separate function.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 242 ++++++++++++++++++++++-----------------
> 1 file changed, 138 insertions(+), 104 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index c9ce57db9554..524df8fc84cd 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1858,65 +1858,69 @@ static int vsock_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> 	return vsock_connectible_sendmsg(sock, msg, len);
> }
>
>-
>-static int
>-vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>-			  int flags)
>+static int vsock_wait_data(struct sock *sk, struct wait_queue_entry *wait,
>+			   long timeout,
>+			   struct vsock_transport_recv_notify_data *recv_data,
>+			   size_t target)
> {
>-	struct sock *sk;
>+	int err = 0;
> 	struct vsock_sock *vsk;
> 	const struct vsock_transport *transport;
>-	int err;
>-	size_t target;
>-	ssize_t copied;
>-	long timeout;
>-	struct vsock_transport_recv_notify_data recv_data;
>-
>-	DEFINE_WAIT(wait);
>
>-	sk = sock->sk;
> 	vsk = vsock_sk(sk);
> 	transport = vsk->transport;
>-	err = 0;
>-
>-	lock_sock(sk);
>-
>-	if (!transport || sk->sk_state != TCP_ESTABLISHED) {
>-		/* Recvmsg is supposed to return 0 if a peer performs an
>-		 * orderly shutdown. Differentiate between that case and when a
>-		 * peer has not connected or a local shutdown occured with the
>-		 * SOCK_DONE flag.
>-		 */
>-		if (sock_flag(sk, SOCK_DONE))
>-			err = 0;
>-		else
>-			err = -ENOTCONN;
>
>+	if (sk->sk_err != 0 ||
>+	    (sk->sk_shutdown & RCV_SHUTDOWN) ||
>+	    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
>+		err = -1;
> 		goto out;
> 	}
>-
>-	if (flags & MSG_OOB) {
>-		err = -EOPNOTSUPP;
>+	/* Don't wait for non-blocking sockets. */
>+	if (timeout == 0) {
>+		err = -EAGAIN;
> 		goto out;
> 	}
>
>-	/* We don't check peer_shutdown flag here since peer may actually shut
>-	 * down, but there can be data in the queue that a local socket can
>-	 * receive.
>-	 */
>-	if (sk->sk_shutdown & RCV_SHUTDOWN) {
>-		err = 0;
>-		goto out;
>+	if (recv_data) {
>+		err = transport->notify_recv_pre_block(vsk, target, recv_data);
>+		if (err < 0)
>+			goto out;
> 	}
>
>-	/* It is valid on Linux to pass in a zero-length receive buffer.  This
>-	 * is not an error.  We may as well bail out now.
>-	 */
>-	if (!len) {
>-		err = 0;
>+	release_sock(sk);
>+	timeout = schedule_timeout(timeout);
>+	lock_sock(sk);
>+
>+	if (signal_pending(current)) {
>+		err = sock_intr_errno(timeout);
>+		goto out;
>+	} else if (timeout == 0) {
>+		err = -EAGAIN;
> 		goto out;
> 	}
>
>+out:
>+	finish_wait(sk_sleep(sk), wait);
>+	return err;
>+}
>+
>+static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
>+				  size_t len, int flags)
>+{
>+	struct vsock_transport_recv_notify_data recv_data;
>+	const struct vsock_transport *transport;
>+	struct vsock_sock *vsk;
>+	ssize_t copied;
>+	size_t target;
>+	long timeout;
>+	int err;
>+
>+	DEFINE_WAIT(wait);
>+
>+	vsk = vsock_sk(sk);
>+	transport = vsk->transport;
>+
> 	/* We must not copy less than target bytes into the user's buffer
> 	 * before returning successfully, so we wait for the consume queue to
> 	 * have that much data to consume before dequeueing.  Note that this
>@@ -1937,85 +1941,53 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>
>
> 	while (1) {
>+		ssize_t read;
> 		s64 ready;
>
> 		prepare_to_wait(sk_sleep(sk), &wait, 
> 		TASK_INTERRUPTIBLE);
> 		ready = vsock_stream_has_data(vsk);

Maybe we can move also these lines in vsock_wait_data() that can return 
'ready' or an error.

>
> 		if (ready == 0) {
>-			if (sk->sk_err != 0 ||
>-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
>-			    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
>-				finish_wait(sk_sleep(sk), &wait);
>-				break;
>-			}
>-			/* Don't wait for non-blocking sockets. */
>-			if (timeout == 0) {
>-				err = -EAGAIN;
>-				finish_wait(sk_sleep(sk), &wait);
>-				break;
>-			}
>-
>-			err = transport->notify_recv_pre_block(
>-					vsk, target, &recv_data);
>-			if (err < 0) {
>-				finish_wait(sk_sleep(sk), &wait);
>-				break;
>-			}
>-			release_sock(sk);
>-			timeout = schedule_timeout(timeout);
>-			lock_sock(sk);
>-
>-			if (signal_pending(current)) {
>-				err = sock_intr_errno(timeout);
>-				finish_wait(sk_sleep(sk), &wait);
>-				break;
>-			} else if (timeout == 0) {
>-				err = -EAGAIN;
>-				finish_wait(sk_sleep(sk), &wait);
>+			if (vsock_wait_data(sk, &wait, timeout, &recv_data, target))
> 				break;
>-			}
>-		} else {
>-			ssize_t read;
>+			continue;
>+		}
>
>-			finish_wait(sk_sleep(sk), &wait);
>+		finish_wait(sk_sleep(sk), &wait);

And also this one can be moved in vsock_wait_data().
>
>-			if (ready < 0) {
>-				/* Invalid queue pair content. XXX This should
>-				* be changed to a connection reset in a later
>-				* change.
>-				*/
>+		if (ready < 0) {
>+			/* Invalid queue pair content. XXX This should
>+			 * be changed to a connection reset in a later
>+			 * change.
>+			 */
>
>-				err = -ENOMEM;
>-				goto out;
>-			}
>+			err = -ENOMEM;
>+			goto out;
>+		}
>
>-			err = transport->notify_recv_pre_dequeue(
>-					vsk, target, &recv_data);
>-			if (err < 0)
>-				break;
>+		err = transport->notify_recv_pre_dequeue(vsk,
>+					target, &recv_data);
>+		if (err < 0)
>+			break;
>+		read = transport->stream_dequeue(vsk, msg, len - copied, flags);
>
>-			read = transport->stream_dequeue(
>-					vsk, msg,
>-					len - copied, flags);
>-			if (read < 0) {
>-				err = -ENOMEM;
>-				break;
>-			}
>+		if (read < 0) {
>+			err = -ENOMEM;
>+			break;
>+		}
>
>-			copied += read;
>+		copied += read;
>
>-			err = transport->notify_recv_post_dequeue(
>-					vsk, target, read,
>+		err = transport->notify_recv_post_dequeue(vsk,
>+					target, read,
> 					!(flags & MSG_PEEK), &recv_data);
>-			if (err < 0)
>-				goto out;
>+		if (err < 0)
>+			goto out;
>
>-			if (read >= target || flags & MSG_PEEK)
>-				break;
>+		if (read >= target || flags & MSG_PEEK)
>+			break;
>
>-			target -= read;
>-		}
>+		target -= read;
> 	}
>
> 	if (sk->sk_err)
>@@ -2031,6 +2003,68 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	return err;
> }
>
>+static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>+				     size_t len, int flags)
>+{
>+	return -1;
>+}
>+

You can add this function later, when you implement it...

>+static int
>+vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>+			  int flags)
>+{
>+	const struct vsock_transport *transport;
>+	struct vsock_sock *vsk;
>+	struct sock *sk;
>+	int err = 0;
>+
>+	sk = sock->sk;
>+
>+	lock_sock(sk);
>+
>+	vsk = vsock_sk(sk);
>+	transport = vsk->transport;
>+
>+	if (!transport || sk->sk_state != TCP_ESTABLISHED) {
>+		/* Recvmsg is supposed to return 0 if a peer performs an
>+		 * orderly shutdown. Differentiate between that case and when a
>+		 * peer has not connected or a local shutdown occurred 
>with the
>+		 * SOCK_DONE flag.
>+		 */
>+		if (!sock_flag(sk, SOCK_DONE))
>+			err = -ENOTCONN;
>+
>+		goto out;
>+	}
>+
>+	if (flags & MSG_OOB) {
>+		err = -EOPNOTSUPP;
>+		goto out;
>+	}
>+
>+	/* We don't check peer_shutdown flag here since peer may actually shut
>+	 * down, but there can be data in the queue that a local socket can
>+	 * receive.
>+	 */
>+	if (sk->sk_shutdown & RCV_SHUTDOWN)
>+		goto out;
>+
>+	/* It is valid on Linux to pass in a zero-length receive buffer.  This
>+	 * is not an error.  We may as well bail out now.
>+	 */
>+	if (!len)
>+		goto out;
>+
>+	if (sk->sk_type == SOCK_STREAM)
>+		err = __vsock_stream_recvmsg(sk, msg, len, flags);
>+	else
>+		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);

...and also this 'else' branch.

>+
>+out:
>+	release_sock(sk);
>+	return err;
>+}
>+
> static int
> vsock_stream_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 		     int flags)
>-- 
>2.25.1
>

