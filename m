Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D86B3183E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 04:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhBKDU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 22:20:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:5062 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhBKDU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 22:20:26 -0500
IronPort-SDR: PDD8QJFuiYpPCPSIWJ5zH8bxaHI4lrJQ3r9ctypVsXc2AbULw08FKMdlco+EycCXPnTuRD7vhX
 r9SuZkFsL9OQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="243676121"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="243676121"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 19:19:45 -0800
IronPort-SDR: WkkssKA/viF5ouDPH5JLBaAT60vsIrjtDowwCutkPdW8O2BBYnNHt4UtIl5sr7n8Eh48zYSqq4
 ko2HA6PV+Ocw==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="588271083"
Received: from rontiver-mobl.amr.corp.intel.com (HELO intel.com) ([10.212.99.95])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 19:19:44 -0800
Date:   Wed, 10 Feb 2021 22:19:43 -0500
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Yijun Shen <Yijun.Shen@dell.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [Intel-gfx] [PATCH v5 1/4] drm/i915/gen9_bc: Recognize TGP PCH +
 CML combos
Message-ID: <20210211031943.GB82362@intel.com>
References: <20210209212832.1401815-1-lyude@redhat.com>
 <20210209212832.1401815-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209212832.1401815-2-lyude@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 04:28:28PM -0500, Lyude Paul wrote:
> Since Intel has introduced the gen9_bc platform, a combination of
> Tigerpoint PCHs and CML CPUs, let's recognize such platforms as valid and
> avoid WARNing on them.
> 
> Changes since v4:
> * Split this into it's own patch - vsyrjala
> 
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
> [originally from Tejas's work]
> Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  drivers/gpu/drm/i915/intel_pch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_pch.c b/drivers/gpu/drm/i915/intel_pch.c
> index 4813207fc053..7476f0e063c6 100644
> --- a/drivers/gpu/drm/i915/intel_pch.c
> +++ b/drivers/gpu/drm/i915/intel_pch.c
> @@ -121,7 +121,8 @@ intel_pch_type(const struct drm_i915_private *dev_priv, unsigned short id)
>  	case INTEL_PCH_TGP2_DEVICE_ID_TYPE:
>  		drm_dbg_kms(&dev_priv->drm, "Found Tiger Lake LP PCH\n");
>  		drm_WARN_ON(&dev_priv->drm, !IS_TIGERLAKE(dev_priv) &&
> -			    !IS_ROCKETLAKE(dev_priv));
> +			    !IS_ROCKETLAKE(dev_priv) &&
> +			    !IS_GEN9_BC(dev_priv));
>  		return PCH_TGP;
>  	case INTEL_PCH_JSP_DEVICE_ID_TYPE:
>  	case INTEL_PCH_JSP2_DEVICE_ID_TYPE:
> -- 
> 2.29.2
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
