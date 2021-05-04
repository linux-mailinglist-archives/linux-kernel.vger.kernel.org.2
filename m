Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16FD372828
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 11:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhEDJmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 05:42:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:62423 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229883AbhEDJmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 05:42:47 -0400
IronPort-SDR: 74YS3uIK1X1b5HC8FkhXPYr4HMhAprg8YSsYW5jLiKr9Iyke1KaMyPtSc4FZ2BYzXgGmAV89jF
 OlWZvhF3FAhQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="283349582"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="283349582"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 02:41:53 -0700
IronPort-SDR: sU4PVJe6GtdbV7YJEGJRCukzA44tIFHj0qbCVsUAyr5k7WbJdlTTZ7Cu+pW2E3xGVvkyE4Xtkw
 1UmswrcCtc2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="427713958"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga007.jf.intel.com with SMTP; 04 May 2021 02:41:49 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 04 May 2021 12:41:48 +0300
Date:   Tue, 4 May 2021 12:41:48 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Add missing check
Message-ID: <YJEW3J0+RQPo22AD@intel.com>
References: <20210503182148.851790-1-wse@tuxedocomputers.com>
 <20210503182148.851790-3-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210503182148.851790-3-wse@tuxedocomputers.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 08:21:46PM +0200, Werner Sembach wrote:
> Add a missing check that could potentially lead to an unarchivable mode being
> validated.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
> 
> >From 54fa706f0a5f260a32af5d18b9622ceebb94c12e Mon Sep 17 00:00:00 2001
> From: Werner Sembach <wse@tuxedocomputers.com>
> Date: Mon, 3 May 2021 14:42:36 +0200
> Subject: [PATCH 2/4] Add missing check

I guess you did something a bit wonky with git format-patch/send-mail?

> 
> ---
>  drivers/gpu/drm/i915/display/intel_hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index 576d3d910d06..ce165ef28e88 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -1913,7 +1913,7 @@ intel_hdmi_mode_valid(struct drm_connector *connector,
>  		clock *= 2;
>  	}
>  
> -	if (drm_mode_is_420_only(&connector->display_info, mode))
> +	if (connector->ycbcr_420_allowed && drm_mode_is_420_only(&connector->display_info, mode))

This one shouldn't be necessary. drm_mode_validate_ycbcr420() has
already checked it for us.

>  		clock /= 2;
>  
>  	status = intel_hdmi_mode_clock_valid(hdmi, clock, has_hdmi_sink);
> -- 
> 2.25.1

-- 
Ville Syrjälä
Intel
