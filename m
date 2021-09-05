Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C302C4010AE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 17:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhIEP4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 11:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229566AbhIEP4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 11:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630857333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FkqlDLwxY15uPA5cvtZn8WB/ij23mnSGY7u9OAsR1+Q=;
        b=Rs8BKOvSH1U4pHq+wAtCjVwyt8FTP8bSzs2F082KK6anN/z4edwqSqhlHJ2a8C8pGdYUcr
        TGF0VLbj3Os0FlaLNGhBzQh8MirTfCwKpoW6/WConwXBITMj92eMEWc+25KGKImXRm6/t+
        CBAYw8Hb5x32Z3LMe0sjH6jB8BjyYIU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-V_mMi5BcPxy3vrOyIz_qJw-1; Sun, 05 Sep 2021 11:55:32 -0400
X-MC-Unique: V_mMi5BcPxy3vrOyIz_qJw-1
Received: by mail-wm1-f69.google.com with SMTP id z18-20020a1c7e120000b02902e69f6fa2e0so1431431wmc.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 08:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FkqlDLwxY15uPA5cvtZn8WB/ij23mnSGY7u9OAsR1+Q=;
        b=qoVLz1LrB26s+vY0UtUoHGMLC0/TVcGDIDcgju1xaKaDrTYLf0DDl2umF35fX5H+hs
         o4fcIg+967PdPEChCYqi0SqkF+Sb3pXbR3pBEgDx4gkj/rARxQCu0l7asaBnPgG+Ktig
         UCnszKI6MsNj7/fxnNy2w8b+PaGENv/Hgdu+onveR5VjtQSPuAbG5GRIEvwMvZ81NdDI
         KTg76lTLK0G9ipRGij6R7XRKtMx4lF4E7NeCi4nG96oRSr7h6nQ4VOSamuGkrY/l+j+P
         y/yLnPvCIzJoxuT9Ig9GgJM8gmZ+wpnR205DKZXUcQdbwiwiBxhO50+qHbHWQpFjvk/O
         YGuQ==
X-Gm-Message-State: AOAM531fA5e4ASQ5ZscWPjnYnWKp1k2z+fOBhWpjRyRvXk3aac4Mmej7
        ZpIF42F5WzQXMUb17WePB6rYiGkGYs99cbquf3Gy9kboIeXd5opniKQkFAsJJzrMRmNmZIP44pM
        iuWU+XnDDv+TnT8RCdeqU9O5B
X-Received: by 2002:adf:e901:: with SMTP id f1mr9157530wrm.13.1630857331139;
        Sun, 05 Sep 2021 08:55:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoTItRtnLZijeuCdThieRPiWw2ARQXOEWH6eQ4SZ+adLnfig/pueE4P6suOA4XEsTs9sRHXg==
X-Received: by 2002:adf:e901:: with SMTP id f1mr9157499wrm.13.1630857330868;
        Sun, 05 Sep 2021 08:55:30 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
        by smtp.gmail.com with ESMTPSA id a10sm5294954wrd.51.2021.09.05.08.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 08:55:30 -0700 (PDT)
Date:   Sun, 5 Sep 2021 11:55:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v5 0/6] virtio/vsock: introduce MSG_EOR flag for
 SEQPACKET
Message-ID: <20210905115139-mutt-send-email-mst@kernel.org>
References: <20210903123016.3272800-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903123016.3272800-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 03:30:13PM +0300, Arseny Krasnov wrote:
> 	This patchset implements support of MSG_EOR bit for SEQPACKET
> AF_VSOCK sockets over virtio transport.
> 	First we need to define 'messages' and 'records' like this:
> Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
> etc. It has fixed maximum length, and it bounds are visible using
> return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
> Current implementation based on message definition above.
> 	Record has unlimited length, it consists of multiple message,
> and bounds of record are visible via MSG_EOR flag returned from
> 'recvmsg()' call. Sender passes MSG_EOR to sending system call and
> receiver will see MSG_EOR when corresponding message will be processed.
> 	Idea of patchset comes from POSIX: it says that SEQPACKET
> supports record boundaries which are visible for receiver using
> MSG_EOR bit. So, it looks like MSG_EOR is enough thing for SEQPACKET
> and we don't need to maintain boundaries of corresponding send -
> receive system calls. But, for 'sendXXX()' and 'recXXX()' POSIX says,
> that all these calls operates with messages, e.g. 'sendXXX()' sends
> message, while 'recXXX()' reads messages and for SEQPACKET, 'recXXX()'
> must read one entire message from socket, dropping all out of size
> bytes. Thus, both message boundaries and MSG_EOR bit must be supported
> to follow POSIX rules.
> 	To support MSG_EOR new bit was added along with existing
> 'VIRTIO_VSOCK_SEQ_EOR': 'VIRTIO_VSOCK_SEQ_EOM'(end-of-message) - now it
> works in the same way as 'VIRTIO_VSOCK_SEQ_EOR'. But 'VIRTIO_VSOCK_SEQ_EOR'
> is used to mark 'MSG_EOR' bit passed from userspace.
> 	This patchset includes simple test for MSG_EOR.


I'm prepared to merge this for this window,
but I'm not sure who's supposed to ack the net/vmw_vsock/af_vsock.c
bits. It's a harmless variable renaming so maybe it does not matter.

The rest is virtio stuff so I guess my tree is ok.

Objections, anyone?



>  Arseny Krasnov(6):
>   virtio/vsock: rename 'EOR' to 'EOM' bit.
>   virtio/vsock: add 'VIRTIO_VSOCK_SEQ_EOR' bit.
>   vhost/vsock: support MSG_EOR bit processing
>   virtio/vsock: support MSG_EOR bit processing
>   af_vsock: rename variables in receive loop
>   vsock_test: update message bounds test for MSG_EOR
> 
>  drivers/vhost/vsock.c                   | 28 +++++++++++++----------
>  include/uapi/linux/virtio_vsock.h       |  3 ++-
>  net/vmw_vsock/af_vsock.c                | 10 ++++----
>  net/vmw_vsock/virtio_transport_common.c | 23 ++++++++++++-------
>  tools/testing/vsock/vsock_test.c        |  8 ++++++-
>  5 files changed, 45 insertions(+), 27 deletions(-)
> 
>  v4 -> v5:
>  - Move bitwise and out of le32_to_cpu() in 0003.
> 
>  v3 -> v4:
>  - 'sendXXX()' renamed to 'send*()' in 0002- commit msg.
>  - Comment about bit restore updated in 0003-.
>  - 'same' renamed to 'similar' in 0003- commit msg.
>  - u32 used instead of uint32_t in 0003-.
> 
>  v2 -> v3:
>  - 'virtio/vsock: rename 'EOR' to 'EOM' bit.' - commit message updated.
>  - 'VIRTIO_VSOCK_SEQ_EOR' bit add moved to separate patch.
>  - 'vhost/vsock: support MSG_EOR bit processing' - commit message
>    updated.
>  - 'vhost/vsock: support MSG_EOR bit processing' - removed unneeded
>    'le32_to_cpu()', because input argument was already in CPU
>    endianness.
> 
>  v1 -> v2:
>  - 'VIRTIO_VSOCK_SEQ_EOR' is renamed to 'VIRTIO_VSOCK_SEQ_EOM', to
>    support backward compatibility.
>  - use bitmask of flags to restore in vhost.c, instead of separated
>    bool variable for each flag.
>  - test for EAGAIN removed, as logically it is not part of this
>    patchset(will be sent separately).
>  - cover letter updated(added part with POSIX description).
> 
> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> -- 
> 2.25.1

