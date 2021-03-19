Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDA1341ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCSNwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:52:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:35689 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229936AbhCSNwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:52:47 -0400
IronPort-SDR: ive6hKuFTUIvcmyInSnP2tDbFFrZ2BgcdhspYvJCtamyJVyKqhzDC24lqTPJ5sKRPPjg0pzg+K
 Jp+sM4FohZPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="189987342"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="189987342"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 06:52:47 -0700
IronPort-SDR: YNF8CPXV+IYFng1K1eaVAQh11SNitPCITE3gei6N+X9otQaAOBt9/124pzpgd5+3jTxljWpScR
 J/Bl7zhD4W5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="374956703"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga006.jf.intel.com with SMTP; 19 Mar 2021 06:52:44 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 19 Mar 2021 15:52:43 +0200
Date:   Fri, 19 Mar 2021 15:52:43 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 04/19] include: drm: drm_atomic: Make use of
 'new_plane_state'
Message-ID: <YFSsq745gswwET6A@intel.com>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
 <20210319082428.3294591-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210319082428.3294591-5-lee.jones@linaro.org>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 08:24:13AM +0000, Lee Jones wrote:
> In the macro for_each_oldnew_plane_in_state() 'new_plane_state' is provided
> as a container for state->planes[i].new_state, but is not utilised in
> some use-cases, so we fake-use it instead.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function ‘amdgpu_dm_commit_cursors’:
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7649:44: warning: variable ‘new_plane_state’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/drm/drm_atomic.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index ac5a28eff2c86..259e6970dc836 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -871,7 +871,8 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  			     ((plane) = (__state)->planes[__i].ptr,	\
>  			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
>  			      (old_plane_state) = (__state)->planes[__i].old_state,\
> -			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
> +			      (new_plane_state) = (__state)->planes[__i].new_state, \
> +			      (void)(new_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))

In this case you can just switch the code to use
for_each_old_plane_in_state() instead.

>  
>  /**
>   * for_each_oldnew_plane_in_state_reverse - iterate over all planes in an atomic
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
