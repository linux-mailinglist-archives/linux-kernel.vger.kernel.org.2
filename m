Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3233139555C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 08:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhEaGWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 02:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhEaGWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 02:22:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C23C061760
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 23:21:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id t15so1985056eju.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 23:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dykij4/ipSjY/qjU7iLz8hMkaJ9DNR7hfb9RpI8VxG4=;
        b=fnx0yLV9OD0b5ZBPi5I1a5W/VId1w1Kx0smh0Qevrxs49y2JMmOxwt2MKwuVrNQpft
         xiGUEDgzd+e02hGscYEIQcZgHMbacIm3Fo7ImrUn2uvVKskaRW+wdPal8feFpurGFLni
         O0JErMQ0ArxAW+bcvQ3UUBgZ3IYatgAInRR9EQEJ/LO8M9amjHFuCtjBSWxtIwK8ltQe
         /Pn2pije0ELGDTluje+5H09h4sJ3wA5iC9zm0+0eFxUe6CkkrsrQyn0gSyV1K7WBJOn4
         T+ENGW6YDK+aeZnnCVhcKVd+O8UHsyp7z3k0YfD6mWNHaNIaKeQ8oqZqBGtFCo4I2KZR
         wosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dykij4/ipSjY/qjU7iLz8hMkaJ9DNR7hfb9RpI8VxG4=;
        b=QRFpfxuDFDiBTe1wny25L0CoTYW3f1XaD8e6pIJN7k/9z4XtgQKLvETFUcbzxqV0BI
         6VFveAU12nCqFi86l3nklOZh90SyeUTPQ7G7gOCbx/dkYElr71m0+cNwlLJDFnWV8/I3
         pjP8mUryM95fwYLm6bdOOAHES8o44a2qPrtKhvdzi4iSBgXACUyA9Dv4w8cNW6wLz+GA
         dgbtLm9fmqzV0GfALhXMmsJbIZSYxH4Aaq6f9287XkkeY7q7bUbFXrxSS6o6RIeCWFG+
         t2+LkZRir6p5blbfbwpoizgnsz4ta07w2Yd+G/Ge/kPc6GYdQvA2l+NHm6dzTAnDHL2X
         G/oA==
X-Gm-Message-State: AOAM531oLxaTTq1aix466/D5zYLff5j3icNFsUJHNrtKg0aXcyWo/pLr
        duVU0nKwQi6WS5vEcnR2wqbkwuVbr4MNfZi7Xp4=
X-Google-Smtp-Source: ABdhPJwmAVA0RaF6nRoCWPFnO95e/ta5Yhi7K5zJ73CH+QokRG5rVBJ1kqwXBIFk7TJQF7Fe0kod8wP0f3gUwdZSbOs=
X-Received: by 2002:a17:906:148f:: with SMTP id x15mr20757423ejc.535.1622442063801;
 Sun, 30 May 2021 23:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
 <20210528133309.GR24442@kadam> <CAD-N9QVWcEJjoziA6HVoQiUueVaKqAJS5Et60zvCvuUE7e6=gg@mail.gmail.com>
 <20210528140500.GS24442@kadam> <A622EB84-DC4A-47A4-A828-CE6D25DC92EB@gmail.com>
 <CAD-N9QVjhDDJxRnNrDzwt05BNijr1o11nE8xjvq8GrakEJ8EuQ@mail.gmail.com> <20210531044022.GU24442@kadam>
In-Reply-To: <20210531044022.GU24442@kadam>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 31 May 2021 14:20:37 +0800
Message-ID: <CAD-N9QWBBP6_Wwi4z3e4yJM-tS54=1=CcvAA+2__Qj8NsTLq9g@mail.gmail.com>
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

On Mon, May 31, 2021 at 12:40 PM Dan Carpenter <dan.carpenter@oracle.com> w=
rote:
>
> On Mon, May 31, 2021 at 11:03:36AM +0800, Dongliang Mu wrote:
> > On Sat, May 29, 2021 at 5:35 AM =E6=85=95=E5=86=AC=E4=BA=AE <mudonglian=
gabcd@gmail.com> wrote:
> > >
> > >
> > >
> > > > On May 28, 2021, at 10:05 PM, Dan Carpenter <dan.carpenter@oracle.c=
om> wrote:
> > > >
> > > > On Fri, May 28, 2021 at 09:50:49PM +0800, Dongliang Mu wrote:
> > > >>
> > > >> Can you please give some advise on how to fix this WARN issue?
> > > >
> > > > But it feels like it spoils the fun if I write the commit...  Anywa=
y:
> > >
> > > It=E2=80=99s fine. I am still in the learning process. It=E2=80=99s a=
lso good to learn experience by comparing your patch and my patch.
> > >
> > > >
> > > > regards,
> > > > dan carpenter
> > > >
> > > > diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> > > > index 25f57c14f294..dd357abc1b58 100644
> > > > --- a/sound/core/control_led.c
> > > > +++ b/sound/core/control_led.c
> > > > @@ -740,6 +740,7 @@ static int __init snd_ctl_led_init(void)
> > > >                       for (; group > 0; group--) {
> > > >                               led =3D &snd_ctl_leds[group - 1];
> > > >                               device_del(&led->dev);
> > > > +                             device_put(&led->dev);
> > > >                       }
> > > >                       device_del(&snd_ctl_led_dev);
> > > >                       return -ENOMEM;
> > > > @@ -768,6 +769,7 @@ static void __exit snd_ctl_led_exit(void)
> > > >       for (group =3D 0; group < MAX_LED; group++) {
> > > >               led =3D &snd_ctl_leds[group];
> > > >               device_del(&led->dev);
> > > > +             device_put(&led->dev);
> > > >       }
> > > >       device_del(&snd_ctl_led_dev);
> > > >       snd_ctl_led_clean(NULL);
> >
> > Hi Dan,
> >
> > I tried this patch, and it still triggers the memleak.
>
> Did your patch fix the leak?  Because my patch should have been
> equivalent except for it fixes an additional leak in the snd_ctl_led_init=
()
> error path.

The syzbot link is [1]. I have tested my patch in the syzbot dashboard
and my local workspace.

I think the reason why your patch did not work should be
led_card(struct snd_ctl_led_card) is already freed before returning in
snd_ctl_led_sysfs_remove, rather than led(struct snd_ctl_led). See the
implementation of snd_ctl_led_sysfs_remove for some details. Please
correct me if I make any mistakes.

static void snd_ctl_led_sysfs_remove(struct snd_card *card)
{
        unsigned int group;
        struct snd_ctl_led_card *led_card;
        struct snd_ctl_led *led;
        char link_name[32];

        for (group =3D 0; group < MAX_LED; group++) {
                led =3D &snd_ctl_leds[group];
                led_card =3D led->cards[card->number];
                if (!led_card)
                        continue;
                snprintf(link_name, sizeof(link_name), "led-%s", led->name)=
;
                sysfs_remove_link(&card->ctl_dev.kobj, link_name);
                sysfs_remove_link(&led_card->dev.kobj, "card");
                device_del(&led_card->dev);
                put_device(&led_card->dev);
                kfree(led_card);
                led->cards[card->number] =3D NULL;
        }
}

[1] https://syzkaller.appspot.com/bug?id=3D6d9e1e89003c894e7a1855c92dfa558e=
bcb8f218

>
> > My
> > understanding is that the device object is already freed in the
> > snd_ctl_led_sysfs_remove.
> >
>
> "Already freed"?  Is it a memleak or is it a double free???  I probably
> should have read the syzbot email on this...  But you didn't include
> a link to it or a reported-by tag so I don't have a way to look at the
> actual bug.

I listed the reported-by tag and fixes tag in the first email in this
thread. The syzbot link is [1].

Please take a look at my patch testing request.

>
> I did fix a bug, though...  Just not the one from the report I guess.
> Please send a link to the bug report so I can look at that.  ;)

We should talk about different bugs, memory leak for different objects
and different paths.

>
> regards,
> dan carpenter
>
