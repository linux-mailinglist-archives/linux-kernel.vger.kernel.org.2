Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEE83C65C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 23:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhGLV7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 17:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhGLV7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 17:59:12 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B67C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 14:56:23 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BA1B2CC;
        Mon, 12 Jul 2021 23:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1626126979;
        bh=+d8YmarxqieQLIrWWfUj888qjlOdg83gqF6/rmhuzng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sKGPXvlp5fN9Nh+8sOS1EV8yWEPE9bwH7owAA3bsoKZncpHSvV6TpGpoRfDXh6ksL
         /cTysgd1UwzTaxWwxzAKusz0Eronc0bTFgtv0oh7wqRuGf7x1JKJG4mA44B3/9p0ob
         l8Yl59ETdw/3+eejNTN39IkglMgK2w742R2Tyv1Q=
Date:   Tue, 13 Jul 2021 00:55:33 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] drm/of: free the iterator object on failure
Message-ID: <YOy6VQNz8Htg6Usb@pendragon.ideasonboard.com>
References: <20210712155758.48286-1-steven.price@arm.com>
 <YOxyvIoJcZFAgUz5@pendragon.ideasonboard.com>
 <b420a4e6-8038-6c1e-7c97-75ef3bea3c21@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b420a4e6-8038-6c1e-7c97-75ef3bea3c21@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Mon, Jul 12, 2021 at 10:31:52PM +0100, Steven Price wrote:
> On 12/07/2021 17:50, Laurent Pinchart wrote:
> > On Mon, Jul 12, 2021 at 04:57:58PM +0100, Steven Price wrote:
> >> When bailing out due to the sanity check the iterator value needs to be
> >> freed because the early return prevents for_each_child_of_node() from
> >> doing the dereference itself.
> >>
> >> Fixes: 4ee48cc5586b ("drm: of: Fix double-free bug")
> > 
> > I don't think the Fixes tag is correct, the issue was already present
> > before 4ee48cc5586b. The fix looks right though.
> 
> I'm not sure quite what you mean by "already present". As I understand
> it the timeline was:
> 
> 1. 6529007522de drm: of: Add drm_of_lvds_get_dual_link_pixel_order
>    The function was originally added. This made the mistake twice of
>    calling of_node_put() on the wrong variable (remote_port rather than
>    endpoint).

Correct.

> 2. 4ee48cc5586b drm: of: Fix double-free bug
>    One of the of_node_put() calls was removed as it was a double-free.
>    This left the first incorrect of_node_put() in place, and the second
>    is now a straight leak.

That's right, but this commit didn't introduce the leak, it was already
there in 6529007522de (in addition to the double-free).

> 3. b557a5f8da57 drm/of: free the right object
>    This (correctly) fixes the first of_node_put() to free endpoint. And
>    the post from Daniel was what caused me to look.
> 
> 4. This patch
>    Reintroduces the of_node_put() removed in (2) but putting endpoint
>    rather than remote_port.
> 
> I've put (2) in the Fixes line as this patch is fixing the leak
> introduced by that patch, but that in itself was of course 'fixing' the
> double free of the original patch.
> 
> >> Signed-off-by: Steven Price <steven.price@arm.com>
> >> ---
> >>  drivers/gpu/drm/drm_of.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> Daniel's email[1] made me take a look at this function and it appears
> >> that for_each_child_of_node()'s interface had caused a bad bug fix due
> >> to the hidden reference counting in the iterator.
> >>
> >> [1] https://lore.kernel.org/r/YOxQ5TbkNrqCGBDJ%40phenom.ffwll.local
> >>
> >> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> >> index 197c57477344..997b8827fed2 100644
> >> --- a/drivers/gpu/drm/drm_of.c
> >> +++ b/drivers/gpu/drm/drm_of.c
> >> @@ -331,8 +331,10 @@ static int drm_of_lvds_get_remote_pixels_type(
> >>  		 * configurations by passing the endpoints explicitly to
> >>  		 * drm_of_lvds_get_dual_link_pixel_order().
> >>  		 */
> >> -		if (!current_pt || pixels_type != current_pt)
> >> +		if (!current_pt || pixels_type != current_pt) {
> >> +			of_node_put(endpoint);
> >>  			return -EINVAL;
> >> +		}
> >>  	}
> >>  
> >>  	return pixels_type;

-- 
Regards,

Laurent Pinchart
