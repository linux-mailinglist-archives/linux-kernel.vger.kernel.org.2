Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E5531CA18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhBPLrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:47:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:40444 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhBPLmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:42:43 -0500
IronPort-SDR: wExj2dWau9FPU6O9DcRRwkmzpvfmWZDyKyif1Nr92TBVTUMTZQyNqFDuOQjW/K9TIRdO1BEp3x
 M6xdQCKQ+3SQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="182082968"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="182082968"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 03:40:57 -0800
IronPort-SDR: 4kV5ifMdVY9iJrYATUkpZJGFsnJHi5+qO0IkY7IxM9P8arvHIg0VaVYfdir6wCj/cYIBdI+Pi9
 LMsAkJsHniLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="400964230"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga007.jf.intel.com with SMTP; 16 Feb 2021 03:40:54 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 16 Feb 2021 13:40:53 +0200
Date:   Tue, 16 Feb 2021 13:40:53 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Chen Lin <chen45464546@163.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Chen Lin <chen.lin5@zte.com.cn>, rodrigo.vivi@intel.com
Subject: Re: [PATCH] drm/i915: Remove unused function pointer typedef
 long_pulse_detect_func
Message-ID: <YCuvRTwGxocZULT1@intel.com>
References: <1613388619-3276-1-git-send-email-chen45464546@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1613388619-3276-1-git-send-email-chen45464546@163.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 07:30:19PM +0800, Chen Lin wrote:
> From: Chen Lin <chen.lin5@zte.com.cn>
> 
> Remove the 'long_pulse_detect_func' typedef as it is not used.
> 
> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
> ---
>  drivers/gpu/drm/i915/i915_irq.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
> index 6cdb052..c294ac6 100644
> --- a/drivers/gpu/drm/i915/i915_irq.c
> +++ b/drivers/gpu/drm/i915/i915_irq.c
> @@ -78,7 +78,6 @@ static inline void pmu_irq_stats(struct drm_i915_private *i915,
>  	WRITE_ONCE(i915->pmu.irq_count, i915->pmu.irq_count + 1);
>  }
>  
> -typedef bool (*long_pulse_detect_func)(enum hpd_pin pin, u32 val);
>  typedef u32 (*hotplug_enables_func)(struct drm_i915_private *i915,
>  				    enum hpd_pin pin);

I thought we used in when passing it as an argument to
intel_get_hpd_pins(), but looks like that's not the case.
I guess we should unify this stuff by either removing both
these typedefs and adjusting intel_hpd_hotplug_enables()
accordingly, or we should use the typedef in intel_get_hpd_pins() as
well.

-- 
Ville Syrjälä
Intel
