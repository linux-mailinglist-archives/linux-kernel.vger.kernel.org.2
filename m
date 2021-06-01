Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB4397056
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhFAJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233641AbhFAJ2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:28:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54B5361396;
        Tue,  1 Jun 2021 09:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622539591;
        bh=kKX1yVjitfZZxbdBgzCtdoPBBfSIvUVJzJ5sKjo78qc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l2A4q7WzOFkiELQ2A3xBy1Foc+wwXt1VLZQ0QkOSa0833GZHZ8vygacZdReblL7ht
         Ocbj4K3OfK8Yu0fIAqvoNyL7l5WSCgOLuBuGjWqEGuJuQE5mXKC++b4CutSSwPxxCG
         2wKzxMkn6OyrNpXyWDrt4ccGiQDQadCLy7JkLFzxhVe1ylYZJB7cbdSwXCxg3fRtoe
         3PhMttL9Lb4EV1TN5w/uHdqz3x5tdHQmP+OQr6bAGmSCw3a08C3uPIgniTeT2swQOl
         GkV6bwR0m+BRdxBOox3bKPuL2ajaomZIqgZcebdZLsjvve14r5ur8ld4FxXnupWFIH
         F5QH/3XlvmZLw==
Message-ID: <c1ee306fbc81da2df7d0041c719fc8cd3302cf0f.camel@kernel.org>
Subject: Re: [PATCH v2 10/12] drm/vc4: hdmi: Register HDMI codec
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
Date:   Tue, 01 Jun 2021 11:26:24 +0200
In-Reply-To: <20210525132354.297468-11-maxime@cerno.tech>
References: <20210525132354.297468-1-maxime@cerno.tech>
         <20210525132354.297468-11-maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-05-25 at 15:23 +0200, Maxime Ripard wrote:
> The hdmi-codec brings a lot of advanced features, including the HDMI
> channel mapping. Let's use it in our driver instead of our own codec.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Regards,
Nicolas


