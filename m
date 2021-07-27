Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06103D70B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbhG0H7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235675AbhG0H7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627372793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/EIq4hrAP0Ac0pX1HeyNfiwT/0BIOEO0auXFwtqoKwk=;
        b=RzWYwwJW0HI5LovkIL/n3eKTaJxruFQFZsnR+6nAOLc2j7Rglx9g3B3OO8/iwDMO3JJluO
        bF9JqQ1V+P0JXy/QYLC698r4I7KJ8h8D419mWyLo6CPGB4Ma8XiPupjqQ/cqL7TbSRhrfT
        0m1snXyA+r3o2E6pOolbXbCf7ywX2q0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-VtHXY_ebMMGZG17Ja4wxjQ-1; Tue, 27 Jul 2021 03:59:52 -0400
X-MC-Unique: VtHXY_ebMMGZG17Ja4wxjQ-1
Received: by mail-ed1-f72.google.com with SMTP id u25-20020aa7d8990000b02903bb6a903d90so3382675edq.17
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/EIq4hrAP0Ac0pX1HeyNfiwT/0BIOEO0auXFwtqoKwk=;
        b=VVvmfyiDQT0kd+WduwZfVNz5CZds9/EJfQ22/Iq0349XsOJQfbDvNpAP0atgbQOIu9
         UpQ3VDrguo2ND7hYXwllRg5BiepxOBWQDMBxQ4yGvJIs2pTdQls7/BSqAdZZ2CqhOfZI
         0DD/qV1MrPEuujprngrIGX+QZ/i7Akgf0uwgBfKUWcnBps+iY9IofN6/MoPZCtZv4XLZ
         Wqa88R5siEAC8Dt6Tq2l2tqmPElatDMduMsC/mj1lZBaABaClLFcWmZ72F3Q8T4B0HQI
         gLcGrGDNXeU56mGOvPUPnRBbrRoSAPUu4Br5QCh/pSjjGng9Ivw9LGzUdvVtTwFSZI8j
         SUbg==
X-Gm-Message-State: AOAM531nfiOLNrSDR5UhivdU4KT2PoRnaXkWCBQkmq+4fUgKFYNRg++0
        wP9hK9REJMXnHhqRLyq1lWFqXfJ4eUWJrLW6aN6/ruZA2ce3Qt6N8LNCr5qrV/PsiT7n+WpeYju
        S8Xy4vwXk8qrI0jGgV/ZFGWG0
X-Received: by 2002:a05:6402:12c3:: with SMTP id k3mr11211306edx.11.1627372791441;
        Tue, 27 Jul 2021 00:59:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlCvS56tYgLWOzqJ8Wh70Fht2s02iJ7M5DydMmq9uVJaSBBqYQBS2qw7251aRYo+dt+iun8A==
X-Received: by 2002:a05:6402:12c3:: with SMTP id k3mr11211285edx.11.1627372791319;
        Tue, 27 Jul 2021 00:59:51 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id i14sm613214eja.91.2021.07.27.00.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:59:50 -0700 (PDT)
Date:   Tue, 27 Jul 2021 09:59:48 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Norbert Slusarek <nslusarek@gmx.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v1 0/7] virtio/vsock: introduce MSG_EOR flag for
 SEQPACKET
Message-ID: <20210727075948.yl4w3foqa6rp4obg@steredhat>
References: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 07:31:33PM +0300, Arseny Krasnov wrote:
>	This patchset implements support of MSG_EOR bit for SEQPACKET
>AF_VSOCK sockets over virtio transport.
>	Idea is to distinguish concepts of 'messages' and 'records'.
>Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
>etc. It has fixed maximum length, and it bounds are visible using
>return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
>Current implementation based on message definition above.
>	Record has unlimited length, it consists of multiple message,
>and bounds of record are visible via MSG_EOR flag returned from
>'recvmsg()' call. Sender passes MSG_EOR to sending system call and
>receiver will see MSG_EOR when corresponding message will be processed.
>	To support MSG_EOR new bit was added along with existing
>'VIRTIO_VSOCK_SEQ_EOR': 'VIRTIO_VSOCK_SEQ_EOM'(end-of-message) - now it
>works in the same way as 'VIRTIO_VSOCK_SEQ_EOR'. But 'VIRTIO_VSOCK_SEQ_EOR'
>is used to mark 'MSG_EOR' bit passed from userspace.

At this point it's probably better to rename the old flag, so we stay 
compatible.

What happens if one of the two peers does not support MSG_EOR handling, 
while the other does?

I'll do a closer review in the next few days.

Thanks,
Stefano

