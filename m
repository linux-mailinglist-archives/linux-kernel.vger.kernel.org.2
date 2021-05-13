Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8863437F956
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhEMODi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234308AbhEMODH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620914516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dzzbRMtR/ux/HKuN2b3P0GhQTxIlq9su8CHUI1jg3KU=;
        b=SiQOYK/MO0LdSgxD7UJuu8x2ECv0tT5oWCkX+0PVldL3e8qzVmUMnLoKTE33t7t2xzzhmj
        LEqGqkp23MGDcelovfZrMV//aYb6vUGvjbRung5hktboDzesJeKMDsWhYONwNouBVLy4yL
        AAK4i8lPncT0UWEMVYgKkCFE+QX1cBQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-xrRhmDXoP5CmEkpeRiq53Q-1; Thu, 13 May 2021 10:01:54 -0400
X-MC-Unique: xrRhmDXoP5CmEkpeRiq53Q-1
Received: by mail-ed1-f70.google.com with SMTP id h16-20020a0564020950b029038cbdae8cbaso3213805edz.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dzzbRMtR/ux/HKuN2b3P0GhQTxIlq9su8CHUI1jg3KU=;
        b=JS4ICKaKQy2p9V6DP4rf/AnyDtjOwABwymZJeGcrwcVjzQ6jyncxOM1XQtzLBWj4Rr
         Ufi5+TIW4p0mUCihk2uuwtnvsFZ8u2lXNwx5E5RtJKh8+J/NLS2pvHpZpVfhXRRdTzey
         Q7eTtBxfWozXdvBOatvDQQkLRgVUHmmhXXVR9egzhd8SjwRNLNyKdpamyz8VBzcVFE0f
         l2Ui8bJiqgQZyszXm5iiVxMLUa4B1nYqC+WPUppLQp3NnRaPzF9nchGlHdbMjkJb+df5
         /4fxTPhXOjaf3euSm2XaePKp6CzwHmEWjvV1xx7Cq9KEcyM2RxcPiKYVeKX8Vg7uGPch
         jQ5Q==
X-Gm-Message-State: AOAM5337DfEnrR9D7Of+WmjAHyFDPOKYXhrI3nla2ZNeA65IL6XDsiWV
        9ih6naEh88U2W6AC684pg2Zpnxe9Nrc25xXhEAe8FlSq+64/DTZbE94UVdJKYxYi8qwBcHDcM7k
        sRPU8m2Q8mke8sT7IUQgPo80D
X-Received: by 2002:a17:906:dc8:: with SMTP id p8mr43396597eji.75.1620914513353;
        Thu, 13 May 2021 07:01:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw39IWhXvW7OgV46gQBGVCcCQQk3NNZ/aEpvFouiESvkXXJwhBo18CCtS6V20sKwwrVlEsIFQ==
X-Received: by 2002:a17:906:dc8:: with SMTP id p8mr43396565eji.75.1620914513141;
        Thu, 13 May 2021 07:01:53 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id x7sm1820591ejc.116.2021.05.13.07.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 07:01:52 -0700 (PDT)
Date:   Thu, 13 May 2021 16:01:50 +0200
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
Subject: Re: [RFC PATCH v9 19/19] af_vsock: serialize writes to shared socket
Message-ID: <20210513140150.ugw6foy742fxan4w@steredhat>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163738.3432975-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210508163738.3432975-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 07:37:35PM +0300, Arseny Krasnov wrote:
>This add logic, that serializes write access to single socket
>by multiple threads. It is implemented be adding field with TID
>of current writer. When writer tries to send something, it checks
>that field is -1(free), else it sleep in the same way as waiting
>for free space at peers' side.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   |  1 +
> net/vmw_vsock/af_vsock.c | 10 +++++++++-
> 2 files changed, 10 insertions(+), 1 deletion(-)

I think you forgot to move this patch at the beginning of the series.
It's important because in this way we can backport to stable branches 
easily.

About the implementation, can't we just add a mutex that we hold until 
we have sent all the payload?

I need to check other implementations like TCP.

>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 1747c0b564ef..413343f18e99 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -69,6 +69,7 @@ struct vsock_sock {
> 	u64 buffer_size;
> 	u64 buffer_min_size;
> 	u64 buffer_max_size;
>+	pid_t tid_owner;
>
> 	/* Private to transport. */
> 	void *trans;
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 7790728465f4..1fb4a1860f6d 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -757,6 +757,7 @@ static struct sock *__vsock_create(struct net *net,
> 	vsk->peer_shutdown = 0;
> 	INIT_DELAYED_WORK(&vsk->connect_work, vsock_connect_timeout);
> 	INIT_DELAYED_WORK(&vsk->pending_work, vsock_pending_work);
>+	vsk->tid_owner = -1;
>
> 	psk = parent ? vsock_sk(parent) : NULL;
> 	if (parent) {
>@@ -1765,7 +1766,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 		ssize_t written;
>
> 		add_wait_queue(sk_sleep(sk), &wait);
>-		while (vsock_stream_has_space(vsk) == 0 &&
>+		while ((vsock_stream_has_space(vsk) == 0 ||
>+			(vsk->tid_owner != current->pid &&
>+			 vsk->tid_owner != -1)) &&
> 		       sk->sk_err == 0 &&
> 		       !(sk->sk_shutdown & SEND_SHUTDOWN) &&
> 		       !(vsk->peer_shutdown & RCV_SHUTDOWN)) {
>@@ -1796,6 +1799,8 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 				goto out_err;
> 			}
> 		}
>+
>+		vsk->tid_owner = current->pid;
> 		remove_wait_queue(sk_sleep(sk), &wait);
>
> 		/* These checks occur both as part of and after the loop
>@@ -1852,7 +1857,10 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 			err = total_written;
> 	}
> out:
>+	vsk->tid_owner = -1;
> 	release_sock(sk);
>+	sk->sk_write_space(sk);
>+

Is this change related? Can you explain in the commit message why it is 
needed?

> 	return err;
> }
>
>-- 
>2.25.1
>

