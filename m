Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BE539E883
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhFGUfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:35:54 -0400
Received: from srv6.fidu.org ([159.69.62.71]:41150 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhFGUfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:35:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id ABF33C800EB;
        Mon,  7 Jun 2021 22:33:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id m8ADLpTJUMYx; Mon,  7 Jun 2021 22:33:59 +0200 (CEST)
Received: from [IPv6:2003:e3:7f4f:6000:f5f4:4cdd:8015:9770] (p200300e37F4f6000F5F44cDd80159770.dip0.t-ipconnect.de [IPv6:2003:e3:7f4f:6000:f5f4:4cdd:8015:9770])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id E768CC800E8;
        Mon,  7 Jun 2021 22:33:57 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: [PATCH 4/4] drm/i915/display: Add handling for new "active bpc"
 property
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     mripard@kernel.org, daniel@ffwll.ch, sunpeng.li@amd.com,
        intel-gfx@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
        maarten.lankhorst@linux.intel.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        jani.nikula@linux.intel.com, amd-gfx@lists.freedesktop.org,
        tzimmermann@suse.de, rodrigo.vivi@intel.com,
        alexander.deucher@amd.com, harry.wentland@amd.com,
        christian.koenig@amd.com
References: <20210604171723.10276-1-wse@tuxedocomputers.com>
 <20210604171723.10276-5-wse@tuxedocomputers.com> <YLpjTMegcjT22vQE@intel.com>
 <bd6a27e7-3ae5-ecb1-2fef-e5f8c1b6a2ac@tuxedocomputers.com>
Message-ID: <96d10ed0-f8a2-1d0b-62dd-9d6173722506@tuxedocomputers.com>
Date:   Mon, 7 Jun 2021 22:33:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bd6a27e7-3ae5-ecb1-2fef-e5f8c1b6a2ac@tuxedocomputers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.06.21 um 08:47 schrieb Werner Sembach:
>
> Am 04.06.21 um 19:30 schrieb Ville Syrjälä:
>> On Fri, Jun 04, 2021 at 07:17:23PM +0200, Werner Sembach wrote:
>>> This commits implements the "active bpc" drm property for the Intel 
>>> GPU driver.
>>>
>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>> ---
>>>   drivers/gpu/drm/i915/display/intel_display.c | 13 +++++++++++++
>>>   drivers/gpu/drm/i915/display/intel_dp.c      |  8 ++++++--
>>>   drivers/gpu/drm/i915/display/intel_dp_mst.c  |  4 +++-
>>>   drivers/gpu/drm/i915/display/intel_hdmi.c    |  4 +++-
>>>   4 files changed, 25 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/display/intel_display.c 
>>> b/drivers/gpu/drm/i915/display/intel_display.c
>>> index 64e9107d70f7..f7898d9d7438 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_display.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_display.c
>>> @@ -10164,6 +10164,8 @@ static void intel_atomic_commit_tail(struct 
>>> intel_atomic_state *state)
>>>       struct drm_i915_private *dev_priv = to_i915(dev);
>>>       struct intel_crtc_state *new_crtc_state, *old_crtc_state;
>>>       struct intel_crtc *crtc;
>>> +    struct drm_connector *connector;
>>> +    struct drm_connector_state *new_conn_state;
>>>       u64 put_domains[I915_MAX_PIPES] = {};
>>>       intel_wakeref_t wakeref = 0;
>>>       int i;
>>> @@ -10324,6 +10326,17 @@ static void intel_atomic_commit_tail(struct 
>>> intel_atomic_state *state)
>>>       }
>>>       intel_runtime_pm_put(&dev_priv->runtime_pm, state->wakeref);
>>>   +    /* Extract information from crtc to communicate it to 
>>> userspace as connector properties */
>>> +    for_each_new_connector_in_state(&state->base, connector, 
>>> new_conn_state, i) {
>>> +        struct drm_crtc *crtc = new_conn_state->crtc;
>>> +        if (crtc) {
>>> +            new_crtc_state = 
>>> to_intel_crtc_state(drm_atomic_get_new_crtc_state(&state->base, crtc));
>> intel_atomic_get_new_crtc_state()
> Thanks, will use that.
>>
>>> + new_conn_state->active_bpc = new_crtc_state->pipe_bpp / 3;
>>> +        }
>>> +        else
>>> +            new_conn_state->active_bpc = 0;
>>> +    }
>> This also seems too late. I think the whole thing should be
>> done somewhere around the normal swap_state() stuff.
> Ok, will look into it.
So I tried to put it in intel_atomic_commit() after 
drm_atomic_helper_swap_state() and before 
INIT_WORK(&state->base.commit_work, intel_atomic_commit_work) (which 
creates a worker for intel_atomic_commit_tail), but somewhere in 
between, the connector_state seems to change: The bpc written with the 
for_each_new_connector_in_state() loop, gets discarded.
>>
>>> +
>>>       /*
>>>        * Defer the cleanup of the old state to a separate worker to not
>>>        * impede the current task (userspace for blocking modesets) that
>>> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c 
>>> b/drivers/gpu/drm/i915/display/intel_dp.c
>>> index 642c60f3d9b1..67826ba976ed 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_dp.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
>>> @@ -4671,10 +4671,14 @@ intel_dp_add_properties(struct intel_dp 
>>> *intel_dp, struct drm_connector *connect
>>>           intel_attach_force_audio_property(connector);
>>>         intel_attach_broadcast_rgb_property(connector);
>>> -    if (HAS_GMCH(dev_priv))
>>> +    if (HAS_GMCH(dev_priv)) {
>>>           drm_connector_attach_max_bpc_property(connector, 6, 10);
>>> -    else if (DISPLAY_VER(dev_priv) >= 5)
>>> +        drm_connector_attach_active_bpc_property(connector, 6, 10);
>>> +    }
>>> +    else if (DISPLAY_VER(dev_priv) >= 5) {
>>>           drm_connector_attach_max_bpc_property(connector, 6, 12);
>>> +        drm_connector_attach_active_bpc_property(connector, 6, 12);
>>> +    }
>>>         /* Register HDMI colorspace for case of lspcon */
>>>       if (intel_bios_is_lspcon_present(dev_priv, port)) {
>>> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c 
>>> b/drivers/gpu/drm/i915/display/intel_dp_mst.c
>>> index 2daa3f67791e..5a1869dc2210 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
>>> @@ -844,8 +844,10 @@ static struct drm_connector 
>>> *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
>>>        */
>>>       connector->max_bpc_property =
>>> intel_dp->attached_connector->base.max_bpc_property;
>>> -    if (connector->max_bpc_property)
>>> +    if (connector->max_bpc_property) {
>>>           drm_connector_attach_max_bpc_property(connector, 6, 12);
>>> +        drm_connector_attach_active_bpc_property(connector, 6, 12);
>>> +    }
>>>         return connector;
>>>   diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c 
>>> b/drivers/gpu/drm/i915/display/intel_hdmi.c
>>> index d69f0a6dc26d..8af78b27b6ce 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
>>> @@ -2463,8 +2463,10 @@ intel_hdmi_add_properties(struct intel_hdmi 
>>> *intel_hdmi, struct drm_connector *c
>>>           drm_object_attach_property(&connector->base,
>>> connector->dev->mode_config.hdr_output_metadata_property, 0);
>>>   -    if (!HAS_GMCH(dev_priv))
>>> +    if (!HAS_GMCH(dev_priv)) {
>>>           drm_connector_attach_max_bpc_property(connector, 8, 12);
>>> +        drm_connector_attach_active_bpc_property(connector, 8, 12);
>>> +    }
>>>   }
>>>     /*
>>> -- 
>>> 2.25.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
