Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E573AE6AE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhFUKEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhFUKEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624269748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PZIO5NpgIVUNv0kj+r82DXgHE7L65dog7HHDBqbMgHI=;
        b=gGQtjQiqmP7SeoT9S9Dj4EGKiTFohwj6gvv0i+RsTHR2Yz5SUa1pm+pKiHEoA3AihAbTdn
        wRqXOQJSeINZVfQLCMfXeaTkkODgJb6PC15yTexz/gm+F7eK3c9Uh7uq+qy2I+EkGIJDL3
        PwGvuTy3xpgrlLaox/sgyHdQu/aMJqY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-x3R5yaiGM6CxpZcNgvb3OQ-1; Mon, 21 Jun 2021 06:02:27 -0400
X-MC-Unique: x3R5yaiGM6CxpZcNgvb3OQ-1
Received: by mail-ej1-f69.google.com with SMTP id q14-20020a1709066aceb029049fa6bee56fso569628ejs.21
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PZIO5NpgIVUNv0kj+r82DXgHE7L65dog7HHDBqbMgHI=;
        b=RZPF8Py4eeS9Abwrg30pd9Bs/eCmJpO8OMVNhAl1u/3DM96nGXOIDzSItMA7T2bABq
         LUMaQMVeQqY9gzYxwz5rkBovCG4ycHQUEbodE9YB8AvbbwGe5DYgtmZy2zjjbQ0yeIvi
         KudawW7B2HnbQGeNJ2jqTG2hf3tNNBh3Y6mkg0o5gPtWSdvN2pXXOUbAl6KDZ0I1CBy5
         YfKyucTJ5GMJdGx8UU0AKGXeBXY022pqvvsRjwjuy0GFzVYc4EiFIk8RmwmewFwSFmK3
         kEjic4qiO7Qw8Sihwp/L9GNys/AZS5YDWxY7Xqc3+7dC0CWzjdre3v88MGbbBI6GFSWu
         D2sg==
X-Gm-Message-State: AOAM532ova+oUFQ8WcN1sqfZfVWCUK2ed7Q8ypkqFQm0wnwMitktjuG0
        nxRqd7EA/TueH0OFwpcY8D5xVQW2870fq0kNp+v7Jzthd6uRfxnsvy7HxuD7R4XFl6pnIezKRxc
        0jZPd1glEL32zAEk4Fojuh7UU
X-Received: by 2002:a17:907:2165:: with SMTP id rl5mr23532502ejb.98.1624269745870;
        Mon, 21 Jun 2021 03:02:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI/DlaZvtpyAu2Ncemo1+R+rxYzgmP6CvYztVMEJT254YGs7mVm/LkwCtPDgJX2tnwmfaVSQ==
X-Received: by 2002:a17:907:2165:: with SMTP id rl5mr23532477ejb.98.1624269745555;
        Mon, 21 Jun 2021 03:02:25 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id o14sm5130578edw.36.2021.06.21.03.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 03:02:25 -0700 (PDT)
Date:   Mon, 21 Jun 2021 12:02:22 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arei.gonglei@huawei.com, "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>,
        Colin Ian King <colin.king@canonical.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        lixianming <lixianming5@huawei.com>
Subject: Re: [PATCH v2] vsock: notify server to shutdown when client has
 pending signal
Message-ID: <20210621100222.jg7rajkjyzuao5h5@steredhat>
References: <20210621062601.1473-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210621062601.1473-1-longpeng2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 02:26:01PM +0800, Longpeng(Mike) wrote:
>The client's sk_state will be set to TCP_ESTABLISHED if the server
>replay the client's connect request.
>
>However, if the client has pending signal, its sk_state will be set
>to TCP_CLOSE without notify the server, so the server will hold the
>corrupt connection.
>
>            client                        server
>
>1. sk_state=TCP_SYN_SENT         |
>2. call ->connect()              |
>3. wait reply                    |
>                                 | 4. sk_state=TCP_ESTABLISHED
>                                 | 5. insert to connected list
>                                 | 6. reply to the client
>7. sk_state=TCP_ESTABLISHED      |
>8. insert to connected list      |
>9. *signal pending* <--------------------- the user kill client
>10. sk_state=TCP_CLOSE           |
>client is exiting...             |
>11. call ->release()             |
>     virtio_transport_close
>      if (!(sk->sk_state == TCP_ESTABLISHED ||
>	      sk->sk_state == TCP_CLOSING))
>		return true; *return at here, the server cannot notice the connection is corrupt*
>
>So the client should notify the peer in this case.
>
>Cc: David S. Miller <davem@davemloft.net>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Jorgen Hansen <jhansen@vmware.com>
>Cc: Norbert Slusarek <nslusarek@gmx.net>
>Cc: Andra Paraschiv <andraprs@amazon.com>
>Cc: Colin Ian King <colin.king@canonical.com>
>Cc: David Brazdil <dbrazdil@google.com>
>Cc: Alexander Popov <alex.popov@linux.com>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Link: https://lkml.org/lkml/2021/5/17/418
>Signed-off-by: lixianming <lixianming5@huawei.com>
>Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>---
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 92a72f0..ae11311 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1369,7 +1369,7 @@ static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
>
> 		if (signal_pending(current)) {
> 			err = sock_intr_errno(timeout);
>-			sk->sk_state = TCP_CLOSE;
>+			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
> 			sock->state = SS_UNCONNECTED;
> 			vsock_transport_cancel_pkt(vsk);
> 			goto out_wait;
>-- 
>1.8.3.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

