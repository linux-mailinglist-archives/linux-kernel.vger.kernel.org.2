Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCA7398FD1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFBQWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFBQWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:22:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF96C061756
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 09:20:49 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A88CD97;
        Wed,  2 Jun 2021 18:20:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622650846;
        bh=cxdEdqSOuqJ2Db1fe9dCOUd2kzYtl1woUTU5rFP9sjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olDbqIyBZ25R4ClHJp1wh/tS9eaEtU/2Z4fk787abAcCejjh7O/MYz38Q/4RxBhTD
         huAXEXqpYKbDEjUP7CQMS9G5dC87Efd6XHIMsdItM+2+bNXs7SqwdSMqdQ0plS4DYj
         UA8R+cAkBbESq0M3Gb6zOOiJivLuC8jLmZaHe3Vg=
Date:   Wed, 2 Jun 2021 19:20:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND 17/26] drm/xlnx/zynqmp_disp: Fix incorrectly named enum
 'zynqmp_disp_layer_id'
Message-ID: <YLev02lSORBOlqw+@pendragon.ideasonboard.com>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
 <20210602143300.2330146-18-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602143300.2330146-18-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Thank you for the patch.

On Wed, Jun 02, 2021 at 03:32:51PM +0100, Lee Jones wrote:
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
