Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CB33E0A31
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 00:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhHDWCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 18:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229479AbhHDWCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 18:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628114520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d2KqUld+afo/DqE9+AEtQTsC0qFJZ5g464VDzN5fDCk=;
        b=DznlWIsIohk04aVdpHuasVaWIpn8mGeEI3/N4ONXjaLG+NfnuxbGlM40phnf0Mko7D3CNP
        o7ll2jECSR28U4AqOrVcw24K42YjHxR2OoO9C4tVF+O+dcmP/oNt6jULlZaZpZGtDiileM
        Ea3FcVdOPwapWD7Lw9XhQIUSEFQi3xc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-ovtQRFh_MEaJwMBn1iEjNw-1; Wed, 04 Aug 2021 18:01:59 -0400
X-MC-Unique: ovtQRFh_MEaJwMBn1iEjNw-1
Received: by mail-wr1-f71.google.com with SMTP id d10-20020a056000114ab02901537f048363so1281199wrx.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 15:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2KqUld+afo/DqE9+AEtQTsC0qFJZ5g464VDzN5fDCk=;
        b=g5QlfTb67LmxSBkRgeFIfJzCBpBgConhS0EOJZaPEHNO1/wNxwLvpXAN1zeYG06x0t
         PRaSC4W0hoyw5EGv9mO3ilxCrPYmhsBQyuFOXYqrapFfx8rtbZASm/S5vppild7Qjjwd
         JMrswhedLVM+5bbgU1m831yVtPjAfr5HTCqQ92FXe3juh5pyrEiHuFr/kqIUREpMxXiy
         WdLCHlFTg09jE5bU4RkBbc6fC565RH5+NI7jFbxCHQkTSrxE4jqjsypoNCtc4BBSXEnH
         /5nBVpXvYIlHOS4a1ZXwFnVVs7kaSOTj8dW3gZpepOL2NlG+OY/P/qpT7pF+A2EuEk93
         fm8A==
X-Gm-Message-State: AOAM533aIGL670lkn1yVuElb8rxnFzGhvg3iaoyoGnPJ8GvYgBNNzWwK
        PhphVJRNtt0hha3GT2Ds88/RmbOvZYkYCeStIC2PkIUzzvTrcE57QrK2YR3e3HG65uhzcW5QbhU
        jO7zIdtP2XsgOOGdTHYpSUodODtBQ90nE69GxlnVY
X-Received: by 2002:a05:600c:2241:: with SMTP id a1mr11802093wmm.171.1628114518450;
        Wed, 04 Aug 2021 15:01:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY5/nXWklNR1mjmCS911U1388HsPu+p770sIXPA+rC70wi12iHVm9penxHkIrsLojhFxJ+H/cT1xS0GAj+5BQ=
X-Received: by 2002:a05:600c:2241:: with SMTP id a1mr11802083wmm.171.1628114518302;
 Wed, 04 Aug 2021 15:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0i0WP24Z0TScmPqKxmM2ovtKnmm+qZq6+Tc1ju+hma0w@mail.gmail.com>
 <20210804141049.499767-1-kherbst@redhat.com> <CAK8P3a136c_L3yVn-841Sbfib9UMOf1M-pk+2SqWt0wD2zfRKQ@mail.gmail.com>
 <CACO55tsLpURTm=Jf=4gRVtYQbit5h2OBYw_MFb6Vf1PFvTV7dw@mail.gmail.com>
 <CACO55tuy5Am9zbcR490KWYYAg7MguBN5m82vbjzifGN5KpGbxw@mail.gmail.com> <CAK8P3a3hZ7X5+kM5E+_Y+COUp49Kt6iDjiqMFtimiSbPk4byzQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3hZ7X5+kM5E+_Y+COUp49Kt6iDjiqMFtimiSbPk4byzQ@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 5 Aug 2021 00:01:47 +0200
Message-ID: <CACO55tsj_dgo8NENArCQ_=qcuJoMPg9k-gfkWxZ_8FCQUOTY1A@mail.gmail.com>
Subject: Re: [PATCH] depend on BACKLIGHT_CLASS_DEVICE for more devices
To:     Arnd Bergmann <arnd@kernel.org>
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

On Wed, Aug 4, 2021 at 11:10 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, Aug 4, 2021 at 8:59 PM Karol Herbst <kherbst@redhat.com> wrote:
> > On Wed, Aug 4, 2021 at 4:43 PM Karol Herbst <kherbst@redhat.com> wrote:
> > > On Wed, Aug 4, 2021 at 4:19 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > On Wed, Aug 4, 2021 at 4:10 PM Karol Herbst <kherbst@redhat.com> wrote:
> > > > >
> > > > > playing around a little bit with this, I think the original "select
> > > > > BACKLIGHT_CLASS_DEVICE" is fine. Atm we kind of have this weird mix of
> > > > > drivers selecting and others depending on it. We could of course convert
> > > > > everything over to depend, and break those cycling dependency issues with
> > > > > this.
> > > > >
> > > > > Anyway this change on top of my initial patch is enough to make Kconfig
> > > > > happy and has the advantage of not having to mess with the deps of nouveau
> > > > > too much.
> > > >
> > > > Looks good to me. We'd probably want to make the BACKLIGHT_CLASS_DEVICE
> > > > option itself 'default FB || DRM' though, to ensure that defconfigs
> > > > keep working.
> > > >
> > >
> > > okay cool. Will send out a proper updated patch series soonish.
> > >
> >
> > mhh, actually that breaks drivers selecting FB_BACKLIGHT as now
> > BACKLIGHT_CLASS_DEVICE might be disabled :(
>
> Are you sure? It should already be the case that any driver that selects
> FB_BACKLIGHT either 'depends on BACKLIGHT_CLASS_DEVICE'
> or 'select BACKLIGHT_CLASS_DEVICE'.
>

none of the fb drivers seem to do that.

> If you change all the 'select BACKLIGHT_CLASS_DEVICE' to 'depends
> on', I don't see a problem with doing 'select FB_BACKLIGHT' from
> those.
>
> I have applied your patch to my randconfig tree and built a few dozen
> kernels, don't see any regressions so far, but will let it run over night.
>
>       Arnd
>

