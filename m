Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCF743CA30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbhJ0M6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:58:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:27658 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235988AbhJ0M6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:58:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="230100129"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="230100129"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 05:55:38 -0700
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="497853533"
Received: from smaharan-mobl.gar.corp.intel.com (HELO localhost) ([10.251.214.195])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 05:55:33 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RESEND] drm: fb_helper: fix CONFIG_FB dependency
In-Reply-To: <3604fb90-f6c3-0fa2-c864-7f1795caee1e@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210927142816.2069269-1-arnd@kernel.org> <202109270923.97AFDE89DB@keescook> <YVXJLE8UqgcUNIKl@phenom.ffwll.local> <878ryeit9i.fsf@intel.com> <CAK8P3a0EG_C6OvG00Dg8SQacirNztLFjVonb5t2xQj9aFZ47Vg@mail.gmail.com> <3604fb90-f6c3-0fa2-c864-7f1795caee1e@redhat.com>
Date:   Wed, 27 Oct 2021 15:55:30 +0300
Message-ID: <87zgquhbjx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021, Javier Martinez Canillas <javierm@redhat.com> wrote:
> On 10/27/21 14:18, Arnd Bergmann wrote:
>> On Wed, Oct 27, 2021 at 1:47 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> [snip]
>
>>> drm_fb_helper.o is not part of drm.ko, it's part of
>>> drm_kms_helper.ko. This adds some sort of indirect dependency via DRM
>>> which might work, maybe by coincidence, maybe not - but it's certainly
>>> not obvious.
>
> Indeed, you are correct that's not semantically correct.
>
>> 
>> Right, how about this change on top?
>> 
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -117,9 +117,8 @@ config DRM_DEBUG_MODESET_LOCK
>> 
>>  config DRM_FBDEV_EMULATION
>>         bool "Enable legacy fbdev support for your modesetting driver"
>> -       depends on DRM
>> -       depends on FB=y || FB=DRM
>> -       select DRM_KMS_HELPER
>> +       depends on DRM_KMS_HELPER
>> +       depends on FB=y || FB=DRM_KMS_HELPER
>>         select FB_CFB_FILLRECT
>>         select FB_CFB_COPYAREA
>>         select FB_CFB_IMAGEBLIT
>> 
>> That would probably make it work for DRM=y, FB=m, DRM_KMS_HELPER=m,
>> but it needs more randconfig testing, which I can help with.
>>
>>> The likely culprit is, again, the overuse of select, and in this case
>>> select DRM_KMS_HELPER. And DRM_KMS_HELPER should depend on FB if
>>> DRM_FBDEV_EMULATION=y. That's the problem.
>> 
>> This is something we can't easily express in Kconfig, as we can't add the
>> dependency to a symbol that only gets selected by other drivers, which
>> is why the dependency has to be in the user-visible symbol,
>> in this case DRM_FBDEV_EMULATION.
>> 
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

To me, this seems like the right solution. Depend on FB if
DRM_FBDEV_EMULATION is enabled. That's exactly what the relationship is.

BR,
Jani.



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
>
> Best regards,

-- 
Jani Nikula, Intel Open Source Graphics Center
