Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4B643129D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhJRI72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:59:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:35106 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231190AbhJRI7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:59:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="228153348"
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="228153348"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 01:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="443325319"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga006.jf.intel.com with SMTP; 18 Oct 2021 01:57:06 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 18 Oct 2021 11:57:06 +0300
Date:   Mon, 18 Oct 2021 11:57:06 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     luo penghao <cgel.zte@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] drm/i915/display: Remove unused variable and
 its assignment.
Message-ID: <YW024pwrV7fLgV/2@intel.com>
References: <20211018084331.851975-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211018084331.851975-1-luo.penghao@zte.com.cn>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 08:43:31AM +0000, luo penghao wrote:
> Variable is not used in functions, and its assignment is redundant too.
> So it should be deleted.
> 
> The clang_analyzer complains as follows:
> 
> drivers/gpu/drm/i915/display/intel_dpll.c:1653:2 warning:
> Value stored to 'bestm1' is never read.
> 
> drivers/gpu/drm/i915/display/intel_dpll.c:1651:2 warning:
> Value stored to 'bestn' is never read.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> ---
>  drivers/gpu/drm/i915/display/intel_dpll.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dpll.c b/drivers/gpu/drm/i915/display/intel_dpll.c
> index b84ed4a..28b1616 100644
> --- a/drivers/gpu/drm/i915/display/intel_dpll.c
> +++ b/drivers/gpu/drm/i915/display/intel_dpll.c
> @@ -1644,13 +1644,11 @@ static void chv_prepare_pll(const struct intel_crtc_state *crtc_state)
>  	enum pipe pipe = crtc->pipe;
>  	enum dpio_channel port = vlv_pipe_to_channel(pipe);
>  	u32 loopfilter, tribuf_calcntr;
> -	u32 bestn, bestm1, bestm2, bestp1, bestp2, bestm2_frac;
> +	u32 bestm2, bestp1, bestp2, bestm2_frac;
>  	u32 dpio_val;
>  	int vco;
>  
> -	bestn = crtc_state->dpll.n;

This one we could use. For some reason we hardcode it to
1 now, which is correct for our use cases but I don't really
see a reason to hardcode it here. We are supposed to calculate
it correctly after all, and chv_crtc_clock_get() also just blindly
reads it out.

>  	bestm2_frac = crtc_state->dpll.m2 & 0x3fffff;
> -	bestm1 = crtc_state->dpll.m1;

This one is a bit trickier since I don't think the spec even
gives us other values. But we could assert that it's correct.

Some something along these lines I think would be best:
+ drm_WARN_ON(&dev_priv->drm, bestm1 != 2);
  vlv_dpio_write(dev_priv, pipe, CHV_PLL_DW1(port),
                 DPIO_CHV_M1_DIV_BY_2 |
- 		 1 << DPIO_CHV_N_DIV_SHIFT);
+ 		 bestn << DPIO_CHV_N_DIV_SHIFT);

-- 
Ville Syrjälä
Intel
