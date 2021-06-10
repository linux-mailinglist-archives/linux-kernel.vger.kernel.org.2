Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD73A2E31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhFJOb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:31:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:11728 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhFJObz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:31:55 -0400
IronPort-SDR: dnnxobe61lALNh83QG0iBuvBELJMkdTxUSVTF5eGSG5KTGG4SKJ43vHekrfoVXX1YhzRaIopJ8
 tK70qnkgdBLQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="203461898"
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="203461898"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 07:29:58 -0700
IronPort-SDR: CqbxeVTzHSnV4mW82zmiqTzAQw4SyA7B/76zpUXzQnUE6QC1QDpmbU9GAm7vCNgeujLfxXY/iE
 sK0JzxoJquPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="441234105"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga007.jf.intel.com with SMTP; 10 Jun 2021 07:29:53 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 10 Jun 2021 17:29:52 +0300
Date:   Thu, 10 Jun 2021 17:29:52 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     amd-gfx@lists.freedesktop.org, tzimmermann@suse.de,
        sunpeng.li@amd.com, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
        alexander.deucher@amd.com, christian.koenig@amd.com
Subject: Re: [PATCH 4/4] drm/i915/display: Add handling for new "active bpc"
 property
Message-ID: <YMIh4G1CY8EYVEuI@intel.com>
References: <20210604171723.10276-1-wse@tuxedocomputers.com>
 <20210604171723.10276-5-wse@tuxedocomputers.com>
 <YLpjTMegcjT22vQE@intel.com>
 <bd6a27e7-3ae5-ecb1-2fef-e5f8c1b6a2ac@tuxedocomputers.com>
 <96d10ed0-f8a2-1d0b-62dd-9d6173722506@tuxedocomputers.com>
 <210b4108-74a7-bf42-eab8-b98239ce3f1a@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <210b4108-74a7-bf42-eab8-b98239ce3f1a@tuxedocomputers.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 07:19:31PM +0200, Werner Sembach wrote:
> 
> Am 07.06.21 um 22:33 schrieb Werner Sembach:
> > Am 07.06.21 um 08:47 schrieb Werner Sembach:
> >>
> >> Am 04.06.21 um 19:30 schrieb Ville Syrj�l�:
> >>> On Fri, Jun 04, 2021 at 07:17:23PM +0200, Werner Sembach wrote:
> >>>> This commits implements the "active bpc" drm property for the Intel 
> >>>> GPU driver.
> >>>>
> >>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> >>>> ---
> >>>> � drivers/gpu/drm/i915/display/intel_display.c | 13 +++++++++++++
> >>>> � drivers/gpu/drm/i915/display/intel_dp.c����� |� 8 ++++++--
> >>>> � drivers/gpu/drm/i915/display/intel_dp_mst.c� |� 4 +++-
> >>>> � drivers/gpu/drm/i915/display/intel_hdmi.c��� |� 4 +++-
> >>>> � 4 files changed, 25 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/i915/display/intel_display.c 
> >>>> b/drivers/gpu/drm/i915/display/intel_display.c
> >>>> index 64e9107d70f7..f7898d9d7438 100644
> >>>> --- a/drivers/gpu/drm/i915/display/intel_display.c
> >>>> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> >>>> @@ -10164,6 +10164,8 @@ static void intel_atomic_commit_tail(struct 
> >>>> intel_atomic_state *state)
> >>>> ����� struct drm_i915_private *dev_priv = to_i915(dev);
> >>>> ����� struct intel_crtc_state *new_crtc_state, *old_crtc_state;
> >>>> ����� struct intel_crtc *crtc;
> >>>> +��� struct drm_connector *connector;
> >>>> +��� struct drm_connector_state *new_conn_state;
> >>>> ����� u64 put_domains[I915_MAX_PIPES] = {};
> >>>> ����� intel_wakeref_t wakeref = 0;
> >>>> ����� int i;
> >>>> @@ -10324,6 +10326,17 @@ static void 
> >>>> intel_atomic_commit_tail(struct intel_atomic_state *state)
> >>>> ����� }
> >>>> ����� intel_runtime_pm_put(&dev_priv->runtime_pm, state->wakeref);
> >>>> � +��� /* Extract information from crtc to communicate it to 
> >>>> userspace as connector properties */
> >>>> +��� for_each_new_connector_in_state(&state->base, connector, 
> >>>> new_conn_state, i) {
> >>>> +������� struct drm_crtc *crtc = new_conn_state->crtc;
> >>>> +������� if (crtc) {
> >>>> +����������� new_crtc_state = 
> >>>> to_intel_crtc_state(drm_atomic_get_new_crtc_state(&state->base, 
> >>>> crtc));
> >>> intel_atomic_get_new_crtc_state()
> >> Thanks, will use that.
> >>>
> >>>> + new_conn_state->active_bpc = new_crtc_state->pipe_bpp / 3;
> >>>> +������� }
> >>>> +������� else
> >>>> +����������� new_conn_state->active_bpc = 0;
> >>>> +��� }
> >>> This also seems too late. I think the whole thing should be
> >>> done somewhere around the normal swap_state() stuff.
> >> Ok, will look into it.
> > So I tried to put it in intel_atomic_commit() after 
> > drm_atomic_helper_swap_state() and before 
> > INIT_WORK(&state->base.commit_work, intel_atomic_commit_work) (which 
> > creates a worker for intel_atomic_commit_tail), but somewhere in 
> > between, the connector_state seems to change: The bpc written with the 
> > for_each_new_connector_in_state() loop, gets discarded.
> 
> This was not the problem. Setting the drm property immutable made it 
> (also?) immutable from the driver context, which I didn't test separately.
> 
> Removed the immutable again and moved the loop.

Immutable props are special. See __drm_object_property_get_value().

-- 
Ville Syrj�l�
Intel
