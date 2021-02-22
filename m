Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6CA32112C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 08:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhBVHJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 02:09:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52889 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhBVHJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:09:14 -0500
Received: from mail-lj1-f200.google.com ([209.85.208.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lE5KZ-0006Bg-Md
        for linux-kernel@vger.kernel.org; Mon, 22 Feb 2021 07:08:31 +0000
Received: by mail-lj1-f200.google.com with SMTP id w17so3736169lji.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 23:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQb/U05beEqXDSOnU2R2gxKRYcy1C5Xug7vclRhtUZo=;
        b=JLwN7VzRSQrVUIwHNWU7ieXCu+HOC7V2C5eSQBZwqmsquHIRQmJhSNzZs3wXOIGuXL
         oai4Kprw4ZT8pq20ho6k2kC8eIvgRZd95bHyS+V0NDwZ58lSQYVdYUee1N5Ote8devW+
         UXx9H7BPgbnNZ8YXmy5EFmKgODfH0ATRQHWlhx5nkyrZzZpESs/SDVp7ni2qG++Wox+D
         Zd6U6HyklYDxQUV1doUjl1yCgly/gOWZzpJ2EDv6RX5wvUSAM4o8y9jynD0yC2ZmwOtt
         r+BnCOH/ddapVjRKyMaUgcS2MxB8ZEqIe+kWz6mkJ7zyKjaM6DhULbXyBvv0iJZjj/eJ
         avRA==
X-Gm-Message-State: AOAM532a0fWxKn/E5NhX1tjM8otuLxdEMEqbZcZhcwMWHes4SqFdhXOm
        RTAM80ZabZvKeZ82MvaIumwMfXVlO/3yBAHTu0aMNXTujJYCI3FQBEYJJFwxBtXIVG5sbtRhuSe
        tau4VseCly+MzpLX8OHeEi8ZJIKH+5KiXM3t5xgWpY333ZPDoyCpOyfd4iQ==
X-Received: by 2002:a05:6512:b1b:: with SMTP id w27mr12697033lfu.10.1613977711172;
        Sun, 21 Feb 2021 23:08:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmwJFwD2hfSbm4znFNjHvhOMUpClGNSy8bAWfw5K3mLGPr7XuvEwm2N8RU7BjYzrcSZSXdCO0BDnrFKhpgUyk=
X-Received: by 2002:a05:6512:b1b:: with SMTP id w27mr12697017lfu.10.1613977710921;
 Sun, 21 Feb 2021 23:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20210129084327.986630-1-kai.heng.feng@canonical.com> <CADnq5_MduzcezmAjEGK0X7bDiY98f68s8roXc6gOTWjcpNC9Rw@mail.gmail.com>
In-Reply-To: <CADnq5_MduzcezmAjEGK0X7bDiY98f68s8roXc6gOTWjcpNC9Rw@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 22 Feb 2021 15:08:19 +0800
Message-ID: <CAAd53p4y+A5Bv4nUKZw+kzrmxcYm8DXrY06QqkU4iopj0dRrzw@mail.gmail.com>
Subject: Re: [PATCH] efifb: Ensure graphics device for efifb stays at PCI D0
To:     pjones@redhat.com
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 11:21 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Sat, Jan 30, 2021 at 6:27 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > We are seeing root ports on some desktop boards support D3cold for
> > discrete graphics card. So when efifb is in use while graphics device
> > isn't bound to a driver, PCI and ACPI will put the graphics to D3cold
> > when runtime suspend kicks in, makes efifb stop working.
> >
> > So ensure the graphics device won't be runtime suspended, to keep efifb
> > work all the time.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

A gentle ping...

>
> > ---
> >  drivers/video/fbdev/efifb.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> > index e57c00824965..19edd7206409 100644
> > --- a/drivers/video/fbdev/efifb.c
> > +++ b/drivers/video/fbdev/efifb.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/printk.h>
> >  #include <linux/screen_info.h>
> > +#include <linux/pm_runtime.h>
> >  #include <video/vga.h>
> >  #include <asm/efi.h>
> >  #include <drm/drm_utils.h> /* For drm_get_panel_orientation_quirk */
> > @@ -575,6 +576,7 @@ static int efifb_probe(struct platform_device *dev)
> >                 goto err_fb_dealoc;
> >         }
> >         fb_info(info, "%s frame buffer device\n", info->fix.id);
> > +       pm_runtime_get_sync(&efifb_pci_dev->dev);
> >         return 0;
> >
> >  err_fb_dealoc:
> > @@ -601,6 +603,7 @@ static int efifb_remove(struct platform_device *pdev)
> >         unregister_framebuffer(info);
> >         sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
> >         framebuffer_release(info);
> > +       pm_runtime_put(&efifb_pci_dev->dev);
> >
> >         return 0;
> >  }
> > --
> > 2.29.2
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
