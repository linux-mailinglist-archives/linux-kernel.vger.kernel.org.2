Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6FA44427C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 14:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhKCNhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 09:37:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:64458 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhKCNhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 09:37:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="294944392"
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="294944392"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 06:34:30 -0700
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="501063969"
Received: from bmagdala-mobl.ger.corp.intel.com (HELO localhost) ([10.251.215.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 06:34:25 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [RESEND PATCH 1/5] drm/i915: Fix comment about modeset parameters
In-Reply-To: <20211103122809.1040754-2-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211103122809.1040754-1-javierm@redhat.com> <20211103122809.1040754-2-javierm@redhat.com>
Date:   Wed, 03 Nov 2021 15:34:22 +0200
Message-ID: <87r1bxbbxd.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Nov 2021, Javier Martinez Canillas <javierm@redhat.com> wrote:
> The comment mentions that the KMS is enabled by default unless either the
> i915.modeset module parameter or vga_text_mode_force boot option are used.
>
> But the latter does not exist and instead the nomodeset option was meant.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for the patch. I've picked this up to drm-intel-next as a
non-functional change independent from the rest of the series.

BR,
Jani.

> ---
>
>  drivers/gpu/drm/i915/i915_module.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_module.c b/drivers/gpu/drm/i915/i915_module.c
> index ab2295dd4500..c7507266aa83 100644
> --- a/drivers/gpu/drm/i915/i915_module.c
> +++ b/drivers/gpu/drm/i915/i915_module.c
> @@ -24,8 +24,8 @@ static int i915_check_nomodeset(void)
>  
>  	/*
>  	 * Enable KMS by default, unless explicitly overriden by
> -	 * either the i915.modeset prarameter or by the
> -	 * vga_text_mode_force boot option.
> +	 * either the i915.modeset parameter or by the
> +	 * nomodeset boot option.
>  	 */
>  
>  	if (i915_modparams.modeset == 0)

-- 
Jani Nikula, Intel Open Source Graphics Center
