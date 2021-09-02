Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CB93FE676
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbhIBASd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 20:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239574AbhIBASc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 20:18:32 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268A7C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 17:17:34 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id q70so336935ybg.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 17:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FevjD/FVxAD6pFl9drCNLdP4ezd25swvvRq2QRQxtfg=;
        b=g0HiYc7MOgM8VXdmjyYYlj8HB++u2sBVdIQ1BvwkAsVA1HzxL++Ckxb5uk/a7dz5jH
         b4bJNQnkx20Ni5ZugABRsdZgyIbTi0gcG4ZZZ6N0nWMZUN4xrBknVuplOJbT/dW/P5Rs
         e1CKKQmG7v7da9KHhodzzYY7l/P9D3s5nX2VU2UZKEg2RyzkpAMFvtelzUdr8cX/AWGm
         dpq/7xlEcbycODKmfibDJRyWprTi+CpxecY86rFHpg1ZmP3rTYcNI2/xEcad/gatLeRu
         OWlnovywK/UGPA/LANugHlnQyt5A0rBdJlH9YEnUWppStlvGtPJsVNjEuPEsuhnFH0+y
         ApDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FevjD/FVxAD6pFl9drCNLdP4ezd25swvvRq2QRQxtfg=;
        b=qmCwSqZI0usn/FxFYaUlUuT+BDECI2USyb7tFu3ROv0PGlTTOay0lsKW8vF4bvuV8b
         hYavEa97JeC2T55vUaaVSp2ebCBneU7fsmmw/yH9ZkDXpTcsZggQpdi6BTPNMLXluvkx
         s52YyqWi+JtdPp5olLpWcoWiy/7gzZ70tD9yOjUNhKA4LZaRlBvcpvWFu32k/tjMInG7
         QGvv+pcRfeeIQJm5Dm7DsUpjEEO9MIsi9XXyNhKrTn+H5DrbcTHBIejxaG6jgKkTqhrl
         HgNrsg0/4s53qZDIIkHxIOZRIGCIAdTXn5BIQ1XUwOk7UbQW3XGKzcpW2Oxt/DXt/qFS
         Wjdw==
X-Gm-Message-State: AOAM5300bvZbupsFygqWhUgNk9IyixEH3aVcrjwQxN6bf4MvBOlBHKzT
        76vt9LCc27ewtXy9gxw22cvlMa3scV0f4qYh1KXxiQ==
X-Google-Smtp-Source: ABdhPJxGBWe3qLmw/3Y2M4lqy82fWwyIYRuK6cCACyljHenD/H6KFvsBKYo3pJMxDG04DaDjbBwqMNxsqSwRN3BhAIs=
X-Received: by 2002:a25:81ce:: with SMTP id n14mr819417ybm.32.1630541853220;
 Wed, 01 Sep 2021 17:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210831224510.703253-1-saravanak@google.com> <CAPDyKFpQqKx2UDo4kc3eAxPfp47gOGbjtnm0fg1q+bshpb-vew@mail.gmail.com>
 <CAGETcx8Oc63WXy6VPNQ6uO1JhQpVFgcCYNhSJNbvDp1CD18KQg@mail.gmail.com> <CAPDyKFo7Y9NPm1UoKzsRNKZbvoqmCUCVg0UD8dwa5FLb1FOZkQ@mail.gmail.com>
In-Reply-To: <CAPDyKFo7Y9NPm1UoKzsRNKZbvoqmCUCVg0UD8dwa5FLb1FOZkQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Sep 2021 17:16:57 -0700
Message-ID: <CAGETcx9U2M5i1CAx605fG3Qwm1xwjH2uy4kY4vrAF7YSRSSg+w@mail.gmail.com>
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

On Wed, Sep 1, 2021 at 3:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 1 Sept 2021 at 23:54, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Wed, Sep 1, 2021 at 8:45 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 1 Sept 2021 at 00:45, Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > Devices that are not on a bus will never have a driver bound to it. So,
> > > > fw_devlink should not create device links for it as it can cause probe
> > > > issues[1] or sync_state() call back issues[2].
> > > >
> > > > [1] - https://lore.kernel.org/lkml/CAGETcx_xJCqOWtwZ9Ee2+0sPGNLM5=F=djtbdYENkAYZa0ynqQ@mail.gmail.com/
> > > > [2] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > >
> > > Unfortunately, this doesn't fix my problem in [2].
> > >
> > > When the "soctest" device is initialized, via of_platform_populate(),
> > > it will be attached to the platform bus, hence the check for the bus
> > > pointer that you suggest to add below, doesn't have an impact on my
> > > use case. I still get the below in the log:
> >
> > *face palm* Right. I forgot that. I just read "bus" and my mind went
> > to busses added as devices. It apparently also didn't help [1] which
> > is surprising to me. I'll dig into that separately. I'll look into
> > fixing this. The annoying part is that some devices have compatible
> > property that's both "simple-bus" and some other string that a driver
> > actually matches with.
>
> Yes, that is my view of the problem as well.
>
> So perhaps we should do a more fine grained check for when the
> "simple-bus" compatible is present in the node,

Exactly. Do you want to take a stab at this? There are too many things
I want to work on, so if you can do this one, that'd be nice.

> and then don't create
> a fw_devlink if we reach an ascendant with only this compatible?

And you can achieve that by setting this flag for that DT node:
fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;

-Saravana
