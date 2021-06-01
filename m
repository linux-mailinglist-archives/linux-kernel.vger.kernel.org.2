Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D61C396F5E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhFAItf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233752AbhFAIt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:49:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 886C661370;
        Tue,  1 Jun 2021 08:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622537267;
        bh=cEZUezywMgX5vR/D3t0QvKikngNRDFHs2Ki3SJ0Xpuk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MBOgPX8ZH57ze1iAkkC/l2BOuVL3FOn20aZDjoZSw1jg9q+l7xb2rZTF6NtRhrI8F
         OMtiubpyveaCTSnBhhLgfCDTeNs4BW9DbwOnvwNm/qzCWXbnRvE6cR2EFj8VNIEttD
         LXimyUmi3rNBsKfJV7lFug9FZuv3n/7mqsdA46ciLhsiZoBy0swgETx4LKicZ4e2+/
         aR+pq+AdK5JgDR9QcPkuWcms3+pfN/5CSTl8/Ch63eTUq2BCHKhgsRaCqVPbLACXCi
         yeTOjXIClj7UB87btlifu4y4bpNOg30tSIwVFt4Iu6GhzLaHHiO6AyQngiTrzTxIII
         UAoHWdQ6LBsOw==
Message-ID: <a2e780be6b81443630aa72eb9c5c919061e309b8.camel@kernel.org>
Subject: Re: [PATCH v2 07/12] drm/vc4: hdmi: Set HDMI_MAI_FMT
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
Date:   Tue, 01 Jun 2021 10:47:40 +0200
In-Reply-To: <20210525132354.297468-8-maxime@cerno.tech>
References: <20210525132354.297468-1-maxime@cerno.tech>
         <20210525132354.297468-8-maxime@cerno.tech>
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
> The hardware uses this for generating the right audio
> data island packets when using formats other than PCM
> 
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Regards,
Nicolas

