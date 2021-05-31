Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941D93957E1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEaJM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhEaJM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:12:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AA9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 02:11:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gb17so15616106ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 02:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u2dhyBrRgPJpaThHfekNjY1YApaj7rhpOg94pOVXFYo=;
        b=l5fjIPYn38smOxIuXHQkyewgGm5qBMWad56100e+IhcCPWxriuu65koJ6FxAYBSPc0
         Qv6ElSOifoR4yTKAlqo98TwBX9/r7e9z++/ozMdvanTz4vJn/xxSZU6XDUZL6zBGmHvo
         4Lb6A32g7kxmIi4WfaCgxDnRSUwCIi57cEP4k6evMLXlXRwu/ae5GU7gMoiBGZ5NK1+C
         R6eyEvFwm5CxZYADIVjc3yHzWuABY9LawKLafNYJoFs68RgBwCloB7aO316uIl8eH682
         d3gHpo1h5eBgMhqhL5Eo5Mk9CZowAC8giIWpI+eSzrXWEDySrvA0qm2D0EVPowjLHAzx
         W33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u2dhyBrRgPJpaThHfekNjY1YApaj7rhpOg94pOVXFYo=;
        b=rqhTQeqbo8lTUKtdh943UxSws/JdFsqjvUaHAHVn2q4ALJWUE2zVwcALG1cxgUZhTO
         P28WxpUeYyy6gOJo/RcZ+LEsQsxdHR7R0DRcJHediRGXnebLmc9/XpUttakQ9+6c4fls
         GyEekcYIxAdUiXJ90qnkq+sZfJrZGUU7TAF9mJePzHWN39vIs4h6ruDJ7eRhF3MUI1rL
         /OCKh84JUe+9xWYe/02mKQbg56u0gJIgAZ9F9YGNdoVjid10+ZsVfD7Szk0IAcMptZpy
         tww75mLniCjYMOlah3bV1v11/2bNrrJiGeCz2Rla5EXf3F3EKjtOwB3EtXAW/nxX1roJ
         TBRw==
X-Gm-Message-State: AOAM530fr07TBzs7DT9t7BBkYGAEa5QbZsmFm2dPmj8dnVVOx2TyVsKc
        lgSAov+HKwixWLY0fpS/MS/WqFvl7iVI6GFljb8=
X-Google-Smtp-Source: ABdhPJzv2Q8xcijadeJ3KhGFvOtaZLvG/YMSiIQdGWA6OCTTsWlSnSwNL7llQfmfXZxzPTOR593GCAv1xMGeHyjIUC4=
X-Received: by 2002:a17:906:4f10:: with SMTP id t16mr6914755eju.337.1622452275938;
 Mon, 31 May 2021 02:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210528133309.GR24442@kadam> <CAD-N9QVWcEJjoziA6HVoQiUueVaKqAJS5Et60zvCvuUE7e6=gg@mail.gmail.com>
 <20210528140500.GS24442@kadam> <A622EB84-DC4A-47A4-A828-CE6D25DC92EB@gmail.com>
 <CAD-N9QVjhDDJxRnNrDzwt05BNijr1o11nE8xjvq8GrakEJ8EuQ@mail.gmail.com>
 <20210531044022.GU24442@kadam> <CAD-N9QWBBP6_Wwi4z3e4yJM-tS54=1=CcvAA+2__Qj8NsTLq9g@mail.gmail.com>
 <20210531070337.GV24442@kadam> <CAD-N9QU-uqFr=b1hMi1h1ytq2Uf2XKL44f9OHBRhM70zhkiO7w@mail.gmail.com>
 <CAD-N9QW5C2ssA7H_U+eiM=SbsPj29Ooo6Sk=r4d1qELbZQjuPA@mail.gmail.com> <20210531084613.GX24442@kadam>
In-Reply-To: <20210531084613.GX24442@kadam>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 31 May 2021 17:10:49 +0800
Message-ID: <CAD-N9QVAdaitDcM6BGfwvNR=gMf7G6DK00n0Ev6ucXc6xNFFpw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: control led: fix memory leak in snd_ctl_led_register
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 4:46 PM Dan Carpenter <dan.carpenter@oracle.com> wr=
ote:
>
> On Mon, May 31, 2021 at 04:08:04PM +0800, Dongliang Mu wrote:
> > On Mon, May 31, 2021 at 3:34 PM Dongliang Mu <mudongliangabcd@gmail.com=
> wrote:
> > >
> > > On Mon, May 31, 2021 at 3:03 PM Dan Carpenter <dan.carpenter@oracle.c=
om> wrote:
> > > >
> > > > On Mon, May 31, 2021 at 02:20:37PM +0800, Dongliang Mu wrote:
> > > > > On Mon, May 31, 2021 at 12:40 PM Dan Carpenter <dan.carpenter@ora=
cle.com> wrote:
> > > > > >
> > > > > > On Mon, May 31, 2021 at 11:03:36AM +0800, Dongliang Mu wrote:
> > > > > > > On Sat, May 29, 2021 at 5:35 AM =E6=85=95=E5=86=AC=E4=BA=AE <=
mudongliangabcd@gmail.com> wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > On May 28, 2021, at 10:05 PM, Dan Carpenter <dan.carpente=
r@oracle.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, May 28, 2021 at 09:50:49PM +0800, Dongliang Mu wr=
ote:
> > > > > > > > >>
> > > > > > > > >> Can you please give some advise on how to fix this WARN =
issue?
> > > > > > > > >
> > > > > > > > > But it feels like it spoils the fun if I write the commit=
...  Anyway:
> > > > > > > >
> > > > > > > > It=E2=80=99s fine. I am still in the learning process. It=
=E2=80=99s also good to learn experience by comparing your patch and my pat=
ch.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > regards,
> > > > > > > > > dan carpenter
> > > > > > > > >
> > > > > > > > > diff --git a/sound/core/control_led.c b/sound/core/contro=
l_led.c
> > > > > > > > > index 25f57c14f294..dd357abc1b58 100644
> > > > > > > > > --- a/sound/core/control_led.c
> > > > > > > > > +++ b/sound/core/control_led.c
> > > > > > > > > @@ -740,6 +740,7 @@ static int __init snd_ctl_led_init(vo=
id)
> > > > > > > > >                       for (; group > 0; group--) {
> > > > > > > > >                               led =3D &snd_ctl_leds[group=
 - 1];
> > > > > > > > >                               device_del(&led->dev);
> > > > > > > > > +                             device_put(&led->dev);
> > > > > > > > >                       }
> > > > > > > > >                       device_del(&snd_ctl_led_dev);
> > > > > > > > >                       return -ENOMEM;
> > > > > > > > > @@ -768,6 +769,7 @@ static void __exit snd_ctl_led_exit(v=
oid)
> > > > > > > > >       for (group =3D 0; group < MAX_LED; group++) {
> > > > > > > > >               led =3D &snd_ctl_leds[group];
> > > > > > > > >               device_del(&led->dev);
> > > > > > > > > +             device_put(&led->dev);
> > > > > > > > >       }
> > > > > > > > >       device_del(&snd_ctl_led_dev);
> > > > > > > > >       snd_ctl_led_clean(NULL);
> > > > > > >
> > > > > > > Hi Dan,
> > > > > > >
> > > > > > > I tried this patch, and it still triggers the memleak.
> > > > > >
> > > > > > Did your patch fix the leak?  Because my patch should have been
> > > > > > equivalent except for it fixes an additional leak in the snd_ct=
l_led_init()
> > > > > > error path.
> > > > >
> > > > > The syzbot link is [1]. I have tested my patch in the syzbot dash=
board
> > > > > and my local workspace.
> > > > >
> > > > > I think the reason why your patch did not work should be
> > > > > led_card(struct snd_ctl_led_card) is already freed before returni=
ng in
> > > > > snd_ctl_led_sysfs_remove, rather than led(struct snd_ctl_led). Se=
e the
> > > > > implementation of snd_ctl_led_sysfs_remove for some details. Plea=
se
> > > > > correct me if I make any mistakes.
> > > > >
> > > > > static void snd_ctl_led_sysfs_remove(struct snd_card *card)
> > > > > {
> > > > >         unsigned int group;
> > > > >         struct snd_ctl_led_card *led_card;
> > > > >         struct snd_ctl_led *led;
> > > > >         char link_name[32];
> > > > >
> > > > >         for (group =3D 0; group < MAX_LED; group++) {
> > > > >                 led =3D &snd_ctl_leds[group];
> > > > >                 led_card =3D led->cards[card->number];
> > > > >                 if (!led_card)
> > > > >                         continue;
> > > > >                 snprintf(link_name, sizeof(link_name), "led-%s", =
led->name);
> > > > >                 sysfs_remove_link(&card->ctl_dev.kobj, link_name)=
;
> > > > >                 sysfs_remove_link(&led_card->dev.kobj, "card");
> > > > >                 device_del(&led_card->dev);
> > > > >                 put_device(&led_card->dev);
> > > > >                 kfree(led_card);
> > > > >                 led->cards[card->number] =3D NULL;
> > > > >         }
> > > > > }
> > > >
> > > > This is frustrating to look at because it's not a diff so it doesn'=
t
> > > > show what you changed.  I think you are saying that you added the
> > > > put_device(&led_card->dev);.  That's true.  There are some other le=
aks
> > > > as well.  We should just fix them all.  Use device_unregister() bec=
ause
> > > > it's cleaner.
> > >
> > > Oh, I see your point. Yeah, we should fix these memory leaks all. I
> > > agree with device_unregister.
> > >
> > > >
> > > > If both device_initialize() and device_add() succeed then call
> > > > device_unregister() to unwind.
> > >
> > > BTW, have you tested this new patch on two memory leaks?
> > >
> >
> > Please keep in mind that if we don't have any release method for
> > struct snd_ctl_led_card, it will trigger a WARN[1] in the
> > device_release function. That's why I have to add one dummy release
> > function.
> >
> > if (dev->release)
> >         dev->release(dev);
> > else if (dev->type && dev->type->release)
> >         dev->type->release(dev);
> > else if (dev->class && dev->class->dev_release)
> >         dev->class->dev_release(dev);
> > else
> >         WARN(1, KERN_ERR "Device '%s' does not have a release()
> > function, it is broken and must be fixed. See
> > Documentation/core-api/kobject.rst.\n",
> > dev_name(dev));
> >
>
> Oh yeah.  You're right.  The "kfree(led_card);" needs to be moved to a
> release function or it can lead to a use after free.  For the others,
> I think a dummy release function is ok (because it is static data).
>

Hi Dan,

I wonder if we shall split the current patch into two patches, one
patch for each memory leak. It is better to satisfy the rule - "one
patch only fixes one issue".

We should absolutely fix all these memory leaks. But one patch for two
different bugs with different objects and different paths is not very
suitable.

> It feels like there should be a standard way to say that there is no
> need to release any data.  That way it could be verified by static
> analysis tools.
>
> regards,
> dan carpenter
>
> > [1] https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#=
L2110
> >
> > > >
> > > > diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> > > > index 25f57c14f294..561fe45e4449 100644
> > > > --- a/sound/core/control_led.c
> > > > +++ b/sound/core/control_led.c
> > > > @@ -700,7 +700,7 @@ static void snd_ctl_led_sysfs_remove(struct snd=
_card *card)
> > > >                 snprintf(link_name, sizeof(link_name), "led-%s", le=
d->name);
> > > >                 sysfs_remove_link(&card->ctl_dev.kobj, link_name);
> > > >                 sysfs_remove_link(&led_card->dev.kobj, "card");
> > > > -               device_del(&led_card->dev);
> > > > +               device_unregister(&led_card->dev);
> > > >                 kfree(led_card);
> > > >                 led->cards[card->number] =3D NULL;
> > > >         }
> > > > @@ -739,9 +739,9 @@ static int __init snd_ctl_led_init(void)
> > > >                         put_device(&led->dev);
> > > >                         for (; group > 0; group--) {
> > > >                                 led =3D &snd_ctl_leds[group - 1];
> > > > -                               device_del(&led->dev);
> > > > +                               device_unregister(&led->dev);
> > > >                         }
> > > > -                       device_del(&snd_ctl_led_dev);
> > > > +                       device_unregister(&snd_ctl_led_dev);
> > > >                         return -ENOMEM;
> > > >                 }
> > > >         }
> > > > @@ -767,9 +767,9 @@ static void __exit snd_ctl_led_exit(void)
> > > >         }
> > > >         for (group =3D 0; group < MAX_LED; group++) {
> > > >                 led =3D &snd_ctl_leds[group];
> > > > -               device_del(&led->dev);
> > > > +               device_unregister(&led->dev);
> > > >         }
> > > > -       device_del(&snd_ctl_led_dev);
> > > > +       device_unregister(&snd_ctl_led_dev);
> > > >         snd_ctl_led_clean(NULL);
> > > >  }
> > > >
