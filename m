Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3014444591E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhKDSAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:00:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:27695 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232245AbhKDSAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:00:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="218956812"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="218956812"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 10:57:38 -0700
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="501633554"
Received: from mihaelac-mobl.ger.corp.intel.com (HELO localhost) ([10.249.32.21])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 10:57:31 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        amd-gfx@lists.freedesktop.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        intel-gfx@lists.freedesktop.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        virtualization@lists.linux-foundation.org,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        "Pan\, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        spice-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 1/2] drm: Add a drm_drv_enabled() to check if drivers should be enabled
In-Reply-To: <YYQaYsCr+piMlRpS@ravnborg.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211104160707.1407052-1-javierm@redhat.com> <20211104160707.1407052-2-javierm@redhat.com> <YYQaYsCr+piMlRpS@ravnborg.org>
Date:   Thu, 04 Nov 2021 19:57:29 +0200
Message-ID: <87r1bvajna.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2021, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Javier,
>
> On Thu, Nov 04, 2021 at 05:07:06PM +0100, Javier Martinez Canillas wrote:
>> Some DRM drivers check the vgacon_text_force() function return value as an
>> indication on whether they should be allowed to be enabled or not.
>> 
>> This function returns true if the nomodeset kernel command line parameter
>> was set. But there may be other conditions besides this to determine if a
>> driver should be enabled.
>> 
>> Let's add a drm_drv_enabled() helper function to encapsulate that logic so
>> can be later extended if needed, without having to modify all the drivers.
>> 
>> Also, while being there do some cleanup. The vgacon_text_force() function
>> is guarded by CONFIG_VGA_CONSOLE and there's no need for callers to do it.
>> 
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> 
>> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
>> index 8214a0b1ab7f..3fb567d62881 100644
>> --- a/drivers/gpu/drm/drm_drv.c
>> +++ b/drivers/gpu/drm/drm_drv.c
>> @@ -975,6 +975,26 @@ int drm_dev_set_unique(struct drm_device *dev, const char *name)
>>  }
>>  EXPORT_SYMBOL(drm_dev_set_unique);
>>  
>> +/**
>> + * drm_drv_enabled - Checks if a DRM driver can be enabled
>> + * @driver: DRM driver to check
>> + *
>> + * Checks whether a DRM driver can be enabled or not. This may be the case
>> + * if the "nomodeset" kernel command line parameter is used.
>> + *
>> + * Return: 0 on success or a negative error code on failure.
>> + */
>> +int drm_drv_enabled(const struct drm_driver *driver)
>> +{
>> +	if (vgacon_text_force()) {
>> +		DRM_INFO("%s driver is disabled\n", driver->name);
>
> DRM_INFO is deprecated, please do not use it in new code.
> Also other users had an error message and not just info - is info
> enough?
>
>
>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(drm_drv_enabled);
>> +
>>  /*
>>   * DRM Core
>>   * The DRM core module initializes all global DRM objects and makes them
>> diff --git a/drivers/gpu/drm/i915/i915_module.c b/drivers/gpu/drm/i915/i915_module.c
>> index ab2295dd4500..45cb3e540eff 100644
>> --- a/drivers/gpu/drm/i915/i915_module.c
>> +++ b/drivers/gpu/drm/i915/i915_module.c
>> @@ -18,9 +18,12 @@
>>  #include "i915_selftest.h"
>>  #include "i915_vma.h"
>>  
>> +static const struct drm_driver driver;
> Hmmm...
>
>> +
>>  static int i915_check_nomodeset(void)
>>  {
>>  	bool use_kms = true;
>> +	int ret;
>>  
>>  	/*
>>  	 * Enable KMS by default, unless explicitly overriden by
>> @@ -31,7 +34,8 @@ static int i915_check_nomodeset(void)
>>  	if (i915_modparams.modeset == 0)
>>  		use_kms = false;
>>  
>> -	if (vgacon_text_force() && i915_modparams.modeset == -1)
>> +	ret = drm_drv_enabled(&driver);
>
> You pass the local driver variable here - which looks wrong as this is
> not the same as the driver variable declared in another file.

Indeed.

> Maybe move the check to new function you can add to init_funcs,
> and locate the new function in i915_drv - so it has access to driver?

We don't really want that, though. This check is pretty much as early as
it can be, and there's a ton of useless initialization that would happen
if we waited until drm_driver is available.

From my POV, drm_drv_enabled() is a solution that creates a worse
problem for us than it solves.


BR,
Jani.


>
>
> 	Sam

-- 
Jani Nikula, Intel Open Source Graphics Center
