Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1528C395977
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhEaLN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhEaLNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:13:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CFFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:11:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb17so16095346ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CRaLvLXh68H09Zfp4seCpIdzZFvvlshqCqJckzDqmc=;
        b=H+I960k746ql73un5xNsHeDl+HqmrhExRw8VJA0AnvSaliaY8kQcw/DKPsZoYwCNC5
         cQ1hsBRTEgfTlEO9qwbYYPon3jDiJULGt9JFjOHWiNYa8EXnodRprTOZS5SkXihHdCRF
         18fyKaf9VBGdqZZEjZkodq0/nmy+Wl3a42rLaBs9WJEXvjYHM1kbxdmgoNZCk1lEr+B8
         hsmoqFUFZOg3XC4M+2uWpb6ll63GUO5Kb6iuTjd8iOub+YmdM5ueaz23xEa1nraK/F0b
         Y5Y8wZZxGVuyzvUgvenjsuj4p5ccNZt0/7w2hOBU4eSdnduFTMj3ESD89VDSH65T4d+Z
         hvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CRaLvLXh68H09Zfp4seCpIdzZFvvlshqCqJckzDqmc=;
        b=Yynsm6JJC4+YFK1I0LmgAq9gRBt6cLUuIdtH1D8AtwJsi6TxlvK+qjBhReMOA7hA+u
         nsG7dvxzE+KfBli/jC+A+gKnpL389kT4M9U7sD7S+Z14ZFkT7Dedw3hBHIgFQW/8eSp0
         KZIigoZOj+94wkpPP4P+01DiSF+69d5P2x4ZOFTmXoSccYsYwH1sKSPfB318ovkzaqGv
         kBMbvkx47qibfqPOD3UG038O9CT1BszeaVnZZAgGDq0Uboj8lI53AakHjLqZ8T2gDHzC
         O6mLaAC8h8ToEeqK4gBtkhpxRpaK1suAgGqgXaBUxuBWygG6s78NEtN7+ksHktDvDyjN
         h1lw==
X-Gm-Message-State: AOAM530Eu6AAQ3MyUfPx1KIlZ4CLgclzl8gXYFyPltDvRXwGd/Kuukl1
        4jdlH9j6TnUY8N12Jj2sXYUZur3KF8CyZ7Txqr3aTSqaKq6+ww==
X-Google-Smtp-Source: ABdhPJxPMYA4RvOOpmuxpdIkn9OTBgTkBiOKjJDd58HQSAarNrG5xrH0C/ICHXC/R3X0Hydy9/XkI8XUGDZ6+Uu73n4=
X-Received: by 2002:a17:906:6d17:: with SMTP id m23mr22979526ejr.73.1622459503577;
 Mon, 31 May 2021 04:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
 <20210531110144.GA24442@kadam> <20210531110742.GB24442@kadam>
In-Reply-To: <20210531110742.GB24442@kadam>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 31 May 2021 19:11:16 +0800
Message-ID: <CAD-N9QU8uLE=0r3x7dvoSctMnOapr9OyFbCjb=ytO=qC6GCe4g@mail.gmail.com>
Subject: Re: [PATCH] ALSA: control led: fix memory leak in snd_ctl_led_register
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 7:07 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> I've also created a Smatch check for missing ->release() functions.  It
> find one bug in that file.  There are other bugs, but the static checker
> is not clever enough to find them.  I expect Smatch will get smarter
> about this in the coming year.
>
> sound/core/control_led.c:685 snd_ctl_led_sysfs_add() warn: calling put_device() with no ->release() function
>
> So, yeay, I feel like this thread has been useful and I now understand
> put_device() a little better.  Please review the email thread again and
> send a v2 patch.  :)

Sure. No problem. I will send a v2 patch after reading the whole thread again.

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
> #include "smatch_extra.h"
>
> static int my_id;
>
> static void match_put_device(struct expression *expr, const char *name, struct symbol *sym, void *data)
> {
>         struct smatch_state *state;
>
>         state = get_state(SMATCH_EXTRA, name, sym);
>         if (!state ||
>             estate_min(state).value != 0 ||
>             estate_max(state).value != 0)
>                 return;
>
>         sm_warning("calling put_device() with no ->release() function");
> }
>
> void check_no_release(int id)
> {
>         my_id = id;
>
>         if (option_project != PROJ_KERNEL)
>                 return;
>
>         add_function_param_key_hook("put_device", &match_put_device, 0, "$->release", NULL);
>         add_function_param_key_hook("device_unregister", &match_put_device, 0, "$->release", NULL);
> }
>
