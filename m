Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE63627C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbhDPSap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbhDPSam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:30:42 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397D8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 11:30:17 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r186so993190oif.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 11:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2URQPxDc6xW1AaRajqTpp369cvO98uJ1uS2r5+fbu3k=;
        b=bvGRbApMkBauGUNafe/fhcXAyutILbCc9hjQGaXx7Y/ch2K9GsqGKMPlGE8C+YQN/G
         WO9/tFzpbpG7buc8WnD3yg4kA2pbNAfOl5i9iiCic9ohQgHlA2cczv2atpvGoEoGyfGz
         nCmk+k2ijBj3kd6i5KA+nB4lBrk4UcrY3460U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2URQPxDc6xW1AaRajqTpp369cvO98uJ1uS2r5+fbu3k=;
        b=DY2DqOgZKpBaefuQfkLe0LBWFspQwdN9e1QItIB9nRmZVYMXDr3f4zIxz5uEjNVh5q
         PsD3zkffzfkhZOs4Ph6c45QgqWiRLf2n8+Ulo9Fwkq5iWwS/A/ALZ/djA7dMZyPQTUuW
         xhJ8sd3vByLZhu9tHlZ/PmuOeOtcUDufuJfx7OoIlTy+6b4u3XIvUZgGc93ZAv57UzGm
         8D/p19wcJyo8uPGt8bF3mFpSSJgULNWEWC3Chg9Z0BjCoFtp5/xk44OW2RdYcMKy76/G
         Au29t/4V0d6CnjcQ0KRNyJF99j/mFIMU3OoFrG6L2OL+GtAaEjQ4qoMcWHIMC8i/rDeA
         TOTA==
X-Gm-Message-State: AOAM531dg3XOTx8O9q1XrUroQVUSVi5tF3ZbuW0wAOJVQ1/SK5nlNb4S
        2vdILN89ewFGGdgoVv7Rs1xZxLpy+TAP7cBhl35VmjXRyHo=
X-Google-Smtp-Source: ABdhPJxb+g8k8UtLxPTQIoGSCy7z9ew4ioxyVJ0PqTXAZcDjJdOEUwcZL52fZgJet2zQ8R1syVlj3BNmMPeyowrEYIM=
X-Received: by 2002:a05:6808:699:: with SMTP id k25mr2828361oig.101.1618597816597;
 Fri, 16 Apr 2021 11:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210416125344.13550-1-tiwai@suse.de>
In-Reply-To: <20210416125344.13550-1-tiwai@suse.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 16 Apr 2021 20:30:05 +0200
Message-ID: <CAKMK7uH4Cc-nEAa3CcYTAtq8nh0HHTQNvGNZSZyzB7U-EWae2Q@mail.gmail.com>
Subject: Re: [PATCH] drm: Fix fbcon blank on QEMU graphics drivers
To:     Takashi Iwai <tiwai@suse.de>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 2:53 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> Currently the DRM fbcon helper for console blank,
> drm_fb_helper_blank(), simply calls drm_fb_helper_dpms() and always
> returns zero, supposing the driver dealing with DPMS or atomic
> crtc->active flip to handle blanking the screen.  It works on most of
> devices, but broken on most of KVM/QEMU graphics: bochs, qxl and
> cirrus drivers just ignore crtc->active state change as blanking (or
> cirrus ignoring DPMS).  In practice, when you run like
>   % setterm --blank force
> on a VT console, the screen freezes without actually blanking.
>
> A simple fix for this problem would be not to rely on DPMS but let
> fbcon performs the generic blank code.  This can be achieved just by
> returning an error from drm_fb_helper_blank().
>
> In this patch, we add a flag, no_dpms_blank, to drm_fb_helper for
> indicating that the driver doesn't handle blank via DPMS or
> crtc->active flip.  When this flag is set, drm_fb_helper_blank()
> simply returns an error, so that fbcon falls back to its generic blank
> handler.  The flag is set to both bochs and qxl drivers in this patch,
> while cirrus is left untouched as it's declared as to-be-deprecated.
>
> Link: https://lore.kernel.org/dri-devel/20170726205636.19144-1-tiwai@suse.de/
> BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1095700
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Uh we're supposed to fix these drivers to actually blank (scan out
black, worst case), not paper over it in higher levels. Atomic kms is
meant to be a somewhat useful abstraction. So now fbcon blanks, but
your desktop still just freezes.

> ---
>
> Here I whip a dead horse again, revisiting the long-standing issue
> stated in the previous patch set in 2017:
>   https://lore.kernel.org/dri-devel/20170726205636.19144-1-tiwai@suse.de/
>
> I thought to refresh the previous patch set at first, but it seems
> invalid for the atomic modeset case.  And for the atomic, it's even
> more difficult to propagate the return from the bottom to up.
> So I ended up with this approach as it's much simpler.

Yeah that's because atomic assume you can at least blank your screen to black.
-Daniel

> But if there is any better way (even simpler or more robust), I'd
> happily rewrite, too.
>
> ---
>  drivers/gpu/drm/bochs/bochs_drv.c | 3 +++
>  drivers/gpu/drm/drm_fb_helper.c   | 5 +++++
>  drivers/gpu/drm/qxl/qxl_drv.c     | 3 +++
>  include/drm/drm_fb_helper.h       | 8 ++++++++
>  4 files changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index b469624fe40d..816899a266ff 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -132,6 +132,9 @@ static int bochs_pci_probe(struct pci_dev *pdev,
>                 goto err_unload;
>
>         drm_fbdev_generic_setup(dev, 32);
> +       if (dev->fb_helper)
> +               dev->fb_helper->no_dpms_blank = true;
> +
>         return ret;
>
>  err_unload:
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index f6baa2046124..b892f02ff2f1 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -332,9 +332,14 @@ static void drm_fb_helper_dpms(struct fb_info *info, int dpms_mode)
>   */
>  int drm_fb_helper_blank(int blank, struct fb_info *info)
>  {
> +       struct drm_fb_helper *fb_helper = info->par;
> +
>         if (oops_in_progress)
>                 return -EBUSY;
>
> +       if (fb_helper->no_dpms_blank)
> +               return -EINVAL;
> +
>         switch (blank) {
>         /* Display: On; HSync: On, VSync: On */
>         case FB_BLANK_UNBLANK:
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 1864467f1063..58ecfaeed7c1 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -120,6 +120,9 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>                 goto modeset_cleanup;
>
>         drm_fbdev_generic_setup(&qdev->ddev, 32);
> +       if (qdev->fb_helper)
> +               qdev->fb_helper->no_dpms_blank = true;
> +
>         return 0;
>
>  modeset_cleanup:
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index 3b273f9ca39a..151be4219c32 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -176,6 +176,14 @@ struct drm_fb_helper {
>          */
>         bool deferred_setup;
>
> +       /**
> +        * @no_dpms_blank:
> +        *
> +        * A flag indicating that the driver doesn't support blanking.
> +        * Then fbcon core code falls back to its generic handler.
> +        */
> +       bool no_dpms_blank;
> +
>         /**
>          * @preferred_bpp:
>          *
> --
> 2.26.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
