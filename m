Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AB0398FE0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhFBQZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFBQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:25:26 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D458C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 09:23:43 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BF8D5D97;
        Wed,  2 Jun 2021 18:23:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622651021;
        bh=ktVh8oqCTxXbo8Ng4kZbtq18cRRXXX8vW5zxhH3w6x0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INzKlSMZHVUz11YqbR2GYjXngapsiK0xMha72MmBxNDUHAlF/bcWEA5H4lyuICbEx
         8s9it1L/XMBPHen+/93+Hl6moa2ulLe+xxFS25cvQS1VdGwXpMAkpScg+m7dGUBrqP
         e2783QLi3CwEQ4YM09dZhg6p9oNf1HK9U+uYPN18=
Date:   Wed, 2 Jun 2021 19:23:30 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND 18/26] drm/xlnx/zynqmp_dp: Fix incorrectly name function
 'zynqmp_dp_train()'
Message-ID: <YLewgiMzhlR//gzQ@pendragon.ideasonboard.com>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
 <20210602143300.2330146-19-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602143300.2330146-19-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Thank you for the patch.

On Wed, Jun 02, 2021 at 03:32:52PM +0100, Lee Jones wrote:
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
> ---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 82430ca9b9133..a1055d5055eab 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -797,7 +797,7 @@ static int zynqmp_dp_link_train_ce(struct zynqmp_dp *dp)
>  }
>  
>  /**
> - * zynqmp_dp_link_train - Train the link
> + * zynqmp_dp_train - Train the link

The driver has other functions related to link training that start with
the zynqmp_dp_link_train_* prefix. I'd prefer renaming this function to
zynqmp_dp_link_train(). Bonus points if the same patch could rename
zynqmp_dp_train_loop() to zynqmp_dp_link_train_loop() too :-)

>   * @dp: DisplayPort IP core structure
>   *
>   * Return: 0 if all trains are done successfully, or corresponding error code.

-- 
Regards,

Laurent Pinchart
