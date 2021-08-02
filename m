Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B633DDF57
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhHBSfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232124AbhHBSfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627929301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wminINGDgWcNHoLPUasL8rgS7uCgoeCj4rIW6d1gFd0=;
        b=YvBg4D6Ok09eOJC7TpSEwFAEQ2FIpkAD3RnFGXJllgtpEvvvY32RT1vEPaP+v9hID1svZ8
        IadKbOyRJWI8L53OId502PzHZFsdKqe9b3ZT219OP8kpZrOG124J/W9kmYAeKeXtHkZ1v6
        kb346tGfSInQ8X5ngvqAx7EFrrPb2rg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-sa-sHLhyNgeUZagA4kstnw-1; Mon, 02 Aug 2021 14:35:00 -0400
X-MC-Unique: sa-sHLhyNgeUZagA4kstnw-1
Received: by mail-ej1-f70.google.com with SMTP id rv22-20020a17090710d6b029058c69e3adbbso4989409ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 11:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wminINGDgWcNHoLPUasL8rgS7uCgoeCj4rIW6d1gFd0=;
        b=GJ6WoOKJwNV/SMAoOzXyugFHkAfqEAuL8yJULgPuBU5KfDL0uGo/MRR8+yWXkFLH8g
         TUm4ODCw8of0SEHq6q5wgWPTgbt2dOsbv+QY7XXNRHfxKXOqplnYIHqjvYD0Yta2lNh4
         2Ft/+j0EskkbrLa7fYc8VLfSEhpRK4tYd9H7KSprk0cFreiwOcxBEULF6MUOmA11BYRW
         Fgani+xjQLKS4mj24600f3KHEPYpEe4Dr1EIcITT9Nle/L50srmTvBhfarqLUUBqTP8V
         mUAGqFkXgbLRDQrtQQgYs41cqYyYPmUdsuUe5EcBQbQqjs/o7xgdrtYpSOCYVO3nK4Ds
         MDzQ==
X-Gm-Message-State: AOAM531L438dqnftmGmN66y3yEqk2/7yEGrwO61AQdk8n7aiK7ZapMDX
        LkZaMobw9qEiXmM8lk6SCWtNkSUSb0Oa5uFQdswGCi0CRk9TsIlYGIeWmHJON/OTD1nLfNb/ycl
        aw+pznzEBVi68T+Julyh/LsJ3
X-Received: by 2002:a50:fb18:: with SMTP id d24mr20985347edq.225.1627929299327;
        Mon, 02 Aug 2021 11:34:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoCyMdXrDgg3jX2cUmgPnbyHqQZI1zsIxFF27gl9okbIV2OgI+ba2TaS/45evhjSuB8kSK5g==
X-Received: by 2002:a50:fb18:: with SMTP id d24mr20985334edq.225.1627929299147;
        Mon, 02 Aug 2021 11:34:59 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id n13sm6705376eda.36.2021.08.02.11.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 11:34:58 -0700 (PDT)
Date:   Mon, 2 Aug 2021 20:34:56 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Harshavardhan Unnibhavi <harshanavkis@gmail.com>
Cc:     stefanha@redhat.com, davem@davemloft.net, kuba@kernel.org,
        asias@redhat.com, mst@redhat.com, imbrenda@linux.vnet.ibm.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] VSOCK: handle VIRTIO_VSOCK_OP_CREDIT_REQUEST
Message-ID: <20210802183456.zvr6raqtgwrm3s52@steredhat>
References: <20210802173506.2383-1-harshanavkis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210802173506.2383-1-harshanavkis@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 07:35:06PM +0200, Harshavardhan Unnibhavi wrote:
>The original implementation of the virtio-vsock driver does not
>handle a VIRTIO_VSOCK_OP_CREDIT_REQUEST as required by the
>virtio-vsock specification. The vsock device emulated by
>vhost-vsock and the virtio-vsock driver never uses this request,
>which was probably why nobody noticed it. However, another
>implementation of the device may use this request type.
>
>Hence, this commit introduces a way to handle an explicit credit
>request by responding with a corresponding credit update as
>required by the virtio-vsock specification.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>
>Signed-off-by: Harshavardhan Unnibhavi <harshanavkis@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c 
>b/net/vmw_vsock/virtio_transport_common.c
>index 169ba8b72a63..081e7ae93cb1 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1079,6 +1079,9 @@ virtio_transport_recv_connected(struct sock *sk,
> 		virtio_transport_recv_enqueue(vsk, pkt);
> 		sk->sk_data_ready(sk);
> 		return err;
>+	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
>+		virtio_transport_send_credit_update(vsk);
>+		break;
> 	case VIRTIO_VSOCK_OP_CREDIT_UPDATE:
> 		sk->sk_write_space(sk);
> 		break;
>-- 2.17.1
>

The patch LGTM, thanks for fixing this long-time issue!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

