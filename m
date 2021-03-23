Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA9B3460FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhCWOGW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Mar 2021 10:06:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:44770 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232158AbhCWOGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:06:13 -0400
IronPort-SDR: 46nylmF01wxZhGJfMmOb9TvHP9mipiLaU3egVVxEARU0sKt4nF5Tdsw9YsWNU1IhRMsfQpRJCx
 QPSij6jLbspg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="189882787"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="189882787"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 07:06:12 -0700
IronPort-SDR: OgCpjYysMewcIG7T/5T0gGkytTxkwKdQzZxfWA+o+XkeIOGiAR9CjOmP4KM7hy9ER20JHM2jeu
 T502Uf/10h2w==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="414998948"
Received: from wjlloyd-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.53.124])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 07:06:08 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     lyude@redhat.com, intel-gfx@lists.freedesktop.org
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Aaron Ma <aaron.ma@canonical.com>,
        Dave Airlie <airlied@redhat.com>,
        "open list\:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/i915/dpcd_bl: Don't try vesa interface unless specified by VBT
In-Reply-To: <dfec442a4888c8387a6002b0424415ee5d8be343.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210318170204.513000-1-lyude@redhat.com> <dfec442a4888c8387a6002b0424415ee5d8be343.camel@redhat.com>
Date:   Tue, 23 Mar 2021 16:06:05 +0200
Message-ID: <87k0py3qya.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021, Lyude Paul <lyude@redhat.com> wrote:
> Actually-NAK this. I just realized I've been misreading the bug and that this
> doesn't actually seem to be fixed. Will resend once I figure out what's going on

Well, I think there are actually multiple issues on multiple
machines. This fixes the issue on ThinkPad X1 Titanium Gen1 [1].

I suspect reverting 98e497e203a5 ("drm/i915/dpcd_bl: uncheck PWM_PIN_CAP
when detect eDP backlight capabilities") would too. But then that would
break *other* machines that claim support for *both* eDP PWM pin and
DPCD backlight control, I think.

I think there are issues with how we try setup DPCD backlight if the GOP
has set up PWM backlight. For example, we don't set the backlight
control mode correctly until the next disable/enable sequence. However,
I tried to fix this, and I think I was doing all the right things, and
DPCD reads seemed to confirm this, yet I was not able to control
brightness using DPCD. I don't know what gives, but I do know eDP PWM
pin control works.


BR,
Jani.


[1] https://gitlab.freedesktop.org/drm/intel/-/issues/3158


>
> On Thu, 2021-03-18 at 13:02 -0400, Lyude Paul wrote:
>> Looks like that there actually are another subset of laptops on the market
>> that don't support the Intel HDR backlight interface, but do advertise
>> support for the VESA DPCD backlight interface despite the fact it doesn't
>> seem to work.
>> 
>> Note though I'm not entirely clear on this - on one of the machines where
>> this issue was observed, I also noticed that we appeared to be rejecting
>> the VBT defined backlight frequency in
>> intel_dp_aux_vesa_calc_max_backlight(). It's noted in this function that:
>> 
>> /* Use highest possible value of Pn for more granularity of brightness
>>  * adjustment while satifying the conditions below.
>>  * ...
>>  * - FxP is within 25% of desired value.
>>  *   Note: 25% is arbitrary value and may need some tweak.
>>  */
>> 
>> So it's possible that this value might just need to be tweaked, but for now
>> let's just disable the VESA backlight interface unless it's specified in
>> the VBT just to be safe. We might be able to try enabling this again by
>> default in the future.
>> 
>> Fixes: 2227816e647a ("drm/i915/dp: Allow forcing specific interfaces through
>> enable_dpcd_backlight")
>> Cc: Jani Nikula <jani.nikula@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Bugzilla: https://gitlab.freedesktop.org/drm/intel/-/issues/3169
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>> ---
>>  drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>> b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>> index 651884390137..4f8337c7fd2e 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>> @@ -646,7 +646,6 @@ int intel_dp_aux_init_backlight_funcs(struct
>> intel_connector *connector)
>>                         break;
>>                 case INTEL_BACKLIGHT_DISPLAY_DDI:
>>                         try_intel_interface = true;
>> -                       try_vesa_interface = true;
>>                         break;
>>                 default:
>>                         return -ENODEV;

-- 
Jani Nikula, Intel Open Source Graphics Center
