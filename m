Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F2D39D554
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFGGsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhFGGsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:48:41 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB935C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 23:46:50 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 0C3B8C800E1;
        Mon,  7 Jun 2021 08:46:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id CcSs6_Du4AyO; Mon,  7 Jun 2021 08:46:47 +0200 (CEST)
Received: from [IPv6:2003:e3:7f4f:6000:f5f4:4cdd:8015:9770] (p200300E37F4f6000F5F44cDd80159770.dip0.t-ipconnect.de [IPv6:2003:e3:7f4f:6000:f5f4:4cdd:8015:9770])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 71043C800DF;
        Mon,  7 Jun 2021 08:46:47 +0200 (CEST)
Subject: Re: [PATCH 2/4] drm/uAPI: Add "active bpc" as feedback channel for
 "max bpc" drm property
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     amd-gfx@lists.freedesktop.org, tzimmermann@suse.de,
        intel-gfx@lists.freedesktop.org, sunpeng.li@amd.com,
        dri-devel@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
        maarten.lankhorst@linux.intel.com, linux-kernel@vger.kernel.org,
        mripard@kernel.org, airlied@linux.ie, jani.nikula@linux.intel.com,
        daniel@ffwll.ch, rodrigo.vivi@intel.com, alexander.deucher@amd.com,
        harry.wentland@amd.com, christian.koenig@amd.com
References: <20210604171723.10276-1-wse@tuxedocomputers.com>
 <20210604171723.10276-3-wse@tuxedocomputers.com> <YLpiVFiBrgH29rki@intel.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
Message-ID: <bef099db-f662-9005-6e36-ce056257f537@tuxedocomputers.com>
Date:   Mon, 7 Jun 2021 08:46:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YLpiVFiBrgH29rki@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 04.06.21 um 19:26 schrieb Ville Syrjälä:
> On Fri, Jun 04, 2021 at 07:17:21PM +0200, Werner Sembach wrote:
>> Add a new general drm property "active bpc" which can be used by graphic drivers
>> to report the applied bit depth per pixel back to userspace.
>>
>> While "max bpc" can be used to change the color depth, there was no way to check
>> which one actually got used. While in theory the driver chooses the best/highest
>> color depth within the max bpc setting a user might not be fully aware what his
>> hardware is or isn't capable off. This is meant as a quick way to double check
>> the setup.
>>
>> In the future, automatic color calibration for screens might also depend on this
>> information available.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> ---
>>   drivers/gpu/drm/drm_atomic_uapi.c |  2 ++
>>   drivers/gpu/drm/drm_connector.c   | 40 +++++++++++++++++++++++++++++++
>>   include/drm/drm_connector.h       | 15 ++++++++++++
>>   3 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
>> index 268bb69c2e2f..7ae4e40936b5 100644
>> --- a/drivers/gpu/drm/drm_atomic_uapi.c
>> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
>> @@ -873,6 +873,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
>>   		*val = 0;
>>   	} else if (property == connector->max_bpc_property) {
>>   		*val = state->max_requested_bpc;
>> +	} else if (property == connector->active_bpc_property) {
>> +		*val = state->active_bpc;
>>   	} else if (connector->funcs->atomic_get_property) {
>>   		return connector->funcs->atomic_get_property(connector,
>>   				state, property, val);
>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
>> index 7631f76e7f34..5f42a5be5822 100644
>> --- a/drivers/gpu/drm/drm_connector.c
>> +++ b/drivers/gpu/drm/drm_connector.c
>> @@ -1195,6 +1195,13 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
>>    *	drm_connector_attach_max_bpc_property() to create and attach the
>>    *	property to the connector during initialization.
>>    *
>> + * active bpc:
>> + *	This read-only range property is used by userspace check the bit depth
>> + *	actually applied by the GPU driver after evaluation all hardware
>> + *	capabilities and max bpc. Drivers to use the function
>> + *	drm_connector_attach_active_bpc_property() to create and attach the
>> + *	property to the connector during initialization.
>> + *
>>    * Connectors also have one standardized atomic property:
>>    *
>>    * CRTC_ID:
>> @@ -2150,6 +2157,39 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>>   }
>>   EXPORT_SYMBOL(drm_connector_attach_max_bpc_property);
>>   
>> +/**
>> + * drm_connector_attach_active_bpc_property - attach "active bpc" property
>> + * @connector: connector to attach active bpc property on.
>> + * @min: The minimum bit depth supported by the connector.
>> + * @max: The maximum bit depth supported by the connector.
>> + *
>> + * This is used to check the applied bit depth on a connector.
>> + *
>> + * Returns:
>> + * Zero on success, negative errno on failure.
>> + */
>> +int drm_connector_attach_active_bpc_property(struct drm_connector *connector,
>> +					  int min, int max)
>> +{
>> +	struct drm_device *dev = connector->dev;
>> +	struct drm_property *prop;
>> +
>> +	prop = connector->active_bpc_property;
>> +	if (!prop) {
>> +		prop = drm_property_create_range(dev, 0, "active bpc", min, max);
> Should be immutable.
Yes. I didn't know if there is a way to do this (or just don't define a 
set-function), but I think I found the define for this.
>
> Also wondering what the semantics of this should be when eg. DSC
> is active?
I'm unfamiliar how the inner workings of DSC (I guess Display Stream 
Compression?) are. But doesn't it also have color depth?

The active bpc should be what the GPU tells the display to actually show 
the user when he looks at just one pixel.

So dithering computed on the host should not be included (aka when the 
gpu sends a premade picture to the screen and tells it the lesser pbc), 
while FRC dithering computed in the display firmware should be included 
(since the GPU can't really tell the difference between FRC displays and 
True 10-Bit displays, can't it?)
>
>> +		if (!prop)
>> +			return -ENOMEM;
>> +
>> +		connector->active_bpc_property = prop;
>> +	}
>> +
>> +	drm_object_attach_property(&connector->base, prop, 0);
>> +	connector->state->active_bpc = 0;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(drm_connector_attach_active_bpc_property);
>> +
>>   /**
>>    * drm_connector_set_vrr_capable_property - sets the variable refresh rate
>>    * capable property for a connector
>> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
>> index 1922b278ffad..c58cba2b6afe 100644
>> --- a/include/drm/drm_connector.h
>> +++ b/include/drm/drm_connector.h
>> @@ -781,6 +781,13 @@ struct drm_connector_state {
>>   	 */
>>   	u8 max_bpc;
>>   
>> +	/**
>> +	 * @active_bpc: Read only property set by the GPU driver to the actually
>> +	 * applied bit depth of the pixels after evaluating all hardware
>> +	 * limitations.
>> +	 */
>> +	u8 active_bpc;
>> +
>>   	/**
>>   	 * @hdr_output_metadata:
>>   	 * DRM blob property for HDR output metadata
>> @@ -1380,6 +1387,12 @@ struct drm_connector {
>>   	 */
>>   	struct drm_property *max_bpc_property;
>>   
>> +	/**
>> +	 * @active_bpc_property: Default connector property for the active bpc
>> +	 * to be driven out of the connector.
>> +	 */
>> +	struct drm_property *active_bpc_property;
>> +
>>   #define DRM_CONNECTOR_POLL_HPD (1 << 0)
>>   #define DRM_CONNECTOR_POLL_CONNECT (1 << 1)
>>   #define DRM_CONNECTOR_POLL_DISCONNECT (1 << 2)
>> @@ -1698,6 +1711,8 @@ int drm_connector_set_panel_orientation_with_quirk(
>>   	int width, int height);
>>   int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>>   					  int min, int max);
>> +int drm_connector_attach_active_bpc_property(struct drm_connector *connector,
>> +					  int min, int max);
>>   
>>   /**
>>    * struct drm_tile_group - Tile group metadata
>> -- 
>> 2.25.1
