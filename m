Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B02422E3D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbhJEQrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:47:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:6416 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhJEQrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:47:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="206607888"
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="206607888"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 09:43:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="488108560"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga008.jf.intel.com with SMTP; 05 Oct 2021 09:43:38 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 05 Oct 2021 19:43:38 +0300
Date:   Tue, 5 Oct 2021 19:43:38 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, geert@linux-m68k.org,
        oliver.sang@intel.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/edid: Fix crash with zero/invalid EDID
Message-ID: <YVyAutDoR4otVBS9@intel.com>
References: <20211004092100.1.Ic90a5ebd44c75db963112be167a03cc96f9fb249@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211004092100.1.Ic90a5ebd44c75db963112be167a03cc96f9fb249@changeid>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 09:21:27AM -0700, Douglas Anderson wrote:
> In the commit bac9c2948224 ("drm/edid: Break out reading block 0 of
> the EDID") I broke out reading the base block of the EDID to its own
> function. Unfortunately, when I did that I messed up the handling when
> drm_edid_is_zero() indicated that we had an EDID that was all 0x00 or
> when we went through 4 loops and didn't get a valid EDID. Specifically
> I needed to pass the broken EDID to connector_bad_edid() but now I was
> passing an error-pointer.
> 
> Let's re-jigger things so we can pass the bad EDID in properly.
> 
> Fixes: bac9c2948224 ("drm/edid: Break out reading block 0 of the EDID")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

A bit of historical fallout zone this part of the code. So
not the easiest thing to read in general. But looks like what
you have here should work.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
> 
>  drivers/gpu/drm/drm_edid.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 9b19eee0e1b4..9c9463ec5465 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -1911,13 +1911,15 @@ int drm_add_override_edid_modes(struct drm_connector *connector)
>  }
>  EXPORT_SYMBOL(drm_add_override_edid_modes);
>  
> -static struct edid *drm_do_get_edid_base_block(
> +static struct edid *drm_do_get_edid_base_block(struct drm_connector *connector,
>  	int (*get_edid_block)(void *data, u8 *buf, unsigned int block,
>  			      size_t len),
> -	void *data, bool *edid_corrupt, int *null_edid_counter)
> +	void *data)
>  {
> -	int i;
> +	int *null_edid_counter = connector ? &connector->null_edid_counter : NULL;
> +	bool *edid_corrupt = connector ? &connector->edid_corrupt : NULL;
>  	void *edid;
> +	int i;
>  
>  	edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
>  	if (edid == NULL)
> @@ -1941,9 +1943,8 @@ static struct edid *drm_do_get_edid_base_block(
>  	return edid;
>  
>  carp:
> -	kfree(edid);
> -	return ERR_PTR(-EINVAL);
> -
> +	if (connector)
> +		connector_bad_edid(connector, edid, 1);
>  out:
>  	kfree(edid);
>  	return NULL;
> @@ -1982,14 +1983,9 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
>  	if (override)
>  		return override;
>  
> -	edid = (u8 *)drm_do_get_edid_base_block(get_edid_block, data,
> -						&connector->edid_corrupt,
> -						&connector->null_edid_counter);
> -	if (IS_ERR_OR_NULL(edid)) {
> -		if (IS_ERR(edid))
> -			connector_bad_edid(connector, edid, 1);
> +	edid = (u8 *)drm_do_get_edid_base_block(connector, get_edid_block, data);
> +	if (!edid)
>  		return NULL;
> -	}
>  
>  	/* if there's no extensions or no connector, we're done */
>  	valid_extensions = edid[0x7e];
> @@ -2142,14 +2138,13 @@ u32 drm_edid_get_panel_id(struct i2c_adapter *adapter)
>  	struct edid *edid;
>  	u32 panel_id;
>  
> -	edid = drm_do_get_edid_base_block(drm_do_probe_ddc_edid, adapter,
> -					  NULL, NULL);
> +	edid = drm_do_get_edid_base_block(NULL, drm_do_probe_ddc_edid, adapter);
>  
>  	/*
>  	 * There are no manufacturer IDs of 0, so if there is a problem reading
>  	 * the EDID then we'll just return 0.
>  	 */
> -	if (IS_ERR_OR_NULL(edid))
> +	if (!edid)
>  		return 0;
>  
>  	panel_id = edid_extract_panel_id(edid);
> -- 
> 2.33.0.800.g4c38ced690-goog

-- 
Ville Syrjälä
Intel
