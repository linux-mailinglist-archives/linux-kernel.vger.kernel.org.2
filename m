Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999B43F8D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243232AbhHZRi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:38:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:61186 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231801AbhHZRiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:38:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="217520636"
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="217520636"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 10:37:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="537536146"
Received: from fbenmlih-mobile.amr.corp.intel.com (HELO intel.com) ([10.255.36.148])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 10:37:35 -0700
Date:   Thu, 26 Aug 2021 13:37:34 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Sean Paul <seanpaul@chromium.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/i915/dp: Use max params for panels < eDP 1.4
Message-ID: <YSfRXjuRWa57uxXN@intel.com>
References: <20210820075301.693099-1-kai.heng.feng@canonical.com>
 <YR/ltlF5jRTYzQ3F@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YR/ltlF5jRTYzQ3F@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 08:26:14PM +0300, Ville Syrjälä wrote:
> On Fri, Aug 20, 2021 at 03:52:59PM +0800, Kai-Heng Feng wrote:
> > Users reported that after commit 2bbd6dba84d4 ("drm/i915: Try to use
> > fast+narrow link on eDP again and fall back to the old max strategy on
> > failure"), the screen starts to have wobbly effect.
> > 
> > Commit a5c936add6a2 ("drm/i915/dp: Use slow and wide link training for
> > everything") doesn't help either, that means the affected eDP 1.2 panels
> > only work with max params.
> > 
> > So use max params for panels < eDP 1.4 as Windows does to solve the
> > issue.
> > 
> > v3:
> >  - Do the eDP rev check in intel_edp_init_dpcd()
> > 
> > v2:
> >  - Check eDP 1.4 instead of DPCD 1.1 to apply max params
> > 
> > Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3714
> > Fixes: 2bbd6dba84d4 ("drm/i915: Try to use fast+narrow link on eDP again and fall back to the old max strategy on failure")
> > Fixes: a5c936add6a2 ("drm/i915/dp: Use slow and wide link training for everything")
> > Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Slapped a cc:stable on it and pushed to drm-intel-next. Thanks.

Since I got a strange failure on CI_DIF_604 that I don't see on CI_DIF_603,
I'm avoiding the display patches. This one and also
dab1b47e57e0 ("drm/i915/dp: return proper DPRX link training result")

I know, it is probably the other one, but I had to remove both patches for
now and I'm not confident the CI will allow me to test with this one alone.

If we have -rc8 I will check again later. Otherwise we will have to send
to the stable mailing list later.

> 
> > ---
> >  drivers/gpu/drm/i915/display/intel_dp.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> > index 75d4ebc669411..e0dbd35ae7bc0 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -2445,11 +2445,14 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp)
> >  	 */
> >  	if (drm_dp_dpcd_read(&intel_dp->aux, DP_EDP_DPCD_REV,
> >  			     intel_dp->edp_dpcd, sizeof(intel_dp->edp_dpcd)) ==
> > -			     sizeof(intel_dp->edp_dpcd))
> > +			     sizeof(intel_dp->edp_dpcd)) {
> >  		drm_dbg_kms(&dev_priv->drm, "eDP DPCD: %*ph\n",
> >  			    (int)sizeof(intel_dp->edp_dpcd),
> >  			    intel_dp->edp_dpcd);
> >  
> > +		intel_dp->use_max_params = intel_dp->edp_dpcd[0] < DP_EDP_14;
> > +	}
> > +
> >  	/*
> >  	 * This has to be called after intel_dp->edp_dpcd is filled, PSR checks
> >  	 * for SET_POWER_CAPABLE bit in intel_dp->edp_dpcd[1]
> > -- 
> > 2.32.0
> 
> -- 
> Ville Syrjälä
> Intel
