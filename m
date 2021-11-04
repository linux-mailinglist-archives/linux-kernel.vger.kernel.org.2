Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375B9445ABC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 20:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhKDT5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 15:57:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:36856 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbhKDT5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 15:57:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="218980327"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="218980327"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 12:54:42 -0700
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="501674768"
Received: from mihaelac-mobl.ger.corp.intel.com (HELO localhost) ([10.249.32.21])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 12:54:34 -0700
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
In-Reply-To: <YYQ0doL/F3ULjXyr@ravnborg.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211104160707.1407052-1-javierm@redhat.com> <20211104160707.1407052-2-javierm@redhat.com> <YYQaYsCr+piMlRpS@ravnborg.org> <87r1bvajna.fsf@intel.com> <eddff405-18f5-31cf-9981-27343384e12c@redhat.com> <YYQ0doL/F3ULjXyr@ravnborg.org>
Date:   Thu, 04 Nov 2021 21:54:32 +0200
Message-ID: <87lf23ae87.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2021, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Javier,
>
>> 
>> >>>  
>> >>> -	if (vgacon_text_force() && i915_modparams.modeset == -1)
>> >>> +	ret = drm_drv_enabled(&driver);
>> >>
>> >> You pass the local driver variable here - which looks wrong as this is
>> >> not the same as the driver variable declared in another file.
>> >
>> 
>> Yes, Jani mentioned it already. I got confused and thought that the driver
>> variable was also defined in the same compilation unit...
>> 
>> Maybe I could squash the following change?
>> 
>> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
>> index b18a250e5d2e..b8f399b76363 100644
>> --- a/drivers/gpu/drm/i915/i915_drv.c
>> +++ b/drivers/gpu/drm/i915/i915_drv.c
>> @@ -89,7 +89,7 @@
>>  #include "intel_region_ttm.h"
>>  #include "vlv_suspend.h"
>>  
>> -static const struct drm_driver driver;
>> +const struct drm_driver driver;
> No, variables with such a generic name will clash.
>
> Just add a
> const drm_driver * i915_drm_driver(void)
> {
> 	return &driver;
> }
>
> And then use this function to access the drm_driver variable.

Agreed on the general principle of exposing interfaces over data.

But... why? I'm still at a loss what problem this solves. We pass
&driver to exactly one place, devm_drm_dev_alloc(), and it's neatly
hidden away.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
