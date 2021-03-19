Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F89341999
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhCSKLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:11:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:18024 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230140AbhCSKKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:10:46 -0400
IronPort-SDR: puZjaoEQ0GvJ2RtvjSENOgk574lRNN7J0Plk+SO40+CnRBg6wG0GYtXi4Je42NCH7fgH2v4Qjx
 ejiqPSLi200g==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="186516765"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="186516765"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 03:10:46 -0700
IronPort-SDR: BP2x8eNN1duoqgsKcaQCBQEhSMeMBqP1S4Wlb+4Ha0LXvx0vzz62ouEWA9Axsm/nDMrHTeOYo1
 EP9QC4iBNurg==
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="413453437"
Received: from koehlcla-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 03:10:40 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, imre.deak@intel.com,
        ville.syrjala@linux.intel.com, lucas.demarchi@intel.com,
        matthew.d.roper@intel.com,
        tejaskumarx.surendrakumar.upadhyay@intel.com,
        aditya.swarup@intel.com, anusha.srivatsa@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH] drm: i915: Fix a typo
In-Reply-To: <20210319043701.14105-1-unixbhaskar@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210319043701.14105-1-unixbhaskar@gmail.com>
Date:   Fri, 19 Mar 2021 12:10:37 +0200
Message-ID: <87mtuz78te.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021, Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
> s/nothign/nothing/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Thanks, pushed.

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> index f6ad257a260e..14d784a6fae5 100644
> --- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> +++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> @@ -4185,7 +4185,7 @@ static void icl_pll_disable(struct drm_i915_private *dev_priv,
>  	/*
>  	 * DVFS pre sequence would be here, but in our driver the cdclk code
>  	 * paths should already be setting the appropriate voltage, hence we do
> -	 * nothign here.
> +	 * nothing here.
>  	 */
>
>  	val = intel_de_read(dev_priv, enable_reg);
> --
> 2.26.2
>

-- 
Jani Nikula, Intel Open Source Graphics Center
