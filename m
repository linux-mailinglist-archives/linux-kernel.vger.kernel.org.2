Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0006F43B0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 13:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhJZLUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 07:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235470AbhJZLUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 07:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635247062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6TpfncIbRN2wIiXvPAEkb8bm0utZs2Zbi5cSQ14Wg50=;
        b=c4qL+8cDE+a+2ZFwRH8D0uluY1IsZ5AqA0aofw0AUb5Kp/rxIHRvgQmAzhQAb8FVICv3pd
        iM5ScFgAMBZZMUVIbcYvQdycDc+VEMONqgxwH8ZNOlaiIT+mnntHeG+Z4uqLAReAtGO1m3
        K65hzH4AJyJqUX0brXi1T5Nj8deHRAs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-nTAy5oKiPQGjVHKMyw2x4g-1; Tue, 26 Oct 2021 07:17:41 -0400
X-MC-Unique: nTAy5oKiPQGjVHKMyw2x4g-1
Received: by mail-ed1-f69.google.com with SMTP id m16-20020a056402431000b003dd2005af01so622894edc.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 04:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6TpfncIbRN2wIiXvPAEkb8bm0utZs2Zbi5cSQ14Wg50=;
        b=AnDqy40jCdRadvXny9UR2JFJkkllQq3u9u53MkazBfhSSrwf/UegPiepV6zA0LdHlP
         vI1BbPZwN9bCwNplomApLjwIz4y3yfhSNzOfUonwMeypWVNJNjIwN3V3RGv5rYCzBvdv
         vZIRSxR5JG164ci6PiPuFvho1EqNf74kf6v8/ZBT/UEFT5rT2ASTpXBhSUTWlRyLT0/7
         h1yJccyxgw/0gcqqforpy+ND920+tz3J/4lJJ2a/D0Y8ZFKaP1lVpa/+wBdzAWs0ryLS
         b9Cn8PH/NbPfO0QFnx/ZjDzKiurS42LeLQZ522ZloCqohd/M9schsSKZlgX3YS+YK3kP
         ggRA==
X-Gm-Message-State: AOAM533a/tiIz4Cx0t4V+L4fRxdxiavqoVtIkDqdKaHa/BT+Da0tO6A5
        R4xWsq6bL//t89RHq6NmteHmwHoOBaiSEDTmlRK5giTL9QI7DsmwCezv27I7GY9pzKjDclCw5uT
        is6ryY/S2S5TTlOL4uoEJyv1X
X-Received: by 2002:a17:906:a08d:: with SMTP id q13mr29939026ejy.465.1635247060106;
        Tue, 26 Oct 2021 04:17:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgsgVHMqjVtNfTJQc71/3yQjNJBw7QbsfzzaH84DrM2rc/AHDvL+5r/1luGk4wkGrC9g125w==
X-Received: by 2002:a17:906:a08d:: with SMTP id q13mr29939009ejy.465.1635247059966;
        Tue, 26 Oct 2021 04:17:39 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it. [79.30.88.77])
        by smtp.gmail.com with ESMTPSA id p23sm11379803edw.94.2021.10.26.04.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:17:39 -0700 (PDT)
Date:   Tue, 26 Oct 2021 13:17:37 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org
Subject: Re: [PATCH 05/10] virtio/vsock: add copy_peercred() to
 virtio_transport
Message-ID: <20211026111737.eyzvbthmc7h3em5z@steredhat>
References: <20211021123714.1125384-1-marcandre.lureau@redhat.com>
 <20211021123714.1125384-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211021123714.1125384-6-marcandre.lureau@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 04:37:09PM +0400, Marc-André Lureau wrote:
>Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
> include/linux/virtio_vsock.h            | 2 ++
> net/vmw_vsock/virtio_transport_common.c | 9 +++++++++
> 2 files changed, 11 insertions(+)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 35d7eedb5e8e..2445bece9216 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -69,6 +69,8 @@ struct virtio_transport {
>
> 	/* Takes ownership of the packet */
> 	int (*send_pkt)(struct virtio_vsock_pkt *pkt);
>+	/* Set peercreds on socket created after listen recv */
>+	void (*copy_peercred)(struct sock *sk, struct virtio_vsock_pkt *pkt);
> };
>
> ssize_t
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 59ee1be5a6dd..611d25e80723 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1194,6 +1194,15 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
> 		return -ENOMEM;
> 	}
>
>+	if (t->copy_peercred) {
>+		t->copy_peercred(child, pkt);
>+	} else {
>+		put_pid(child->sk_peer_pid);
>+		child->sk_peer_pid = NULL;
>+		put_cred(child->sk_peer_cred);
>+		child->sk_peer_cred = NULL;
>+	}
>+

Should we do the same also on the other side?
I mean in virtio_transport_recv_connecting() when 
VIRTIO_VSOCK_OP_RESPONSE is received.

I think we can add an helper and call it every time we call 
vsock_insert_connected().

Even better if we can do it in the core, but maybe this can be a next 
step.

Thanks,
Stefano

