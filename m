Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA6D3E017D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbhHDM6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236732AbhHDM6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628081868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0/bO+MgPDOUvO02RQ1/ITQ19fPYuZ/wXOCdSbbV0LTs=;
        b=UCoW/u3bwoN1cij5IZAJGsLIQn6XEhfX8lEutJfSCo5jSnhtxsvtOE2tLhcvfhcOxbTuAn
        43+EhRSZuChrPQxmQmsxmDHTZOo3POI5ScGxqbErMZri9c4ArW128pc54FzR/jmB0nw41H
        fLfaAB0DegJI+INZWGewT1Hf4wCa0m0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-tywEbNnQPBuBmd83L_6I3g-1; Wed, 04 Aug 2021 08:57:45 -0400
X-MC-Unique: tywEbNnQPBuBmd83L_6I3g-1
Received: by mail-ed1-f69.google.com with SMTP id u4-20020a50eac40000b02903bddc52675eso1248255edp.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 05:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0/bO+MgPDOUvO02RQ1/ITQ19fPYuZ/wXOCdSbbV0LTs=;
        b=WTmoTkjbJB9BhqPhYOtHhEROV21ucSHT61t44DDNJM9/vVvZbJj19//qkpNByTjHdj
         E4jNX2NLCWJctDExGLj35JpBVUD8w+OJyMNBlFso/1hv73ddC6n07PDnm0aYCFUzvz0v
         mvY+xsFuil7Do6eCRQqaxHj3NnxS5bGVBhjr0mz5DMwbXHSiFAmVlkEW5kR4ysl9BfQR
         2H7xlR/W8R4/QQm01Ar6tOKejxEIauTuXTwvJsyqTA/EdiRUYOEHisZaU5pLoqayehc5
         StwisaY1jd7drupF+iS6dD/8HziSNGzVH6xtHmVherwqE1zh311O9jq3L55fchzz7ZGj
         KBcQ==
X-Gm-Message-State: AOAM532mA5tC6h7kriSfeUo9pkgwxYeTlwCgEYSc4fZqL30Ojor6kgHl
        ZjN2iY7Dl4R5SvSCLuB8v/6X2kb84BimM029D4FTX3g2iA4H394SvSFH/Ny3D4nNgiqhQq/nHmy
        xK1JvJauaaqW4RuJXhrlzk4cm
X-Received: by 2002:a17:906:c085:: with SMTP id f5mr26109122ejz.250.1628081864054;
        Wed, 04 Aug 2021 05:57:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiZNmhNR8yr3j+9pHq54LbMN6zvfVQtndDuehBDERZ/x4tZYc2Uu210Q95TZ8Abyb0Xl5IzQ==
X-Received: by 2002:a17:906:c085:: with SMTP id f5mr26109096ejz.250.1628081863868;
        Wed, 04 Aug 2021 05:57:43 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id n11sm666345ejg.111.2021.08.04.05.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 05:57:43 -0700 (PDT)
Date:   Wed, 4 Aug 2021 14:57:37 +0200
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
Message-ID: <20210804125737.kbgc6mg2v5lw25wu@steredhat>
References: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseny,

On Mon, Jul 26, 2021 at 07:31:33PM +0300, Arseny Krasnov wrote:
>	This patchset implements support of MSG_EOR bit for SEQPACKET
>AF_VSOCK sockets over virtio transport.
>	Idea is to distinguish concepts of 'messages' and 'records'.
>Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
>etc. It has fixed maximum length, and it bounds are visible using
>return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
>Current implementation based on message definition above.

Okay, so the implementation we merged is wrong right?
Should we disable the feature bit in stable kernels that contain it? Or 
maybe we can backport the fixes...

>	Record has unlimited length, it consists of multiple message,
>and bounds of record are visible via MSG_EOR flag returned from
>'recvmsg()' call. Sender passes MSG_EOR to sending system call and
>receiver will see MSG_EOR when corresponding message will be processed.
>	To support MSG_EOR new bit was added along with existing
>'VIRTIO_VSOCK_SEQ_EOR': 'VIRTIO_VSOCK_SEQ_EOM'(end-of-message) - now it
>works in the same way as 'VIRTIO_VSOCK_SEQ_EOR'. But 'VIRTIO_VSOCK_SEQ_EOR'
>is used to mark 'MSG_EOR' bit passed from userspace.

I understand that it makes sense to remap VIRTIO_VSOCK_SEQ_EOR to 
MSG_EOR to make the user understand the boundaries, but why do we need 
EOM as well?

Why do we care about the boundaries of a message within a record?
I mean, if the sender makes 3 calls:
     send(A1,0)
     send(A2,0)
     send(A3, MSG_EOR);

IIUC it should be fine if the receiver for example receives all in one 
single recv() calll with MSG_EOR set, so why do we need EOM?

Thanks,
Stefano

