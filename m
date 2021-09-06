Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF21440177A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 10:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbhIFIFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 04:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240536AbhIFIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630915428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W2g1b9NX3P4QOnCtZSdNu+sJkQfvHZK6OJZ7BDJqDLg=;
        b=bTLymkt1Htw3/35pi9zhgmWCvpxDXsQpFKCRDnZOTNScDq9k4E926y8gJLWccOxye3wBBc
        Fa4OkUlnepdmro4bqHcJ3H40BffYwg7gmwompTmyDbo/W0SnPmAlRPOh7JlQJ1jr8EMlLX
        aB8iM546c1Tru4FLhtPBzlRyciisifg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-vtq0fVhBOjGAql7tGNl3uA-1; Mon, 06 Sep 2021 04:03:45 -0400
X-MC-Unique: vtq0fVhBOjGAql7tGNl3uA-1
Received: by mail-ed1-f72.google.com with SMTP id z17-20020a05640240d100b003cac681f4f4so3148372edb.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 01:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W2g1b9NX3P4QOnCtZSdNu+sJkQfvHZK6OJZ7BDJqDLg=;
        b=NOx11SWV/hJjueLHFw50+kFBF2qreLdRf7Fvu+Qo4P1Qo4bG2E7sn6+U7Ezjh/a/kE
         ikxLfg/aoVGixxxBsUJlInV6qYmXx/av7mLUh3iaAd/Cg7TP6WyTJbyC3WEzdDK79wBT
         YikxHqWLxrdz3ZcVzGvJP3u5o84pJjMorNeasqFloLd3ufdmk2hvTfccBuz+EnJ4KKPn
         /P8gvuavkr9S1mx7gGRQkCHhPi1+e8sMvrKDUMbxLCXaKxUpq8OLb8SNT/r1Lu/HkmrO
         S0Io2zg5qvBLNtFMXSsE9UbAkuUtfgcgsmt2vPpuejYBxtOiL6Kh+ho2eNz/JsCUjHu/
         bdCg==
X-Gm-Message-State: AOAM530xL+Wx/NOYgdC6pAmbrCE6d7Z+5bMbQ1qDzsjZVxz51pCD2VG0
        OEDKCfkwxP1sESRK/x2Zr9aiAEGCxvjVaoHUPcOiFK/2uVjLeehNdJ/CvUkQANSGf7LxPsSTPNj
        fypDieuirURSIvgL58wawBsL1
X-Received: by 2002:a05:6402:148:: with SMTP id s8mr12049797edu.298.1630915424072;
        Mon, 06 Sep 2021 01:03:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRJf9kq4wjR1PeMax4DOv0vHAJxFFvRjMlnKsmrmMvqdiz5jcTh29LDuagCJ7xkcWidZAWDA==
X-Received: by 2002:a05:6402:148:: with SMTP id s8mr12049783edu.298.1630915423910;
        Mon, 06 Sep 2021 01:03:43 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
        by smtp.gmail.com with ESMTPSA id c25sm3423749ejm.9.2021.09.06.01.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 01:03:43 -0700 (PDT)
Date:   Mon, 6 Sep 2021 04:03:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
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
Message-ID: <20210906040148-mutt-send-email-mst@kernel.org>
References: <20210903123016.3272800-1-arseny.krasnov@kaspersky.com>
 <20210905115139-mutt-send-email-mst@kernel.org>
 <4558e96b-6330-667f-955b-b689986f884f@kaspersky.com>
 <20210905121932-mutt-send-email-mst@kernel.org>
 <5b20410a-fb8f-2e38-59d9-74dc6b8a9d4f@kaspersky.com>
 <20210905161809-mutt-send-email-mst@kernel.org>
 <20210906073315.n7qgsv3gm7dasgzu@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906073315.n7qgsv3gm7dasgzu@steredhat>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 09:33:15AM +0200, Stefano Garzarella wrote:
> On Sun, Sep 05, 2021 at 04:18:52PM -0400, Michael S. Tsirkin wrote:
> > On Sun, Sep 05, 2021 at 07:21:10PM +0300, Arseny Krasnov wrote:
> > > 
> > > On 05.09.2021 19:19, Michael S. Tsirkin wrote:
> > > > On Sun, Sep 05, 2021 at 07:02:44PM +0300, Arseny Krasnov wrote:
> > > >> On 05.09.2021 18:55, Michael S. Tsirkin wrote:
> > > >>> On Fri, Sep 03, 2021 at 03:30:13PM +0300, Arseny Krasnov wrote:
> > > >>>> 	This patchset implements support of MSG_EOR bit for SEQPACKET
> > > >>>> AF_VSOCK sockets over virtio transport.
> > > >>>> 	First we need to define 'messages' and 'records' like this:
> > > >>>> Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
> > > >>>> etc. It has fixed maximum length, and it bounds are visible using
> > > >>>> return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
> > > >>>> Current implementation based on message definition above.
> > > >>>> 	Record has unlimited length, it consists of multiple message,
> > > >>>> and bounds of record are visible via MSG_EOR flag returned from
> > > >>>> 'recvmsg()' call. Sender passes MSG_EOR to sending system call and
> > > >>>> receiver will see MSG_EOR when corresponding message will be processed.
> > > >>>> 	Idea of patchset comes from POSIX: it says that SEQPACKET
> > > >>>> supports record boundaries which are visible for receiver using
> > > >>>> MSG_EOR bit. So, it looks like MSG_EOR is enough thing for SEQPACKET
> > > >>>> and we don't need to maintain boundaries of corresponding send -
> > > >>>> receive system calls. But, for 'sendXXX()' and 'recXXX()' POSIX says,
> > > >>>> that all these calls operates with messages, e.g. 'sendXXX()' sends
> > > >>>> message, while 'recXXX()' reads messages and for SEQPACKET, 'recXXX()'
> > > >>>> must read one entire message from socket, dropping all out of size
> > > >>>> bytes. Thus, both message boundaries and MSG_EOR bit must be supported
> > > >>>> to follow POSIX rules.
> > > >>>> 	To support MSG_EOR new bit was added along with existing
> > > >>>> 'VIRTIO_VSOCK_SEQ_EOR': 'VIRTIO_VSOCK_SEQ_EOM'(end-of-message) - now it
> > > >>>> works in the same way as 'VIRTIO_VSOCK_SEQ_EOR'. But 'VIRTIO_VSOCK_SEQ_EOR'
> > > >>>> is used to mark 'MSG_EOR' bit passed from userspace.
> > > >>>> 	This patchset includes simple test for MSG_EOR.
> > > >>> I'm prepared to merge this for this window,
> > > >>> but I'm not sure who's supposed to ack the net/vmw_vsock/af_vsock.c
> > > >>> bits. It's a harmless variable renaming so maybe it does not matter.
> > > >>>
> > > >>> The rest is virtio stuff so I guess my tree is ok.
> > > >>>
> > > >>> Objections, anyone?
> > > >> https://lkml.org/lkml/2021/9/3/76 this is v4. It is same as v5 in af_vsock.c changes.
> > > >>
> > > >> It has Reviewed by from Stefano Garzarella.
> > > > Is Stefano the maintainer for af_vsock then?
> > > > I wasn't sure.
> 
> I'm maintaining virtio-vsock stuff, but I'm reviewing most of the af_vsock
> patches. We don't have an entry for it in MAINTAINERS, maybe we should.

Yea, please add that. And the test I guess?
It's now Dave and while he's great as we all know,
reducing the load on him is a good thing to do.

> > > Ack, let's wait for maintainer's comment
> > 
> > 
> > The specific patch is a trivial variable renaming so
> > I parked this in my tree for now, will merge unless I
> > hear any objections in the next couple of days.
> 
> I agree, I think your tree is fine, since this series is mostly about
> virtio-vsock.
> 
> Thanks,
> Stefano

