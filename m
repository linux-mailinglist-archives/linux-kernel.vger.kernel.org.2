Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3362939541E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 05:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhEaDFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 23:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEaDFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 23:05:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D242C061574
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 20:04:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ss26so14415402ejb.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 20:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9zncGjWI/Ti8X4PcYn2LTWv6/sQeOvT3E+T4zzv3al4=;
        b=ZpqMb5pLMC57T5ge9mI5wiScA0lilfWuOW/WzS/iOL/Pobi10ictGNHq7So1K580xE
         t6evHt86l5Sp49kkm6XqGBAzK8M8H47X62rQ6zJ1QVuZid/NhxgwKV7hnYtqNHE8SH7n
         3dpFSHiJzHhVc1wyl3Vf8unKF1Nc9uWTTDeX6sHDzNqI0Q0r4dvv8BhVZpBUIUP/+7pP
         LwmVv+cfs0pcO6mG5VPZFkPjGyzhwCtX86UgN2r718AxHZydoQOy8U5NdHrRAf3H7lOP
         HtDmRlKaY7lD9jlScOo0NWYWo+kcuTeLR0IafCzd59/Y46A+rR6ShPlGHHLcj0mVODKm
         JphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9zncGjWI/Ti8X4PcYn2LTWv6/sQeOvT3E+T4zzv3al4=;
        b=LM5bgl6OTmoU5Ywih7oJJ5mG4C96pwvxuLnMsMjlE1n5jrz+/FVhqDe4r2RVhVae39
         bbg2I7U4TSbVdrg2c+GyIArIej7rMlZAjH687IC74RhzWF1c0RWM9lEFfyGPCbwIORH8
         ausNEBbs7repQ9iMXJvqBjkEiEWoyBo4RLhAZptaNcvqVuD1cRjPlLqGoI6yjBG0gZGE
         6A1wlad/6y2mU1QNPC3tcZ0RwD8n3SStUR8TsQvCBaazZHCMyhflmoV6YzIr13CA1WnT
         EFxU8YaHgwYLtYIx90GEmd02fQDXp3OgxyqNWK0A+OPv1eOWinrMvYM1ts9GlPLxWvge
         61Dw==
X-Gm-Message-State: AOAM531O5pJeUz20xos0AtZfi2nCGcHqau9rPosqEkXyckZFZL16Bsu8
        e0XOiNAX76FzHNzBRt1iOWiFOpEYTfb45Qjqo24=
X-Google-Smtp-Source: ABdhPJxDEPa3T5UAc0cyhX2pJM3u681kMN50f7+D2IiLhhsuHCNZDsnnuQO0O7X+CyydTBL9Se8gyDjJEZsWpjQ1m5o=
X-Received: by 2002:a17:906:6d17:: with SMTP id m23mr21254158ejr.73.1622430242956;
 Sun, 30 May 2021 20:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
 <20210528133309.GR24442@kadam> <CAD-N9QVWcEJjoziA6HVoQiUueVaKqAJS5Et60zvCvuUE7e6=gg@mail.gmail.com>
 <20210528140500.GS24442@kadam> <A622EB84-DC4A-47A4-A828-CE6D25DC92EB@gmail.com>
In-Reply-To: <A622EB84-DC4A-47A4-A828-CE6D25DC92EB@gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 31 May 2021 11:03:36 +0800
Message-ID: <CAD-N9QVjhDDJxRnNrDzwt05BNijr1o11nE8xjvq8GrakEJ8EuQ@mail.gmail.com>
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

On Sat, May 29, 2021 at 5:35 AM =E6=85=95=E5=86=AC=E4=BA=AE <mudongliangabc=
d@gmail.com> wrote:
>
>
>
> > On May 28, 2021, at 10:05 PM, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
> >
> > On Fri, May 28, 2021 at 09:50:49PM +0800, Dongliang Mu wrote:
> >>
> >> Can you please give some advise on how to fix this WARN issue?
> >
> > But it feels like it spoils the fun if I write the commit...  Anyway:
>
> It=E2=80=99s fine. I am still in the learning process. It=E2=80=99s also =
good to learn experience by comparing your patch and my patch.
>
> >
> > regards,
> > dan carpenter
> >
> > diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> > index 25f57c14f294..dd357abc1b58 100644
> > --- a/sound/core/control_led.c
> > +++ b/sound/core/control_led.c
> > @@ -740,6 +740,7 @@ static int __init snd_ctl_led_init(void)
> >                       for (; group > 0; group--) {
> >                               led =3D &snd_ctl_leds[group - 1];
> >                               device_del(&led->dev);
> > +                             device_put(&led->dev);
> >                       }
> >                       device_del(&snd_ctl_led_dev);
> >                       return -ENOMEM;
> > @@ -768,6 +769,7 @@ static void __exit snd_ctl_led_exit(void)
> >       for (group =3D 0; group < MAX_LED; group++) {
> >               led =3D &snd_ctl_leds[group];
> >               device_del(&led->dev);
> > +             device_put(&led->dev);
> >       }
> >       device_del(&snd_ctl_led_dev);
> >       snd_ctl_led_clean(NULL);

Hi Dan,

I tried this patch, and it still triggers the memleak. My
understanding is that the device object is already freed in the
snd_ctl_led_sysfs_remove.

>
> Does this patch mean I should add device_put in the init and exit functio=
n other than snd_ctl_led_sysfs_remove? This will cause device_release bypas=
s the release method checking?
>
