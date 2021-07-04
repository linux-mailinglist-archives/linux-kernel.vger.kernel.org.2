Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5ADB3BAC22
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 10:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhGDIde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 04:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhGDIdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 04:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625387457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mjv6RdL7FMrY4HG6p07wZrW4/GnliOhXTbPvIgXM+o=;
        b=H8THpi2wAXgD4xRxaIMpHH1/wIRiAf8o95SRKboOploAm87ookkwqHgBorKmJUj7dWPEic
        BVT1eleqQzftnHXhWo/b6XrKRyI94HSvXzNVECXCmcg5KQwIgoMXfvAKHxjK3afO7cx9YD
        gnACHFXL+ojo9LakNIpOSf0wxoWq0lc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-hfpmZdbPPnmRKOnMg3HYzg-1; Sun, 04 Jul 2021 04:30:56 -0400
X-MC-Unique: hfpmZdbPPnmRKOnMg3HYzg-1
Received: by mail-wm1-f71.google.com with SMTP id k16-20020a7bc3100000b02901d849b41038so8210964wmj.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 01:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5mjv6RdL7FMrY4HG6p07wZrW4/GnliOhXTbPvIgXM+o=;
        b=iUHM+5dE+DvVg1CH4Q5IHQ8q5CYowqf0B06Ho/b6IR761xeXPIz1pGltuiULCMNzCn
         HXsAbuaJx6VB74fGFb73iXIfWem5tgTgsUdTJP2ABIOgWL/3zm3USmWPt5rArXSwDJm4
         Hv1bCKA+9U7tg/7VJReY/L7nGc0PoRaE5xBc/AsSL/qs3Wdcc8Y4Nbagkjk8NKIlWDRg
         5ddiJhginvh8nMbBhX484oJqyybt0IE1/NhwVewcsNbXxviXt7FQcFwL2C5PRTCMJsxw
         eJrkoPoglZ+ImxqDYQ0zehRvwgNFLVUgIokt0fxPc9sySci5Bpdk0U4S4dKCevDa2wSt
         wkvg==
X-Gm-Message-State: AOAM5305c4O7duVUEhsK8KB+uHPAXtXEsc+r9yaUzJGWtUDq3Qu+r7aW
        aqhcF8hXPZuYVS4yAWM3sKNbipPwvT2aExgMXwiC+DElC0DPPP8TD8Q196BpqXIvon1BQCeyS7P
        rKaChrG01N3bx+9IdV2tONUfB
X-Received: by 2002:adf:e5c9:: with SMTP id a9mr8700554wrn.376.1625387455157;
        Sun, 04 Jul 2021 01:30:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwxGgBxRdRHKsi3pLvnR9YQmU1IRGI0nidEiliUf/DDtuDrxohgpJHy7wgnQWR8PGRO13Hew==
X-Received: by 2002:adf:e5c9:: with SMTP id a9mr8700530wrn.376.1625387454934;
        Sun, 04 Jul 2021 01:30:54 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
        by smtp.gmail.com with ESMTPSA id l10sm8293941wrt.49.2021.07.04.01.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 01:30:54 -0700 (PDT)
Date:   Sun, 4 Jul 2021 04:30:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Colin Ian King <colin.king@canonical.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        oxffffaa@gmail.com
Subject: Re: [RFC PATCH v2 0/6] Improve SOCK_SEQPACKET receive logic
Message-ID: <20210704042843-mutt-send-email-mst@kernel.org>
References: <20210704080820.88746-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210704080820.88746-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2021 at 11:08:13AM +0300, Arseny Krasnov wrote:
> 	This patchset modifies receive logic for SOCK_SEQPACKET.
> Difference between current implementation and this version is that
> now reader is woken up when there is at least one RW packet in rx
> queue of socket and data is copied to user's buffer, while merged
> approach wake up user only when whole message is received and kept
> in queue. New implementation has several advantages:
>  1) There is no limit for message length. Merged approach requires
>     that length must be smaller than 'peer_buf_alloc', otherwise
>     transmission will stuck.
>  2) There is no need to keep whole message in queue, thus no
>     'kmalloc()' memory will be wasted until EOR is received.
> 
>     Also new approach has some feature: as fragments of message
> are copied until EOR is received, it is possible that part of
> message will be already in user's buffer, while rest of message
> still not received. And if user will be interrupted by signal or
> timeout with part of message in buffer, it will exit receive loop,
> leaving rest of message in queue. To solve this problem special
> callback was added to transport: it is called when user was forced
> to leave exit loop and tells transport to drop any packet until
> EOR met.

Sorry about commenting late in the game.  I'm a bit lost


SOCK_SEQPACKET
Provides sequenced, reliable, bidirectional, connection-mode transmission paths for records. A record can be sent using one or more output operations and received using one or more input operations, but a single operation never transfers part of more than one record. Record boundaries are visible to the receiver via the MSG_EOR flag.

it's supposed to be reliable - how is it legal to drop packets?


> When EOR is found, this mode is disabled and normal packet
> processing started. Note, that when 'drop until EOR' mode is on,
> incoming packets still inserted in queue, reader will be woken up,
> tries to copy data, but nothing will be copied until EOR found.
> It was possible to drain such unneeded packets it rx work without
> kicking user, but implemented way is simplest. Anyway, i think
> such cases are rare.


>     New test also added - it tries to copy to invalid user's
> buffer.
> 
> Arseny Krasnov (16):
>  af_vsock/virtio/vsock: change seqpacket receive logic
>  af_vsock/virtio/vsock: remove 'seqpacket_has_data' callback
>  virtio/vsock: remove 'msg_count' based logic
>  af_vsock/virtio/vsock: add 'seqpacket_drop()' callback
>  virtio/vsock: remove record size limit for SEQPACKET
>  vsock_test: SEQPACKET read to broken buffer
> 
>  drivers/vhost/vsock.c                   |   2 +-
>  include/linux/virtio_vsock.h            |   7 +-
>  include/net/af_vsock.h                  |   4 +-
>  net/vmw_vsock/af_vsock.c                |  44 ++++----
>  net/vmw_vsock/virtio_transport.c        |   2 +-
>  net/vmw_vsock/virtio_transport_common.c | 103 ++++++++-----------
>  net/vmw_vsock/vsock_loopback.c          |   2 +-
>  tools/testing/vsock/vsock_test.c        | 120 ++++++++++++++++++++++
>  8 files changed, 193 insertions(+), 91 deletions(-)
> 
>  v1 -> v2:
>  Patches reordered and reorganized.
> 
> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> ---
>  cv.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 cv.txt
> 
> diff --git a/cv.txt b/cv.txt
> new file mode 100644
> index 000000000000..e69de29bb2d1
> -- 
> 2.25.1

