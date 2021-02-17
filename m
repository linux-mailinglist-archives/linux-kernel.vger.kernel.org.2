Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710CB31DF06
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 19:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhBQSUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 13:20:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:37910 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233681AbhBQST7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 13:19:59 -0500
IronPort-SDR: jMU7FshkCpeS+1HMGQy9XiTXIPhdEpvnBOy2ZEahUUeb/SNJvgdl0fDyT0aIo+Q+S3pOJlYQQO
 GMtKVStS1mRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="180717010"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="180717010"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 10:19:01 -0800
IronPort-SDR: 10/4LOWbbDnZydEs+vFTlUYsXzTSAzQnuDjBVxyDtp4FHP9x+tcj8xiNBV49xXOPLYOR6BMZ3y
 Q5hA4fy5S5Tw==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="401386165"
Received: from gfreude-mobl.amr.corp.intel.com (HELO intel.com) ([10.209.147.126])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 10:19:00 -0800
Date:   Wed, 17 Feb 2021 13:18:58 -0500
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
Subject: Re: [PATCH v3 2/2] drm/i915/icp+: Use icp_hpd_irq_setup() instead of
 spt_hpd_irq_setup()
Message-ID: <YC1eEmjZigHbYYyy@intel.com>
References: <20210217025337.1929015-1-lyude@redhat.com>
 <20210217025337.1929015-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217025337.1929015-2-lyude@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 09:53:37PM -0500, Lyude Paul wrote:
> While reviewing patches for handling workarounds related to gen9 bc, Imre
> from Intel discovered that we're using spt_hpd_irq_setup() on ICP+ PCHs
> despite it being almost the same as icp_hpd_irq_setup(). Since we need to
> be calling icp_hpd_irq_setup() to ensure that CML-S/TGP platforms function
> correctly anyway, let's move platforms using PCH_ICP which aren't handled
> by gen11_hpd_irq_setup() over to icp_hpd_irq_setup().
> 
> Cc: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>


makes sense to me...


Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>


> ---
>  drivers/gpu/drm/i915/i915_irq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
> index f86b147f588f..7ec61187a315 100644
> --- a/drivers/gpu/drm/i915/i915_irq.c
> +++ b/drivers/gpu/drm/i915/i915_irq.c
> @@ -4320,6 +4320,8 @@ void intel_irq_init(struct drm_i915_private *dev_priv)
>  			dev_priv->display.hpd_irq_setup = gen11_hpd_irq_setup;
>  		else if (IS_GEN9_LP(dev_priv))
>  			dev_priv->display.hpd_irq_setup = bxt_hpd_irq_setup;
> +		else if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
> +			dev_priv->display.hpd_irq_setup = icp_hpd_irq_setup;
>  		else if (INTEL_PCH_TYPE(dev_priv) >= PCH_SPT)
>  			dev_priv->display.hpd_irq_setup = spt_hpd_irq_setup;
>  		else
> -- 
> 2.29.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
