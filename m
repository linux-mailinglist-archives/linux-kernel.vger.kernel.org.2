Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C50A3E09DB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhHDVKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhHDVKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:10:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17ACA60F43
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628111409;
        bh=AR7/8fSFLxcOU7ReweR1RJMUzQ2C6A8WBiBQgmubyxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bstBTAnhv749RIOm/8A++1zEJoVPLjeLJya1QeLgs+5os8XLqTX8NVxd11Jh5ne0X
         25RPg0sHRCshpt2JG73ht7Xyx5dhtErx1V8I9gCVolzqz237y6uQ98P1D4u3g0FnEH
         SnynInM+s3bEItadObYqiqLFG2NHBPRBkZeJYWhW+F5BV7++MeLDhNP+rF+X86XxpF
         aTbuCPg58JahZq3d68NRMmRAd9W2YnbjIVMfIoU5tbkiNR5tQSdrSe1ht84Lr9Z5cl
         3geDZMkh8EWExQ4h3Kl04ZTQUyVWVA3XrMvZJNdyBdMaZiSkIusjDlYx8q+EiUfTyf
         7lV0W67V/+P6g==
Received: by mail-wm1-f45.google.com with SMTP id n11so1969504wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:10:09 -0700 (PDT)
X-Gm-Message-State: AOAM532/wYGvR5hZ+vQXaI4SEVTXsFWt9rlKkM1tHc+rQT9NGglH+eCS
        ZjyynDceM8jCiDJUv3Rd5lgquF6FvL9GU9rYCvA=
X-Google-Smtp-Source: ABdhPJxawV1DUFGq0xf4c1YWGB9f0ICNgrFaDVK4nvjPq8GUrxtQnE1yV12ZR4xxG8yzQp9mNDGQvEuc2xvVrRg4gF8=
X-Received: by 2002:a7b:ce10:: with SMTP id m16mr11140796wmc.75.1628111407639;
 Wed, 04 Aug 2021 14:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0i0WP24Z0TScmPqKxmM2ovtKnmm+qZq6+Tc1ju+hma0w@mail.gmail.com>
 <20210804141049.499767-1-kherbst@redhat.com> <CAK8P3a136c_L3yVn-841Sbfib9UMOf1M-pk+2SqWt0wD2zfRKQ@mail.gmail.com>
 <CACO55tsLpURTm=Jf=4gRVtYQbit5h2OBYw_MFb6Vf1PFvTV7dw@mail.gmail.com> <CACO55tuy5Am9zbcR490KWYYAg7MguBN5m82vbjzifGN5KpGbxw@mail.gmail.com>
In-Reply-To: <CACO55tuy5Am9zbcR490KWYYAg7MguBN5m82vbjzifGN5KpGbxw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 4 Aug 2021 23:09:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3hZ7X5+kM5E+_Y+COUp49Kt6iDjiqMFtimiSbPk4byzQ@mail.gmail.com>
Message-ID: <CAK8P3a3hZ7X5+kM5E+_Y+COUp49Kt6iDjiqMFtimiSbPk4byzQ@mail.gmail.com>
Subject: Re: [PATCH] depend on BACKLIGHT_CLASS_DEVICE for more devices
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 8:59 PM Karol Herbst <kherbst@redhat.com> wrote:
> On Wed, Aug 4, 2021 at 4:43 PM Karol Herbst <kherbst@redhat.com> wrote:
> > On Wed, Aug 4, 2021 at 4:19 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > On Wed, Aug 4, 2021 at 4:10 PM Karol Herbst <kherbst@redhat.com> wrote:
> > > >
> > > > playing around a little bit with this, I think the original "select
> > > > BACKLIGHT_CLASS_DEVICE" is fine. Atm we kind of have this weird mix of
> > > > drivers selecting and others depending on it. We could of course convert
> > > > everything over to depend, and break those cycling dependency issues with
> > > > this.
> > > >
> > > > Anyway this change on top of my initial patch is enough to make Kconfig
> > > > happy and has the advantage of not having to mess with the deps of nouveau
> > > > too much.
> > >
> > > Looks good to me. We'd probably want to make the BACKLIGHT_CLASS_DEVICE
> > > option itself 'default FB || DRM' though, to ensure that defconfigs
> > > keep working.
> > >
> >
> > okay cool. Will send out a proper updated patch series soonish.
> >
>
> mhh, actually that breaks drivers selecting FB_BACKLIGHT as now
> BACKLIGHT_CLASS_DEVICE might be disabled :(

Are you sure? It should already be the case that any driver that selects
FB_BACKLIGHT either 'depends on BACKLIGHT_CLASS_DEVICE'
or 'select BACKLIGHT_CLASS_DEVICE'.

If you change all the 'select BACKLIGHT_CLASS_DEVICE' to 'depends
on', I don't see a problem with doing 'select FB_BACKLIGHT' from
those.

I have applied your patch to my randconfig tree and built a few dozen
kernels, don't see any regressions so far, but will let it run over night.

      Arnd
