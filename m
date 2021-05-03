Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7257C3710A2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 05:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhECDHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 23:07:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:56767 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232392AbhECDH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 23:07:26 -0400
IronPort-SDR: kCjX26s8fheaQYA5n5KSAp0eHscybzxRnB+loy3F2QTcnis31majjMBSrgGndBcJnxNM4VKWJm
 5UocdSdKQ8/g==
X-IronPort-AV: E=McAfee;i="6200,9189,9972"; a="197708916"
X-IronPort-AV: E=Sophos;i="5.82,268,1613462400"; 
   d="scan'208";a="197708916"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2021 20:06:34 -0700
IronPort-SDR: HHVWRGq5bZuAXY29a6hCV4j1XzWO7JuSFxlqcKcEXJAHeQS+MyF1NqHR05hYoCVII25I/w0+FF
 EEbzpKVTipYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,268,1613462400"; 
   d="scan'208";a="457034607"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by FMSMGA003.fm.intel.com with SMTP; 02 May 2021 20:06:30 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 03 May 2021 06:06:30 +0300
Date:   Mon, 3 May 2021 06:06:29 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [Intel-gfx] [PATCH 2/2] drm/dp: Drop open-coded
 drm_dp_is_branch() in drm_dp_read_downstream_info()
Message-ID: <YI9otSh/ftvLqMxb@intel.com>
References: <20210430223428.10514-1-lyude@redhat.com>
 <20210430223428.10514-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210430223428.10514-2-lyude@redhat.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 06:34:28PM -0400, Lyude Paul wrote:
> Noticed this while fixing another issue in drm_dp_read_downstream_info(),
> the open coded DP_DOWNSTREAMPORT_PRESENT check here just duplicates what we
> already do in drm_dp_is_branch(), so just get rid of it.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_dp_helper.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 27c8c5bdf7d9..0f84df8798ab 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -677,9 +677,7 @@ int drm_dp_read_downstream_info(struct drm_dp_aux *aux,
>  	memset(downstream_ports, 0, DP_MAX_DOWNSTREAM_PORTS);
>  
>  	/* No downstream info to read */
> -	if (!drm_dp_is_branch(dpcd) ||
> -	    dpcd[DP_DPCD_REV] < DP_DPCD_REV_10 ||
> -	    !(dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DWN_STRM_PORT_PRESENT))
> +	if (!drm_dp_is_branch(dpcd) || dpcd[DP_DPCD_REV] < DP_DPCD_REV_10)

BTW that DPCD_REV check looks rather wrong.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

>  		return 0;
>  
>  	/* Some branches advertise having 0 downstream ports, despite also advertising they have a
> -- 
> 2.30.2
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Ville Syrjälä
Intel
