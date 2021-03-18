Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BC0340B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhCRRLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhCRRLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:11:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE63C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:11:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h10so7565763edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLCs8dK09TUMHOT2NYCns3wokmbDEYXTL43a3XAzuZU=;
        b=Q7xL/lATpE/URL2l6+hU4FoepAXrnehK1BqwYobVfpw+kD5QEnC56VCUzVH2SV85B3
         Wdj+AKu1ZDb4tExOWTj+6t9XUorKu5N6LkMzezFm0PtbWDnU8cqQw6EPHl6PFqouf6O9
         fnqVmRmQqK6Wvg6huVjTPkFXDUrWub33YCflY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLCs8dK09TUMHOT2NYCns3wokmbDEYXTL43a3XAzuZU=;
        b=Jjd51pMaUbYgZ0iCiEdPBB5K/QJIw1ga/oavktLdLvkHUUsYDpH7OP1475cmkzVzh2
         CitfQR5Qp7JOD4WnAAg/Je+xhbwS1R1c1hU0uF6CKkEBNO2krRdp5mPAFF7p8Iyj+m+c
         cPkQsiZiwmKeCKG/3Z2uOL38wsOjiE/UIj11TUh3RP4+NPJtTol5OV7oilM7yCgdwceO
         bZhJWTOnh74XZbwd0Z9aaSZNsTwbqOsaq9xkzRiZkXZbE6pg42mwiShOwNX1jv9S3DWW
         jxGvpZT9b2DwDime/Poz3EUxfA7yvEorDgHkPM+XA/ieoGJL3CtgyDXToP7LJq17pVaJ
         Oesg==
X-Gm-Message-State: AOAM532d0RpN6XIfPEFTK0N+ZO6BOzbjPQRKKLuB8Dq0O9gUxzKhlFor
        zrR7QC3maL04Q7BJiSvk5a1yNbUAO4Q1Aiv1o8RxlQ==
X-Google-Smtp-Source: ABdhPJzZgCdBknX1FiGte14A7JikvzUMkanYdZTRn6D/9Vu4fp44jr53LMMpsl/dQZAW8lXtgjoXPykteRmCn8Y5fuM=
X-Received: by 2002:a05:6402:549:: with SMTP id i9mr5024153edx.379.1616087468724;
 Thu, 18 Mar 2021 10:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210316011630.1121213-1-dualli@chromium.org> <20210317180048.inzdursqmnvxkgwp@wittgenstein>
 <CAG48ez2ATadfuBjZDqjLa-Mzh669F-yDuBzV62aH=OHRt5g4Pg@mail.gmail.com> <CAHRSSEy2UdHHquSGjTYisGyXSVergopxBLh-64j9Nbc9FNie7w@mail.gmail.com>
In-Reply-To: <CAHRSSEy2UdHHquSGjTYisGyXSVergopxBLh-64j9Nbc9FNie7w@mail.gmail.com>
From:   Li Li <dualli@chromium.org>
Date:   Thu, 18 Mar 2021 10:10:57 -0700
Message-ID: <CANBPYPi2b9tr6NAvZKTC138PgPY=WHcAJsRKf++ANiAQck8Www@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Binder: Enable App Freezing Capability
To:     Todd Kjos <tkjos@google.com>
Cc:     Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Li Li <dualli@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 9:20 AM Todd Kjos <tkjos@google.com> wrote:
>
> On Wed, Mar 17, 2021 at 1:17 PM Jann Horn <jannh@google.com> wrote:
> >
> > On Wed, Mar 17, 2021 at 7:00 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > > On Mon, Mar 15, 2021 at 06:16:27PM -0700, Li Li wrote:
> > > > To improve the user experience when switching between recently used
> > > > applications, the background applications which are not currently needed
> > > > are cached in the memory. Normally, a well designed application will not
> > > > consume valuable CPU resources in the background. However, it's possible
> > > > some applications are not able or willing to behave as expected, wasting
> > > > energy even after being cached.
> > > >
> > > > It is a good idea to freeze those applications when they're only being
> > > > kept alive for the sake of faster startup and energy saving. These kernel
> > > > patches will provide the necessary infrastructure for user space framework
> > > > to freeze and thaw a cached process, check the current freezing status and
> > > > correctly deal with outstanding binder transactions to frozen processes.
> >
> > I just have some comments on the overall design:
> >
> > This seems a bit convoluted to me; and I'm not sure whether this is
> > really something the kernel should get involved in, or whether this
> > patchset is operating at the right layer.
>
> The issue is that there is lot's of per-process state in the binder
> driver that needs to be quiesced prior to freezing the process (using
> the standard freeze mechanism of
> Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst). That's all
> this series does... quiesces binder state prior to freeze and then
> re-enable transactions when the process is thawed.
>
> >
> > If there are non-binder threads that are misbehaving, could you
> > instead stop all those threads in pure userspace code (e.g. by sending
> > a thread-directed signal to all of them and letting the signal handler
> > sleep on a futex); and if the binder thread receives a transaction
> > that should be handled, wake up those threads again?
>
> It is not an issue of stopping threads. It's an issue of quiescing
> binder for a process so clients aren't blocked waiting for a response
> from a frozen process that may never handle the transaction. This
> series causes the soon-to-be-frozen process to reject new transactions
> and allows user-space to detect when the transactions have drained
> from the queues prior to freezing the process.
>
> >
> > Or alternatively you could detect that the application is being woken
> > up frequently even though it's supposed to be idle (e.g. using
> > information from procfs), and kill it since you consider it to be
> > misbehaving?
> >
> > Or if there are specific usage patterns you see frequently that you
> > consider to be wasting CPU resources (e.g. setting an interval timer
> > that fires in short intervals), you could try to delay such timers.
> >
> >
> > With your current approach, you're baking the assumption that all IPC
> > goes through binder into the kernel API; things like passing a file
> > descriptor to a pipe through binder or using shared futexes are no
>
> No, we're dealing with an issue that is particular to binder IPC when
> freezing a process. I suspect that other IPC mechanisms do not have
> this issue -- and if any do for Android, then they would need
> equivalent pre-freeze/post-freeze mechanisms. So far in the testing of
> freezing in Android R, there haven't been issues with pipes or futexes
> that required this kind of explicit quiescing (at least none that I
> know of -- dualli@, please comment if there have been these kinds of
> issues).
Correct, currently there's no evidence the similar things should be applied
to other IPC mechanisms. But we'll keep an eye on this.

>
> > longer usable for cross-process communication without making more
> > kernel changes. I'm not sure whether that's a good idea. On top of
> > that, if you freeze a process while it is in the middle of some
> > operation, resources associated with the operation will probably stay
> > in use for quite some time; for example, if an app is in the middle of
> > downloading some data over HTTP, and you freeze it, this may cause the
> > TCP connection to remain active and consume resources for send/receive
> > buffers on both the device and the server.
