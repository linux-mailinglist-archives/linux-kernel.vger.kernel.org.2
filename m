Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD43956A9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhEaIKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaIKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:10:13 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7105C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:08:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u24so2950504edy.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c+pwhGgkZwVwJSlAkd+SILIfBZyexjldGK0DQMbe5B0=;
        b=jUbwI26axnplE39v5+sh5CnOSjPGa++0V0t9MtFTRE70jO3uFWMNLE+3gYrHYk4qYY
         tA7gD14wpBDMVdLTbLu6nUKc8XuykRRsQZPy/qSfARNPSF7O1k18KA+PQ9BYASycG57f
         veCEV0S+ClmaFN7SJhwo0GT/NdF6ixdVru5zHnhs7YEDQacstUQf8dTOzOeLeqNaFsKE
         1vi4h0es1VOr05Zxg2PHptFK7hXv2QF2dlM4kgDDgQ0HicXrM3Ci4PffvG707EcE9hS/
         OSJkvZbYA2cZvTZzvpN4G4zN5c0ZH7r1J03I2YXvoO5+QTEWxjx/lElUadA0egqzPvvo
         0iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c+pwhGgkZwVwJSlAkd+SILIfBZyexjldGK0DQMbe5B0=;
        b=Uof1OVCU0mVzE6mgFGVL3hG2mV1jxUvIanue2bNWjnweu9WsLLQYV1uydwV8SI9HGc
         vNorTXbFuyGaf6/oeTpquF/PiVtZN+ALoGHpDDTV9mgwaDsONAGVQuIvVr98n/EsPcUI
         +wPzgksF4P6YRW1t/q6bOZttou4DddMHYMbNg56e1nS5rsDbM1XSVyZNFkYq64Jo1Ttb
         24rlwsa8kgJ3ee4yJMTPlyxG8S7Ry/0DCHHx82ZWnz1k1DpqOjaBAJYV7mjSb5llHw2N
         yV1TVzpmstyXmpzRyCddGSmnz+rgIumJ01Ob4VtA4RKzKZGr/dqLk5cpTiH+IwNb+w5z
         ocHg==
X-Gm-Message-State: AOAM531fQ8uKoXYI1RSOi1uXegokV52j6Icw5H/Nc8JAxJwX7HUxNK/F
        YULTXhQl6LkrwQGkzW2Kvt9LAKaSXwRuSQE+6Hw=
X-Google-Smtp-Source: ABdhPJxOTryzEua54hvVaBaAzjMBgkBfDeJuKV9+vA0IKBDVEFDkhDPAg0TyqiwYLSNadIWsyVMiyKNOWb31KE8eCWA=
X-Received: by 2002:a05:6402:60a:: with SMTP id n10mr24125109edv.241.1622448511246;
 Mon, 31 May 2021 01:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
 <20210528133309.GR24442@kadam> <CAD-N9QVWcEJjoziA6HVoQiUueVaKqAJS5Et60zvCvuUE7e6=gg@mail.gmail.com>
 <20210528140500.GS24442@kadam> <A622EB84-DC4A-47A4-A828-CE6D25DC92EB@gmail.com>
 <CAD-N9QVjhDDJxRnNrDzwt05BNijr1o11nE8xjvq8GrakEJ8EuQ@mail.gmail.com>
 <20210531044022.GU24442@kadam> <CAD-N9QWBBP6_Wwi4z3e4yJM-tS54=1=CcvAA+2__Qj8NsTLq9g@mail.gmail.com>
 <20210531070337.GV24442@kadam> <CAD-N9QU-uqFr=b1hMi1h1ytq2Uf2XKL44f9OHBRhM70zhkiO7w@mail.gmail.com>
In-Reply-To: <CAD-N9QU-uqFr=b1hMi1h1ytq2Uf2XKL44f9OHBRhM70zhkiO7w@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 31 May 2021 16:08:04 +0800
Message-ID: <CAD-N9QW5C2ssA7H_U+eiM=SbsPj29Ooo6Sk=r4d1qELbZQjuPA@mail.gmail.com>
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

On Mon, May 31, 2021 at 3:34 PM Dongliang Mu <mudongliangabcd@gmail.com> wr=
ote:
>
> On Mon, May 31, 2021 at 3:03 PM Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
> >
> > On Mon, May 31, 2021 at 02:20:37PM +0800, Dongliang Mu wrote:
> > > On Mon, May 31, 2021 at 12:40 PM Dan Carpenter <dan.carpenter@oracle.=
com> wrote:
> > > >
> > > > On Mon, May 31, 2021 at 11:03:36AM +0800, Dongliang Mu wrote:
> > > > > On Sat, May 29, 2021 at 5:35 AM =E6=85=95=E5=86=AC=E4=BA=AE <mudo=
ngliangabcd@gmail.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > > On May 28, 2021, at 10:05 PM, Dan Carpenter <dan.carpenter@or=
acle.com> wrote:
> > > > > > >
> > > > > > > On Fri, May 28, 2021 at 09:50:49PM +0800, Dongliang Mu wrote:
> > > > > > >>
> > > > > > >> Can you please give some advise on how to fix this WARN issu=
e?
> > > > > > >
> > > > > > > But it feels like it spoils the fun if I write the commit... =
 Anyway:
> > > > > >
> > > > > > It=E2=80=99s fine. I am still in the learning process. It=E2=80=
=99s also good to learn experience by comparing your patch and my patch.
> > > > > >
> > > > > > >
> > > > > > > regards,
> > > > > > > dan carpenter
> > > > > > >
> > > > > > > diff --git a/sound/core/control_led.c b/sound/core/control_le=
d.c
> > > > > > > index 25f57c14f294..dd357abc1b58 100644
> > > > > > > --- a/sound/core/control_led.c
> > > > > > > +++ b/sound/core/control_led.c
> > > > > > > @@ -740,6 +740,7 @@ static int __init snd_ctl_led_init(void)
> > > > > > >                       for (; group > 0; group--) {
> > > > > > >                               led =3D &snd_ctl_leds[group - 1=
];
> > > > > > >                               device_del(&led->dev);
> > > > > > > +                             device_put(&led->dev);
> > > > > > >                       }
> > > > > > >                       device_del(&snd_ctl_led_dev);
> > > > > > >                       return -ENOMEM;
> > > > > > > @@ -768,6 +769,7 @@ static void __exit snd_ctl_led_exit(void)
> > > > > > >       for (group =3D 0; group < MAX_LED; group++) {
> > > > > > >               led =3D &snd_ctl_leds[group];
> > > > > > >               device_del(&led->dev);
> > > > > > > +             device_put(&led->dev);
> > > > > > >       }
> > > > > > >       device_del(&snd_ctl_led_dev);
> > > > > > >       snd_ctl_led_clean(NULL);
> > > > >
> > > > > Hi Dan,
> > > > >
> > > > > I tried this patch, and it still triggers the memleak.
> > > >
> > > > Did your patch fix the leak?  Because my patch should have been
> > > > equivalent except for it fixes an additional leak in the snd_ctl_le=
d_init()
> > > > error path.
> > >
> > > The syzbot link is [1]. I have tested my patch in the syzbot dashboar=
d
> > > and my local workspace.
> > >
> > > I think the reason why your patch did not work should be
> > > led_card(struct snd_ctl_led_card) is already freed before returning i=
n
> > > snd_ctl_led_sysfs_remove, rather than led(struct snd_ctl_led). See th=
e
> > > implementation of snd_ctl_led_sysfs_remove for some details. Please
> > > correct me if I make any mistakes.
> > >
> > > static void snd_ctl_led_sysfs_remove(struct snd_card *card)
> > > {
> > >         unsigned int group;
> > >         struct snd_ctl_led_card *led_card;
> > >         struct snd_ctl_led *led;
> > >         char link_name[32];
> > >
> > >         for (group =3D 0; group < MAX_LED; group++) {
> > >                 led =3D &snd_ctl_leds[group];
> > >                 led_card =3D led->cards[card->number];
> > >                 if (!led_card)
> > >                         continue;
> > >                 snprintf(link_name, sizeof(link_name), "led-%s", led-=
>name);
> > >                 sysfs_remove_link(&card->ctl_dev.kobj, link_name);
> > >                 sysfs_remove_link(&led_card->dev.kobj, "card");
> > >                 device_del(&led_card->dev);
> > >                 put_device(&led_card->dev);
> > >                 kfree(led_card);
> > >                 led->cards[card->number] =3D NULL;
> > >         }
> > > }
> >
> > This is frustrating to look at because it's not a diff so it doesn't
> > show what you changed.  I think you are saying that you added the
> > put_device(&led_card->dev);.  That's true.  There are some other leaks
> > as well.  We should just fix them all.  Use device_unregister() because
> > it's cleaner.
>
> Oh, I see your point. Yeah, we should fix these memory leaks all. I
> agree with device_unregister.
>
> >
> > If both device_initialize() and device_add() succeed then call
> > device_unregister() to unwind.
>
> BTW, have you tested this new patch on two memory leaks?
>

Please keep in mind that if we don't have any release method for
struct snd_ctl_led_card, it will trigger a WARN[1] in the
device_release function. That's why I have to add one dummy release
function.

if (dev->release)
        dev->release(dev);
else if (dev->type && dev->type->release)
        dev->type->release(dev);
else if (dev->class && dev->class->dev_release)
        dev->class->dev_release(dev);
else
        WARN(1, KERN_ERR "Device '%s' does not have a release()
function, it is broken and must be fixed. See
Documentation/core-api/kobject.rst.\n",
dev_name(dev));

[1] https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L211=
0

> >
> > diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> > index 25f57c14f294..561fe45e4449 100644
> > --- a/sound/core/control_led.c
> > +++ b/sound/core/control_led.c
> > @@ -700,7 +700,7 @@ static void snd_ctl_led_sysfs_remove(struct snd_car=
d *card)
> >                 snprintf(link_name, sizeof(link_name), "led-%s", led->n=
ame);
> >                 sysfs_remove_link(&card->ctl_dev.kobj, link_name);
> >                 sysfs_remove_link(&led_card->dev.kobj, "card");
> > -               device_del(&led_card->dev);
> > +               device_unregister(&led_card->dev);
> >                 kfree(led_card);
> >                 led->cards[card->number] =3D NULL;
> >         }
> > @@ -739,9 +739,9 @@ static int __init snd_ctl_led_init(void)
> >                         put_device(&led->dev);
> >                         for (; group > 0; group--) {
> >                                 led =3D &snd_ctl_leds[group - 1];
> > -                               device_del(&led->dev);
> > +                               device_unregister(&led->dev);
> >                         }
> > -                       device_del(&snd_ctl_led_dev);
> > +                       device_unregister(&snd_ctl_led_dev);
> >                         return -ENOMEM;
> >                 }
> >         }
> > @@ -767,9 +767,9 @@ static void __exit snd_ctl_led_exit(void)
> >         }
> >         for (group =3D 0; group < MAX_LED; group++) {
> >                 led =3D &snd_ctl_leds[group];
> > -               device_del(&led->dev);
> > +               device_unregister(&led->dev);
> >         }
> > -       device_del(&snd_ctl_led_dev);
> > +       device_unregister(&snd_ctl_led_dev);
> >         snd_ctl_led_clean(NULL);
> >  }
> >
