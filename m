Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE33DDF5B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhHBShT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:37:17 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37866C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 11:37:07 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id k24so2060008vsg.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IpKyihB3M+3oinMY5i464lWGHngiMrlvZE39L5yuKac=;
        b=IELFFR56N8LyPmwrNGKlS1ao8vH/LLrw5ZS44V5f8D3W1JRnUh+LPgTzqBlU8FgoE8
         fGGimjIp5iIsWIAIkJ35I5YGoLfKQoJrxQZRnTaj/YUANaLxOODm961BVRPP4fr6h7k3
         CwtQLVbWYB0iEirh0GGxW+0thmIhG5wHoASQX/luG9Xj+JsIr/NssxM5XxQ0PrkJM11A
         2VJEKixVg6QFXFzsBqsqNM2funSFiKMT3NRmOmn5alXZcLarqoL7QOcIZgGjCIV5Qene
         Z65cCkyLEtI5gkfeNntJ6lCMBvHJmtCe171UlD+regWNlwSnh0iE/oXwKOxH4IoM5hKm
         8wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IpKyihB3M+3oinMY5i464lWGHngiMrlvZE39L5yuKac=;
        b=oWspvbXZOAZtcG446Wh/pLzF7EazCmxMwucvXqay9gKjb11Oke5o9YrsxKkYUkVqIV
         t4Gd+fCIQ1elr5Ysu9XEcWe8+L2eyJHrgcexHRfeA0+F14sINBLh/uaHmeg3UtLJ11pi
         Nq8ptGyjSN6qFYEmTgpdN2VxTy3T4ZUL0oct7YU4QGneFriuP15uo4/K/mk9EdvjKjwC
         fud4ZBnk82fT01xdGtp4358wHJ83eVYKxOGulNdRG3o3q1Us2/cARN2zzJDQrrrdmrEc
         p0dCtTFY8b4Fst8TdCIu9cAUApvOGZYQZehICXOR+zwv0ke3VbAu9IYfiARSjkqkdY/A
         mlJQ==
X-Gm-Message-State: AOAM530ZpasdeqmATMU3oKUKx+jKzZm9EUcfTbtuxBcXS46foMsr8BFc
        XAOBCXxTPjPoLPQJiAlL1AkXrILC6oztsOhl8jM=
X-Google-Smtp-Source: ABdhPJzjo/9qOXG0fdeyFyvhz+Aj/p8NcNMo/+WII7wlKLWCAd3lrkIimR0VXnppY4xXe7pst3ulKKdyrBotgKBzXac=
X-Received: by 2002:a67:f58c:: with SMTP id i12mr1373736vso.7.1627929426283;
 Mon, 02 Aug 2021 11:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210731214211.657280-1-jim.cromie@gmail.com> <20210731214211.657280-3-jim.cromie@gmail.com>
 <CACvgo50DDp3p=-2mzY8jvzuLo_4_1L+b8=x6ZRERtcVJUHcomQ@mail.gmail.com>
In-Reply-To: <CACvgo50DDp3p=-2mzY8jvzuLo_4_1L+b8=x6ZRERtcVJUHcomQ@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Mon, 2 Aug 2021 12:36:39 -0600
Message-ID: <CAJfuBxzsLToskA_dtdmsvQdSnEoDRgmrQycZ_nCKm4yQDqJ5Pg@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] moduleparam: add data member to struct kernel_param
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Wyatt Wood <Wyatt.Wood@amd.com>, Jessica Yu <jeyu@kernel.org>,
        Johan Hovold <johan@kernel.org>, Joe Perches <joe@perches.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 10:18 AM Emil Velikov <emil.l.velikov@gmail.com> wrote:
>
> Hi Jim,
>
> On Sat, 31 Jul 2021 at 22:42, Jim Cromie <jim.cromie@gmail.com> wrote:
>
> > Use of this new data member will be rare, it might be worth redoing
> > this as a separate/sub-type to keep the base case.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  include/linux/moduleparam.h | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> > index eed280fae433..e9495b1e794d 100644
> > --- a/include/linux/moduleparam.h
> > +++ b/include/linux/moduleparam.h
> > @@ -78,6 +78,7 @@ struct kernel_param {
> >                 const struct kparam_string *str;
> >                 const struct kparam_array *arr;
> >         };
> > +       void *data;
>
> Might as well make this "const void *" since it is a compile-time constant?
>

yes indeed. revising.  thanks

> -Emil
