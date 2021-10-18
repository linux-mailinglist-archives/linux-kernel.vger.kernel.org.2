Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B594312EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhJRJOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:14:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:49450 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231528AbhJRJOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:14:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="209001452"
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="209001452"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 02:12:06 -0700
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="493509143"
Received: from foboril-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.44.188])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 02:12:01 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     luo penghao <cgel.zte@gmail.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        "Deak\, Imre" <imre.deak@intel.com>
Subject: Re: [PATCH linux-next] drm/i915/display: Remove unused variable in the for loop.
In-Reply-To: <20211018084449.852251-1-luo.penghao@zte.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211018084449.852251-1-luo.penghao@zte.com.cn>
Date:   Mon, 18 Oct 2021 12:11:58 +0300
Message-ID: <87k0iau275.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021, luo penghao <cgel.zte@gmail.com> wrote:
> Variable is not used in the loop, and its assignment is redundant too.
> So it should be deleted.
>
> The clang_analyzer complains as follows:
>
> drivers/gpu/drm/i915/display/intel_fb.c:1018:3 warning:
>
> Value stored to 'cpp' is never read.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> ---
>  drivers/gpu/drm/i915/display/intel_fb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
> index fa1f375..b9b6a7a 100644
> --- a/drivers/gpu/drm/i915/display/intel_fb.c
> +++ b/drivers/gpu/drm/i915/display/intel_fb.c
> @@ -998,7 +998,7 @@ int intel_fill_fb_info(struct drm_i915_private *i915, struct intel_framebuffer *
>  	for (i = 0; i < num_planes; i++) {
>  		struct fb_plane_view_dims view_dims;
>  		unsigned int width, height;
> -		unsigned int cpp, size;
> +		unsigned int size;
>  		u32 offset;
>  		int x, y;
>  		int ret;
> @@ -1015,7 +1015,7 @@ int intel_fill_fb_info(struct drm_i915_private *i915, struct intel_framebuffer *
>  				return -EINVAL;
>  		}
>  
> -		cpp = fb->base.format->cpp[i];
> +		fb->base.format->cpp[i];

Thanks for the report. However, this "fix" isn't any better than having
the unused variable. It's obviously wrong.

It would be useful to dig into the history of the function, and figure
out when and why the variable became unused, and whether that caused an
actual bug or whether this was just leftovers from some refactoring.

So that's what I did. Some git blame and git log -p revealed commit
d3c5e10b6059 ("drm/i915/intel_fb: Factor out
convert_plane_offset_to_xy()") that moved the check that used the cpp
variable to a separate function, and the local variable and the line
above became unused and useless.

That's the actually helpful part. It's easy to see and verify that the
right fix is to just remove the line completely.

BR,
Jani.


>  		intel_fb_plane_dims(fb, i, &width, &height);
>  
>  		ret = convert_plane_offset_to_xy(fb, i, width, &x, &y);

-- 
Jani Nikula, Intel Open Source Graphics Center
