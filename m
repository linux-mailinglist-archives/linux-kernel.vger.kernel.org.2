Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DBF31D430
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 04:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBQDO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 22:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBQDO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 22:14:57 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9017AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 19:14:16 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id k4so12468239ybp.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 19:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aKz1fqKBuerBSHv+tvE/Zsr3uM0/879qeLbFEOzIH0=;
        b=Jbl5enkDuGWTiydyPw2PmlCS0Xcgu9KPuSWtV8A+zjdZVkFVjeOmZjxAIu4hfBWjl3
         wlnWyCE7nx4OnQk3MkSZMjZI4AsGJCgQ2VWXcvC0VKgsEK/K0NP+sK8YgcZylGOmipeA
         Lo5oIH5bG990X3qMYBDtr4992vYY+3+pubExAm9H7Ub3586U18a8RBZNuBqTMHCF4p+d
         k9YbexY+xaXvbN7ZZ1fl86m5gWStzeSGKN1YC5NaB4TebFHe41UdIXUbEmZHuKT6yn9l
         /A/JqkSTq7XaUC/38ytW2yW70txtjA5triLGrVsWlkQeKS6MoCugmYYLu0m5cXIsUVhV
         eySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aKz1fqKBuerBSHv+tvE/Zsr3uM0/879qeLbFEOzIH0=;
        b=drVhLx5NEAZiX6nu81GxdT8jLoW2FziA+HOJP417dUVT5x2BlLg0kpWVyC0XA8xdKV
         VYQqsyKVqyVOpC5GBdE6TknA5TQLO0MeOwazR9R4rzKBeJgwuZFQx6/HaWckZaCTatB+
         scRE9SkUOXKAr4NxzjxHVWcpobRNZkYSaGW5J+njC4EXGOwAErUafOQeM9LIu6ErZnqF
         /J0/le2g42SGcFvcIPMRfbHNB1gSb+i4q4gTP/jB1nLkb+DIhotsTFQuihc59puF3SOz
         4rVOrlRH6oTuxV4MNEPA65ip4eYd5ufx/ynvRZ9eY5sCLrXweEPXBE0VXHYXTCk+pFre
         53Tg==
X-Gm-Message-State: AOAM531hsw/YpH4HZMLYpNoLEtJ2/RBzOnYZ8SL3GTSHsJ1z7B/PJCIS
        VpjnrlwWrAhCNB4HRCn8YsUkfj84CA7F5sDkoXMJcw==
X-Google-Smtp-Source: ABdhPJz645niIfjT6H88y8rbgnUoXP0v1ldL6AW17rZaHZCXVgWm93zO3zC+zRfk+5nw/RJZ6asHKGzOYRVljwqYjGg=
X-Received: by 2002:a25:3345:: with SMTP id z66mr34021484ybz.466.1613531655676;
 Tue, 16 Feb 2021 19:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
 <20201218031703.3053753-6-saravanak@google.com> <20210210055430.GA73123@roeck-us.net>
 <CAGETcx-UaYEeYVXg0sd4=9t2zbBe8YH1LOoOms9ANGix=Zmypw@mail.gmail.com>
 <33f643b9-9f6d-e59a-64e7-2d2b7d3e71a4@roeck-us.net> <CAGETcx8QRDo2t==Ng2Cvs_+ZXXnM2SjMzo+A1b78XXAj1iYKSw@mail.gmail.com>
 <db598d8c-cf59-8478-2248-2ad2ab065c37@roeck-us.net> <CAGETcx-fQWJUyDS9HbHzBpb-1dSNX1B7jqOF9696D0rZXnBHFQ@mail.gmail.com>
 <20210217030543.GA189612@roeck-us.net>
In-Reply-To: <20210217030543.GA189612@roeck-us.net>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Feb 2021 19:13:39 -0800
Message-ID: <CAGETcx-qgieP7MikNdP_=2bXnf0OKOc2LZb6vwpnmRA08w6XNA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] driver core: Set fw_devlink=on by default
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 7:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Feb 16, 2021 at 06:39:55PM -0800, Saravana Kannan wrote:
> > On Wed, Feb 10, 2021 at 1:21 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On 2/10/21 12:52 PM, Saravana Kannan wrote:
> > > > On Wed, Feb 10, 2021 at 7:10 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >>
> > > >> On 2/10/21 12:20 AM, Saravana Kannan wrote:
> > > >>> On Tue, Feb 9, 2021 at 9:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >>>>
> > > >>>> On Thu, Dec 17, 2020 at 07:17:03PM -0800, Saravana Kannan wrote:
> > > >>>>> Cyclic dependencies in some firmware was one of the last remaining
> > > >>>>> reasons fw_devlink=on couldn't be set by default. Now that cyclic
> > > >>>>> dependencies don't block probing, set fw_devlink=on by default.
> > > >>>>>
> > > >>>>> Setting fw_devlink=on by default brings a bunch of benefits (currently,
> > > >>>>> only for systems with device tree firmware):
> > > >>>>> * Significantly cuts down deferred probes.
> > > >>>>> * Device probe is effectively attempted in graph order.
> > > >>>>> * Makes it much easier to load drivers as modules without having to
> > > >>>>>   worry about functional dependencies between modules (depmod is still
> > > >>>>>   needed for symbol dependencies).
> > > >>>>>
> > > >>>>> If this patch prevents some devices from probing, it's very likely due
> > > >>>>> to the system having one or more device drivers that "probe"/set up a
> > > >>>>> device (DT node with compatible property) without creating a struct
> > > >>>>> device for it.  If we hit such cases, the device drivers need to be
> > > >>>>> fixed so that they populate struct devices and probe them like normal
> > > >>>>> device drivers so that the driver core is aware of the devices and their
> > > >>>>> status. See [1] for an example of such a case.
> > > >>>>>
> > > >>>>> [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
> > > >>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > >>>>
> > > >>>> This patch breaks nios2 boot tests in qemu. The system gets stuck when
> > > >>>> trying to reboot. Reverting this patch fixes the problem. Bisect log
> > > >>>> is attached.
> > > >>>
> > > >>> Thanks for the report Guenter. Can you please try this series?
> > > >>> https://lore.kernel.org/lkml/20210205222644.2357303-1-saravanak@google.com/
> > > >>>
> > > >>
> > > >> Not this week. I have lots of reviews to complete before the end of the week,
> > > >> with the 5.12 commit window coming up.
> > > >
> > > > Ok. By next week, all the fixes should be in linux-next too. So it
> > > > should be easier if you choose to test.
> > > >
> > > >> Given the number of problems observed, I personally think that it is way
> > > >> too early for this patch. We'll have no end of problems if it is applied
> > > >> to the upstream kernel in the next commit window. Of course, that is just
> > > >> my personal opinion.
> > > >
> > > > You had said "with 115 of 430 boot tests failing in -next" earlier.
> > > > Just to be sure I understand it right, you are not saying this patch
> > > > caused them all right? You are just saying that 115 general boot
> > > > failures that might mask fw_devlink issues in some of them, right?
> > > >
> > >
> > > Correct.
> >
> > Is it right to assume [1] fixed all known boot issues due to fw_devlink=on?
> > [1] - https://lore.kernel.org/lkml/20210215224258.1231449-1-saravanak@google.com/
> >
>
> I honestly don't know. Current status of -next in my tests is:
>
> Build results:
>         total: 149 pass: 144 fail: 5
> Qemu test results:
>         total: 432 pass: 371 fail: 61
>
> This is for next-20210216. Newly introduced failures keep popping up. Some
> of the failures have been persistent for weeks, so it is all but impossible
> to say if affected platforms experience more than one failure.
>
> Also, please keep in mind that my boot tests are very shallow, along the
> line of "it boots, therefore it works". It only tests hardware which is
> emulated by qemu and is needed for booting. It tests probably much less
> than 1% of driver code. It can and should not be used for any useful
> fw_devlink related test coverage.

Agreed. I'm not using this for fw_devlink=on test coverage. Just
checking to make sure I've addressed any issues you've seen.

FYI, you can change it at runtime using the kernel commandline param
fw_devlink=permissive. So, you don't have to build all these kernels
again to test if fw_devlink=on is making things worse.

-Saravana
