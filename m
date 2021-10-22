Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6ED4379C1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhJVPVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhJVPVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:21:06 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C10C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:18:48 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id t127so7651535ybf.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fwpfxXx461GW/t9aJZdpXhZ72PsLhaKzoYMsGQ7KVRY=;
        b=jS3yjWXDIs2OA38IxY4wKc8hJJHnIJVkM9H4fOUcOKB27upFSngstRXgglTBCCmHs7
         x8sQ20ObWf/hpUqye8VGZCd/dRt8GsLJxiTOZZokTdx/GZ1Rtx+hxdx0lwGwGxYjN+iS
         f2GPcMqjqF7lURdZfp7ion8tqA0am4HV7AM0DuTmYNmrU3WZCBQFrPk1uZI8yfK/ilZV
         tonxWhZmli844dyy13ukq8rpHrqN9G2hec8UXVJxxv5Fw/vbadFk8Mg1gQ0C5+SJxEiF
         lhpDCKRQoRtEYAY8q9IqFFtECDWNZ5L80ooYzpdwiLkvl9zb2pL+13tKWi3BlkG6fT47
         PhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fwpfxXx461GW/t9aJZdpXhZ72PsLhaKzoYMsGQ7KVRY=;
        b=W+UXKNtMvqkJOdLfj1mLKN6dN+oiQCHuLzKgujuQkB27qVJbydJTR5pPMIE796Q6O8
         K/hs5sCROegVJs/tBg1otnOB1i0kjWVnS+wo0JNUxWnPKRqQu1Rlh63vRdS9SVjbGMdd
         S5A7EknkmtNVh2mp51F9UR0TkUom4GQp/VIgwfoOkl1x3oyyXPI1oZa/DIQkcJ7IHH8m
         qG1uHwxH1FGpSrUtKxS4r2cuD2NSvNgoEIcZsOeuDqV9FuS0fgMN3nk68g/bLNeIotao
         mFs79WYfGAPhklrLPY4j1nFtOCX0tiP1Y3hnvEXZntFQq23LMzltWu8w8b+g+V2YTI6q
         QwSA==
X-Gm-Message-State: AOAM531SilKx1gUD6CdI9/UxZazCFIMPqVoyHOhnP3e9WaPyEGouPzQ7
        Gq0LNlYnCu8KNkzwobDFJPduxIzeGOHfECHunOY=
X-Google-Smtp-Source: ABdhPJyAwPZVO8USIjROBG/1m9oIrEngG7D8J/gdwhG0Su6y+Uv+5HHnEgF7gkq1SLUU3Wt8n4ltkTlovLXxPCchwlQ=
X-Received: by 2002:a25:a4e1:: with SMTP id g88mr409543ybi.58.1634915927698;
 Fri, 22 Oct 2021 08:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211022144040.3418284-1-javierm@redhat.com> <CAEg-Je_v0zvOs1dOZ3P0qsPDO7LC8xk0zxQBLH6gr65V82dnPA@mail.gmail.com>
 <352163b2-2946-aec8-16b4-fd6f01373ff2@redhat.com>
In-Reply-To: <352163b2-2946-aec8-16b4-fd6f01373ff2@redhat.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Fri, 22 Oct 2021 11:18:12 -0400
Message-ID: <CAEg-Je-zP=BZaqK94Ra+P1eiwpDrOy-jmq1YfyPE9XcPp_ZtCg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/aperture: Add param to disable conflicting
 framebuffers removal
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 11:16 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Neal,
>
> Thanks for your feedback.
>
> On 10/22/21 16:56, Neal Gompa wrote:
> > On Fri, Oct 22, 2021 at 10:40 AM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >>
> >> The simpledrm driver allows to use the frame buffer that was set-up by=
 the
> >> firmware. This gives early video output before the platform DRM driver=
 is
> >> probed and takes over.
> >>
> >> But it would be useful to have a way to disable this take over by the =
real
> >> DRM drivers. For example, there may be bugs in the DRM drivers that co=
uld
> >> cause the display output to not work correctly.
> >>
> >> For those cases, it would be good to keep the simpledrm driver instead=
 and
> >> at least get a working display as set-up by the firmware.
> >>
> >> Let's add a drm.remove_fb boolean kernel command line parameter, that =
when
> >> set to false will prevent the conflicting framebuffers to being remove=
d.
> >>
> >> Since the drivers call drm_aperture_remove_conflicting_framebuffers() =
very
> >> early in their probe callback, this will cause the drivers' probe to f=
ail.
> >>
> >> Thanks to Neal Gompa for the suggestion and Thomas Zimmermann for the =
idea
> >> on how this could be implemented.
> >>
> >> Suggested-by: Neal Gompa <ngompa13@gmail.com>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> ---
> >> Hello,
> >>
> >> I'm sending this as an RFC because I wasn't sure about the correct nam=
e for
> >> this module parameter, and also if 'remove_fb=3D0' is intitutive or in=
stead a
> >> parameter that's enabled is preferred (i.e: 'disable_fb_removal=3D1').
> >>
> >
> > In general, I think the patch is fine, but it might make sense to name
> > the parameter after the *effect* rather than the *action*. That is,
> > the effect of this option is that we don't probe and hand over to a
> > more appropriate hardware DRM driver.
> >
> > Since the effect (in DRM terms) is that we don't use platform DRM
> > modules, perhaps we could name the option one of these:
> >
> > * drm.noplatformdrv
> > * drm.simpledrv
> > * drm.force_simple
> >
>
> or maybe drm.disable_handover ? Naming is hard...
>

That would make sense for a parameter named by the action. If we want
to go that route, then I'd be fine with that. My goal is to have
something people understand.

> > I'm inclined to say we should use the drm.* namespace for the cmdline
> > option because that makes it clear what subsystem it affects. The
> > legacy "nomodeset" option kind of sucked because it didn't really tell
> > you what that meant, and I'd rather not repeat that mistake.
> >
>
> Yes, agreed. In fact, that is the case for this patch since the param is
> in the drm module. I just forgot to mention the namespace in the last
> paragraph of the comment.
>

Good to know. :)



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
