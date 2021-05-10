Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4558237974F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhEJS7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:59:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:30337 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhEJS71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:59:27 -0400
IronPort-SDR: Zm5KbuFpgCkwdxuOciUaeOwNuRVyqLvlAqh02CtklXObzrUm7dn+fnbR38folFUlNCOZ5afNB0
 UTdn7lig7LSQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186709507"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="186709507"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 11:58:21 -0700
IronPort-SDR: +nz7qXDCXeB+sCLTczfEsaDbsEEhfvqceOUFejnXjavRMsg/m+68aE4tZ6lvoEdeuPgiJgsNsl
 hvgdIKnler3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="392023840"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga006.jf.intel.com with SMTP; 10 May 2021 11:58:18 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 10 May 2021 21:58:17 +0300
Date:   Mon, 10 May 2021 21:58:17 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/dp: Fix bogus DPCD version check in
 drm_dp_read_downstream_info()
Message-ID: <YJmCSTg+j+M/6SoC@intel.com>
References: <20210507214209.554866-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210507214209.554866-1-lyude@redhat.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 05:42:09PM -0400, Lyude Paul wrote:
> Ville pointed this out to me when fixing some issues in
> drm_dp_read_downstream_info() - the DPCD version check here is bogus as
> there's no DisplayPort versions prior to 1.0. The original code from i915
> that this was extracted from actually did:
> 
>   dpcd[DP_DPCD_REV] == DP_DPCD_REV_10
> 
> Which is correct, and somehow got missed when extracting this function. So
> let's fix this. Note that as far as I'm aware, I don't think this fixes any
> actual issues users are hitting.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/drm_dp_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 0f84df8798ab..55b53df6ce34 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -677,7 +677,7 @@ int drm_dp_read_downstream_info(struct drm_dp_aux *aux,
>  	memset(downstream_ports, 0, DP_MAX_DOWNSTREAM_PORTS);
>  
>  	/* No downstream info to read */
> -	if (!drm_dp_is_branch(dpcd) || dpcd[DP_DPCD_REV] < DP_DPCD_REV_10)
> +	if (!drm_dp_is_branch(dpcd) || dpcd[DP_DPCD_REV] == DP_DPCD_REV_10)
>  		return 0;
>  
>  	/* Some branches advertise having 0 downstream ports, despite also advertising they have a
> -- 
> 2.30.2

-- 
Ville Syrjälä
Intel
