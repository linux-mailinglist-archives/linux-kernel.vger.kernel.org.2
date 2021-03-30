Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3038134F162
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 21:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhC3TAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 15:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhC3TAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 15:00:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADF7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 12:00:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e7so19406933edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySqH0GZxajP8KrZ+n0xkhdcfDVlDyNCl1jidh+ITquU=;
        b=RW21Rwlm4SZq0A71YieJ7UGN5BUyQuxa8BQ+EI8CySUWq2GuztQ7yDNEFaOwQOULxF
         Avj1P5K1FBw+RfBSBZTGb4gg3fC2Tq1m1rH4Di9wgs6LuOJc3lWf3JZYvU25a/VLBJzA
         qjcvNRAUuLo7ygxkbGPzP1t6o4QuzGIKu9ki0paA2hVYabwDcpW3pwvGqpbk7x7rGEbj
         W/BXgfZAYAqmc2/O05yO8D/UEprzvBw3cZ/Afjl0C8/T2aP44v3kupO5wxeBUgeC2jxc
         wVgCygnrYu1ixk6kMujZoLtq9V6ZN95EUuBxtalzByPJ0QIEAuXzmmPsULlaSqUbISEC
         y/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySqH0GZxajP8KrZ+n0xkhdcfDVlDyNCl1jidh+ITquU=;
        b=G78wlAF5iDa4CtsMo52KQt+jnsSWE+5yTGGOkLblYwx7Wo/5XUwPGs/h0WwNXNiUSQ
         dhel5MlDrR5z4AEmW/HiNiJ+VZnBIvlz3WyH4zeNg8B0rgkAvw196mUBaxUydOpqCwJN
         NDW/Ix5IfPmI5UfYen6eZPaQITTG1PaQOZlKK10EOPHZyA8tNUjWhS2NpYSu7E6YGA6y
         Z7W7ZqYk+oI9qtgYlnvDLqa9YwNGSIrIKfOndbg1MB07HF9n0nJTE9EDSqcTa7RQfd59
         ZA+jJbcS+WBUPoWRQKcvEzfrVb3MewcVsUtobXdrkHL7+YGprLOFuRvaiRpe2aY+5uz3
         +MAQ==
X-Gm-Message-State: AOAM530qhSNXUn4k8jsJk+GhL7SB9d2F25kqCzvXXRAJ0lME/tGRQQXC
        tQnZy7q52S1jRZNQKsKUbuugVXrhiCgpuqILjttfO6qREZ3+JQ==
X-Google-Smtp-Source: ABdhPJy4OBG59iCDYL7xATyHi5xULCWzYjz0hSNLm4DQ3DFUtKNhhTC8O6ZcDlWYCwKCNa2AmMKNVa0BOFoHs2aEp9M=
X-Received: by 2002:a50:82c5:: with SMTP id 63mr34857756edg.97.1617130833296;
 Tue, 30 Mar 2021 12:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210330111620.GK2356281@nvidia.com> <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
 <20210330154712.GR2356281@nvidia.com> <CAPcyv4hL-B=1hostoj9t6EE5impmcDR2-wsgahvBKdzL9LbqLg@mail.gmail.com>
 <20210330170253.GU2356281@nvidia.com> <CAPcyv4ixD=+PejHErT_FLtEyXsm4mk+93R7mQ0uFtd_kd-fs1w@mail.gmail.com>
 <20210330175431.GX2356281@nvidia.com>
In-Reply-To: <20210330175431.GX2356281@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Mar 2021 12:00:23 -0700
Message-ID: <CAPcyv4igMvwfZNgi-Uap_QUJi+uocMUD3KZBhXUy56AuHZQtqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 10:54 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Mar 30, 2021 at 10:31:15AM -0700, Dan Williams wrote:
> > On Tue, Mar 30, 2021 at 10:03 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Tue, Mar 30, 2021 at 09:05:29AM -0700, Dan Williams wrote:
> > >
> > > > > If you can't clearly point to the *data* under RCU protection it is
> > > > > being used wrong.
> > > >
> > > > Agree.
> > > >
> > > > The data being protected is the value of
> > > > dev->kobj.state_in_sysfs. The
> > >
> > > So where is that read under:
> > >
> > > +       idx = srcu_read_lock(&cxl_memdev_srcu);
> > > +       rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
> > > +       srcu_read_unlock(&cxl_memdev_srcu, idx);
> > >
> > > ?
> >
> > device_is_registered() inside __cxl_memdev_ioctl().
>
> Oh, I see, I missed that
>
> > > It can't read the RCU protected data outside the RCU critical region,
> > > and it can't read/write RCU protected data without using the helper
> > > macros which insert the required barriers.
> >
> > The required barriers are there. srcu_read_lock() +
> > device_is_registered() is paired with cdev_device_del() +
> > synchronize_rcu().
>
> RCU needs barriers on the actual load/store just a naked
> device_is_registered() alone is not strong enough.
>
> > > IMHO this can't use 'dev->kobj.state_in_sysfs' as the RCU protected data.
> >
> > This usage of srcu is functionally equivalent to replacing
> > srcu_read_lock() with down_read() and the shutdown path with:
>
> Sort of, but the rules for load/store under RCU are different than for
> load/store under a normal barriered lock. All the data is unstable for
> instance and minimially needs READ_ONCE.

The data is unstable under the srcu_read_lock until the end of the
next rcu grace period, synchronize_rcu() ensures all active
srcu_read_lock() sections have completed. Unless Paul and I
misunderstood each other, this scheme of synchronizing object state is
also used in kill_dax(), and I put that comment there the last time
this question was raised. If srcu was being used to synchronize the
liveness of an rcu object like @cxlm or a new ops object then I would
expect rcu_dereference + rcu_assign_pointer around usages of that
object. The liveness of the object in this case is handled by kobject
reference, or inode reference in the case of kill_dax() outside of
srcu.

>
> > cdev_device_del(...);
> > down_write(...):
> > up_write(...);
>
> The lock would have to enclose the store to state_in_sysfs, otherwise
> as written it has the same data race problems.

There's no race above. The rule is that any possible observation of
->state_in_sysfs == 1, or rcu_dereference() != NULL, must be flushed.
After that value transitions to zero, or the rcu object is marked for
deletion, an rcu grace period is needed before that memory can be
freed. If an rwsem is used the only requirement is that any read-side
sections that might have observed ->state_in_sysfs == 1 have ended
which is why the down_write() / up_write() does not need to surround
the cdev_device_del(). It's sufficient to flush the read side after
the state is known to have changed. There are several examples of
rwsem being used as a barrier like this:

drivers/mtd/ubi/wl.c:1432:      down_write(&ubi->work_sem);
drivers/mtd/ubi/wl.c-1433-      up_write(&ubi->work_sem);

drivers/scsi/cxlflash/main.c:2229:      down_write(&cfg->ioctl_rwsem);
drivers/scsi/cxlflash/main.c-2230-      up_write(&cfg->ioctl_rwsem);

fs/btrfs/block-group.c:355:     down_write(&space_info->groups_sem);
fs/btrfs/block-group.c-356-     up_write(&space_info->groups_sem);

fs/btrfs/disk-io.c:4189:        down_write(&fs_info->cleanup_work_sem);
fs/btrfs/disk-io.c-4190-        up_write(&fs_info->cleanup_work_sem);

net/core/net_namespace.c:629:   down_write(&pernet_ops_rwsem);
net/core/net_namespace.c-630-   up_write(&pernet_ops_rwsem);
