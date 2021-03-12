Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832F23390DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhCLPLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:11:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231601AbhCLPKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615561833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=At+gLYpOVuwtYiPKDJPSOAsFyXGyFQ/Ei1/8xDCko3E=;
        b=En2MHtPiD96hkZOTsX2qKCg85mhFLqzC+/13T9cXG705fR2AkWjEagBdGde9wt9sCACTPM
        ioZWn5sB/aNju4xRjc9stXALmqiTiQiAR8FdO4pomo/Eaqta8Pldsv6rKiVi0PdEFiL+qR
        6/jjMawkdz5OoME2VFIFVByx+vzbZkQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-dFMljhupPbWtjKCBKVMhqA-1; Fri, 12 Mar 2021 10:10:32 -0500
X-MC-Unique: dFMljhupPbWtjKCBKVMhqA-1
Received: by mail-wr1-f72.google.com with SMTP id h5so11248666wrr.17
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=At+gLYpOVuwtYiPKDJPSOAsFyXGyFQ/Ei1/8xDCko3E=;
        b=fFNlf510/h8oWU3xU8nZWdEBoTgI9BYL0AcOgfRzsNBFWBXs1E5RXsL1WiY42iTWza
         WVB5AuXHniVfWnDTW1UzbUfvfEYfOo3q0jg/LXSkrMCuVw7D9zUfP/cSDfZyulwVh+I8
         AdyVArqUv4MdZ/PzMw4AxyR+84iByFg9CV8xsh0w/n8w5VBPwotbDFMzffhIvaaeukRW
         kqvSgjtg32JXa38ukMbpLt32V3oLeVlT4CofsjjcnrMoZRTSF8VqSvAnfdLeaBzHpyjn
         kWlDFRHTE0yRDCR/u0jWbniSyobpvoeNuTulM5Y9rGmfYMwN2UE5vudDlRzYFjMscQwa
         Xmuw==
X-Gm-Message-State: AOAM5302iy+tF6R0TtPHAOSAZPJKQDvdRc9X4ulvC6HtMtCfdIjTQOcR
        6XN1Ue5MNUyE4XAd/kl3087wDty+0XLErafQMzh3Xe9t9NErkiYRBk7fDpVRYAqfvtGt5ibqT0e
        OXRTt8cuW8t1/7S/Gbc6X21q8
X-Received: by 2002:adf:90c2:: with SMTP id i60mr14448418wri.75.1615561830791;
        Fri, 12 Mar 2021 07:10:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBUQ6H37FhlxEuc6bIG9e30/3DvMV1YlOPohF80Djr/3IK1mCCHCFlpAvMtmDgq0mHUGX6jQ==
X-Received: by 2002:adf:90c2:: with SMTP id i60mr14448382wri.75.1615561830569;
        Fri, 12 Mar 2021 07:10:30 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id t8sm8072008wrr.10.2021.03.12.07.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:10:30 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:10:27 +0100
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
        Norbert Slusarek <nslusarek@gmx.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v6 06/22] af_vsock: implement send logic for SEQPACKET
Message-ID: <20210312151027.kamodty37ftspkmc@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307180030.3465161-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210307180030.3465161-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 09:00:26PM +0300, Arseny Krasnov wrote:
>This adds some logic to current stream enqueue function for SEQPACKET
>support:
>1) Use transport's seqpacket enqueue callback.
>2) Return value from enqueue function is whole record length or error
>   for SOCK_SEQPACKET.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   |  2 ++
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++------
> 2 files changed, 18 insertions(+), 6 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index a8c4039e40cf..aed306292ab3 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -139,6 +139,8 @@ struct vsock_transport {
> 	size_t (*seqpacket_seq_get_len)(struct vsock_sock *vsk);
> 	int (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
> 				 int flags, bool *msg_ready);
>+	int (*seqpacket_enqueue)(struct vsock_sock *vsk, struct msghdr *msg,
>+				 int flags, size_t len);
>
> 	/* Notification. */
> 	int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 5bf64a3e678a..a031f165494d 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1830,9 +1830,14 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 		 * responsibility to check how many bytes we were able to send.
> 		 */
>
>-		written = transport->stream_enqueue(
>-				vsk, msg,
>-				len - total_written);
>+		if (sk->sk_type == SOCK_SEQPACKET) {
>+			written = transport->seqpacket_enqueue(vsk,
>+						msg, msg->msg_flags,

I think we can avoid to pass 'msg->msg_flags', since the transport can 
access it through the 'msg' pointer, right?

>+						len - total_written);
>+		} else {
>+			written = transport->stream_enqueue(vsk,
>+					msg, len - total_written);
>+		}
> 		if (written < 0) {
> 			err = -ENOMEM;
> 			goto out_err;
>@@ -1844,12 +1849,17 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 				vsk, written, &send_data);
> 		if (err < 0)
> 			goto out_err;
>-
> 	}
>
> out_err:
>-	if (total_written > 0)
>-		err = total_written;
>+	if (total_written > 0) {
>+		/* Return number of written bytes only if:
>+		 * 1) SOCK_STREAM socket.
>+		 * 2) SOCK_SEQPACKET socket when whole buffer is sent.
>+		 */
>+		if (sk->sk_type == SOCK_STREAM || total_written == len)
>+			err = total_written;
>+	}
> out:
> 	release_sock(sk);
> 	return err;
>-- 
>2.25.1
>

