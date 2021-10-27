Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE32E43CA52
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbhJ0NJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:09:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:28690 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235246AbhJ0NJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:09:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="230102611"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="230102611"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 06:06:50 -0700
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="497857989"
Received: from smaharan-mobl.gar.corp.intel.com (HELO localhost) ([10.251.214.195])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 06:06:46 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
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
In-Reply-To: <CAK8P3a0_9U0MDLcNG8GL_ZDCGQAsB=G7DBC0k1BYB1HNQTbu4Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210927142816.2069269-1-arnd@kernel.org> <202109270923.97AFDE89DB@keescook> <YVXJLE8UqgcUNIKl@phenom.ffwll.local> <878ryeit9i.fsf@intel.com> <CAK8P3a0EG_C6OvG00Dg8SQacirNztLFjVonb5t2xQj9aFZ47Vg@mail.gmail.com> <3604fb90-f6c3-0fa2-c864-7f1795caee1e@redhat.com> <CAK8P3a0_9U0MDLcNG8GL_ZDCGQAsB=G7DBC0k1BYB1HNQTbu4Q@mail.gmail.com>
Date:   Wed, 27 Oct 2021 16:06:44 +0300
Message-ID: <87tuh2hb17.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021, Arnd Bergmann <arnd@kernel.org> wrote:
> On Wed, Oct 27, 2021 at 2:38 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> >
>> > This is something we can't easily express in Kconfig, as we can't add the
>> > dependency to a symbol that only gets selected by other drivers, which
>> > is why the dependency has to be in the user-visible symbol,
>> > in this case DRM_FBDEV_EMULATION.
>> >
>>
>> Why the dependency has to be in a user-visible symbol? What could be the
>> problem with having something like:
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index cea777ae7fb9..f80b404946ca 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -82,6 +82,7 @@ config DRM_DEBUG_SELFTEST
>>  config DRM_KMS_HELPER
>>         tristate
>>         depends on DRM
>> +       depends on (DRM_FBDEV_EMULATION && FB) || !DRM_FBDEV_EMULATION
>>         help
>>           CRTC helpers for KMS drivers.
>>
>> @@ -104,7 +105,6 @@ config DRM_FBDEV_EMULATION
>>         bool "Enable legacy fbdev support for your modesetting driver"
>>         depends on DRM
>>         depends on FB
>> -       select DRM_KMS_HELPER
>>         select FB_CFB_FILLRECT
>>         select FB_CFB_COPYAREA
>>         select FB_CFB_IMAGEBLIT
>
> This fails because of all the other drivers that try to 'select DRM_KMS_HELPER'.
> Kconfig will now complain about a symbol that gets selected while its
> dependencies
> are not met.
>
> To work around that, every single driver that has 'selects DRM_KMS_HELPER' would
> now have to also list 'depends on (DRM_FBDEV_EMULATION && FB) ||
> !DRM_FBDEV_EMULATION'.

So the fix would be that nobody selects DRM_KMS_HELPER...

BR,
Jani.

>
>        Arnd

-- 
Jani Nikula, Intel Open Source Graphics Center
