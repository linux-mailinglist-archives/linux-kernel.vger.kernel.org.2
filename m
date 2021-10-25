Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C544398F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhJYOtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:49:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:3449 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhJYOs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:48:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="216835372"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="216835372"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 07:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="634762348"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga001.fm.intel.com with SMTP; 25 Oct 2021 07:46:26 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 25 Oct 2021 17:46:26 +0300
Date:   Mon, 25 Oct 2021 17:46:26 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     He Ying <heying24@huawei.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        lyude@redhat.com, anshuman.gupta@intel.com,
        matthew.d.roper@intel.com, nikola.cornij@amd.com,
        jose.souza@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm: Small optimization to
 intel_dp_mst_atomic_master_trans_check
Message-ID: <YXbDQrH1/rpA8xL2@intel.com>
References: <20211022022243.138860-1-heying24@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211022022243.138860-1-heying24@huawei.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 10:22:43PM -0400, He Ying wrote:
> If we want to return from for_each_intel_connector_iter(), one
> way is calling drm_connector_list_iter_end() before returning
> to avoid memleak. The other way is just breaking from the bracket
> and then returning after the outside drm_connector_list_iter_end().
> Obviously, the second way makes code smaller and more clear.
> Apply it to the function intel_dp_mst_atomic_master_trans_check().

Matches what we seem to be doing everywhere else.
Applied to drm-intel-next. Thanks.

> 
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_mst.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index 8d13d7b26a25..bbecbbbcb10d 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -231,6 +231,7 @@ intel_dp_mst_atomic_master_trans_check(struct intel_connector *connector,
>  	struct drm_i915_private *dev_priv = to_i915(state->base.dev);
>  	struct drm_connector_list_iter connector_list_iter;
>  	struct intel_connector *connector_iter;
> +	int ret = 0;
>  
>  	if (DISPLAY_VER(dev_priv) < 12)
>  		return  0;
> @@ -243,7 +244,6 @@ intel_dp_mst_atomic_master_trans_check(struct intel_connector *connector,
>  		struct intel_digital_connector_state *conn_iter_state;
>  		struct intel_crtc_state *crtc_state;
>  		struct intel_crtc *crtc;
> -		int ret;
>  
>  		if (connector_iter->mst_port != connector->mst_port ||
>  		    connector_iter == connector)
> @@ -252,8 +252,8 @@ intel_dp_mst_atomic_master_trans_check(struct intel_connector *connector,
>  		conn_iter_state = intel_atomic_get_digital_connector_state(state,
>  									   connector_iter);
>  		if (IS_ERR(conn_iter_state)) {
> -			drm_connector_list_iter_end(&connector_list_iter);
> -			return PTR_ERR(conn_iter_state);
> +			ret = PTR_ERR(conn_iter_state);
> +			break;
>  		}
>  
>  		if (!conn_iter_state->base.crtc)
> @@ -262,20 +262,18 @@ intel_dp_mst_atomic_master_trans_check(struct intel_connector *connector,
>  		crtc = to_intel_crtc(conn_iter_state->base.crtc);
>  		crtc_state = intel_atomic_get_crtc_state(&state->base, crtc);
>  		if (IS_ERR(crtc_state)) {
> -			drm_connector_list_iter_end(&connector_list_iter);
> -			return PTR_ERR(crtc_state);
> +			ret = PTR_ERR(crtc_state);
> +			break;
>  		}
>  
>  		ret = drm_atomic_add_affected_planes(&state->base, &crtc->base);
> -		if (ret) {
> -			drm_connector_list_iter_end(&connector_list_iter);
> -			return ret;
> -		}
> +		if (ret)
> +			break;
>  		crtc_state->uapi.mode_changed = true;
>  	}
>  	drm_connector_list_iter_end(&connector_list_iter);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int
> -- 
> 2.17.1

-- 
Ville Syrjälä
Intel
