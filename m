Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ED837F85A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhEMNEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233591AbhEMNE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620910999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=reFKUH6rrlF+AA2394T7GVrIVtOgj3DePRS0lsPMuB0=;
        b=iU1pLIUggdeYLMe1RxV77TwP4TKS8095Zp61qXjpBza/f0Z8Tm+JsWicylTuwZTxBpBrKC
        Rqkw/KsfHRHLh/R13T3ePwUM0gMWfOkE/KmJcdYmKPiqRmN9woLdMtj/2u5lQlKJcvltKG
        s0fWXco4hNiFJdguvQQkM6PSNkzmPv4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-mmepGcJ8PzeyoPHKRzu0Ew-1; Thu, 13 May 2021 09:03:17 -0400
X-MC-Unique: mmepGcJ8PzeyoPHKRzu0Ew-1
Received: by mail-ed1-f72.google.com with SMTP id i19-20020a05640242d3b0290388cea34ed3so14582318edc.15
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 06:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=reFKUH6rrlF+AA2394T7GVrIVtOgj3DePRS0lsPMuB0=;
        b=rkhIIAiTdJW59RLU3qiAHliyJB2Et/Dposk4zhF14ugdAc5pv7xUJzdlyIURwDyVDz
         JmrvDAEZ3I4I+uh7g5Tnv4cuy8J01HzpPG46Lqxs3fZLjtAWCuj/lwEBFwsB1nsO2En6
         HtDWMVJanctCzTryrR4UIsGesL1EvrShxId2IYk0javtOMM8auesbHCXQafN2XpBznQK
         Z9PLMu2YciJzaBjONEDZmSXaVM3DlScKCsQ07TKK1n7UFgsl84851SntxXfacj9U3Ycm
         axOdH9m9vXC5hv1FgYGFhaBRDi7rj7mp7pBrrJue3jlAbRL3fxeXouM0fU+S0qlYkm/P
         Ih4Q==
X-Gm-Message-State: AOAM531ScApNaJ/dh9fvig32UTWIaD2IgZOVaNBXvl8FpLd5REO97zLP
        XGQS239FtC+FQJz+nn0rVPON55FD+FAYCjo3Cct+veyLgoaVBxUfYRaL8699GfEZBteE33JscjL
        4UtTpWUV/3v0AHJzvunWMWB06
X-Received: by 2002:a17:906:a017:: with SMTP id p23mr44269249ejy.460.1620910996140;
        Thu, 13 May 2021 06:03:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlZU02TavvxbBUmfRJG32boBnlj1iP4tM0Qg/JAmvchXWsqL5Ii9AcVBluYmGFZU6Zj7oJcg==
X-Received: by 2002:a17:906:a017:: with SMTP id p23mr44269235ejy.460.1620910995957;
        Thu, 13 May 2021 06:03:15 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id h4sm2157154edv.97.2021.05.13.06.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 06:03:15 -0700 (PDT)
Date:   Thu, 13 May 2021 15:03:13 +0200
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
        Norbert Slusarek <nslusarek@gmx.net>,
        kvm <kvm@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        stsp <stsp2@yandex.ru>, Krasnov Arseniy <oxffffaa@gmail.com>
Subject: Re: [RFC PATCH v9 13/19] virtio/vsock: rest of SOCK_SEQPACKET support
Message-ID: <CAGxU2F5M8rMCTAoQLnEorwtnmJ14L3v9mJpywjAsUwUCtNCjDg@mail.gmail.com>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163558.3432246-1-arseny.krasnov@kaspersky.com>
 <20210513122708.mwooglzkhv7du7jo@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513122708.mwooglzkhv7du7jo@steredhat>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdf

On Thu, May 13, 2021 at 2:27 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Sat, May 08, 2021 at 07:35:54PM +0300, Arseny Krasnov wrote:
> >This adds rest of logic for SEQPACKET:
> >1) Send SHUTDOWN on socket close for SEQPACKET type.
> >2) Set SEQPACKET packet type during send.
> >3) 'seqpacket_allow' flag to virtio transport.
>
> Please update this commit message, point 3 is not included anymore in
> this patch, right?
>
> >4) Set 'VIRTIO_VSOCK_SEQ_EOR' bit in flags for last
> >   packet of message.
> >
> >Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> >---
> > v8 -> v9:
> > 1) Use cpu_to_le32() to set VIRTIO_VSOCK_SEQ_EOR.
> >
> > include/linux/virtio_vsock.h            |  4 ++++
> > net/vmw_vsock/virtio_transport_common.c | 17 +++++++++++++++--
> > 2 files changed, 19 insertions(+), 2 deletions(-)
> >
> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> >index 02acf6e9ae04..7360ab7ea0af 100644
> >--- a/include/linux/virtio_vsock.h
> >+++ b/include/linux/virtio_vsock.h
> >@@ -80,6 +80,10 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> >                              struct msghdr *msg,
> >                              size_t len, int flags);
> >
> >+int
> >+virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
> >+                                 struct msghdr *msg,
> >+                                 size_t len);
> > ssize_t
> > virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> >                                  struct msghdr *msg,
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index 7fea0a2192f7..b6608b4ac7c2 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -74,6 +74,10 @@ virtio_transport_alloc_pkt(struct virtio_vsock_pkt_info *info,
> >               err = memcpy_from_msg(pkt->buf, info->msg, len);
> >               if (err)
> >                       goto out;
> >+
> >+              if (info->msg->msg_iter.count == 0)
>
> Also here is better `msg_data_left(info->msg)`
>
> >+                      pkt->hdr.flags = cpu_to_le32(info->flags |
> >+                                              VIRTIO_VSOCK_SEQ_EOR);
>
> Re-thinking an alternative could be to set EOR here...
>
>                         info->flags |= VIRTIO_VSOCK_SEQ_EOR;

Or just `pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR)`, as you 
did in vhost-vsock :-)

