Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D494016FD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbhIFHe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239854AbhIFHeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630913600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RSrx4XOVTKDR+lRM3utIJIs7HCPXyZCtAZOFr15Y8Bw=;
        b=X7DT8HoDz8ZPSQAjJcAahyqM4Mi0w3eMABkPs2OEiDrDk20exV38TUUI/K/gZqOu1IAs0p
        lFwCwaIAeWkogUzMg4AcoyER+xsxhwAbt0fdDThFR5sPQ8gg9j9McxtF3/uCuwFQ7P364Z
        LPrUP/SZCGmamLqpA3wNBDHZrDDHrSU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-VRasUscAPPijmbrMgSHphg-1; Mon, 06 Sep 2021 03:33:19 -0400
X-MC-Unique: VRasUscAPPijmbrMgSHphg-1
Received: by mail-ej1-f71.google.com with SMTP id cf17-20020a170906b2d100b005d42490f86bso1947164ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 00:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RSrx4XOVTKDR+lRM3utIJIs7HCPXyZCtAZOFr15Y8Bw=;
        b=WORO39Ng+ggNzNOth07bIwcbk8tAXiuycCi+VemXfnQzSUo6o8YXbY2L8m4QuUCRYm
         gYb0ewurtpmNZwuGl1hBgXVs964J1h6hD/SjAViubw492ADz55BtaqfFZjgbagBSNP1j
         T7NkCdF020+5Qtr9gOeUwDEHABvlr8bLoFd4h8wx2MmY2mZM1Wo91EKJrVL3trtOszHk
         b2fTsSkfkmZMoZxR4ciok42YKp0o+Yx8heGcRsQDqpWSLAG2G2GUujg0LVtS8Cwf9WFN
         ZENlo2XLVDfJ/fu53PmoTVR5kKlU0anvBpGJXyoQ9vRJ5oJkaBEVNRTv/YFo8+n/fuNg
         qVbA==
X-Gm-Message-State: AOAM532f5JXwNKJKcos+l/GcDaTki8weckGdSGGoDFItQeX75w81O45D
        Tu/mb1iR26o9hqTsY099NE+uRfAHWaF8C6/KCcITwVzsZLpFESUDx2CgqdxPmMZldoM+IsZZgos
        wbU6keTZxzJKT5qG46zruyTHK
X-Received: by 2002:a05:6402:524f:: with SMTP id t15mr12090721edd.121.1630913598479;
        Mon, 06 Sep 2021 00:33:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztuWeCXr3yeqKVL82y9FHLYnMqEF7PCrl5+Qj+0fsCR1hZx3SVNS75Zj5Zq0HWAuYyDMs9jw==
X-Received: by 2002:a05:6402:524f:: with SMTP id t15mr12090699edd.121.1630913598298;
        Mon, 06 Sep 2021 00:33:18 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it. [79.51.2.59])
        by smtp.gmail.com with ESMTPSA id y32sm4119673ede.22.2021.09.06.00.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:33:17 -0700 (PDT)
Date:   Mon, 6 Sep 2021 09:33:15 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Arseny Krasnov <arseny.krasnov@kaspersky.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
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
Message-ID: <20210906073315.n7qgsv3gm7dasgzu@steredhat>
References: <20210903123016.3272800-1-arseny.krasnov@kaspersky.com>
 <20210905115139-mutt-send-email-mst@kernel.org>
 <4558e96b-6330-667f-955b-b689986f884f@kaspersky.com>
 <20210905121932-mutt-send-email-mst@kernel.org>
 <5b20410a-fb8f-2e38-59d9-74dc6b8a9d4f@kaspersky.com>
 <20210905161809-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210905161809-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2021 at 04:18:52PM -0400, Michael S. Tsirkin wrote:
>On Sun, Sep 05, 2021 at 07:21:10PM +0300, Arseny Krasnov wrote:
>>
>> On 05.09.2021 19:19, Michael S. Tsirkin wrote:
>> > On Sun, Sep 05, 2021 at 07:02:44PM +0300, Arseny Krasnov wrote:
>> >> On 05.09.2021 18:55, Michael S. Tsirkin wrote:
>> >>> On Fri, Sep 03, 2021 at 03:30:13PM +0300, Arseny Krasnov wrote:
>> >>>> 	This patchset implements support of MSG_EOR bit for SEQPACKET
>> >>>> AF_VSOCK sockets over virtio transport.
>> >>>> 	First we need to define 'messages' and 'records' like this:
>> >>>> Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
>> >>>> etc. It has fixed maximum length, and it bounds are visible using
>> >>>> return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
>> >>>> Current implementation based on message definition above.
>> >>>> 	Record has unlimited length, it consists of multiple message,
>> >>>> and bounds of record are visible via MSG_EOR flag returned from
>> >>>> 'recvmsg()' call. Sender passes MSG_EOR to sending system call and
>> >>>> receiver will see MSG_EOR when corresponding message will be processed.
>> >>>> 	Idea of patchset comes from POSIX: it says that SEQPACKET
>> >>>> supports record boundaries which are visible for receiver using
>> >>>> MSG_EOR bit. So, it looks like MSG_EOR is enough thing for SEQPACKET
>> >>>> and we don't need to maintain boundaries of corresponding send -
>> >>>> receive system calls. But, for 'sendXXX()' and 'recXXX()' POSIX says,
>> >>>> that all these calls operates with messages, e.g. 'sendXXX()' sends
>> >>>> message, while 'recXXX()' reads messages and for SEQPACKET, 'recXXX()'
>> >>>> must read one entire message from socket, dropping all out of size
>> >>>> bytes. Thus, both message boundaries and MSG_EOR bit must be supported
>> >>>> to follow POSIX rules.
>> >>>> 	To support MSG_EOR new bit was added along with existing
>> >>>> 'VIRTIO_VSOCK_SEQ_EOR': 'VIRTIO_VSOCK_SEQ_EOM'(end-of-message) - now it
>> >>>> works in the same way as 'VIRTIO_VSOCK_SEQ_EOR'. But 'VIRTIO_VSOCK_SEQ_EOR'
>> >>>> is used to mark 'MSG_EOR' bit passed from userspace.
>> >>>> 	This patchset includes simple test for MSG_EOR.
>> >>> I'm prepared to merge this for this window,
>> >>> but I'm not sure who's supposed to ack the net/vmw_vsock/af_vsock.c
>> >>> bits. It's a harmless variable renaming so maybe it does not matter.
>> >>>
>> >>> The rest is virtio stuff so I guess my tree is ok.
>> >>>
>> >>> Objections, anyone?
>> >> https://lkml.org/lkml/2021/9/3/76 this is v4. It is same as v5 in af_vsock.c changes.
>> >>
>> >> It has Reviewed by from Stefano Garzarella.
>> > Is Stefano the maintainer for af_vsock then?
>> > I wasn't sure.

I'm maintaining virtio-vsock stuff, but I'm reviewing most of the 
af_vsock patches. We don't have an entry for it in MAINTAINERS, maybe we 
should.

>> Ack, let's wait for maintainer's comment
>
>
>The specific patch is a trivial variable renaming so
>I parked this in my tree for now, will merge unless I
>hear any objections in the next couple of days.

I agree, I think your tree is fine, since this series is mostly about 
virtio-vsock.

Thanks,
Stefano

