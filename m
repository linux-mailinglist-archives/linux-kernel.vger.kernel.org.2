Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2B93E0E8D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 08:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhHEGvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 02:51:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231418AbhHEGvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 02:51:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6B6960F41
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 06:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628146258;
        bh=qMsPpqQgFUPSSPnZfZavNoLnNsZYb+hVgAtPZNQBy5w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ObhBf+NN4GqwQxNx/Lx+8AMAwuGlEvoXaj2dr50XEIYqzYy/HZE2xI7CL2r/XBdRm
         h7Jl0yGq7YppbC5Qi+io0LfpKg8+sqkjPa7VgkgDzQj7MZ8Za/g84FRPLsS/geIrib
         XeHHxL9J9xr5FwusDdEI8d630JA5vK4xwDEB/ag73EcJ8nyoA5iocv71E6axsMyg03
         MQJsYEqpOGmzbPpV4barhyJ1DNTVMGbVfR76rJJ/glh7MLH4aQwApNRc3MqRkjAboQ
         UO7cggith/pKaisdmkMHzNieFdV7GQLpIG3V5j64ROArAcaNQjL0LWYWAPOA436KVE
         lr78sf0ffppPw==
Received: by mail-wr1-f44.google.com with SMTP id p5so5076257wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 23:50:58 -0700 (PDT)
X-Gm-Message-State: AOAM533mvrVpQ8XuUCJ4BJBd/Iw/y7IjxVfgXHIWvO5iYprt+/3ORBEY
        /ZIuHUaHwTopmioowzJd4noLCE0apWHS7jqUGwA=
X-Google-Smtp-Source: ABdhPJznMWhOISmuIYDXrWpGkt4y1m+fqzTgxmRqDkmkTEHJHsPKR7IHYLL2Gk1DFScHpZ5gzgXyDTyRE3rrOBfVhqs=
X-Received: by 2002:adf:f7c5:: with SMTP id a5mr3290312wrq.99.1628146257464;
 Wed, 04 Aug 2021 23:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0i0WP24Z0TScmPqKxmM2ovtKnmm+qZq6+Tc1ju+hma0w@mail.gmail.com>
 <20210804141049.499767-1-kherbst@redhat.com> <CAK8P3a136c_L3yVn-841Sbfib9UMOf1M-pk+2SqWt0wD2zfRKQ@mail.gmail.com>
 <CACO55tsLpURTm=Jf=4gRVtYQbit5h2OBYw_MFb6Vf1PFvTV7dw@mail.gmail.com>
 <CACO55tuy5Am9zbcR490KWYYAg7MguBN5m82vbjzifGN5KpGbxw@mail.gmail.com>
 <CAK8P3a3hZ7X5+kM5E+_Y+COUp49Kt6iDjiqMFtimiSbPk4byzQ@mail.gmail.com> <CACO55tsj_dgo8NENArCQ_=qcuJoMPg9k-gfkWxZ_8FCQUOTY1A@mail.gmail.com>
In-Reply-To: <CACO55tsj_dgo8NENArCQ_=qcuJoMPg9k-gfkWxZ_8FCQUOTY1A@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 5 Aug 2021 08:50:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1rAr0BH6cNLkhES+81x2hWW31RTLZkHLDJYK-r8+x6Gg@mail.gmail.com>
Message-ID: <CAK8P3a1rAr0BH6cNLkhES+81x2hWW31RTLZkHLDJYK-r8+x6Gg@mail.gmail.com>
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

On Thu, Aug 5, 2021 at 12:01 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Wed, Aug 4, 2021 at 11:10 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Wed, Aug 4, 2021 at 8:59 PM Karol Herbst <kherbst@redhat.com> wrote:
> > > On Wed, Aug 4, 2021 at 4:43 PM Karol Herbst <kherbst@redhat.com> wrote:
> > > > On Wed, Aug 4, 2021 at 4:19 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > > On Wed, Aug 4, 2021 at 4:10 PM Karol Herbst <kherbst@redhat.com> wrote:
> > > > > >
> > > > > > playing around a little bit with this, I think the original "select
> > > > > > BACKLIGHT_CLASS_DEVICE" is fine. Atm we kind of have this weird mix of
> > > > > > drivers selecting and others depending on it. We could of course convert
> > > > > > everything over to depend, and break those cycling dependency issues with
> > > > > > this.
> > > > > >
> > > > > > Anyway this change on top of my initial patch is enough to make Kconfig
> > > > > > happy and has the advantage of not having to mess with the deps of nouveau
> > > > > > too much.
> > > > >
> > > > > Looks good to me. We'd probably want to make the BACKLIGHT_CLASS_DEVICE
> > > > > option itself 'default FB || DRM' though, to ensure that defconfigs
> > > > > keep working.
> > > > >
> > > >
> > > > okay cool. Will send out a proper updated patch series soonish.
> > > >
> > >
> > > mhh, actually that breaks drivers selecting FB_BACKLIGHT as now
> > > BACKLIGHT_CLASS_DEVICE might be disabled :(
> >
> > Are you sure? It should already be the case that any driver that selects
> > FB_BACKLIGHT either 'depends on BACKLIGHT_CLASS_DEVICE'
> > or 'select BACKLIGHT_CLASS_DEVICE'.
> >
> none of the fb drivers seem to do that.

Ah, right, I see now that my randconfig series has a couple of patches
applied that deal with other random failures, including this one:

https://patchwork.kernel.org/project/linux-fbdev/patch/20200417155553.675905-8-arnd@arndb.de/

Part of the series went in (through different ways) now, but this one
never did.

      Arnd
