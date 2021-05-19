Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47E038909E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346818AbhESOUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241224AbhESOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621433858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=icJcCqfGBMIKdg56kl8nkfi2ldLxVscbkDP3FGXCv8k=;
        b=dwT6yvgaQrAppXyYjwGz4eJ+e4Xwvpw9hbLiZW3G6bh2Z8PqKXol96RnBwICM904hTZwSs
        cduT8PshEHCx22HM+VVHrAvICERL5KmNrCJJIaBGv1N+D/qnCZ1e0lPxnveIA8wxB8Fx5T
        hisdsxzPYXMPEIlBcgGoDmlikIGx5yE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-dVDH5yrwOvKdBx3Afna_Eg-1; Wed, 19 May 2021 10:17:37 -0400
X-MC-Unique: dVDH5yrwOvKdBx3Afna_Eg-1
Received: by mail-wm1-f69.google.com with SMTP id l185-20020a1c25c20000b029014b0624775eso1577179wml.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icJcCqfGBMIKdg56kl8nkfi2ldLxVscbkDP3FGXCv8k=;
        b=WzNtCzw1ZNNlvPpe17XQCASlK39IdtcAJq30Tyo7pRKWVrIg1gbRVpHa+hG6LTZh5l
         BagIIqEb7gyGp14x65d/kiq2ExQjgv9KMIiRNL2aMWnjsXxjwdyKSTYw89Hnh6nCC4rh
         qbg/Z4ejYCgrDEadjAZ2Fm9jilBBm2kIdSm3FsJ0NjBJXqkPyvY7GkLl+UwE5/uCROj0
         X0TpzI+MkCqFtvc1/RYmvbwOAvVqNSbUNG4pZgnFDe/udX7lkkqAoAPU7yjB6Xi6QWF0
         kEDlO/Y2AsBmPtqjc2DyaASbHmo2gIy0Gg0jWGQrJDU0C6Wp4sLPe3FcpGK4K8EYh0Uj
         1wkQ==
X-Gm-Message-State: AOAM5339C8B73aphMhpKrvPjqdsnuzdAgT7t1SsmQTULoM4CNeyMopUL
        lllI3FBb/Kn6xwm0UE5GuAGfMk5YD6zIah9EuUhVo5HzdAp8as7ERCabhMOQB+OrdXI62gnCIvC
        PEAja/0ftcjJohx7AHNMHiQeo/9KvfnyPMW1oy/n+
X-Received: by 2002:a1c:f012:: with SMTP id a18mr11823465wmb.53.1621433855691;
        Wed, 19 May 2021 07:17:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUYw+dNhR/wi0zmm1gNhT045SZTpfUQacgFY4wE2XnTZuSC/xawairjyUH3JZ3eNVy8wdsCTxcsaA73SyGJSo=
X-Received: by 2002:a1c:f012:: with SMTP id a18mr11823425wmb.53.1621433855316;
 Wed, 19 May 2021 07:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210429102828.31248-1-prasanna.kalever@redhat.com>
 <YKMKdHPFCNhR1SXx@T590> <CANwsLLH0HyZ-VGPMc+VmuLivG1fiZHnSqUyLx3UWb76ZMCgYSg@mail.gmail.com>
 <YKOHuNd0Kp+lcQHY@T590> <CANwsLLE6FK3eCmDwQ+7ghwFx0Hi1KDr6TaiKX1VW2Yt+5xe+WA@mail.gmail.com>
 <YKTEKmDdKZKTMKYS@T590>
In-Reply-To: <YKTEKmDdKZKTMKYS@T590>
From:   Prasanna Kalever <pkalever@redhat.com>
Date:   Wed, 19 May 2021 19:47:24 +0530
Message-ID: <CANwsLLHqtEGVJO5Ow92OjPm8oDnFRegWv2UfaunXtKVzZ6481g@mail.gmail.com>
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

On Wed, May 19, 2021 at 1:24 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, May 18, 2021 at 03:19:37PM +0530, Prasanna Kalever wrote:
> > On Tue, May 18, 2021 at 2:54 PM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Tue, May 18, 2021 at 01:22:19PM +0530, Prasanna Kalever wrote:
> > > > On Tue, May 18, 2021 at 6:00 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > > >
> > > > > Hello Prasanna,
> > > > >
> > > > > On Thu, Apr 29, 2021 at 03:58:28PM +0530, Prasanna Kumar Kalever wrote:
> > > > > > Problem:
> > > > > > On reconfigure of device, there is no way to defend if the backend
> > > > > > storage is matching with the initial backend storage.
> > > > > >
> > > > > > Say, if an initial connect request for backend "pool1/image1" got
> > > > > > mapped to /dev/nbd0 and the userspace process is terminated. A next
> > > > > > reconfigure request within NBD_ATTR_DEAD_CONN_TIMEOUT is allowed to
> > > > > > use /dev/nbd0 for a different backend "pool1/image2"
> > > > > >
> > > > > > For example, an operation like below could be dangerous:
> > > > >
> > > >
> > > > Hello Ming,
> > > >
> > > > > Can you explain a bit why it is dangerous?
> > > >
> > > > Yes, sure. Please check the below comments inline,
> > > >
> > > > >
> > > > > >
> > > > > > $ sudo rbd-nbd map --try-netlink rbd-pool/ext4-image
> > > > > > /dev/nbd0
> > > > > > $ sudo blkid /dev/nbd0
> > > > > > /dev/nbd0: UUID="bfc444b4-64b1-418f-8b36-6e0d170cfc04" TYPE="ext4"
> > > >
> > > > On Map the rbd-nbd attempting to send NBD_CMD_CONNECT, for backend
> > > > 'rbd-pool/ext4-image'. Post which kernel will allocate a new device
> > > > say /dev/nbd0 for backend file rbd-pool/ext4-image (format:
> > > > <pool>/<backendfile>)
> > > >
> > > > > > $ sudo pkill -9 rbd-nbd
> > > >
> > > > Assume normally or abnormally the userspace process (rbd-nbd here) is
> > > > terminated, but then as per the settings the device /dev/nbd0 is not
> > > > returned immediately, the kernel will wait for the
> > > > NBD_ATTR_DEAD_CONN_TIMEOUT to expire.
> > > >
> > > > At this point two things could be possible:
> > > > 1. if there is a reconfigure request from userspace within the timeout
> > > > then the kernel might reassign the same device /dev/nbd0.
> > > > 2. if the timeout has expired, then the device will be relieved.
> > > >
> > > > > > $ sudo rbd-nbd attach --try-netlink --device /dev/nbd0 rbd-pool/xfs-image
> > > > > > /dev/nbd0
> > > > > > $ sudo blkid /dev/nbd0
> > > > > > /dev/nbd0: UUID="d29bf343-6570-4069-a9ea-2fa156ced908" TYPE="xfs"
> > > >
> > > > On attach the rbd-nbd attempt to send NBD_CMD_RECONFIGURE, after which
> > > > the kernel will assign '--device /dev/nbd0' to specified backend.
> > > >
> > > > But there is a chance that userspace processes might accidentally send
> > > > NBD_CMD_RECONFIGURE claiming for /dev/nbd0 for a different backend
> > > > (rbd-pool/xfs-image instead of original rbd-pool/ext4-image).
> > > > Currently, there is no mechanism to verify if the backend provided
> > > > later with attach(NBD_CMD_RECONFIGURE) is matching with the one
> > > > provided originally with map(NBD_CMD_CONNECT) before granting for a
> > > > attach or reconfigure.
> > > >
> > > > For example in the above-explained scenario:
> > > > Assume EXT4 on rbd-pool/ext4-image was mounted, after attach (Note:
> > > > device /dev/nbd0 is reconfigured to a different backend file) XFS on
> > > > rbd-pool/xfs-image would get corrupted. If there was an application
> > > > using /dev/nbd0 directly (as a raw block volume), it wouldn't be happy
> > > > either.
> > >
> > > OK, got it. If I understand correctly, what you need is to not allow
> > > reconfigure if the nbd disk is mounted, right?
> >
> > Excuse me, not exactly. Mount was one example scenario to showcase why
> > allowing attaching without any validation could be dangerous.
>
> If nbd has exclusive owner, it shouldn't be reconfigured, which
> can be respected in kernel side only, see loop_configure().
>
> Not all application can provide NBD_ATTR_BACKEND_IDENTIFIER, so
> claiming in nbd_genl_reconfigure() is still needed, IMO.
>
> > Basically, we want a way to check and verify if the backend specified
> > at map time and backend specified at attach(reconfigure) time are
> > matching for a given device, only if they are matching proceed to
> > attach else fail.
> >
> > >
> > > >
> > > > > >
> > > > > > Solution:
> > > > > > Provide a way for userspace processes to keep some metadata to identify
> > > > > > between the device and the backend, so that when a reconfigure request is
> > > > > > made, we can compare and avoid such dangerous operations.
> > > > > >
> > > > > > With this solution, as part of the initial connect request, backend
> > > > > > path can be stored in the sysfs per device config, so that on a reconfigure
> > > > > > request it's easy to check if the backend path matches with the initial
> > > > > > connect backend path.
> > > > > >
> > > > > > Please note, ioctl interface to nbd will not have these changes, as there
> > > > > > won't be any reconfigure.
> > > > >
> > > > > BTW, loop has similar issue, and patch of 'block: add a sequence number to disks'
> > > > > is added for addressing this issue, what do you think of that generic
> > > > > approach wrt. this nbd's issue? such as used the exposed sysfs sequence number
> > > > > for addressing this issue?
> > > > >
> > > > > https://lore.kernel.org/linux-block/YH81n34d2G3C4Re+@gardel-login/#r
> > > >
> > > > If I understand the changes and the background of the fix correctly, I
> > > > think with that fix author is trying to monotonically increase the seq
> > > > number and add it to the disk on every single device map/attach and
> > > > expose it through the sysfs, which will help the userspace processes
> > > > further to correlate events for particular and specific devices that
> > > > reuse the same loop device.
> > > >
> > > > Coming back to my changes:
> > > > I think here with this fix, we are trying to solve a different
> > > > problem. The fix with this patch accepts a cookie or a backend string
> > > > (could be file-path or whatever id userspace choose to provide) from
> > > > userspace at the time of map and stores it in the sysfs
> > > > /sys/block/nbdX/backend path and persists it until unmap is issued on
> > > > the device (meaning that identity stays throughout the life cycle of
> > > > that device, no matter how many detach and attaches happen).
> > >
> > > Your solution needs change from userspace side, so it isn't flexible.
> > >
> > > > If there
> > > > is a detach request in between (not unmap) then on the next attach
> > > > (reconfigure request to reuse the same device) the stored
> > > > cookie/UUID/backend-string will stand as a reference to verify if the
> > > > newly passed backend is matching with the actual backend passed at map
> > > > time to avoid any misconfigurations by accident and to safely proceed
> > > > with attach.
> > >
> > > We can avoid reconfigure if the nbd disk is opened exclusively, such as
> > > mount, please see if the following patch can solve your problem:
> >
> > IMHO, we should almost never allow reconfigure/reattaching a given
> > device with a different backend (except in cases like live migration,
> > which the application should take care of), and not just when nbd disk
> > is opened exclusively.
> >
> > When an attach (reconfigure) is issued, Its application's logic to
> > provide the same matching cookie (or device-string or a uuid) so that
> > kernel can validate it with /sys/block/nbdX/backend and continue
> > safely to attach and reassign the device back.
>
> Your patch looks fine, but only new application can benefit from it, and
> we still need to avoid reconfigure if the disk is opened exclusively for
> old applications. Anyway:

Right applications adopting NBD_ATTR_BACKEND_IDENTIFIER will only get
benefited from these changes.
We could make it strict on the kernel side asking for a cookie but
that will break the existing users.

Here is one good example where we need to allow reconfigure when the
disk is opened exclusively:
Assume your nbd client process (rbd-nbd) is running in a server
container and the application is running in a different
container(which benefits from mount). During server upgrades, we need
to restart the server containers, which means the rbd-nbd process will
also be terminated and later rbd-nbd process need to brought back to
life where it should clam the same device with NBD_CMD_RECONFIGURE,
all this happening while the IO is ongoing on the mount point, in this
cases we need to allow reconfigure even when the disk is opened
exclusively.

Not just the upgrades there are many practical cases where restart of
the server container is done.

>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Many thanks for your review.

BRs,
--
Prasanna

>
>
>
> Thanks,
> Ming
>

