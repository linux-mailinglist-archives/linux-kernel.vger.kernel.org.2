Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CC6362319
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245230AbhDPOpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbhDPOpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:45:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE86C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:45:08 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8849B51E;
        Fri, 16 Apr 2021 16:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618584306;
        bh=7gdYMuUtn6uOGMcMMnkrDu5CQiOt/VJ+0qsqd8hKfU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7WE6YKMq9p03CIOMLvar3I/tBOdqoEJ8kBNzQ1oxzf6LqFRDorw4gLWjwaj1npzc
         7Yulu1L8UTSxxd2/IAfQ+CPjbtgOxYV8m7rMTi6f6cEr7vE9YzgTQgGr4W88CUDh40
         FcQ+wq79AJV+JCVDU7+8JQk3MqcZ9tMawF9tk6PY=
Date:   Fri, 16 Apr 2021 17:45:02 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 20/40] drm/xlnx/zynqmp_disp: Fix incorrectly documented
 enum 'zynqmp_disp_id'
Message-ID: <YHmi7psSllqh9WwG@pendragon.ideasonboard.com>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
 <20210416143725.2769053-21-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210416143725.2769053-21-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Thank you for the patch.

On Fri, Apr 16, 2021 at 03:37:05PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/xlnx/zynqmp_disp.c:101: warning: expecting prototype for enum zynqmp_disp_id. Prototype was for enum zynqmp_disp_layer_id instead
> 
> Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index 109d627968ac0..ca1161ec9e16f 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -91,7 +91,7 @@ struct zynqmp_disp_format {
>  };
>  
>  /**
> - * enum zynqmp_disp_id - Layer identifier
> + * enum zynqmp_disp_layer_id - Layer identifier
>   * @ZYNQMP_DISP_LAYER_VID: Video layer
>   * @ZYNQMP_DISP_LAYER_GFX: Graphics layer
>   */

-- 
Regards,

Laurent Pinchart
