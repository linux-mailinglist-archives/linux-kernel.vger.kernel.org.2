Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2497245B743
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbhKXJW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:22:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:40354 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhKXJWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:22:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="259125727"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="259125727"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:19:10 -0800
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="509804292"
Received: from moconno1-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.21.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:19:02 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     cgel.zte@gmail.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jason@jlekstrand.net, chris@chris-wilson.co.uk,
        maarten.lankhorst@linux.intel.com, yao.jing2@zte.com.cn,
        gregkh@linuxfoundation.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drm/i915/dmabuf: remove duplicate include in
  i915_gem_dmabuf.c
In-Reply-To: <20211124030607.34914-1-yao.jing2@zte.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211124030607.34914-1-yao.jing2@zte.com.cn>
Date:   Wed, 24 Nov 2021 11:18:59 +0200
Message-ID: <87mtltnc70.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021, cgel.zte@gmail.com wrote:
> From: Yao Jing <yao.jing2@zte.com.cn>
>
> 'asm/smp.h' included in 'drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c' is
> duplicated. It is clearly included on the 12 line.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yao Jing <yao.jing2@zte.com.cn>

The correct fix is [1].

If you keep sending patches from cgel.zte@gmail.com, you need to add
your Signed-off-by too.

BR,
Jani.


[1] https://patchwork.freedesktop.org/patch/msgid/20211122135758.85444-1-tvrtko.ursulin@linux.intel.com



> ---
>  drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> index f291cf4c3886..5712b6b5f285 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> @@ -17,9 +17,7 @@
>  
>  MODULE_IMPORT_NS(DMA_BUF);
>  
> -#if defined(CONFIG_X86)
> -#include <asm/smp.h>
> -#else
> +#if !defined(CONFIG_X86)
>  #define wbinvd_on_all_cpus() \
>  	pr_warn(DRIVER_NAME ": Missing cache flush in %s\n", __func__)
>  #endif

-- 
Jani Nikula, Intel Open Source Graphics Center
