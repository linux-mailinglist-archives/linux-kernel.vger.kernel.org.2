Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157B43409FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 17:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhCRQUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhCRQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:20:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12A1C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 09:20:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a198so5493910lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zwcduKzIq4GC5dWLbEFbfl9XtpQWfA9RBswfOwrzJs=;
        b=mWAd0i4enX53awQX65/2aZz8HC7bZwH8n1DlbB5jlkwrfEW7VZYWCtpbMpAbJGj1D+
         6qIQZ74drdiHvVpXThtMC5aCxMASuyIoAnNf53WoVi0EULH2lKzk9/t4H+bNHyuDddaA
         QP5geeBsOOCUYDQJr6XA9tB0vYPJBokm6VjlRSq3ZwCNqTbJciXrkiC0Ed1hLS9XhlWo
         ZngKyPme0GfCHSc0Gq2gPYML5KIyTa7tSyQ+pv+PExjqr/OzIMxiXmGu9Uw0bxL8SLLS
         +SfKPz466EptYLhoIMPwqudw7sVakXktiz3mO28hyfkNuC5Zr1LOjITK9CpwTNCdfttF
         YgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zwcduKzIq4GC5dWLbEFbfl9XtpQWfA9RBswfOwrzJs=;
        b=ulQYDkejMjoIS2y7g4LswRozsPDPeQCP+M/mU8YoxtOLYAFGNZ/kv0gkkUCECcvsqn
         OUv/KsRWQmoqu1HX8kU36NnHhdczXFKxfJTpXqyok1JKH25mFZcurihl8bmh3++yO4s+
         szcXccxi+5xU2WDYDWjWP+G47oexiIhAaS8Rqj2RJZRxHrr2uHRGTr3zb5rjelJKg32d
         R9mbgBhPKwAtwvsxGkPogLt5NaeaImcLQGc01eTqSA7FIJy63kcok+jV7dbs0PVdRzFR
         yxCtNwXEo+u9yt6IG3VQ68Hkxqx7o4X6ifSjRtnakK4E/aT20HJLPSOHMxLHps1SBq3+
         K8jQ==
X-Gm-Message-State: AOAM532BdWarM33vgZgQ3FCHZqwqAh0AS1xD/HcJcUx5WSn5ls7TTiYA
        VQt1AnT63LFPFvgn6Iav1QU4VJZC4iBpOVJ15azOVw==
X-Google-Smtp-Source: ABdhPJzZwRsg9OK5SzAQQtTYoS0oCVD74bvjBEUHhX/hI0SlCbPfITtx0XAlcbM6mR2AqrQG7+ZY/qHsGNJS0naipYE=
X-Received: by 2002:a19:22d6:: with SMTP id i205mr5732721lfi.352.1616084430138;
 Thu, 18 Mar 2021 09:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210316011630.1121213-1-dualli@chromium.org> <20210317180048.inzdursqmnvxkgwp@wittgenstein>
 <CAG48ez2ATadfuBjZDqjLa-Mzh669F-yDuBzV62aH=OHRt5g4Pg@mail.gmail.com>
In-Reply-To: <CAG48ez2ATadfuBjZDqjLa-Mzh669F-yDuBzV62aH=OHRt5g4Pg@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 18 Mar 2021 09:20:17 -0700
Message-ID: <CAHRSSEy2UdHHquSGjTYisGyXSVergopxBLh-64j9Nbc9FNie7w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Binder: Enable App Freezing Capability
To:     Jann Horn <jannh@google.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Li Li <dualli@chromium.org>, Li Li <dualli@google.com>,
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

On Wed, Mar 17, 2021 at 1:17 PM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Mar 17, 2021 at 7:00 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > On Mon, Mar 15, 2021 at 06:16:27PM -0700, Li Li wrote:
> > > To improve the user experience when switching between recently used
> > > applications, the background applications which are not currently needed
> > > are cached in the memory. Normally, a well designed application will not
> > > consume valuable CPU resources in the background. However, it's possible
> > > some applications are not able or willing to behave as expected, wasting
> > > energy even after being cached.
> > >
> > > It is a good idea to freeze those applications when they're only being
> > > kept alive for the sake of faster startup and energy saving. These kernel
> > > patches will provide the necessary infrastructure for user space framework
> > > to freeze and thaw a cached process, check the current freezing status and
> > > correctly deal with outstanding binder transactions to frozen processes.
>
> I just have some comments on the overall design:
>
> This seems a bit convoluted to me; and I'm not sure whether this is
> really something the kernel should get involved in, or whether this
> patchset is operating at the right layer.

The issue is that there is lot's of per-process state in the binder
driver that needs to be quiesced prior to freezing the process (using
the standard freeze mechanism of
Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst). That's all
this series does... quiesces binder state prior to freeze and then
re-enable transactions when the process is thawed.

>
> If there are non-binder threads that are misbehaving, could you
> instead stop all those threads in pure userspace code (e.g. by sending
> a thread-directed signal to all of them and letting the signal handler
> sleep on a futex); and if the binder thread receives a transaction
> that should be handled, wake up those threads again?

It is not an issue of stopping threads. It's an issue of quiescing
binder for a process so clients aren't blocked waiting for a response
from a frozen process that may never handle the transaction. This
series causes the soon-to-be-frozen process to reject new transactions
and allows user-space to detect when the transactions have drained
from the queues prior to freezing the process.

>
> Or alternatively you could detect that the application is being woken
> up frequently even though it's supposed to be idle (e.g. using
> information from procfs), and kill it since you consider it to be
> misbehaving?
>
> Or if there are specific usage patterns you see frequently that you
> consider to be wasting CPU resources (e.g. setting an interval timer
> that fires in short intervals), you could try to delay such timers.
>
>
> With your current approach, you're baking the assumption that all IPC
> goes through binder into the kernel API; things like passing a file
> descriptor to a pipe through binder or using shared futexes are no

No, we're dealing with an issue that is particular to binder IPC when
freezing a process. I suspect that other IPC mechanisms do not have
this issue -- and if any do for Android, then they would need
equivalent pre-freeze/post-freeze mechanisms. So far in the testing of
freezing in Android R, there haven't been issues with pipes or futexes
that required this kind of explicit quiescing (at least none that I
know of -- dualli@, please comment if there have been these kinds of
issues).

> longer usable for cross-process communication without making more
> kernel changes. I'm not sure whether that's a good idea. On top of
> that, if you freeze a process while it is in the middle of some
> operation, resources associated with the operation will probably stay
> in use for quite some time; for example, if an app is in the middle of
> downloading some data over HTTP, and you freeze it, this may cause the
> TCP connection to remain active and consume resources for send/receive
> buffers on both the device and the server.
