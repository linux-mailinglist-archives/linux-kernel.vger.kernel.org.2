Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B4C38738F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347303AbhERHxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238641AbhERHxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621324355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p9kYQX9+jlMVrfT7LlQkoPwBVtgy2VXVBykxVLkyCrs=;
        b=YNAkl2TqEEGPa10TfsWIx/U5aKWzQnvhOhAApdWu70pVWX3DZFgfQFdCoZGFcq/+ODMkOq
        HYgv3l5R18ptW2lrvMFWhaaxdVOGfNm2dsuqz6lA6y/tSnKbM1zHL2dzNQASvjV50WG98q
        lY+c+1C8KC4uZsub99QAaDPjn/DtOP8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-5ymFumHaMQyLtoUyUOFr3Q-1; Tue, 18 May 2021 03:52:31 -0400
X-MC-Unique: 5ymFumHaMQyLtoUyUOFr3Q-1
Received: by mail-wr1-f70.google.com with SMTP id i102-20020adf90ef0000b029010dfcfc46c0so5214406wri.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9kYQX9+jlMVrfT7LlQkoPwBVtgy2VXVBykxVLkyCrs=;
        b=tggW/si74TQkmBTqgJ2XjpW5eU29qWuQiuJCbJRHsM8z6xsAiegHeakkBtbIdNIXDe
         YitWiuMgp1+uNdv5L6e7s109TEtL5ox0V4NxWt2k/4CIUbUif3DsaCEwCniY40sOT2pN
         im/0YMy/f5E22TKS0fRtaDAYB6Q/0wCVx6+NnUqn3UW06q+tqFYAqxw0vB1nKIoDjAZz
         E0tLP/BO9QocZdA8IsIYLKRsjy04vz8a6BxUOTTryhNFu8+y87BAzkmikliXLSay7wTv
         ICburBZSaSk5tHn/1lAgsOT0ROrJm2nt4SbDBO8TKmyZP4PIGjGPVzffsjsU1+mwQTJT
         vZCQ==
X-Gm-Message-State: AOAM5304+qGsJGLOkRJOUzJpiClISyXfsmJjG6t6zGeb2ZnTBklNTsmh
        hx8N60/+KY7rk29kHlVL+Fmjm02E44p2Q9kFRkiSrJqr0SOzB66/muzen5oYz5vGyWdPFYjFhFm
        UKcyHXiEN5DEDK8xnyEBi8JgYvy3g3Rx2IpGqtwkw
X-Received: by 2002:a05:6000:43:: with SMTP id k3mr5161714wrx.222.1621324350514;
        Tue, 18 May 2021 00:52:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy57QWx1Ov1vyh0TzbyrOH0cj+e32NvnYKAZJPCRd1Ls4ChobMxvXgL27Lpb43iGPVsbefTsMUY9jLvCUeu7wk=
X-Received: by 2002:a05:6000:43:: with SMTP id k3mr5161689wrx.222.1621324350215;
 Tue, 18 May 2021 00:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210429102828.31248-1-prasanna.kalever@redhat.com> <YKMKdHPFCNhR1SXx@T590>
In-Reply-To: <YKMKdHPFCNhR1SXx@T590>
From:   Prasanna Kalever <pkalever@redhat.com>
Date:   Tue, 18 May 2021 13:22:19 +0530
Message-ID: <CANwsLLH0HyZ-VGPMc+VmuLivG1fiZHnSqUyLx3UWb76ZMCgYSg@mail.gmail.com>
Subject: Re: [PATCH] nbd: provide a way for userspace processes to identify
 device backends
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, Josef Bacik <josef@toxicpanda.com>,
        axboe@kernel.dk, Ilya Dryomov <idryomov@redhat.com>,
        Xiubo Li <xiubli@redhat.com>,
        Matteo Croce <mcroce@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 6:00 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> Hello Prasanna,
>
> On Thu, Apr 29, 2021 at 03:58:28PM +0530, Prasanna Kumar Kalever wrote:
> > Problem:
> > On reconfigure of device, there is no way to defend if the backend
> > storage is matching with the initial backend storage.
> >
> > Say, if an initial connect request for backend "pool1/image1" got
> > mapped to /dev/nbd0 and the userspace process is terminated. A next
> > reconfigure request within NBD_ATTR_DEAD_CONN_TIMEOUT is allowed to
> > use /dev/nbd0 for a different backend "pool1/image2"
> >
> > For example, an operation like below could be dangerous:
>

Hello Ming,

> Can you explain a bit why it is dangerous?

Yes, sure. Please check the below comments inline,

>
> >
> > $ sudo rbd-nbd map --try-netlink rbd-pool/ext4-image
> > /dev/nbd0
> > $ sudo blkid /dev/nbd0
> > /dev/nbd0: UUID="bfc444b4-64b1-418f-8b36-6e0d170cfc04" TYPE="ext4"

On Map the rbd-nbd attempting to send NBD_CMD_CONNECT, for backend
'rbd-pool/ext4-image'. Post which kernel will allocate a new device
say /dev/nbd0 for backend file rbd-pool/ext4-image (format:
<pool>/<backendfile>)

> > $ sudo pkill -9 rbd-nbd

Assume normally or abnormally the userspace process (rbd-nbd here) is
terminated, but then as per the settings the device /dev/nbd0 is not
returned immediately, the kernel will wait for the
NBD_ATTR_DEAD_CONN_TIMEOUT to expire.

At this point two things could be possible:
1. if there is a reconfigure request from userspace within the timeout
then the kernel might reassign the same device /dev/nbd0.
2. if the timeout has expired, then the device will be relieved.

> > $ sudo rbd-nbd attach --try-netlink --device /dev/nbd0 rbd-pool/xfs-image
> > /dev/nbd0
> > $ sudo blkid /dev/nbd0
> > /dev/nbd0: UUID="d29bf343-6570-4069-a9ea-2fa156ced908" TYPE="xfs"

On attach the rbd-nbd attempt to send NBD_CMD_RECONFIGURE, after which
the kernel will assign '--device /dev/nbd0' to specified backend.

But there is a chance that userspace processes might accidentally send
NBD_CMD_RECONFIGURE claiming for /dev/nbd0 for a different backend
(rbd-pool/xfs-image instead of original rbd-pool/ext4-image).
Currently, there is no mechanism to verify if the backend provided
later with attach(NBD_CMD_RECONFIGURE) is matching with the one
provided originally with map(NBD_CMD_CONNECT) before granting for a
attach or reconfigure.

For example in the above-explained scenario:
Assume EXT4 on rbd-pool/ext4-image was mounted, after attach (Note:
device /dev/nbd0 is reconfigured to a different backend file) XFS on
rbd-pool/xfs-image would get corrupted. If there was an application
using /dev/nbd0 directly (as a raw block volume), it wouldn't be happy
either.

> >
> > Solution:
> > Provide a way for userspace processes to keep some metadata to identify
> > between the device and the backend, so that when a reconfigure request is
> > made, we can compare and avoid such dangerous operations.
> >
> > With this solution, as part of the initial connect request, backend
> > path can be stored in the sysfs per device config, so that on a reconfigure
> > request it's easy to check if the backend path matches with the initial
> > connect backend path.
> >
> > Please note, ioctl interface to nbd will not have these changes, as there
> > won't be any reconfigure.
>
> BTW, loop has similar issue, and patch of 'block: add a sequence number to disks'
> is added for addressing this issue, what do you think of that generic
> approach wrt. this nbd's issue? such as used the exposed sysfs sequence number
> for addressing this issue?
>
> https://lore.kernel.org/linux-block/YH81n34d2G3C4Re+@gardel-login/#r

If I understand the changes and the background of the fix correctly, I
think with that fix author is trying to monotonically increase the seq
number and add it to the disk on every single device map/attach and
expose it through the sysfs, which will help the userspace processes
further to correlate events for particular and specific devices that
reuse the same loop device.

Coming back to my changes:
I think here with this fix, we are trying to solve a different
problem. The fix with this patch accepts a cookie or a backend string
(could be file-path or whatever id userspace choose to provide) from
userspace at the time of map and stores it in the sysfs
/sys/block/nbdX/backend path and persists it until unmap is issued on
the device (meaning that identity stays throughout the life cycle of
that device, no matter how many detach and attaches happen). If there
is a detach request in between (not unmap) then on the next attach
(reconfigure request to reuse the same device) the stored
cookie/UUID/backend-string will stand as a reference to verify if the
newly passed backend is matching with the actual backend passed at map
time to avoid any misconfigurations by accident and to safely proceed
with attach.


Thank you for the review.

BRs,
--
Prasanna

>
> Thanks,
> Ming
>

