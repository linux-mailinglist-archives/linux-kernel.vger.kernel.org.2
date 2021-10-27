Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E0043C971
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbhJ0MVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230420AbhJ0MV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:21:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4ACFD610A0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 12:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635337144;
        bh=N0hHufsA4EpZzPuUSABPRlv91lFIykpTajufmGvhWUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UQHIDCqTivQTJ21GBCFzXw1Qo5rgI9dwnMtwql5+0IX/ZjbtTw1+za7S6AO8m4MqZ
         HzOuMbFZ4p3+7JynKr0d0wSUVtoxM1NPBdCAGcsyFHdxIDzbu0RZV9Uu7r6sZkQgjR
         sBs6Jsl/h0Inhvq+nETJB251J2Gf8Wg0Ir7QSPiWZos3CuEyHh4q03D7gQJ0tIBf7y
         2imLeLQVn/7NzrTxqvVCNSO5ZpX1/pjV26JTVXKJmgrwIzl3muyXUTeOgW9OYEasyr
         pUBrcPqBFFoV2OJFV/I0rbz06vRNwQ3WdA7q8Pm629xsDsIK1+1qZqReG30kcevlZr
         44LAQCEtmVN+A==
Received: by mail-wr1-f47.google.com with SMTP id z14so3821731wrg.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:19:04 -0700 (PDT)
X-Gm-Message-State: AOAM5302rrx14m2yp8JNDFO9shAgtXM8k6xSL3w3gaX6wZL2D2hlST4O
        UI5vkl55ofN6czDnTc6qgyPhpEgSR/gbudSSYg4=
X-Google-Smtp-Source: ABdhPJzoUgOiwa5qHQWOfJ8KqHnSLcVaqjltVoX2kWLRWVMNVmk/Xlspt0Fim2onTGTzFXkXEGvr3R8QuEO6UaOatoA=
X-Received: by 2002:adf:ab46:: with SMTP id r6mr40167677wrc.71.1635337142692;
 Wed, 27 Oct 2021 05:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210927142816.2069269-1-arnd@kernel.org> <202109270923.97AFDE89DB@keescook>
 <YVXJLE8UqgcUNIKl@phenom.ffwll.local> <878ryeit9i.fsf@intel.com>
In-Reply-To: <878ryeit9i.fsf@intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 27 Oct 2021 14:18:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0EG_C6OvG00Dg8SQacirNztLFjVonb5t2xQj9aFZ47Vg@mail.gmail.com>
Message-ID: <CAK8P3a0EG_C6OvG00Dg8SQacirNztLFjVonb5t2xQj9aFZ47Vg@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] drm: fb_helper: fix CONFIG_FB dependency
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 1:47 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Thu, 30 Sep 2021, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Mon, Sep 27, 2021 at 09:23:45AM -0700, Kees Cook wrote:
> >> On Mon, Sep 27, 2021 at 04:28:02PM +0200, Arnd Bergmann wrote:
> >> > From: Arnd Bergmann <arnd@arndb.de>
> >> >
> >> > With CONFIG_FB=m and CONFIG_DRM=y, we get a link error in the fb helper:
> >> >
> >> > aarch64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_fbi':
> >> > (.text+0x10cc): undefined reference to `framebuffer_alloc'
> >> >
> >> > Tighten the dependency so it is only allowed in the case that DRM can
> >> > link against FB.
> >> >
> >> > Fixes: f611b1e7624c ("drm: Avoid circular dependencies for CONFIG_FB")
> >> > Link: https://lore.kernel.org/all/20210721152211.2706171-1-arnd@kernel.org/
> >> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Thanks for fixing this!
> >>
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > Stuffed into drm-misc-next.
>
> The problem is, I don't think the patch is semantically correct.
>
> drm_fb_helper.o is not part of drm.ko, it's part of
> drm_kms_helper.ko. This adds some sort of indirect dependency via DRM
> which might work, maybe by coincidence, maybe not - but it's certainly
> not obvious.

Right, how about this change on top?

--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -117,9 +117,8 @@ config DRM_DEBUG_MODESET_LOCK

 config DRM_FBDEV_EMULATION
        bool "Enable legacy fbdev support for your modesetting driver"
-       depends on DRM
-       depends on FB=y || FB=DRM
-       select DRM_KMS_HELPER
+       depends on DRM_KMS_HELPER
+       depends on FB=y || FB=DRM_KMS_HELPER
        select FB_CFB_FILLRECT
        select FB_CFB_COPYAREA
        select FB_CFB_IMAGEBLIT

That would probably make it work for DRM=y, FB=m, DRM_KMS_HELPER=m,
but it needs more randconfig testing, which I can help with.

> The likely culprit is, again, the overuse of select, and in this case
> select DRM_KMS_HELPER. And DRM_KMS_HELPER should depend on FB if
> DRM_FBDEV_EMULATION=y. That's the problem.

This is something we can't easily express in Kconfig, as we can't add the
dependency to a symbol that only gets selected by other drivers, which
is why the dependency has to be in the user-visible symbol,
in this case DRM_FBDEV_EMULATION.

> All of the drm Kconfigs could use an overhaul to be semantically
> correct, but that's a hill nobody wants to die on. Instead we keep
> piling up tweaks to paper over the issues, ad infinitum.

Yes, that is a big issue, though we have similar problems with drivers/media
and net/.

On a related note, I did manage to sort out the backlight dependency issue
(intel_panel.c:(.text+0x2f58): undefined reference to
`backlight_device_register'),
but haven't sent that one again yet, but I can if you like. This one changes
DRM_I915 and all of drivers/video/fbdev from 'select BACKLIGHT_CLASS_DEVICE'
to 'depends on', which I think moves everything into broadly the right
direction.

Let me know if you would like me to send those now, or have a look at the
top 3 patches in [1] if you are interested. This has passed a few
thousand randconfig
builds and should not depend on additional patches.

        Arnd

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=randconfig-5.16-next
