Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A6D4005C6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbhICTXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbhICTXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:23:47 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAD9C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:22:46 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id n63so179247vsc.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MdMXgAi9xhJwsQRjrZfawPYCwx2RDb+dIjCSNtGUvMY=;
        b=eRN7yapVLK9w0fTrKsOyuiL9ebnqz8i3ECnJpUPuFrJ3o34wrGJDXLLjvLGCusaaTF
         svGKU/62fC5Zm2uqiy7Gq2ciKhqmOguTZ9FEkM5mo7jRj243b9S7FqxD2SVsj2Afxq+H
         8mBXAdpz40WYkdoZvSMISp7sOv8pbaSUTfWJZ3an0fJEkPJK6gCxMzkeQE9xeZUYKMCD
         QSk49iiJyshVJXVZTl89B/B+Th2Rq/jsW+uaN8kobzX39AqQ4uJxZMfCh3cVWJnAuKZN
         L8O9SwyFxwcPYX+rs7/TjTl6PtxzSuSEHL24cKcIJeBWRPOO6m3840HNeZQ2vBSva3Wt
         gvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MdMXgAi9xhJwsQRjrZfawPYCwx2RDb+dIjCSNtGUvMY=;
        b=RN7CLgsnWhSaQibsvJt1RRFZ1MCe8FLvxwA/FNvdAwSIemiKLXZv5oW4dbEsKH8ptU
         BXY86TJDuIhRUmvEHhgt5VOFXgabOxEF+WkNcNO8cVuFi+zfB+fzh+s18ngB/LvHCIT3
         b2DAhEyYyrFb40SBGTN0Sk3urK/aQriBwXg75w7KtMQB4VJ0oNgVj9auHSxjmHE/NHpx
         j5nCKhiNgCPiNG7Hnld3vBsz61OHY1TPTbTa20713OHPswuBu4j8vVRMdtNcT/vJMiTi
         TPRBO4oINELqR3xGacTJtl+kL7kuUhzeQ/P7REV4VQ7dsD47hqVGzsQGNdZNaGzGC4F+
         MBoA==
X-Gm-Message-State: AOAM530PyO63lTiz1Jp3sVHBQezEaVfpt3ljBdx4b7I9AiOFJCYx7HDz
        tgd8cV79MDzlXny17ekPSHmmrteqAeP8NZoj2DyyRd9usjI=
X-Google-Smtp-Source: ABdhPJyQhdlOGNgq/F67sNH2Ya6oqz77IfwN3oOH0tdgX3ely67VRTOYdk1XXyJBjQA9XVI9iCsDo6AHhdLYWYjHmdc=
X-Received: by 2002:a67:401:: with SMTP id 1mr508836vse.48.1630696965751; Fri,
 03 Sep 2021 12:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210831202133.2165222-1-jim.cromie@gmail.com>
 <20210831202133.2165222-4-jim.cromie@gmail.com> <9fe5e962-e65e-6844-269a-058cce944a89@linux.intel.com>
In-Reply-To: <9fe5e962-e65e-6844-269a-058cce944a89@linux.intel.com>
From:   jim.cromie@gmail.com
Date:   Fri, 3 Sep 2021 13:22:19 -0600
Message-ID: <CAJfuBxz+cZyyDSBrDR0+Rf7K9fqpmeAfcWb1x2MkwD0P9LuDcQ@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v7 3/8] i915/gvt: use DEFINE_DYNAMIC_DEBUG_CATEGORIES
 to create "gvt:core:" etc categories
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 5:07 AM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 31/08/2021 21:21, Jim Cromie wrote:
> > The gvt component of this driver has ~120 pr_debugs, in 9 categories
> > quite similar to those in DRM.  Following the interface model of
> > drm.debug, add a parameter to map bits to these categorizations.
> >
> > DEFINE_DYNAMIC_DEBUG_CATEGORIES(debug_gvt, __gvt_debug,
> >       "dyndbg bitmap desc",
> >       { "gvt:cmd: ",  "command processing" },
> >       { "gvt:core: ", "core help" },
> >       { "gvt:dpy: ",  "display help" },
> >       { "gvt:el: ",   "help" },
> >       { "gvt:irq: ",  "help" },
> >       { "gvt:mm: ",   "help" },
> >       { "gvt:mmio: ", "help" },
> >       { "gvt:render: ", "help" },
> >       { "gvt:sched: " "help" });
> >

BTW, Ive dropped the help field, its already handled, dont need to clutter.


> > The actual patch has a few details different, cmd_help() macro emits
> > the initialization construct.
> >
> > if CONFIG_DRM_USE_DYNAMIC_DEBUG, then -DDYNAMIC_DEBUG_MODULE is added
> > cflags, by gvt/Makefile.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> > v5:
> > . static decl of vector of bit->class descriptors - Emil.V
> > . relocate gvt-makefile chunk from elsewhere
> > v7:
> > . move ccflags addition up to i915/Makefile from i915/gvt
> > ---
> >   drivers/gpu/drm/i915/Makefile      |  4 ++++
> >   drivers/gpu/drm/i915/i915_params.c | 35 ++++++++++++++++++++++++++++++
>
> Can this work if put under gvt/ or at least intel_gvt.h|c?
>

I thought it belonged here more, at least according to the name of the
config.var

CONFIG_DRM_USE_DYNAMIC_DEBUG.

I suppose its not a great name, its narrow purpose is to swap
drm-debug api to use dyndbg.   drm-evrything already "uses"
dyndbg if CONFIG_DYNAMIC_DEBUG=y, those gvt/pr_debugs in particular.

Theres also CONFIG_DYNAMIC_DEBUG_CORE=y,
which drm basically ignores currently.

So with the name CONFIG_DRM_USE_DYNAMIC_DEBUG
it seemed proper to arrange for that  to be true on DD-CORE=y builds,
by adding -DDYNAMIC_DEBUG_MODULE

Does that make some sense ?
How to best resolve the frictions ?
new CONFIG names ?

> >   2 files changed, 39 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> > index 4f22cac1c49b..5a4e371a3ec2 100644
> > --- a/drivers/gpu/drm/i915/Makefile
> > +++ b/drivers/gpu/drm/i915/Makefile
> > @@ -30,6 +30,10 @@ CFLAGS_display/intel_fbdev.o = $(call cc-disable-warning, override-init)
> >
> >   subdir-ccflags-y += -I$(srctree)/$(src)
> >
> > +#ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
> > +ccflags-y += -DDYNAMIC_DEBUG_MODULE
> > +#endif
>
> Ignores whether CONFIG_DRM_I915_GVT is enabled or not?
>

not intentionally.
I think theres 2 things youre noting:

1 - make frag into gvt/Makefile
I had it there earlier, not sure why I moved it up.
maybe some confusion on proper scope of the flag.


2 - move new declaration code in i915-param.c inside the gvt ifdef

Im good with that.
I'll probably copy the ifdef wrapper down rather than move the decl up.
ie:

#if __and(IS_ENABLED(CONFIG_DRM_I915_GVT),
  IS_ENABLED(CONFIG_DRM_USE_DYNAMIC_DEBUG))

unsigned long __gvt_debug;
EXPORT_SYMBOL(__gvt_debug);


> > +
> >   # Please keep these build lists sorted!
> >
> >   # core driver code
> > diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
> > index e07f4cfea63a..e645e149485e 100644
> > --- a/drivers/gpu/drm/i915/i915_params.c
> > +++ b/drivers/gpu/drm/i915/i915_params.c
> > @@ -265,3 +265,38 @@ void i915_params_free(struct i915_params *params)
> >       I915_PARAMS_FOR_EACH(FREE);
> >   #undef FREE
> >   }
> > +
> > +#ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
> > +/* todo: needs DYNAMIC_DEBUG_MODULE in some cases */
> > +
> > +unsigned long __gvt_debug;
> > +EXPORT_SYMBOL(__gvt_debug);
> > +
> > +#define _help(key)   "\t    \"" key "\"\t: help for " key "\n"
> > +
> > +#define I915_GVT_CATEGORIES(name) \
> > +     " Enable debug output via /sys/module/i915/parameters/" #name   \
> > +     ", where each bit enables a debug category.\n"                  \
> > +     _help("gvt:cmd:")                                               \
> > +     _help("gvt:core:")                                              \
> > +     _help("gvt:dpy:")                                               \
> > +     _help("gvt:el:")                                                \
> > +     _help("gvt:irq:")                                               \
> > +     _help("gvt:mm:")                                                \
> > +     _help("gvt:mmio:")                                              \
> > +     _help("gvt:render:")                                            \
> > +     _help("gvt:sched:")
> > +
> > +DEFINE_DYNAMIC_DEBUG_CATEGORIES(debug_gvt, __gvt_debug,
> > +                             I915_GVT_CATEGORIES(debug_gvt),
> > +                             _DD_cat_("gvt:cmd:"),
> > +                             _DD_cat_("gvt:core:"),
> > +                             _DD_cat_("gvt:dpy:"),
> > +                             _DD_cat_("gvt:el:"),
> > +                             _DD_cat_("gvt:irq:"),
> > +                             _DD_cat_("gvt:mm:"),
> > +                             _DD_cat_("gvt:mmio:"),
> > +                             _DD_cat_("gvt:render:"),
> > +                             _DD_cat_("gvt:sched:"));
> > +
> > +#endif
>
> So just the foundation - no actual use sites I mean? How would these be
> used from the code?
>

there are 120 pr_debug "users" :-)

no users per se, but anyone using drm.debug
/sys/module/drm/parameters/debug
might use this too.
its a bit easier than composing queries for >/proc/dyamic_debug/control




> Regards,
>
> Tvrtko
