Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21FC424A45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 01:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhJFXC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 19:02:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:6249 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhJFXCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 19:02:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="223515489"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="223515489"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 16:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="624046966"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga001.fm.intel.com with SMTP; 06 Oct 2021 16:00:10 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 07 Oct 2021 02:00:09 +0300
Date:   Thu, 7 Oct 2021 02:00:09 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Zuo, Jerry" <Jerry.Zuo@amd.com>, alexander.deucher@amd.com,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/edid: In connector_bad_edid() cap num_of_ext by
 num_blocks read
Message-ID: <YV4qeRtJoJW+W2at@intel.com>
References: <20211005192905.v2.1.Ib059f9c23c2611cb5a9d760e7d0a700c1295928d@changeid>
 <CAD=FV=XP6TFVn=uxRYr0fXzK9s-uh=a06kZBA5Y6Sj99OCeCXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XP6TFVn=uxRYr0fXzK9s-uh=a06kZBA5Y6Sj99OCeCXQ@mail.gmail.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 03:45:07PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Oct 5, 2021 at 7:29 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > In commit e11f5bd8228f ("drm: Add support for DP 1.4 Compliance edid
> > corruption test") the function connector_bad_edid() started assuming
> > that the memory for the EDID passed to it was big enough to hold
> > `edid[0x7e] + 1` blocks of data (1 extra for the base block). It
> > completely ignored the fact that the function was passed `num_blocks`
> > which indicated how much memory had been allocated for the EDID.
> >
> > Let's fix this by adding a bounds check.
> >
> > This is important for handling the case where there's an error in the
> > first block of the EDID. In that case we will call
> > connector_bad_edid() without having re-allocated memory based on
> > `edid[0x7e]`.
> >
> > Fixes: e11f5bd8228f ("drm: Add support for DP 1.4 Compliance edid corruption test")
> > Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> > This problem report came up in the context of a patch I sent out [1]
> > and this is my attempt at a fix. The problem predates my patch,
> > though. I don't personally know anything about DP compliance testing
> > and what should be happening here, nor do I apparently have any
> > hardware that actually reports a bad EDID. Thus this is just compile
> > tested. I'm hoping that someone here can test this and make sure it
> > seems OK to them.
> >
> > Changes in v2:
> > - Added a comment/changed math to help make it easier to grok.
> >
> >  drivers/gpu/drm/drm_edid.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> Pushed this to drm-misc-fixes since the commit it fixes is fairly old.
> 
> fdc21c35aaa1 drm/edid: In connector_bad_edid() cap num_of_ext by num_blocks read

BTW seems kasan caught this for us [1]. I didn't notice we had a bug
open about it until now. Just Chris Wilson mentioned it to me in passing
quite a while ago, and I totally forgot about it until I saw your other
patch poking around the same code.

[1] https://gitlab.freedesktop.org/drm/intel/-/issues/4106

-- 
Ville Syrjälä
Intel
