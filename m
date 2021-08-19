Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FBD3F1D81
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhHSQM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:12:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:36194 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhHSQM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:12:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216624126"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="216624126"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:11:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="489721270"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga008.fm.intel.com with SMTP; 19 Aug 2021 09:11:46 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 19 Aug 2021 19:11:45 +0300
Date:   Thu, 19 Aug 2021 19:11:45 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Sean Paul <seanpaul@chromium.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/dp: Use max params for panels < eDP 1.4
Message-ID: <YR6CwZ0QEEI+jFVO@intel.com>
References: <20210818171457.536107-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210818171457.536107-1-kai.heng.feng@canonical.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 01:14:55AM +0800, Kai-Heng Feng wrote:
> Users reported that after commit 2bbd6dba84d4 ("drm/i915: Try to use
> fast+narrow link on eDP again and fall back to the old max strategy on
> failure"), the screen starts to have wobbly effect.
> 
> Commit a5c936add6a2 ("drm/i915/dp: Use slow and wide link training for
> everything") doesn't help either, that means the affected eDP 1.2 panels
> only work with max params.
> 
> So use max params for panels < eDP 1.4 as Windows does to solve the
> issue.
> 
> v2:
>  - Check eDP 1.4 instead of DPCD 1.1 to apply max params
> 
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3714
> Fixes: 2bbd6dba84d4 ("drm/i915: Try to use fast+narrow link on eDP again and fall back to the old max strategy on failure")
> Fixes: a5c936add6a2 ("drm/i915/dp: Use slow and wide link training for everything")
> Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 75d4ebc669411..f87fad78f1a9f 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -1330,14 +1330,16 @@ intel_dp_compute_link_config(struct intel_encoder *encoder,
>  	limits.min_bpp = intel_dp_min_bpp(pipe_config->output_format);
>  	limits.max_bpp = intel_dp_max_bpp(intel_dp, pipe_config);
>  
> -	if (intel_dp->use_max_params) {
> +	if (intel_dp->use_max_params ||
> +	    intel_dp->edp_dpcd[0] < DP_EDP_14) {

I think we're going to need a is_edp check here or else we'll always
take this path on extenral DP when edp_dpcd[] is zeroed.

Hmm. Maybe just stick
intel_dp->use_max_params = intel_dp->edp_dpcd[0] < DP_EDP_14;
into intel_edp_init_dpcd()?

>  		/*
>  		 * Use the maximum clock and number of lanes the eDP panel
>  		 * advertizes being capable of in case the initial fast
> -		 * optimal params failed us. The panels are generally
> -		 * designed to support only a single clock and lane
> -		 * configuration, and typically on older panels these
> -		 * values correspond to the native resolution of the panel.
> +		 * optimal params failed us or the EDP rev is earlier than 1.4.
> +		 * The panels are generally designed to support only a single
> +		 * clock and lane configuration, and typically on older panels
> +		 * these values correspond to the native resolution of the
> +		 * panel.
>  		 */
>  		limits.min_lane_count = limits.max_lane_count;
>  		limits.min_clock = limits.max_clock;
> -- 
> 2.32.0

-- 
Ville Syrjälä
Intel
