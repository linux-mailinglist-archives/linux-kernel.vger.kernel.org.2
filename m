Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6967E3E086B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbhHDTAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237903AbhHDTAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628103592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m6Y9wLKgvbcBXmzq59WFKbPsBB9KXRj1k5gZ7Uo0zgM=;
        b=icQX1Ams6B2JTt9m+5XXi+9DByF93OdInlih0qJhTCjc80sJXmpSpibjSfPDVO4s6yB/YG
        4iRqqY+AfVQxUBlVq5wXg92GU6TbjPcKQ22vcBKkudD1o2Vb7d++wnQKN/VTr0gCno88DD
        HNqb1Z9uL0wZ7WzFLdlVJD+zLJVCLlk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-GiPDxMLbNvOPDju53_CaFw-1; Wed, 04 Aug 2021 14:59:51 -0400
X-MC-Unique: GiPDxMLbNvOPDju53_CaFw-1
Received: by mail-wr1-f70.google.com with SMTP id p12-20020a5d68cc0000b02901426384855aso1143474wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 11:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6Y9wLKgvbcBXmzq59WFKbPsBB9KXRj1k5gZ7Uo0zgM=;
        b=l5pWMbcySkLRznR7Kkgl723agD+07QoQrvWOjeBQOU613sNZAeujDHoH1jtxXI6/pd
         zDfw/F7OZghOC00yjTk4nKojNukc7gK/HZT6fJZIDpK3XbxzthPIaaVrbY4sT4EWKm5r
         H+cKlm/u1MkWU/ewLw1FoLS19ZM932m3J/uqoLCVzPtC8K7optqYYshUBFv7JXWhYfcB
         lKuI68XhWaXBu5fQ7rLasY7DCV5PQdg0y1JcLQ0ot4ZXvz4rOeB0zVQL7ITr8s57yQF0
         LhjUXJnS9dXrwhgXOA1Q9bMDywKOHX4ijeWZATfd6QgtqC8/pw6X5pp7yygoxBfjEw3N
         RcAw==
X-Gm-Message-State: AOAM531DjcmgxH6U0iI6GjvBh7ILK1qLP+avpka8KJOvY3l1UeABxOwp
        AjmLth5/9QFvTfBN25H6P7mPVSXw77MRp7VSgCQrzDjwWqyfqW8Gml18csdINL6BiDOo9vBbQO5
        fZXDXUjIvisegI/4QWNnupR0DQRjJV61bv6iJ/Mxb
X-Received: by 2002:a1c:4c:: with SMTP id 73mr11093303wma.139.1628103590253;
        Wed, 04 Aug 2021 11:59:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhSQsWnmHBJ0c+6q+9oNf5P9jAy2HMqrpqSesVTuGeJ7py4jp3l1Ku85Qc9jxKYKufAhOS69CECl/Kud9SaJo=
X-Received: by 2002:a1c:4c:: with SMTP id 73mr11093289wma.139.1628103590064;
 Wed, 04 Aug 2021 11:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0i0WP24Z0TScmPqKxmM2ovtKnmm+qZq6+Tc1ju+hma0w@mail.gmail.com>
 <20210804141049.499767-1-kherbst@redhat.com> <CAK8P3a136c_L3yVn-841Sbfib9UMOf1M-pk+2SqWt0wD2zfRKQ@mail.gmail.com>
 <CACO55tsLpURTm=Jf=4gRVtYQbit5h2OBYw_MFb6Vf1PFvTV7dw@mail.gmail.com>
In-Reply-To: <CACO55tsLpURTm=Jf=4gRVtYQbit5h2OBYw_MFb6Vf1PFvTV7dw@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 4 Aug 2021 20:59:39 +0200
Message-ID: <CACO55tuy5Am9zbcR490KWYYAg7MguBN5m82vbjzifGN5KpGbxw@mail.gmail.com>
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

On Wed, Aug 4, 2021 at 4:43 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Wed, Aug 4, 2021 at 4:19 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Wed, Aug 4, 2021 at 4:10 PM Karol Herbst <kherbst@redhat.com> wrote:
> > >
> > > playing around a little bit with this, I think the original "select
> > > BACKLIGHT_CLASS_DEVICE" is fine. Atm we kind of have this weird mix of
> > > drivers selecting and others depending on it. We could of course convert
> > > everything over to depend, and break those cycling dependency issues with
> > > this.
> > >
> > > Anyway this change on top of my initial patch is enough to make Kconfig
> > > happy and has the advantage of not having to mess with the deps of nouveau
> > > too much.
> >
> > Looks good to me. We'd probably want to make the BACKLIGHT_CLASS_DEVICE
> > option itself 'default FB || DRM' though, to ensure that defconfigs
> > keep working.
> >
>
> okay cool. Will send out a proper updated patch series soonish.
>

mhh, actually that breaks drivers selecting FB_BACKLIGHT as now
BACKLIGHT_CLASS_DEVICE might be disabled :(

somehow it doesn't feel like worth the effort converting it all over
to depend.. dunno.

Atm I would just use "select" in nouveau and deal with the conversion
later once somebody gets annoyed enough or so...

> >       Arnd
> >

