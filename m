Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B0530F11B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhBDKpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:45:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:52906 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235037AbhBDKpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:45:19 -0500
IronPort-SDR: j/GbsNOoNowtUHBalcuGDyhLqBxrJINjf7Ou5qit2/qzgnfPPzf8q/j1L1snEqjxbx8VbBmlvQ
 m7DkVzm/icrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="242723583"
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="242723583"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:44:37 -0800
IronPort-SDR: PVOI/G2+/ZiQWeX5LUb4HtD1Ld7CVXQhvQyVaAW11Nq0aIYkKueAedfuUUi80zuDxgX09iFQS8
 IN+encK524Uw==
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="393103840"
Received: from dbmayer-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:44:34 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Colin King <colin.king@canonical.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915/display: fix spelling mistake "Couldnt" -> "Couldn't"
In-Reply-To: <20210203110803.17894-1-colin.king@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210203110803.17894-1-colin.king@canonical.com>
Date:   Thu, 04 Feb 2021 12:44:31 +0200
Message-ID: <87eehwf6y8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Feb 2021, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a drm_dbg message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, pushed to drm-intel-next.

BR,
Jani.


> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 8c12d5375607..a338720cee2e 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -2650,7 +2650,7 @@ void intel_dp_check_frl_training(struct intel_dp *intel_dp)
>  	if (intel_dp_pcon_start_frl_training(intel_dp) < 0) {
>  		int ret, mode;
>  
> -		drm_dbg(&dev_priv->drm, "Couldnt set FRL mode, continuing with TMDS mode\n");
> +		drm_dbg(&dev_priv->drm, "Couldn't set FRL mode, continuing with TMDS mode\n");
>  		ret = drm_dp_pcon_reset_frl_config(&intel_dp->aux);
>  		mode = drm_dp_pcon_hdmi_link_mode(&intel_dp->aux, NULL);

-- 
Jani Nikula, Intel Open Source Graphics Center
