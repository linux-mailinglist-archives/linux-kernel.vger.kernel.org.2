Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B391445AC2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 20:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhKDUAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 16:00:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:33932 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230403AbhKDT76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 15:59:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="317985239"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="317985239"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 12:57:19 -0700
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="501676017"
Received: from mihaelac-mobl.ger.corp.intel.com (HELO localhost) ([10.249.32.21])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 12:57:11 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "Pan\, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, spice-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/2] drm: Add a drm_drv_enabled() to check if drivers should be enabled
In-Reply-To: <20211104160707.1407052-2-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211104160707.1407052-1-javierm@redhat.com> <20211104160707.1407052-2-javierm@redhat.com>
Date:   Thu, 04 Nov 2021 21:57:08 +0200
Message-ID: <87ilx7ae3v.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2021, Javier Martinez Canillas <javierm@redhat.com> wrote:
> +/**
> + * drm_drv_enabled - Checks if a DRM driver can be enabled
> + * @driver: DRM driver to check
> + *
> + * Checks whether a DRM driver can be enabled or not. This may be the case
> + * if the "nomodeset" kernel command line parameter is used.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int drm_drv_enabled(const struct drm_driver *driver)
> +{
> +	if (vgacon_text_force()) {
> +		DRM_INFO("%s driver is disabled\n", driver->name);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_drv_enabled);

The name implies a bool return, but it's not.

	if (drm_drv_enabled(...)) {
		/* surprise, it's disabled! */
	}


BR,
Jani.



-- 
Jani Nikula, Intel Open Source Graphics Center
