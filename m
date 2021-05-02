Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D313709B2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 04:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhEBCuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 22:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhEBCuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 22:50:54 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3EEC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 19:50:03 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id s2so829236uap.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 19:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+QXw9dj6OatVC6+nMGVCyDaTaKRILac2pWCqc7vNvg=;
        b=hzPqrlV3PpfgJo3o4NYVOUbWebeJZGi8DDMY2VHO/0YESpqN2la5cIVlpLViTLP1lW
         AYOvc+X1CcJDjkjDcgt/0Kjo62YJpxEOe2+eacwg8pGuPBMri/6Ps5llwaMtcqBW0kHD
         CpmjviZiB5kGvfNJtdk+PGpDQj6Lxc7mDV/xXhTX6fhy1URuaw0XFFTO+Lt4qiVFhTgd
         n0I+8+8Xf+108NyCmS5X1b7K/7Q6FoyV73nPzYVdsyAC5ujlz0h0lW11ZWV/6d6ympio
         1FoALItd7rJPYD1CrdG7MJoGCV8dHHUeyi7JvoX9TQEgS6kyZuzEnJVycYANBrIOQKL9
         7Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+QXw9dj6OatVC6+nMGVCyDaTaKRILac2pWCqc7vNvg=;
        b=PUlNYITkdrBhOzeyF+TzkfklZVO2SCWkpiqmu7wWjvsItWS10N4UWof06M+ZjcAlHv
         Z53pBurQ8dUF5v2UkWviFU7cbpsbTo01+mM1cwyLc85kqlLcj1x1riLDcK2ui4eAqU0V
         yzypTpCcou9w0+AFb26bpAC9Pw9Qq9ONI4hcdtqJJEQMr1OkkP3O7mu36rIcNAU+AOTm
         zHgpbuM0XO31CqPoML9uiYln2Y5rPasFaVFiMcAp2YSIJVtKDwSb6Xx7noFXkCSldixs
         NxvQssClOe5pWahjIrfdLBDrtnzCh6UyMdnmPPzfnxIZj2KAE3/uTRg1RWrZQ0p2qg6t
         pvwQ==
X-Gm-Message-State: AOAM532h9ajX4LLefXtfOm2a2uHxlI3VUxUG1WEiwkXfYHKDIMRUnYPl
        0Jlx5TfWWsJkBG00kqzK5Yh4rlYSQoR+BLcleKVANIEC
X-Google-Smtp-Source: ABdhPJwdfm4vhgQuwA2DE9TiRM33sy6ri2jgv4I45ShNTi420Gjz/1/AhL6AvMtQPSt4Ogm1OYozNkOInNmnNXndAOI=
X-Received: by 2002:ab0:6031:: with SMTP id n17mr10499173ual.128.1619923801947;
 Sat, 01 May 2021 19:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210428010031.571623-1-jim.cromie@gmail.com> <20210428010031.571623-2-jim.cromie@gmail.com>
 <f2e4773e-45a2-c4cb-24cb-fc8119f10a3a@akamai.com>
In-Reply-To: <f2e4773e-45a2-c4cb-24cb-fc8119f10a3a@akamai.com>
From:   jim.cromie@gmail.com
Date:   Sat, 1 May 2021 20:49:35 -0600
Message-ID: <CAJfuBxwubk2DatnVrHU1C6WiYNKW1CcuQZe29vToMov4Ch0dHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dyndbg: avoid calling dyndbg_emit_prefix when it has
 no work
To:     Jason Baron <jbaron@akamai.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 3:03 PM Jason Baron <jbaron@akamai.com> wrote:
>
> Hi Jim,
>
> On 4/27/21 9:00 PM, Jim Cromie wrote:
> > Wrap function in a static-inline one, which checks flags to avoid
> > calling the function unnecessarily.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  include/linux/dynamic_debug.h | 9 +++++++++
> >  lib/dynamic_debug.c           | 9 ++++++++-
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> > index a57ee75342cf..173535e725f7 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -32,6 +32,15 @@ struct _ddebug {
> >  #define _DPRINTK_FLAGS_INCL_FUNCNAME (1<<2)
> >  #define _DPRINTK_FLAGS_INCL_LINENO   (1<<3)
> >  #define _DPRINTK_FLAGS_INCL_TID              (1<<4)
> > +
> > +#define _DPRINTK_FLAGS_INCL_ANYSITE          \
> > +     (_DPRINTK_FLAGS_INCL_MODNAME            \
> > +      | _DPRINTK_FLAGS_INCL_FUNCNAME         \
> > +      | _DPRINTK_FLAGS_INCL_LINENO)
> > +#define _DPRINTK_FLAGS_INCL_ANY                      \
> > +     (_DPRINTK_FLAGS_INCL_ANYSITE            \
> > +      | _DPRINTK_FLAGS_INCL_TID)
> > +
>
> I'm not sure it's worth having an unused define here by dynamic_debug.c.
>
> I would prefer to just have _DPRINTK_FLAGS_INCL_ANY that has all the flags
> in a single define.


I have another patch to emit_prefix that uses !ANYSITE to return early
if only TID is wanted
but I can split that out,
or maybe I can pull the other patch forward out of the dd-diet-plan
set Im working.





>
> hmmm - looking at __dynamic_emit_prefix() it starts by doing:
>
>
>  589 static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
>  590 {
>  591         int pos_after_tid;
>  592         int pos = 0;
>  593
>  594         *buf = '\0';
>
>
> So now we are missing the string termination if no flags are set...

yes thats wrong.  looks like I can hoist that init into the caller


> Thanks,
>
> -Jason
>

thanks
Jim
