Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DB7395637
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhEaHga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhEaHgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:36:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6E0C061760
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:34:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b11so5564196edy.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XwcT6Kv2brjtsl4Ipm3p1AZlwCeGBUcE4mYeB/eMvEY=;
        b=A/zCrpsqLVqOTQvaFFc4XTHwRBKoCwyL/4ViX16fBUYeoncy+yx4A0G1ygDflEfuPc
         jrwc5bGjj3Ty3k+hO7QwcDPkRyR5GmbBAP5xihOyiK3fDEpWDYd09ZBhwNNxuSjEsMHu
         ej1G3yzpoRXoHWrJZWjNd2BjgAsR79RNAIT1exajye04BOsTeAMa7AsdJ/4RpobYMEkT
         UJ5CYA+kfo6V0cnPbHPp+67DeD8Pll+ZoeRrbe0z+Ov0XNItkyiy8GFqzstwQL2RsjTM
         Ce8+FnD10FJhfhNlZkmg7JSfcswxafZ12Z98nLBs3JBg2vp8nxAfzSyvYpsh5qoX2RBn
         7ZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XwcT6Kv2brjtsl4Ipm3p1AZlwCeGBUcE4mYeB/eMvEY=;
        b=gtm+5tqiRzfUk3bKE9EvL4PYmMqFR2aeFXkjs9PklYNGcGNpOnUr67HZkqR1dHpzmZ
         34nUeHXaV4PYH3s27llz8PnUQImOSpn8jTmMtBqn1flaSc59osAIPuTcUwfj2zQEfaiz
         9LSM6CXZ98fjNnlf7nOQ5sKyTxuymBcgqEpX1Wxgamh103L/bPTmnvueOMGABiioDb7I
         +5yEm2BBccVRmzVgHmIKW7nB6U+TjtfesLUEaIzvTiGjWhGnUybwzntKJxxlhnCnOBjD
         rM03RpN1xwIccEtrMqjnDKhINRpcbv73H6BLLFZjvCnE1IJuBax3A7uV4VM3sNS2ySpR
         gcFw==
X-Gm-Message-State: AOAM531msHhzcGBtOYd5CYXlxWN1i7LVS8rHB8BRQ3lI4j8NfMKQdTMq
        UgaYMiowCb2ZbaGIHC6kdACVPfInOn7nipNqXDI=
X-Google-Smtp-Source: ABdhPJwHjvQOiFcj/g/sfB5LtcLpZbk0oEXeGC1eP+k8avTItRcWcZ5Gq5U1Xq5wo+DTg4vjU3IGma/QL9tBSfVx2hE=
X-Received: by 2002:a05:6402:15:: with SMTP id d21mr24298531edu.66.1622446476085;
 Mon, 31 May 2021 00:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
 <20210528133309.GR24442@kadam> <CAD-N9QVWcEJjoziA6HVoQiUueVaKqAJS5Et60zvCvuUE7e6=gg@mail.gmail.com>
 <20210528140500.GS24442@kadam> <A622EB84-DC4A-47A4-A828-CE6D25DC92EB@gmail.com>
 <CAD-N9QVjhDDJxRnNrDzwt05BNijr1o11nE8xjvq8GrakEJ8EuQ@mail.gmail.com>
 <20210531044022.GU24442@kadam> <CAD-N9QWBBP6_Wwi4z3e4yJM-tS54=1=CcvAA+2__Qj8NsTLq9g@mail.gmail.com>
 <20210531070337.GV24442@kadam>
In-Reply-To: <20210531070337.GV24442@kadam>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 31 May 2021 15:34:09 +0800
Message-ID: <CAD-N9QU-uqFr=b1hMi1h1ytq2Uf2XKL44f9OHBRhM70zhkiO7w@mail.gmail.com>
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

On Mon, May 31, 2021 at 3:03 PM Dan Carpenter <dan.carpenter@oracle.com> wr=
ote:
>
> On Mon, May 31, 2021 at 02:20:37PM +0800, Dongliang Mu wrote:
> > On Mon, May 31, 2021 at 12:40 PM Dan Carpenter <dan.carpenter@oracle.co=
m> wrote:
> > >
> > > On Mon, May 31, 2021 at 11:03:36AM +0800, Dongliang Mu wrote:
> > > > On Sat, May 29, 2021 at 5:35 AM =E6=85=95=E5=86=AC=E4=BA=AE <mudong=
liangabcd@gmail.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > > On May 28, 2021, at 10:05 PM, Dan Carpenter <dan.carpenter@orac=
le.com> wrote:
> > > > > >
> > > > > > On Fri, May 28, 2021 at 09:50:49PM +0800, Dongliang Mu wrote:
> > > > > >>
> > > > > >> Can you please give some advise on how to fix this WARN issue?
> > > > > >
> > > > > > But it feels like it spoils the fun if I write the commit...  A=
nyway:
> > > > >
> > > > > It=E2=80=99s fine. I am still in the learning process. It=E2=80=
=99s also good to learn experience by comparing your patch and my patch.
> > > > >
> > > > > >
> > > > > > regards,
> > > > > > dan carpenter
> > > > > >
> > > > > > diff --git a/sound/core/control_led.c b/sound/core/control_led.=
c
> > > > > > index 25f57c14f294..dd357abc1b58 100644
> > > > > > --- a/sound/core/control_led.c
> > > > > > +++ b/sound/core/control_led.c
> > > > > > @@ -740,6 +740,7 @@ static int __init snd_ctl_led_init(void)
> > > > > >                       for (; group > 0; group--) {
> > > > > >                               led =3D &snd_ctl_leds[group - 1];
> > > > > >                               device_del(&led->dev);
> > > > > > +                             device_put(&led->dev);
> > > > > >                       }
> > > > > >                       device_del(&snd_ctl_led_dev);
> > > > > >                       return -ENOMEM;
> > > > > > @@ -768,6 +769,7 @@ static void __exit snd_ctl_led_exit(void)
> > > > > >       for (group =3D 0; group < MAX_LED; group++) {
> > > > > >               led =3D &snd_ctl_leds[group];
> > > > > >               device_del(&led->dev);
> > > > > > +             device_put(&led->dev);
> > > > > >       }
> > > > > >       device_del(&snd_ctl_led_dev);
> > > > > >       snd_ctl_led_clean(NULL);
> > > >
> > > > Hi Dan,
> > > >
> > > > I tried this patch, and it still triggers the memleak.
> > >
> > > Did your patch fix the leak?  Because my patch should have been
> > > equivalent except for it fixes an additional leak in the snd_ctl_led_=
init()
> > > error path.
> >
> > The syzbot link is [1]. I have tested my patch in the syzbot dashboard
> > and my local workspace.
> >
> > I think the reason why your patch did not work should be
> > led_card(struct snd_ctl_led_card) is already freed before returning in
> > snd_ctl_led_sysfs_remove, rather than led(struct snd_ctl_led). See the
> > implementation of snd_ctl_led_sysfs_remove for some details. Please
> > correct me if I make any mistakes.
> >
> > static void snd_ctl_led_sysfs_remove(struct snd_card *card)
> > {
> >         unsigned int group;
> >         struct snd_ctl_led_card *led_card;
> >         struct snd_ctl_led *led;
> >         char link_name[32];
> >
> >         for (group =3D 0; group < MAX_LED; group++) {
> >                 led =3D &snd_ctl_leds[group];
> >                 led_card =3D led->cards[card->number];
> >                 if (!led_card)
> >                         continue;
> >                 snprintf(link_name, sizeof(link_name), "led-%s", led->n=
ame);
> >                 sysfs_remove_link(&card->ctl_dev.kobj, link_name);
> >                 sysfs_remove_link(&led_card->dev.kobj, "card");
> >                 device_del(&led_card->dev);
> >                 put_device(&led_card->dev);
> >                 kfree(led_card);
> >                 led->cards[card->number] =3D NULL;
> >         }
> > }
>
> This is frustrating to look at because it's not a diff so it doesn't
> show what you changed.  I think you are saying that you added the
> put_device(&led_card->dev);.  That's true.  There are some other leaks
> as well.  We should just fix them all.  Use device_unregister() because
> it's cleaner.

Oh, I see your point. Yeah, we should fix these memory leaks all. I
agree with device_unregister.

>
> If both device_initialize() and device_add() succeed then call
> device_unregister() to unwind.

BTW, have you tested this new patch on two memory leaks?

>
> diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> index 25f57c14f294..561fe45e4449 100644
> --- a/sound/core/control_led.c
> +++ b/sound/core/control_led.c
> @@ -700,7 +700,7 @@ static void snd_ctl_led_sysfs_remove(struct snd_card =
*card)
>                 snprintf(link_name, sizeof(link_name), "led-%s", led->nam=
e);
>                 sysfs_remove_link(&card->ctl_dev.kobj, link_name);
>                 sysfs_remove_link(&led_card->dev.kobj, "card");
> -               device_del(&led_card->dev);
> +               device_unregister(&led_card->dev);
>                 kfree(led_card);
>                 led->cards[card->number] =3D NULL;
>         }
> @@ -739,9 +739,9 @@ static int __init snd_ctl_led_init(void)
>                         put_device(&led->dev);
>                         for (; group > 0; group--) {
>                                 led =3D &snd_ctl_leds[group - 1];
> -                               device_del(&led->dev);
> +                               device_unregister(&led->dev);
>                         }
> -                       device_del(&snd_ctl_led_dev);
> +                       device_unregister(&snd_ctl_led_dev);
>                         return -ENOMEM;
>                 }
>         }
> @@ -767,9 +767,9 @@ static void __exit snd_ctl_led_exit(void)
>         }
>         for (group =3D 0; group < MAX_LED; group++) {
>                 led =3D &snd_ctl_leds[group];
> -               device_del(&led->dev);
> +               device_unregister(&led->dev);
>         }
> -       device_del(&snd_ctl_led_dev);
> +       device_unregister(&snd_ctl_led_dev);
>         snd_ctl_led_clean(NULL);
>  }
>
