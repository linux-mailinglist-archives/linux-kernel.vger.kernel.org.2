Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698B636231F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245281AbhDPOr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbhDPOr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:47:26 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F0CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:47:01 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C586C510;
        Fri, 16 Apr 2021 16:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618584420;
        bh=cQArhNoWMAlPCxN0Uts+L5Q+YkzYFQeuqeKvTHpGInw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRUDU+fHVYP1SmkEbF043sQt24g1Kbv6AdtfwwYYg6FT280yhEEWx9LB8SC1/SLmo
         faWL3syih+hWi+Xahjiv0Cu0T8dH792SwUkanFbISIouOCbfL0w2ugSYARhGu/feSb
         t/+4L6FpNGjR35Y7ZKlu4Rez6mR6UL4A/PdGyqEk=
Date:   Fri, 16 Apr 2021 17:46:57 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 21/40] drm/xlnx/zynqmp_dp: Fix a little potential doc-rot
Message-ID: <YHmjYRKouy9P/YGb@pendragon.ideasonboard.com>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
 <20210416143725.2769053-22-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210416143725.2769053-22-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Thank you for the patch.

On Fri, Apr 16, 2021 at 03:37:06PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/xlnx/zynqmp_dp.c:806: warning: expecting prototype for zynqmp_dp_link_train(). Prototype was for zynqmp_dp_train() instead
> 
> Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I assume you'll merge the whole series in one go through drm-misc. If
that's not the case, please let me know and I'll take the zynqmp patches
in my tree.

> ---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 59d1fb017da01..5ce96421acf40 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -797,7 +797,7 @@ static int zynqmp_dp_link_train_ce(struct zynqmp_dp *dp)
>  }
>  
>  /**
> - * zynqmp_dp_link_train - Train the link
> + * zynqmp_dp_train - Train the link
>   * @dp: DisplayPort IP core structure
>   *
>   * Return: 0 if all trains are done successfully, or corresponding error code.

-- 
Regards,

Laurent Pinchart
