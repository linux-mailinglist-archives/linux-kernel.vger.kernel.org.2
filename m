Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317BE345A25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCWIyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:54:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:22479 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhCWIxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:53:39 -0400
IronPort-SDR: ZM9vjQhsXqJDvIXYuHd7eZ0QiI6m1Fh9HcqV76y4lRzPJh2bBcwYWa4ayjb+PcAqKaVbAAUe4E
 KvUTSFfwXOmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="189836000"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="189836000"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 01:53:38 -0700
IronPort-SDR: t+oiGgHPJCqHwAq8+rSN/RDWKIGZmRczwfRj/GoCOhzU1tWK+Oq7+4XqAwmZMmVM7uLzFsbWnr
 X4EKQEPaHWUw==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="414883545"
Received: from wjlloyd-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.53.124])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 01:53:33 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, imre.deak@intel.com,
        ville.syrjala@linux.intel.com, lucas.demarchi@intel.com,
        matthew.d.roper@intel.com,
        tejaskumarx.surendrakumar.upadhyay@intel.com,
        unixbhaskar@gmail.com, aditya.swarup@intel.com,
        anusha.srivatsa@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: Re: [PATCH] drm/i915: A typo fix
In-Reply-To: <20210323011607.182803-1-unixbhaskar@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210323011607.182803-1-unixbhaskar@gmail.com>
Date:   Tue, 23 Mar 2021 10:53:31 +0200
Message-ID: <87blba5jzo.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021, Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
> s/nothign/nothing/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

You've sent the same patch before? I've already pushed it.

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
> 2.31.0
>

-- 
Jani Nikula, Intel Open Source Graphics Center
