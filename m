Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5EE322CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhBWO5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:57:15 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:42314 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbhBWO5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:57:13 -0500
Received: by mail-io1-f50.google.com with SMTP id u20so17340318iot.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 06:56:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlV7um2EY+vl+2ZBJzHoUyA7guYZm1/i3OsQfILG6rY=;
        b=rc75seAxPN4cOJptMBCbuQLlsLKVDZNMUvNJAHyiqxLQ8Pkn2V4TCWGa1AS7+0JJ9/
         yjhA970DcT1pQnmaoeaJhx+7YkcetA5Pj1nbST20V46/j3Ob776nYcnO1L165jVqtCwK
         7YCljRa7WwxMDjH5b6l5sSSbwqhGXn3FB3NQMssEu055IfIkZQdQbjUZqLoxQTT0VDt6
         9LGRrl9SXrB4wyU0O1h9PEbFaQb45D7Ll1WrPuNKnmNDwdu3No+a9iHHFrXs1mBzTXsQ
         y5Ux55uRAHltpT23KT0wP+QAwkFJsCtg2z3Tv/nJzomvZqIj0a4T+Jurih8UefKmj4sc
         jRaQ==
X-Gm-Message-State: AOAM533wXzmarlIULw1wKjFZF0Upa1RmnmOnbjMufopShF0g+0mkAse/
        Tj5HO9BN/qrGGconBgr0KmoaTAocVIjzGidneTo=
X-Google-Smtp-Source: ABdhPJzRZwXRb1la0GMwx+ZhoDIz+aEfwGxnH+TD2zlplxcjV1p+0QmI6jsxIrIxkFQXPlk3s9buU4XAusngiI4vY4k=
X-Received: by 2002:a05:6602:24cb:: with SMTP id h11mr20201100ioe.79.1614092192347;
 Tue, 23 Feb 2021 06:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20210119015415.2511028-1-lyude@redhat.com> <20210119015415.2511028-2-lyude@redhat.com>
 <YDUN+Re/alMVL0Zn@pflmari>
In-Reply-To: <YDUN+Re/alMVL0Zn@pflmari>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Tue, 23 Feb 2021 09:56:21 -0500
Message-ID: <CAKb7UvhFkw23so-a4JKLzpQLhphzjzarOy-9h+FiKP-aAC=4xw@mail.gmail.com>
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

On Tue, Feb 23, 2021 at 9:26 AM Alex Riesen
<alexander.riesen@cetitec.com> wrote:
>
> Lyude Paul, Tue, Jan 19, 2021 02:54:13 +0100:
> > diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > index c6367035970e..5f4f09a601d4 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > @@ -2663,6 +2663,14 @@ nv50_display_create(struct drm_device *dev)
> >       else
> >               nouveau_display(dev)->format_modifiers = disp50xx_modifiers;
> >
> > +     if (disp->disp->object.oclass >= GK104_DISP) {
> > +             dev->mode_config.cursor_width = 256;
> > +             dev->mode_config.cursor_height = 256;
> > +     } else {
> > +             dev->mode_config.cursor_width = 64;
> > +             dev->mode_config.cursor_height = 64;
> > +     }
> > +
> >       /* create crtc objects to represent the hw heads */
> >       if (disp->disp->object.oclass >= GV100_DISP)
> >               crtcs = nvif_rd32(&device->object, 0x610060) & 0xff;
>
> This change broke X cursor in my setup, and reverting the commit restores it.
>
> Dell Precision M4800, issue ~2014 with GK106GLM [Quadro K2100M] (rev a1).
> libdrm 2.4.91-1 (Debian 10.8 stable).
> There are no errors or warnings in Xorg logs nor in the kernel log.

Hi Alex,

Could you confirm which ddx is driving the nvidia hw? You can find
this out by running "xrandr --listproviders", or also in the xorg log.

Thanks,

  -ilia
