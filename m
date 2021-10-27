Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4BE43CA22
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbhJ0MzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhJ0MzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:55:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE6A3610C7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 12:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635339165;
        bh=Q7hlXm24IlvoYotzMPCW0asKP7SmokzIn117GHNxzFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HyHWeRsQLzxW3Cv2ZvfgJq9LQ0C24Yzzkch5UMjac3pgFU8ZwxqDFVkOdi3dxSZnZ
         VJVz8V5vIai80fB+VJ4ykIGCCfzURmHfgqIS4tJXmrOAo808A9h+fCInfTxa0cg/ZD
         jUCQx61dITcuN7VfuODxdavtSKuWsdLMcp1xI6AVOpTYLuB+m9KKAxDrk9JWDdDDG5
         0AxZZJiKWmeVEjAfh2o+Xxf2dJHArpkQ42oV/UMQiisra2DBh6TKy4SqflT/bBMlf0
         jBT8ztNAoFVPU17HKgI60G47vpA1PbIFc+d6nayvOki8YuOZ9HrmtUQUjAvAG1fDL+
         EGy9+zVVqaGLQ==
Received: by mail-wr1-f41.google.com with SMTP id v17so3958658wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:52:45 -0700 (PDT)
X-Gm-Message-State: AOAM532H/yu33hr6FMwMpghAEM6vccxSjPHltPNU0fUYD6A6lhOgU18t
        M0TLxEgZ+spljTbgWO38ZR8H12u5w3oz4q2sA1w=
X-Google-Smtp-Source: ABdhPJzbCZlyX9k07pVOYD24NnN5Ih9Jz4C65HCAbcMBr1xanhoORR4HnbeuhyjlQLr424LeCjS0GIekG1+t5CZJ+/Q=
X-Received: by 2002:a5d:47a3:: with SMTP id 3mr27512666wrb.336.1635339164196;
 Wed, 27 Oct 2021 05:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210927142816.2069269-1-arnd@kernel.org> <202109270923.97AFDE89DB@keescook>
 <YVXJLE8UqgcUNIKl@phenom.ffwll.local> <878ryeit9i.fsf@intel.com>
 <CAK8P3a0EG_C6OvG00Dg8SQacirNztLFjVonb5t2xQj9aFZ47Vg@mail.gmail.com> <3604fb90-f6c3-0fa2-c864-7f1795caee1e@redhat.com>
In-Reply-To: <3604fb90-f6c3-0fa2-c864-7f1795caee1e@redhat.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 27 Oct 2021 14:52:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0_9U0MDLcNG8GL_ZDCGQAsB=G7DBC0k1BYB1HNQTbu4Q@mail.gmail.com>
Message-ID: <CAK8P3a0_9U0MDLcNG8GL_ZDCGQAsB=G7DBC0k1BYB1HNQTbu4Q@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] drm: fb_helper: fix CONFIG_FB dependency
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 2:38 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> >
> > This is something we can't easily express in Kconfig, as we can't add the
> > dependency to a symbol that only gets selected by other drivers, which
> > is why the dependency has to be in the user-visible symbol,
> > in this case DRM_FBDEV_EMULATION.
> >
>
> Why the dependency has to be in a user-visible symbol? What could be the
> problem with having something like:
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index cea777ae7fb9..f80b404946ca 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -82,6 +82,7 @@ config DRM_DEBUG_SELFTEST
>  config DRM_KMS_HELPER
>         tristate
>         depends on DRM
> +       depends on (DRM_FBDEV_EMULATION && FB) || !DRM_FBDEV_EMULATION
>         help
>           CRTC helpers for KMS drivers.
>
> @@ -104,7 +105,6 @@ config DRM_FBDEV_EMULATION
>         bool "Enable legacy fbdev support for your modesetting driver"
>         depends on DRM
>         depends on FB
> -       select DRM_KMS_HELPER
>         select FB_CFB_FILLRECT
>         select FB_CFB_COPYAREA
>         select FB_CFB_IMAGEBLIT

This fails because of all the other drivers that try to 'select DRM_KMS_HELPER'.
Kconfig will now complain about a symbol that gets selected while its
dependencies
are not met.

To work around that, every single driver that has 'selects DRM_KMS_HELPER' would
now have to also list 'depends on (DRM_FBDEV_EMULATION && FB) ||
!DRM_FBDEV_EMULATION'.

       Arnd
