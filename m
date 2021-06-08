Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC1739EE8D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFHGOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:14:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:45940 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhFHGOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:14:05 -0400
IronPort-SDR: M0VNI7wZbry6xNRFBHdHPY0xQZ+ZPmjYJivMMg+4jmg+Gg9ehuRYltJ9DbhsHOGO7E5VsELhj/
 dKt7g52ZjL6A==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="192104874"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="192104874"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 23:12:12 -0700
IronPort-SDR: whekhH+DUY/L22S5XiQsTkHvvJod+1Jj3xQiVW1tsjKQSjaC4sRJHyZGYR8ZUEaVAP8Sdj+7EQ
 ig9yJmLawE3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="481822230"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga001.jf.intel.com with SMTP; 07 Jun 2021 23:12:07 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 08 Jun 2021 09:12:06 +0300
Date:   Tue, 8 Jun 2021 09:12:06 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     amd-gfx@lists.freedesktop.org, tzimmermann@suse.de,
        intel-gfx@lists.freedesktop.org, sunpeng.li@amd.com,
        dri-devel@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
        maarten.lankhorst@linux.intel.com, linux-kernel@vger.kernel.org,
        mripard@kernel.org, airlied@linux.ie, jani.nikula@linux.intel.com,
        daniel@ffwll.ch, rodrigo.vivi@intel.com, alexander.deucher@amd.com,
        harry.wentland@amd.com, christian.koenig@amd.com
Subject: Re: [PATCH 2/4] drm/uAPI: Add "active bpc" as feedback channel for
 "max bpc" drm property
Message-ID: <YL8KNshbrHt3FBFa@intel.com>
References: <20210604171723.10276-1-wse@tuxedocomputers.com>
 <20210604171723.10276-3-wse@tuxedocomputers.com>
 <YLpiVFiBrgH29rki@intel.com>
 <bef099db-f662-9005-6e36-ce056257f537@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bef099db-f662-9005-6e36-ce056257f537@tuxedocomputers.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 08:46:47AM +0200, Werner Sembach wrote:
> 
> Am 04.06.21 um 19:26 schrieb Ville Syrjälä:
> > On Fri, Jun 04, 2021 at 07:17:21PM +0200, Werner Sembach wrote:
> >> Add a new general drm property "active bpc" which can be used by graphic drivers
> >> to report the applied bit depth per pixel back to userspace.
> >>
> >> While "max bpc" can be used to change the color depth, there was no way to check
> >> which one actually got used. While in theory the driver chooses the best/highest
> >> color depth within the max bpc setting a user might not be fully aware what his
> >> hardware is or isn't capable off. This is meant as a quick way to double check
> >> the setup.
> >>
> >> In the future, automatic color calibration for screens might also depend on this
> >> information available.
> >>
> >> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> >> ---
> >>   drivers/gpu/drm/drm_atomic_uapi.c |  2 ++
> >>   drivers/gpu/drm/drm_connector.c   | 40 +++++++++++++++++++++++++++++++
> >>   include/drm/drm_connector.h       | 15 ++++++++++++
> >>   3 files changed, 57 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> >> index 268bb69c2e2f..7ae4e40936b5 100644
> >> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> >> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> >> @@ -873,6 +873,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
> >>   		*val = 0;
> >>   	} else if (property == connector->max_bpc_property) {
> >>   		*val = state->max_requested_bpc;
> >> +	} else if (property == connector->active_bpc_property) {
> >> +		*val = state->active_bpc;
> >>   	} else if (connector->funcs->atomic_get_property) {
> >>   		return connector->funcs->atomic_get_property(connector,
> >>   				state, property, val);
> >> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> >> index 7631f76e7f34..5f42a5be5822 100644
> >> --- a/drivers/gpu/drm/drm_connector.c
> >> +++ b/drivers/gpu/drm/drm_connector.c
> >> @@ -1195,6 +1195,13 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
> >>    *	drm_connector_attach_max_bpc_property() to create and attach the
> >>    *	property to the connector during initialization.
> >>    *
> >> + * active bpc:
> >> + *	This read-only range property is used by userspace check the bit depth
> >> + *	actually applied by the GPU driver after evaluation all hardware
> >> + *	capabilities and max bpc. Drivers to use the function
> >> + *	drm_connector_attach_active_bpc_property() to create and attach the
> >> + *	property to the connector during initialization.
> >> + *
> >>    * Connectors also have one standardized atomic property:
> >>    *
> >>    * CRTC_ID:
> >> @@ -2150,6 +2157,39 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
> >>   }
> >>   EXPORT_SYMBOL(drm_connector_attach_max_bpc_property);
> >>   
> >> +/**
> >> + * drm_connector_attach_active_bpc_property - attach "active bpc" property
> >> + * @connector: connector to attach active bpc property on.
> >> + * @min: The minimum bit depth supported by the connector.
> >> + * @max: The maximum bit depth supported by the connector.
> >> + *
> >> + * This is used to check the applied bit depth on a connector.
> >> + *
> >> + * Returns:
> >> + * Zero on success, negative errno on failure.
> >> + */
> >> +int drm_connector_attach_active_bpc_property(struct drm_connector *connector,
> >> +					  int min, int max)
> >> +{
> >> +	struct drm_device *dev = connector->dev;
> >> +	struct drm_property *prop;
> >> +
> >> +	prop = connector->active_bpc_property;
> >> +	if (!prop) {
> >> +		prop = drm_property_create_range(dev, 0, "active bpc", min, max);
> > Should be immutable.
> Yes. I didn't know if there is a way to do this (or just don't define a 
> set-function), but I think I found the define for this.
> >
> > Also wondering what the semantics of this should be when eg. DSC
> > is active?
> I'm unfamiliar how the inner workings of DSC (I guess Display Stream 
> Compression?) are. But doesn't it also have color depth?

Some number of bits go into the compressor, smaller/equal number
of bits come out. Not sure if the choice of the input bpc affects
what the sink does when decompressing or not.

> 
> The active bpc should be what the GPU tells the display to actually show 
> the user when he looks at just one pixel.
> 
> So dithering computed on the host should not be included (aka when the 
> gpu sends a premade picture to the screen and tells it the lesser pbc), 
> while FRC dithering computed in the display firmware should be included 
> (since the GPU can't really tell the difference between FRC displays and 
> True 10-Bit displays, can't it?)

Not sure. Haven't checked if there's something in some standard for
that.

-- 
Ville Syrjälä
Intel
