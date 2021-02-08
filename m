Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E53313FF3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhBHUIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:08:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235614AbhBHSd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612809151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FONHI2TN+O9acLzuem6EKO8Yxg/GTLtQhMLyetszZzg=;
        b=i4dzJjOmxnszr2CzjT8VaUpfgrc39wb5VM0YMrzfm6jx0hS4KZ9Xr4UF1DwA9bY0eVaenZ
        qpbjm+Mgx1PUeUm8+/Bbrz/O43qEvgAOCh0w7KY21Gqm2IWh2qA5qJrUJNK/8Duf/p4nEA
        2H0b0zcA8wN0g5xOW5IiKUVgMBmSFHY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-pv3ODgGGOP6EsuW8NpJjHw-1; Mon, 08 Feb 2021 13:32:29 -0500
X-MC-Unique: pv3ODgGGOP6EsuW8NpJjHw-1
Received: by mail-ed1-f72.google.com with SMTP id g2so14686771edq.14
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FONHI2TN+O9acLzuem6EKO8Yxg/GTLtQhMLyetszZzg=;
        b=jW5hNHZucXe0fXd92sd42TS4V2c31EOHCQbS5gjCoeVZHs36Ru0iw60/8o0QILe0jg
         OGePXuB/gcZRh09WcQeGRX6fxceiaHqNaNAfQERM/9N+iYZv+T4gszpmN2462wnHbJXN
         qw6OO5e+QwId6mdBAkhR6ghONdiI1dN3bopYZCNKTaZE7deND3jTbJpJg7R5PbGBjc7E
         mE7QYVDrjHJ56wkXCtANtHQJywISKOpBqQwT1oxBDVgxx1XmOs8RIZQDqf9JZTJ+XKgv
         UbpvdeLZrcaTHPWG5JJfO+efO6Pn29kIG1EFSLunldIq7T0ykEwaN7+XeFRc8dmg9LLN
         apPA==
X-Gm-Message-State: AOAM53045P2o92lHydO6PMIGOayOSkIzphlRkO3qOwz/T+5L9fz2RVVX
        QZLpUw+eClxoS0+qPrZF1IIQH7NmpoqP/D9qzkADe5VEzWp8xQgNwwlZqQMEyrwXfqHqwRQcUn3
        UTS47Sa430xvsFlxDyChe67l6
X-Received: by 2002:aa7:c755:: with SMTP id c21mr18592169eds.47.1612809148226;
        Mon, 08 Feb 2021 10:32:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpsuTp5sRzeOMNIjmosofGMT5Va6UgHF+7NHtSfOHTT8nBvBhqO12WkK46eKwRMOgobAa2CA==
X-Received: by 2002:aa7:c755:: with SMTP id c21mr18592153eds.47.1612809148080;
        Mon, 08 Feb 2021 10:32:28 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id x5sm10415492edi.35.2021.02.08.10.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 10:32:27 -0800 (PST)
Date:   Mon, 8 Feb 2021 13:32:24 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     kuba@kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Asias He <asias@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: update credit only if socket is not
 closed
Message-ID: <20210208133211-mutt-send-email-mst@kernel.org>
References: <20210208144454.84438-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208144454.84438-1-sgarzare@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 03:44:54PM +0100, Stefano Garzarella wrote:
> If the socket is closed or is being released, some resources used by
> virtio_transport_space_update() such as 'vsk->trans' may be released.
> 
> To avoid a use after free bug we should only update the available credit
> when we are sure the socket is still open and we have the lock held.
> 
> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Probably stable material.

> ---
>  net/vmw_vsock/virtio_transport_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 5956939eebb7..e4370b1b7494 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1130,8 +1130,6 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  
>  	vsk = vsock_sk(sk);
>  
> -	space_available = virtio_transport_space_update(sk, pkt);
> -
>  	lock_sock(sk);
>  
>  	/* Check if sk has been closed before lock_sock */
> @@ -1142,6 +1140,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  		goto free_pkt;
>  	}
>  
> +	space_available = virtio_transport_space_update(sk, pkt);
> +
>  	/* Update CID in case it has changed after a transport reset event */
>  	vsk->local_addr.svm_cid = dst.svm_cid;
>  
> -- 
> 2.29.2

