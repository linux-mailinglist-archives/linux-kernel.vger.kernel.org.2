Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A4234761D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhCXK2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbhCXK2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:28:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1D9C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:27:53 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B2BF9580;
        Wed, 24 Mar 2021 11:27:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616581671;
        bh=jX/rL9SThiDdwKt+QT470qBbeWnwAKKXbWin9BMzKGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q1PPh8/Wn91HuGwqpoEoS0Xjf8J0F7S+fj4EWJbWe6VkHU6FVm8Y1CDsW5P+v/ctx
         E9StN8iohlydMwsnLfwHR6pncDH80LlI0ri+fBcYC3mITxZsVFmKP2WrhsJ5wBvmHo
         LRDd2WWqRsdiy4JIIZt8yvXk/t3692YM3VUZSk90=
Date:   Wed, 24 Mar 2021 12:27:07 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] MAINTAINERS: Update Maintainers of DRM Bridge Drivers
Message-ID: <YFsT++Nxd2qhtHO0@pendragon.ideasonboard.com>
References: <20210324102019.1251744-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210324102019.1251744-1-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Mar 24, 2021 at 11:20:19AM +0100, Robert Foss wrote:
> Add myself as co-maintainer of DRM Bridge Drivers. Repository
> commit access has already been granted.
> 
> https://gitlab.freedesktop.org/freedesktop/freedesktop/-/issues/338
> 
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Jernej Škrabec <jernej.skrabec@siol.net>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and welcome :-)

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b705ba51c54..16ace8f58649 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5902,6 +5902,7 @@ F:	drivers/gpu/drm/atmel-hlcdc/
>  DRM DRIVERS FOR BRIDGE CHIPS
>  M:	Andrzej Hajda <a.hajda@samsung.com>
>  M:	Neil Armstrong <narmstrong@baylibre.com>
> +M:	Robert Foss <robert.foss@linaro.org>
>  R:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
>  R:	Jonas Karlman <jonas@kwiboo.se>
>  R:	Jernej Skrabec <jernej.skrabec@siol.net>

-- 
Regards,

Laurent Pinchart
