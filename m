Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9F13E1D00
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbhHETw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbhHETw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:52:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E67C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:52:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ca5so11500859pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJmOpEwE9lxeEjSBDZIktawPgAevjn7yO4pdJHSJHNE=;
        b=vuEGFs4GQM/KoJIky8OccECbir3mh2bt8xA1UttsQZWB4BqQBfCwN5YuTUpxOwLHtL
         QShYEYe7XF1f/j0NqYJb7Fuf09UurlM48C1WpCOEJlmwzrxhV00xwg5GVoGyHbzujXXh
         PGQba1GDGo0oQTkQqgp/9nUPoCsS4bdKF7x8WjYlr+1X4E5xzYid025cEwPun9Rz1VGi
         iRTftullhxPJWVvVqlE9irP9OnjGOoL7Zuy3tlpAirmZoYlTVjQ7akyxXLqP8HJiEgAc
         RP2i5BVKDnZYs1pVSABgyF2rsRC8bzRZl0xURqaRj6q7oVfOlCOcTx6zDjM4MRKUXF0f
         Pxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJmOpEwE9lxeEjSBDZIktawPgAevjn7yO4pdJHSJHNE=;
        b=KrjgIGxjDCneRTbE797LdtkRRDPuW5vT4qirmrfSmJd3ulGmAenCU20LUYskqSigaN
         zp54Saow4KwWDaXfpzbofFwKGL09GFLDmEoDQmWFU3eZKWvbNNYPRbVW1J5FdM6uSSRk
         nlrUPti65i/Axc9LjuC4p9rNlgBvekxwVI4ClNIteJFty3k1uYdcUkR7Z2EzyoOdMHw+
         RYVMkOrxlmnSGqR8UfPyefO2wA89b+aQA9SaB4wK2cK4I5MlAl1eDuErGkLUC6Dp6Lak
         p0gPSbNsb5dWk3RefXS+VwhIa5pBqAZXvHbvSYzyabs2B/JLcpy8Xn7yBe0mtXHt1qGU
         6okQ==
X-Gm-Message-State: AOAM5308X9TxRN6s6QJImKFe+Rj0XPfXQZU4sMR3SuOLzPnGLWc5WJHO
        klQsOTpo3R2fVjALnKBeaGvhRJzjsaMN7lxx8Ad89g==
X-Google-Smtp-Source: ABdhPJykpLaKn49AsycfvP9cpaaDTsNQ2/hCbG6nsZZi8ZnboN5frJKZHGCWPDWRhIKqvttVczmTrVNWGKGeYJ+C2+Q=
X-Received: by 2002:a17:902:ab91:b029:12b:8dae:b1ff with SMTP id
 f17-20020a170902ab91b029012b8daeb1ffmr5316523plr.52.1628193161219; Thu, 05
 Aug 2021 12:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <YQuYCePPZEmVbkfc@kroah.com> <YQuZdVuaGG/Cr62y@kroah.com>
 <YQuaJ78y8j1UmBoz@kroah.com> <fdf8b6b6-58c3-8392-2fc6-1908a314e991@linux.intel.com>
 <YQwlHrJBw79xhTSI@kroah.com> <21db8884-5aa1-3971-79ef-f173a0a95bef@linux.intel.com>
 <YQwpa+LAYt7YZ5dh@kroah.com> <7d6751b1-c476-51d3-25c6-b65c0e93d23b@linux.intel.com>
 <YQw4AEwIUGe3RpCx@kroah.com> <CAPcyv4gV9GK93rgtoHxhshzDGk0ueJn0d9LXYitJ8=wJWzmWHg@mail.gmail.com>
 <YQw71hBx4/w14Fir@kroah.com>
In-Reply-To: <YQw71hBx4/w14Fir@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 5 Aug 2021 12:52:30 -0700
Message-ID: <CAPcyv4g1oBU3J3qpd+hDy9cKMYqn0FAsAO4BxxfrNCnpaxzO9g@mail.gmail.com>
Subject: Re: [PATCH v1] driver: base: Add driver filter support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Jonathan ]

On Thu, Aug 5, 2021 at 12:28 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 05, 2021 at 12:18:12PM -0700, Dan Williams wrote:
> > On Thu, Aug 5, 2021 at 12:12 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Aug 05, 2021 at 11:53:52AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> > > > I am not sure how USB and Thunderbolt "authorzied" model works. But I
> > > > don't think it prevents built-in driver probes during kernel boot right?
> > >
> > > Yes it does.
> > >
> > > Again Intel created this framework well over a decade ago for busses
> > > that it deemed that it did not want to "trust" to instantly probe
> > > drivers for and made it part of the Wireless USB specification.
> > >
> > > Then Intel went and added the same framework to Thunderbolt for the same
> > > reason.
> > >
> > > To ignore this work is quite odd, you might want to talk to your
> > > coworkers...
> >
> > Sometimes we need upstream to connect us wayward drones back into the
> > hive mind. Forgive me for not immediately recognizing that the
> > existing 'authorized' mechanisms might be repurposed for this use
> > case.
>
> Not your fault, I'm more amazed that Andi doesn't remember this, he's
> been around longer :)
>

In the driver core? No, not so much, and I do remember it flying by,
just did not connect the dots. In fact, it had just gone upstream when
you and I had that thread about blocking PCI drivers [1], September
2017 vs June 2017 when the Thunderbolt connection manager was merged.
There was no internal review process back then so I failed to
internalize its implications for this TDX filter. You had taken the
time to review it in a way that I had not.

> But the first instinct should not be "let's go add a new feature", but
> rather, "how has this problem been solved by others first" because,
> really, this is not a new issue at all.  You should not rely on just me
> to point out existing kernel features, we do have documentation you
> know...

I have added, "review driver core attribute proposal for duplication
of bus-local capabilities" to my review checklist.

The good news is I think this generic authorization support in the
core may answer one of Jonathan's questions about how to integrate PCI
SPDM/CMA support [2].

[1]: https://lore.kernel.org/lkml/20170928090901.GC12599@kroah.com/
[2]: https://lore.kernel.org/r/20210804161839.3492053-1-Jonathan.Cameron@huawei.com
