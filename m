Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2F8422CE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhJEPst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:48:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:6184 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235588AbhJEPsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:48:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="286657013"
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="286657013"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 08:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="559365575"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by FMSMGA003.fm.intel.com with SMTP; 05 Oct 2021 08:46:40 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 05 Oct 2021 18:46:39 +0300
Date:   Tue, 5 Oct 2021 18:46:39 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, Rodrigo.Siqueira@amd.com,
        Harry.Wentland@amd.com, khsieh@codeaurora.org, Jerry.Zuo@amd.com,
        alexander.deucher@amd.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/edid: In connector_bad_edid() cap num_of_ext by
 num_blocks read
Message-ID: <YVxzX9h+jBqOj1/V@intel.com>
References: <20211005081022.1.Ib059f9c23c2611cb5a9d760e7d0a700c1295928d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211005081022.1.Ib059f9c23c2611cb5a9d760e7d0a700c1295928d@changeid>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 08:10:28AM -0700, Douglas Anderson wrote:
> In commit e11f5bd8228f ("drm: Add support for DP 1.4 Compliance edid
> corruption test") the function connector_bad_edid() started assuming
> that the memory for the EDID passed to it was big enough to hold
> `edid[0x7e] + 1` blocks of data (1 extra for the base block). It
> completely ignored the fact that the function was passed `num_blocks`
> which indicated how much memory had been allocated for the EDID.
> 
> Let's fix this by adding a bounds check.
> 
> This is important for handling the case where there's an error in the
> first block of the EDID. In that case we will call
> connector_bad_edid() without having re-allocated memory based on
> `edid[0x7e]`.
> 
> Fixes: e11f5bd8228f ("drm: Add support for DP 1.4 Compliance edid corruption test")
> Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This problem report came up in the context of a patch I sent out [1]
> and this is my attempt at a fix. The problem predates my patch,
> though. I don't personally know anything about DP compliance testing
> and what should be happening here, nor do I apparently have any
> hardware that actually reports a bad EDID. Thus this is just compile
> tested. I'm hoping that someone here can test this and make sure it
> seems OK to them.
> 
>  drivers/gpu/drm/drm_edid.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 9b19eee0e1b4..ccfa08631c57 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -1843,8 +1843,9 @@ static void connector_bad_edid(struct drm_connector *connector,
>  	u8 num_of_ext = edid[0x7e];
>  
>  	/* Calculate real checksum for the last edid extension block data */
> -	connector->real_edid_checksum =
> -		drm_edid_block_checksum(edid + num_of_ext * EDID_LENGTH);
> +	if (num_of_ext <= num_blocks - 1)

Something about that doesn't really agree with my brain.
It's correct but when I read it I can't immediately see it.

I guess what I'd like to see is something like:
last_block = edid[0x7e];
if (last_block < num_blocks)
	connector->real_edid_checksum =
		drm_edid_block_checksum(edid + last_block * EDID_LENGTH);

Techically exactly the same thing, but I don't have to read
the comparison twice to convince myself that it's correct.

Anyways, this is
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
either way.

> +		connector->real_edid_checksum =
> +			drm_edid_block_checksum(edid + num_of_ext * EDID_LENGTH);
>  
>  	if (connector->bad_edid_counter++ && !drm_debug_enabled(DRM_UT_KMS))
>  		return;
> -- 
> 2.33.0.800.g4c38ced690-goog

-- 
Ville Syrjälä
Intel
