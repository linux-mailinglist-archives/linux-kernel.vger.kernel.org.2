Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B674339BEA8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhFDR2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:28:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:39630 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhFDR2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:28:37 -0400
IronPort-SDR: vC89Zk9JdxPzo8LPD8psxPGGPjSNSm3r/1lKntrqKK6FIKeW0eooD04wtyCc5+k4GYckbmW60F
 87G3O7OK8m4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265496854"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="265496854"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 10:26:49 -0700
IronPort-SDR: hHxfs9zcgC2O6PZrXBqdGq+eSyydodxVXZvXVI2bKozhgASgx9bBU8+ndopyiwkqxP9Y2HmPs8
 GPnpR/h35PpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="439257354"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga007.jf.intel.com with SMTP; 04 Jun 2021 10:26:44 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 04 Jun 2021 20:26:44 +0300
Date:   Fri, 4 Jun 2021 20:26:44 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/4] drm/uAPI: Add "active bpc" as feedback channel for
 "max bpc" drm property
Message-ID: <YLpiVFiBrgH29rki@intel.com>
References: <20210604171723.10276-1-wse@tuxedocomputers.com>
 <20210604171723.10276-3-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210604171723.10276-3-wse@tuxedocomputers.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 07:17:21PM +0200, Werner Sembach wrote:
> Add a new general drm property "active bpc" which can be used by graphic drivers
> to report the applied bit depth per pixel back to userspace.
> 
> While "max bpc" can be used to change the color depth, there was no way to check
> which one actually got used. While in theory the driver chooses the best/highest
> color depth within the max bpc setting a user might not be fully aware what his
> hardware is or isn't capable off. This is meant as a quick way to double check
> the setup.
> 
> In the future, automatic color calibration for screens might also depend on this
> information available.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c |  2 ++
>  drivers/gpu/drm/drm_connector.c   | 40 +++++++++++++++++++++++++++++++
>  include/drm/drm_connector.h       | 15 ++++++++++++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 268bb69c2e2f..7ae4e40936b5 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -873,6 +873,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
>  		*val = 0;
>  	} else if (property == connector->max_bpc_property) {
>  		*val = state->max_requested_bpc;
> +	} else if (property == connector->active_bpc_property) {
> +		*val = state->active_bpc;
>  	} else if (connector->funcs->atomic_get_property) {
>  		return connector->funcs->atomic_get_property(connector,
>  				state, property, val);
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 7631f76e7f34..5f42a5be5822 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1195,6 +1195,13 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
>   *	drm_connector_attach_max_bpc_property() to create and attach the
>   *	property to the connector during initialization.
>   *
> + * active bpc:
> + *	This read-only range property is used by userspace check the bit depth
> + *	actually applied by the GPU driver after evaluation all hardware
> + *	capabilities and max bpc. Drivers to use the function
> + *	drm_connector_attach_active_bpc_property() to create and attach the
> + *	property to the connector during initialization.
> + *
>   * Connectors also have one standardized atomic property:
>   *
>   * CRTC_ID:
> @@ -2150,6 +2157,39 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>  }
>  EXPORT_SYMBOL(drm_connector_attach_max_bpc_property);
>  
> +/**
> + * drm_connector_attach_active_bpc_property - attach "active bpc" property
> + * @connector: connector to attach active bpc property on.
> + * @min: The minimum bit depth supported by the connector.
> + * @max: The maximum bit depth supported by the connector.
> + *
> + * This is used to check the applied bit depth on a connector.
> + *
> + * Returns:
> + * Zero on success, negative errno on failure.
> + */
> +int drm_connector_attach_active_bpc_property(struct drm_connector *connector,
> +					  int min, int max)
> +{
> +	struct drm_device *dev = connector->dev;
> +	struct drm_property *prop;
> +
> +	prop = connector->active_bpc_property;
> +	if (!prop) {
> +		prop = drm_property_create_range(dev, 0, "active bpc", min, max);

Should be immutable.

Also wondering what the semantics of this should be when eg. DSC
is active?

> +		if (!prop)
> +			return -ENOMEM;
> +
> +		connector->active_bpc_property = prop;
> +	}
> +
> +	drm_object_attach_property(&connector->base, prop, 0);
> +	connector->state->active_bpc = 0;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_connector_attach_active_bpc_property);
> +
>  /**
>   * drm_connector_set_vrr_capable_property - sets the variable refresh rate
>   * capable property for a connector
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 1922b278ffad..c58cba2b6afe 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -781,6 +781,13 @@ struct drm_connector_state {
>  	 */
>  	u8 max_bpc;
>  
> +	/**
> +	 * @active_bpc: Read only property set by the GPU driver to the actually
> +	 * applied bit depth of the pixels after evaluating all hardware
> +	 * limitations.
> +	 */
> +	u8 active_bpc;
> +
>  	/**
>  	 * @hdr_output_metadata:
>  	 * DRM blob property for HDR output metadata
> @@ -1380,6 +1387,12 @@ struct drm_connector {
>  	 */
>  	struct drm_property *max_bpc_property;
>  
> +	/**
> +	 * @active_bpc_property: Default connector property for the active bpc
> +	 * to be driven out of the connector.
> +	 */
> +	struct drm_property *active_bpc_property;
> +
>  #define DRM_CONNECTOR_POLL_HPD (1 << 0)
>  #define DRM_CONNECTOR_POLL_CONNECT (1 << 1)
>  #define DRM_CONNECTOR_POLL_DISCONNECT (1 << 2)
> @@ -1698,6 +1711,8 @@ int drm_connector_set_panel_orientation_with_quirk(
>  	int width, int height);
>  int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>  					  int min, int max);
> +int drm_connector_attach_active_bpc_property(struct drm_connector *connector,
> +					  int min, int max);
>  
>  /**
>   * struct drm_tile_group - Tile group metadata
> -- 
> 2.25.1

-- 
Ville Syrjälä
Intel
