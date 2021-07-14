Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15293C8766
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbhGNP3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:29:42 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:55106 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbhGNP3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:29:42 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 349C1CC;
        Wed, 14 Jul 2021 17:26:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1626276409;
        bh=84WzucsuPRknBN24/uKLmvjQvuZlqHt2bUpjOHcYCKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tScMMw2N8vf0e4duiMi+FNqgNpvIioqS2ULraxcT1wdNbG1VqQfjfQ9DREUetkeBg
         FvFhegjMLfv8nTI1JhC/AnhUPVdXpWpnU3sLl/03dUoZMeWq/mml+hSpxNHqJ8zrJ6
         QuK/LiDp2UKwBZDCyckPa0JP3fps01G8Jzj8lpYE=
Date:   Wed, 14 Jul 2021 18:26:48 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH v2] drm/of: free the iterator object on failure
Message-ID: <YO8CODO4TRP+qr9H@pendragon.ideasonboard.com>
References: <20210712155758.48286-1-steven.price@arm.com>
 <20210714143300.20632-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210714143300.20632-1-steven.price@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Thank you for the patch.

On Wed, Jul 14, 2021 at 03:33:00PM +0100, Steven Price wrote:
> When bailing out due to the sanity check the iterator value needs to be
> freed because the early return prevents for_each_child_of_node() from
> doing the dereference itself.
> 
> Fixes: 6529007522de ("drm: of: Add drm_of_lvds_get_dual_link_pixel_order")
> Signed-off-by: Steven Price <steven.price@arm.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/drm_of.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> v2: Fixes now refers to the original commit as suggested by Laurent, rather
> than 4ee48cc5586b ("drm: of: Fix double-free bug") which only fixed part of
> the problem. Note that 4ee48cc5586b is a dependency for this patch to
> cleanly apply.
> 
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index 197c57477344..997b8827fed2 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -331,8 +331,10 @@ static int drm_of_lvds_get_remote_pixels_type(
>  		 * configurations by passing the endpoints explicitly to
>  		 * drm_of_lvds_get_dual_link_pixel_order().
>  		 */
> -		if (!current_pt || pixels_type != current_pt)
> +		if (!current_pt || pixels_type != current_pt) {
> +			of_node_put(endpoint);
>  			return -EINVAL;
> +		}
>  	}
>  
>  	return pixels_type;

-- 
Regards,

Laurent Pinchart
