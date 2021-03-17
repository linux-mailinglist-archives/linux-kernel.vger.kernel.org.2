Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31DC33F9E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhCQUSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbhCQURr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:17:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2EEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:17:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 16so4750288ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6gJzCwpLyG7+14+e+3YoRVEedOSyoYsJ1d1aSm3u8s=;
        b=Ot1J2LG0SujcfumGfz731vdJqKOxO4S52bTDK4ESl++y2B/qGrQJ3ZdY9Sabt4+qqD
         CzWxpMj1luRIBQBFf/hyxd2opLMAqV+cwP7dETj1336+AfgOqmHKYaS1AhWtahJVwqlU
         gN553b7yWZyHe+SWBQ9bi314J/UcXDnhrU4nma/KHf7eOaDPE89DCmyfYyjlFc58rtjR
         whkrzXuDb3CPlElVyu7jaeUhUnKX65xuboxd3rKb2tS8bX9WpDZFAgettshbfdbaKNHH
         u9gNjJ1sQ7q4evUHcE8LsEtu7/1CyNif50ADrZcWccijWbfuWsO0kK7olDowKVJPpK8j
         RYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6gJzCwpLyG7+14+e+3YoRVEedOSyoYsJ1d1aSm3u8s=;
        b=E8bconJw7AjQtQiymYcR+tkaRDoxOnHlyHZR+dfSR6R8raczgXcPf7lpyw7JGwxkRK
         u+8ZZIWh9ewPfxCjzgf2ei2XJQlGn+APafDK1U+OPKThy/T5jcI8zulBBO/EQbGxexBj
         87aGk3qqGbbReYlPRD5Dqpnbfb+kkzrxfqiViF+p0+h2x1ovw3J0lMbKgyDciwnpylYe
         1hMEzVC8E5ueU3XTEZNy8i9Guw9y0jfARSAFn9b967r1e/RBYOGYpMaieYamGMQrpFtC
         UYuIW4BPs3JsWbNblaPoctaN5i1s8i5JVnydUBiM0JErvyJNPWzdnmJr2fda+XNVp8t3
         2Ygw==
X-Gm-Message-State: AOAM531cgDuY0necgg5qOu2MHuOpYPkbGuwp5rDg3fJ9ZdkbXuF4voJo
        Fx8bfNUzkeLAuIVHdxZigQKsfWs9GMYfiiGvhrK2JQ==
X-Google-Smtp-Source: ABdhPJxm6guJ8ZzFVRuVVjxk9Ag12khXWuNxP2NxaZfEBJIJzMCqUEtP+HDMBvXMUishhGlf43z6gBFdhYMFqXivsG0=
X-Received: by 2002:a2e:b6d4:: with SMTP id m20mr3432836ljo.448.1616012265057;
 Wed, 17 Mar 2021 13:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210316011630.1121213-1-dualli@chromium.org> <20210317180048.inzdursqmnvxkgwp@wittgenstein>
In-Reply-To: <20210317180048.inzdursqmnvxkgwp@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 17 Mar 2021 21:17:18 +0100
Message-ID: <CAG48ez2ATadfuBjZDqjLa-Mzh669F-yDuBzV62aH=OHRt5g4Pg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Binder: Enable App Freezing Capability
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Li Li <dualli@chromium.org>, dualli@google.com,
        Todd Kjos <tkjos@google.com>,
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

On Wed, Mar 17, 2021 at 7:00 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Mon, Mar 15, 2021 at 06:16:27PM -0700, Li Li wrote:
> > To improve the user experience when switching between recently used
> > applications, the background applications which are not currently needed
> > are cached in the memory. Normally, a well designed application will not
> > consume valuable CPU resources in the background. However, it's possible
> > some applications are not able or willing to behave as expected, wasting
> > energy even after being cached.
> >
> > It is a good idea to freeze those applications when they're only being
> > kept alive for the sake of faster startup and energy saving. These kernel
> > patches will provide the necessary infrastructure for user space framework
> > to freeze and thaw a cached process, check the current freezing status and
> > correctly deal with outstanding binder transactions to frozen processes.

I just have some comments on the overall design:

This seems a bit convoluted to me; and I'm not sure whether this is
really something the kernel should get involved in, or whether this
patchset is operating at the right layer.

If there are non-binder threads that are misbehaving, could you
instead stop all those threads in pure userspace code (e.g. by sending
a thread-directed signal to all of them and letting the signal handler
sleep on a futex); and if the binder thread receives a transaction
that should be handled, wake up those threads again?

Or alternatively you could detect that the application is being woken
up frequently even though it's supposed to be idle (e.g. using
information from procfs), and kill it since you consider it to be
misbehaving?

Or if there are specific usage patterns you see frequently that you
consider to be wasting CPU resources (e.g. setting an interval timer
that fires in short intervals), you could try to delay such timers.


With your current approach, you're baking the assumption that all IPC
goes through binder into the kernel API; things like passing a file
descriptor to a pipe through binder or using shared futexes are no
longer usable for cross-process communication without making more
kernel changes. I'm not sure whether that's a good idea. On top of
that, if you freeze a process while it is in the middle of some
operation, resources associated with the operation will probably stay
in use for quite some time; for example, if an app is in the middle of
downloading some data over HTTP, and you freeze it, this may cause the
TCP connection to remain active and consume resources for send/receive
buffers on both the device and the server.
