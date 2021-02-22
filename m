Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7D1321A56
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhBVO1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:27:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231584AbhBVOTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 09:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614003496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dczqn3yvtGdaJ4ItxeNsO6mMvqpqPNPelEeJ/DM0z8=;
        b=D9Znyra/izg0Sf6vTn0ntrFK/QjbOjknZ/jkWrXBqnohcuFlRHO7c0Z8QJZUYzPVB1YQMs
        jvUBIjr1BV5f784uJ9r+JY7wi5gTi0uq3NrLDKtBqr8C17mInUAabBwq6y1B5Fxogeiy27
        ZbMBp91dVOhbrnKAo/AxXk3eWF8jBFo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-N3C7LOQ8Oba-7dxLZ7LjYg-1; Mon, 22 Feb 2021 09:18:14 -0500
X-MC-Unique: N3C7LOQ8Oba-7dxLZ7LjYg-1
Received: by mail-wr1-f71.google.com with SMTP id h12so120550wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 06:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4dczqn3yvtGdaJ4ItxeNsO6mMvqpqPNPelEeJ/DM0z8=;
        b=mas70qXs/J0u2fj85mQEGUugzmCxeFNNx/HEaSkC1w49LbrQwSa9TlNAd9kbieTb58
         qJ5DluZmhp3ZoA5PYDs8R1k3qpUDHYu9QosYVvT5rC6C9KcLGuNRg7G5xd+ma270fpaA
         GZYqjnh+Ly3WrLhGooJdtBBF4lrWzVupLUfnVX8FLnraHyvAZUAhzrYt8H/XKjlgGGzN
         N3UhsK94AMuukx3h26JYdCYxZEskyX1cCvuXxp7YHlxPRVIRAptzjmeoo5Vq94601Tt9
         gJicL/GAMhJ3vH+lHRK+iG49SQumK/7j99JZM7XWqXDQqxI5O8YaoT+Q0POv5SSja9G3
         UpOw==
X-Gm-Message-State: AOAM532eZKYtBf+DNfuLIqyZUFzla6bpKe1cfOuYmog7rdpfRy6h+WUU
        yp+vwm6QRWZ0+Rp/gpyZo9iCRwkhSFv2uLrhXUNot51zvPDT1eYbgQDwjakTz3vQnKXFD6xlWsm
        rA0ioIy0914kijYcFmm4TW1TO
X-Received: by 2002:adf:9031:: with SMTP id h46mr22072613wrh.19.1614003493370;
        Mon, 22 Feb 2021 06:18:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3ZEW5m0LD2K3iKZRRGxx+XdzwaUrxqdU5eFOuJolpSBSUTb9lIA0xW6yKMdbESnoC8aNNjw==
X-Received: by 2002:adf:9031:: with SMTP id h46mr22072591wrh.19.1614003493149;
        Mon, 22 Feb 2021 06:18:13 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id q25sm20813231wmq.15.2021.02.22.06.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 06:18:12 -0800 (PST)
Date:   Mon, 22 Feb 2021 15:18:09 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Colin Ian King <colin.king@canonical.com>,
        Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v5 08/19] af_vsock: update comments for stream sockets
Message-ID: <20210222141809.6wcvglet4cpmcjlg@steredhat>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210218053852.1067811-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210218053852.1067811-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 08:38:48AM +0300, Arseny Krasnov wrote:
>This replaces 'stream' to 'connect oriented' in comments as SEQPACKET is
                             ^ connection

You forgot to update the commit message :-)

With that fixed:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>also connect oriented.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 31 +++++++++++++++++--------------
> 1 file changed, 17 insertions(+), 14 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f4b02c6d35d1..f1bf6a5ad15e 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -415,8 +415,8 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
>
> /* Assign a transport to a socket and call the .init transport callback.
>  *
>- * Note: for stream socket this must be called when vsk->remote_addr is set
>- * (e.g. during the connect() or when a connection request on a listener
>+ * Note: for connection oriented socket this must be called when vsk->remote_addr
>+ * is set (e.g. during the connect() or when a connection request on a listener
>  * socket is received).
>  * The vsk->remote_addr is used to decide which transport to use:
>  *  - remote CID == VMADDR_CID_LOCAL or g2h->local_cid or VMADDR_CID_HOST if
>@@ -470,10 +470,10 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 			return 0;
>
> 		/* transport->release() must be called with sock lock acquired.
>-		 * This path can only be taken during vsock_stream_connect(),
>-		 * where we have already held the sock lock.
>-		 * In the other cases, this function is called on a new socket
>-		 * which is not assigned to any transport.
>+		 * This path can only be taken during vsock_connect(), where we
>+		 * have already held the sock lock. In the other cases, this
>+		 * function is called on a new socket which is not assigned to
>+		 * any transport.
> 		 */
> 		vsk->transport->release(vsk);
> 		vsock_deassign_transport(vsk);
>@@ -658,9 +658,10 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>
> 	vsock_addr_init(&vsk->local_addr, new_addr.svm_cid, new_addr.svm_port);
>
>-	/* Remove stream sockets from the unbound list and add them to the hash
>-	 * table for easy lookup by its address.  The unbound list is simply an
>-	 * extra entry at the end of the hash table, a trick used by AF_UNIX.
>+	/* Remove connection oriented sockets from the unbound list and add them
>+	 * to the hash table for easy lookup by its address.  The unbound list
>+	 * is simply an extra entry at the end of the hash table, a trick used
>+	 * by AF_UNIX.
> 	 */
> 	__vsock_remove_bound(vsk);
> 	__vsock_insert_bound(vsock_bound_sockets(&vsk->local_addr), vsk);
>@@ -951,10 +952,10 @@ static int vsock_shutdown(struct socket *sock, int mode)
> 	if ((mode & ~SHUTDOWN_MASK) || !mode)
> 		return -EINVAL;
>
>-	/* If this is a STREAM socket and it is not connected then bail out
>-	 * immediately.  If it is a DGRAM socket then we must first kick the
>-	 * socket so that it wakes up from any sleeping calls, for example
>-	 * recv(), and then afterwards return the error.
>+	/* If this is a connection oriented socket and it is not connected then
>+	 * bail out immediately.  If it is a DGRAM socket then we must first
>+	 * kick the socket so that it wakes up from any sleeping calls, for
>+	 * example recv(), and then afterwards return the error.
> 	 */
>
> 	sk = sock->sk;
>@@ -1783,7 +1784,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>
> 	transport = vsk->transport;
>
>-	/* Callers should not provide a destination with stream sockets. */
>+	/* Callers should not provide a destination with connection oriented
>+	 * sockets.
>+	 */
> 	if (msg->msg_namelen) {
> 		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
> 		goto out;
>-- 
>2.25.1
>

