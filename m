Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407073D4067
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 20:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhGWSIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 14:08:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229461AbhGWSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 14:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627066112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TT3QlzruQFM0O9S/g7+HR5WRHatrYiPktX1CpTRxfHI=;
        b=MkVLqrLloHwsyDjO5cgdF1YaktoR+OAhFpjgZkybTxViOLYA5T7YIb1hfGhEXkjdsZMnjP
        +CvixTtIaOauh7TjI94jZWDGlUbsleNNxKzKWX66jWhTeJDm8IB6LPu8T7J/sfb9HcmHvS
        WS7dZExoNgySvOZIEHrrvOawAER4Elo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-D5fHKXg2MlGl5-vM5_cyzQ-1; Fri, 23 Jul 2021 14:48:31 -0400
X-MC-Unique: D5fHKXg2MlGl5-vM5_cyzQ-1
Received: by mail-wr1-f69.google.com with SMTP id s8-20020a5d42480000b02901404c442853so1290938wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 11:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TT3QlzruQFM0O9S/g7+HR5WRHatrYiPktX1CpTRxfHI=;
        b=lBqUIjhbUYfdjvSz6DGDS9Pv6FRkGU8EAM2fqVZHrKj9y9eYucG28pu1SAAfh855dQ
         9/ppNL8hKb7RdJVcyRBrZceVOsJ/bx4FuoauNJuSaik7LRnACc9TANdRu/OT6TXdKuZe
         Csx288PNyOHB4vA63WfeXf57OCDZzMXRLF0V5Pd+szG7h86GgwJsWHN+A+UoMVyx0ijr
         SEQUXtfsF351SSML0qBjmJSMjzCOmA4k9vEVZV39Dt5ndN3z8SpxyF7zTA9eSrbJvUQJ
         simO0YDfiqm/xMf6LqCD1AD7TxK9zvkqFgdNJRVSqSJE6gbUTp09pnqhY1QMyK6v9DLr
         oqDQ==
X-Gm-Message-State: AOAM532xsDT60QGhQls76dh9ykE3PRyF4El4hQvSjqUNWKHkvDTRbw3G
        KF5AfniwEYxCVQFQPiJF4T1V8M1ooX6I4ZDxea4tBMCsLmElJVe2sx+Ih/X0hIS+4LOFwROyNiU
        Zkuq8OxD4ibARDulxdLeL9+gmSxRppVmhfJztfa0d
X-Received: by 2002:adf:ec0c:: with SMTP id x12mr6982929wrn.113.1627066110110;
        Fri, 23 Jul 2021 11:48:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZMoQyCFyEOCbinYmqYmEk4f3Ojj0mdfzboAjHeKt/OCfsnzDXsFZfcZoauHAS7H3EsRN3J0C10LA5+A8j6co=
X-Received: by 2002:adf:ec0c:: with SMTP id x12mr6982917wrn.113.1627066109896;
 Fri, 23 Jul 2021 11:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210723091534.1730564-1-arnd@kernel.org> <a618e29a-e4b7-bda4-a3e0-7dfd67d64e92@infradead.org>
 <CACO55tvQoCnjQWRJhrJ+8TzY5MuDDSUSnwd5AU8G1qsQYCSCBg@mail.gmail.com>
 <7ddd0c7c-9bdc-9ea3-c635-f1d141d1e870@infradead.org> <CACO55ttjQO5kUeEA7opvGLAwT+a1t0vAguncKDhB4bdy96K7LA@mail.gmail.com>
 <CAK8P3a0YiAgTLptmPbK6vczkMi7F=tzE-Ae8GPFnBtbvQnoF0Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0YiAgTLptmPbK6vczkMi7F=tzE-Ae8GPFnBtbvQnoF0Q@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 23 Jul 2021 20:48:19 +0200
Message-ID: <CACO55ts5C6xodqstoeCvhpRpMOB=nTTPDnBfN_QT2GJe2F4wNw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/kms/nv50-: fix build failure with CONFIG_BACKLIGHT=n
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 8:40 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Jul 23, 2021 at 6:34 PM Karol Herbst <kherbst@redhat.com> wrote:
> > On Fri, Jul 23, 2021 at 6:31 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > On 7/23/21 8:15 AM, Karol Herbst wrote:
> > > > On Fri, Jul 23, 2021 at 5:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > >
> > > > what's actually the use case of compiling with
> > > > CONFIG_DRM_NOUVEAU_BACKLIGHT=n anyway?
> > >
> > > Dunno. In this case it was just a randconfig. Still, it needs to be
> > > handled in some way - such as the other suggestion in this thread.
> > >
> >
> > sure, I was just curious if there was a specific use case or just
> > something random as you mentioned.
>
> I think this is purely done because of tradition. A long time ago, we had
> tiny framebuffer drivers and most PCs did not have backlights, so it
> made sense to leave this optional.
>
> This was probably just always carried over.
>
>          Arnd
>

okay. I think I will write a patch for nouveau then and send it out soonish

