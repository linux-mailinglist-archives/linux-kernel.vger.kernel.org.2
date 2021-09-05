Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179B840117B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 22:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbhIEUUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 16:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233039AbhIEUUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 16:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630873140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQWW6TpVY//HFZs2vSUfOxyHJTX08YzLd3xkHk5EtPE=;
        b=BABlO+H6H5f2MD0thZ93TaKj/yWO7T/R28cRkrldgkjmN9M4GtN2Qhq7OAl3NVCFFwc/+9
        xzpclb0ReuWmp8fR2vZD3IPWUkWL767Csr0krdrC7/u3g9vaFNV18gK2HrhkFS4r7KAQG3
        VLsBo4KlgbDktlN0svnJdBnHJEFE1Pg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-NAZO5fKNPVOVbUAT54mt1Q-1; Sun, 05 Sep 2021 16:18:58 -0400
X-MC-Unique: NAZO5fKNPVOVbUAT54mt1Q-1
Received: by mail-ej1-f69.google.com with SMTP id f23-20020a17090624d700b005d7f8be91eeso1355041ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 13:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fQWW6TpVY//HFZs2vSUfOxyHJTX08YzLd3xkHk5EtPE=;
        b=rFBmcSft7t4WDsEHebQtw/n4Q5WvlS4Dc23oUxcE2529fUNZOlii5VVQX4zPYpWQiT
         ldHf2IVmx3VZOJmjqca8Taa+DLBHmyzD2PuE2usS4VwafXlea5MMCJ9y/eL+D+32bi13
         23Bvy8smXA1SfMH7yBmGKA5Zh0qj51D37OZi72NiwoHvv3S74pCf/kAuMlZfTBcz68eb
         lc9Rt3v/dTEpDIum7O3eFlhIiYVKNYQoqy258945J1rVb5zmAKga+0DWAD332cx94EKh
         8lVe4/D5i8gxvDGFuCVSs7S2oXiyA5laJSSoNrJLD7X+ClzDw9S301KdKR/eQt/XGIY6
         cxEA==
X-Gm-Message-State: AOAM530pg7p9X9zbCR/uOwStDrFbeJiCVfx5YMu7+WL94RENwj8RGpjP
        ZeCR6ydMNOBKakZLgIi04I4PppOLzfVNyyPYv5qdyCKLLrmy7eWXytnGoC5dseZEBX+SOEJ/Y/e
        u9CxRe/bqW9BH9MlsuRtAwOlp
X-Received: by 2002:a50:c31e:: with SMTP id a30mr9935810edb.123.1630873137569;
        Sun, 05 Sep 2021 13:18:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZyj5klHOKXtKHJVij4O41tF6RVru9NpoUc9SoZ7Oi7i9goRlBONg0sRdXLSdPiSXG6ezXvw==
X-Received: by 2002:a50:c31e:: with SMTP id a30mr9935790edb.123.1630873137307;
        Sun, 05 Sep 2021 13:18:57 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
        by smtp.gmail.com with ESMTPSA id k6sm3292620edv.77.2021.09.05.13.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 13:18:56 -0700 (PDT)
Date:   Sun, 5 Sep 2021 16:18:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stsp2@yandex.ru" <stsp2@yandex.ru>,
        "oxffffaa@gmail.com" <oxffffaa@gmail.com>
Subject: Re: [PATCH net-next v5 0/6] virtio/vsock: introduce MSG_EOR flag for
 SEQPACKET
Message-ID: <20210905161809-mutt-send-email-mst@kernel.org>
References: <20210903123016.3272800-1-arseny.krasnov@kaspersky.com>
 <20210905115139-mutt-send-email-mst@kernel.org>
 <4558e96b-6330-667f-955b-b689986f884f@kaspersky.com>
 <20210905121932-mutt-send-email-mst@kernel.org>
 <5b20410a-fb8f-2e38-59d9-74dc6b8a9d4f@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b20410a-fb8f-2e38-59d9-74dc6b8a9d4f@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2021 at 07:21:10PM +0300, Arseny Krasnov wrote:
> 
> On 05.09.2021 19:19, Michael S. Tsirkin wrote:
> > On Sun, Sep 05, 2021 at 07:02:44PM +0300, Arseny Krasnov wrote:
> >> On 05.09.2021 18:55, Michael S. Tsirkin wrote:
> >>> On Fri, Sep 03, 2021 at 03:30:13PM +0300, Arseny Krasnov wrote:
> >>>> 	This patchset implements support of MSG_EOR bit for SEQPACKET
> >>>> AF_VSOCK sockets over virtio transport.
> >>>> 	First we need to define 'messages' and 'records' like this:
> >>>> Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
> >>>> etc. It has fixed maximum length, and it bounds are visible using
> >>>> return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
> >>>> Current implementation based on message definition above.
> >>>> 	Record has unlimited length, it consists of multiple message,
> >>>> and bounds of record are visible via MSG_EOR flag returned from
> >>>> 'recvmsg()' call. Sender passes MSG_EOR to sending system call and
> >>>> receiver will see MSG_EOR when corresponding message will be processed.
> >>>> 	Idea of patchset comes from POSIX: it says that SEQPACKET
> >>>> supports record boundaries which are visible for receiver using
> >>>> MSG_EOR bit. So, it looks like MSG_EOR is enough thing for SEQPACKET
> >>>> and we don't need to maintain boundaries of corresponding send -
> >>>> receive system calls. But, for 'sendXXX()' and 'recXXX()' POSIX says,
> >>>> that all these calls operates with messages, e.g. 'sendXXX()' sends
> >>>> message, while 'recXXX()' reads messages and for SEQPACKET, 'recXXX()'
> >>>> must read one entire message from socket, dropping all out of size
> >>>> bytes. Thus, both message boundaries and MSG_EOR bit must be supported
> >>>> to follow POSIX rules.
> >>>> 	To support MSG_EOR new bit was added along with existing
> >>>> 'VIRTIO_VSOCK_SEQ_EOR': 'VIRTIO_VSOCK_SEQ_EOM'(end-of-message) - now it
> >>>> works in the same way as 'VIRTIO_VSOCK_SEQ_EOR'. But 'VIRTIO_VSOCK_SEQ_EOR'
> >>>> is used to mark 'MSG_EOR' bit passed from userspace.
> >>>> 	This patchset includes simple test for MSG_EOR.
> >>> I'm prepared to merge this for this window,
> >>> but I'm not sure who's supposed to ack the net/vmw_vsock/af_vsock.c
> >>> bits. It's a harmless variable renaming so maybe it does not matter.
> >>>
> >>> The rest is virtio stuff so I guess my tree is ok.
> >>>
> >>> Objections, anyone?
> >> https://lkml.org/lkml/2021/9/3/76 this is v4. It is same as v5 in af_vsock.c changes.
> >>
> >> It has Reviewed by from Stefano Garzarella.
> > Is Stefano the maintainer for af_vsock then?
> > I wasn't sure.
> Ack, let's wait for maintainer's comment


The specific patch is a trivial variable renaming so
I parked this in my tree for now, will merge unless I
hear any objections in the next couple of days.

> >>>
> >>>>  Arseny Krasnov(6):
> >>>>   virtio/vsock: rename 'EOR' to 'EOM' bit.
> >>>>   virtio/vsock: add 'VIRTIO_VSOCK_SEQ_EOR' bit.
> >>>>   vhost/vsock: support MSG_EOR bit processing
> >>>>   virtio/vsock: support MSG_EOR bit processing
> >>>>   af_vsock: rename variables in receive loop
> >>>>   vsock_test: update message bounds test for MSG_EOR
> >>>>
> >>>>  drivers/vhost/vsock.c                   | 28 +++++++++++++----------
> >>>>  include/uapi/linux/virtio_vsock.h       |  3 ++-
> >>>>  net/vmw_vsock/af_vsock.c                | 10 ++++----
> >>>>  net/vmw_vsock/virtio_transport_common.c | 23 ++++++++++++-------
> >>>>  tools/testing/vsock/vsock_test.c        |  8 ++++++-
> >>>>  5 files changed, 45 insertions(+), 27 deletions(-)
> >>>>
> >>>>  v4 -> v5:
> >>>>  - Move bitwise and out of le32_to_cpu() in 0003.
> >>>>
> >>>>  v3 -> v4:
> >>>>  - 'sendXXX()' renamed to 'send*()' in 0002- commit msg.
> >>>>  - Comment about bit restore updated in 0003-.
> >>>>  - 'same' renamed to 'similar' in 0003- commit msg.
> >>>>  - u32 used instead of uint32_t in 0003-.
> >>>>
> >>>>  v2 -> v3:
> >>>>  - 'virtio/vsock: rename 'EOR' to 'EOM' bit.' - commit message updated.
> >>>>  - 'VIRTIO_VSOCK_SEQ_EOR' bit add moved to separate patch.
> >>>>  - 'vhost/vsock: support MSG_EOR bit processing' - commit message
> >>>>    updated.
> >>>>  - 'vhost/vsock: support MSG_EOR bit processing' - removed unneeded
> >>>>    'le32_to_cpu()', because input argument was already in CPU
> >>>>    endianness.
> >>>>
> >>>>  v1 -> v2:
> >>>>  - 'VIRTIO_VSOCK_SEQ_EOR' is renamed to 'VIRTIO_VSOCK_SEQ_EOM', to
> >>>>    support backward compatibility.
> >>>>  - use bitmask of flags to restore in vhost.c, instead of separated
> >>>>    bool variable for each flag.
> >>>>  - test for EAGAIN removed, as logically it is not part of this
> >>>>    patchset(will be sent separately).
> >>>>  - cover letter updated(added part with POSIX description).
> >>>>
> >>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> >>>> -- 
> >>>> 2.25.1
> >

