Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A101336B213
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 13:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhDZLLE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Apr 2021 07:11:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46456 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbhDZLLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:11:03 -0400
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1laz89-0002BT-CW
        for linux-kernel@vger.kernel.org; Mon, 26 Apr 2021 11:10:21 +0000
Received: by mail-lf1-f71.google.com with SMTP id p28-20020a056512329cb02901ae653ca592so9279732lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 04:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xiDFWZDIwVOWhDf8JIJtdA0vE7Qg4WZABGwJr1mglyw=;
        b=Zj4EG5EXpfreMGAFcEu+d7HL3IKvr8Girxhue9R7pYZOBa2mKKCn3zUS5iJmq4Fx6V
         I6Rm21xAsTPo3/bwa/Oq7NAVVigXvUZq0APJZQTn4/ihag8hUkaxanBg5V24+dE3pi0o
         ddZetAhfjLydHu9S462EeqGSD4TyN5hJ0HKX/RaU0ogSzZ+MiLWJ0yzeIs0bsxkTXJnW
         XzrZqveNd/gUOmndSFe0FrIXIfNUBJV+LdNQeXSeGtm/CvquvC/Ms9GK8v58G6nS0/TR
         JYQGSn9gQ2xoHOHDQo/9DtVuk+81e4xq01F6thueWz1LU0F2UB9kxNDZ24XGUkzCXDmU
         mxKQ==
X-Gm-Message-State: AOAM531pbX+60FUh2IlUO5s0koDmSTaa0xVYCs836MeEJWnvhh5RYIxJ
        LIgdugo1ZKuekq3q/hWQfVWPK2iM/c5a1uGr/gEuE8KFETLTwUKBkcRrOrzTOGmPD+H/Y0UBO9T
        gBM7a5R5r4L20qUxaD0UwxWfyqgdQsXrQMQmFwIQ7N6Sb30Ykvn0Ch1kfXA==
X-Received: by 2002:ac2:4546:: with SMTP id j6mr307073lfm.290.1619435419363;
        Mon, 26 Apr 2021 04:10:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2HuOs7hsFQWQ6DpfjtFI/lGLMD7R4zW0qG+mZ1QM088Bg0L5h31Ae1gJG1TKdvDNzcal21ao43zQupwhBKww=
X-Received: by 2002:ac2:4546:: with SMTP id j6mr307063lfm.290.1619435419143;
 Mon, 26 Apr 2021 04:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210423044700.247359-1-kai.heng.feng@canonical.com> <YILAc6EhoWWhENq8@intel.com>
In-Reply-To: <YILAc6EhoWWhENq8@intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 26 Apr 2021 19:10:06 +0800
Message-ID: <CAAd53p72Y8Rda0Hk3WReLKPGJe8rwc5X-Pi5cyCpRPAm8sVEzg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915: Invoke BXT _DSM to enable MUX on HP
 Workstation laptops
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Takashi Iwai <tiwai@suse.de>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 8:41 PM Ville Syrjälä
<ville.syrjala@linux.intel.com> wrote:
>
> On Fri, Apr 23, 2021 at 12:46:54PM +0800, Kai-Heng Feng wrote:
> > On HP Fury G7 Workstations, graphics output is re-routed from Intel GFX
> > to discrete GFX after S3. This is not desirable, because userspace will
> > treat connected display as a new one, losing display settings.
> >
> > The expected behavior is to let discrete GFX drives all external
> > displays.
> >
> > The platform in question uses ACPI method \_SB.PCI0.HGME to enable MUX.
> > The method is inside the BXT _DSM, so add the _DSM and call it
> > accordingly.
> >
> > I also tested some MUX-less and iGPU only laptops with the BXT _DSM, no
> > regression was found.
> >
> > v2:
> >  - Forward declare struct pci_dev.
> >
> > Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3113
> > References: https://lore.kernel.org/intel-gfx/1460040732-31417-4-git-send-email-animesh.manna@intel.com/
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_acpi.c | 17 +++++++++++++++++
> >  drivers/gpu/drm/i915/display/intel_acpi.h |  3 +++
> >  drivers/gpu/drm/i915/i915_drv.c           |  5 +++++
> >  3 files changed, 25 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> > index 833d0c1be4f1..c7b57c22dce3 100644
> > --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> > +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> > @@ -14,11 +14,16 @@
> >
> >  #define INTEL_DSM_REVISION_ID 1 /* For Calpella anyway... */
> >  #define INTEL_DSM_FN_PLATFORM_MUX_INFO 1 /* No args */
> > +#define INTEL_DSM_FN_PLATFORM_BXT_MUX_INFO 0 /* No args */
> >
> >  static const guid_t intel_dsm_guid =
> >       GUID_INIT(0x7ed873d3, 0xc2d0, 0x4e4f,
> >                 0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
> >
> > +static const guid_t intel_bxt_dsm_guid =
> > +     GUID_INIT(0x3e5b41c6, 0xeb1d, 0x4260,
> > +               0x9d, 0x15, 0xc7, 0x1f, 0xba, 0xda, 0xe4, 0x14);
> > +
>
> I think this dsm is just supposed to be more or less an
> alternative to the opregion SCI stuff. Why there are two
> ways to do the same things I have no idea. The opregion
> spec does not tell us such mundane details.

Right now I think it's HP specific and from what I can see it doesn't
touch opregion.

>
> It's also not documented to do anything except list the
> supported functions:
> "Get BIOS Data Functions Supported “Function #0"
>  This function can be called to discover which “_DSM” Functions are
>  supported. It may only return success if the return value accurately
>  lists supported Functions."
>
> But what you're apparently saying is that calling this changes
> the behaviour of the system somehow? That is troubling.

It flips a bit in BIOS-reserved Intel GPIO, and EC/hardware will
change the MUX based on the GPIO bit.

We can add a DMI check to match "HP" to minimize the potential
regression factor.

Kai-Heng

>
> --
> Ville Syrjälä
> Intel
