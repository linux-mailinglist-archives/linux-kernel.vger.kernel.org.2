Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C75438BD6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 22:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhJXUqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhJXUqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 16:46:37 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E706C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 13:44:16 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id b9so20611551ybc.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i9ZP7IGMGpELliVa79P8GGwJ6qwJ6CfnjAX5YXt22no=;
        b=deK0Bucl7tHpR2tHP2TRWP2tmUPAsSKTAkMa8BUZtEfgZtb76ColSmGeYdDkEugmJK
         VrwGOqG6S07klCU7ihULqhUe05BDy81dXkzo6NoMOXy8lj/Jd2mhCGdDc6SD/N+693RD
         Dg0q5T0hodqesb/VflqOGhB8sO750molmWSYhuhyYUjHweo9QgG3RKPXvUpqjE3Ly7BM
         WaaoJEfOlevDeIFL/EERaKw0sjynC5Ulugj2cWmVfRtZ2FrpLu+PYsa9y1ng2Q+5eFMR
         Oo4fZCnABaU7bf5zq59SkGkmau1mvpaaz5AgNNgFRQkWacO5HrVaOxA2iT41pMCITeYP
         fygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i9ZP7IGMGpELliVa79P8GGwJ6qwJ6CfnjAX5YXt22no=;
        b=QJQK33V9ily/e05Fs/3fuavKpWzAasc2kj5hFl3YiMg0wTJyKebBiNN/RFWTudC77h
         A5RhcL++1KQO07JZ6G/6HJhWQYOpdFLf2YrsKFmagZm5k3JudQgPJ2ewUc6WzbPcbJWi
         QIUNev8jPKlLv2kswkq/Gx4lvGsKs/mnxzaLZ6a9USMZ6tie8tmEzziJwgYiqJmpFgYj
         +qGPQW03cDqhJqi8BzkE8fMJtnxwe2Do1kHhgFAnmClJHjxL3VvSOjwRf/HoAdvGiTuo
         gWXXe7OcT5y97RKUCKYL8qdDG9p/DTKhTQ+vBWA9xrcrKB4YxTj6O3/4sdgKRxMPwFuB
         Pvdw==
X-Gm-Message-State: AOAM532YNKncHQzKHm5SrUVc+Gheu6WEuBDg6/37sJ/aWHotbIRSt0tZ
        QJEkkIMLuiueQWGJ/FYC+pcAe+H+fisKX86Lqfw=
X-Google-Smtp-Source: ABdhPJyqv7OtAmcih1xrZ+g+PbBttJQ6eb+kwtn/PFj8QNfrD8ulw4zvW16fmjfHz1j+VaKMMZYGdm9W+buoU47rdPA=
X-Received: by 2002:a25:d196:: with SMTP id i144mr13692041ybg.255.1635108255433;
 Sun, 24 Oct 2021 13:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211022144040.3418284-1-javierm@redhat.com> <14a41bd8-cd70-b9d0-ce1c-869cfde8bdcb@suse.de>
 <015855d9-62f3-be81-a4c1-b8439534ec06@redhat.com>
In-Reply-To: <015855d9-62f3-be81-a4c1-b8439534ec06@redhat.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Sun, 24 Oct 2021 16:43:39 -0400
Message-ID: <CAEg-Je8-sSSo-4t_FvqquonPJF7y=-zpQLLX5PjkhEKG-xop=A@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/aperture: Add param to disable conflicting
 framebuffers removal
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 4:40 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Thomas,
>
> Thanks a lot for your feedback.
>
> On 10/22/21 21:05, Thomas Zimmermann wrote:
>
> > There's still the question of the semantics of this parameter. It's a
> > bit fuzzy.
> >
> > If you use 'disable_handover' (as you mentioned in another mail), it
> > would mean that only the handover itself is disabled. So if simpledrm i=
s
> > not bound to the device, then a native driver should load. That would b=
e
> > hard to implement with the current code base, where we have to take old
> > fbdev drivers into account.
> >
> > (And to be pedantic, we don't really do a handover of the device. We
> > hot-unplug the generic platform device, so that the driver for the
> > native device can operate the HW without interference.)
> >
> > Simpledrm only acquires an aperture, but never removes a driver. If
> > there is a driver already, simpledrm would fail. Only native drivers tr=
y > to remove drivers and would trigger the test. So your patch is more
> > something like 'disable_native_drivers'.
> >
> > I'd go with 'disable_native_drivers', or maybe 'disable_device_handover=
'
>
> That works for me and "drm.disable_native_drivers" is also what Neal mean=
t
> with his "drm.noplatformdrv", but yours is much easier to remember / type=
.
>

I'm good with that too. :)

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
