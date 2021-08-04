Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521173E0396
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbhHDOnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238314AbhHDOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628088213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFYUSa3dRghMYe581f3uqD6OPPYe5RTO9O4Oxh6XB5I=;
        b=SdL1aHBKgTm6gcbnxkeRkIOKlJmEetcQudRSgQrLcXM4j2155L0/lL/giPTBmJanc65B2w
        1ctFBRCWehsOXTapBIPCxqrDa73ZD8w2IG7IIlfECAGC3zkLs1fTU1Tgw9/74/T9hPe4Ut
        DpvoHqEzcTbuy8tp0GhnWjIkn6s+Yuo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-gwb65xhTOgipaQVyzJdJkw-1; Wed, 04 Aug 2021 10:43:31 -0400
X-MC-Unique: gwb65xhTOgipaQVyzJdJkw-1
Received: by mail-wm1-f70.google.com with SMTP id a197-20020a1c98ce0000b029025831695a2eso362891wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 07:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFYUSa3dRghMYe581f3uqD6OPPYe5RTO9O4Oxh6XB5I=;
        b=ICRqKPbyC5y9Xz7qPMZ82QAGj9QRxMPQ/wWKUD0MTYbqKqMou+j5Pe+PNX7K4/WrTo
         qmfxvJzso2L99syKGc6XD+EjQkHQhhUSLAb690eTOVcGlqYSpWpe+XbsFvN/5nkxqAlg
         +d5g8mp0Re217KAZGKDLFxGJZBR0cARkMAaS9Q39p2oMJIt9pKk/9wtFj+mYVWTEHg6w
         wcHmCy4WQPJMGEWNQPzHepEdcCnPMfKMuT6i7qPb4CBWydVulPEVOl6D2P0lYerRsQri
         l/dxOJFe43OUdPWnkbY7WPY601xawedprPIdJ+bgl0xLyK9crg15dp7OuYa0nU5c/HzP
         PWyA==
X-Gm-Message-State: AOAM530oRaU/nUSzhW8EVUin6TgVytCIzhf3zgQ+UsShRkdVc21xXGxN
        /h5eOL7sewc9G+nsT6vUV2k4CNL1U9sK9km+lsQXO4t79Uiw3bhSVuBYYBzFMXEnJOF8vgbhMwa
        5aRG86dVi/k5aRzwaBoo24S80Kx83jD1LRYjB1qhq
X-Received: by 2002:a05:600c:2241:: with SMTP id a1mr10229059wmm.171.1628088210717;
        Wed, 04 Aug 2021 07:43:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwKeR2z5x/HL0NvZb68pP377KTS2HGMKbAH8tOqgYY8tWUV+n8t4legpd8joDAklG+ZHncu46UdSv0kNWBp5Q=
X-Received: by 2002:a05:600c:2241:: with SMTP id a1mr10229050wmm.171.1628088210589;
 Wed, 04 Aug 2021 07:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0i0WP24Z0TScmPqKxmM2ovtKnmm+qZq6+Tc1ju+hma0w@mail.gmail.com>
 <20210804141049.499767-1-kherbst@redhat.com> <CAK8P3a136c_L3yVn-841Sbfib9UMOf1M-pk+2SqWt0wD2zfRKQ@mail.gmail.com>
In-Reply-To: <CAK8P3a136c_L3yVn-841Sbfib9UMOf1M-pk+2SqWt0wD2zfRKQ@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 4 Aug 2021 16:43:19 +0200
Message-ID: <CACO55tsLpURTm=Jf=4gRVtYQbit5h2OBYw_MFb6Vf1PFvTV7dw@mail.gmail.com>
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

On Wed, Aug 4, 2021 at 4:19 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, Aug 4, 2021 at 4:10 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > playing around a little bit with this, I think the original "select
> > BACKLIGHT_CLASS_DEVICE" is fine. Atm we kind of have this weird mix of
> > drivers selecting and others depending on it. We could of course convert
> > everything over to depend, and break those cycling dependency issues with
> > this.
> >
> > Anyway this change on top of my initial patch is enough to make Kconfig
> > happy and has the advantage of not having to mess with the deps of nouveau
> > too much.
>
> Looks good to me. We'd probably want to make the BACKLIGHT_CLASS_DEVICE
> option itself 'default FB || DRM' though, to ensure that defconfigs
> keep working.
>

okay cool. Will send out a proper updated patch series soonish.

>       Arnd
>

