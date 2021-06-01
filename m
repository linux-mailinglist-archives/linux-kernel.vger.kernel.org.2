Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC139706A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhFAJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233408AbhFAJcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:32:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6798C60233;
        Tue,  1 Jun 2021 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622539858;
        bh=MzlARME4PT7gZfBfOUguUEgshh64veA8ys2s2SbHRfM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AGqWFUsJLkcVJZ4LIwG+zPi8RAXRzCZp6K3epM0/Vl7+RdYvCfNrdUu0tXtpBv1HU
         aEjLQMpLDljY3rnnuyLcEqTJpteSYW0J228pFQqE2Wer5K8NVY13c+E4qejYPmn0wZ
         ErR45tsnWiSJH+ZaBDbmgklFcvUBZK5XT3vZYtz0pa/Uq4L++Rf3byso6RBYtg8DhN
         dq17CLatmOoBmLgpSTpr+h3Ghi/6QulAf5+Mu1xrIDvH21ZEQHj8JrnpwJgtLYNEej
         b5Aegteov9mIPeQq0ZD/1m+4anggbpDae5h9ASMFMZk2ux4vG7fjWOIJHMiYtEtFd0
         Xo6Aydw1MUvOw==
Message-ID: <fac8428765f0ad2fdd49407b9d1187336e8cb618.camel@kernel.org>
Subject: Re: [PATCH v2 11/12] drm/vc4: hdmi: Remove redundant variables
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     devicetree@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-doc@vger.kernel.org,
        Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Maxime Ripard <mripard@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-rpi-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 01 Jun 2021 11:30:50 +0200
In-Reply-To: <20210525132354.297468-12-maxime@cerno.tech>
References: <20210525132354.297468-1-maxime@cerno.tech>
         <20210525132354.297468-12-maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-05-25 at 15:23 +0200, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Adding a commit message would've been nice. But I guess the patch is trivial
enough.

Other than that:

Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Regards,
Nicolas

