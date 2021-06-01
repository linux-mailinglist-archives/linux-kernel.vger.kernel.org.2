Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACFF396F8E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhFAIv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233556AbhFAIvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:51:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E53F61375;
        Tue,  1 Jun 2021 08:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622537392;
        bh=BWq5NprmRBFQsgZo2g232l4nfkJzik5TZeKrg2RP7A4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iGXAAQHTjaMW5jK32eeGWC/RMFFgzjIrcMr7psbh+zR6Q2/OwOLt/jUrgAkIts5eI
         YE9mqsBPPxfXMllInKg/lzlcvQL9pBDGUUKDpK3bANr+hzYeKuYwQsRZ1azVlrjV60
         L9ZRjWo97oGa5w+Gja4vghuhWY7d/iByP3bkn3Ok4Cx/gH+j+MtNRmuAoN/QBTXTcj
         joE5KshjA13w2AZoHznmYqMMMcOIdld5uK/Xt6IbKrb/I130zBtSJw0uDaqj54TMVk
         mvFA3LqaeVz+EXflPqjPNu5e6bQuYjhGykfyPXILyn5ZZKnlaqDmODJtrzmviALaKp
         9mYgKvZ8Yr/vg==
Message-ID: <90338d5fbc55f80a8cd28ead24791f3edc247ba4.camel@kernel.org>
Subject: Re: [PATCH v2 08/12] drm/vc4: hdmi: Set
 VC4_HDMI_MAI_CONFIG_FORMAT_REVERSE
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
        Rob Herring <robh+dt@kernel.org>,
        Dom Cobley <popcornmix@gmail.com>
Date:   Tue, 01 Jun 2021 10:49:44 +0200
In-Reply-To: <20210525132354.297468-9-maxime@cerno.tech>
References: <20210525132354.297468-1-maxime@cerno.tech>
         <20210525132354.297468-9-maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-05-25 at 15:23 +0200, Maxime Ripard wrote:
> From: Dom Cobley <popcornmix@gmail.com>
> 
> Without this bit set, HDMI_MAI_FORMAT doesn't pick up
> the format and samplerate from DVP_CFG_MAI0_FMT and you
> can't get HDMI_HDMI_13_AUDIO_STATUS_1 to indicate HBR mode
> 
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Regards,
Nicolas

