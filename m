Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5784E3746B8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbhEERXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:23:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:35634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240023AbhEERT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:19:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2679DAF3D;
        Wed,  5 May 2021 17:19:01 +0000 (UTC)
Date:   Wed, 5 May 2021 19:18:58 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: fix LONTIUM_LT8912B dependencies
Message-ID: <20210505171858.GC6564@kitsune.suse.cz>
References: <20210504220207.4004511-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210504220207.4004511-1-adrien.grassein@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 12:02:07AM +0200, Adrien Grassein wrote:
> LONTIUM_LT8912B uses "drm_display_mode_to_videomode" from
> DRM framework that needs VIDEOMODE_HELPERS to be enabled.
> 
> Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 400193e38d29..70bcceaae9bf 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -68,6 +68,7 @@ config DRM_LONTIUM_LT8912B
>  	select DRM_KMS_HELPER
>  	select DRM_MIPI_DSI
>  	select REGMAP_I2C
> +	select VIDEOMODE_HELPERS
>  	help
>  	  Driver for Lontium LT8912B DSI to HDMI bridge
>  	  chip driver.

Indeed, this fixes the problem.

Thanks

Michal
