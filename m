Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0F134333F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 16:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhCUPlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 11:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhCUPke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 11:40:34 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57605C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 08:40:34 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b10so11322255iot.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFEl7zRd1y3+Yjl6YpSAci6EecEvaghk0CRZeU1EYug=;
        b=iwAvu2rH2NjnO6TRux4mQwSWkzaQ4bB6mc4ycyeLkNw8QB03szvHYT/JO1FvM/sLIV
         ZJ8ZptUPACF/qtJFVQIf2IlRKGmNmDUhtbu3Sjh4DZBvVKMBviIS9LVGZhcVPZnAmfsf
         ozPBsGvZA9z+swXBKk1rqdzrOfqQ+gysyHJn8g5J5jjQhsoJdw54KFUJwD94ZF9z9gSb
         ombiis1gU8zNwIt5vMwBj9jev1OWzXmyad6ZPSsrI/Q0qrXkjfBeVBiljs+Gg74Kf5zg
         XKduTsMFv52c1+fftEbqOkDgR+jDXBzGKLK6WIW8Gfhkc0GFsZQYQTqef+T0lJdSmy4c
         GFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFEl7zRd1y3+Yjl6YpSAci6EecEvaghk0CRZeU1EYug=;
        b=oCyx121Xyhqx+8A8Rno6bw0Z4DMYZCNg53Mos/o9Bk8nx0lu/BkQvtcXsGnemT5dNd
         lsDauzYYzrgtEZFCJB3186pLjBMVgC12UE+Xdy2gx7Mermc7S8zHyGhyeyG90aYERD6E
         dYBkXX/+Uy+ghNe+RBmMyl59m+zdeXC3ESRvo64+xx00Fn9gn+Y7NVSMtp2YLsFCM3Qg
         rOrtTnHIDUi6IMUEdfYzlIeZAh4yW/tdPa47jX0lzJYYRp5RQcnXLQiWtOImuhGq/KVG
         v/WIidP42iaSe/7WN9QUE8iUzoIccJ4gPz5At2oDkTjuIaxu0RTswCrsfWZ5bAzhzP/m
         lO2g==
X-Gm-Message-State: AOAM532hOE73eYTN3nFsZneQtE/fwwqny+UQ4NEDezgzl77idTSts1pq
        vyiH+dpTV+7VFNg1SYDqpqvy7RU2LGHjHbGYsBk=
X-Google-Smtp-Source: ABdhPJxfezZGN6S4kSlRC4d9WhjUyi4Cow0vVF3nxcd2+q7qH4p7tHEO6zD4Xw2kRMyi5eZwojtKgLAX75USekNds84=
X-Received: by 2002:a02:3085:: with SMTP id q127mr7954477jaq.137.1616341233776;
 Sun, 21 Mar 2021 08:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210320222337.243368-1-ztong0001@gmail.com> <s5htup4exbl.wl-tiwai@suse.de>
In-Reply-To: <s5htup4exbl.wl-tiwai@suse.de>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Sun, 21 Mar 2021 11:40:23 -0400
Message-ID: <CAA5qM4CTdeLN894V9RTsx5kUdYC5g_OsHeyBWqpCwZcQoUZi5w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ALSA: hdsp and hdspm, don't disable device if not enabled
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jasmin Fazlic <superfassl@gmail.com>,
        Mark Brown <broonie@kernel.org>, Joe Perches <joe@perches.com>,
        Tom Rix <trix@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 4:16 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sat, 20 Mar 2021 23:23:33 +0100,
> Tong Zhang wrote:
> >
> > This series fixes issues in hdsp and hdspm. The drivers in question want
> > to disable a device that is not enabled on error path.
> >
> > v2: add fix to rme9652
> >
> > Tong Zhang (3):
> >   ALSA: hdsp: don't disable if not enabled
> >   ALSA: hdspm: don't disable if not enabled
> >   ALSA: rme9652: don't disable if not enabled
>
> Thanks for the patches.
>
> IMO, a safer way for this is to add pci_is_enabled() check in *_free()
> functions around the call of pci_disable_device().  The point is that
> *_free() is the sole destructor function that manages all stuff, hence
> it's better to do all there.  And, of course, it'll be less changes.
>
> Care to resend v3 patches with that?
>
>
> thanks,
>
> Takashi

Thanks Takashi.
I made some changes and sent them as v3.
- Tong
