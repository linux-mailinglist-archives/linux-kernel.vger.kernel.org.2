Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD233FE7EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 05:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhIBDOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 23:14:18 -0400
Received: from rosenzweig.io ([138.197.143.207]:45444 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233143AbhIBDON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 23:14:13 -0400
Date:   Wed, 1 Sep 2021 21:35:40 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm: Add drm_fixed_16_16 helper
Message-ID: <YTAqbAhoYPe6Stjn@sunset>
References: <20210901175431.14060-1-alyssa@rosenzweig.io>
 <YS/CsCSqKeFYF9x7@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS/CsCSqKeFYF9x7@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Missing documentation :-)

Ack.

> > +static inline int drm_fixed_16_16(s32 mult, s32 div)
> 
> You should return a s32.

Ack.

> The function name isn't very explicit, and departs from the naming
> scheme of other functions in the same file. As fixed-point numbers are
> stored in a s64 for the drm_fixp_* helpers, we shouldn't rese the
> drm_fixp_ prefix, maybe drm_fixp_s16_16_ would be a good prefix. The
> function should probably be named drm_fixp_s16_16 from_fraction() then,
> but then the same logic should possibly be replicated to ensure optimal
> precision. I wonder if it wouldn't be best to simply use
> drm_fixp_from_fraction() and shift the result right by 16 bits.

Sure, I'm not attached to the naming ... will wait to hear what colours
everyone else wants the bikehed painted.

As for the implementation, I just went with what was used across
multiple drivers already (no chance of regressions that way) but could
reuse other helpers if it's better..? If the behaviour changes this goes
from a trivial cleanup to a much more invasive changeset. I don't own
half of the hardware here.
