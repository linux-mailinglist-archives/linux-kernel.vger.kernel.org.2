Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF6235E68C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347953AbhDMSiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhDMSiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:38:01 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CECC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:37:40 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id b3so3190165oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9l7MhNlE9zmt6nhNqqiUgq+wfQLEas5zTZd2Qi3n29c=;
        b=QOsR2qML+66/IL/2QygasVpniZsHI8EFVaq3gMigiAz1z0nR9iUZDxl2m8vc9Uas8t
         UbUicdnCbJI38veDYp8o7bnzx7trAahcwjmWnNJVBr58E7Z3wG0AFiuOOdaOa/bhmAPM
         UC7Pc5mHm/MRYrAatiU0fjhGoaF6Ez1LMNg6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9l7MhNlE9zmt6nhNqqiUgq+wfQLEas5zTZd2Qi3n29c=;
        b=BffPuHFy8I39Y8CJaHNfA1mhmUDSSTPUBWkCpF9eMoNldl11MW9KBeUJD6hhkr5n3t
         QTFIXIvBtTzGJPdnXIyhsznDfHBb4JQ5ie1bcp0GlVjg8DrRVtCtDO3Vxe+VI1/j6bHm
         g4R4o0Czyd56dfLNQx3aHrm3kkqg3O75d+JlY1+zJQNSXHUd7iIiLkhnt1lcnGwNAsz9
         wcqhQs+xNHAi7h6pYoDKE3tYv30w65wY+kXNV/RR1t22DNw2XIpEnzh+XKnw8OIpjeNL
         YWF7VBZoAE/WooSPJKovPKoiW3lKJxZDDEzFyVMDhU0ykD4hUw5HKAUcRx/jUC+V3C9r
         cYWg==
X-Gm-Message-State: AOAM53097cEuWm3v6RkQWLj4FCtfEYxIsFSb0tZjPma9/GA0VzsPUAAa
        SzkDVOPULOAKv0FIgt5I7Jom7yTHZrdnLjq1PTrj4Q==
X-Google-Smtp-Source: ABdhPJzt3kTr/mnJ3swKnUlL5iVJ4GtE2T/oWlZHUL1YEPuogvLtGB1kNXErK0jci66Ehs3+KW5l0HK9ayVogLDiydM=
X-Received: by 2002:aca:4188:: with SMTP id o130mr964224oia.101.1618339060149;
 Tue, 13 Apr 2021 11:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210413170508.968148-1-kai.heng.feng@canonical.com> <CADnq5_P7_7jOZWTo+KCj3jOpmyDPN8eH3jNTgg3xLC4V9QM7kQ@mail.gmail.com>
In-Reply-To: <CADnq5_P7_7jOZWTo+KCj3jOpmyDPN8eH3jNTgg3xLC4V9QM7kQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 13 Apr 2021 20:37:29 +0200
Message-ID: <CAKMK7uHR0VDk=C+u1d5qiiqQP+3ad5_gXQwvmPbJ56mG=3RjpQ@mail.gmail.com>
Subject: Re: [PATCH] efifb: Check efifb_pci_dev before using it
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        pjones@redhat.com, Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 8:02 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Apr 13, 2021 at 1:05 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > On some platforms like Hyper-V and RPi4 with UEFI firmware, efifb is not
> > a PCI device.
> >
> > So make sure efifb_pci_dev is found before using it.
> >
> > Fixes: a6c0fd3d5a8b ("efifb: Ensure graphics device for efifb stays at PCI D0")
> > BugLink: https://bugs.launchpad.net/bugs/1922403
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

fbdev is in drm-misc, so maybe you can push this one too?
-Daniel

>
> > ---
> >  drivers/video/fbdev/efifb.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> > index f58a545b3bf3..8ea8f079cde2 100644
> > --- a/drivers/video/fbdev/efifb.c
> > +++ b/drivers/video/fbdev/efifb.c
> > @@ -575,7 +575,8 @@ static int efifb_probe(struct platform_device *dev)
> >                 goto err_fb_dealoc;
> >         }
> >         fb_info(info, "%s frame buffer device\n", info->fix.id);
> > -       pm_runtime_get_sync(&efifb_pci_dev->dev);
> > +       if (efifb_pci_dev)
> > +               pm_runtime_get_sync(&efifb_pci_dev->dev);
> >         return 0;
> >
> >  err_fb_dealoc:
> > @@ -602,7 +603,8 @@ static int efifb_remove(struct platform_device *pdev)
> >         unregister_framebuffer(info);
> >         sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
> >         framebuffer_release(info);
> > -       pm_runtime_put(&efifb_pci_dev->dev);
> > +       if (efifb_pci_dev)
> > +               pm_runtime_put(&efifb_pci_dev->dev);
> >
> >         return 0;
> >  }
> > --
> > 2.30.2
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
