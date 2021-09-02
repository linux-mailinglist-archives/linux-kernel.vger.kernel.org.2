Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA29B3FE740
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 03:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhIBBpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 21:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhIBBpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 21:45:03 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDAFC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 18:44:06 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id e131so675026ybb.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 18:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQ2lr2yLn3EKI9aSELf6uISMHHDFFGiHQ8ZaoohuBFU=;
        b=Ir67N0WUlXiP7R1B6nwCiLZ55eoTDqolx0g+dfi79MFBYlpzc+hr6MqhCvJtmjuCHN
         sUXswRogS9ISAhpXx0mEUWif7Negwyhf0o6zSgN3X6r5NDlkU9nFVqaL29phfi00u02q
         gWVhWRmk/WQONDpI1FAlloPpItRUUOp2IYZxtmfFBcEIqFWno/NJv24+HwUcc/ldiJdP
         beKN++IlBfDVnEATmzB39h8zQPA2/4XuKJ2nTs9bCo2UDurI9wQX1yWqFKxz/XjxYAx1
         GrHT+lRrY+tU4rQp29hnrn/j5xScm9mVVG9On15pCLgQ3a0AmBrJf3QT4ROzW/n99UUz
         mmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQ2lr2yLn3EKI9aSELf6uISMHHDFFGiHQ8ZaoohuBFU=;
        b=BJ9J+5NN78k+Qx0JQM56ru29CEgNDl+YGtnEk5fE9Ga7UHbOE86joGnT9y8X6ljVD7
         CN6WgtFd7BDNNVtHZK9u/iLmCvZMpG+/X9aM3oJ7c4vPt5TevpBtuX9j9BBjhHV/0yjL
         ns+ZGY1DeqWBHAK6EwyVNXU/52n/wuEvYDPcnc05zwy1OISiPdjXIZKYzOxOUZSHO0p1
         wgkTcEan5CMhxt9zRY/VT7qz/5/JPKvhexY75uLLEAlYhio8lOnNmOqtLSdbhqA2vIKh
         HVYWoFtWnRR5lBw52p5wK2JeOpI9QfLBV2jjiZDhPLQqtGNGosfmdhJh1nQm0uI9MmZj
         vtXQ==
X-Gm-Message-State: AOAM531vEP31VpY8+REqDXOvs31qKQUHZFDoalpNcHNAjmG8nasTj2mm
        E4UjIo9o+BapnzT5RSR1k1b1YKe0dayYoNj6AWWazQ==
X-Google-Smtp-Source: ABdhPJywYmEIfPKKMCtfaYKW4weTkTNt4BduRAE4fGLJK8Lm8UBonpwXxVu4c/dAa2RoOqTs0tWz3OY9jBVoU0HJPK0=
X-Received: by 2002:a25:804:: with SMTP id 4mr1059364ybi.346.1630547045363;
 Wed, 01 Sep 2021 18:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210831224510.703253-1-saravanak@google.com> <CAPDyKFpQqKx2UDo4kc3eAxPfp47gOGbjtnm0fg1q+bshpb-vew@mail.gmail.com>
 <CAGETcx8Oc63WXy6VPNQ6uO1JhQpVFgcCYNhSJNbvDp1CD18KQg@mail.gmail.com>
 <CAPDyKFo7Y9NPm1UoKzsRNKZbvoqmCUCVg0UD8dwa5FLb1FOZkQ@mail.gmail.com> <CAGETcx9U2M5i1CAx605fG3Qwm1xwjH2uy4kY4vrAF7YSRSSg+w@mail.gmail.com>
In-Reply-To: <CAGETcx9U2M5i1CAx605fG3Qwm1xwjH2uy4kY4vrAF7YSRSSg+w@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Sep 2021 18:43:29 -0700
Message-ID: <CAGETcx_EeiimxoXcN0Vw_sizeioDnBB8z4bh_3Qj4ac_tL7BRQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: fw_devlink: Don't create device links for
 devices not on a bus
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 5:16 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Sep 1, 2021 at 3:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 1 Sept 2021 at 23:54, Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Wed, Sep 1, 2021 at 8:45 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Wed, 1 Sept 2021 at 00:45, Saravana Kannan <saravanak@google.com> wrote:
> > > > >
> > > > > Devices that are not on a bus will never have a driver bound to it. So,
> > > > > fw_devlink should not create device links for it as it can cause probe
> > > > > issues[1] or sync_state() call back issues[2].
> > > > >
> > > > > [1] - https://lore.kernel.org/lkml/CAGETcx_xJCqOWtwZ9Ee2+0sPGNLM5=F=djtbdYENkAYZa0ynqQ@mail.gmail.com/
> > > > > [2] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > > >
> > > > Unfortunately, this doesn't fix my problem in [2].
> > > >
> > > > When the "soctest" device is initialized, via of_platform_populate(),
> > > > it will be attached to the platform bus, hence the check for the bus
> > > > pointer that you suggest to add below, doesn't have an impact on my
> > > > use case. I still get the below in the log:
> > >
> > > *face palm* Right. I forgot that. I just read "bus" and my mind went
> > > to busses added as devices. It apparently also didn't help [1] which
> > > is surprising to me. I'll dig into that separately. I'll look into
> > > fixing this. The annoying part is that some devices have compatible
> > > property that's both "simple-bus" and some other string that a driver
> > > actually matches with.
> >
> > Yes, that is my view of the problem as well.
> >
> > So perhaps we should do a more fine grained check for when the
> > "simple-bus" compatible is present in the node,
>
> Exactly. Do you want to take a stab at this? There are too many things
> I want to work on, so if you can do this one, that'd be nice.

Nevermind. I already did most of it and it needs a little bit more
massaging. I'll send out a patch later.

-Saravana

>
> > and then don't create
> > a fw_devlink if we reach an ascendant with only this compatible?
>
> And you can achieve that by setting this flag for that DT node:
> fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
>
> -Saravana
