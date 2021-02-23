Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3726F322DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhBWPtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:49:09 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:46209 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhBWPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:47:44 -0500
Received: by mail-io1-f52.google.com with SMTP id u8so17523876ior.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+CvRb8uJsnMhLBA4z+SJwvevSaxCnZTQPudMnhz+y8=;
        b=M0kc+GcDAXfDoLDuTMtzaQcnA08poU/GD7IASOJi0xLMdvITERr3Bb6eOPv5kZWxg7
         NmHz+BbsTIj9jHbBginGoDEhS16emMbCEHTfmpaTgoQtinGW5bODHgIusaIUkAIiaSFU
         hhRo0yMLYbBs1dxbN3Sfequ89hslWJvUaewyjDBVrQCTeU9/FBJlAb4cF/WZ3IPMYN7L
         RZOdf9IYZaiL1s3htU84Cedytif6SVh+DUk6zhU3KpGzW/TZCLw5iipQ2xt04ymObliN
         I+eequEJ6yr6YLVi+RLrAkU0zAynNhoLS7FUjQJFoLlTIzfSjFIFSZWAedXXlATBqlRP
         2gbQ==
X-Gm-Message-State: AOAM532qGNRmXC63jqDMDmijqj0n4vivC3+F8F1tth/BkSWAIfaJLKPy
        Ca2ujUv4fpFdUiev2ESod0r1W9GkcqscKwaLLZQ=
X-Google-Smtp-Source: ABdhPJz1kFrzRXcSKPQzV0L9KIq7evTjzIK/fhnl6+WUHdZTdl5LT2+m6x7mNbscJ1uoZ/eP3Tr0b55SGQjjzmQLtUI=
X-Received: by 2002:a6b:f206:: with SMTP id q6mr20237814ioh.143.1614095223592;
 Tue, 23 Feb 2021 07:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20210119015415.2511028-1-lyude@redhat.com> <20210119015415.2511028-2-lyude@redhat.com>
 <YDUN+Re/alMVL0Zn@pflmari> <CAKb7UvhFkw23so-a4JKLzpQLhphzjzarOy-9h+FiKP-aAC=4xw@mail.gmail.com>
 <YDUg/9fjsvTkRUqr@pflmari>
In-Reply-To: <YDUg/9fjsvTkRUqr@pflmari>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Tue, 23 Feb 2021 10:46:52 -0500
Message-ID: <CAKb7Uvji_+N+b8HghZckU-uSBWn-=BZwNAiUff2oitbVuNUE2Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/nouveau/kms/nv50-: Report max cursor size to userspace
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        James Jones <jajones@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jeremy Cline <jcline@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 10:36 AM Alex Riesen
<alexander.riesen@cetitec.com> wrote:
>
> Ilia Mirkin, Tue, Feb 23, 2021 15:56:21 +0100:
> > On Tue, Feb 23, 2021 at 9:26 AM Alex Riesen <alexander.riesen@cetitec.com> wrote:
> > > Lyude Paul, Tue, Jan 19, 2021 02:54:13 +0100:
> > > > diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > > > index c6367035970e..5f4f09a601d4 100644
> > > > --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > > > +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > > > @@ -2663,6 +2663,14 @@ nv50_display_create(struct drm_device *dev)
> > > >       else
> > > >               nouveau_display(dev)->format_modifiers = disp50xx_modifiers;
> > > >
> > > > +     if (disp->disp->object.oclass >= GK104_DISP) {
> > > > +             dev->mode_config.cursor_width = 256;
> > > > +             dev->mode_config.cursor_height = 256;
> > > > +     } else {
> > > > +             dev->mode_config.cursor_width = 64;
> > > > +             dev->mode_config.cursor_height = 64;
> > > > +     }
> > > > +
> > > >       /* create crtc objects to represent the hw heads */
> > > >       if (disp->disp->object.oclass >= GV100_DISP)
> > > >               crtcs = nvif_rd32(&device->object, 0x610060) & 0xff;
> > >
> > > This change broke X cursor in my setup, and reverting the commit restores it.
> > >
> > > Dell Precision M4800, issue ~2014 with GK106GLM [Quadro K2100M] (rev a1).
> > > libdrm 2.4.91-1 (Debian 10.8 stable).
> > > There are no errors or warnings in Xorg logs nor in the kernel log.
> >
> > Could you confirm which ddx is driving the nvidia hw? You can find
> > this out by running "xrandr --listproviders", or also in the xorg log.
>
> xrandr(1) does not seem to list much:
>
> $ xrandr --listproviders
> Providers: number : 1
> Provider 0: id: 0x48 cap: 0xf, Source Output, Sink Output, Source Offload, Sink Offload crtcs: 4 outputs: 5 associated providers: 0 name:modesetting

Thanks - this is what I was looking for. name:modesetting, i.e. the
modesetting ddx driver.

I checked nouveau source, and it seems like it uses a 64x64 cursor no
matter what. Not sure what the modesetting ddx does.

I'd recommend using xf86-video-nouveau in any case, but some distros
have decided to explicitly force modesetting in preference of nouveau.
Oh well. (And regardless, the regression should be addressed somehow,
but it's also good to understand what the problem is.)

Can you confirm what the problem with the cursor is?

  -ilia
