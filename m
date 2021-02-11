Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22633183EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 04:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhBKDWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 22:22:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:15588 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhBKDWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 22:22:07 -0500
IronPort-SDR: grtHrf6oaewfuyU+U/aPQa6ezkCjpqYeV03Woesc5jFbeBAZFE0Mq+1QCSTScO1uaOwRDgTkSD
 f8aFoAAgjcsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="182254446"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="182254446"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 19:21:26 -0800
IronPort-SDR: oZzvHfjV1sOGfUxeOlwHp2xaK570Vqw3O/xOjjQEFVwQBnbfZyg2bOqNEWEZUQ4LFUXZzIVKMN
 ZFbHJwTxtH3Q==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="586825353"
Received: from rontiver-mobl.amr.corp.intel.com (HELO intel.com) ([10.212.99.95])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 19:21:25 -0800
Date:   Wed, 10 Feb 2021 22:21:24 -0500
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Yijun Shen <Yijun.Shen@dell.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Dave Airlie <airlied@redhat.com>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
Subject: Re: [PATCH v5 3/4] drm/i915/gen9_bc: Introduce HPD pin mappings for
 TGP PCH + CML combos
Message-ID: <20210211032124.GC82362@intel.com>
References: <20210209212832.1401815-1-lyude@redhat.com>
 <20210209212832.1401815-4-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209212832.1401815-4-lyude@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 04:28:30PM -0500, Lyude Paul wrote:
> Next, let's start introducing the HPD pin mappings for Intel's new gen9_bc
> platform in order to make hotplugging display connectors work. Since
> gen9_bc is just a TGP PCH along with a CML CPU, except with the same HPD
> mappings as ICL, we simply add a skl_hpd_pin function that is shared
> between gen9 and gen9_bc which handles both the traditional gen9 HPD pin
> mappings and the Icelake HPD pin mappings that gen9_bc uses.
> 
> Changes since v4:
> * Split this into its own commit
> * Introduce skl_hpd_pin() like vsyrjala suggested and use that instead of
>   sticking our HPD pin mappings in TGP code
> 
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
> [originally from Tejas's work]
> Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_ddi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
> index 3c4003605f93..01b171f52694 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -3954,6 +3954,14 @@ static enum hpd_pin cnl_hpd_pin(struct drm_i915_private *dev_priv,
>  	return HPD_PORT_A + port - PORT_A;
>  }
>  
> +static enum hpd_pin skl_hpd_pin(struct drm_i915_private *dev_priv, enum port port)
> +{
> +	if (HAS_PCH_TGP(dev_priv))
> +		return icl_hpd_pin(dev_priv, port);
> +
> +	return HPD_PORT_A + port - PORT_A;
> +}
> +
>  #define port_tc_name(port) ((port) - PORT_TC1 + '1')
>  #define tc_port_name(tc_port) ((tc_port) - TC_PORT_1 + '1')
>  
> @@ -4070,6 +4078,8 @@ void intel_ddi_init(struct drm_i915_private *dev_priv, enum port port)
>  		encoder->hpd_pin = icl_hpd_pin(dev_priv, port);
>  	else if (IS_GEN(dev_priv, 10))
>  		encoder->hpd_pin = cnl_hpd_pin(dev_priv, port);
> +	else if (IS_GEN(dev_priv, 9))
> +		encoder->hpd_pin = skl_hpd_pin(dev_priv, port);
>  	else
>  		encoder->hpd_pin = intel_hpd_pin_default(dev_priv, port);
>  
> -- 
> 2.29.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
