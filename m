Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ABE3973F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhFANTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbhFANTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:19:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EF8C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 06:17:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id c10so412958eja.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKh2Ei8jzV9/CXBxRyHEePS0EA9HNSzLk2hOx/oYJ4k=;
        b=HQ9vc3xt4K6h3wBVGVk1RUHKoLGWB3dCmt7DKSb0FXG93D28kccxBbZnDtBzZY/3zo
         WbYh74kbE+i1gviuZoLFGcwRULD8ATjQUPW4MXKmnLiO+BWk3/XE/dfYoq1Aa5Ijhd1a
         aLjDroTqqXH7xOZqDRbzDyOkC9xCLUFJroH+++1XNhTh/JvXa2rEPxuqUNzc8oTT6EXn
         IOgN8hrJTvtuUg3V5AuGdIxsFUyFswFrkOGx8RorRZwbcoLiTWWlkqcd0rWIxoCK7SMx
         RKiwByF+RUDeteZjNGnUBYPojs5wILlTXbr8ei+lDpbK7+xBHG3hbQUC9CXwjditfhj6
         X5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKh2Ei8jzV9/CXBxRyHEePS0EA9HNSzLk2hOx/oYJ4k=;
        b=IxoNrjxaCGYtAv6q5y+Jw0NO6iUiiX9l1YU1ApsJ6uuskRaQLLEl6vXj+/fmP0hkhj
         RxLWgkBfO500IcuXNz1l/7COX41M4XdLmzBGa4Tib6747JEuNdRA3fcywBQ1RKZjsVf0
         ihcR254KCQT/U+TrxLScXOHhLr5yGe/I8rmZQX919Ozq1YG3dRfCFxyBZ771qosmIHjd
         KkCyK/W1Epjqe8/dWEi4nZQmHXTYzfheofBSD02z9GsjvxXBacjONrGVP21bjiC06T05
         VjZuIKjGl0pbdcw/cJmeQeU/8uhOjNXGOyzydemV2jwjO6TnOBd9lTRYGkKFfTtfP70l
         KZEQ==
X-Gm-Message-State: AOAM530QWjfvv5s1GOsVtjDdYgxTX7z2p/GbsO1X1+q8iIWzRT/DmdFR
        7s15Pu0vYKDKYM2UDIiJ3eY05Y1Ogfc9ky6nr2w=
X-Google-Smtp-Source: ABdhPJyQnE7jFPI8F35dp5ym75hvc65OIPHWxwMvuFuH1SiWmhA/7IclLnr4D5D57h4leWNh7CLmxTo6psRoVfFq2VQ=
X-Received: by 2002:a17:906:148f:: with SMTP id x15mr28460712ejc.535.1622553451894;
 Tue, 01 Jun 2021 06:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com> <20210531110144.GA24442@kadam>
In-Reply-To: <20210531110144.GA24442@kadam>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 1 Jun 2021 21:17:04 +0800
Message-ID: <CAD-N9QW17fVZhaLY=CLPj9EbTLpG9qFNcGYZ0MhGxg_E0df1Uw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: control led: fix memory leak in snd_ctl_led_register
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 7:02 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
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
> Just to clarify again some more, this call back has to free "led_card".
> This patch changes the memory leak into a use after free bug. (A use
> after free bug is worse than a memory leak).

Hi Dan,

I have read the whole thread several times. I don't quite understand
why you think this call back needs to free "led_card". In current
implementation, the led_card is allocated in snd_ctl_led_sysfs_add,
and released in snd_ctl_led_sysfs_remove. It seems there is no logic
issue. If we keep a dump function here, I think there should no UAF.

I agree with you. We shall be very careful about any added release
function. It might turn a memory leak into double-free or
use-after-free.

>
> There were some other leaks as discussed where a dummy free function is
> fine because they were dealing with static data structures (not
> allocated memory).
>
> > +
> >  /*
> >   * sysfs
> >   */
> > @@ -663,6 +667,7 @@ static void snd_ctl_led_sysfs_add(struct snd_card *card)
> >               led_card->number = card->number;
> >               led_card->led = led;
> >               device_initialize(&led_card->dev);
> > +             led_card->dev.release = snd_ctl_led_release;
> >               if (dev_set_name(&led_card->dev, "card%d", card->number) < 0)
> >                       goto cerr;
> >               led_card->dev.parent = &led->dev;
> > @@ -701,6 +706,7 @@ static void snd_ctl_led_sysfs_remove(struct snd_card *card)
> >               sysfs_remove_link(&card->ctl_dev.kobj, link_name);
> >               sysfs_remove_link(&led_card->dev.kobj, "card");
> >               device_del(&led_card->dev);
> > +             put_device(&led_card->dev);
> >               kfree(led_card);
> >               led->cards[card->number] = NULL;
> >       }
>
> Btw, I have created a Smatch warning for this type of code where we
> have:
>
>         put_device(&foo->dev);
>         kfree(foo);

I don't think this should be a bug pattern. put_device will drop the
final reference of one object with struct device and invoke
device_release to release some resources.

The release function should only clean up the internal resources in
the device object. It should not touch the led_card which contains the
device object.

>
> sound/core/control_led.c:709 snd_ctl_led_sysfs_remove() warn: freeing device managed memory: 'led_card'
>
> So hopefully that will prevent future similar bugs.  I'll test it out
> overnight and report back tomorrow how it works.
>
> regards,
> dan carpenter
>
> /*
>  * Copyright (C) 2021 Oracle.
>  *
>  * This program is free software; you can redistribute it and/or
>  * modify it under the terms of the GNU General Public License
>  * as published by the Free Software Foundation; either version 2
>  * of the License, or (at your option) any later version.
>  *
>  * This program is distributed in the hope that it will be useful,
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  * GNU General Public License for more details.
>  *
>  * You should have received a copy of the GNU General Public License
>  * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
>  */
>
> #include "smatch.h"
>
> static int my_id;
>
> STATE(managed);
>
> static void set_ignore(struct sm_state *sm, struct expression *mod_expr)
> {
>         set_state(my_id, sm->name, sm->sym, &undefined);
> }
>
> static void match_put_device(const char *fn, struct expression *expr, void *param)
> {
>         struct expression *arg;
>
>         arg = get_argument_from_call_expr(expr->args, PTR_INT(param));
>         arg = strip_expr(arg);
>         if (!arg || arg->type != EXPR_PREOP || arg->op != '&')
>                 return;
>         arg = strip_expr(arg->unop);
>         if (!arg || arg->type != EXPR_DEREF)
>                 return;
>         arg = strip_expr(arg->deref);
>         if (arg && arg->type == EXPR_PREOP && arg->op == '*')
>                 arg = arg->unop;
>         set_state_expr(my_id, arg, &managed);
> }
>
> static void match_free(const char *fn, struct expression *expr, void *param)
> {
>         struct expression *arg;
>         char *name;
>
>         arg = get_argument_from_call_expr(expr->args, PTR_INT(param));
>         if (get_state_expr(my_id, arg) != &managed)
>                 return;
>         name = expr_to_str(arg);
>         sm_warning("freeing device managed memory: '%s'", name);
>         free_string(name);
> }
>
> void check_put_device(int id)
> {
>         my_id = id;
>
>         if (option_project != PROJ_KERNEL)
>                 return;
>
>         add_function_hook("put_device", &match_put_device, INT_PTR(0));
>         add_function_hook("device_unregister", &match_put_device, INT_PTR(0));
>
>         add_function_hook("kfree", &match_free, INT_PTR(0));
>         add_modification_hook(my_id, &set_ignore);
> }
