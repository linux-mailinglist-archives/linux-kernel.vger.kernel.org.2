Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D586A394395
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhE1Nw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbhE1Nwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:52:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4D5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:51:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l3so5485675ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onRUdRcxNeN6AVsu4VKeJQ+UQbP3xs8LpXPjnAqcXc8=;
        b=jxBfkIfGhWECkl53LRrTXxtiCB6D8bkzCWImvbRkFYfAghiIx4agRpAznuIh6jPqlv
         8RxoYH+DubIkSnQirszDFwAyvMrVKdPI47ISuK8ZbBNhjdrG+Rdttcrtr7Y+OT7JFHyo
         OIiQ+whsojq7bx6y8gyg8IsJ48oGCo8A2X9R3VdlNB7YLB8st5WmyjNVfy5HZmkcuLVo
         GSrBHB7jstTybPJpkKgupXf9UH5vvSssOrTouMH082SKp1qbIFYI7wS+hRj1kzd2uRei
         aZNI6+Bq4zOkMXAUfC8fPcjF+nxVBcWVYHwL91pSfQWkGMu6QNtueWJVLY/LYjfmBfh8
         hqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onRUdRcxNeN6AVsu4VKeJQ+UQbP3xs8LpXPjnAqcXc8=;
        b=uKgjYTdXilCO2/WIHmLVBlzXkVe1NFiDyIQZz/uUcbolrGdIzgrb40qWu0VugDy2zo
         R8ORyL78JqTmTuLG0hnxek2u32uq27J1Fr62LYExRHY5VP39GAvAX3CD7bGahH5O8KhZ
         el/dq38rRnB8kUpOa61OkmlPSfNQWWV0C+yF8sIC/aAp+9gOQ5t61i7rkTMeWke1/XV3
         K4/TFLh5icyTcTLSKqKwf2zS0B5qfeIL0fQV63dOjSPOEhg+wUClVvrfl8R92c+DfiSd
         6EKSG72LkwSyGk9ddkKgMEMCpf0XbLrmVQskWGqXQVSQeaobS0TTKj+uESE2R5nFDjW7
         QYTA==
X-Gm-Message-State: AOAM530iM68aqkzM+AYmnXKPmwiwBQG4H+QfV0qkN69SJQ2Kmtsaet1/
        sdHJF430tl0c9QOtWtEwWhpcnaGG8kSZw9EwXk4=
X-Google-Smtp-Source: ABdhPJx9YVBhKVLFitWH3X96et2+PSjDzS8OddAowo9TocvFnd2QFOGJAmAI6qRLyxiXY4Gyg8S3I6hZEhluCPaAdpI=
X-Received: by 2002:a17:906:73d7:: with SMTP id n23mr9154549ejl.135.1622209878522;
 Fri, 28 May 2021 06:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com> <20210528133309.GR24442@kadam>
In-Reply-To: <20210528133309.GR24442@kadam>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 28 May 2021 21:50:49 +0800
Message-ID: <CAD-N9QVWcEJjoziA6HVoQiUueVaKqAJS5Et60zvCvuUE7e6=gg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: control led: fix memory leak in snd_ctl_led_register
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-

On Fri, May 28, 2021 at 9:33 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, May 28, 2021 at 09:17:57PM +0800, Dongliang Mu wrote:
> > The snd_ctl_led_sysfs_add and snd_ctl_led_sysfs_remove should contain
> > the refcount operations in pair. However, snd_ctl_led_sysfs_remove fails
> > to decrease the refcount to zero, which causes device_release never to
> > be invoked. This leads to memory leak to some resources, like struct
> > device_private.
> >
> > Fix this by calling put_device at the end of snd_ctl_led_sysfs_remove
> >
> > Reported-by: syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
> > Fixes: a135dfb5de1 ("ALSA: led control - add sysfs kcontrol LED marking layer")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  sound/core/control_led.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> > index 25f57c14f294..fff2688b5019 100644
> > --- a/sound/core/control_led.c
> > +++ b/sound/core/control_led.c
> > @@ -371,6 +371,10 @@ static void snd_ctl_led_disconnect(struct snd_card *card)
> >       snd_ctl_led_refresh();
> >  }
> >
> > +static void snd_ctl_led_release(struct device *dev)
> > +{
> > +}
>
> Whatever you're trying to do, adding a dummy function is never the
> answer.

I see your point. This function I added is not to fix the root cause,
but to fix an issue caused by the release function when the device is
released.

The put_device is to fix the root cause(i.e., decrease the refcount to
zero), however, the result is dev->p and kobject can be freed, but it
will trigger a WARN [1] as it has no release method.

I don't know how to craft a release method for such a device. So this
dummy function is generated following the default_release, also a
dummy function.

Can you please give some advise on how to fix this WARN issue?

[1] https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L2110

>
> regards,
> dan carpenter
>
