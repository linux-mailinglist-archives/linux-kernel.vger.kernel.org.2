Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F65E3B81C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhF3MOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234413AbhF3MN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625055090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HjLKivpmTxani+XPF3iGAiHLl5i/SxVPZjv2mKGxTR4=;
        b=EbluSdyFvc3I9Jb278vJRzcmj9H63nr1Uy1MKJ0/PmNffMiPhz2VcdyapobQYg9gl9MwPT
        qPvXxeXaNS6L4s4HvvwNGFWo8VYYpwBRphxVhsiV1N4RVOubkob13pcm3V+bEEfVeLp5hd
        r7s57EfPwA8HztDEfPId6IONjNfmccg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-STW2rd-UPveMs9Joske3MQ-1; Wed, 30 Jun 2021 08:11:28 -0400
X-MC-Unique: STW2rd-UPveMs9Joske3MQ-1
Received: by mail-ej1-f69.google.com with SMTP id k1-20020a17090666c1b029041c273a883dso695701ejp.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HjLKivpmTxani+XPF3iGAiHLl5i/SxVPZjv2mKGxTR4=;
        b=mS18O7FKbNQbBDYU/M3UqVVVX2XkYRbhfF18nuo5n+24/ETeVkoS1za30kq0uNCADa
         1l/0/nnamtR3ef2K5t0zWaMysmsyohUDTKIxj0S4Cchpu4HhBjbXJOEPXZ46c7+i15cl
         Ikm0jj+csprkWx+9veWXxILnbH3bvQNmir8RsWNDUA1QLZfGJ1hsqv7dGSL+mjqhfFgL
         Y7qdb8aFYT7+uLm1dERh/d9K0GDTIphlCxwp0xQvc8XKT9YkktQeazB4WodpEtmIeWK5
         4u1jc8ivrM9li4bU+wXNVZL6gLKj4nPn/rdE043Fr0FDoQmtxn+k/OxQBQ4dYnQmxtz0
         jSng==
X-Gm-Message-State: AOAM530wJJEljvME2aUZsK31b4YcFf8iUCprSpoFOPfJCgefvZbuixdO
        u2Mbry7Yg0RYYERnRyVibF1pOZmOBeP78KwUvbqty5e5yI4WQb0XfcMGyXiGkFTO2sa730pvvkK
        n9gXSvIGTKBinOdJ0N+pZ9U+W
X-Received: by 2002:a17:906:4899:: with SMTP id v25mr35863388ejq.451.1625055087451;
        Wed, 30 Jun 2021 05:11:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxS+TPipViKVTyOBRlKGUsXt+XwfFGYR4iIVDCFdEFv1bf670kbuHjhW5TA+alh5BwQNtL7Mw==
X-Received: by 2002:a17:906:4899:: with SMTP id v25mr35863362ejq.451.1625055087282;
        Wed, 30 Jun 2021 05:11:27 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id r12sm12637350edd.52.2021.06.30.05.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 05:11:26 -0700 (PDT)
Date:   Wed, 30 Jun 2021 14:11:24 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>,
        Colin Ian King <colin.king@canonical.com>,
        kvm <kvm@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Krasnov Arseniy <oxffffaa@gmail.com>
Subject: Re: [RFC PATCH v1 07/16] virtio/vsock: don't count EORs on receive
Message-ID: <CAGxU2F7SsxvCht2HbDb7dKsM_auHoxvHirgWwNMObjxOci=5nA@mail.gmail.com>
References: <20210628095959.569772-1-arseny.krasnov@kaspersky.com>
 <20210628100318.570947-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628100318.570947-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 01:03:15PM +0300, Arseny Krasnov wrote:
>There is no sense to count EORs, because 'rx_bytes' is
>used to check data presence on socket.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 3 ---
> 1 file changed, 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 84431d7a87a5..319c3345f3e0 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1005,9 +1005,6 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>               goto out;
>       }
>
>-      if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR)
>-              vvs->msg_count++;
>-

Same here, please remove it when you don't need it, and also remove from
the struct virtio_vsock_sock.

Thanks,
Stefano

>       /* Try to copy small packets into the buffer of last packet queued,
>        * to avoid wasting memory queueing the entire buffer with a small
>        * payload.
>--
>2.25.1
>

